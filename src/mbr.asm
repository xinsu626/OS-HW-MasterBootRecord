


[BITS 16]
boot: ; This file starts executing here.
main:
    mov ah,0x0e 
    mov bx,STRING 	;put the string address into bx
    call putStr 	;print the string 
    call readSector
    jmp 0x7E00
STRING:
    db "welcome",0dh,0ah,0
putStr:
    mov al,[bx] 	;the value of the string
    cmp al,0 		;compare cl with 0
    jne bx_add 		;if cl is not zero and jmp to bx_add
    ret
bx_add:
    int 0x10 		;execute the interupt to print
    add bx,1 		;increase bx by 1 and point to next letter
    jmp putStr
readSector:
    mov bx,0x7E00 	;where do we want to put these sectors
    mov ah,0x02 	;settings for reading sectors
    mov al,50 		;number of sectors
    mov ch,0x00 	;cyliner number
    mov dh,0x00 	;head number
    mov cl,0x02 	;sector number, where to start
    int 0x13 		;use the interupt
    ret
    hlt

times 510-($-$$) db 0 ; Skip to end of boot sector

db 0x55 ; Magic Numbers
db 0xaa ; To make disk bootable



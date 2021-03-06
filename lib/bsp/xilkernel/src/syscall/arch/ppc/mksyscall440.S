/******************************************************************************
*
* Copyright (C) 2010 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/
/*----------------------------------------------------------------------------------------//
//! @file
//! mksyscall.S - System call stub
-----------------------------------------------------------------------------------------//*/

#include <os_config.h>
#include <sys/arch.h>


/*  make_syscall (param1, param2, param3, param4, param5, syscall_num);
 *		   r3,     r4,     r5,     r6,     r7,     r8
 *
 *  System call handler located at system call exception
 */

	.global make_syscall
	.section .text
	.align 2
        .type make_syscall@function
make_syscall:
        stwu    1, -8(1);                       /* Make space on the stack and save backchain */
        mflr    0;
        stw     0, 12(1);                       /* Save link register */
        mfivpr  11;                             /* Get the exception vector base */
        mfivor8 12;
        add     0, 11, 12;
        mtlr    0;
        blrl;
        lwz     0, 12(1);
        mtlr    0;
	addi	1, 1, 8;
        blr;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5798E4A2B44
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 03:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352193AbiA2CZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 21:25:51 -0500
Received: from m228-4.mailgun.net ([159.135.228.4]:51111 "EHLO
        m228-4.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbiA2CZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 21:25:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=michaelkloos.com; q=dns/txt;
 s=k1; t=1643423149; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=vzl2zEWdMUQVvDPixuCkhMPePb8rN9TYNu5woqHzlhY=; b=q3QiBuBdonX34/fpXPNrQRRlsrFY6arnUw9Jxyf5gSVxmq02f1Hf4F7eUwDsoTEIdz4BuJqR
 hAI6ePIZB2z6oyabDm0U7v25lBdX3LPKx2lagFPPPm2iTQFxYkiGtoq8TSdkDYBDlGGWB1hh
 SE4ro7zJIiSOSgnI7n47BmFHVso=
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI5NjYzNiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjQ4Y2MwIl0=
Received: from drop1.michaelkloos.com (drop1.michaelkloos.com
 [67.205.190.89]) by smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61f4a5ace42a102d96680644 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Sat, 29 Jan 2022 02:25:48 GMT
Sender: michael@michaelkloos.com
Received: from qpc.home.michaelkloos.com (cpe-173-88-115-50.columbus.res.rr.com [173.88.115.50])
        by drop1.michaelkloos.com (Postfix) with ESMTPSA id 3764840266;
        Sat, 29 Jan 2022 02:25:15 +0000 (UTC)
From:   "Michael T. Kloos" <michael@michaelkloos.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Michael T. Kloos" <michael@michaelkloos.com>
Subject: [PATCH v4] riscv: Fixed misaligned memory access.  Fixed pointer comparison.
Date:   Fri, 28 Jan 2022 21:24:48 -0500
Message-Id: <20220129022448.37483-1-michael@michaelkloos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrote the RISC-V memmove() assembly implementation.  The
previous implementation did not check memory alignment and it
compared 2 pointers with a signed comparison.  The misaligned
memory access would cause the kernel to crash on systems that
did not emulate it in firmware and did not support it in hardware.
Firmware emulation is slow and may not exist.  The RISC-V spec
does not guarantee that support for misaligned memory accesses
will exist.  It should not be depended on.

This patch now checks for XLEN granularity of co-alignment between
the pointers.  Failing that, copying is done by loading from the 2
contiguous and naturally aligned XLEN memory locations containing
the overlapping XLEN sized data to be copied.  Only one load from
memory is needed per loop iteration as the value loaded is passed
by cpu register into the next iteration to minimize the memory
accesses required.  The data is shifted into the correct place and
binary or'ed together on each iteration.  The result is then
stored into the corresponding naturally aligned XLEN sized
location in the destination.  For unaligned data at the
terminations of the regions to be copied or for copies less than
XLEN in size, byte copy is used.

This patch also now uses unsigned comparison for the pointers and
migrates to the newer assembler annotations from the now deprecated
ones.

[v3]

Fixed the build issue reported by the test robot.  Changed the
copy implementation based on the suggestion by David Laight.

One change that could potentially still be made is to roll one
of the values loaded in the copy loop into the next iteration
of the fixup loop, rather than reloading both values from memory
on each iteration.  It would require some more logic and I'm
really not sure that it is worth it.  It could be added in a
later patch.  For now, this fixes the issues I set out to fix.

[v4]

I could not resist implementing the optimization I mentioned in
my v3 notes.  I have implemented the roll over of data by cpu
register in the misaligned fixup copy loops.  Now, only one load
from memory is required per iteration of the loop.

Signed-off-by: Michael T. Kloos <michael@michaelkloos.com>
---
 arch/riscv/lib/memmove.S | 327 ++++++++++++++++++++++++++++++++-------
 1 file changed, 267 insertions(+), 60 deletions(-)

diff --git a/arch/riscv/lib/memmove.S b/arch/riscv/lib/memmove.S
index 07d1d2152ba5..13f17affe115 100644
--- a/arch/riscv/lib/memmove.S
+++ b/arch/riscv/lib/memmove.S
@@ -1,64 +1,271 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022 Michael T. Kloos <michael@michaelkloos.com>
+ */
 
 #include <linux/linkage.h>
 #include <asm/asm.h>
 
-ENTRY(__memmove)
-WEAK(memmove)
-        move    t0, a0
-        move    t1, a1
-
-        beq     a0, a1, exit_memcpy
-        beqz    a2, exit_memcpy
-        srli    t2, a2, 0x2
-
-        slt     t3, a0, a1
-        beqz    t3, do_reverse
-
-        andi    a2, a2, 0x3
-        li      t4, 1
-        beqz    t2, byte_copy
-
-word_copy:
-        lw      t3, 0(a1)
-        addi    t2, t2, -1
-        addi    a1, a1, 4
-        sw      t3, 0(a0)
-        addi    a0, a0, 4
-        bnez    t2, word_copy
-        beqz    a2, exit_memcpy
-        j       byte_copy
-
-do_reverse:
-        add     a0, a0, a2
-        add     a1, a1, a2
-        andi    a2, a2, 0x3
-        li      t4, -1
-        beqz    t2, reverse_byte_copy
-
-reverse_word_copy:
-        addi    a1, a1, -4
-        addi    t2, t2, -1
-        lw      t3, 0(a1)
-        addi    a0, a0, -4
-        sw      t3, 0(a0)
-        bnez    t2, reverse_word_copy
-        beqz    a2, exit_memcpy
-
-reverse_byte_copy:
-        addi    a0, a0, -1
-        addi    a1, a1, -1
-
-byte_copy:
-        lb      t3, 0(a1)
-        addi    a2, a2, -1
-        sb      t3, 0(a0)
-        add     a1, a1, t4
-        add     a0, a0, t4
-        bnez    a2, byte_copy
-
-exit_memcpy:
-        move a0, t0
-        move a1, t1
-        ret
-END(__memmove)
+SYM_FUNC_START(__memmove)
+SYM_FUNC_START_WEAK(memmove)
+	/*
+	 * Returns
+	 *   a0 - dest
+	 *
+	 * Parameters
+	 *   a0 - Inclusive first byte of dest
+	 *   a1 - Inclusive first byte of src
+	 *   a2 - Length of copy n
+	 *
+	 * Because the return matches the parameter register a0,
+	 * we will not clobber or modify that register.
+	 *
+	 * Note: This currently only works on little-endian.
+	 * To port to big-endian, reverse the direction of shifts
+	 * in the 2 misaligned fixup copy loops.
+	 */
+
+	/* Return if nothing to do */
+	beq a0, a1, 20f /* Return from memmove */
+	beqz a2, 20f /* Return from memmove */
+
+	/*
+	 * Register Uses
+	 *      Forward Copy: a3 - Index counter of src
+	 *      Reverse Copy: a4 - Index counter of src
+	 *      Forward Copy: t3 - Index counter of dest
+	 *      Reverse Copy: t4 - Index counter of dest
+	 *   Both Copy Modes: t5 - Inclusive first multibyte/aligned of dest
+	 *   Both Copy Modes: t6 - Non-Inclusive last multibyte/aligned of dest
+	 *   Both Copy Modes: t0 - Link / Temporary for load-store
+	 *   Both Copy Modes: t1 - Temporary for load-store
+	 *   Both Copy Modes: t2 - Temporary for load-store
+	 *   Both Copy Modes: a5 - dest to src alignment offset
+	 *   Both Copy Modes: a6 - Shift ammount
+	 *   Both Copy Modes: a7 - Inverse Shift ammount
+	 */
+
+	/*
+	 * Solve for some register values now.
+	 * Byte copy does not need t5 or t6.
+	 */
+	add  t3, a0, zero
+	add  t4, a0, a2
+	add  a3, a1, zero
+	add  a4, a1, a2
+
+	/*
+	 * Byte copy if copying less than SZREG bytes.
+	 * This can cause problems with the bulk copy
+	 * implementation and is small enough not
+	 * to bother.
+	 */
+	andi t0, a2, -SZREG
+	beqz t0, 21f
+
+	/*
+	 * Now solve for t5 and t6.
+	 */
+	andi t5, t3, -SZREG
+	andi t6, t4, -SZREG
+	/*
+	 * If dest(Register t3) rounded down to the nearest naturally
+	 * aligned SZREG address, does not equal dest, then add SZREG
+	 * to find the low-bound of SZREG alignment in the dest memory
+	 * region.  Note that this could overshoot the dest memory
+	 * region if n is less than SZREG.  This is one reason why
+	 * we always byte copy if n is less than SZREG.
+	 * Otherwise, dest is already naturally aligned to SZREG.
+	 */
+	beq  t5, t3, 1f
+		addi t5, t5, SZREG
+	1:
+
+	/*
+	 * If the dest and src are co-aligned to SZREG, then there is
+	 * no need for the full rigmarole of a full misaligned fixup copy.
+	 * Instead, do a simpler co-aligned copy.
+	 */
+	xor  t0, a0, a1
+	andi t1, t0, (SZREG - 1)
+	beqz t1, 26f
+	/* Fall through to misaligned fixup copy */
+
+1: /* Misaligned fixup copy */
+	bltu a1, a0, 4f /* Misaligned fixup copy: Reverse */
+
+3: /* Misaligned fixup copy: Forward */
+	jal  t0, 24f /* Byte copy until aligned: Forward */
+
+	andi a5, a3, (SZREG - 1) /* Find the alignment offset of src (a3) */
+	slli a6, a5, 3 /* Multiply by 8 to convert that to bits to shift */
+
+	sub  a3, a3, a5 /* Align the src pointer */
+
+	/*
+	 * Compute The Inverse Shift
+	 * a7 = XLEN - a6 = XLEN + -a6
+	 * 2s complement negation to find the negative: -a6 = ~a6 + 1
+	 * Add that to XLEN.  XLEN = SZREG * 8.
+	 */
+	not  a7, a6
+	addi a7, a7, (SZREG * 8 + 1)
+
+	/*
+	 * Fix Misalignment Copy Loop.
+	 * load_val1 = load_ptr[0];
+	 * while (store_ptr != store_ptr_end) {
+	 *   load_val0 = load_val1;
+	 *   load_val1 = load_ptr[1];
+	 *   *store_ptr = (load_val0 >> {a6}) | (load_val1 << {a7});
+	 *   load_ptr++;
+	 *   store_ptr++;
+	 * }
+	 */
+	REG_L t0, 0x000(a3)
+	1:
+	beq   t3, t6, 2f
+	mv    t1, t0
+	REG_L t0, SZREG(a3)
+	srl   t1, t1, a6
+	sll   t2, t0, a7
+	or    t1, t1, t2
+	REG_S t1, 0x000(t3)
+	addi  a3, a3, SZREG
+	addi  t3, t3, SZREG
+	j 1b
+	2:
+
+	add  a3, a3, a5 /* Restore the src pointer */
+	j 22f /* Byte copy: Forward */ /* Copy any remaining bytes */
+
+4: /* Misaligned fixup copy: Reverse */
+	jal  t0, 25f /* Byte copy until aligned: Reverse */
+
+	andi a5, a4, (SZREG - 1) /* Find the alignment offset of src (a4) */
+	slli a6, a5, 3 /* Multiply by 8 to convert that to bits to shift */
+
+	sub  a4, a4, a5 /* Align the src pointer */
+
+	/*
+	 * Compute The Inverse Shift
+	 * a7 = XLEN - a6 = XLEN + -a6
+	 * 2s complement negation to find the negative: -a6 = ~a6 + 1
+	 * Add that to XLEN.  XLEN = SZREG * 8.
+	 */
+	not  a7, a6
+	addi a7, a7, (SZREG * 8 + 1)
+
+	/*
+	 * Fix Misalignment Copy Loop.
+	 * load_val0 = load_ptr[0];
+	 * while (store_ptr != store_ptr_end) {
+	 *   load_ptr--;
+	 *   store_ptr--;
+	 *   load_val1 = load_val0;
+	 *   load_val0 = load_ptr[0];
+	 *   *store_ptr = (load_val0 >> {a6}) | (load_val1 << {a7});
+	 * }
+	 */
+	REG_L t0, 0x000(a4)
+	1:
+	beq   t4, t5, 2f
+	addi  a4, a4, -SZREG
+	addi  t4, t4, -SZREG
+	mv    t2, t0
+	REG_L t0, 0x000(a4)
+	srl   t1, t0, a6
+	sll   t2, t2, a7
+	or    t1, t1, t2
+	REG_S t1, 0x000(t4)
+	j 1b
+	2:
+
+	add  a4, a4, a5 /* Restore the src pointer */
+	j 23f /* Byte copy: Reverse */ /* Copy any remaining bytes */
+
+/*
+ * Simple copy loops for SZREG co-aligned memory locations.
+ * These also make calls to do byte copies for any unaligned
+ * data at their terminations.
+ */
+26: /* Co-Aligned copy */
+	bltu a1, a0, 3f /* Co-Aligned copy: Reverse */
+
+2: /* Co-Aligned copy: Forward */
+	jal t0, 24f /* Byte copy until aligned: Forward */
+
+	1:
+	beq   t3, t6, 22f /* Byte copy: Forward */
+	REG_L t1, (a3)
+	REG_S t1, (t3)
+	addi  a3, a3, SZREG
+	addi  t3, t3, SZREG
+	j 1b
+
+3: /* Co-Aligned copy: Reverse */
+	jal t0, 25f /* Byte copy until aligned: Reverse */
+
+	1:
+	beq   t4, t5, 23f /* Byte copy: Reverse */
+	addi  a4, a4, -SZREG
+	addi  t4, t4, -SZREG
+	REG_L t1, (a4)
+	REG_S t1, (t4)
+	j 1b
+
+/*
+ * These are basically sub-functions within the function.  They
+ * are used to byte copy until the dest pointer is in alignment.
+ * At which point, a bulk copy method can be used by the
+ * calling code.  These work on the same registers as the bulk
+ * copy loops.  Therefore, the register values can be picked
+ * up from where they were left and we avoid code duplication
+ * without any overhead except the call in and return jumps.
+ */
+24: /* Byte copy until aligned: Forward */
+	beq  t3, t5, 1f /* Reuse the return from the other copy loop */
+	lb   t1, (a3)
+	sb   t1, (t3)
+	addi a3, a3, 1
+	addi t3, t3, 1
+	j 24b
+
+25: /* Byte copy until aligned: Reverse */
+	beq  t4, t6, 1f
+	addi a4, a4, -1
+	addi t4, t4, -1
+	lb   t1, (a4)
+	sb   t1, (t4)
+	j 25b
+	1: jalr zero, 0x0(t0) /* Return to multibyte copy loop */
+
+/*
+ * Simple byte copy loops.
+ * These will byte copy until they reach the end of data to copy.
+ * At that point, they will call to return from memmove.
+ */
+21: /* Byte copy */
+	bltu a1, a0, 23f /* Byte copy: Reverse */
+
+22: /* Byte copy: Forward */
+	beq  t3, t4, 20f /* Return from memmove */
+	lb   t1, (a3)
+	sb   t1, (t3)
+	addi a3, a3, 1
+	addi t3, t3, 1
+	j 22b
+
+23: /* Byte copy: Reverse */
+	beq  t4, t3, 20f /* Return from memmove */
+	addi a4, a4, -1
+	addi t4, t4, -1
+	lb   t1, (a4)
+	sb   t1, (t4)
+	j 23b
+
+20: /* Return from memmove */
+	ret
+
+SYM_FUNC_END(memmove)
+SYM_FUNC_END(__memmove)
-- 
2.34.1


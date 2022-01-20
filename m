Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CF0495712
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378204AbiATXlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:41:04 -0500
Received: from m228-6.mailgun.net ([159.135.228.6]:60791 "EHLO
        m228-6.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244889AbiATXk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:40:58 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jan 2022 18:40:58 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=michaelkloos.com; q=dns/txt;
 s=k1; t=1642722056; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=Cy6tIjM9sRgDUTNoIKHXr4iFY4oMmMOX9cOVZGirez8=; b=NBzaOOxNPuaPmfYXY+dMOXzCHj3ljDMudsYvXieXdCopgEEpdKZAFk6CymQgDCnk4sA/QkYh
 58bO31hE5UlAepPS0O3U/ZWQAVeh+pmcLm4mBDsR/n9QsKOVhPbXTzl91J5PLQ7eK11JnXzv
 5xl137gMJm4A4b/7ZgLNt0ppKJk=
X-Mailgun-Sending-Ip: 159.135.228.6
X-Mailgun-Sid: WyI5NjYzNiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjQ4Y2MwIl0=
Received: from drop1.michaelkloos.com (drop1.michaelkloos.com
 [67.205.190.89]) by smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61e9f1d6e0071250cf66942b (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 20 Jan 2022 23:35:50 GMT
Sender: michael@michaelkloos.com
Received: from qpc.home.michaelkloos.com (cpe-173-88-115-50.columbus.res.rr.com [173.88.115.50])
        by drop1.michaelkloos.com (Postfix) with ESMTPSA id 636FB40267;
        Thu, 20 Jan 2022 23:35:49 +0000 (UTC)
From:   "Michael T. Kloos" <michael@michaelkloos.com>
To:     paul.walmsley@sifive.com
Cc:     palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Michael T. Kloos" <michael@michaelkloos.com>
Subject: [PATCH] Fixed: Misaligned memory access.  Fixed pointer comparison.
Date:   Thu, 20 Jan 2022 18:34:27 -0500
Message-Id: <20220120233427.262098-1-michael@michaelkloos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrote the riscv memmove() assembly implementation.  The
previous implementation did not check memory alignment and it
compared 2 pointers with a signed comparison.  The misaligned
memory access would cause the kernel to crash on systems that
did not emulate it firmware and did support it in hardware.
Firmware emulation is slow may not exist.  Additionally, hardware
support may not exist and would likely still run slower than
aligned	accesses even if it did.  The RISC-V spec does not
guarantee that support for misaligned memory accesses will exist.
It should not be depended on.

This patch now checks for the maximum granularity of co-alignment
between the pointers and copies them with that, using single-byte
copy for any unaligned data at their terminations.  It also now uses
unsigned comparison for the pointers.

Added half-word and, if built for 64-bit, double-word copy.

Migrated to the	newer assembler annotations from the now deprecated
ones.

Signed-off-by: Michael T. Kloos <michael@michaelkloos.com>
---
 arch/riscv/lib/memmove.S | 264 +++++++++++++++++++++++++++++++--------
 1 file changed, 210 insertions(+), 54 deletions(-)

diff --git a/arch/riscv/lib/memmove.S b/arch/riscv/lib/memmove.S
index 07d1d2152ba5..df7cd7a559ae 100644
--- a/arch/riscv/lib/memmove.S
+++ b/arch/riscv/lib/memmove.S
@@ -1,64 +1,220 @@
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
+SYM_FUNC_START(__memmove)
+SYM_FUNC_START_ALIAS(memmove)
+	/*
+	 * Returns
+	 *   a0 - dest
+	 *
+	 * Parameters
+	 *   a0 - Inclusive first byte of dest
+	 *   a1 - Inclusive first byte of src
+	 *   a2 - Length of copy
+	 *
+	 * Because the return matches the parameter register a0,
+	 * we will not clobber or modify that register.
+	 */
 
-        beq     a0, a1, exit_memcpy
-        beqz    a2, exit_memcpy
-        srli    t2, a2, 0x2
+	/* Return if nothing to do */
+	beq a0, a1, exit_memmove
+	beqz a2, exit_memmove
 
-        slt     t3, a0, a1
-        beqz    t3, do_reverse
+	/*
+	 * Register Uses
+	 *   a3 - Inclusive first multibyte of src
+	 *   a4 - Non-inclusive last multibyte of src
+	 *   a5 - Non-inclusive last byte of src
+	 *
+	 * During the copy
+	 *      Forward Copy: a1 - Index counter of src
+	 *      Reverse Copy: a5 - Index counter of src
+	 *   Both Copy Modes: t2 - Index counter of dest
+	 *   Both Copy Modes: t1 - Temporary for load-store
+	 *   Both Copy Modes: t0 - Link
+	 */
 
-        andi    a2, a2, 0x3
-        li      t4, 1
-        beqz    t2, byte_copy
+	/*
+	 * Solve for last byte now.  We will solve the rest when
+	 * they are needed for the copy because either byte copy
+	 * does not require any of the others (Wasted effort if
+	 * byte copy gets used) or we do not yet have enough
+	 * information to solve them.
+	 */
+	add  a5, a1, a2
 
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
+	/*
+	 * Byte copy if copying less than SZREG bytes.
+	 * This can cause problems with the bulk copy
+	 * implementation below and is small enough not
+	 * to bother.
+	 */
+	andi t0, a2, -SZREG
+	beqz t0, byte_copy
+
+	/* Determine the maximum granularity of co-alignment. */
+	xor  t0, a0, a1
+#if   SZREG >= 8
+	andi t1, t0, 0x7
+	beqz t1, doubleword_copy
+#endif
+	andi t1, t0, 0x3
+	beqz t1, word_copy
+	andi t1, t0, 0x1
+	beqz t1, halfword_copy
+	/* Fall through to byte copy if nothing larger is found. */
 
 byte_copy:
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
+	bltu a1, a0, byte_copy_reverse
+
+byte_copy_forward:
+	add  t2, a0, zero
+byte_copy_fw_callin:
+	beq  a1, a5, exit_memmove
+	lb   t1, (a1)
+	sb   t1, (t2)
+	addi a1, a1, 1
+	addi t2, t2, 1
+	j byte_copy_fw_callin
+
+byte_copy_reverse:
+	add  t2, a0, a2
+byte_copy_rv_callin:
+	beq  a1, a5, exit_memmove
+	addi a5, a5, -1
+	addi t2, t2, -1
+	lb   t1, (a5)
+	sb   t1, (t2)
+	j byte_copy_rv_callin
+
+exit_memmove:
+	ret
+
+copy_bytes_until_aligned_fw:
+	beq  a1, a3, 1f /* Reuse the return from the other copy loop */
+	lb   t1, (a1)
+	sb   t1, (t2)
+	addi a1, a1, 1
+	addi t2, t2, 1
+	j copy_bytes_until_aligned_fw
+
+copy_bytes_until_aligned_rv:
+	beq  a4, a5, 1f
+	addi a5, a5, -1
+	addi t2, t2, -1
+	lb   t1, (a5)
+	sb   t1, (t2)
+	j copy_bytes_until_aligned_rv
+	1: jalr zero, (t0) /* Return */
+
+#if   SZREG >= 8
+doubleword_copy:
+	andi a3, a1, -8
+	andi a4, a5, -8
+	beq  a3, a1, 1f
+	addi a3, a3, 8
+	1:
+	bltu a1, a0, doubleword_copy_reverse
+
+doubleword_copy_forward:
+	add  t2, a0, zero
+
+	jal t0, copy_bytes_until_aligned_fw
+
+	1:
+	beq  a1, a4, byte_copy_fw_callin
+	ld   t1, (a1)
+	sd   t1, (t2)
+	addi a1, a1, 8
+	addi t2, t2, 8
+	j 1b
+
+doubleword_copy_reverse:
+	add  t2, a0, a2
+
+	jal t0, copy_bytes_until_aligned_rv
+
+	1:
+	beq  a3, a5, byte_copy_rv_callin
+	addi a5, a5, -8
+	addi t2, t2, -8
+	ld   t1, (a5)
+	sd   t1, (t2)
+	j 1b
+#endif
+
+word_copy:
+	andi a3, a1, -4
+	andi a4, a5, -4
+	beq  a3, a1, 1f
+	addi a3, a3, 4
+	1:
+	bltu a1, a0, word_copy_reverse
+
+word_copy_forward:
+	add  t2, a0, zero
+
+	jal t0, copy_bytes_until_aligned_fw
+
+	1:
+	beq  a1, a4, byte_copy_fw_callin
+	lw   t1, (a1)
+	sw   t1, (t2)
+	addi a1, a1, 4
+	addi t2, t2, 4
+	j 1b
+
+word_copy_reverse:
+	add  t2, a0, a2
+
+	jal t0, copy_bytes_until_aligned_rv
+
+	1:
+	beq  a3, a5, byte_copy_rv_callin
+	addi a5, a5, -4
+	addi t2, t2, -4
+	lw   t1, (a5)
+	sw   t1, (t2)
+	j 1b
+
+halfword_copy:
+	andi a3, a1, -2
+	andi a4, a5, -2
+	beq  a3, a1, 1f
+	addi a3, a3, 2
+	1:
+	bltu a1, a0, halfword_reverse
+
+halfword_forward:
+	add  t2, a0, zero
+
+	jal t0, copy_bytes_until_aligned_fw
+
+	1:
+	beq  a1, a4, byte_copy_fw_callin
+	lh   t1, (a1)
+	sh   t1, (t2)
+	addi a1, a1, 2
+	addi t2, t2, 2
+	j 1b
+
+halfword_reverse:
+	add  t2, a0, a2
+
+	jal t0, copy_bytes_until_aligned_rv
+
+	1:
+	beq  a3, a5, byte_copy_rv_callin
+	addi a5, a5, -2
+	addi t2, t2, -2
+	lh   t1, (a5)
+	sh   t1, (t2)
+	j 1b
+
+SYM_FUNC_END_ALIAS(memmove)
+SYM_FUNC_END(__memmove)
-- 
2.34.1


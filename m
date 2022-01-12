Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E485E48CB65
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356339AbiALS5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344217AbiALS5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:57:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AF6C06173F;
        Wed, 12 Jan 2022 10:57:00 -0800 (PST)
Date:   Wed, 12 Jan 2022 18:56:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642013817;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=R4wi31HdWueflYFR8yOsMKZBc+tMzdsD3UgnsCYyGms=;
        b=VxazbL3uvlWUWCiKlMtUxHtfY16STCMMcGZDPcbAN++e1QNPmXisydyrJ4mPOEw0y5VRkW
        oWC1vaqjM5l8SbihRiBj5o1JvP/bWQ9sIn6ehhmUGrbfhuSDJxVHpk41c/9V591niahPg4
        hCGSZU7I+N6AgMdu0txBGhXCn57ZR67THM96/mN0a8NAjJyIt7w5KfH1QBTZsSmbx8PgZq
        EXRgvK78LExC4tZF4uCCGF3re59UO+YpSUG4QfM1IkLWRIzeOaUmaRZjuMvXyW9otdDaUK
        8YtYQ1Hk0wOxDFtAo7UAmyQmd8yDQRoBOZEW7OdQ9JUwOzMtrh+NZRSiRgtrFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642013817;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=R4wi31HdWueflYFR8yOsMKZBc+tMzdsD3UgnsCYyGms=;
        b=CSB3BcwRicNitRGDB6NDfiKZZbYBUDdmCP46gkecJGlbUuvF/+lcsjv2O3Y1xX7lwur0DV
        E5PK57B5XYdw+pBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/entry_32: Fix segment exceptions
Cc:     kernel test robot <oliver.sang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164201381597.16921.10308781686748636284.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     9cdbeec4096804083944d05da96bbaf59a1eb4f9
Gitweb:        https://git.kernel.org/tip/9cdbeec4096804083944d05da96bbaf59a1eb4f9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 11 Jan 2022 12:11:14 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 12 Jan 2022 16:38:25 +01:00

x86/entry_32: Fix segment exceptions

The LKP robot reported that commit in Fixes: caused a failure. Turns out
the ldt_gdt_32 selftest turns into an infinite loop trying to clear the
segment.

As discovered by Sean, what happens is that PARANOID_EXIT_TO_KERNEL_MODE
in the handle_exception_return path overwrites the entry stack data with
the task stack data, restoring the "bad" segment value.

Instead of having the exception retry the instruction, have it emulate
the full instruction. Replace EX_TYPE_POP_ZERO with EX_TYPE_POP_REG
which will do the equivalent of: POP %reg; MOV $imm, %reg.

In order to encode the segment registers, add them as registers 8-11 for
32-bit.

By setting regs->[defg]s the (nested) RESTORE_REGS will pop this value
at the end of the exception handler and by increasing regs->sp, it will
have skipped the stack slot.

This was debugged by Sean Christopherson <seanjc@google.com>.

 [ bp: Add EX_REG_GS too. ]

Fixes: aa93e2ad7464 ("x86/entry_32: Remove .fixup usage")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/Yd1l0gInc4zRcnt/@hirez.programming.kicks-ass.net
---
 arch/x86/entry/entry_32.S                  | 13 +++++++++----
 arch/x86/include/asm/extable_fixup_types.h | 11 ++++++++++-
 arch/x86/lib/insn-eval.c                   |  5 +++++
 arch/x86/mm/extable.c                      | 17 +++--------------
 4 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index e0a95d8..a7ec22b 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -268,11 +268,16 @@
 1:	popl	%ds
 2:	popl	%es
 3:	popl	%fs
-	addl	$(4 + \pop), %esp	/* pop the unused "gs" slot */
+4:	addl	$(4 + \pop), %esp	/* pop the unused "gs" slot */
 	IRET_FRAME
-	_ASM_EXTABLE_TYPE(1b, 1b, EX_TYPE_POP_ZERO)
-	_ASM_EXTABLE_TYPE(2b, 2b, EX_TYPE_POP_ZERO)
-	_ASM_EXTABLE_TYPE(3b, 3b, EX_TYPE_POP_ZERO)
+
+	/*
+	 * There is no _ASM_EXTABLE_TYPE_REG() for ASM, however since this is
+	 * ASM the registers are known and we can trivially hard-code them.
+	 */
+	_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_POP_ZERO|EX_REG_DS)
+	_ASM_EXTABLE_TYPE(2b, 3b, EX_TYPE_POP_ZERO|EX_REG_ES)
+	_ASM_EXTABLE_TYPE(3b, 4b, EX_TYPE_POP_ZERO|EX_REG_FS)
 .endm
 
 .macro RESTORE_ALL_NMI cr3_reg:req pop=0
diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index b5ab333..5036226 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -16,9 +16,16 @@
 #define EX_DATA_FLAG_SHIFT		12
 #define EX_DATA_IMM_SHIFT		16
 
+#define EX_DATA_REG(reg)		((reg) << EX_DATA_REG_SHIFT)
 #define EX_DATA_FLAG(flag)		((flag) << EX_DATA_FLAG_SHIFT)
 #define EX_DATA_IMM(imm)		((imm) << EX_DATA_IMM_SHIFT)
 
+/* segment regs */
+#define EX_REG_DS			EX_DATA_REG(8)
+#define EX_REG_ES			EX_DATA_REG(9)
+#define EX_REG_FS			EX_DATA_REG(10)
+#define EX_REG_GS			EX_DATA_REG(11)
+
 /* flags */
 #define EX_FLAG_CLEAR_AX		EX_DATA_FLAG(1)
 #define EX_FLAG_CLEAR_DX		EX_DATA_FLAG(2)
@@ -41,7 +48,9 @@
 #define	EX_TYPE_RDMSR_IN_MCE		13
 #define	EX_TYPE_DEFAULT_MCE_SAFE	14
 #define	EX_TYPE_FAULT_MCE_SAFE		15
-#define	EX_TYPE_POP_ZERO		16
+
+#define	EX_TYPE_POP_REG			16 /* sp += sizeof(long) */
+#define EX_TYPE_POP_ZERO		(EX_TYPE_POP_REG | EX_DATA_IMM(0))
 
 #define	EX_TYPE_IMM_REG			17 /* reg := (long)imm */
 #define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(-EFAULT))
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 7760d22..c8a962c 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -430,6 +430,11 @@ static const int pt_regoff[] = {
 	offsetof(struct pt_regs, r13),
 	offsetof(struct pt_regs, r14),
 	offsetof(struct pt_regs, r15),
+#else
+	offsetof(struct pt_regs, ds),
+	offsetof(struct pt_regs, es),
+	offsetof(struct pt_regs, fs),
+	offsetof(struct pt_regs, gs),
 #endif
 };
 
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 41eaa64..dba2197 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -126,18 +126,6 @@ static bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
 	return ex_handler_default(fixup, regs);
 }
 
-static bool ex_handler_pop_zero(const struct exception_table_entry *fixup,
-				struct pt_regs *regs)
-{
-	/*
-	 * Typically used for when "pop %seg" traps, in which case we'll clear
-	 * the stack slot and re-try the instruction, which will then succeed
-	 * to pop zero.
-	 */
-	*((unsigned long *)regs->sp) = 0;
-	return ex_handler_default(fixup, regs);
-}
-
 static bool ex_handler_imm_reg(const struct exception_table_entry *fixup,
 			       struct pt_regs *regs, int reg, int imm)
 {
@@ -218,8 +206,9 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 	case EX_TYPE_RDMSR_IN_MCE:
 		ex_handler_msr_mce(regs, false);
 		break;
-	case EX_TYPE_POP_ZERO:
-		return ex_handler_pop_zero(e, regs);
+	case EX_TYPE_POP_REG:
+		regs->sp += sizeof(long);
+		fallthrough;
 	case EX_TYPE_IMM_REG:
 		return ex_handler_imm_reg(e, regs, reg, imm);
 	case EX_TYPE_FAULT_SGX:

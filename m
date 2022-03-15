Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826184D993D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347482AbiCOKrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347316AbiCOKpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB473334A;
        Tue, 15 Mar 2022 03:43:57 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ArAtxpSD+TxTsnoeHVZ7oNxvvqLUKVPFRWejT59GfzI=;
        b=NBtRe66HkE03zOTHu6ve4Ly2O/q05UoQ8H0UC9MTTTEmPumyIvZzaw5i8zNbyLdj/MmeOM
        B45A76OTaAXdNqqmnc+R+s5OPyeK8/S/qn24DYFBk7SDVLX/zKj5Rs0M2KfJPmVCD1B/lF
        c4vOm3iGK+nZKoraI8xohfnZtr4hnCuwOfY0w2BqKwlVTqej91wh9EvkEifiTcKzf/kKR9
        1ZZL/eGp/TT1BrLbwBTLZJNnYKaKnwD96C3xjNbCJxcBGAIVf3M2wRUBLOTw0gr8s9cX6f
        lCku8kudMUcMvfC8ZO+jYYhvR4BuHsmXXq25LFAXAgxw6UsRWk/OoQU0d7AorQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ArAtxpSD+TxTsnoeHVZ7oNxvvqLUKVPFRWejT59GfzI=;
        b=0bicAjEfrAftTPSOWiGzSQOWD83x9Q52cG9AXnFRli3SnICpa8bstd+Cv5MKGmd66ULG5I
        /68GJwsymcTecGAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Annotate text references
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.877758523@infradead.org>
References: <20220308154318.877758523@infradead.org>
MIME-Version: 1.0
Message-ID: <164734103513.16921.6405279348386536774.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     3e3f069504344c241f89737e4af014f83fca0b27
Gitweb:        https://git.kernel.org/tip/3e3f069504344c241f89737e4af014f83fca0b27
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:40 +01:00

x86/ibt: Annotate text references

Annotate away some of the generic code references. This is things
where we take the address of a symbol for exception handling or return
addresses (eg. context switch).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.877758523@infradead.org
---
 arch/x86/entry/entry_64.S            |  6 ++++++
 arch/x86/entry/entry_64_compat.S     |  1 +
 arch/x86/kernel/alternative.c        | 10 ++++++++--
 arch/x86/kernel/head_64.S            |  4 ++++
 arch/x86/kernel/kprobes/core.c       |  1 +
 arch/x86/kernel/relocate_kernel_64.S |  2 ++
 arch/x86/lib/error-inject.c          |  2 ++
 arch/x86/lib/retpoline.S             |  1 +
 8 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 50b6118..d76f14f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -277,6 +277,7 @@ SYM_FUNC_END(__switch_to_asm)
 .pushsection .text, "ax"
 SYM_CODE_START(ret_from_fork)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR // copy_thread
 	movq	%rax, %rdi
 	call	schedule_tail			/* rdi: 'prev' task parameter */
 
@@ -569,6 +570,7 @@ __irqentry_text_start:
 	.align 16
 	.globl __irqentry_text_end
 __irqentry_text_end:
+	ANNOTATE_NOENDBR
 
 SYM_CODE_START_LOCAL(common_interrupt_return)
 SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
@@ -650,6 +652,7 @@ SYM_INNER_LABEL(early_xen_iret_patch, SYM_L_GLOBAL)
 #endif
 
 SYM_INNER_LABEL(native_irq_return_iret, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR // exc_double_fault
 	/*
 	 * This may fault.  Non-paranoid faults on return to userspace are
 	 * handled by fixup_bad_iret.  These include #SS, #GP, and #NP.
@@ -744,6 +747,7 @@ SYM_FUNC_START(asm_load_gs_index)
 	FRAME_BEGIN
 	swapgs
 .Lgs_change:
+	ANNOTATE_NOENDBR // error_entry
 	movl	%edi, %gs
 2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
 	swapgs
@@ -1322,6 +1326,7 @@ first_nmi:
 #endif
 
 repeat_nmi:
+	ANNOTATE_NOENDBR // this code
 	/*
 	 * If there was a nested NMI, the first NMI's iret will return
 	 * here. But NMIs are still enabled and we can take another
@@ -1350,6 +1355,7 @@ repeat_nmi:
 	.endr
 	subq	$(5*8), %rsp
 end_repeat_nmi:
+	ANNOTATE_NOENDBR // this code
 
 	/*
 	 * Everything below this point can be preempted by a nested NMI.
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 35a0e69..74208a1 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -148,6 +148,7 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 	popfq
 	jmp	.Lsysenter_flags_fixed
 SYM_INNER_LABEL(__end_entry_SYSENTER_compat, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR // is_sysenter_singlestep
 SYM_CODE_END(entry_SYSENTER_compat)
 
 /*
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 14d1003..954d39c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -713,6 +713,7 @@ asm (
 "	.pushsection	.init.text, \"ax\", @progbits\n"
 "	.type		int3_magic, @function\n"
 "int3_magic:\n"
+	ANNOTATE_NOENDBR
 "	movl	$1, (%" _ASM_ARG1 ")\n"
 	ASM_RET
 "	.size		int3_magic, .-int3_magic\n"
@@ -724,16 +725,19 @@ extern void int3_selftest_ip(void); /* defined in asm below */
 static int __init
 int3_exception_notify(struct notifier_block *self, unsigned long val, void *data)
 {
+	unsigned long selftest = (unsigned long)&int3_selftest_ip;
 	struct die_args *args = data;
 	struct pt_regs *regs = args->regs;
 
+	OPTIMIZER_HIDE_VAR(selftest);
+
 	if (!regs || user_mode(regs))
 		return NOTIFY_DONE;
 
 	if (val != DIE_INT3)
 		return NOTIFY_DONE;
 
-	if (regs->ip - INT3_INSN_SIZE != (unsigned long)&int3_selftest_ip)
+	if (regs->ip - INT3_INSN_SIZE != selftest)
 		return NOTIFY_DONE;
 
 	int3_emulate_call(regs, (unsigned long)&int3_magic);
@@ -757,7 +761,9 @@ static noinline void __init int3_selftest(void)
 	 * INT3 padded with NOP to CALL_INSN_SIZE. The int3_exception_nb
 	 * notifier above will emulate CALL for us.
 	 */
-	asm volatile ("int3_selftest_ip: int3; nop; nop; nop; nop\n\t"
+	asm volatile ("int3_selftest_ip:\n\t"
+		      ANNOTATE_NOENDBR
+		      "    int3; nop; nop; nop; nop\n\t"
 		      : ASM_CALL_CONSTRAINT
 		      : __ASM_SEL_RAW(a, D) (&val)
 		      : "memory");
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 9b6fa76..462cc1e 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -99,6 +99,7 @@ SYM_CODE_END(startup_64)
 
 SYM_CODE_START(secondary_startup_64)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	/*
 	 * At this point the CPU runs in 64bit mode CS.L = 1 CS.D = 0,
 	 * and someone has loaded a mapped page table.
@@ -127,6 +128,7 @@ SYM_CODE_START(secondary_startup_64)
 	 */
 SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 
 	/*
 	 * Retrieve the modifier (SME encryption mask if SME is active) to be
@@ -192,6 +194,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	jmp	*%rax
 1:
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR // above
 
 	/*
 	 * We must switch to a new descriptor in kernel space for the GDT
@@ -299,6 +302,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	pushq	%rax		# target address in negative space
 	lretq
 .Lafter_lret:
+	ANNOTATE_NOENDBR
 SYM_CODE_END(secondary_startup_64)
 
 #include "verify_cpu.S"
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 9ea0e3e..8ef933c 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1033,6 +1033,7 @@ asm(
 	".type __kretprobe_trampoline, @function\n"
 	"__kretprobe_trampoline:\n"
 #ifdef CONFIG_X86_64
+	ANNOTATE_NOENDBR
 	/* Push a fake return address to tell the unwinder it's a kretprobe. */
 	"	pushq $__kretprobe_trampoline\n"
 	UNWIND_HINT_FUNC
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 5b65f6e..c1d8626 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -42,6 +42,7 @@
 	.code64
 SYM_CODE_START_NOALIGN(relocate_kernel)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	/*
 	 * %rdi indirection_page
 	 * %rsi page_list
@@ -223,6 +224,7 @@ SYM_CODE_END(identity_mapped)
 
 SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR // RET target, above
 	movq	RSP(%r8), %rsp
 	movq	CR4(%r8), %rax
 	movq	%rax, %cr4
diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
index 5208970..1e3de07 100644
--- a/arch/x86/lib/error-inject.c
+++ b/arch/x86/lib/error-inject.c
@@ -3,6 +3,7 @@
 #include <linux/linkage.h>
 #include <linux/error-injection.h>
 #include <linux/kprobes.h>
+#include <linux/objtool.h>
 
 asmlinkage void just_return_func(void);
 
@@ -11,6 +12,7 @@ asm(
 	".type just_return_func, @function\n"
 	".globl just_return_func\n"
 	"just_return_func:\n"
+		ANNOTATE_NOENDBR
 		ASM_RET
 	".size just_return_func, .-just_return_func\n"
 );
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index afbdda5..5f87bab 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -55,6 +55,7 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
 
 	.align RETPOLINE_THUNK_SIZE
 SYM_CODE_START(__x86_indirect_thunk_array)
+	ANNOTATE_NOENDBR // apply_retpolines
 
 #define GEN(reg) THUNK reg
 #include <asm/GEN-for-each-reg.h>

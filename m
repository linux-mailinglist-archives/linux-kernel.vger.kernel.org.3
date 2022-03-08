Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81C44D1C9F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348918AbiCHP6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348071AbiCHP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B60F4F9C3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ghZq/fRkvyuABkJueyMa0lboE5tllYhuGIiBxq7FbqI=; b=kKPTVTyZTsLu3fR0dpYKerDGrn
        GJoV9/OHn4Wg3KwK4LbsmvTz4ldr6vXYvfTDc+c8ZeQRzoCbQx3HEsXxJi8DZdffyI79H24vd1DXL
        sBmwrzj+XLUccjPmqeF0XfjwFhrRQYoEDV1n+58+32SrA7V9bWGPM4N14beJQqsguhAzDLUC+Gs7o
        QcgWhqdQsoT0OQ0Wfksmt5/Cf1sRY+22LnDrBMXmj90EN6u8rT4XssU3O2Vv88P4iZwd3z01X92oV
        YYy5Y99wGtoBSJeHXQX5A+RQvJbY+VriJAvWpxLpidZmvua7DhQ40z28cfljYrGi2JXtVmMwmGBQx
        GiDXY34A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAc-00GIvG-Qk; Tue, 08 Mar 2022 15:54:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 447A5302D52;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 87E302B561939; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154318.877758523@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 29/45] x86/ibt: Annotate text references
References: <20220308153011.021123062@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotate away some of the generic code references. This is things
where we take the address of a symbol for exception handling or return
addresses (eg. context switch).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S            |    6 ++++++
 arch/x86/entry/entry_64_compat.S     |    1 +
 arch/x86/kernel/alternative.c        |   10 ++++++++--
 arch/x86/kernel/head_64.S            |    4 ++++
 arch/x86/kernel/kprobes/core.c       |    1 +
 arch/x86/kernel/relocate_kernel_64.S |    2 ++
 arch/x86/lib/error-inject.c          |    2 ++
 arch/x86/lib/retpoline.S             |    1 +
 8 files changed, 25 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -277,6 +277,7 @@ SYM_FUNC_END(__switch_to_asm)
 .pushsection .text, "ax"
 SYM_CODE_START(ret_from_fork)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR // copy_thread
 	movq	%rax, %rdi
 	call	schedule_tail			/* rdi: 'prev' task parameter */
 
@@ -569,6 +570,7 @@ SYM_CODE_END(\asmsym)
 	.align 16
 	.globl __irqentry_text_end
 __irqentry_text_end:
+	ANNOTATE_NOENDBR
 
 SYM_CODE_START_LOCAL(common_interrupt_return)
 SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
@@ -650,6 +652,7 @@ SYM_INNER_LABEL(early_xen_iret_patch, SY
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
@@ -1322,6 +1326,7 @@ SYM_CODE_START(asm_exc_nmi)
 #endif
 
 repeat_nmi:
+	ANNOTATE_NOENDBR // this code
 	/*
 	 * If there was a nested NMI, the first NMI's iret will return
 	 * here. But NMIs are still enabled and we can take another
@@ -1350,6 +1355,7 @@ SYM_CODE_START(asm_exc_nmi)
 	.endr
 	subq	$(5*8), %rsp
 end_repeat_nmi:
+	ANNOTATE_NOENDBR // this code
 
 	/*
 	 * Everything below this point can be preempted by a nested NMI.
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -148,6 +148,7 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_af
 	popfq
 	jmp	.Lsysenter_flags_fixed
 SYM_INNER_LABEL(__end_entry_SYSENTER_compat, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR // is_sysenter_singlestep
 SYM_CODE_END(entry_SYSENTER_compat)
 
 /*
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
@@ -724,16 +725,19 @@ extern void int3_selftest_ip(void); /* d
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
@@ -757,7 +761,9 @@ static void __init int3_selftest(void)
 	 * then trigger the INT3, padded with NOPs to match a CALL instruction
 	 * length.
 	 */
-	asm volatile ("int3_selftest_ip: int3; nop; nop; nop; nop\n\t"
+	asm volatile ("int3_selftest_ip:\n\t"
+		      ANNOTATE_NOENDBR
+		      "    int3; nop; nop; nop; nop\n\t"
 		      : ASM_CALL_CONSTRAINT
 		      : __ASM_SEL_RAW(a, D) (&val)
 		      : "memory");
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
@@ -192,6 +194,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_
 	jmp	*%rax
 1:
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR // above
 
 	/*
 	 * We must switch to a new descriptor in kernel space for the GDT
@@ -299,6 +302,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_
 	pushq	%rax		# target address in negative space
 	lretq
 .Lafter_lret:
+	ANNOTATE_NOENDBR
 SYM_CODE_END(secondary_startup_64)
 
 #include "verify_cpu.S"
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
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -55,6 +55,7 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\re
 
 	.align RETPOLINE_THUNK_SIZE
 SYM_CODE_START(__x86_indirect_thunk_array)
+	ANNOTATE_NOENDBR // apply_retpolines
 
 #define GEN(reg) THUNK reg
 #include <asm/GEN-for-each-reg.h>



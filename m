Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01814577250
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiGPXT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiGPXTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:19:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D455F24F1C
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:18:16 -0700 (PDT)
Message-ID: <20220716230954.835254576@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=PII+cwKLyD+P05ol3oLjiYv5SJEasmDF6oIXlLdij2g=;
        b=m3VUJtBcCROOUBGwbEBONJJigGj+W4WZzj2RctcUR0DtY0EwqJwcsUMfq02ZAiem7/7qP9
        Qi+0E/ceGixkq0tkSek6amfM+oBHnAES3cKxJw5nSTDJ39pQj6t2SpngsmnZA07VawP+yZ
        reCpZXAFL1PueX5Qxr7RFlO3drmIVLAU3lNCzA9xYZg7ZSvjmhcABXwFmuHw8dEYGYrVcC
        tIUYyO+9wMQ9KuXa+O+S9NqS5FlmwpBvvtwdlpwT9uTTtRseiaPonkZlSXXtoNSMDyoNHO
        dwxlQCHQCyvDfKUpPY8Pk9CHREJJqqE73KyUJMGXbt9z57whZ8ISvOqXt7Bjzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=PII+cwKLyD+P05ol3oLjiYv5SJEasmDF6oIXlLdij2g=;
        b=X932vk2axR6UO80rh2//i3Y151zee7HakzWAlj5t2aT1m+U/Jbzz3AnvU/GTdAiy31fk9D
        Ufo1iUX29DwmcECg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch 36/38] x86/ftrace: Make it call depth tracking aware
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:18:08 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Since ftrace has trampolines, don't use thunks for the __fentry__ site
but instead require that every function called from there includes
accounting. This very much includes all the direct-call functions.

Additionally, ftrace uses ROP tricks in two places:

 - return_to_handler(), and
 - ftrace_regs_caller() when pt_regs->orig_ax is set by a direct-call.

return_to_handler() already uses a retpoline to replace an
indirect-jump to defeat IBT, since this is a jump-type retpoline, make
sure there is no accounting done and ALTERNATIVE the RET into a ret.

ftrace_regs_caller() does much the same but currently causes an RSB
imbalance by effectively doing a PUSH+RET combo, rebalance.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/nospec-branch.h        |    8 +++++++
 arch/x86/kernel/ftrace.c                    |   16 ++++++++++----
 arch/x86/kernel/ftrace_64.S                 |   31 ++++++++++++++++++++++++++--
 arch/x86/net/bpf_jit_comp.c                 |    6 +++++
 kernel/trace/trace_selftest.c               |    5 +++-
 samples/ftrace/ftrace-direct-modify.c       |    2 +
 samples/ftrace/ftrace-direct-multi-modify.c |    2 +
 samples/ftrace/ftrace-direct-multi.c        |    1 
 samples/ftrace/ftrace-direct-too.c          |    1 
 samples/ftrace/ftrace-direct.c              |    1 
 10 files changed, 66 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -293,6 +293,11 @@ static inline void x86_set_skl_return_th
 	x86_return_thunk = &__x86_return_skl;
 }
 
+#define CALL_DEPTH_ACCOUNT					\
+	ALTERNATIVE("",						\
+		    __stringify(INCREMENT_CALL_DEPTH),		\
+		    X86_FEATURE_CALL_DEPTH)
+
 DECLARE_PER_CPU(u64, __x86_call_depth);
 #ifdef CONFIG_CALL_THUNKS_DEBUG
 DECLARE_PER_CPU(u64, __x86_call_count);
@@ -302,6 +307,9 @@ DECLARE_PER_CPU(u64, __x86_ctxsw_count);
 #endif
 #else
 static inline void x86_set_skl_return_thunk(void) {}
+
+#define CALL_DEPTH_ACCOUNT
+
 #endif
 
 #ifdef CONFIG_RETPOLINE
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -69,6 +69,10 @@ static const char *ftrace_nop_replace(vo
 
 static const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 {
+	/*
+	 * No need to translate into a callthunk. The trampoline does
+	 * the depth accounting itself.
+	 */
 	return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
 }
 
@@ -316,7 +320,7 @@ create_trampoline(struct ftrace_ops *ops
 	unsigned long size;
 	unsigned long *ptr;
 	void *trampoline;
-	void *ip;
+	void *ip, *dest;
 	/* 48 8b 15 <offset> is movq <offset>(%rip), %rdx */
 	unsigned const char op_ref[] = { 0x48, 0x8b, 0x15 };
 	unsigned const char retq[] = { RET_INSN_OPCODE, INT3_INSN_OPCODE };
@@ -403,10 +407,14 @@ create_trampoline(struct ftrace_ops *ops
 	/* put in the call to the function */
 	mutex_lock(&text_mutex);
 	call_offset -= start_offset;
+	/*
+	 * No need to translate into a callthunk. The trampoline does
+	 * the depth accounting before the call already.
+	 */
+	dest = ftrace_ops_get_func(ops);
 	memcpy(trampoline + call_offset,
-	       text_gen_insn(CALL_INSN_OPCODE,
-			     trampoline + call_offset,
-			     ftrace_ops_get_func(ops)), CALL_INSN_SIZE);
+	       text_gen_insn(CALL_INSN_OPCODE, trampoline + call_offset, dest),
+	       CALL_INSN_SIZE);
 	mutex_unlock(&text_mutex);
 
 	/* ALLOC_TRAMP flags lets us know we created it */
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -132,6 +132,7 @@
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 SYM_FUNC_START(__fentry__)
+	CALL_DEPTH_ACCOUNT
 	RET
 SYM_FUNC_END(__fentry__)
 EXPORT_SYMBOL(__fentry__)
@@ -140,6 +141,8 @@ SYM_FUNC_START(ftrace_caller)
 	/* save_mcount_regs fills in first two parameters */
 	save_mcount_regs
 
+	CALL_DEPTH_ACCOUNT
+
 	/* Stack - skipping return address of ftrace_caller */
 	leaq MCOUNT_REG_SIZE+8(%rsp), %rcx
 	movq %rcx, RSP(%rsp)
@@ -155,6 +158,9 @@ SYM_INNER_LABEL(ftrace_caller_op_ptr, SY
 	/* Only ops with REGS flag set should have CS register set */
 	movq $0, CS(%rsp)
 
+	/* Account for the function call below */
+	CALL_DEPTH_ACCOUNT
+
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	call ftrace_stub
@@ -195,6 +201,8 @@ SYM_FUNC_START(ftrace_regs_caller)
 	save_mcount_regs 8
 	/* save_mcount_regs fills in first two parameters */
 
+	CALL_DEPTH_ACCOUNT
+
 SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	/* Load the ftrace_ops into the 3rd parameter */
@@ -225,6 +233,9 @@ SYM_INNER_LABEL(ftrace_regs_caller_op_pt
 	/* regs go into 4th parameter */
 	leaq (%rsp), %rcx
 
+	/* Account for the function call below */
+	CALL_DEPTH_ACCOUNT
+
 SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	call ftrace_stub
@@ -280,7 +291,19 @@ SYM_INNER_LABEL(ftrace_regs_caller_end,
 	/* Restore flags */
 	popfq
 	UNWIND_HINT_FUNC
-	jmp	ftrace_epilogue
+
+	/*
+	 * Since we're effectively emulating a tail-call with PUSH;RET
+	 * make sure we don't unbalance the RSB and mess up accounting.
+	 */
+	ANNOTATE_INTRA_FUNCTION_CALL
+	call	2f
+	int3
+2:
+	add	$8, %rsp
+	ALTERNATIVE __stringify(RET), \
+		    __stringify(ANNOTATE_UNRET_SAFE; ret; int3), \
+		    X86_FEATURE_CALL_DEPTH
 
 SYM_FUNC_END(ftrace_regs_caller)
 STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
@@ -289,6 +312,8 @@ STACK_FRAME_NON_STANDARD_FP(ftrace_regs_
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
 SYM_FUNC_START(__fentry__)
+	CALL_DEPTH_ACCOUNT
+
 	cmpq $ftrace_stub, ftrace_trace_function
 	jnz trace
 
@@ -345,6 +370,8 @@ SYM_CODE_START(return_to_handler)
 	int3
 .Ldo_rop:
 	mov %rdi, (%rsp)
-	RET
+	ALTERNATIVE __stringify(RET), \
+		    __stringify(ANNOTATE_UNRET_SAFE; ret; int3), \
+		    X86_FEATURE_CALL_DEPTH
 SYM_CODE_END(return_to_handler)
 #endif
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -12,6 +12,7 @@
 #include <linux/memory.h>
 #include <linux/sort.h>
 #include <asm/extable.h>
+#include <asm/ftrace.h>
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
 #include <asm/text-patching.h>
@@ -2090,6 +2091,11 @@ int arch_prepare_bpf_trampoline(struct b
 	prog = image;
 
 	EMIT_ENDBR();
+	/*
+	 * This is the direct-call trampoline, as such it needs accounting
+	 * for the __fentry__ call.
+	 */
+	x86_call_depth_emit_accounting(&prog, __fentry__);
 	EMIT1(0x55);		 /* push rbp */
 	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
 	EMIT4(0x48, 0x83, 0xEC, stack_size); /* sub rsp, stack_size */
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -785,7 +785,10 @@ static struct fgraph_ops fgraph_ops __in
 };
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-noinline __noclone static void trace_direct_tramp(void) { }
+noinline __noclone static void trace_direct_tramp(void)
+{
+	asm(CALL_DEPTH_ACCOUNT);
+}
 #endif
 
 /*
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -34,6 +34,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	call my_direct_func1\n"
 "	leave\n"
 "	.size		my_tramp1, .-my_tramp1\n"
@@ -45,6 +46,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	call my_direct_func2\n"
 "	leave\n"
 	ASM_RET
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -32,6 +32,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func1\n"
@@ -46,6 +47,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func2\n"
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -27,6 +27,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func\n"
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -29,6 +29,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	pushq %rdi\n"
 "	pushq %rsi\n"
 "	pushq %rdx\n"
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -26,6 +26,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	pushq %rdi\n"
 "	call my_direct_func\n"
 "	popq %rdi\n"


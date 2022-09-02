Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668085AB38F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbiIBOai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237270AbiIBO1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A4013C9F1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=nkpy4e1HtSQn0yBC/Joemu5I/+dxImw25H8Njycu7GE=; b=gr5bIfOceN5RFMT0JskhEX8l9A
        j2BCiiRa/wWT+4OiusNtzYwdWDDM3HTtvzcHBYyZYGIneK2pySdi7yOK5KmbvsnUJpTulnQ2f8TZC
        tWYVjFkJtGRAZ1ztjMBHr3Z/lHdtmiWkhWW5r/0Y+WCs5DY0P/TvZ1nlZPCeX6etVCEKn00dBuJIj
        OO3F2ZxiM6btpoclenQBUXoPGW1G3k1+SLSnW+TNgp4UlDBOiTYlge0WuPR8ysSTvfZNvUA3nqm54
        iJVp6MiS8ulpbKYtJ7/yAgcJFw9z021qr+Vwq6f6NK/MK+mYs0ohK+fcX+8H7VQPqH0+oEy+vAm/h
        NY95A2/g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77Q-0074V7-Ty; Fri, 02 Sep 2022 13:54:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 490DA302E0D;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D66032B8EFB66; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130952.375380675@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:07:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 58/59] x86/ftrace: Make it call depth tracking aware
References: <20220902130625.217071627@infradead.org>
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

ftrace_regs_caller() does much the same and gets the same treatment.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h        |    9 +++++++++
 arch/x86/kernel/callthunks.c                |    2 +-
 arch/x86/kernel/ftrace.c                    |   16 ++++++++++++----
 arch/x86/kernel/ftrace_64.S                 |   22 ++++++++++++++++++++--
 arch/x86/net/bpf_jit_comp.c                 |    6 ++++++
 kernel/trace/trace_selftest.c               |    5 ++++-
 samples/ftrace/ftrace-direct-modify.c       |    3 +++
 samples/ftrace/ftrace-direct-multi-modify.c |    3 +++
 samples/ftrace/ftrace-direct-multi.c        |    2 ++
 samples/ftrace/ftrace-direct-too.c          |    2 ++
 samples/ftrace/ftrace-direct.c              |    2 ++
 11 files changed, 64 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -331,6 +331,12 @@ static inline void x86_set_skl_return_th
 {
 	x86_return_thunk = &__x86_return_skl;
 }
+
+#define CALL_DEPTH_ACCOUNT					\
+	ALTERNATIVE("",						\
+		    __stringify(INCREMENT_CALL_DEPTH),		\
+		    X86_FEATURE_CALL_DEPTH)
+
 #ifdef CONFIG_CALL_THUNKS_DEBUG
 DECLARE_PER_CPU(u64, __x86_call_count);
 DECLARE_PER_CPU(u64, __x86_ret_count);
@@ -339,6 +345,9 @@ DECLARE_PER_CPU(u64, __x86_ctxsw_count);
 #endif
 #else
 static inline void x86_set_skl_return_thunk(void) {}
+
+#define CALL_DEPTH_ACCOUNT ""
+
 #endif
 
 #ifdef CONFIG_RETPOLINE
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -315,7 +315,7 @@ int x86_call_depth_emit_accounting(u8 **
 		return 0;
 
 	/* Is function call target a thunk? */
-	if (is_callthunk(func))
+	if (func && is_callthunk(func))
 		return 0;
 
 	memcpy(*pprog, tmpl, tmpl_size);
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
 
@@ -317,7 +321,7 @@ create_trampoline(struct ftrace_ops *ops
 	unsigned long size;
 	unsigned long *ptr;
 	void *trampoline;
-	void *ip;
+	void *ip, *dest;
 	/* 48 8b 15 <offset> is movq <offset>(%rip), %rdx */
 	unsigned const char op_ref[] = { 0x48, 0x8b, 0x15 };
 	unsigned const char retq[] = { RET_INSN_OPCODE, INT3_INSN_OPCODE };
@@ -404,10 +408,14 @@ create_trampoline(struct ftrace_ops *ops
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
@@ -4,6 +4,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
 #include <asm/ftrace.h>
 #include <asm/export.h>
@@ -132,6 +133,7 @@
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 SYM_FUNC_START(__fentry__)
+	CALL_DEPTH_ACCOUNT
 	RET
 SYM_FUNC_END(__fentry__)
 EXPORT_SYMBOL(__fentry__)
@@ -140,6 +142,8 @@ SYM_FUNC_START(ftrace_caller)
 	/* save_mcount_regs fills in first two parameters */
 	save_mcount_regs
 
+	CALL_DEPTH_ACCOUNT
+
 	/* Stack - skipping return address of ftrace_caller */
 	leaq MCOUNT_REG_SIZE+8(%rsp), %rcx
 	movq %rcx, RSP(%rsp)
@@ -155,6 +159,9 @@ SYM_INNER_LABEL(ftrace_caller_op_ptr, SY
 	/* Only ops with REGS flag set should have CS register set */
 	movq $0, CS(%rsp)
 
+	/* Account for the function call below */
+	CALL_DEPTH_ACCOUNT
+
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	call ftrace_stub
@@ -189,6 +196,8 @@ SYM_FUNC_START(ftrace_regs_caller)
 	save_mcount_regs 8
 	/* save_mcount_regs fills in first two parameters */
 
+	CALL_DEPTH_ACCOUNT
+
 SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	/* Load the ftrace_ops into the 3rd parameter */
@@ -219,6 +228,9 @@ SYM_INNER_LABEL(ftrace_regs_caller_op_pt
 	/* regs go into 4th parameter */
 	leaq (%rsp), %rcx
 
+	/* Account for the function call below */
+	CALL_DEPTH_ACCOUNT
+
 SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	call ftrace_stub
@@ -282,7 +294,9 @@ SYM_INNER_LABEL(ftrace_regs_caller_end,
 	int3
 .Ldo_rebalance:
 	add $8, %rsp
-	RET
+	ALTERNATIVE __stringify(RET), \
+		    __stringify(ANNOTATE_UNRET_SAFE; ret; int3), \
+		    X86_FEATURE_CALL_DEPTH
 
 SYM_FUNC_END(ftrace_regs_caller)
 STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
@@ -291,6 +305,8 @@ STACK_FRAME_NON_STANDARD_FP(ftrace_regs_
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
 SYM_FUNC_START(__fentry__)
+	CALL_DEPTH_ACCOUNT
+
 	cmpq $ftrace_stub, ftrace_trace_function
 	jnz trace
 
@@ -347,6 +363,8 @@ SYM_CODE_START(return_to_handler)
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
@@ -2095,6 +2096,11 @@ int arch_prepare_bpf_trampoline(struct b
 	prog = image;
 
 	EMIT_ENDBR();
+	/*
+	 * This is the direct-call trampoline, as such it needs accounting
+	 * for the __fentry__ call.
+	 */
+	x86_call_depth_emit_accounting(&prog, NULL);
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
@@ -3,6 +3,7 @@
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-branch.h>
 
 extern void my_direct_func1(void);
 extern void my_direct_func2(void);
@@ -34,6 +35,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	call my_direct_func1\n"
 "	leave\n"
 "	.size		my_tramp1, .-my_tramp1\n"
@@ -45,6 +47,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	call my_direct_func2\n"
 "	leave\n"
 	ASM_RET
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -3,6 +3,7 @@
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-branch.h>
 
 extern void my_direct_func1(unsigned long ip);
 extern void my_direct_func2(unsigned long ip);
@@ -32,6 +33,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func1\n"
@@ -46,6 +48,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func2\n"
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -5,6 +5,7 @@
 #include <linux/ftrace.h>
 #include <linux/sched/stat.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-branch.h>
 
 extern void my_direct_func(unsigned long ip);
 
@@ -27,6 +28,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func\n"
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -4,6 +4,7 @@
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-branch.h>
 
 extern void my_direct_func(struct vm_area_struct *vma,
 			   unsigned long address, unsigned int flags);
@@ -29,6 +30,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	pushq %rdi\n"
 "	pushq %rsi\n"
 "	pushq %rdx\n"
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -4,6 +4,7 @@
 #include <linux/sched.h> /* for wake_up_process() */
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-branch.h>
 
 extern void my_direct_func(struct task_struct *p);
 
@@ -26,6 +27,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	pushq %rdi\n"
 "	call my_direct_func\n"
 "	popq %rdi\n"



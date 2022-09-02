Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343375AB37F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbiIBO2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbiIBO1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2062EE6BA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=hulrMKM+G54XvOkRK8niCZtARXKO3DviugUwXwClgsU=; b=SLQ+/x0CpgeWTIXTF6IqFFbfqp
        ubAGGAYvbmSzXE+ajDGZNRCE45i5ooIeWBWn7X6tOitjJ3msEWc/fojkHLxiuzlyrPSrsyiF9+l/f
        YDMe+rIOT2WsjaMmUX3S6dZdsPwGBxNeKTwfCC1wcCtf7kHaQLK72+1g5298qY2zC6zIm3ClL9tBo
        Lx6X1T+5J3AG0MkQtcIrfkoG76jQIO/OUYAQ2hMsOs6iODlZkXNLpHZx4jtQAMQgRXNU68t/44D2L
        0l6qVQ1H3hJiCisXMm20q86cx3FH45UnSjUnfQody7ApMDkDMe0Db5OpzUgB3CFyq6wT14H959+Y5
        dIEYFUbw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77M-008g8G-FK; Fri, 02 Sep 2022 13:53:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28394301D73;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B46092B8EF7EF; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130948.954682077@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:50 +0200
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
Subject: [PATCH v2 25/59] x86/percpu: Move current_top_of_stack next to current_task
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

From: Thomas Gleixner <tglx@linutronix.de>

Extend the struct pcpu_hot cacheline with current_top_of_stack;
another very frequently used value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_32.S        |    4 ++--
 arch/x86/entry/entry_64.S        |    6 +++---
 arch/x86/entry/entry_64_compat.S |    6 +++---
 arch/x86/include/asm/current.h   |    1 +
 arch/x86/include/asm/processor.h |    4 +---
 arch/x86/kernel/asm-offsets.c    |    2 ++
 arch/x86/kernel/cpu/common.c     |   12 +-----------
 arch/x86/kernel/process_32.c     |    4 ++--
 arch/x86/kernel/process_64.c     |    2 +-
 arch/x86/kernel/smpboot.c        |    2 +-
 arch/x86/kernel/traps.c          |    4 ++--
 11 files changed, 19 insertions(+), 28 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1181,7 +1181,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 * is using the thread stack right now, so it's safe for us to use it.
 	 */
 	movl	%esp, %ebx
-	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esp
+	movl	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %esp
 	call	exc_nmi
 	movl	%ebx, %esp
 
@@ -1243,7 +1243,7 @@ SYM_CODE_START(rewind_stack_and_make_dea
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
 
-	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esi
+	movl	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %esi
 	leal	-TOP_OF_KERNEL_STACK_PADDING-PTREGS_SIZE(%esi), %esp
 
 	call	make_task_dead
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -92,7 +92,7 @@ SYM_CODE_START(entry_SYSCALL_64)
 	/* tss.sp2 is scratch space. */
 	movq	%rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
 
 SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
@@ -1209,7 +1209,7 @@ SYM_CODE_START(asm_exc_nmi)
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
 	UNWIND_HINT_IRET_REGS base=%rdx offset=8
 	pushq	5*8(%rdx)	/* pt_regs->ss */
 	pushq	4*8(%rdx)	/* pt_regs->rsp */
@@ -1525,7 +1525,7 @@ SYM_CODE_START_NOALIGN(rewind_stack_and_
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
 
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rax
+	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rax
 	leaq	-PTREGS_SIZE(%rax), %rsp
 	UNWIND_HINT_REGS
 
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -58,7 +58,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 	popq	%rax
 
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
 
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER32_DS		/* pt_regs->ss */
@@ -191,7 +191,7 @@ SYM_CODE_START(entry_SYSCALL_compat)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
 
 	/* Switch to the kernel stack */
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
 
 SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
@@ -332,7 +332,7 @@ SYM_CODE_START(entry_INT80_compat)
 	ALTERNATIVE "", "jmp .Lint80_keep_stack", X86_FEATURE_XENPV
 
 	movq	%rsp, %rax
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
 
 	pushq	5*8(%rax)		/* regs->ss */
 	pushq	4*8(%rax)		/* regs->rsp */
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -17,6 +17,7 @@ struct pcpu_hot {
 			struct task_struct	*current_task;
 			int			preempt_count;
 			int			cpu_number;
+			unsigned long		top_of_stack;
 		};
 		u8	pad[64];
 	};
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -426,8 +426,6 @@ struct irq_stack {
 	char		stack[IRQ_STACK_SIZE];
 } __aligned(IRQ_STACK_SIZE);
 
-DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
-
 #ifdef CONFIG_X86_64
 struct fixed_percpu_data {
 	/*
@@ -566,7 +564,7 @@ static __always_inline unsigned long cur
 	 *  and around vm86 mode and sp0 on x86_64 is special because of the
 	 *  entry trampoline.
 	 */
-	return this_cpu_read_stable(cpu_current_top_of_stack);
+	return this_cpu_read_stable(pcpu_hot.top_of_stack);
 }
 
 static __always_inline bool on_thread_stack(void)
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -109,6 +109,8 @@ static void __used common(void)
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
 
+	OFFSET(X86_top_of_stack, pcpu_hot, top_of_stack);
+
 	if (IS_ENABLED(CONFIG_KVM_INTEL)) {
 		BLANK();
 		OFFSET(VMX_spec_ctrl, vcpu_vmx, spec_ctrl);
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2003,6 +2003,7 @@ static __init int setup_clearcpuid(char
 DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
 	.current_task	= &init_task,
 	.preempt_count	= INIT_PREEMPT_COUNT,
+	.top_of_stack	= TOP_OF_INIT_STACK,
 };
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 
@@ -2014,8 +2015,6 @@ EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_d
 DEFINE_PER_CPU(void *, hardirq_stack_ptr);
 DEFINE_PER_CPU(bool, hardirq_stack_inuse);
 
-DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
-
 static void wrmsrl_cstar(unsigned long val)
 {
 	/*
@@ -2066,15 +2065,6 @@ void syscall_init(void)
 
 #else	/* CONFIG_X86_64 */
 
-/*
- * On x86_32, vm86 modifies tss.sp0, so sp0 isn't a reliable way to find
- * the top of the kernel stack.  Use an extra percpu variable to track the
- * top of the kernel stack directly.
- */
-DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) =
-	(unsigned long)&init_thread_union + THREAD_SIZE;
-EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
-
 #ifdef CONFIG_STACKPROTECTOR
 DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -191,13 +191,13 @@ EXPORT_SYMBOL_GPL(start_thread);
 	arch_end_context_switch(next_p);
 
 	/*
-	 * Reload esp0 and cpu_current_top_of_stack.  This changes
+	 * Reload esp0 and pcpu_hot.top_of_stack.  This changes
 	 * current_thread_info().  Refresh the SYSENTER configuration in
 	 * case prev or next is vm86.
 	 */
 	update_task_stack(next_p);
 	refresh_sysenter_cs(next);
-	this_cpu_write(cpu_current_top_of_stack,
+	this_cpu_write(pcpu_hot.top_of_stack,
 		       (unsigned long)task_stack_page(next_p) +
 		       THREAD_SIZE);
 
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -617,7 +617,7 @@ void compat_start_thread(struct pt_regs
 	 * Switch the PDA and FPU contexts.
 	 */
 	raw_cpu_write(pcpu_hot.current_task, next_p);
-	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
+	raw_cpu_write(pcpu_hot.top_of_stack, task_top_of_stack(next_p));
 
 	switch_fpu_finish();
 
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1056,7 +1056,7 @@ int common_cpu_up(unsigned int cpu, stru
 
 #ifdef CONFIG_X86_32
 	/* Stack for startup_32 can be just as for start_secondary onwards */
-	per_cpu(cpu_current_top_of_stack, cpu) = task_top_of_stack(idle);
+	per_cpu(pcpu_hot.top_of_stack, cpu) = task_top_of_stack(idle);
 #else
 	initial_gs = per_cpu_offset(cpu);
 #endif
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -849,7 +849,7 @@ DEFINE_IDTENTRY_RAW(exc_int3)
  */
 asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
 {
-	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(cpu_current_top_of_stack) - 1;
+	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(pcpu_hot.top_of_stack) - 1;
 	if (regs != eregs)
 		*regs = *eregs;
 	return regs;
@@ -867,7 +867,7 @@ asmlinkage __visible noinstr struct pt_r
 	 * trust it and switch to the current kernel stack
 	 */
 	if (ip_within_syscall_gap(regs)) {
-		sp = this_cpu_read(cpu_current_top_of_stack);
+		sp = this_cpu_read(pcpu_hot.top_of_stack);
 		goto sync;
 	}
 



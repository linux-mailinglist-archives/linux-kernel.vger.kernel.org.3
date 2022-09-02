Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288FC5AB377
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbiIBO2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiIBO1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697BF141A36
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=PFfW8V4/jVOWAwq+y9cqQUX13nMDKmYOZG3YIHdvifE=; b=Ttg6g5Xhu9XRQ3qFnHxWqKZC3T
        YPDo/4B/2G996i3BKIZSXY64Fy+VTc1Hs0JqsaRqjzDSqiXxbbFb8Gax+ujuqlvkunKeFAbcbhRYx
        adYq4+gVOEbwvmA+jGvezQ7vC0wTE6qnHi+USA3mlQmDUWtSgxd1ZzRO0LoI4Je31naIWCs5Pw54+
        PA0LyO9wWuHXi3x9qYaBSbO2c5eRxSCs21wlBWuv39op2aogHjgoU2yOv0CQzkavExRNMfwvDabZe
        aM2eHkacnFlYiPONOWk6S92jaQuPNHxAvXV/UCdlWmLMT4ttiHYhdxr/3wKE8/lOYWXvB4d77/rhB
        /0RCUM1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77M-008g8D-DD; Fri, 02 Sep 2022 13:53:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27D11301D53;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BC2BB2B8EF7F0; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130949.060211705@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:51 +0200
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
Subject: [PATCH v2 26/59] x86/percpu: Move irq_stack variables next to current_task
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

Further extend struct pcpu_hot with the hard and soft irq stack
pointers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/current.h   |    6 ++++++
 arch/x86/include/asm/irq_stack.h |   12 ++++++------
 arch/x86/include/asm/processor.h |    4 ----
 arch/x86/kernel/cpu/common.c     |    3 ---
 arch/x86/kernel/dumpstack_32.c   |    4 ++--
 arch/x86/kernel/dumpstack_64.c   |    2 +-
 arch/x86/kernel/irq_32.c         |   13 +++++--------
 arch/x86/kernel/irq_64.c         |    6 +++---
 arch/x86/kernel/process_64.c     |    2 +-
 9 files changed, 24 insertions(+), 28 deletions(-)

--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -18,6 +18,12 @@ struct pcpu_hot {
 			int			preempt_count;
 			int			cpu_number;
 			unsigned long		top_of_stack;
+			void			*hardirq_stack_ptr;
+#ifdef CONFIG_X86_64
+			bool			hardirq_stack_inuse;
+#else
+			void			*softirq_stack_ptr;
+#endif
 		};
 		u8	pad[64];
 	};
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -116,7 +116,7 @@
 	ASM_CALL_ARG2
 
 #define call_on_irqstack(func, asm_call, argconstr...)			\
-	call_on_stack(__this_cpu_read(hardirq_stack_ptr),		\
+	call_on_stack(__this_cpu_read(pcpu_hot.hardirq_stack_ptr),	\
 		      func, asm_call, argconstr)
 
 /* Macros to assert type correctness for run_*_on_irqstack macros */
@@ -135,7 +135,7 @@
 	 * User mode entry and interrupt on the irq stack do not	\
 	 * switch stacks. If from user mode the task stack is empty.	\
 	 */								\
-	if (user_mode(regs) || __this_cpu_read(hardirq_stack_inuse)) {	\
+	if (user_mode(regs) || __this_cpu_read(pcpu_hot.hardirq_stack_inuse)) { \
 		irq_enter_rcu();					\
 		func(c_args);						\
 		irq_exit_rcu();						\
@@ -146,9 +146,9 @@
 		 * places. Invoke the stack switch macro with the call	\
 		 * sequence which matches the above direct invocation.	\
 		 */							\
-		__this_cpu_write(hardirq_stack_inuse, true);		\
+		__this_cpu_write(pcpu_hot.hardirq_stack_inuse, true);	\
 		call_on_irqstack(func, asm_call, constr);		\
-		__this_cpu_write(hardirq_stack_inuse, false);		\
+		__this_cpu_write(pcpu_hot.hardirq_stack_inuse, false);	\
 	}								\
 }
 
@@ -212,9 +212,9 @@
  */
 #define do_softirq_own_stack()						\
 {									\
-	__this_cpu_write(hardirq_stack_inuse, true);			\
+	__this_cpu_write(pcpu_hot.hardirq_stack_inuse, true);		\
 	call_on_irqstack(__do_softirq, ASM_CALL_ARG0);			\
-	__this_cpu_write(hardirq_stack_inuse, false);			\
+	__this_cpu_write(pcpu_hot.hardirq_stack_inuse, false);		\
 }
 
 #endif
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -448,8 +448,6 @@ static inline unsigned long cpu_kernelmo
 	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
 }
 
-DECLARE_PER_CPU(void *, hardirq_stack_ptr);
-DECLARE_PER_CPU(bool, hardirq_stack_inuse);
 extern asmlinkage void ignore_sysret(void);
 
 /* Save actual FS/GS selectors and bases to current->thread */
@@ -458,8 +456,6 @@ void current_save_fsgs(void);
 #ifdef CONFIG_STACKPROTECTOR
 DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
 #endif
-DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
-DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
 #endif	/* !X86_64 */
 
 struct perf_event;
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2012,9 +2012,6 @@ DEFINE_PER_CPU_FIRST(struct fixed_percpu
 		     fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
 EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
 
-DEFINE_PER_CPU(void *, hardirq_stack_ptr);
-DEFINE_PER_CPU(bool, hardirq_stack_inuse);
-
 static void wrmsrl_cstar(unsigned long val)
 {
 	/*
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -37,7 +37,7 @@ const char *stack_type_name(enum stack_t
 
 static bool in_hardirq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *begin = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
+	unsigned long *begin = (unsigned long *)this_cpu_read(pcpu_hot.hardirq_stack_ptr);
 	unsigned long *end   = begin + (THREAD_SIZE / sizeof(long));
 
 	/*
@@ -62,7 +62,7 @@ static bool in_hardirq_stack(unsigned lo
 
 static bool in_softirq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *begin = (unsigned long *)this_cpu_read(softirq_stack_ptr);
+	unsigned long *begin = (unsigned long *)this_cpu_read(pcpu_hot.softirq_stack_ptr);
 	unsigned long *end   = begin + (THREAD_SIZE / sizeof(long));
 
 	/*
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -134,7 +134,7 @@ static __always_inline bool in_exception
 
 static __always_inline bool in_irq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *end = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
+	unsigned long *end = (unsigned long *)this_cpu_read(pcpu_hot.hardirq_stack_ptr);
 	unsigned long *begin;
 
 	/*
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -52,9 +52,6 @@ static inline int check_stack_overflow(v
 static inline void print_stack_overflow(void) { }
 #endif
 
-DEFINE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
-DEFINE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
-
 static void call_on_stack(void *func, void *stack)
 {
 	asm volatile("xchgl	%%ebx,%%esp	\n"
@@ -77,7 +74,7 @@ static inline int execute_on_irq_stack(i
 	u32 *isp, *prev_esp, arg1;
 
 	curstk = (struct irq_stack *) current_stack();
-	irqstk = __this_cpu_read(hardirq_stack_ptr);
+	irqstk = __this_cpu_read(pcpu_hot.hardirq_stack_ptr);
 
 	/*
 	 * this is where we switch to the IRQ stack. However, if we are
@@ -115,7 +112,7 @@ int irq_init_percpu_irqstack(unsigned in
 	int node = cpu_to_node(cpu);
 	struct page *ph, *ps;
 
-	if (per_cpu(hardirq_stack_ptr, cpu))
+	if (per_cpu(pcpu_hot.hardirq_stack_ptr, cpu))
 		return 0;
 
 	ph = alloc_pages_node(node, THREADINFO_GFP, THREAD_SIZE_ORDER);
@@ -127,8 +124,8 @@ int irq_init_percpu_irqstack(unsigned in
 		return -ENOMEM;
 	}
 
-	per_cpu(hardirq_stack_ptr, cpu) = page_address(ph);
-	per_cpu(softirq_stack_ptr, cpu) = page_address(ps);
+	per_cpu(pcpu_hot.hardirq_stack_ptr, cpu) = page_address(ph);
+	per_cpu(pcpu_hot.softirq_stack_ptr, cpu) = page_address(ps);
 	return 0;
 }
 
@@ -138,7 +135,7 @@ void do_softirq_own_stack(void)
 	struct irq_stack *irqstk;
 	u32 *isp, *prev_esp;
 
-	irqstk = __this_cpu_read(softirq_stack_ptr);
+	irqstk = __this_cpu_read(pcpu_hot.softirq_stack_ptr);
 
 	/* build the stack frame on the softirq stack */
 	isp = (u32 *) ((char *)irqstk + sizeof(*irqstk));
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -50,7 +50,7 @@ static int map_irq_stack(unsigned int cp
 		return -ENOMEM;
 
 	/* Store actual TOS to avoid adjustment in the hotpath */
-	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
+	per_cpu(pcpu_hot.hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
 	return 0;
 }
 #else
@@ -63,14 +63,14 @@ static int map_irq_stack(unsigned int cp
 	void *va = per_cpu_ptr(&irq_stack_backing_store, cpu);
 
 	/* Store actual TOS to avoid adjustment in the hotpath */
-	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
+	per_cpu(pcpu_hot.hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
 	return 0;
 }
 #endif
 
 int irq_init_percpu_irqstack(unsigned int cpu)
 {
-	if (per_cpu(hardirq_stack_ptr, cpu))
+	if (per_cpu(pcpu_hot.hardirq_stack_ptr, cpu))
 		return 0;
 	return map_irq_stack(cpu);
 }
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -562,7 +562,7 @@ void compat_start_thread(struct pt_regs
 	int cpu = smp_processor_id();
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
-		     this_cpu_read(hardirq_stack_inuse));
+		     this_cpu_read(pcpu_hot.hardirq_stack_inuse));
 
 	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
 		switch_fpu_prepare(prev_fpu, cpu);



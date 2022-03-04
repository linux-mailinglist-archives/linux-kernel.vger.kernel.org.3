Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E4E4CDB28
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbiCDRns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbiCDRmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:42:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5511C1B8CB8;
        Fri,  4 Mar 2022 09:42:01 -0800 (PST)
Date:   Fri, 4 Mar 2022 18:41:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646415719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=IJN47LYS6K2ly1vV+nQxQ2KFTJvNb96YSYZ4wW4jxds=;
        b=OhiLvodqbIOM7JoX/cUEUA6GnE0js3EiUjZXSXf7+I3BYHZgIXUofJgpesGWbl1d9oN6o9
        vuKE4/FWa876n75WmHHuctncpEyA3qvDUDl9xwXmsEGzhBNNdA27Fsm4teGjVJsNsYbyqU
        d/ZJzTTPcGjilF6PeTDEfG1Szi5kmmSw074X8hxAHTRURCcb3pKfjPMtfcMfInZ0XgimjA
        fyCeMJ1AERJXVOaEp6rZCugmsx5jMuLBOgDa9DWdMmuFLADIVq/a5yDk6nipu7f5WJqKg7
        kl9UHAZPoyA0uC0PhloPCblAhhYwBfGxtYr1jwZL9N/ceS3uaQuDDbfJCCWLUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646415719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=IJN47LYS6K2ly1vV+nQxQ2KFTJvNb96YSYZ4wW4jxds=;
        b=hPn8BfuAnY3AIOlG295kxD5Cg/yL1TmE9O5ukUIjswbW97C2OiLHdFuLvfg8/HwuoPb1o6
        SWTd17fdRJ2BbKDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.17-rc6-rt11
Message-ID: <YiJPZt4a95l1VolR@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.17-rc6-rt11 patch set. 

Changes since v5.17-rc6-rt10:

  - Update the delayed signal patch for x86. The functionality is
    unchanged. Update by Thomas Gleixner.

  - Delay the fast init of the random pool to a worker. This was
    accidentally removed from the last release. Upstream has a slightly
    different solution for that but has too many dependency for a
    backport.

  - Drop the special handling of preempt_enable_no_resched() on
    PREEMPT_RT. There are almost no users left so it is not worth the
    trouble.

  - Update the "ptrace: fix ptrace vs tasklist_lock race" patch. The
    functionality is unchanged.

  - Don't delay the RCU selftest at boot and try a different approach.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.17-rc6-rt10 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/incr/patch-5.17-rc6-rt10-rt11.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.17-rc6-rt11

The RT patch against v5.17-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/older/patch-5.17-rc6-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/older/patches-5.17-rc6-rt11.tar.xz

Sebastian

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index aec70a41a42bc..2983b150305e3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -97,6 +97,7 @@ config ARM64
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_NO_INSTR
+	select ARCH_WANTS_RT_DELAYED_SIGNALS
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
diff --git a/arch/arm64/include/asm/signal.h b/arch/arm64/include/asm/signal.h
index 5e535c3e49260..ef449f5f4ba80 100644
--- a/arch/arm64/include/asm/signal.h
+++ b/arch/arm64/include/asm/signal.h
@@ -22,8 +22,4 @@ static inline void __user *arch_untagged_si_addr(void __user *addr,
 }
 #define arch_untagged_si_addr arch_untagged_si_addr
 
-#if defined(CONFIG_PREEMPT_RT)
-#define ARCH_RT_DELAYS_SIGNAL_SEND
-#endif
-
 #endif
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 3c0abbe904268..5f02f2e12cfd6 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -928,7 +928,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
 		} else {
 			local_daif_restore(DAIF_PROCCTX);
 
-#ifdef ARCH_RT_DELAYS_SIGNAL_SEND
+#ifdef CONFIG_RT_DELAYED_SIGNALS
 			if (unlikely(current->forced_info.si_signo)) {
 				struct task_struct *t = current;
 				force_sig_info(&t->forced_info);
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 587aa9de2ba8f..6699c030bd225 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -121,6 +121,7 @@ config X86
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANT_HUGE_PMD_SHARE
 	select ARCH_WANT_LD_ORPHAN_WARN
+	select ARCH_WANTS_RT_DELAYED_SIGNALS
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index fc03f4f7ed84c..2dfb5fea13aff 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -28,19 +28,6 @@ typedef struct {
 #define SA_IA32_ABI	0x02000000u
 #define SA_X32_ABI	0x01000000u
 
-/*
- * Because some traps use the IST stack, we must keep preemption
- * disabled while calling do_trap(), but do_trap() may call
- * force_sig_info() which will grab the signal spin_locks for the
- * task, which in PREEMPT_RT are mutexes.  By defining
- * ARCH_RT_DELAYS_SIGNAL_SEND the force_sig_info() will set
- * TIF_NOTIFY_RESUME and set up the signal to be sent on exit of the
- * trap.
- */
-#if defined(CONFIG_PREEMPT_RT)
-#define ARCH_RT_DELAYS_SIGNAL_SEND
-#endif
-
 #ifndef CONFIG_COMPAT
 #define compat_sigset_t compat_sigset_t
 typedef sigset_t compat_sigset_t;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 82ee3ed8099dd..9aa4f3412e010 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -707,8 +707,7 @@ static size_t crng_fast_load(const u8 *cp, size_t len)
 	u8 *p;
 	size_t ret = 0;
 
-	if (!spin_trylock_irqsave(&primary_crng.lock, flags))
-		return 0;
+	spin_lock_irqsave(&primary_crng.lock, flags);
 	if (crng_init != 0) {
 		spin_unlock_irqrestore(&primary_crng.lock, flags);
 		return 0;
@@ -1086,6 +1085,19 @@ static void mix_interrupt_randomness(struct work_struct *work)
 	fast_pool->last = jiffies;
 	local_irq_enable();
 
+	if (unlikely(crng_init == 0)) {
+		size_t ret;
+
+		ret = crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool));
+		if (ret) {
+			local_irq_disable();
+			WRITE_ONCE(fast_pool->count, 0);
+			fast_pool->last = jiffies;
+			local_irq_enable();
+			return;
+		}
+	}
+
 	mix_pool_bytes(pool, sizeof(pool));
 	credit_entropy_bits(1);
 	memzero_explicit(pool, sizeof(pool));
@@ -1119,11 +1131,18 @@ void add_interrupt_randomness(int irq)
 	add_interrupt_bench(cycles);
 
 	if (unlikely(crng_init == 0)) {
-		if ((new_count >= 64) &&
-		    crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
-			fast_pool->count = 0;
-			fast_pool->last = now;
-		}
+		if (new_count & MIX_INFLIGHT)
+			return;
+
+		if (new_count < 64)
+			return;
+
+		if (unlikely(!fast_pool->mix.func))
+			INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
+
+		fast_pool->count |= MIX_INFLIGHT;
+		queue_work_on(raw_smp_processor_id(), system_highpri_wq, &fast_pool->mix);
+
 		return;
 	}
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index db4a23d07a571..e286e6b6fdf9b 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -600,6 +600,7 @@ asmlinkage void __do_softirq(void);
 
 extern void open_softirq(int nr, void (*action)(struct softirq_action *));
 extern void softirq_init(void);
+extern void softirq_spawn_ksoftirqd(void);
 extern void __raise_softirq_irqoff(unsigned int nr);
 
 extern void raise_softirq_irqoff(unsigned int nr);
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index c05c5247986f7..c3cb3fcbee8c3 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -230,11 +230,11 @@ do { \
 	preempt_count_dec(); \
 } while (0)
 
+#define preempt_enable_no_resched() sched_preempt_enable_no_resched()
+
 #ifndef CONFIG_PREEMPT_RT
-# define preempt_enable_no_resched() sched_preempt_enable_no_resched()
 # define preempt_check_resched_rt() barrier();
 #else
-# define preempt_enable_no_resched() preempt_enable()
 # define preempt_check_resched_rt() preempt_check_resched()
 #endif
 
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 8b3874d68a174..88b42eb464068 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -95,13 +95,6 @@ void rcu_init_tasks_generic(void);
 static inline void rcu_init_tasks_generic(void) { }
 #endif
 
-#if defined(CONFIG_PROVE_RCU) && defined(CONFIG_TASKS_RCU_GENERIC)
-void rcu_tasks_initiate_self_tests(void);
-#else
-static inline void rcu_tasks_initiate_self_tests(void) {}
-#endif
-
-
 #ifdef CONFIG_RCU_STALL_COMMON
 void rcu_sysrq_start(void);
 void rcu_sysrq_end(void);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 99807ada20a6e..3df4ab414f1ad 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1083,8 +1083,8 @@ struct task_struct {
 	/* Restored if set_restore_sigmask() was used: */
 	sigset_t			saved_sigmask;
 	struct sigpending		pending;
-#ifdef CONFIG_PREEMPT_RT
-	struct				kernel_siginfo forced_info;
+#ifdef CONFIG_RT_DELAYED_SIGNALS
+	struct kernel_siginfo		forced_info;
 #endif
 	unsigned long			sas_ss_sp;
 	size_t				sas_ss_size;
@@ -2043,78 +2043,126 @@ static inline int need_resched_now(void)
 #endif
 
 #ifdef CONFIG_PREEMPT_RT
-static inline bool task_match_saved_state(struct task_struct *p, long match_state)
-{
-	return p->saved_state == match_state;
-}
 
-static inline bool task_is_traced(struct task_struct *task)
+static inline bool task_state_match_and(struct task_struct *tsk, long state)
 {
-	bool traced = false;
-
-	/* in case the task is sleeping on tasklist_lock */
-	raw_spin_lock_irq(&task->pi_lock);
-	if (READ_ONCE(task->__state) & __TASK_TRACED)
-		traced = true;
-	else if (task->saved_state & __TASK_TRACED)
-		traced = true;
-	raw_spin_unlock_irq(&task->pi_lock);
-	return traced;
-}
-
-static inline bool task_is_stopped_or_traced(struct task_struct *task)
-{
-	bool traced_stopped = false;
 	unsigned long flags;
+	bool match = false;
 
-	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
+	if (READ_ONCE(tsk->__state) & state)
+		match = true;
+	else if (tsk->saved_state & state)
+		match = true;
+	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
+	return match;
+}
 
-	if (READ_ONCE(task->__state) & (__TASK_STOPPED | __TASK_TRACED))
-		traced_stopped = true;
-	else if (task->saved_state & (__TASK_STOPPED | __TASK_TRACED))
-		traced_stopped = true;
+static inline bool __task_state_match_eq(struct task_struct *tsk, long state)
+{
+	bool match = false;
 
-	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
-	return traced_stopped;
+	if (READ_ONCE(tsk->__state) == state)
+		match = true;
+	else if (tsk->saved_state == state)
+		match = true;
+	return match;
+}
+
+static inline bool task_state_match_eq(struct task_struct *tsk, long state)
+{
+	unsigned long flags;
+	bool match;
+
+	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
+	match = __task_state_match_eq(tsk, state);
+	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
+	return match;
+}
+
+static inline bool task_state_match_and_set(struct task_struct *tsk, long state,
+					    long new_state)
+{
+	unsigned long flags;
+	bool match = false;
+
+	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
+	if (READ_ONCE(tsk->__state) & state) {
+		WRITE_ONCE(tsk->__state, new_state);
+		match = true;
+	} else if (tsk->saved_state & state) {
+		tsk->__state = new_state;
+		match = true;
+	}
+	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
+	return match;
+}
+
+static inline bool task_state_match_eq_set(struct task_struct *tsk, long state,
+					   long new_state)
+{
+	unsigned long flags;
+	bool match = false;
+
+	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
+	if (READ_ONCE(tsk->__state) == state) {
+		WRITE_ONCE(tsk->__state, new_state);
+		match = true;
+	} else if (tsk->saved_state == state) {
+		tsk->saved_state = new_state;
+		match = true;
+	}
+	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
+	return match;
 }
 
 #else
 
-static inline bool task_match_saved_state(struct task_struct *p, long match_state)
+static inline bool task_state_match_and(struct task_struct *tsk, long state)
 {
+	return READ_ONCE(tsk->__state) & state;
+}
+
+static inline bool __task_state_match_eq(struct task_struct *tsk, long state)
+{
+	return READ_ONCE(tsk->__state) == state;
+}
+
+static inline bool task_state_match_eq(struct task_struct *tsk, long state)
+{
+	return __task_state_match_eq(tsk, state);
+}
+
+static inline bool task_state_match_and_set(struct task_struct *tsk, long state,
+					    long new_state)
+{
+	if (READ_ONCE(tsk->__state) & state) {
+		WRITE_ONCE(tsk->__state, new_state);
+		return true;
+	}
 	return false;
 }
 
-static inline bool task_is_traced(struct task_struct *task)
+static inline bool task_state_match_eq_set(struct task_struct *tsk, long state,
+					   long new_state)
 {
-	return READ_ONCE(task->__state) & __TASK_TRACED;
+	if (READ_ONCE(tsk->__state) == state) {
+		WRITE_ONCE(tsk->__state, new_state);
+		return true;
+	}
+	return false;
 }
 
-static inline bool task_is_stopped_or_traced(struct task_struct *task)
-{
-	return READ_ONCE(task->__state) & (__TASK_STOPPED | __TASK_TRACED);
-}
 #endif
 
-static inline bool task_match_state_or_saved(struct task_struct *p,
-					     long match_state)
+static inline bool task_is_traced(struct task_struct *tsk)
 {
-	if (READ_ONCE(p->__state) == match_state)
-		return true;
-
-	return task_match_saved_state(p, match_state);
+	return task_state_match_and(tsk, __TASK_TRACED);
 }
 
-static inline bool task_match_state_lock(struct task_struct *p,
-					 long match_state)
+static inline bool task_is_stopped_or_traced(struct task_struct *tsk)
 {
-	bool match;
-
-	raw_spin_lock_irq(&p->pi_lock);
-	match = task_match_state_or_saved(p, match_state);
-	raw_spin_unlock_irq(&p->pi_lock);
-
-	return match;
+	return task_state_match_and(tsk, __TASK_STOPPED | __TASK_TRACED);
 }
 
 /*
diff --git a/init/main.c b/init/main.c
index cfc45e47b9ca4..a0014b8bae203 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1598,9 +1598,9 @@ static noinline void __init kernel_init_freeable(void)
 
 	init_mm_internals();
 
+	softirq_spawn_ksoftirqd();
 	rcu_init_tasks_generic();
 	do_pre_smp_initcalls();
-	rcu_tasks_initiate_self_tests();
 	lockup_detector_init();
 
 	smp_init();
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 5d3e650cdf489..e85d8527d4b3d 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -138,4 +138,14 @@ config SCHED_CORE
 	  which is the likely usage by Linux distributions, there should
 	  be no measurable impact on performance.
 
+config ARCH_WANTS_RT_DELAYED_SIGNALS
+	bool
+	help
+	  This option is selected by architectures where raising signals
+	  can happen in atomic contexts on PREEMPT_RT enabled kernels. This
+	  option delays raising the signal until the return to user space
+	  loop where it is also delivered. X86 requires this to deliver
+	  signals from trap handlers which run on IST stacks.
 
+config RT_DELAYED_SIGNALS
+	def_bool PREEMPT_RT && ARCH_WANTS_RT_DELAYED_SIGNALS
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 93ad647f4a220..8236b2c78b48f 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -148,6 +148,18 @@ static void handle_signal_work(struct pt_regs *regs, unsigned long ti_work)
 	arch_do_signal_or_restart(regs, ti_work & _TIF_SIGPENDING);
 }
 
+#ifdef CONFIG_RT_DELAYED_SIGNALS
+static inline void raise_delayed_signal(void)
+{
+	if (unlikely(current->forced_info.si_signo)) {
+		force_sig_info(&current->forced_info);
+		current->forced_info.si_signo = 0;
+	}
+}
+#else
+static inline void raise_delayed_signal(void) { }
+#endif
+
 static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 					    unsigned long ti_work)
 {
@@ -162,13 +174,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		if (ti_work & _TIF_NEED_RESCHED_MASK)
 			schedule();
 
-#ifdef ARCH_RT_DELAYS_SIGNAL_SEND
-		if (unlikely(current->forced_info.si_signo)) {
-			struct task_struct *t = current;
-			force_sig_info(&t->forced_info);
-			t->forced_info.si_signo = 0;
-		}
-#endif
+		raise_delayed_signal();
 
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index c0d05fe027cf0..5ce0948c0c0a7 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -195,21 +195,10 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 		return ret;
 
 	spin_lock_irq(&task->sighand->siglock);
-	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
-	    !__fatal_signal_pending(task)) {
-#ifdef CONFIG_PREEMPT_RT
-		unsigned long flags;
+	if (!looks_like_a_spurious_pid(task) && !__fatal_signal_pending(task)) {
 
-		raw_spin_lock_irqsave(&task->pi_lock, flags);
-		if (READ_ONCE(task->__state) & __TASK_TRACED)
-			WRITE_ONCE(task->__state, __TASK_TRACED);
-		else
-			task->saved_state = __TASK_TRACED;
-		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
-#else
-		WRITE_ONCE(task->__state, __TASK_TRACED);
-#endif
-		ret = true;
+		ret = task_state_match_and_set(task, __TASK_TRACED,
+					       __TASK_TRACED);
 	}
 	spin_unlock_irq(&task->sighand->siglock);
 
@@ -218,8 +207,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	unsigned long flags;
-	bool frozen = true;
+	bool frozen;
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
 	    READ_ONCE(task->__state) != __TASK_TRACED)
@@ -232,17 +220,8 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	 * Recheck state under the lock to close this race.
 	 */
 	spin_lock_irq(&task->sighand->siglock);
-	raw_spin_lock_irqsave(&task->pi_lock, flags);
-	if (READ_ONCE(task->__state) == __TASK_TRACED)
-		WRITE_ONCE(task->__state, TASK_TRACED);
 
-#ifdef CONFIG_PREEMPT_RT
-	else if (task->saved_state == __TASK_TRACED)
-		task->saved_state = TASK_TRACED;
-#endif
-	else
-		frozen = false;
-	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+	frozen = task_state_match_eq_set(task, __TASK_TRACED, TASK_TRACED);
 
 	if (frozen && __fatal_signal_pending(task))
 		wake_up_state(task, __TASK_TRACED);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d3476223c2471..f804afb304135 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -46,7 +46,7 @@ struct rcu_tasks_percpu {
 
 /**
  * struct rcu_tasks - Definition for a Tasks-RCU-like mechanism.
- * @cbs_wq: Wait queue allowing new callback to get kthread's attention.
+ * @cbs_wait: RCU wait allowing a new callback to get kthread's attention.
  * @cbs_gbl_lock: Lock protecting callback list.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
@@ -77,7 +77,7 @@ struct rcu_tasks_percpu {
  * @kname: This flavor's kthread name.
  */
 struct rcu_tasks {
-	struct wait_queue_head cbs_wq;
+	struct rcuwait cbs_wait;
 	raw_spinlock_t cbs_gbl_lock;
 	int gp_state;
 	int gp_sleep;
@@ -113,11 +113,11 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
 #define DEFINE_RCU_TASKS(rt_name, gp, call, n)						\
 static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
 	.lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ## __percpu.cbs_pcpu_lock),		\
-	.rtp_irq_work = IRQ_WORK_INIT(call_rcu_tasks_iw_wakeup),			\
+	.rtp_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),			\
 };											\
 static struct rcu_tasks rt_name =							\
 {											\
-	.cbs_wq = __WAIT_QUEUE_HEAD_INITIALIZER(rt_name.cbs_wq),			\
+	.cbs_wait = __RCUWAIT_INITIALIZER(rt_name.wait),				\
 	.cbs_gbl_lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name.cbs_gbl_lock),			\
 	.gp_func = gp,									\
 	.call_func = call,								\
@@ -261,7 +261,7 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
 	struct rcu_tasks_percpu *rtpcp = container_of(iwp, struct rcu_tasks_percpu, rtp_irq_work);
 
 	rtp = rtpcp->rtpp;
-	wake_up(&rtp->cbs_wq);
+	rcuwait_wake_up(&rtp->cbs_wait);
 }
 
 // Enqueue a callback for the specified flavor of Tasks RCU.
@@ -509,7 +509,9 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 
 		/* If there were none, wait a bit and start over. */
-		wait_event_idle(rtp->cbs_wq, (needgpcb = rcu_tasks_need_gpcb(rtp)));
+		rcuwait_wait_event(&rtp->cbs_wait,
+				   (needgpcb = rcu_tasks_need_gpcb(rtp)),
+				   TASK_IDLE);
 
 		if (needgpcb & 0x2) {
 			// Wait for one grace period.
@@ -1661,7 +1663,7 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
 	rttd->notrun = true;
 }
 
-void rcu_tasks_initiate_self_tests(void)
+static void rcu_tasks_initiate_self_tests(void)
 {
 	pr_info("Running RCU-tasks wait API self tests\n");
 #ifdef CONFIG_TASKS_RCU
@@ -1698,7 +1700,9 @@ static int rcu_tasks_verify_self_tests(void)
 	return ret;
 }
 late_initcall(rcu_tasks_verify_self_tests);
-#endif /* #ifdef CONFIG_PROVE_RCU */
+#else /* #ifdef CONFIG_PROVE_RCU */
+static void rcu_tasks_initiate_self_tests(void) { }
+#endif /* #else #ifdef CONFIG_PROVE_RCU */
 
 void __init rcu_init_tasks_generic(void)
 {
@@ -1713,6 +1717,9 @@ void __init rcu_init_tasks_generic(void)
 #ifdef CONFIG_TASKS_TRACE_RCU
 	rcu_spawn_tasks_trace_kthread();
 #endif
+
+	// Run the self-tests.
+	rcu_tasks_initiate_self_tests();
 }
 
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 327a48b14f00a..33ce5cd113d82 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3281,7 +3281,8 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
-			if (match_state && !task_match_state_lock(p, match_state))
+			if (match_state &&
+			    unlikely(!task_state_match_eq(p, match_state)))
 				return 0;
 			cpu_relax();
 		}
@@ -3296,7 +3297,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		running = task_running(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if (!match_state || task_match_state_or_saved(p, match_state))
+		if (!match_state || __task_state_match_eq(p, match_state))
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &rf);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 71e662ebe65c3..933eab153f042 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1307,6 +1307,43 @@ enum sig_handler {
 	HANDLER_EXIT,	 /* Only visible as the process exit code */
 };
 
+/*
+ * On some archictectures, PREEMPT_RT has to delay sending a signal from a
+ * trap since it cannot enable preemption, and the signal code's
+ * spin_locks turn into mutexes. Instead, it must set TIF_NOTIFY_RESUME
+ * which will send the signal on exit of the trap.
+ */
+#ifdef CONFIG_RT_DELAYED_SIGNALS
+static inline bool force_sig_delayed(struct kernel_siginfo *info,
+				     struct task_struct *t)
+{
+	if (!in_atomic())
+		return false;
+
+	if (WARN_ON_ONCE(t->forced_info.si_signo))
+		return true;
+
+	if (is_si_special(info)) {
+		WARN_ON_ONCE(info != SEND_SIG_PRIV);
+		t->forced_info.si_signo = info->si_signo;
+		t->forced_info.si_errno = 0;
+		t->forced_info.si_code = SI_KERNEL;
+		t->forced_info.si_pid = 0;
+		t->forced_info.si_uid = 0;
+	} else {
+		t->forced_info = *info;
+	}
+	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+	return true;
+}
+#else
+static inline bool force_sig_delayed(struct kernel_siginfo *info,
+				     struct task_struct *t)
+{
+	return false;
+}
+#endif
+
 /*
  * Force a signal that the process can't ignore: if necessary
  * we unblock the signal and change any SIG_IGN to SIG_DFL.
@@ -1327,34 +1364,9 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
 	struct k_sigaction *action;
 	int sig = info->si_signo;
 
-	/*
-	 * On some archs, PREEMPT_RT has to delay sending a signal from a trap
-	 * since it can not enable preemption, and the signal code's spin_locks
-	 * turn into mutexes. Instead, it must set TIF_NOTIFY_RESUME which will
-	 * send the signal on exit of the trap.
-	 */
-#ifdef ARCH_RT_DELAYS_SIGNAL_SEND
-	if (in_atomic()) {
-		struct task_struct *t = current;
-
-		if (WARN_ON_ONCE(t->forced_info.si_signo))
-			return 0;
-
-		if (is_si_special(info)) {
-			WARN_ON_ONCE(info != SEND_SIG_PRIV);
-			t->forced_info.si_signo = info->si_signo;
-			t->forced_info.si_errno = 0;
-			t->forced_info.si_code = SI_KERNEL;
-			t->forced_info.si_pid = 0;
-			t->forced_info.si_uid = 0;
-		} else {
-			t->forced_info = *info;
-		}
-
-		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+	if (force_sig_delayed(info, t))
 		return 0;
-	}
-#endif
+
 	spin_lock_irqsave(&t->sighand->siglock, flags);
 	action = &t->sighand->action[sig-1];
 	ignored = action->sa.sa_handler == SIG_IGN;
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 22948c2109f5b..32c1c503b9d65 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -1037,17 +1037,14 @@ static struct smp_hotplug_thread timer_threads = {
         .thread_comm            = "ktimers/%u",
 };
 
-static __init int spawn_ksoftirqd(void)
+__init void softirq_spawn_ksoftirqd(void)
 {
 	cpuhp_setup_state_nocalls(CPUHP_SOFTIRQ_DEAD, "softirq:dead", NULL,
 				  takeover_tasklets);
 	BUG_ON(smpboot_register_percpu_thread(&softirq_threads));
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		BUG_ON(smpboot_register_percpu_thread(&timer_threads));
-
-	return 0;
 }
-early_initcall(spawn_ksoftirqd);
 
 /*
  * [ These __weak aliases are kept in a separate compilation unit, so that
diff --git a/localversion-rt b/localversion-rt
index d79dde624aaac..05c35cb580779 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt10
+-rt11

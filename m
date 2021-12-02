Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C141A465A95
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354268AbhLBAWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:22:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55546 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344287AbhLBAWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:22:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 727BBB8219A;
        Thu,  2 Dec 2021 00:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FD4C53FD0;
        Thu,  2 Dec 2021 00:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404347;
        bh=i0ByPPO0mi/klz7yydQpYmm6+LV3Zv65SMiV6Bg/mfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RyX4VWXNix6TNmqgu0eLglVOVFlYlV5++juLpuAGzxhFnjIqjay5EKIjHbNx91CqU
         Y0RmP5xCk0dQX15ItAUPEz4RSLYxlZj3J5BNAu6vvM/iTnFIlZ6QmmjMWTArdNfJKn
         j23IGFEPKiFUDbo5kJKE06DLxirxIxoj09FyzAJhwjF0L2vp4mE8264dojNc0eoPBw
         OIlw2l7XFqfYXMcX3LBKbZzXCRRHYMV10IxoS/UL5z9abJnxQxc4YgHbr4QzSPmqVJ
         pKnWUOmI+GSF1b7MAmA6X5vCO+6eexbVPq7Ckl0zjoITYEvsG3qSmzmdrhVi1RDmtS
         sG8UCIgINc/8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C78F35C1109; Wed,  1 Dec 2021 16:19:06 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/4] rcu: Remove the RCU_FAST_NO_HZ Kconfig option
Date:   Wed,  1 Dec 2021 16:19:03 -0800
Message-Id: <20211202001904.3126929-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202001838.GA3126627@paulmck-ThinkPad-P17-Gen-1>
References: <20211202001838.GA3126627@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the uses of CONFIG_RCU_FAST_NO_HZ=y that I have seen involve
systems with RCU callbacks offloaded.  In this situation, all that this
Kconfig option does is slow down idle entry/exit with an additional
allways-taken early exit.  If this is the only use case, then this
Kconfig option nothing but an attractive nuisance that needs to go away.

This commit therefore removes the RCU_FAST_NO_HZ Kconfig option.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/stallwarn.rst               |  11 --
 .../admin-guide/kernel-parameters.txt         |   4 -
 Documentation/timers/no_hz.rst                |  10 +-
 kernel/rcu/Kconfig                            |  18 --
 kernel/rcu/tree.c                             |  11 --
 kernel/rcu/tree.h                             |   7 -
 kernel/rcu/tree_plugin.h                      | 185 +-----------------
 kernel/rcu/tree_stall.h                       |  27 +--
 .../selftests/rcutorture/configs/rcu/TREE01   |   1 -
 .../selftests/rcutorture/configs/rcu/TREE04   |   1 -
 .../rcutorture/doc/TREE_RCU-kconfig.txt       |   1 -
 11 files changed, 7 insertions(+), 269 deletions(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index 28f8ad16db250..78404625bad26 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -254,17 +254,6 @@ period (in this case 2603), the grace-period sequence number (7075), and
 an estimate of the total number of RCU callbacks queued across all CPUs
 (625 in this case).
 
-In kernels with CONFIG_RCU_FAST_NO_HZ, more information is printed
-for each CPU::
-
-	0: (64628 ticks this GP) idle=dd5/3fffffffffffffff/0 softirq=82/543 last_accelerate: a345/d342 dyntick_enabled: 1
-
-The "last_accelerate:" prints the low-order 16 bits (in hex) of the
-jiffies counter when this CPU last invoked rcu_try_advance_all_cbs()
-from rcu_needs_cpu() or last invoked rcu_accelerate_cbs() from
-rcu_prepare_for_idle(). "dyntick_enabled: 1" indicates that dyntick-idle
-processing is enabled.
-
 If the grace period ends just as the stall warning starts printing,
 there will be a spurious stall-warning message, which will include
 the following::
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9725c546a0d46..36b83a47e54a6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4489,10 +4489,6 @@
 			on rcutree.qhimark at boot time and to zero to
 			disable more aggressive help enlistment.
 
-	rcutree.rcu_idle_gp_delay= [KNL]
-			Set wakeup interval for idle CPUs that have
-			RCU callbacks (RCU_FAST_NO_HZ=y).
-
 	rcutree.rcu_kick_kthreads= [KNL]
 			Cause the grace-period kthread to get an extra
 			wake_up() if it sleeps three times longer than
diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
index 20ad23a6c618e..f8786be15183c 100644
--- a/Documentation/timers/no_hz.rst
+++ b/Documentation/timers/no_hz.rst
@@ -184,16 +184,12 @@ There are situations in which idle CPUs cannot be permitted to
 enter either dyntick-idle mode or adaptive-tick mode, the most
 common being when that CPU has RCU callbacks pending.
 
-The CONFIG_RCU_FAST_NO_HZ=y Kconfig option may be used to cause such CPUs
-to enter dyntick-idle mode or adaptive-tick mode anyway.  In this case,
-a timer will awaken these CPUs every four jiffies in order to ensure
-that the RCU callbacks are processed in a timely fashion.
-
-Another approach is to offload RCU callback processing to "rcuo" kthreads
+Avoid this by offloading RCU callback processing to "rcuo" kthreads
 using the CONFIG_RCU_NOCB_CPU=y Kconfig option.  The specific CPUs to
 offload may be selected using The "rcu_nocbs=" kernel boot parameter,
 which takes a comma-separated list of CPUs and CPU ranges, for example,
-"1,3-5" selects CPUs 1, 3, 4, and 5.
+"1,3-5" selects CPUs 1, 3, 4, and 5.  Note that CPUs specified by
+the "nohz_full" kernel boot parameter are also offloaded.
 
 The offloaded CPUs will never queue RCU callbacks, and therefore RCU
 never prevents offloaded CPUs from entering either dyntick-idle mode
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 3128b7cf8e1fd..4005f2728f1a6 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -169,24 +169,6 @@ config RCU_FANOUT_LEAF
 
 	  Take the default if unsure.
 
-config RCU_FAST_NO_HZ
-	bool "Accelerate last non-dyntick-idle CPU's grace periods"
-	depends on NO_HZ_COMMON && SMP && RCU_EXPERT
-	default n
-	help
-	  This option permits CPUs to enter dynticks-idle state even if
-	  they have RCU callbacks queued, and prevents RCU from waking
-	  these CPUs up more than roughly once every four jiffies (by
-	  default, you can adjust this using the rcutree.rcu_idle_gp_delay
-	  parameter), thus improving energy efficiency.  On the other
-	  hand, this option increases the duration of RCU grace periods,
-	  for example, slowing down synchronize_rcu().
-
-	  Say Y if energy efficiency is critically important, and you
-	  	don't care about increased grace-period durations.
-
-	  Say N if you are unsure.
-
 config RCU_BOOST
 	bool "Enable RCU priority boosting"
 	depends on (RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT) || PREEMPT_RT
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ef8d36f580fc3..5e98257c2910e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -624,7 +624,6 @@ static noinstr void rcu_eqs_enter(bool user)
 	instrumentation_begin();
 	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
-	rcu_prepare_for_idle();
 	rcu_preempt_deferred_qs(current);
 
 	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
@@ -768,9 +767,6 @@ noinstr void rcu_nmi_exit(void)
 	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
-	if (!in_nmi())
-		rcu_prepare_for_idle();
-
 	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
 	instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
 	instrumentation_end();
@@ -872,7 +868,6 @@ static void noinstr rcu_eqs_exit(bool user)
 	// instrumentation for the noinstr rcu_dynticks_eqs_exit()
 	instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
 
-	rcu_cleanup_after_idle();
 	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdp->dynticks_nesting, 1);
@@ -1014,12 +1009,6 @@ noinstr void rcu_nmi_enter(void)
 		rcu_dynticks_eqs_exit();
 		// ... but is watching here.
 
-		if (!in_nmi()) {
-			instrumentation_begin();
-			rcu_cleanup_after_idle();
-			instrumentation_end();
-		}
-
 		instrumentation_begin();
 		// instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
 		instrument_atomic_read(&rdp->dynticks, sizeof(rdp->dynticks));
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 305cf6aeb4086..7ca1aa46083cc 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -189,11 +189,6 @@ struct rcu_data {
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
 	bool rcu_forced_tick;		/* Forced tick to provide QS. */
 	bool rcu_forced_tick_exp;	/*   ... provide QS to expedited GP. */
-#ifdef CONFIG_RCU_FAST_NO_HZ
-	unsigned long last_accelerate;	/* Last jiffy CBs were accelerated. */
-	unsigned long last_advance_all;	/* Last jiffy CBs were all advanced. */
-	int tick_nohz_enabled_snap;	/* Previously seen value from sysfs. */
-#endif /* #ifdef CONFIG_RCU_FAST_NO_HZ */
 
 	/* 4) rcu_barrier(), OOM callbacks, and expediting. */
 	struct rcu_head barrier_head;
@@ -419,8 +414,6 @@ static bool rcu_is_callbacks_kthread(void);
 static void rcu_cpu_kthread_setup(unsigned int cpu);
 static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp);
 static void __init rcu_spawn_boost_kthreads(void);
-static void rcu_cleanup_after_idle(void);
-static void rcu_prepare_for_idle(void);
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 static bool rcu_preempt_need_deferred_qs(struct task_struct *t);
 static void rcu_preempt_deferred_qs(struct task_struct *t);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5199559fbbf0c..19f7d578cedb3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -51,8 +51,6 @@ static void __init rcu_bootup_announce_oddness(void)
 			RCU_FANOUT);
 	if (rcu_fanout_exact)
 		pr_info("\tHierarchical RCU autobalancing is disabled.\n");
-	if (IS_ENABLED(CONFIG_RCU_FAST_NO_HZ))
-		pr_info("\tRCU dyntick-idle grace-period acceleration is enabled.\n");
 	if (IS_ENABLED(CONFIG_PROVE_RCU))
 		pr_info("\tRCU lockdep checking is enabled.\n");
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
@@ -1253,16 +1251,14 @@ static void __init rcu_spawn_boost_kthreads(void)
 
 #endif /* #else #ifdef CONFIG_RCU_BOOST */
 
-#if !defined(CONFIG_RCU_FAST_NO_HZ)
-
 /*
  * Check to see if any future non-offloaded RCU-related work will need
  * to be done by the current CPU, even if none need be done immediately,
  * returning 1 if so.  This function is part of the RCU implementation;
  * it is -not- an exported member of the RCU API.
  *
- * Because we not have RCU_FAST_NO_HZ, just check whether or not this
- * CPU has RCU callbacks queued.
+ * Just check whether or not this CPU has non-offloaded RCU callbacks
+ * queued.
  */
 int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 {
@@ -1271,183 +1267,6 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 		!rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
 }
 
-/*
- * Because we do not have RCU_FAST_NO_HZ, don't bother cleaning up
- * after it.
- */
-static void rcu_cleanup_after_idle(void)
-{
-}
-
-/*
- * Do the idle-entry grace-period work, which, because CONFIG_RCU_FAST_NO_HZ=n,
- * is nothing.
- */
-static void rcu_prepare_for_idle(void)
-{
-}
-
-#else /* #if !defined(CONFIG_RCU_FAST_NO_HZ) */
-
-/*
- * This code is invoked when a CPU goes idle, at which point we want
- * to have the CPU do everything required for RCU so that it can enter
- * the energy-efficient dyntick-idle mode.
- *
- * The following preprocessor symbol controls this:
- *
- * RCU_IDLE_GP_DELAY gives the number of jiffies that a CPU is permitted
- *	to sleep in dyntick-idle mode with RCU callbacks pending.  This
- *	is sized to be roughly one RCU grace period.  Those energy-efficiency
- *	benchmarkers who might otherwise be tempted to set this to a large
- *	number, be warned: Setting RCU_IDLE_GP_DELAY too high can hang your
- *	system.  And if you are -that- concerned about energy efficiency,
- *	just power the system down and be done with it!
- *
- * The value below works well in practice.  If future workloads require
- * adjustment, they can be converted into kernel config parameters, though
- * making the state machine smarter might be a better option.
- */
-#define RCU_IDLE_GP_DELAY 4		/* Roughly one grace period. */
-
-static int rcu_idle_gp_delay = RCU_IDLE_GP_DELAY;
-module_param(rcu_idle_gp_delay, int, 0644);
-
-/*
- * Try to advance callbacks on the current CPU, but only if it has been
- * awhile since the last time we did so.  Afterwards, if there are any
- * callbacks ready for immediate invocation, return true.
- */
-static bool __maybe_unused rcu_try_advance_all_cbs(void)
-{
-	bool cbs_ready = false;
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	struct rcu_node *rnp;
-
-	/* Exit early if we advanced recently. */
-	if (jiffies == rdp->last_advance_all)
-		return false;
-	rdp->last_advance_all = jiffies;
-
-	rnp = rdp->mynode;
-
-	/*
-	 * Don't bother checking unless a grace period has
-	 * completed since we last checked and there are
-	 * callbacks not yet ready to invoke.
-	 */
-	if ((rcu_seq_completed_gp(rdp->gp_seq,
-				  rcu_seq_current(&rnp->gp_seq)) ||
-	     unlikely(READ_ONCE(rdp->gpwrap))) &&
-	    rcu_segcblist_pend_cbs(&rdp->cblist))
-		note_gp_changes(rdp);
-
-	if (rcu_segcblist_ready_cbs(&rdp->cblist))
-		cbs_ready = true;
-	return cbs_ready;
-}
-
-/*
- * Allow the CPU to enter dyntick-idle mode unless it has callbacks ready
- * to invoke.  If the CPU has callbacks, try to advance them.  Tell the
- * caller about what to set the timeout.
- *
- * The caller must have disabled interrupts.
- */
-int rcu_needs_cpu(u64 basemono, u64 *nextevt)
-{
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	unsigned long dj;
-
-	lockdep_assert_irqs_disabled();
-
-	/* If no non-offloaded callbacks, RCU doesn't need the CPU. */
-	if (rcu_segcblist_empty(&rdp->cblist) ||
-	    rcu_rdp_is_offloaded(rdp)) {
-		*nextevt = KTIME_MAX;
-		return 0;
-	}
-
-	/* Attempt to advance callbacks. */
-	if (rcu_try_advance_all_cbs()) {
-		/* Some ready to invoke, so initiate later invocation. */
-		invoke_rcu_core();
-		return 1;
-	}
-	rdp->last_accelerate = jiffies;
-
-	/* Request timer and round. */
-	dj = round_up(rcu_idle_gp_delay + jiffies, rcu_idle_gp_delay) - jiffies;
-
-	*nextevt = basemono + dj * TICK_NSEC;
-	return 0;
-}
-
-/*
- * Prepare a CPU for idle from an RCU perspective.  The first major task is to
- * sense whether nohz mode has been enabled or disabled via sysfs.  The second
- * major task is to accelerate (that is, assign grace-period numbers to) any
- * recently arrived callbacks.
- *
- * The caller must have disabled interrupts.
- */
-static void rcu_prepare_for_idle(void)
-{
-	bool needwake;
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	struct rcu_node *rnp;
-	int tne;
-
-	lockdep_assert_irqs_disabled();
-	if (rcu_rdp_is_offloaded(rdp))
-		return;
-
-	/* Handle nohz enablement switches conservatively. */
-	tne = READ_ONCE(tick_nohz_active);
-	if (tne != rdp->tick_nohz_enabled_snap) {
-		if (!rcu_segcblist_empty(&rdp->cblist))
-			invoke_rcu_core(); /* force nohz to see update. */
-		rdp->tick_nohz_enabled_snap = tne;
-		return;
-	}
-	if (!tne)
-		return;
-
-	/*
-	 * If we have not yet accelerated this jiffy, accelerate all
-	 * callbacks on this CPU.
-	 */
-	if (rdp->last_accelerate == jiffies)
-		return;
-	rdp->last_accelerate = jiffies;
-	if (rcu_segcblist_pend_cbs(&rdp->cblist)) {
-		rnp = rdp->mynode;
-		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
-		needwake = rcu_accelerate_cbs(rnp, rdp);
-		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
-		if (needwake)
-			rcu_gp_kthread_wake();
-	}
-}
-
-/*
- * Clean up for exit from idle.  Attempt to advance callbacks based on
- * any grace periods that elapsed while the CPU was idle, and if any
- * callbacks are now ready to invoke, initiate invocation.
- */
-static void rcu_cleanup_after_idle(void)
-{
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-
-	lockdep_assert_irqs_disabled();
-	if (rcu_rdp_is_offloaded(rdp))
-		return;
-	if (rcu_try_advance_all_cbs())
-		invoke_rcu_core();
-}
-
-#endif /* #else #if !defined(CONFIG_RCU_FAST_NO_HZ) */
-
 /*
  * Is this CPU a NO_HZ_FULL CPU that should ignore RCU so that the
  * grace-period kthread will do force_quiescent_state() processing?
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5e2fa6fd97f12..21bebf7c9030b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -347,26 +347,6 @@ static void rcu_dump_cpu_stacks(void)
 	}
 }
 
-#ifdef CONFIG_RCU_FAST_NO_HZ
-
-static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
-{
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-
-	sprintf(cp, "last_accelerate: %04lx/%04lx dyntick_enabled: %d",
-		rdp->last_accelerate & 0xffff, jiffies & 0xffff,
-		!!rdp->tick_nohz_enabled_snap);
-}
-
-#else /* #ifdef CONFIG_RCU_FAST_NO_HZ */
-
-static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
-{
-	*cp = '\0';
-}
-
-#endif /* #else #ifdef CONFIG_RCU_FAST_NO_HZ */
-
 static const char * const gp_state_names[] = {
 	[RCU_GP_IDLE] = "RCU_GP_IDLE",
 	[RCU_GP_WAIT_GPS] = "RCU_GP_WAIT_GPS",
@@ -408,13 +388,12 @@ static bool rcu_is_gp_kthread_starving(unsigned long *jp)
  * of RCU grace periods that this CPU is ignorant of, for example, "1"
  * if the CPU was aware of the previous grace period.
  *
- * Also print out idle and (if CONFIG_RCU_FAST_NO_HZ) idle-entry info.
+ * Also print out idle info.
  */
 static void print_cpu_stall_info(int cpu)
 {
 	unsigned long delta;
 	bool falsepositive;
-	char fast_no_hz[72];
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	char *ticks_title;
 	unsigned long ticks_value;
@@ -432,11 +411,10 @@ static void print_cpu_stall_info(int cpu)
 		ticks_title = "ticks this GP";
 		ticks_value = rdp->ticks_this_gp;
 	}
-	print_cpu_stall_fast_no_hz(fast_no_hz, cpu);
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
 			rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
-	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s%s\n",
+	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
 	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
@@ -449,7 +427,6 @@ static void print_cpu_stall_info(int cpu)
 	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
-	       fast_no_hz,
 	       falsepositive ? " (false positive?)" : "");
 }
 
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01 b/tools/testing/selftests/rcutorture/configs/rcu/TREE01
index b5b53973c01e4..8ae41d5f81a3e 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01
@@ -6,7 +6,6 @@ CONFIG_PREEMPT=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=y
 CONFIG_RCU_TRACE=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_MAXSMP=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
index f6d6a40c05768..22ad0261728d0 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
@@ -7,7 +7,6 @@ CONFIG_PREEMPT=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=n
 CONFIG_NO_HZ_FULL=y
-CONFIG_RCU_FAST_NO_HZ=y
 CONFIG_RCU_TRACE=y
 CONFIG_RCU_FANOUT=4
 CONFIG_RCU_FANOUT_LEAF=3
diff --git a/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
index 1b96d68473b8f..42acb1a64ce10 100644
--- a/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
+++ b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
@@ -15,7 +15,6 @@ CONFIG_PROVE_RCU -- Hardwired to CONFIG_PROVE_LOCKING.
 CONFIG_RCU_BOOST -- one of PREEMPT_RCU.
 CONFIG_RCU_FANOUT -- Cover hierarchy, but overlap with others.
 CONFIG_RCU_FANOUT_LEAF -- Do one non-default.
-CONFIG_RCU_FAST_NO_HZ -- Do one, but not with all nohz_full CPUs.
 CONFIG_RCU_NOCB_CPU -- Do three, one with no rcu_nocbs CPUs, one with
 	rcu_nocbs=0, and one with all rcu_nocbs CPUs.
 CONFIG_RCU_TRACE -- Do half.
-- 
2.31.1.189.g2e36527f23


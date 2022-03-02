Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016794CA996
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbiCBPu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241651AbiCBPu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:50:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95C95AEFA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:49:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D3FD61738
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635E9C36AE5;
        Wed,  2 Mar 2022 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646236163;
        bh=Z+gcfayBIvkyDX+8C5q29ZIotRNA7uEePF1v8HDUZGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dThnWHLsi8M2t3evEqDNe4g8mV725xzM5uYP3yg/1Sta2raThHe0I8iamAsQ5DxGn
         tdv2VjRP646x76OkYa4yxLtSHipDzqIwiV+2Lv9kvs+ubf9/Qj1kir/H6PcxvL4T9B
         sNFaa8IjttbSpwHg/V/pXhFlb4p6UR1/H/cA+Dkx2ymd4OFRAjdtdZyU/uNLcWBkbj
         k6ad1FMOtlvXJNBs0X0PEDVB2BpbVq9WIpkkevY4C7NQCQT2Cx1wDIEgu72iNAJHZI
         P/XBHuRdIdlDpek5f6bT0sgS/j4ZLvdhLKJQa2GbA29xqHCNo6paxrFkZF3hdmfBGL
         WsFtkpZQ/Qrfg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 18/19] rcu/context_tracking: Merge dynticks counter and context tracking states
Date:   Wed,  2 Mar 2022 16:48:09 +0100
Message-Id: <20220302154810.42308-19-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302154810.42308-1-frederic@kernel.org>
References: <20220302154810.42308-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updating the context tracking state and the RCU dynticks counter
atomically in a single operation is a first step towards improving CPU
isolation. This makes the context tracking state updates fully ordered
and therefore allow for later enhancements such as postponing some work
while a task is running isolated in userspace until it ever comes back
to the kernel.

The state field becomes divided in two parts:

1) Lower bits for context tracking state:

   	CONTEXT_IDLE = 1,
	CONTEXT_USER = 2,
	CONTEXT_GUEST = 4,

   A value of 0 means we are in CONTEXT_KERNEL.

2) Higher bits for RCU eqs dynticks counting:

    RCU_DYNTICKS_IDX = 8

   The dynticks counting is always incremented by this value.
   (state & RCU_DYNTICKS_IDX) means we are NOT in an extended quiescent
   state. This makes the chance for a collision more likely between two
   RCU dynticks snapshots but wrapping up 24 bits of eqs dynticks
   increments still takes some bad luck (also rdp.dynticks_snap could be
   converted from int to long?)

Some RCU eqs functions have been renamed to better reflect their broader
scope that now include context tracking state.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao<liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
---
 include/linux/context_tracking.h       |  4 +-
 include/linux/context_tracking_state.h | 33 ++++++---
 kernel/context_tracking.c              | 92 +++++++++++++-------------
 kernel/rcu/tree.c                      | 13 ++--
 kernel/rcu/tree_stall.h                |  2 +-
 5 files changed, 81 insertions(+), 63 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 63343c34ab4e..aa0e6fbf6946 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -110,7 +110,7 @@ static inline void context_tracking_init(void) { }
 #ifdef CONFIG_CONTEXT_TRACKING
 extern void ct_idle_enter(void);
 extern void ct_idle_exit(void);
-extern unsigned long rcu_dynticks_inc(int incby);
+extern unsigned long ct_state_inc(int incby);
 
 /*
  * Is the current CPU in an extended quiescent state?
@@ -119,7 +119,7 @@ extern unsigned long rcu_dynticks_inc(int incby);
  */
 static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
-	return !(arch_atomic_read(this_cpu_ptr(&context_tracking.dynticks)) & 0x1);
+	return !(arch_atomic_read(this_cpu_ptr(&context_tracking.state)) & RCU_DYNTICKS_IDX);
 }
 
 #else
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index bca0d3e0bd3d..b8a309532c18 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -9,13 +9,29 @@
 /* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
 #define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
 
+enum {
+	CONTEXT_IDLE_OFFSET = 0,
+	CONTEXT_USER_OFFSET,
+	CONTEXT_GUEST_OFFSET,
+	CONTEXT_MAX_OFFSET,
+};
+
 enum ctx_state {
 	CONTEXT_DISABLED = -1,	/* returned by ct_state() if unknown */
 	CONTEXT_KERNEL = 0,
-	CONTEXT_USER,
-	CONTEXT_GUEST,
+	CONTEXT_IDLE = BIT(CONTEXT_IDLE_OFFSET),
+	CONTEXT_USER = BIT(CONTEXT_USER_OFFSET),
+	CONTEXT_GUEST = BIT(CONTEXT_GUEST_OFFSET),
+	CONTEXT_MAX = BIT(CONTEXT_MAX_OFFSET),
 };
 
+/* Even value for idle, else odd. */
+#define RCU_DYNTICKS_SHIFT CONTEXT_MAX_OFFSET
+#define RCU_DYNTICKS_IDX CONTEXT_MAX
+
+#define CT_STATE_MASK (CONTEXT_MAX - 1)
+#define CT_DYNTICKS_MASK (~CT_STATE_MASK)
+
 struct context_tracking {
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 	/*
@@ -26,9 +42,8 @@ struct context_tracking {
 	 */
 	bool active;
 	int recursion;
+#endif
 	atomic_t state;
-#endif
-	atomic_t dynticks;		/* Even value for idle, else odd. */
 	long dynticks_nesting;		/* Track process nesting level. */
 	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
 };
@@ -38,24 +53,26 @@ DECLARE_PER_CPU(struct context_tracking, context_tracking);
 
 static __always_inline int __ct_state(void)
 {
-	return atomic_read(this_cpu_ptr(&context_tracking.state));
+	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
 }
 
 static __always_inline int ct_dynticks(void)
 {
-	return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
+	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_MASK;
 }
 
 static __always_inline int ct_dynticks_cpu(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
-	return atomic_read(&ct->dynticks);
+
+	return atomic_read(&ct->state) & CT_DYNTICKS_MASK;
 }
 
 static __always_inline int ct_dynticks_cpu_acquire(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
-	return atomic_read_acquire(&ct->state);
+
+	return atomic_read_acquire(&ct->state) & CT_DYNTICKS_MASK;
 }
 #endif
 
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index fe9066fdfaab..87e7b748791c 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -63,9 +63,9 @@ static __always_inline void rcu_dynticks_task_trace_exit(void)
  * Increment the current CPU's context_tracking structure's ->dynticks field
  * with ordering.  Return the new value.
  */
-noinstr unsigned long rcu_dynticks_inc(int incby)
+noinstr unsigned long ct_state_inc(int incby)
 {
-	return arch_atomic_add_return(incby, this_cpu_ptr(&context_tracking.dynticks));
+	return arch_atomic_add_return(incby, this_cpu_ptr(&context_tracking.state));
 }
 
 /*
@@ -74,7 +74,7 @@ noinstr unsigned long rcu_dynticks_inc(int incby)
  * RCU is watching prior to the call to this function and is no longer
  * watching upon return.
  */
-static noinstr void rcu_dynticks_eqs_enter(void)
+static noinstr void ct_kernel_exit_state(int offset)
 {
 	int seq;
 
@@ -84,9 +84,9 @@ static noinstr void rcu_dynticks_eqs_enter(void)
 	 * next idle sojourn.
 	 */
 	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
-	seq = rcu_dynticks_inc(1);
+	seq = ct_state_inc(offset);
 	// RCU is no longer watching.  Better be in extended quiescent state!
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & 0x1));
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & RCU_DYNTICKS_IDX));
 }
 
 /*
@@ -94,7 +94,7 @@ static noinstr void rcu_dynticks_eqs_enter(void)
  * called from an extended quiescent state, that is, RCU is not watching
  * prior to the call to this function and is watching upon return.
  */
-static noinstr void rcu_dynticks_eqs_exit(void)
+static noinstr void ct_kernel_enter_state(int offset)
 {
 	int seq;
 
@@ -103,10 +103,10 @@ static noinstr void rcu_dynticks_eqs_exit(void)
 	 * and we also must force ordering with the next RCU read-side
 	 * critical section.
 	 */
-	seq = rcu_dynticks_inc(1);
+	seq = ct_state_inc(offset);
 	// RCU is now watching.  Better not be in an extended quiescent state!
 	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & 0x1));
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & RCU_DYNTICKS_IDX));
 }
 
 /*
@@ -117,7 +117,7 @@ static noinstr void rcu_dynticks_eqs_exit(void)
  * the possibility of usermode upcalls having messed up our count
  * of interrupt nesting level during the prior busy period.
  */
-static noinstr void rcu_eqs_enter(bool user)
+static noinstr void ct_kernel_exit(bool user, int offset)
 {
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
@@ -137,13 +137,13 @@ static noinstr void rcu_eqs_enter(bool user)
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rcu_preempt_deferred_qs(current);
 
-	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
-	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
+	// instrumentation for the noinstr ct_kernel_exit_state()
+	instrument_atomic_write(&ct->state, sizeof(ct->state));
 
 	instrumentation_end();
 	WRITE_ONCE(ct->dynticks_nesting, 0); /* Avoid irq-access tearing. */
 	// RCU is watching here ...
-	rcu_dynticks_eqs_enter();
+	ct_kernel_exit_state(offset);
 	// ... but is no longer watching here.
 	rcu_dynticks_task_enter();
 }
@@ -152,7 +152,7 @@ static noinstr void rcu_eqs_enter(bool user)
  * ct_nmi_exit - inform RCU of exit from NMI context
  *
  * If we are returning from the outermost NMI handler that interrupted an
- * RCU-idle period, update ct->dynticks and ct->dynticks_nmi_nesting
+ * RCU-idle period, update ct->state and ct->dynticks_nmi_nesting
  * to let the RCU grace-period handling know that the CPU is back to
  * being RCU-idle.
  *
@@ -189,12 +189,12 @@ noinstr void ct_nmi_exit(void)
 	trace_rcu_dyntick(TPS("Startirq"), ct->dynticks_nmi_nesting, 0, ct_dynticks());
 	WRITE_ONCE(ct->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
-	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
-	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
+	// instrumentation for the noinstr ct_kernel_exit_state()
+	instrument_atomic_write(&ct->state, sizeof(ct->state));
 	instrumentation_end();
 
 	// RCU is watching here ...
-	rcu_dynticks_eqs_enter();
+	ct_kernel_exit_state(RCU_DYNTICKS_IDX);
 	// ... but is no longer watching here.
 
 	if (!in_nmi())
@@ -209,7 +209,7 @@ noinstr void ct_nmi_exit(void)
  * allow for the possibility of usermode upcalls messing up our count of
  * interrupt nesting level during the busy period that is just now starting.
  */
-static void noinstr rcu_eqs_exit(bool user)
+static void noinstr ct_kernel_enter(bool user, int offset)
 {
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 	long oldval;
@@ -224,12 +224,12 @@ static void noinstr rcu_eqs_exit(bool user)
 	}
 	rcu_dynticks_task_exit();
 	// RCU is not watching here ...
-	rcu_dynticks_eqs_exit();
+	ct_kernel_enter_state(offset);
 	// ... but is watching here.
 	instrumentation_begin();
 
-	// instrumentation for the noinstr rcu_dynticks_eqs_exit()
-	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
+	// instrumentation for the noinstr ct_kernel_enter_state()
+	instrument_atomic_write(&ct->state, sizeof(ct->state));
 
 	trace_rcu_dyntick(TPS("End"), ct->dynticks_nesting, 1, ct_dynticks());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
@@ -242,7 +242,7 @@ static void noinstr rcu_eqs_exit(bool user)
 /**
  * ct_nmi_enter - inform RCU of entry to NMI context
  *
- * If the CPU was idle from RCU's viewpoint, update ct->dynticks and
+ * If the CPU was idle from RCU's viewpoint, update ct->state and
  * ct->dynticks_nmi_nesting to let the RCU grace-period handling know
  * that the CPU is active.  This implementation permits nested NMIs, as
  * long as the nesting level does not overflow an int.  (You will probably
@@ -273,14 +273,14 @@ noinstr void ct_nmi_enter(void)
 			rcu_dynticks_task_exit();
 
 		// RCU is not watching here ...
-		rcu_dynticks_eqs_exit();
+		ct_kernel_enter_state(RCU_DYNTICKS_IDX);
 		// ... but is watching here.
 
 		instrumentation_begin();
 		// instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
-		instrument_atomic_read(&ct->dynticks, sizeof(ct->dynticks));
-		// instrumentation for the noinstr rcu_dynticks_eqs_exit()
-		instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
+		instrument_atomic_read(&ct->state, sizeof(ct->state));
+		// instrumentation for the noinstr ct_kernel_enter_state()
+		instrument_atomic_write(&ct->state, sizeof(ct->state));
 
 		incby = 1;
 	} else if (!in_nmi()) {
@@ -373,22 +373,23 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 * CPU doesn't need to maintain the tick for RCU maintenance purposes
 			 * when the CPU runs in userspace.
 			 */
-			rcu_eqs_enter(true);
+			ct_kernel_exit(true, RCU_DYNTICKS_IDX + state);
+		} else {
+			/*
+			 * Even if context tracking is disabled on this CPU, because it's outside
+			 * the full dynticks mask for example, we still have to keep track of the
+			 * context transitions and states to prevent inconsistency on those of
+			 * other CPUs.
+			 * If a task triggers an exception in userspace, sleep on the exception
+			 * handler and then migrate to another CPU, that new CPU must know where
+			 * the exception returns by the time we call exception_exit().
+			 * This information can only be provided by the previous CPU when it called
+			 * exception_enter().
+			 * OTOH we can spare the calls to vtime and RCU when context_tracking.active
+			 * is false because we know that CPU is not tickless.
+			 */
+			atomic_add(state, &ct->state);
 		}
-		/*
-		 * Even if context tracking is disabled on this CPU, because it's outside
-		 * the full dynticks mask for example, we still have to keep track of the
-		 * context transitions and states to prevent inconsistency on those of
-		 * other CPUs.
-		 * If a task triggers an exception in userspace, sleep on the exception
-		 * handler and then migrate to another CPU, that new CPU must know where
-		 * the exception returns by the time we call exception_exit().
-		 * This information can only be provided by the previous CPU when it called
-		 * exception_enter().
-		 * OTOH we can spare the calls to vtime and RCU when context_tracking.active
-		 * is false because we know that CPU is not tickless.
-		 */
-		atomic_set(&ct->state, state);
 	}
 	context_tracking_recursion_exit();
 }
@@ -452,15 +453,16 @@ void noinstr __ct_user_exit(enum ctx_state state)
 			 * Exit RCU idle mode while entering the kernel because it can
 			 * run a RCU read side critical section anytime.
 			 */
-			rcu_eqs_exit(true);
+			ct_kernel_enter(true, RCU_DYNTICKS_IDX - state);
 			if (state == CONTEXT_USER) {
 				instrumentation_begin();
 				vtime_user_exit(current);
 				trace_user_exit(0);
 				instrumentation_end();
 			}
+		} else {
+			atomic_sub(state, &ct->state);
 		}
-		atomic_set(&ct->state, CONTEXT_KERNEL);
 	}
 	context_tracking_recursion_exit();
 }
@@ -530,7 +532,7 @@ void __init context_tracking_init(void)
 DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
 		.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 		.dynticks_nesting = 1,
-		.dynticks = ATOMIC_INIT(1),
+		.state = ATOMIC_INIT(RCU_DYNTICKS_IDX),
 };
 EXPORT_SYMBOL_GPL(context_tracking);
 
@@ -548,7 +550,7 @@ EXPORT_SYMBOL_GPL(context_tracking);
 void ct_idle_enter(void)
 {
 	lockdep_assert_irqs_disabled();
-	rcu_eqs_enter(false);
+	ct_kernel_exit(false, RCU_DYNTICKS_IDX + CONTEXT_IDLE);
 }
 EXPORT_SYMBOL_GPL(ct_idle_enter);
 
@@ -566,7 +568,7 @@ void ct_idle_exit(void)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	rcu_eqs_exit(false);
+	ct_kernel_enter(false, RCU_DYNTICKS_IDX - CONTEXT_IDLE);
 	local_irq_restore(flags);
 
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 90a22dd2189d..98fac3d327c9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -272,9 +272,9 @@ void rcu_softirq_qs(void)
  */
 static void rcu_dynticks_eqs_online(void)
 {
-	if (ct_dynticks() & 0x1)
+	if (ct_dynticks() & RCU_DYNTICKS_IDX)
 		return;
-	rcu_dynticks_inc(1);
+	ct_state_inc(RCU_DYNTICKS_IDX);
 }
 
 /*
@@ -293,7 +293,7 @@ static int rcu_dynticks_snap(int cpu)
  */
 static bool rcu_dynticks_in_eqs(int snap)
 {
-	return !(snap & 0x1);
+	return !(snap & RCU_DYNTICKS_IDX);
 }
 
 /* Return true if the specified CPU is currently idle from an RCU viewpoint.  */
@@ -321,8 +321,7 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
 	int snap;
 
 	// If not quiescent, force back to earlier extended quiescent state.
-	snap = ct_dynticks_cpu(cpu) & ~0x1;
-
+	snap = ct_dynticks_cpu(cpu) & ~RCU_DYNTICKS_IDX;
 	smp_rmb(); // Order ->dynticks and *vp reads.
 	if (READ_ONCE(*vp))
 		return false;  // Non-zero, so report failure;
@@ -348,9 +347,9 @@ notrace void rcu_momentary_dyntick_idle(void)
 	int seq;
 
 	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
-	seq = rcu_dynticks_inc(2);
+	seq = ct_state_inc(2 * RCU_DYNTICKS_IDX);
 	/* It is illegal to call this from idle state. */
-	WARN_ON_ONCE(!(seq & 0x1));
+	WARN_ON_ONCE(!(seq & RCU_DYNTICKS_IDX));
 	rcu_preempt_deferred_qs(current);
 }
 EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 9bf5cc79d5eb..1ac48c804006 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -459,7 +459,7 @@ static void print_cpu_stall_info(int cpu)
 			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
 				"!."[!delta],
 	       ticks_value, ticks_title,
-	       rcu_dynticks_snap(cpu) & 0xfff,
+	       (rcu_dynticks_snap(cpu) >> RCU_DYNTICKS_SHIFT) & 0xfff ,
 	       ct->dynticks_nesting, ct->dynticks_nmi_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
-- 
2.25.1


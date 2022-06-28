Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759C855E459
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346428AbiF1NT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346351AbiF1NSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:18:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E53E32EC4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:17:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3E0561774
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C61EC341CC;
        Tue, 28 Jun 2022 13:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656422265;
        bh=q+KasTGYGfbEAG0PKnAsfopTSHH3wIeb3NAl3A6iang=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+6hHUu5Vo2Sj+OsFC5SofFRKuLhhAnSmH9k+FYox/Mm+TWF7obPBjatUJr7ZnPzz
         vSdfC8YZptQDsPjtS84mE6KPRxgj9KHTyABXN7CJl9QhjyYVyj7Vx9sULFqce1cpwK
         wbrl0bIO0u1oYzLCaNhBqUAzqGSO4pzL7mwzA9+ovVoioJ6Kkpgbrb5Y1avlL4bf0J
         /Ru9QIb4RdUdYKZDA1mSYIJ44UKYEtVMDdgaEd5Fh5W6jsmWdXM+j06rlFVKX5btb/
         XylDgjDvPn1tnpvuYY/NOnEGqT11stXXOwlqAiR9YRYDEQpGrqqenLBeCeufT9oga0
         OsWsxqCpcCPvQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Marco Elver <elver@google.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 18/20] context_tracking: Convert state to atomic_t
Date:   Tue, 28 Jun 2022 15:16:17 +0200
Message-Id: <20220628131619.2109651-19-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628131619.2109651-1-frederic@kernel.org>
References: <20220628131619.2109651-1-frederic@kernel.org>
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

Context tracking's state and dynticks counter are going to be merged
in a single field so that both updates can happen atomically and at the
same time. Prepare for that with converting the state into an atomic_t.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 include/linux/context_tracking.h       |  32 ++----
 include/linux/context_tracking_state.h |  59 +++++++---
 kernel/context_tracking.c              | 143 ++++++++++++++++---------
 kernel/rcu/tree.c                      |  13 ++-
 kernel/rcu/tree_stall.h                |   4 +-
 5 files changed, 159 insertions(+), 92 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 1f568676bc1d..fd354eaea510 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -56,7 +56,7 @@ static inline enum ctx_state exception_enter(void)
 	    !context_tracking_enabled())
 		return 0;
 
-	prev_ctx = this_cpu_read(context_tracking.state);
+	prev_ctx = __ct_state();
 	if (prev_ctx != CONTEXT_KERNEL)
 		ct_user_exit(prev_ctx);
 
@@ -86,33 +86,21 @@ static __always_inline void context_tracking_guest_exit(void)
 		__ct_user_exit(CONTEXT_GUEST);
 }
 
-/**
- * ct_state() - return the current context tracking state if known
- *
- * Returns the current cpu's context tracking state if context tracking
- * is enabled.  If context tracking is disabled, returns
- * CONTEXT_DISABLED.  This should be used primarily for debugging.
- */
-static __always_inline enum ctx_state ct_state(void)
-{
-	return context_tracking_enabled() ?
-		this_cpu_read(context_tracking.state) : CONTEXT_DISABLED;
-}
+#define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
+
 #else
 static inline void user_enter(void) { }
 static inline void user_exit(void) { }
 static inline void user_enter_irqoff(void) { }
 static inline void user_exit_irqoff(void) { }
-static inline enum ctx_state exception_enter(void) { return 0; }
+static inline int exception_enter(void) { return 0; }
 static inline void exception_exit(enum ctx_state prev_ctx) { }
-static inline enum ctx_state ct_state(void) { return CONTEXT_DISABLED; }
+static inline int ct_state(void) { return -1; }
 static __always_inline bool context_tracking_guest_enter(void) { return false; }
 static inline void context_tracking_guest_exit(void) { }
-
+#define CT_WARN_ON(cond)
 #endif /* !CONFIG_CONTEXT_TRACKING_USER */
 
-#define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
-
 #ifdef CONFIG_CONTEXT_TRACKING_USER_FORCE
 extern void context_tracking_init(void);
 #else
@@ -130,16 +118,16 @@ extern void ct_idle_exit(void);
  */
 static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
-	return !(arch_atomic_read(this_cpu_ptr(&context_tracking.dynticks)) & 0x1);
+	return !(arch_atomic_read(this_cpu_ptr(&context_tracking.state)) & RCU_DYNTICKS_IDX);
 }
 
 /*
- * Increment the current CPU's context_tracking structure's ->dynticks field
+ * Increment the current CPU's context_tracking structure's ->state field
  * with ordering.  Return the new value.
  */
-static __always_inline unsigned long rcu_dynticks_inc(int incby)
+static __always_inline unsigned long ct_state_inc(int incby)
 {
-	return arch_atomic_add_return(incby, this_cpu_ptr(&context_tracking.dynticks));
+	return arch_atomic_add_return(incby, this_cpu_ptr(&context_tracking.state));
 }
 
 #else
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 5f11e3d2d85a..e20a74bc0597 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -6,16 +6,24 @@
 #include <linux/static_key.h>
 #include <linux/context_tracking_irq.h>
 
-enum ctx_state {
-	CONTEXT_DISABLED = -1,	/* returned by ct_state() if unknown */
-	CONTEXT_KERNEL = 0,
-	CONTEXT_USER,
-	CONTEXT_GUEST,
-};
-
 /* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
 #define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
 
+enum ctx_state {
+	CONTEXT_DISABLED	= -1,	/* returned by ct_state() if unknown */
+	CONTEXT_KERNEL		= 0,
+	CONTEXT_IDLE		= 1,
+	CONTEXT_USER		= 2,
+	CONTEXT_GUEST		= 3,
+	CONTEXT_MAX		= 4,
+};
+
+/* Even value for idle, else odd. */
+#define RCU_DYNTICKS_IDX CONTEXT_MAX
+
+#define CT_STATE_MASK (CONTEXT_MAX - 1)
+#define CT_DYNTICKS_MASK (~CT_STATE_MASK)
+
 struct context_tracking {
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 	/*
@@ -26,10 +34,11 @@ struct context_tracking {
 	 */
 	bool active;
 	int recursion;
-	enum ctx_state state;
+#endif
+#ifdef CONFIG_CONTEXT_TRACKING
+	atomic_t state;
 #endif
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
-	atomic_t dynticks;		/* Even value for idle, else odd. */
 	long dynticks_nesting;		/* Track process nesting level. */
 	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
 #endif
@@ -37,26 +46,31 @@ struct context_tracking {
 
 #ifdef CONFIG_CONTEXT_TRACKING
 DECLARE_PER_CPU(struct context_tracking, context_tracking);
+
+static __always_inline int __ct_state(void)
+{
+	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
+}
 #endif
 
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
 static __always_inline int ct_dynticks(void)
 {
-	return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
+	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_MASK;
 }
 
 static __always_inline int ct_dynticks_cpu(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
-	return atomic_read(&ct->dynticks);
+	return atomic_read(&ct->state) & CT_DYNTICKS_MASK;
 }
 
 static __always_inline int ct_dynticks_cpu_acquire(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
-	return atomic_read_acquire(&ct->dynticks);
+	return atomic_read_acquire(&ct->state) & CT_DYNTICKS_MASK;
 }
 
 static __always_inline long ct_dynticks_nesting(void)
@@ -102,6 +116,27 @@ static inline bool context_tracking_enabled_this_cpu(void)
 	return context_tracking_enabled() && __this_cpu_read(context_tracking.active);
 }
 
+/**
+ * ct_state() - return the current context tracking state if known
+ *
+ * Returns the current cpu's context tracking state if context tracking
+ * is enabled.  If context tracking is disabled, returns
+ * CONTEXT_DISABLED.  This should be used primarily for debugging.
+ */
+static __always_inline int ct_state(void)
+{
+	int ret;
+
+	if (!context_tracking_enabled())
+		return CONTEXT_DISABLED;
+
+	preempt_disable();
+	ret = __ct_state();
+	preempt_enable();
+
+	return ret;
+}
+
 #else
 static __always_inline bool context_tracking_enabled(void) { return false; }
 static __always_inline bool context_tracking_enabled_cpu(int cpu) { return false; }
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index e485b6b01537..ca78ff27dc53 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -28,8 +28,8 @@ DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
 	.dynticks_nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
-	.dynticks = ATOMIC_INIT(1),
 #endif
+	.state = ATOMIC_INIT(RCU_DYNTICKS_IDX),
 };
 EXPORT_SYMBOL_GPL(context_tracking);
 
@@ -76,7 +76,7 @@ static __always_inline void rcu_dynticks_task_trace_exit(void)
  * RCU is watching prior to the call to this function and is no longer
  * watching upon return.
  */
-static noinstr void rcu_dynticks_eqs_enter(void)
+static noinstr void ct_kernel_exit_state(int offset)
 {
 	int seq;
 
@@ -86,9 +86,9 @@ static noinstr void rcu_dynticks_eqs_enter(void)
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
@@ -96,7 +96,7 @@ static noinstr void rcu_dynticks_eqs_enter(void)
  * called from an extended quiescent state, that is, RCU is not watching
  * prior to the call to this function and is watching upon return.
  */
-static noinstr void rcu_dynticks_eqs_exit(void)
+static noinstr void ct_kernel_enter_state(int offset)
 {
 	int seq;
 
@@ -105,10 +105,10 @@ static noinstr void rcu_dynticks_eqs_exit(void)
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
@@ -119,7 +119,7 @@ static noinstr void rcu_dynticks_eqs_exit(void)
  * the possibility of usermode upcalls having messed up our count
  * of interrupt nesting level during the prior busy period.
  */
-static void noinstr rcu_eqs_enter(bool user)
+static void noinstr ct_kernel_exit(bool user, int offset)
 {
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
@@ -139,13 +139,13 @@ static void noinstr rcu_eqs_enter(bool user)
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
@@ -158,7 +158,7 @@ static void noinstr rcu_eqs_enter(bool user)
  * allow for the possibility of usermode upcalls messing up our count of
  * interrupt nesting level during the busy period that is just now starting.
  */
-static void noinstr rcu_eqs_exit(bool user)
+static void noinstr ct_kernel_enter(bool user, int offset)
 {
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 	long oldval;
@@ -173,12 +173,12 @@ static void noinstr rcu_eqs_exit(bool user)
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
 
 	trace_rcu_dyntick(TPS("End"), ct_dynticks_nesting(), 1, ct_dynticks());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
@@ -192,7 +192,7 @@ static void noinstr rcu_eqs_exit(bool user)
  * ct_nmi_exit - inform RCU of exit from NMI context
  *
  * If we are returning from the outermost NMI handler that interrupted an
- * RCU-idle period, update ct->dynticks and ct->dynticks_nmi_nesting
+ * RCU-idle period, update ct->state and ct->dynticks_nmi_nesting
  * to let the RCU grace-period handling know that the CPU is back to
  * being RCU-idle.
  *
@@ -229,12 +229,12 @@ void noinstr ct_nmi_exit(void)
 	trace_rcu_dyntick(TPS("Startirq"), ct_dynticks_nmi_nesting(), 0, ct_dynticks());
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
@@ -244,7 +244,7 @@ void noinstr ct_nmi_exit(void)
 /**
  * ct_nmi_enter - inform RCU of entry to NMI context
  *
- * If the CPU was idle from RCU's viewpoint, update ct->dynticks and
+ * If the CPU was idle from RCU's viewpoint, update ct->state and
  * ct->dynticks_nmi_nesting to let the RCU grace-period handling know
  * that the CPU is active.  This implementation permits nested NMIs, as
  * long as the nesting level does not overflow an int.  (You will probably
@@ -275,14 +275,14 @@ void noinstr ct_nmi_enter(void)
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
@@ -315,7 +315,7 @@ void noinstr ct_nmi_enter(void)
 void noinstr ct_idle_enter(void)
 {
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
-	rcu_eqs_enter(false);
+	ct_kernel_exit(false, RCU_DYNTICKS_IDX + CONTEXT_IDLE);
 }
 EXPORT_SYMBOL_GPL(ct_idle_enter);
 
@@ -333,7 +333,7 @@ void noinstr ct_idle_exit(void)
 	unsigned long flags;
 
 	raw_local_irq_save(flags);
-	rcu_eqs_exit(false);
+	ct_kernel_enter(false, RCU_DYNTICKS_IDX - CONTEXT_IDLE);
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(ct_idle_exit);
@@ -421,8 +421,8 @@ void ct_irq_exit_irqson(void)
 	local_irq_restore(flags);
 }
 #else
-static __always_inline void rcu_eqs_enter(bool user) { }
-static __always_inline void rcu_eqs_exit(bool user) { }
+static __always_inline void ct_kernel_exit(bool user, int offset) { }
+static __always_inline void ct_kernel_enter(bool user, int offset) { }
 #endif /* #ifdef CONFIG_CONTEXT_TRACKING_IDLE */
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER
@@ -463,6 +463,7 @@ static __always_inline void context_tracking_recursion_exit(void)
  */
 void noinstr __ct_user_enter(enum ctx_state state)
 {
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 	lockdep_assert_irqs_disabled();
 
 	/* Kernel threads aren't supposed to go to userspace */
@@ -471,8 +472,8 @@ void noinstr __ct_user_enter(enum ctx_state state)
 	if (!context_tracking_recursion_enter())
 		return;
 
-	if ( __this_cpu_read(context_tracking.state) != state) {
-		if (__this_cpu_read(context_tracking.active)) {
+	if (__ct_state() != state) {
+		if (ct->active) {
 			/*
 			 * At this stage, only low level arch entry code remains and
 			 * then we'll run in userspace. We can assume there won't be
@@ -492,28 +493,49 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 * that will fire and reschedule once we resume in user/guest mode.
 			 */
 			rcu_irq_work_resched();
+
 			/*
 			 * Enter RCU idle mode right before resuming userspace.  No use of RCU
 			 * is permitted between this call and rcu_eqs_exit(). This way the
 			 * CPU doesn't need to maintain the tick for RCU maintenance purposes
 			 * when the CPU runs in userspace.
 			 */
-			rcu_eqs_enter(true);
+			ct_kernel_exit(true, RCU_DYNTICKS_IDX + state);
+
+			/*
+			 * Special case if we only track user <-> kernel transitions for tickless
+			 * cputime accounting but we don't support RCU extended quiescent state.
+			 * In this we case we don't care about any concurrency/ordering.
+			 */
+			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE))
+				atomic_set(&ct->state, state);
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
+			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE)) {
+				/* Tracking for vtime only, no concurrent RCU EQS accounting */
+				atomic_set(&ct->state, state);
+			} else {
+				/*
+				 * Tracking for vtime and RCU EQS. Make sure we don't race
+				 * with NMIs. OTOH we don't care about ordering here since
+				 * RCU only requires RCU_DYNTICKS_IDX increments to be fully
+				 * ordered.
+				 */
+				atomic_add(state, &ct->state);
+			}
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
-		__this_cpu_write(context_tracking.state, state);
 	}
 	context_tracking_recursion_exit();
 }
@@ -581,24 +603,47 @@ NOKPROBE_SYMBOL(user_enter_callable);
  */
 void noinstr __ct_user_exit(enum ctx_state state)
 {
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
+
 	if (!context_tracking_recursion_enter())
 		return;
 
-	if (__this_cpu_read(context_tracking.state) == state) {
-		if (__this_cpu_read(context_tracking.active)) {
+	if (__ct_state() == state) {
+		if (ct->active) {
 			/*
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
+
+			/*
+			 * Special case if we only track user <-> kernel transitions for tickless
+			 * cputime accounting but we don't support RCU extended quiescent state.
+			 * In this we case we don't care about any concurrency/ordering.
+			 */
+			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE))
+				atomic_set(&ct->state, CONTEXT_KERNEL);
+
+		} else {
+			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE)) {
+				/* Tracking for vtime only, no concurrent RCU EQS accounting */
+				atomic_set(&ct->state, CONTEXT_KERNEL);
+			} else {
+				/*
+				 * Tracking for vtime and RCU EQS. Make sure we don't race
+				 * with NMIs. OTOH we don't care about ordering here since
+				 * RCU only requires RCU_DYNTICKS_IDX increments to be fully
+				 * ordered.
+				 */
+				atomic_sub(state, &ct->state);
+			}
 		}
-		__this_cpu_write(context_tracking.state, CONTEXT_KERNEL);
 	}
 	context_tracking_recursion_exit();
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e2a2083079a2..f9d20b40071f 100644
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
index 2683ce0a7c72..195cad14742d 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -469,7 +469,7 @@ static void print_cpu_stall_info(int cpu)
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
 		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
-	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",
+	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%04x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
 	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
@@ -478,7 +478,7 @@ static void print_cpu_stall_info(int cpu)
 			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
 				"!."[!delta],
 	       ticks_value, ticks_title,
-	       rcu_dynticks_snap(cpu) & 0xfff,
+	       rcu_dynticks_snap(cpu) & 0xffff,
 	       ct_dynticks_nesting_cpu(cpu), ct_dynticks_nmi_nesting_cpu(cpu),
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
-- 
2.25.1


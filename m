Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EA85181EA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbiECKG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbiECKGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:06:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB223969F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 03:02:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 341CBCE1E7C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5A4C385A4;
        Tue,  3 May 2022 10:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651572127;
        bh=0EUmFww5drZ15WTYnaK1XZTHt8CmyZosJNalWFJK5X0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jKBnw+lBOSd9P7mHihw65e5wBRmwiANlo79rgfwoMckjfCSgZD9WwA0l065ya9Onp
         Serq/iTjjM1pAQJPYI6OyDEDi+GKdM99Hv6sxkmp88v4WOWaO2CPsUlkRUCQ1r0wPO
         5FVLdt7r2l1/xUg7QpFsY7FaHUq9eGO1k/7kRGSXD4ws6t2Af/ZmP+2P73rhrSxMnv
         g4xUiv/NUCYd/L/nvx47xDcsAxHmUUbxNxVIhdST1bCkdgcApoSsbWoy1DceN9YkGP
         FtvACdfqsgN2rwD1HXSwakCU/6NosEPAByfrXWVjBZ+G6nmOc+QtEywJilx1oOowto
         wqPlS6C2EEwLQ==
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
Subject: [PATCH 18/21] rcu/context-tracking: Move RCU-dynticks internal functions to context_tracking
Date:   Tue,  3 May 2022 12:00:48 +0200
Message-Id: <20220503100051.2799723-19-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503100051.2799723-1-frederic@kernel.org>
References: <20220503100051.2799723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the core RCU eqs/dynticks functions to context tracking so that
we can later merge all that code within context tracking.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
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
Cc: Yu Liao<liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
---
 include/linux/context_tracking.h |  20 ++
 include/linux/rcutree.h          |   3 +
 kernel/context_tracking.c        | 342 +++++++++++++++++++++++++++++++
 kernel/rcu/tree.c                | 328 +----------------------------
 kernel/rcu/tree.h                |   5 -
 kernel/rcu/tree_plugin.h         |  38 +---
 6 files changed, 370 insertions(+), 366 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 27afb75f2650..cad8aecb7321 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -122,6 +122,26 @@ static inline void context_tracking_init(void) { }
 #ifdef CONFIG_CONTEXT_TRACKING
 extern void ct_idle_enter(void);
 extern void ct_idle_exit(void);
+
+/*
+ * Is the current CPU in an extended quiescent state?
+ *
+ * No ordering, as we are sampling CPU-local information.
+ */
+static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
+{
+	return !(arch_atomic_read(this_cpu_ptr(&context_tracking.dynticks)) & 0x1);
+}
+
+/*
+ * Increment the current CPU's context_tracking structure's ->dynticks field
+ * with ordering.  Return the new value.
+ */
+static __always_inline unsigned long rcu_dynticks_inc(int incby)
+{
+	return arch_atomic_add_return(incby, this_cpu_ptr(&context_tracking.dynticks));
+}
+
 #else
 static inline void ct_idle_enter(void) { }
 static inline void ct_idle_exit(void) { }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 6294271f1615..d9e8e6233c47 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -57,6 +57,9 @@ void rcu_irq_exit_check_preempt(void);
 static inline void rcu_irq_exit_check_preempt(void) { }
 #endif
 
+struct task_struct;
+void rcu_preempt_deferred_qs(struct task_struct *t);
+
 void exit_rcu(void);
 
 void rcu_scheduler_starting(void);
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 4ca4aeadad06..279fb5875dd8 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -21,6 +21,348 @@
 #include <linux/hardirq.h>
 #include <linux/export.h>
 #include <linux/kprobes.h>
+#include <trace/events/rcu.h>
+
+#define TPS(x)  tracepoint_string(x)
+
+/* Record the current task on dyntick-idle entry. */
+static __always_inline void rcu_dynticks_task_enter(void)
+{
+#if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
+	WRITE_ONCE(current->rcu_tasks_idle_cpu, smp_processor_id());
+#endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
+}
+
+/* Record no current task on dyntick-idle exit. */
+static __always_inline void rcu_dynticks_task_exit(void)
+{
+#if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
+	WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
+#endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
+}
+
+/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
+static __always_inline void rcu_dynticks_task_trace_enter(void)
+{
+#ifdef CONFIG_TASKS_TRACE_RCU
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
+		current->trc_reader_special.b.need_mb = true;
+#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
+}
+
+/* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
+static __always_inline void rcu_dynticks_task_trace_exit(void)
+{
+#ifdef CONFIG_TASKS_TRACE_RCU
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
+		current->trc_reader_special.b.need_mb = false;
+#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
+}
+
+/*
+ * Record entry into an extended quiescent state.  This is only to be
+ * called when not already in an extended quiescent state, that is,
+ * RCU is watching prior to the call to this function and is no longer
+ * watching upon return.
+ */
+static noinstr void rcu_dynticks_eqs_enter(void)
+{
+	int seq;
+
+	/*
+	 * CPUs seeing atomic_add_return() must see prior RCU read-side
+	 * critical sections, and we also must force ordering with the
+	 * next idle sojourn.
+	 */
+	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
+	seq = rcu_dynticks_inc(1);
+	// RCU is no longer watching.  Better be in extended quiescent state!
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & 0x1));
+}
+
+/*
+ * Record exit from an extended quiescent state.  This is only to be
+ * called from an extended quiescent state, that is, RCU is not watching
+ * prior to the call to this function and is watching upon return.
+ */
+static noinstr void rcu_dynticks_eqs_exit(void)
+{
+	int seq;
+
+	/*
+	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
+	 * and we also must force ordering with the next RCU read-side
+	 * critical section.
+	 */
+	seq = rcu_dynticks_inc(1);
+	// RCU is now watching.  Better not be in an extended quiescent state!
+	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & 0x1));
+}
+
+/*
+ * Enter an RCU extended quiescent state, which can be either the
+ * idle loop or adaptive-tickless usermode execution.
+ *
+ * We crowbar the ->dynticks_nmi_nesting field to zero to allow for
+ * the possibility of usermode upcalls having messed up our count
+ * of interrupt nesting level during the prior busy period.
+ */
+static noinstr void rcu_eqs_enter(bool user)
+{
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
+
+	WARN_ON_ONCE(ct_dynticks_nmi_nesting() != DYNTICK_IRQ_NONIDLE);
+	WRITE_ONCE(ct->dynticks_nmi_nesting, 0);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
+		     ct_dynticks_nesting() == 0);
+	if (ct_dynticks_nesting() != 1) {
+		// RCU will still be watching, so just do accounting and leave.
+		ct->dynticks_nesting--;
+		return;
+	}
+
+	lockdep_assert_irqs_disabled();
+	instrumentation_begin();
+	trace_rcu_dyntick(TPS("Start"), ct_dynticks_nesting(), 0, ct_dynticks());
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
+	rcu_preempt_deferred_qs(current);
+
+	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
+	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
+
+	instrumentation_end();
+	WRITE_ONCE(ct->dynticks_nesting, 0); /* Avoid irq-access tearing. */
+	// RCU is watching here ...
+	rcu_dynticks_eqs_enter();
+	// ... but is no longer watching here.
+	rcu_dynticks_task_enter();
+}
+
+/**
+ * rcu_idle_enter - inform RCU that current CPU is entering idle
+ *
+ * Enter idle mode, in other words, -leave- the mode in which RCU
+ * read-side critical sections can occur.  (Though RCU read-side
+ * critical sections can occur in irq handlers in idle, a possibility
+ * handled by irq_enter() and irq_exit().)
+ *
+ * If you add or remove a call to rcu_idle_enter(), be sure to test with
+ * CONFIG_RCU_EQS_DEBUG=y.
+ */
+noinstr void rcu_idle_enter(void)
+{
+	lockdep_assert_irqs_disabled();
+	rcu_eqs_enter(false);
+}
+
+#ifdef CONFIG_NO_HZ_FULL
+/**
+ * rcu_user_enter - inform RCU that we are resuming userspace.
+ *
+ * Enter RCU idle mode right before resuming userspace.  No use of RCU
+ * is permitted between this call and rcu_user_exit(). This way the
+ * CPU doesn't need to maintain the tick for RCU maintenance purposes
+ * when the CPU runs in userspace.
+ *
+ * If you add or remove a call to rcu_user_enter(), be sure to test with
+ * CONFIG_RCU_EQS_DEBUG=y.
+ */
+noinstr void rcu_user_enter(void)
+{
+	rcu_eqs_enter(true);
+}
+#endif /* CONFIG_NO_HZ_FULL */
+
+/**
+ * rcu_nmi_exit - inform RCU of exit from NMI context
+ *
+ * If we are returning from the outermost NMI handler that interrupted an
+ * RCU-idle period, update ct->dynticks and ct->dynticks_nmi_nesting
+ * to let the RCU grace-period handling know that the CPU is back to
+ * being RCU-idle.
+ *
+ * If you add or remove a call to rcu_nmi_exit(), be sure to test
+ * with CONFIG_RCU_EQS_DEBUG=y.
+ */
+noinstr void rcu_nmi_exit(void)
+{
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
+
+	instrumentation_begin();
+	/*
+	 * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
+	 * (We are exiting an NMI handler, so RCU better be paying attention
+	 * to us!)
+	 */
+	WARN_ON_ONCE(ct_dynticks_nmi_nesting() <= 0);
+	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
+
+	/*
+	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
+	 * leave it in non-RCU-idle state.
+	 */
+	if (ct_dynticks_nmi_nesting() != 1) {
+		trace_rcu_dyntick(TPS("--="), ct_dynticks_nmi_nesting(), ct_dynticks_nmi_nesting() - 2,
+				  ct_dynticks());
+		WRITE_ONCE(ct->dynticks_nmi_nesting, /* No store tearing. */
+			   ct_dynticks_nmi_nesting() - 2);
+		instrumentation_end();
+		return;
+	}
+
+	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
+	trace_rcu_dyntick(TPS("Startirq"), ct_dynticks_nmi_nesting(), 0, ct_dynticks());
+	WRITE_ONCE(ct->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
+
+	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
+	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
+	instrumentation_end();
+
+	// RCU is watching here ...
+	rcu_dynticks_eqs_enter();
+	// ... but is no longer watching here.
+
+	if (!in_nmi())
+		rcu_dynticks_task_enter();
+}
+
+/*
+ * Exit an RCU extended quiescent state, which can be either the
+ * idle loop or adaptive-tickless usermode execution.
+ *
+ * We crowbar the ->dynticks_nmi_nesting field to DYNTICK_IRQ_NONIDLE to
+ * allow for the possibility of usermode upcalls messing up our count of
+ * interrupt nesting level during the busy period that is just now starting.
+ */
+static void noinstr rcu_eqs_exit(bool user)
+{
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
+	long oldval;
+
+	lockdep_assert_irqs_disabled();
+	oldval = ct_dynticks_nesting();
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
+	if (oldval) {
+		// RCU was already watching, so just do accounting and leave.
+		ct->dynticks_nesting++;
+		return;
+	}
+	rcu_dynticks_task_exit();
+	// RCU is not watching here ...
+	rcu_dynticks_eqs_exit();
+	// ... but is watching here.
+	instrumentation_begin();
+
+	// instrumentation for the noinstr rcu_dynticks_eqs_exit()
+	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
+
+	trace_rcu_dyntick(TPS("End"), ct_dynticks_nesting(), 1, ct_dynticks());
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
+	WRITE_ONCE(ct->dynticks_nesting, 1);
+	WARN_ON_ONCE(ct_dynticks_nmi_nesting());
+	WRITE_ONCE(ct->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
+	instrumentation_end();
+}
+
+/**
+ * rcu_idle_exit - inform RCU that current CPU is leaving idle
+ *
+ * Exit idle mode, in other words, -enter- the mode in which RCU
+ * read-side critical sections can occur.
+ *
+ * If you add or remove a call to rcu_idle_exit(), be sure to test with
+ * CONFIG_RCU_EQS_DEBUG=y.
+ *
+ * FIXME: This function should be noinstr but the below local_irq_save() is
+ * unsafe because it involves illegal RCU uses through tracing and lockdep.
+ * This must be fixed first.
+ */
+void rcu_idle_exit(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	rcu_eqs_exit(false);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(rcu_idle_exit);
+
+#ifdef CONFIG_NO_HZ_FULL
+/**
+ * rcu_user_exit - inform RCU that we are exiting userspace.
+ *
+ * Exit RCU idle mode while entering the kernel because it can
+ * run a RCU read side critical section anytime.
+ *
+ * If you add or remove a call to rcu_user_exit(), be sure to test with
+ * CONFIG_RCU_EQS_DEBUG=y.
+ */
+void noinstr rcu_user_exit(void)
+{
+	rcu_eqs_exit(true);
+}
+#endif /* ifdef CONFIG_NO_HZ_FULL */
+
+/**
+ * rcu_nmi_enter - inform RCU of entry to NMI context
+ *
+ * If the CPU was idle from RCU's viewpoint, update ct->dynticks and
+ * ct->dynticks_nmi_nesting to let the RCU grace-period handling know
+ * that the CPU is active.  This implementation permits nested NMIs, as
+ * long as the nesting level does not overflow an int.  (You will probably
+ * run out of stack space first.)
+ *
+ * If you add or remove a call to rcu_nmi_enter(), be sure to test
+ * with CONFIG_RCU_EQS_DEBUG=y.
+ */
+noinstr void rcu_nmi_enter(void)
+{
+	long incby = 2;
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
+
+	/* Complain about underflow. */
+	WARN_ON_ONCE(ct_dynticks_nmi_nesting() < 0);
+
+	/*
+	 * If idle from RCU viewpoint, atomically increment ->dynticks
+	 * to mark non-idle and increment ->dynticks_nmi_nesting by one.
+	 * Otherwise, increment ->dynticks_nmi_nesting by two.  This means
+	 * if ->dynticks_nmi_nesting is equal to one, we are guaranteed
+	 * to be in the outermost NMI handler that interrupted an RCU-idle
+	 * period (observation due to Andy Lutomirski).
+	 */
+	if (rcu_dynticks_curr_cpu_in_eqs()) {
+
+		if (!in_nmi())
+			rcu_dynticks_task_exit();
+
+		// RCU is not watching here ...
+		rcu_dynticks_eqs_exit();
+		// ... but is watching here.
+
+		instrumentation_begin();
+		// instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
+		instrument_atomic_read(&ct->dynticks, sizeof(ct->dynticks));
+		// instrumentation for the noinstr rcu_dynticks_eqs_exit()
+		instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
+
+		incby = 1;
+	} else if (!in_nmi()) {
+		instrumentation_begin();
+		rcu_irq_enter_check_tick();
+	} else  {
+		instrumentation_begin();
+	}
+
+	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
+			  ct_dynticks_nmi_nesting(),
+			  ct_dynticks_nmi_nesting() + incby, ct_dynticks());
+	instrumentation_end();
+	WRITE_ONCE(ct->dynticks_nmi_nesting, /* Prevent store tearing. */
+		   ct_dynticks_nmi_nesting() + incby);
+	barrier();
+}
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7d1a3e73ff25..16d601512da7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -62,6 +62,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/kasan.h>
+#include <linux/context_tracking.h>
 #include "../time/tick-internal.h"
 
 #include "tree.h"
@@ -259,56 +260,6 @@ void rcu_softirq_qs(void)
 	rcu_tasks_qs(current, false);
 }
 
-/*
- * Increment the current CPU's rcu_data structure's ->dynticks field
- * with ordering.  Return the new value.
- */
-static noinline noinstr unsigned long rcu_dynticks_inc(int incby)
-{
-	return arch_atomic_add_return(incby, this_cpu_ptr(&context_tracking.dynticks));
-}
-
-/*
- * Record entry into an extended quiescent state.  This is only to be
- * called when not already in an extended quiescent state, that is,
- * RCU is watching prior to the call to this function and is no longer
- * watching upon return.
- */
-static noinstr void rcu_dynticks_eqs_enter(void)
-{
-	int seq;
-
-	/*
-	 * CPUs seeing atomic_add_return() must see prior RCU read-side
-	 * critical sections, and we also must force ordering with the
-	 * next idle sojourn.
-	 */
-	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
-	seq = rcu_dynticks_inc(1);
-	// RCU is no longer watching.  Better be in extended quiescent state!
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & 0x1));
-}
-
-/*
- * Record exit from an extended quiescent state.  This is only to be
- * called from an extended quiescent state, that is, RCU is not watching
- * prior to the call to this function and is watching upon return.
- */
-static noinstr void rcu_dynticks_eqs_exit(void)
-{
-	int seq;
-
-	/*
-	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
-	 * and we also must force ordering with the next RCU read-side
-	 * critical section.
-	 */
-	seq = rcu_dynticks_inc(1);
-	// RCU is now watching.  Better not be in an extended quiescent state!
-	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & 0x1));
-}
-
 /*
  * Reset the current CPU's ->dynticks counter to indicate that the
  * newly onlined CPU is no longer in an extended quiescent state.
@@ -326,16 +277,6 @@ static void rcu_dynticks_eqs_online(void)
 	rcu_dynticks_inc(1);
 }
 
-/*
- * Is the current CPU in an extended quiescent state?
- *
- * No ordering, as we are sampling CPU-local information.
- */
-static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
-{
-	return !(arch_atomic_read(this_cpu_ptr(&context_tracking.dynticks)) & 0x1);
-}
-
 /*
  * Snapshot the ->dynticks counter with full ordering so as to allow
  * stable comparison of this counter with past and future snapshots.
@@ -601,65 +542,7 @@ void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 }
 EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 
-/*
- * Enter an RCU extended quiescent state, which can be either the
- * idle loop or adaptive-tickless usermode execution.
- *
- * We crowbar the ->dynticks_nmi_nesting field to zero to allow for
- * the possibility of usermode upcalls having messed up our count
- * of interrupt nesting level during the prior busy period.
- */
-static noinstr void rcu_eqs_enter(bool user)
-{
-	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
-
-	WARN_ON_ONCE(ct_dynticks_nmi_nesting() != DYNTICK_IRQ_NONIDLE);
-	WRITE_ONCE(ct->dynticks_nmi_nesting, 0);
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     ct_dynticks_nesting() == 0);
-	if (ct_dynticks_nesting() != 1) {
-		// RCU will still be watching, so just do accounting and leave.
-		ct->dynticks_nesting--;
-		return;
-	}
-
-	lockdep_assert_irqs_disabled();
-	instrumentation_begin();
-	trace_rcu_dyntick(TPS("Start"), ct_dynticks_nesting(), 0, ct_dynticks());
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
-	rcu_preempt_deferred_qs(current);
-
-	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
-	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
-
-	instrumentation_end();
-	WRITE_ONCE(ct->dynticks_nesting, 0); /* Avoid irq-access tearing. */
-	// RCU is watching here ...
-	rcu_dynticks_eqs_enter();
-	// ... but is no longer watching here.
-	rcu_dynticks_task_enter();
-}
-
-/**
- * rcu_idle_enter - inform RCU that current CPU is entering idle
- *
- * Enter idle mode, in other words, -leave- the mode in which RCU
- * read-side critical sections can occur.  (Though RCU read-side
- * critical sections can occur in irq handlers in idle, a possibility
- * handled by irq_enter() and irq_exit().)
- *
- * If you add or remove a call to rcu_idle_enter(), be sure to test with
- * CONFIG_RCU_EQS_DEBUG=y.
- */
-noinstr void rcu_idle_enter(void)
-{
-	lockdep_assert_irqs_disabled();
-	rcu_eqs_enter(false);
-}
-
-#ifdef CONFIG_NO_HZ_FULL
-
-#if !defined(CONFIG_GENERIC_ENTRY) || !defined(CONFIG_KVM_XFER_TO_GUEST_WORK)
+#if defined(CONFIG_NO_HZ_FULL) && (!defined(CONFIG_GENERIC_ENTRY) || !defined(CONFIG_KVM_XFER_TO_GUEST_WORK))
 /*
  * An empty function that will trigger a reschedule on
  * IRQ tail once IRQs get re-enabled on userspace/guest resume.
@@ -697,78 +580,7 @@ noinstr void rcu_irq_work_resched(void)
 	}
 	instrumentation_end();
 }
-#endif /* #if !defined(CONFIG_GENERIC_ENTRY) || !defined(CONFIG_KVM_XFER_TO_GUEST_WORK) */
-
-/**
- * rcu_user_enter - inform RCU that we are resuming userspace.
- *
- * Enter RCU idle mode right before resuming userspace.  No use of RCU
- * is permitted between this call and rcu_user_exit(). This way the
- * CPU doesn't need to maintain the tick for RCU maintenance purposes
- * when the CPU runs in userspace.
- *
- * If you add or remove a call to rcu_user_enter(), be sure to test with
- * CONFIG_RCU_EQS_DEBUG=y.
- */
-noinstr void rcu_user_enter(void)
-{
-	rcu_eqs_enter(true);
-}
-
-#endif /* CONFIG_NO_HZ_FULL */
-
-/**
- * rcu_nmi_exit - inform RCU of exit from NMI context
- *
- * If we are returning from the outermost NMI handler that interrupted an
- * RCU-idle period, update ct->dynticks and ct->dynticks_nmi_nesting
- * to let the RCU grace-period handling know that the CPU is back to
- * being RCU-idle.
- *
- * If you add or remove a call to rcu_nmi_exit(), be sure to test
- * with CONFIG_RCU_EQS_DEBUG=y.
- */
-noinstr void rcu_nmi_exit(void)
-{
-	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
-
-	instrumentation_begin();
-	/*
-	 * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
-	 * (We are exiting an NMI handler, so RCU better be paying attention
-	 * to us!)
-	 */
-	WARN_ON_ONCE(ct_dynticks_nmi_nesting() <= 0);
-	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
-
-	/*
-	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
-	 * leave it in non-RCU-idle state.
-	 */
-	if (ct_dynticks_nmi_nesting() != 1) {
-		trace_rcu_dyntick(TPS("--="), ct_dynticks_nmi_nesting(), ct_dynticks_nmi_nesting() - 2,
-				  ct_dynticks());
-		WRITE_ONCE(ct->dynticks_nmi_nesting, /* No store tearing. */
-			   ct_dynticks_nmi_nesting() - 2);
-		instrumentation_end();
-		return;
-	}
-
-	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), ct_dynticks_nmi_nesting(), 0, ct_dynticks());
-	WRITE_ONCE(ct->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
-
-	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
-	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
-	instrumentation_end();
-
-	// RCU is watching here ...
-	rcu_dynticks_eqs_enter();
-	// ... but is no longer watching here.
-
-	if (!in_nmi())
-		rcu_dynticks_task_enter();
-}
+#endif /* #if defined(CONFIG_NO_HZ_FULL) && (!defined(CONFIG_GENERIC_ENTRY) || !defined(CONFIG_KVM_XFER_TO_GUEST_WORK)) */
 
 #ifdef CONFIG_PROVE_RCU
 /**
@@ -788,81 +600,7 @@ void rcu_irq_exit_check_preempt(void)
 }
 #endif /* #ifdef CONFIG_PROVE_RCU */
 
-/*
- * Exit an RCU extended quiescent state, which can be either the
- * idle loop or adaptive-tickless usermode execution.
- *
- * We crowbar the ->dynticks_nmi_nesting field to DYNTICK_IRQ_NONIDLE to
- * allow for the possibility of usermode upcalls messing up our count of
- * interrupt nesting level during the busy period that is just now starting.
- */
-static void noinstr rcu_eqs_exit(bool user)
-{
-	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
-	long oldval;
-
-	lockdep_assert_irqs_disabled();
-	oldval = ct_dynticks_nesting();
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
-	if (oldval) {
-		// RCU was already watching, so just do accounting and leave.
-		ct->dynticks_nesting++;
-		return;
-	}
-	rcu_dynticks_task_exit();
-	// RCU is not watching here ...
-	rcu_dynticks_eqs_exit();
-	// ... but is watching here.
-	instrumentation_begin();
-
-	// instrumentation for the noinstr rcu_dynticks_eqs_exit()
-	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
-
-	trace_rcu_dyntick(TPS("End"), ct_dynticks_nesting(), 1, ct_dynticks());
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
-	WRITE_ONCE(ct->dynticks_nesting, 1);
-	WARN_ON_ONCE(ct_dynticks_nmi_nesting());
-	WRITE_ONCE(ct->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
-	instrumentation_end();
-}
-
-/**
- * rcu_idle_exit - inform RCU that current CPU is leaving idle
- *
- * Exit idle mode, in other words, -enter- the mode in which RCU
- * read-side critical sections can occur.
- *
- * If you add or remove a call to rcu_idle_exit(), be sure to test with
- * CONFIG_RCU_EQS_DEBUG=y.
- *
- * FIXME: This function should be noinstr but the below local_irq_save() is
- * unsafe because it involves illegal RCU uses through tracing and lockdep.
- * This must be fixed first.
- */
-void rcu_idle_exit(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	rcu_eqs_exit(false);
-	local_irq_restore(flags);
-}
-
 #ifdef CONFIG_NO_HZ_FULL
-/**
- * rcu_user_exit - inform RCU that we are exiting userspace.
- *
- * Exit RCU idle mode while entering the kernel because it can
- * run a RCU read side critical section anytime.
- *
- * If you add or remove a call to rcu_user_exit(), be sure to test with
- * CONFIG_RCU_EQS_DEBUG=y.
- */
-void noinstr rcu_user_exit(void)
-{
-	rcu_eqs_exit(true);
-}
-
 /**
  * __rcu_irq_enter_check_tick - Enable scheduler tick on CPU if RCU needs it.
  *
@@ -925,66 +663,6 @@ void __rcu_irq_enter_check_tick(void)
 }
 #endif /* CONFIG_NO_HZ_FULL */
 
-/**
- * rcu_nmi_enter - inform RCU of entry to NMI context
- *
- * If the CPU was idle from RCU's viewpoint, update ct->dynticks and
- * ct->dynticks_nmi_nesting to let the RCU grace-period handling know
- * that the CPU is active.  This implementation permits nested NMIs, as
- * long as the nesting level does not overflow an int.  (You will probably
- * run out of stack space first.)
- *
- * If you add or remove a call to rcu_nmi_enter(), be sure to test
- * with CONFIG_RCU_EQS_DEBUG=y.
- */
-noinstr void rcu_nmi_enter(void)
-{
-	long incby = 2;
-	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
-
-	/* Complain about underflow. */
-	WARN_ON_ONCE(ct_dynticks_nmi_nesting() < 0);
-
-	/*
-	 * If idle from RCU viewpoint, atomically increment ->dynticks
-	 * to mark non-idle and increment ->dynticks_nmi_nesting by one.
-	 * Otherwise, increment ->dynticks_nmi_nesting by two.  This means
-	 * if ->dynticks_nmi_nesting is equal to one, we are guaranteed
-	 * to be in the outermost NMI handler that interrupted an RCU-idle
-	 * period (observation due to Andy Lutomirski).
-	 */
-	if (rcu_dynticks_curr_cpu_in_eqs()) {
-
-		if (!in_nmi())
-			rcu_dynticks_task_exit();
-
-		// RCU is not watching here ...
-		rcu_dynticks_eqs_exit();
-		// ... but is watching here.
-
-		instrumentation_begin();
-		// instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
-		instrument_atomic_read(&ct->dynticks, sizeof(ct->dynticks));
-		// instrumentation for the noinstr rcu_dynticks_eqs_exit()
-		instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
-
-		incby = 1;
-	} else if (!in_nmi()) {
-		instrumentation_begin();
-		rcu_irq_enter_check_tick();
-	} else  {
-		instrumentation_begin();
-	}
-
-	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
-			  ct_dynticks_nmi_nesting(),
-			  ct_dynticks_nmi_nesting() + incby, ct_dynticks());
-	instrumentation_end();
-	WRITE_ONCE(ct->dynticks_nmi_nesting, /* Prevent store tearing. */
-		   ct_dynticks_nmi_nesting() + incby);
-	barrier();
-}
-
 /*
  * Check to see if any future non-offloaded RCU-related work will need
  * to be done by the current CPU, even if none need be done immediately,
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 11f3e0581782..4ed7f1bdbb0f 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -435,7 +435,6 @@ static void rcu_cpu_kthread_setup(unsigned int cpu);
 static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp);
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 static bool rcu_preempt_need_deferred_qs(struct task_struct *t);
-static void rcu_preempt_deferred_qs(struct task_struct *t);
 static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
@@ -475,10 +474,6 @@ do {								\
 
 static void rcu_bind_gp_kthread(void);
 static bool rcu_nohz_full_cpu(void);
-static void rcu_dynticks_task_enter(void);
-static void rcu_dynticks_task_exit(void);
-static void rcu_dynticks_task_trace_enter(void);
-static void rcu_dynticks_task_trace_exit(void);
 
 /* Forward declarations for tree_stall.h */
 static void record_gp_stall_check_time(void);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 440d9e02a26e..1bb1f571285d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -595,7 +595,7 @@ static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
  * evaluate safety in terms of interrupt, softirq, and preemption
  * disabling.
  */
-static notrace void rcu_preempt_deferred_qs(struct task_struct *t)
+notrace void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	unsigned long flags;
 
@@ -935,7 +935,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 // period for a quiescent state from this CPU.  Note that requests from
 // tasks are handled when removing the task from the blocked-tasks list
 // below.
-static void rcu_preempt_deferred_qs(struct task_struct *t)
+void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
@@ -1290,37 +1290,3 @@ static void rcu_bind_gp_kthread(void)
 		return;
 	housekeeping_affine(current, HK_TYPE_RCU);
 }
-
-/* Record the current task on dyntick-idle entry. */
-static __always_inline void rcu_dynticks_task_enter(void)
-{
-#if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
-	WRITE_ONCE(current->rcu_tasks_idle_cpu, smp_processor_id());
-#endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
-}
-
-/* Record no current task on dyntick-idle exit. */
-static __always_inline void rcu_dynticks_task_exit(void)
-{
-#if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
-	WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
-#endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
-}
-
-/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
-static __always_inline void rcu_dynticks_task_trace_enter(void)
-{
-#ifdef CONFIG_TASKS_TRACE_RCU
-	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
-		current->trc_reader_special.b.need_mb = true;
-#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
-}
-
-/* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
-static __always_inline void rcu_dynticks_task_trace_exit(void)
-{
-#ifdef CONFIG_TASKS_TRACE_RCU
-	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
-		current->trc_reader_special.b.need_mb = false;
-#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
-}
-- 
2.25.1


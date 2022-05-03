Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FE45181F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiECKHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiECKGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:06:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761FD393C7
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 03:02:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3E3160EB1
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5320AC385B3;
        Tue,  3 May 2022 10:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651572120;
        bh=IjWhJv0cZJOyDiXpsKZ3xyRacemptGlTDpAeI5xPX5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b6SAaws+zO6LiHHUMGE/WjOvTHdj+GYnSfrCnXekq+2xW2JzPpnrRUCYj5F8vrPvm
         8eF8CQ0exk6T5Px9VmTW0lugx/7GxvE7bQNX9ef1vNYnwJvvwjDr3g2EAlqrJNchmd
         U5sMjz85J6tQ3f+cWWMEHqfSL+twp5Or+hXFnv6I1hPI00M43htsdQMKrMzWcIbul0
         lszR1UonQO6wjKqgxQSIBE1myE5xi1iPV2jMX8JHgfrh7Jc0niTIBsFjedO+djrZN4
         A60+bF1wBhhuOd1zutfd7hK2wNGWyakfQqzgPZQz7z0DPs/cY9QgPXV548wiiyBLgk
         k+uR0C4tstAgg==
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
Subject: [PATCH 16/21] rcu/context_tracking: Move dynticks_nmi_nesting to context tracking
Date:   Tue,  3 May 2022 12:00:46 +0200
Message-Id: <20220503100051.2799723-17-frederic@kernel.org>
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

The RCU eqs tracking is going to be performed by the context tracking
subsystem. The related nesting counters thus need to be moved to the
context tracking structure.

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
 include/linux/context_tracking_state.h | 15 ++++++++
 kernel/context_tracking.c              |  1 +
 kernel/rcu/rcu.h                       |  4 ---
 kernel/rcu/tree.c                      | 48 +++++++++++---------------
 kernel/rcu/tree.h                      |  1 -
 kernel/rcu/tree_stall.h                |  2 +-
 6 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index cd3a09fb0aea..ded257130987 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -6,6 +6,9 @@
 #include <linux/static_key.h>
 #include <linux/context_tracking_irq.h>
 
+/* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
+#define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
+
 struct context_tracking {
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 	/*
@@ -25,6 +28,7 @@ struct context_tracking {
 #endif
 	atomic_t dynticks;		/* Even value for idle, else odd. */
 	long dynticks_nesting;		/* Track process nesting level. */
+	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
 };
 
 #ifdef CONFIG_CONTEXT_TRACKING
@@ -57,6 +61,17 @@ static __always_inline long ct_dynticks_nesting_cpu(int cpu)
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 	return ct->dynticks_nesting;
 }
+
+static __always_inline long ct_dynticks_nmi_nesting(void)
+{
+	return __this_cpu_read(context_tracking.dynticks_nmi_nesting);
+}
+
+static __always_inline long ct_dynticks_nmi_nesting_cpu(int cpu)
+{
+	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
+	return ct->dynticks_nmi_nesting;
+}
 #endif
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index ae86fab4eab5..14f04c521573 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -250,6 +250,7 @@ void __init context_tracking_init(void)
 #endif /* #ifdef CONFIG_CONTEXT_TRACKING_USER */
 
 DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
+		.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 		.dynticks_nesting = 1,
 		.dynticks = ATOMIC_INIT(1),
 };
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 15b96f990774..f86584fe90ba 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -12,10 +12,6 @@
 
 #include <trace/events/rcu.h>
 
-/* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
-#define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
-
-
 /*
  * Grace-period counter management.
  */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 826946b39943..7b1404db3c17 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -75,7 +75,6 @@
 /* Data structures. */
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
-	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 #ifdef CONFIG_RCU_NOCB_CPU
 	.cblist.flags = SEGCBLIST_RCU_CORE,
 #endif
@@ -437,11 +436,11 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	/* Check for counter underflows */
 	RCU_LOCKDEP_WARN(ct_dynticks_nesting() < 0,
 			 "RCU dynticks_nesting counter underflow!");
-	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
+	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() <= 0,
 			 "RCU dynticks_nmi_nesting counter underflow/zero!");
 
 	/* Are we at first interrupt nesting level? */
-	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
+	nesting = ct_dynticks_nmi_nesting();
 	if (nesting > 1)
 		return false;
 
@@ -612,11 +611,10 @@ EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
  */
 static noinstr void rcu_eqs_enter(bool user)
 {
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
-	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
-	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
+	WARN_ON_ONCE(ct_dynticks_nmi_nesting() != DYNTICK_IRQ_NONIDLE);
+	WRITE_ONCE(ct->dynticks_nmi_nesting, 0);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     ct_dynticks_nesting() == 0);
 	if (ct_dynticks_nesting() != 1) {
@@ -734,7 +732,7 @@ noinstr void rcu_user_enter(void)
  * rcu_nmi_exit - inform RCU of exit from NMI context
  *
  * If we are returning from the outermost NMI handler that interrupted an
- * RCU-idle period, update ct->dynticks and rdp->dynticks_nmi_nesting
+ * RCU-idle period, update ct->dynticks and ct->dynticks_nmi_nesting
  * to let the RCU grace-period handling know that the CPU is back to
  * being RCU-idle.
  *
@@ -744,7 +742,6 @@ noinstr void rcu_user_enter(void)
 noinstr void rcu_nmi_exit(void)
 {
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	instrumentation_begin();
 	/*
@@ -752,25 +749,25 @@ noinstr void rcu_nmi_exit(void)
 	 * (We are exiting an NMI handler, so RCU better be paying attention
 	 * to us!)
 	 */
-	WARN_ON_ONCE(rdp->dynticks_nmi_nesting <= 0);
+	WARN_ON_ONCE(ct_dynticks_nmi_nesting() <= 0);
 	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
 
 	/*
 	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
 	 * leave it in non-RCU-idle state.
 	 */
-	if (rdp->dynticks_nmi_nesting != 1) {
-		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
+	if (ct_dynticks_nmi_nesting() != 1) {
+		trace_rcu_dyntick(TPS("--="), ct_dynticks_nmi_nesting(), ct_dynticks_nmi_nesting() - 2,
 				  ct_dynticks());
-		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
-			   rdp->dynticks_nmi_nesting - 2);
+		WRITE_ONCE(ct->dynticks_nmi_nesting, /* No store tearing. */
+			   ct_dynticks_nmi_nesting() - 2);
 		instrumentation_end();
 		return;
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, ct_dynticks());
-	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
+	trace_rcu_dyntick(TPS("Startirq"), ct_dynticks_nmi_nesting(), 0, ct_dynticks());
+	WRITE_ONCE(ct->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
 	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
 	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
@@ -794,7 +791,7 @@ void rcu_irq_exit_check_preempt(void)
 
 	RCU_LOCKDEP_WARN(ct_dynticks_nesting() <= 0,
 			 "RCU dynticks_nesting counter underflow/zero!");
-	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) !=
+	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() !=
 			 DYNTICK_IRQ_NONIDLE,
 			 "Bad RCU  dynticks_nmi_nesting counter\n");
 	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
@@ -813,11 +810,9 @@ void rcu_irq_exit_check_preempt(void)
 static void noinstr rcu_eqs_exit(bool user)
 {
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
-	struct rcu_data *rdp;
 	long oldval;
 
 	lockdep_assert_irqs_disabled();
-	rdp = this_cpu_ptr(&rcu_data);
 	oldval = ct_dynticks_nesting();
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
 	if (oldval) {
@@ -837,8 +832,8 @@ static void noinstr rcu_eqs_exit(bool user)
 	trace_rcu_dyntick(TPS("End"), ct_dynticks_nesting(), 1, ct_dynticks());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(ct->dynticks_nesting, 1);
-	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
-	WRITE_ONCE(rdp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
+	WARN_ON_ONCE(ct_dynticks_nmi_nesting());
+	WRITE_ONCE(ct->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
 	instrumentation_end();
 }
 
@@ -945,7 +940,7 @@ void __rcu_irq_enter_check_tick(void)
  * rcu_nmi_enter - inform RCU of entry to NMI context
  *
  * If the CPU was idle from RCU's viewpoint, update ct->dynticks and
- * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
+ * ct->dynticks_nmi_nesting to let the RCU grace-period handling know
  * that the CPU is active.  This implementation permits nested NMIs, as
  * long as the nesting level does not overflow an int.  (You will probably
  * run out of stack space first.)
@@ -956,11 +951,10 @@ void __rcu_irq_enter_check_tick(void)
 noinstr void rcu_nmi_enter(void)
 {
 	long incby = 2;
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
 	/* Complain about underflow. */
-	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
+	WARN_ON_ONCE(ct_dynticks_nmi_nesting() < 0);
 
 	/*
 	 * If idle from RCU viewpoint, atomically increment ->dynticks
@@ -994,11 +988,11 @@ noinstr void rcu_nmi_enter(void)
 	}
 
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
-			  rdp->dynticks_nmi_nesting,
-			  rdp->dynticks_nmi_nesting + incby, ct_dynticks());
+			  ct_dynticks_nmi_nesting(),
+			  ct_dynticks_nmi_nesting() + incby, ct_dynticks());
 	instrumentation_end();
-	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
-		   rdp->dynticks_nmi_nesting + incby);
+	WRITE_ONCE(ct->dynticks_nmi_nesting, /* Prevent store tearing. */
+		   ct_dynticks_nmi_nesting() + incby);
 	barrier();
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 26400b511c5b..11f3e0581782 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -191,7 +191,6 @@ struct rcu_data {
 
 	/* 3) dynticks interface. */
 	int dynticks_snap;		/* Per-GP tracking for dynticks. */
-	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
 	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
 	bool rcu_forced_tick;		/* Forced tick to provide QS. */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 0235c03c8642..933445d826f1 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -477,7 +477,7 @@ static void print_cpu_stall_info(int cpu)
 				"!."[!delta],
 	       ticks_value, ticks_title,
 	       rcu_dynticks_snap(cpu) & 0xfff,
-	       ct_dynticks_nesting_cpu(cpu), rdp->dynticks_nmi_nesting,
+	       ct_dynticks_nesting_cpu(cpu), ct_dynticks_nmi_nesting_cpu(cpu),
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
 	       rcuc_starved ? buf : "",
-- 
2.25.1


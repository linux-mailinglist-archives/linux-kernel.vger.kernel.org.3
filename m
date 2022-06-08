Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F905432E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241880AbiFHOnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241873AbiFHOmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:42:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAAB18C06A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C29E61B9C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762D1C36AFF;
        Wed,  8 Jun 2022 14:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654699295;
        bh=brhVaSfjXzn5ay7jCuchujDwc07f8/vcN+lzcYVVxLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXqs90bS2LZ9aKcPyPuonqxVw0Z7MH+dwfyuHgzwUDY50jywAUesaJ3t9GjDyaIAa
         tl4WBWc0UEpuJ5LrX0zQpbwa4OhK9DdmkOyhOiaRw16eIDd/myqt/iELH9NQ0kWmGO
         pcv5prDIyfkaoldDtgfl+w+MyowlicEylrllJl3ZZHLWzOyvxPf+3b1eJxow1F67Pf
         yuLnvxy62wsXXpYc4h2Mq7M68sdyxNx9NNI6teKO4FBPhnn7lcVUkm6+O2YxntqdYz
         CG97qhZkNgAJKxin6UHgGSo0qBSVBXmeNUUKsgQ5woWachrkuMcp2VnF7I0BtdMV9F
         uCLLetfjpTOtA==
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
Subject: [PATCH 14/20] rcu/context_tracking: Move dynticks_nmi_nesting to context tracking
Date:   Wed,  8 Jun 2022 16:40:31 +0200
Message-Id: <20220608144037.1765000-15-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608144037.1765000-1-frederic@kernel.org>
References: <20220608144037.1765000-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 164f4673ee74..b99e9827cc08 100644
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
@@ -26,6 +29,7 @@ struct context_tracking {
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
 	atomic_t dynticks;		/* Even value for idle, else odd. */
 	long dynticks_nesting;		/* Track process nesting level. */
+	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
 #endif
 };
 
@@ -61,6 +65,17 @@ static __always_inline long ct_dynticks_nesting_cpu(int cpu)
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
 #endif /* #ifdef CONFIG_CONTEXT_TRACKING_IDLE */
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index d5ff1de1a24a..95ce83904287 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -26,6 +26,7 @@
 DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
 	.dynticks_nesting = 1,
+	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 	.dynticks = ATOMIC_INIT(1),
 #endif
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
index 5e7771c78162..ef734577b63d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -75,7 +75,6 @@
 /* Data structures. */
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
-	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 #ifdef CONFIG_RCU_NOCB_CPU
 	.cblist.flags = SEGCBLIST_RCU_CORE,
 #endif
@@ -441,11 +440,11 @@ static int rcu_is_cpu_rrupt_from_idle(void)
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
 
@@ -616,11 +615,10 @@ EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
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
@@ -738,7 +736,7 @@ noinstr void rcu_user_enter(void)
  * rcu_nmi_exit - inform RCU of exit from NMI context
  *
  * If we are returning from the outermost NMI handler that interrupted an
- * RCU-idle period, update ct->dynticks and rdp->dynticks_nmi_nesting
+ * RCU-idle period, update ct->dynticks and ct->dynticks_nmi_nesting
  * to let the RCU grace-period handling know that the CPU is back to
  * being RCU-idle.
  *
@@ -748,7 +746,6 @@ noinstr void rcu_user_enter(void)
 noinstr void rcu_nmi_exit(void)
 {
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	instrumentation_begin();
 	/*
@@ -756,25 +753,25 @@ noinstr void rcu_nmi_exit(void)
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
@@ -798,7 +795,7 @@ void rcu_irq_exit_check_preempt(void)
 
 	RCU_LOCKDEP_WARN(ct_dynticks_nesting() <= 0,
 			 "RCU dynticks_nesting counter underflow/zero!");
-	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) !=
+	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() !=
 			 DYNTICK_IRQ_NONIDLE,
 			 "Bad RCU  dynticks_nmi_nesting counter\n");
 	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
@@ -817,11 +814,9 @@ void rcu_irq_exit_check_preempt(void)
 static void noinstr rcu_eqs_exit(bool user)
 {
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
-	struct rcu_data *rdp;
 	long oldval;
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
-	rdp = this_cpu_ptr(&rcu_data);
 	oldval = ct_dynticks_nesting();
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
 	if (oldval) {
@@ -841,8 +836,8 @@ static void noinstr rcu_eqs_exit(bool user)
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
index 642b11cd8027..12e249fbaf1e 100644
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
index b5195bbd9ebc..91e4fd4db12d 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -479,7 +479,7 @@ static void print_cpu_stall_info(int cpu)
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3F05527F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345899AbiFTXPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346334AbiFTXMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:12:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC3C22533;
        Mon, 20 Jun 2022 16:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62F21B8165E;
        Mon, 20 Jun 2022 23:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A17AC341ED;
        Mon, 20 Jun 2022 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766632;
        bh=R3hcoW5ExwknpCngoAMjefhT0YNygpom+qlLYf4jL/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eyfj8AXL1XhBDxx/mWyeGeicje0GqMau+mbaNztRvMH54ixQ73lnp3BzUf/LL92Ya
         /1p734I3r2arJ7BTXSHE9J5GkD3NayjmSTj/592Ey7PT1ufLj7RFtY2seBjTVynTjB
         vsT6VFIFPk1mfme6tTVri0oiwG7TCgTacEEYSb0t6mvf624Qk2iSVAo/r+yKue67xa
         G63NvLlQitvw2OR2nwQs3quekcXuFAKUPm3Kugt+U1C9AJoWw36LPet9BbU8yHWA4y
         8593QvpBZC6qNKB5/sDetUsyXnx/TBiJerNP2L+jEdPv6yAuAyR7a3QKQNUmbOkICN
         8Y98LepdRgWhQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6B7555C0FCA; Mon, 20 Jun 2022 16:10:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>, Phil Auld <pauld@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alex Belits <abelits@marvell.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 16/23] rcu/context_tracking: Move dynticks_nmi_nesting to context tracking
Date:   Mon, 20 Jun 2022 16:10:22 -0700
Message-Id: <20220620231029.3844583-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
References: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
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

From: Frederic Weisbecker <frederic@kernel.org>

The RCU eqs tracking is going to be performed by the context tracking
subsystem. The related nesting counters thus need to be moved to the
context tracking structure.

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
---
 include/linux/context_tracking_state.h | 15 ++++++++
 kernel/context_tracking.c              |  1 +
 kernel/rcu/rcu.h                       |  4 ---
 kernel/rcu/tree.c                      | 48 +++++++++++---------------
 kernel/rcu/tree.h                      |  1 -
 kernel/rcu/tree_stall.h                |  2 +-
 6 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index c866701c7edb5..2f957b48e24f9 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -13,6 +13,9 @@ enum ctx_state {
 	CONTEXT_GUEST,
 };
 
+/* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
+#define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
+
 struct context_tracking {
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 	/*
@@ -28,6 +31,7 @@ struct context_tracking {
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
 	atomic_t dynticks;		/* Even value for idle, else odd. */
 	long dynticks_nesting;		/* Track process nesting level. */
+	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
 #endif
 };
 
@@ -63,6 +67,17 @@ static __always_inline long ct_dynticks_nesting_cpu(int cpu)
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
index ed6c062aff9fa..bf5f498b21d39 100644
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
index 4916077119f3f..7b4a88deff9ad 100644
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
index f6bf328bb9cfd..006939b29e823 100644
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
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
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
 
@@ -941,7 +936,7 @@ void __rcu_irq_enter_check_tick(void)
  * rcu_nmi_enter - inform RCU of entry to NMI context
  *
  * If the CPU was idle from RCU's viewpoint, update ct->dynticks and
- * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
+ * ct->dynticks_nmi_nesting to let the RCU grace-period handling know
  * that the CPU is active.  This implementation permits nested NMIs, as
  * long as the nesting level does not overflow an int.  (You will probably
  * run out of stack space first.)
@@ -952,11 +947,10 @@ void __rcu_irq_enter_check_tick(void)
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
@@ -990,11 +984,11 @@ noinstr void rcu_nmi_enter(void)
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
index 650ff3cf01219..72dbf8512ce78 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -187,7 +187,6 @@ struct rcu_data {
 
 	/* 3) dynticks interface. */
 	int dynticks_snap;		/* Per-GP tracking for dynticks. */
-	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
 	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
 	bool rcu_forced_tick;		/* Forced tick to provide QS. */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index a9c82254b6c65..2683ce0a7c724 100644
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
2.31.1.189.g2e36527f23


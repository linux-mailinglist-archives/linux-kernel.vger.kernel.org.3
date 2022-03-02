Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B154CA997
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242513AbiCBPul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242036AbiCBPuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:50:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD8A3E0DD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:48:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BE58B82088
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BA0C340F2;
        Wed,  2 Mar 2022 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646236134;
        bh=A5lJuMe8z5DgyT0Sqvsr43k4rr8YOnF8m07M+knzFTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwaKCk4dn7ZhTEbEyd8O3rxbr8MmazkpdP4byud4j6JjysAte95Rc7foN+pjCdgJI
         g+tNumJn9uxGr6Z7J3JI/mB1wwzLPCoF+6kQUXtG70r8xfQsq0kZ0RaqB1gTQm5Mpe
         rhomiJZ0L3YJV5Xtw4DXxAe4YUOLFKqZLvrFX+9dypRC3Oh9l7HRmacXZkQ4v8Y0My
         wH3hvh5TTNqHByz5/OyT9Bl4kf7NbqZgiSFW4QfNvoHx2Eq93AIPGlDznmjnAdb4gc
         +M7fJx0ibDJxA560zvdCKcPznMtpSKtbTLRpSdVOyKYvrRfvxRwhGLgvcElSPIIE3U
         LeRaUChojkQdA==
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
Subject: [PATCH 10/19] rcu/context_tracking: Move dynticks counter to context tracking
Date:   Wed,  2 Mar 2022 16:48:01 +0100
Message-Id: <20220302154810.42308-11-frederic@kernel.org>
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

In order to prepare for merging RCU dynticks counter into the context
tracking state, move the rcu_data's dynticks field to the context
tracking structure. It will later be mixed within the context tracking
state itself.

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
 include/linux/context_tracking_state.h | 10 ++++-
 kernel/context_tracking.c              |  9 ++--
 kernel/rcu/tree.c                      | 59 ++++++++++++++------------
 kernel/rcu/tree.h                      |  1 -
 kernel/rcu/tree_exp.h                  |  2 +-
 kernel/rcu/tree_stall.h                |  4 +-
 6 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index cdc692caa01d..5ad0e481c5a3 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -7,6 +7,7 @@
 #include <linux/context_tracking_irq.h>
 
 struct context_tracking {
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	/*
 	 * When active is false, probes are unset in order
 	 * to minimize overhead: TIF flags are cleared
@@ -21,11 +22,16 @@ struct context_tracking {
 		CONTEXT_USER,
 		CONTEXT_GUEST,
 	} state;
+#endif
+	atomic_t dynticks;		/* Even value for idle, else odd. */
 };
 
-#ifdef CONFIG_CONTEXT_TRACKING_USER
-extern struct static_key_false context_tracking_key;
+#ifdef CONFIG_CONTEXT_TRACKING
 DECLARE_PER_CPU(struct context_tracking, context_tracking);
+#endif
+
+#ifdef CONFIG_CONTEXT_TRACKING_USER
+extern struct static_key_false context_tracking_key;
 
 static __always_inline bool context_tracking_enabled(void)
 {
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index ea22eb04750f..77b61a7c9890 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -30,9 +30,6 @@
 DEFINE_STATIC_KEY_FALSE(context_tracking_key);
 EXPORT_SYMBOL_GPL(context_tracking_key);
 
-DEFINE_PER_CPU(struct context_tracking, context_tracking);
-EXPORT_SYMBOL_GPL(context_tracking);
-
 static noinstr bool context_tracking_recursion_enter(void)
 {
 	int recursion;
@@ -236,6 +233,12 @@ void __init context_tracking_init(void)
 
 #endif /* #ifdef CONFIG_CONTEXT_TRACKING_USER */
 
+DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
+		.dynticks = ATOMIC_INIT(1),
+};
+EXPORT_SYMBOL_GPL(context_tracking);
+
+
 void ct_idle_enter(void)
 {
 	rcu_idle_enter();
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cadf5f5a4700..96eb8503f28e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -77,7 +77,6 @@
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
-	.dynticks = ATOMIC_INIT(1),
 #ifdef CONFIG_RCU_NOCB_CPU
 	.cblist.flags = SEGCBLIST_RCU_CORE,
 #endif
@@ -268,7 +267,7 @@ void rcu_softirq_qs(void)
  */
 static noinline noinstr unsigned long rcu_dynticks_inc(int incby)
 {
-	return arch_atomic_add_return(incby, this_cpu_ptr(&rcu_data.dynticks));
+	return arch_atomic_add_return(incby, this_cpu_ptr(&context_tracking.dynticks));
 }
 
 /*
@@ -324,9 +323,9 @@ static noinstr void rcu_dynticks_eqs_exit(void)
  */
 static void rcu_dynticks_eqs_online(void)
 {
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
-	if (atomic_read(&rdp->dynticks) & 0x1)
+	if (atomic_read(&ct->dynticks) & 0x1)
 		return;
 	rcu_dynticks_inc(1);
 }
@@ -338,17 +337,19 @@ static void rcu_dynticks_eqs_online(void)
  */
 static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
-	return !(arch_atomic_read(this_cpu_ptr(&rcu_data.dynticks)) & 0x1);
+	return !(arch_atomic_read(this_cpu_ptr(&context_tracking.dynticks)) & 0x1);
 }
 
 /*
  * Snapshot the ->dynticks counter with full ordering so as to allow
  * stable comparison of this counter with past and future snapshots.
  */
-static int rcu_dynticks_snap(struct rcu_data *rdp)
+static int rcu_dynticks_snap(int cpu)
 {
+	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
+
 	smp_mb();  // Fundamental RCU ordering guarantee.
-	return atomic_read_acquire(&rdp->dynticks);
+	return atomic_read_acquire(&ct->dynticks);
 }
 
 /*
@@ -363,9 +364,7 @@ static bool rcu_dynticks_in_eqs(int snap)
 /* Return true if the specified CPU is currently idle from an RCU viewpoint.  */
 bool rcu_is_idle_cpu(int cpu)
 {
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-
-	return rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
+	return rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
 }
 
 /*
@@ -375,7 +374,7 @@ bool rcu_is_idle_cpu(int cpu)
  */
 static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
 {
-	return snap != rcu_dynticks_snap(rdp);
+	return snap != rcu_dynticks_snap(rdp->cpu);
 }
 
 /*
@@ -384,11 +383,11 @@ static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
  */
 bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
 {
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 	int snap;
 
 	// If not quiescent, force back to earlier extended quiescent state.
-	snap = atomic_read(&rdp->dynticks) & ~0x1;
+	snap = atomic_read(&ct->dynticks) & ~0x1;
 
 	smp_rmb(); // Order ->dynticks and *vp reads.
 	if (READ_ONCE(*vp))
@@ -396,7 +395,7 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
 	smp_rmb(); // Order *vp read and ->dynticks re-read.
 
 	// If still in the same extended quiescent state, we are good!
-	return snap == atomic_read(&rdp->dynticks);
+	return snap == atomic_read(&ct->dynticks);
 }
 
 /*
@@ -620,6 +619,7 @@ EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 static noinstr void rcu_eqs_enter(bool user)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
@@ -633,12 +633,12 @@ static noinstr void rcu_eqs_enter(bool user)
 
 	lockdep_assert_irqs_disabled();
 	instrumentation_begin();
-	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
+	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&ct->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rcu_preempt_deferred_qs(current);
 
 	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
-	instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
+	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
 
 	instrumentation_end();
 	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid irq-access tearing. */
@@ -740,7 +740,7 @@ noinstr void rcu_user_enter(void)
  * rcu_nmi_exit - inform RCU of exit from NMI context
  *
  * If we are returning from the outermost NMI handler that interrupted an
- * RCU-idle period, update rdp->dynticks and rdp->dynticks_nmi_nesting
+ * RCU-idle period, update ct->dynticks and rdp->dynticks_nmi_nesting
  * to let the RCU grace-period handling know that the CPU is back to
  * being RCU-idle.
  *
@@ -749,6 +749,7 @@ noinstr void rcu_user_enter(void)
  */
 noinstr void rcu_nmi_exit(void)
 {
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	instrumentation_begin();
@@ -766,7 +767,7 @@ noinstr void rcu_nmi_exit(void)
 	 */
 	if (rdp->dynticks_nmi_nesting != 1) {
 		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
-				  atomic_read(&rdp->dynticks));
+				  atomic_read(&ct->dynticks));
 		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
 			   rdp->dynticks_nmi_nesting - 2);
 		instrumentation_end();
@@ -774,11 +775,11 @@ noinstr void rcu_nmi_exit(void)
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
+	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&ct->dynticks));
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
 	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
-	instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
+	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
 	instrumentation_end();
 
 	// RCU is watching here ...
@@ -817,6 +818,7 @@ void rcu_irq_exit_check_preempt(void)
  */
 static void noinstr rcu_eqs_exit(bool user)
 {
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 	struct rcu_data *rdp;
 	long oldval;
 
@@ -836,9 +838,9 @@ static void noinstr rcu_eqs_exit(bool user)
 	instrumentation_begin();
 
 	// instrumentation for the noinstr rcu_dynticks_eqs_exit()
-	instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
+	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
 
-	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
+	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&ct->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdp->dynticks_nesting, 1);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
@@ -944,7 +946,7 @@ void __rcu_irq_enter_check_tick(void)
 /**
  * rcu_nmi_enter - inform RCU of entry to NMI context
  *
- * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
+ * If the CPU was idle from RCU's viewpoint, update ct->dynticks and
  * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
  * that the CPU is active.  This implementation permits nested NMIs, as
  * long as the nesting level does not overflow an int.  (You will probably
@@ -957,6 +959,7 @@ noinstr void rcu_nmi_enter(void)
 {
 	long incby = 2;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
 	/* Complain about underflow. */
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
@@ -980,9 +983,9 @@ noinstr void rcu_nmi_enter(void)
 
 		instrumentation_begin();
 		// instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
-		instrument_atomic_read(&rdp->dynticks, sizeof(rdp->dynticks));
+		instrument_atomic_read(&ct->dynticks, sizeof(ct->dynticks));
 		// instrumentation for the noinstr rcu_dynticks_eqs_exit()
-		instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
+		instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
 
 		incby = 1;
 	} else if (!in_nmi()) {
@@ -994,7 +997,7 @@ noinstr void rcu_nmi_enter(void)
 
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
 			  rdp->dynticks_nmi_nesting,
-			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
+			  rdp->dynticks_nmi_nesting + incby, atomic_read(&ct->dynticks));
 	instrumentation_end();
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
 		   rdp->dynticks_nmi_nesting + incby);
@@ -1138,7 +1141,7 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
  */
 static int dyntick_save_progress_counter(struct rcu_data *rdp)
 {
-	rdp->dynticks_snap = rcu_dynticks_snap(rdp);
+	rdp->dynticks_snap = rcu_dynticks_snap(rdp->cpu);
 	if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
@@ -4125,7 +4128,7 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
 	INIT_WORK(&rdp->strict_work, strict_work_handler);
 	WARN_ON_ONCE(rdp->dynticks_nesting != 1);
-	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp)));
+	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu)));
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_ofl_gp_flags = RCU_GP_CLEANED;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b8d07bf92d29..15246a3f0734 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -188,7 +188,6 @@ struct rcu_data {
 	int dynticks_snap;		/* Per-GP tracking for dynticks. */
 	long dynticks_nesting;		/* Track process nesting level. */
 	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
-	atomic_t dynticks;		/* Even value for idle, else odd. */
 	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
 	bool rcu_forced_tick;		/* Forced tick to provide QS. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index d5f30085b0cf..2210110990f4 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -358,7 +358,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 		    !(rnp->qsmaskinitnext & mask)) {
 			mask_ofl_test |= mask;
 		} else {
-			snap = rcu_dynticks_snap(rdp);
+			snap = rcu_dynticks_snap(cpu);
 			if (rcu_dynticks_in_eqs(snap))
 				mask_ofl_test |= mask;
 			else
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 84b812a3ab44..202129b1c7e4 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -448,7 +448,7 @@ static void print_cpu_stall_info(int cpu)
 	}
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
-			rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
+			rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
 	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
@@ -458,7 +458,7 @@ static void print_cpu_stall_info(int cpu)
 			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
 				"!."[!delta],
 	       ticks_value, ticks_title,
-	       rcu_dynticks_snap(rdp) & 0xfff,
+	       rcu_dynticks_snap(cpu) & 0xfff,
 	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
-- 
2.25.1


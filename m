Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B4B5432E4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242069AbiFHOoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241902AbiFHOmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:42:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A14182A61
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:41:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CF44B8284A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214FDC3411D;
        Wed,  8 Jun 2022 14:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654699288;
        bh=qGrUIfwXvG7yTxjwej4vdlqsYZxH6ontr3GA8ffj/ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CmjcbQcmu5TVYlkl1YvsSds93nbQpfLMYZ/JXbDZVfg+00EiMeiyPnEmwJ1it53QM
         I2kCOdO0P65XwYcfRZuwc1PQ4RP3VtkMsQg7EyuxAMohjynecIXkOujB8TBxrixb35
         mk5UDmnXJb732fItA6u7belr4WJXZbmm3TYnp5VJums/JuSpwu2v092dvFdlXrs7PG
         am6GmMoPHNgkLhLPM8OrWvMQcGwXnUaVObbdy3SvkRUCz4DuPHtrpM/jQK0MCwz8E4
         0AFdNCjuSqdX5SmX3wb4q8mHFScS4sV3KosujH3MwnkrVF6z+vO3VUPVWbpneLwSC3
         E+M+sJCjZBoNA==
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
Subject: [PATCH 12/20] rcu/context_tracking: Move dynticks counter to context tracking
Date:   Wed,  8 Jun 2022 16:40:29 +0200
Message-Id: <20220608144037.1765000-13-frederic@kernel.org>
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

In order to prepare for merging RCU dynticks counter into the context
tracking state, move the rcu_data's dynticks field to the context
tracking structure. It will later be mixed within the context tracking
state itself.

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
 include/linux/context_tracking_state.h | 31 +++++++++++++-
 kernel/context_tracking.c              | 10 +++--
 kernel/rcu/tree.c                      | 56 +++++++++++++-------------
 kernel/rcu/tree.h                      |  1 -
 kernel/rcu/tree_exp.h                  |  2 +-
 kernel/rcu/tree_stall.h                |  4 +-
 6 files changed, 66 insertions(+), 38 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 7b46b43b8c98..651bb9c353f0 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -7,6 +7,7 @@
 #include <linux/context_tracking_irq.h>
 
 struct context_tracking {
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	/*
 	 * When active is false, probes are unset in order
 	 * to minimize overhead: TIF flags are cleared
@@ -21,11 +22,37 @@ struct context_tracking {
 		CONTEXT_USER,
 		CONTEXT_GUEST,
 	} state;
+#endif
+#ifdef CONFIG_CONTEXT_TRACKING_IDLE
+	atomic_t dynticks;		/* Even value for idle, else odd. */
+#endif
 };
 
-#ifdef CONFIG_CONTEXT_TRACKING_USER
-extern struct static_key_false context_tracking_key;
+#ifdef CONFIG_CONTEXT_TRACKING
 DECLARE_PER_CPU(struct context_tracking, context_tracking);
+#endif
+
+#ifdef CONFIG_CONTEXT_TRACKING_IDLE
+static __always_inline int ct_dynticks(void)
+{
+	return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
+}
+
+static __always_inline int ct_dynticks_cpu(int cpu)
+{
+	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
+	return atomic_read(&ct->dynticks);
+}
+
+static __always_inline int ct_dynticks_cpu_acquire(int cpu)
+{
+	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
+	return atomic_read_acquire(&ct->dynticks);
+}
+#endif /* #ifdef CONFIG_CONTEXT_TRACKING_IDLE */
+
+#ifdef CONFIG_CONTEXT_TRACKING_USER
+extern struct static_key_false context_tracking_key;
 
 static __always_inline bool context_tracking_enabled(void)
 {
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index c55de8a12c49..3475dbfa4d73 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -23,6 +23,13 @@
 #include <linux/kprobes.h>
 
 
+DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
+#ifdef CONFIG_CONTEXT_TRACKING_IDLE
+	.dynticks = ATOMIC_INIT(1),
+#endif
+};
+EXPORT_SYMBOL_GPL(context_tracking);
+
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
 noinstr void ct_idle_enter(void)
 {
@@ -138,9 +145,6 @@ noinstr void ct_nmi_exit(void)
 DEFINE_STATIC_KEY_FALSE(context_tracking_key);
 EXPORT_SYMBOL_GPL(context_tracking_key);
 
-DEFINE_PER_CPU(struct context_tracking, context_tracking);
-EXPORT_SYMBOL_GPL(context_tracking);
-
 static noinstr bool context_tracking_recursion_enter(void)
 {
 	int recursion;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5e4047cdd8f9..5c9ca5900540 100644
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
@@ -272,7 +271,7 @@ void rcu_softirq_qs(void)
  */
 static noinline noinstr unsigned long rcu_dynticks_inc(int incby)
 {
-	return arch_atomic_add_return(incby, this_cpu_ptr(&rcu_data.dynticks));
+	return arch_atomic_add_return(incby, this_cpu_ptr(&context_tracking.dynticks));
 }
 
 /*
@@ -328,9 +327,7 @@ static noinstr void rcu_dynticks_eqs_exit(void)
  */
 static void rcu_dynticks_eqs_online(void)
 {
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-
-	if (atomic_read(&rdp->dynticks) & 0x1)
+	if (ct_dynticks() & 0x1)
 		return;
 	rcu_dynticks_inc(1);
 }
@@ -342,17 +339,17 @@ static void rcu_dynticks_eqs_online(void)
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
 	smp_mb();  // Fundamental RCU ordering guarantee.
-	return atomic_read_acquire(&rdp->dynticks);
+	return ct_dynticks_cpu_acquire(cpu);
 }
 
 /*
@@ -367,9 +364,7 @@ static bool rcu_dynticks_in_eqs(int snap)
 /* Return true if the specified CPU is currently idle from an RCU viewpoint.  */
 bool rcu_is_idle_cpu(int cpu)
 {
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-
-	return rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
+	return rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
 }
 
 /*
@@ -379,7 +374,7 @@ bool rcu_is_idle_cpu(int cpu)
  */
 static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
 {
-	return snap != rcu_dynticks_snap(rdp);
+	return snap != rcu_dynticks_snap(rdp->cpu);
 }
 
 /*
@@ -388,11 +383,10 @@ static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
  */
 bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
 {
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	int snap;
 
 	// If not quiescent, force back to earlier extended quiescent state.
-	snap = atomic_read(&rdp->dynticks) & ~0x1;
+	snap = ct_dynticks_cpu(cpu) & ~0x1;
 
 	smp_rmb(); // Order ->dynticks and *vp reads.
 	if (READ_ONCE(*vp))
@@ -400,7 +394,7 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
 	smp_rmb(); // Order *vp read and ->dynticks re-read.
 
 	// If still in the same extended quiescent state, we are good!
-	return snap == atomic_read(&rdp->dynticks);
+	return snap == ct_dynticks_cpu(cpu);
 }
 
 /*
@@ -624,6 +618,7 @@ EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 static noinstr void rcu_eqs_enter(bool user)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
@@ -637,12 +632,12 @@ static noinstr void rcu_eqs_enter(bool user)
 
 	instrumentation_begin();
 	lockdep_assert_irqs_disabled();
-	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
+	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, ct_dynticks());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rcu_preempt_deferred_qs(current);
 
 	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
-	instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
+	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
 
 	instrumentation_end();
 	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid irq-access tearing. */
@@ -744,7 +739,7 @@ noinstr void rcu_user_enter(void)
  * rcu_nmi_exit - inform RCU of exit from NMI context
  *
  * If we are returning from the outermost NMI handler that interrupted an
- * RCU-idle period, update rdp->dynticks and rdp->dynticks_nmi_nesting
+ * RCU-idle period, update ct->dynticks and rdp->dynticks_nmi_nesting
  * to let the RCU grace-period handling know that the CPU is back to
  * being RCU-idle.
  *
@@ -753,6 +748,7 @@ noinstr void rcu_user_enter(void)
  */
 noinstr void rcu_nmi_exit(void)
 {
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	instrumentation_begin();
@@ -770,7 +766,7 @@ noinstr void rcu_nmi_exit(void)
 	 */
 	if (rdp->dynticks_nmi_nesting != 1) {
 		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
-				  atomic_read(&rdp->dynticks));
+				  ct_dynticks());
 		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
 			   rdp->dynticks_nmi_nesting - 2);
 		instrumentation_end();
@@ -778,11 +774,11 @@ noinstr void rcu_nmi_exit(void)
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
+	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, ct_dynticks());
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
 	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
-	instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
+	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
 	instrumentation_end();
 
 	// RCU is watching here ...
@@ -821,6 +817,7 @@ void rcu_irq_exit_check_preempt(void)
  */
 static void noinstr rcu_eqs_exit(bool user)
 {
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 	struct rcu_data *rdp;
 	long oldval;
 
@@ -840,9 +837,9 @@ static void noinstr rcu_eqs_exit(bool user)
 	instrumentation_begin();
 
 	// instrumentation for the noinstr rcu_dynticks_eqs_exit()
-	instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
+	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
 
-	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
+	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, ct_dynticks());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdp->dynticks_nesting, 1);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
@@ -948,7 +945,7 @@ void __rcu_irq_enter_check_tick(void)
 /**
  * rcu_nmi_enter - inform RCU of entry to NMI context
  *
- * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
+ * If the CPU was idle from RCU's viewpoint, update ct->dynticks and
  * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
  * that the CPU is active.  This implementation permits nested NMIs, as
  * long as the nesting level does not overflow an int.  (You will probably
@@ -961,6 +958,7 @@ noinstr void rcu_nmi_enter(void)
 {
 	long incby = 2;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
 	/* Complain about underflow. */
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
@@ -984,9 +982,9 @@ noinstr void rcu_nmi_enter(void)
 
 		instrumentation_begin();
 		// instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
-		instrument_atomic_read(&rdp->dynticks, sizeof(rdp->dynticks));
+		instrument_atomic_read(&ct->dynticks, sizeof(ct->dynticks));
 		// instrumentation for the noinstr rcu_dynticks_eqs_exit()
-		instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
+		instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
 
 		incby = 1;
 	} else if (!in_nmi()) {
@@ -998,7 +996,7 @@ noinstr void rcu_nmi_enter(void)
 
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
 			  rdp->dynticks_nmi_nesting,
-			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
+			  rdp->dynticks_nmi_nesting + incby, ct_dynticks());
 	instrumentation_end();
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
 		   rdp->dynticks_nmi_nesting + incby);
@@ -1142,7 +1140,7 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
  */
 static int dyntick_save_progress_counter(struct rcu_data *rdp)
 {
-	rdp->dynticks_snap = rcu_dynticks_snap(rdp);
+	rdp->dynticks_snap = rcu_dynticks_snap(rdp->cpu);
 	if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
@@ -4237,7 +4235,7 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
 	INIT_WORK(&rdp->strict_work, strict_work_handler);
 	WARN_ON_ONCE(rdp->dynticks_nesting != 1);
-	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp)));
+	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu)));
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_ofl_gp_flags = RCU_GP_CLEANED;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 3cdc18997a38..2e46ee108d13 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -193,7 +193,6 @@ struct rcu_data {
 	int dynticks_snap;		/* Per-GP tracking for dynticks. */
 	long dynticks_nesting;		/* Track process nesting level. */
 	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
-	atomic_t dynticks;		/* Even value for idle, else odd. */
 	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
 	bool rcu_forced_tick;		/* Forced tick to provide QS. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index f092c7f18a5f..be667583a554 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -358,7 +358,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 		    !(rnp->qsmaskinitnext & mask)) {
 			mask_ofl_test |= mask;
 		} else {
-			snap = rcu_dynticks_snap(rdp);
+			snap = rcu_dynticks_snap(cpu);
 			if (rcu_dynticks_in_eqs(snap))
 				mask_ofl_test |= mask;
 			else
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 2464b0eccfd0..594a3c5aded1 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -465,7 +465,7 @@ static void print_cpu_stall_info(int cpu)
 	}
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
-			rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
+			rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
 		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
@@ -478,7 +478,7 @@ static void print_cpu_stall_info(int cpu)
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


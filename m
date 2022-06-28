Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041E055E44E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346114AbiF1NSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346390AbiF1NRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:17:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D5F31359
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:17:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8C6AB81E05
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D01C341CB;
        Tue, 28 Jun 2022 13:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656422243;
        bh=/nl0bM4nvyHUTJllVZNsXsfeLkxSPUxohTXAHipm650=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QFJ3pBTT+B3EPqZ0CxdBhQGWZKN8Bqoxw6zWqzJA9t7zsJllTFjDfBeQBkjwWXIUY
         +971sA7lV0Xl09PepOB4xNlYQDK1nHVzlA6Ifi6whWe/z43mh2bYNLsSPOWRH0aSmR
         OA/RMngjoMqSr8fPQGonazHYwSkEK82ox848/jBov4e82ERWnEfX5Agq43YawnOqRt
         h8uwPF7S4Au/ULPP6DD3RCC+S4467MzCdLW2y6gMP6uzQeo5G/uih/PjvlTvypBPev
         7l8Fu4jw0whDhsBezOv4hugsoLXN1zdNYoSr7TaNfYwI3dfx5QZXp932A+f+IDAcWs
         tp4oDKKHxatKA==
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
Subject: [PATCH 13/20] rcu/context_tracking: Move dynticks_nesting to context tracking
Date:   Tue, 28 Jun 2022 15:16:12 +0200
Message-Id: <20220628131619.2109651-14-frederic@kernel.org>
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

The RCU eqs tracking is going to be performed by the context tracking
subsystem. The related nesting counters thus need to be moved to the
context tracking structure.

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
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 include/linux/context_tracking_state.h | 13 +++++++++++
 kernel/context_tracking.c              |  1 +
 kernel/rcu/tree.c                      | 31 +++++++++++++-------------
 kernel/rcu/tree.h                      |  1 -
 kernel/rcu/tree_stall.h                |  2 +-
 5 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 5a8da2787287..13a4a9d1ec7e 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -27,6 +27,7 @@ struct context_tracking {
 #endif
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
 	atomic_t dynticks;		/* Even value for idle, else odd. */
+	long dynticks_nesting;		/* Track process nesting level. */
 #endif
 };
 
@@ -53,6 +54,18 @@ static __always_inline int ct_dynticks_cpu_acquire(int cpu)
 
 	return atomic_read_acquire(&ct->dynticks);
 }
+
+static __always_inline long ct_dynticks_nesting(void)
+{
+	return __this_cpu_read(context_tracking.dynticks_nesting);
+}
+
+static __always_inline long ct_dynticks_nesting_cpu(int cpu)
+{
+	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
+
+	return ct->dynticks_nesting;
+}
 #endif /* #ifdef CONFIG_CONTEXT_TRACKING_IDLE */
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 01abbcec52f7..dfefe04400f8 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -25,6 +25,7 @@
 
 DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
+	.dynticks_nesting = 1,
 	.dynticks = ATOMIC_INIT(1),
 #endif
 };
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a471edc3d893..f6bf328bb9cf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -75,7 +75,6 @@
 /* Data structures. */
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
-	.dynticks_nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 #ifdef CONFIG_RCU_NOCB_CPU
 	.cblist.flags = SEGCBLIST_RCU_CORE,
@@ -436,7 +435,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	lockdep_assert_irqs_disabled();
 
 	/* Check for counter underflows */
-	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
+	RCU_LOCKDEP_WARN(ct_dynticks_nesting() < 0,
 			 "RCU dynticks_nesting counter underflow!");
 	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
 			 "RCU dynticks_nmi_nesting counter underflow/zero!");
@@ -452,7 +451,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	WARN_ON_ONCE(!nesting && !is_idle_task(current));
 
 	/* Does CPU appear to be idle from an RCU standpoint? */
-	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
+	return ct_dynticks_nesting() == 0;
 }
 
 #define DEFAULT_RCU_BLIMIT (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ? 1000 : 10)
@@ -619,16 +618,16 @@ static noinstr void rcu_eqs_enter(bool user)
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     rdp->dynticks_nesting == 0);
-	if (rdp->dynticks_nesting != 1) {
+		     ct_dynticks_nesting() == 0);
+	if (ct_dynticks_nesting() != 1) {
 		// RCU will still be watching, so just do accounting and leave.
-		rdp->dynticks_nesting--;
+		ct->dynticks_nesting--;
 		return;
 	}
 
 	instrumentation_begin();
 	lockdep_assert_irqs_disabled();
-	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, ct_dynticks());
+	trace_rcu_dyntick(TPS("Start"), ct_dynticks_nesting(), 0, ct_dynticks());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rcu_preempt_deferred_qs(current);
 
@@ -636,7 +635,7 @@ static noinstr void rcu_eqs_enter(bool user)
 	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
 
 	instrumentation_end();
-	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid irq-access tearing. */
+	WRITE_ONCE(ct->dynticks_nesting, 0); /* Avoid irq-access tearing. */
 	// RCU is watching here ...
 	rcu_dynticks_eqs_enter();
 	// ... but is no longer watching here.
@@ -793,7 +792,7 @@ void rcu_irq_exit_check_preempt(void)
 {
 	lockdep_assert_irqs_disabled();
 
-	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) <= 0,
+	RCU_LOCKDEP_WARN(ct_dynticks_nesting() <= 0,
 			 "RCU dynticks_nesting counter underflow/zero!");
 	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) !=
 			 DYNTICK_IRQ_NONIDLE,
@@ -819,11 +818,11 @@ static void noinstr rcu_eqs_exit(bool user)
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
 	rdp = this_cpu_ptr(&rcu_data);
-	oldval = rdp->dynticks_nesting;
+	oldval = ct_dynticks_nesting();
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
 	if (oldval) {
 		// RCU was already watching, so just do accounting and leave.
-		rdp->dynticks_nesting++;
+		ct->dynticks_nesting++;
 		return;
 	}
 	rcu_dynticks_task_exit();
@@ -835,9 +834,9 @@ static void noinstr rcu_eqs_exit(bool user)
 	// instrumentation for the noinstr rcu_dynticks_eqs_exit()
 	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
 
-	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, ct_dynticks());
+	trace_rcu_dyntick(TPS("End"), ct_dynticks_nesting(), 1, ct_dynticks());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
-	WRITE_ONCE(rdp->dynticks_nesting, 1);
+	WRITE_ONCE(ct->dynticks_nesting, 1);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
 	instrumentation_end();
@@ -4134,12 +4133,13 @@ static void rcu_init_new_rnp(struct rcu_node *rnp_leaf)
 static void __init
 rcu_boot_init_percpu_data(int cpu)
 {
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
 	/* Set up local state, ensuring consistent view of global state. */
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
 	INIT_WORK(&rdp->strict_work, strict_work_handler);
-	WARN_ON_ONCE(rdp->dynticks_nesting != 1);
+	WARN_ON_ONCE(ct->dynticks_nesting != 1);
 	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu)));
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
@@ -4164,6 +4164,7 @@ rcu_boot_init_percpu_data(int cpu)
 int rcutree_prepare_cpu(unsigned int cpu)
 {
 	unsigned long flags;
+	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rcu_get_root();
 
@@ -4172,7 +4173,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->qlen_last_fqs_check = 0;
 	rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
 	rdp->blimit = blimit;
-	rdp->dynticks_nesting = 1;	/* CPU not up, no tearing. */
+	ct->dynticks_nesting = 1;	/* CPU not up, no tearing. */
 	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
 
 	/*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index ebb973f5b190..650ff3cf0121 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -187,7 +187,6 @@ struct rcu_data {
 
 	/* 3) dynticks interface. */
 	int dynticks_snap;		/* Per-GP tracking for dynticks. */
-	long dynticks_nesting;		/* Track process nesting level. */
 	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
 	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 250fbf2e8522..a9c82254b6c6 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -479,7 +479,7 @@ static void print_cpu_stall_info(int cpu)
 				"!."[!delta],
 	       ticks_value, ticks_title,
 	       rcu_dynticks_snap(cpu) & 0xfff,
-	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
+	       ct_dynticks_nesting_cpu(cpu), rdp->dynticks_nmi_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
 	       rcuc_starved ? buf : "",
-- 
2.25.1


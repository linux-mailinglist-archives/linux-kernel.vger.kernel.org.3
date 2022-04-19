Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C375060DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbiDSAXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbiDSAW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:22:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F89E1EC49;
        Mon, 18 Apr 2022 17:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A82F16134F;
        Tue, 19 Apr 2022 00:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F232AC385A7;
        Tue, 19 Apr 2022 00:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327617;
        bh=grhWMng/x7QwxSNnnjScR54ZNfplaDSHILkEzMzskdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1vZyWygYOFZMl+qGnO1MFUsctIAI0+e41vLwVkhSpNWBtK8tP81KpPMDsPq60lp/
         Fku+/mgjSx6EfsFqbbzF1XMT2gxZFYsDailZX8gt9+garoM/RkARBq/AVdDKhuHxU4
         aS5tA/3eaWnVrX2q7luNh9Epxwgu9Gp8theFZETxw8Zk5FVuAiS6y18g/+fRJEdZcC
         sgv/2/0pJcNjHkdoe9xt6KOiJ3oLlwwGCryuWOHpvXBMxUAxjorRQ2DuoTPBPHNanE
         NygGPEgB6/aTJOq55+4PgrZBkgobq1gbH4lOLVJr+aLxw6hxEBMPB2KbNZ8T0Bqpjj
         kt120PlJduWAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A29FF5C04C6; Mon, 18 Apr 2022 17:20:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Kalesh Singh <kaleshsingh@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Tim Murray <timmurray@google.com>, Wei Wang <wvw@google.com>,
        Kyle Lin <kylelin@google.com>,
        Chunwei Lu <chunweilu@google.com>, Lulu Wang <luluw@google.com>
Subject: [PATCH rcu 2/2] rcu: Move expedited grace period (GP) work to RT kthread_worker
Date:   Mon, 18 Apr 2022 17:20:14 -0700
Message-Id: <20220419002014.3951121-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419002008.GA3950677@paulmck-ThinkPad-P17-Gen-1>
References: <20220419002008.GA3950677@paulmck-ThinkPad-P17-Gen-1>
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

From: Kalesh Singh <kaleshsingh@google.com>

Enabling CONFIG_RCU_BOOST did not reduce RCU expedited grace-period
latency because its workqueues run at SCHED_OTHER, and thus can be
delayed by normal processes.  This commit avoids these delays by moving
the expedited GP work items to a real-time-priority kthread_worker.

This option is controlled by CONFIG_RCU_EXP_KTHREAD and disabled by
default on PREEMPT_RT=y kernels which disable expedited grace periods
after boot by unconditionally setting rcupdate.rcu_normal_after_boot=1.

The results were evaluated on arm64 Android devices (6GB ram) running
5.10 kernel, and capturing trace data in critical user-level code.

The table below shows the resulting order-of-magnitude improvements
in synchronize_rcu_expedited() latency:

------------------------------------------------------------------------
|                          |   workqueues  |  kthread_worker |  Diff   |
------------------------------------------------------------------------
| Count                    |          725  |            688  |         |
------------------------------------------------------------------------
| Min Duration       (ns)  |          326  |            447  |  37.12% |
------------------------------------------------------------------------
| Q1                 (ns)  |       39,428  |         38,971  |  -1.16% |
------------------------------------------------------------------------
| Q2 - Median        (ns)  |       98,225  |         69,743  | -29.00% |
------------------------------------------------------------------------
| Q3                 (ns)  |      342,122  |        126,638  | -62.98% |
------------------------------------------------------------------------
| Max Duration       (ns)  |  372,766,967  |      2,329,671  | -99.38% |
------------------------------------------------------------------------
| Avg Duration       (ns)  |    2,746,353  |        151,242  | -94.49% |
------------------------------------------------------------------------
| Standard Deviation (ns)  |   19,327,765  |        294,408  |         |
------------------------------------------------------------------------

The below table show the range of maximums/minimums for
synchronize_rcu_expedited() latency from all experiments:

------------------------------------------------------------------------
|                          |   workqueues  |  kthread_worker |  Diff   |
------------------------------------------------------------------------
| Total No. of Experiments |           25  |             23  |         |
------------------------------------------------------------------------
| Largest  Maximum   (ns)  |  372,766,967  |      2,329,671  | -99.38% |
------------------------------------------------------------------------
| Smallest Maximum   (ns)  |       38,819  |         86,954  | 124.00% |
------------------------------------------------------------------------
| Range of Maximums  (ns)  |  372,728,148  |      2,242,717  |         |
------------------------------------------------------------------------
| Largest  Minimum   (ns)  |       88,623  |         27,588  | -68.87% |
------------------------------------------------------------------------
| Smallest Minimum   (ns)  |          326  |            447  |  37.12% |
------------------------------------------------------------------------
| Range of Minimums  (ns)  |       88,297  |         27,141  |         |
------------------------------------------------------------------------

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Reported-by: Tim Murray <timmurray@google.com>
Reported-by: Wei Wang <wvw@google.com>
Tested-by: Kyle Lin <kylelin@google.com>
Tested-by: Chunwei Lu <chunweilu@google.com>
Tested-by: Lulu Wang <luluw@google.com>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig    |  14 ++++
 kernel/rcu/rcu.h      |   5 ++
 kernel/rcu/tree.c     |  51 ++++++++++++++-
 kernel/rcu/tree.h     |   5 ++
 kernel/rcu/tree_exp.h | 147 +++++++++++++++++++++++++++++++++---------
 5 files changed, 188 insertions(+), 34 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bf8e341e75b4..fd64a75823cb 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -195,6 +195,20 @@ config RCU_BOOST_DELAY
 
 	  Accept the default if unsure.
 
+config RCU_EXP_KTHREAD
+	bool "Perform RCU expedited work in a real-time kthread"
+	depends on RCU_BOOST && RCU_EXPERT
+	default !PREEMPT_RT && NR_CPUS <= 32
+	help
+	  Use this option to further reduce the latencies of expedited
+	  grace periods at the expense of being more disruptive.
+
+	  This option is disabled by default on PREEMPT_RT=y kernels which
+	  disable expedited grace periods after boot by unconditionally
+	  setting rcupdate.rcu_normal_after_boot=1.
+
+	  Accept the default if unsure.
+
 config RCU_NOCB_CPU
 	bool "Offload RCU callback processing from boot-selected CPUs"
 	depends on TREE_RCU
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 20f0300f6cb1..e27bf7d1e3a4 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -536,7 +536,12 @@ int rcu_get_gp_kthreads_prio(void);
 void rcu_fwd_progress_check(unsigned long j);
 void rcu_force_quiescent_state(void);
 extern struct workqueue_struct *rcu_gp_wq;
+#ifdef CONFIG_RCU_EXP_KTHREAD
+extern struct kthread_worker *rcu_exp_gp_kworker;
+extern struct kthread_worker *rcu_exp_par_gp_kworker;
+#else /* !CONFIG_RCU_EXP_KTHREAD */
 extern struct workqueue_struct *rcu_par_gp_wq;
+#endif /* CONFIG_RCU_EXP_KTHREAD */
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
 #ifdef CONFIG_RCU_NOCB_CPU
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4b8189455d5..763e45fdf49b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4471,6 +4471,51 @@ static int rcu_pm_notify(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
+#ifdef CONFIG_RCU_EXP_KTHREAD
+struct kthread_worker *rcu_exp_gp_kworker;
+struct kthread_worker *rcu_exp_par_gp_kworker;
+
+static void __init rcu_start_exp_gp_kworkers(void)
+{
+	const char *par_gp_kworker_name = "rcu_exp_par_gp_kthread_worker";
+	const char *gp_kworker_name = "rcu_exp_gp_kthread_worker";
+	struct sched_param param = { .sched_priority = kthread_prio };
+
+	rcu_exp_gp_kworker = kthread_create_worker(0, gp_kworker_name);
+	if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
+		pr_err("Failed to create %s!\n", gp_kworker_name);
+		return;
+	}
+
+	rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
+	if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
+		pr_err("Failed to create %s!\n", par_gp_kworker_name);
+		kthread_destroy_worker(rcu_exp_gp_kworker);
+		return;
+	}
+
+	sched_setscheduler_nocheck(rcu_exp_gp_kworker->task, SCHED_FIFO, &param);
+	sched_setscheduler_nocheck(rcu_exp_par_gp_kworker->task, SCHED_FIFO,
+				   &param);
+}
+
+static inline void rcu_alloc_par_gp_wq(void)
+{
+}
+#else /* !CONFIG_RCU_EXP_KTHREAD */
+struct workqueue_struct *rcu_par_gp_wq;
+
+static void __init rcu_start_exp_gp_kworkers(void)
+{
+}
+
+static inline void rcu_alloc_par_gp_wq(void)
+{
+	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
+	WARN_ON(!rcu_par_gp_wq);
+}
+#endif /* CONFIG_RCU_EXP_KTHREAD */
+
 /*
  * Spawn the kthreads that handle RCU's grace periods.
  */
@@ -4500,6 +4545,8 @@ static int __init rcu_spawn_gp_kthread(void)
 	rcu_spawn_nocb_kthreads();
 	rcu_spawn_boost_kthreads();
 	rcu_spawn_core_kthreads();
+	/* Create kthread worker for expedited GPs */
+	rcu_start_exp_gp_kworkers();
 	return 0;
 }
 early_initcall(rcu_spawn_gp_kthread);
@@ -4745,7 +4792,6 @@ static void __init rcu_dump_rcu_node_tree(void)
 }
 
 struct workqueue_struct *rcu_gp_wq;
-struct workqueue_struct *rcu_par_gp_wq;
 
 static void __init kfree_rcu_batch_init(void)
 {
@@ -4811,8 +4857,7 @@ void __init rcu_init(void)
 	/* Create workqueue for Tree SRCU and for expedited GPs. */
 	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_gp_wq);
-	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
-	WARN_ON(!rcu_par_gp_wq);
+	rcu_alloc_par_gp_wq();
 
 	/* Fill in default value for rcutree.qovld boot parameter. */
 	/* -After- the rcu_node ->lock fields are initialized! */
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 926673ebe355..b577cdfdc851 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -10,6 +10,7 @@
  */
 
 #include <linux/cache.h>
+#include <linux/kthread.h>
 #include <linux/spinlock.h>
 #include <linux/rtmutex.h>
 #include <linux/threads.h>
@@ -23,7 +24,11 @@
 /* Communicate arguments to a workqueue handler. */
 struct rcu_exp_work {
 	unsigned long rew_s;
+#ifdef CONFIG_RCU_EXP_KTHREAD
+	struct kthread_work rew_work;
+#else
 	struct work_struct rew_work;
+#endif /* CONFIG_RCU_EXP_KTHREAD */
 };
 
 /* RCU's kthread states for tracing. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index b1f52b59fa4b..0f70f62039a9 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -334,15 +334,13 @@ static bool exp_funnel_lock(unsigned long s)
  * Select the CPUs within the specified rcu_node that the upcoming
  * expedited grace period needs to wait for.
  */
-static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
+static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 {
 	int cpu;
 	unsigned long flags;
 	unsigned long mask_ofl_test;
 	unsigned long mask_ofl_ipi;
 	int ret;
-	struct rcu_exp_work *rewp =
-		container_of(wp, struct rcu_exp_work, rew_work);
 	struct rcu_node *rnp = container_of(rewp, struct rcu_node, rew);
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -417,13 +415,119 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 		rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
 }
 
+static void rcu_exp_sel_wait_wake(unsigned long s);
+
+#ifdef CONFIG_RCU_EXP_KTHREAD
+static void sync_rcu_exp_select_node_cpus(struct kthread_work *wp)
+{
+	struct rcu_exp_work *rewp =
+		container_of(wp, struct rcu_exp_work, rew_work);
+
+	__sync_rcu_exp_select_node_cpus(rewp);
+}
+
+static inline bool rcu_gp_par_worker_started(void)
+{
+	return !!READ_ONCE(rcu_exp_par_gp_kworker);
+}
+
+static inline void sync_rcu_exp_select_cpus_queue_work(struct rcu_node *rnp)
+{
+	kthread_init_work(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
+	/*
+	 * Use rcu_exp_par_gp_kworker, because flushing a work item from
+	 * another work item on the same kthread worker can result in
+	 * deadlock.
+	 */
+	kthread_queue_work(rcu_exp_par_gp_kworker, &rnp->rew.rew_work);
+}
+
+static inline void sync_rcu_exp_select_cpus_flush_work(struct rcu_node *rnp)
+{
+	kthread_flush_work(&rnp->rew.rew_work);
+}
+
+/*
+ * Work-queue handler to drive an expedited grace period forward.
+ */
+static void wait_rcu_exp_gp(struct kthread_work *wp)
+{
+	struct rcu_exp_work *rewp;
+
+	rewp = container_of(wp, struct rcu_exp_work, rew_work);
+	rcu_exp_sel_wait_wake(rewp->rew_s);
+}
+
+static inline void synchronize_rcu_expedited_queue_work(struct rcu_exp_work *rew)
+{
+	kthread_init_work(&rew->rew_work, wait_rcu_exp_gp);
+	kthread_queue_work(rcu_exp_gp_kworker, &rew->rew_work);
+}
+
+static inline void synchronize_rcu_expedited_destroy_work(struct rcu_exp_work *rew)
+{
+}
+#else /* !CONFIG_RCU_EXP_KTHREAD */
+static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
+{
+	struct rcu_exp_work *rewp =
+		container_of(wp, struct rcu_exp_work, rew_work);
+
+	__sync_rcu_exp_select_node_cpus(rewp);
+}
+
+static inline bool rcu_gp_par_worker_started(void)
+{
+	return !!READ_ONCE(rcu_par_gp_wq);
+}
+
+static inline void sync_rcu_exp_select_cpus_queue_work(struct rcu_node *rnp)
+{
+	int cpu = find_next_bit(&rnp->ffmask, BITS_PER_LONG, -1);
+
+	INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
+	/* If all offline, queue the work on an unbound CPU. */
+	if (unlikely(cpu > rnp->grphi - rnp->grplo))
+		cpu = WORK_CPU_UNBOUND;
+	else
+		cpu += rnp->grplo;
+	queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
+}
+
+static inline void sync_rcu_exp_select_cpus_flush_work(struct rcu_node *rnp)
+{
+	flush_work(&rnp->rew.rew_work);
+}
+
+/*
+ * Work-queue handler to drive an expedited grace period forward.
+ */
+static void wait_rcu_exp_gp(struct work_struct *wp)
+{
+	struct rcu_exp_work *rewp;
+
+	rewp = container_of(wp, struct rcu_exp_work, rew_work);
+	rcu_exp_sel_wait_wake(rewp->rew_s);
+}
+
+static inline void synchronize_rcu_expedited_queue_work(struct rcu_exp_work *rew)
+{
+	INIT_WORK_ONSTACK(&rew->rew_work, wait_rcu_exp_gp);
+	queue_work(rcu_gp_wq, &rew->rew_work);
+}
+
+static inline void synchronize_rcu_expedited_destroy_work(struct rcu_exp_work *rew)
+{
+	destroy_work_on_stack(&rew->rew_work);
+}
+#endif /* CONFIG_RCU_EXP_KTHREAD */
+
 /*
  * Select the nodes that the upcoming expedited grace period needs
  * to wait for.
  */
 static void sync_rcu_exp_select_cpus(void)
 {
-	int cpu;
 	struct rcu_node *rnp;
 
 	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("reset"));
@@ -435,28 +539,21 @@ static void sync_rcu_exp_select_cpus(void)
 		rnp->exp_need_flush = false;
 		if (!READ_ONCE(rnp->expmask))
 			continue; /* Avoid early boot non-existent wq. */
-		if (!READ_ONCE(rcu_par_gp_wq) ||
+		if (!rcu_gp_par_worker_started() ||
 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
 		    rcu_is_last_leaf_node(rnp)) {
-			/* No workqueues yet or last leaf, do direct call. */
+			/* No worker started yet or last leaf, do direct call. */
 			sync_rcu_exp_select_node_cpus(&rnp->rew.rew_work);
 			continue;
 		}
-		INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
-		cpu = find_next_bit(&rnp->ffmask, BITS_PER_LONG, -1);
-		/* If all offline, queue the work on an unbound CPU. */
-		if (unlikely(cpu > rnp->grphi - rnp->grplo))
-			cpu = WORK_CPU_UNBOUND;
-		else
-			cpu += rnp->grplo;
-		queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
+		sync_rcu_exp_select_cpus_queue_work(rnp);
 		rnp->exp_need_flush = true;
 	}
 
-	/* Wait for workqueue jobs (if any) to complete. */
+	/* Wait for jobs (if any) to complete. */
 	rcu_for_each_leaf_node(rnp)
 		if (rnp->exp_need_flush)
-			flush_work(&rnp->rew.rew_work);
+			sync_rcu_exp_select_cpus_flush_work(rnp);
 }
 
 /*
@@ -622,17 +719,6 @@ static void rcu_exp_sel_wait_wake(unsigned long s)
 	rcu_exp_wait_wake(s);
 }
 
-/*
- * Work-queue handler to drive an expedited grace period forward.
- */
-static void wait_rcu_exp_gp(struct work_struct *wp)
-{
-	struct rcu_exp_work *rewp;
-
-	rewp = container_of(wp, struct rcu_exp_work, rew_work);
-	rcu_exp_sel_wait_wake(rewp->rew_s);
-}
-
 #ifdef CONFIG_PREEMPT_RCU
 
 /*
@@ -848,20 +934,19 @@ void synchronize_rcu_expedited(void)
 	} else {
 		/* Marshall arguments & schedule the expedited grace period. */
 		rew.rew_s = s;
-		INIT_WORK_ONSTACK(&rew.rew_work, wait_rcu_exp_gp);
-		queue_work(rcu_gp_wq, &rew.rew_work);
+		synchronize_rcu_expedited_queue_work(&rew);
 	}
 
 	/* Wait for expedited grace period to complete. */
 	rnp = rcu_get_root();
 	wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
 		   sync_exp_work_done(s));
-	smp_mb(); /* Workqueue actions happen before return. */
+	smp_mb(); /* Work actions happen before return. */
 
 	/* Let the next expedited grace period start. */
 	mutex_unlock(&rcu_state.exp_mutex);
 
 	if (likely(!boottime))
-		destroy_work_on_stack(&rew.rew_work);
+		synchronize_rcu_expedited_destroy_work(&rew);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
-- 
2.31.1.189.g2e36527f23


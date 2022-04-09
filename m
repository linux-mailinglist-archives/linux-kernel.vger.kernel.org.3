Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A414FA0B2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 02:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbiDIAhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 20:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiDIAhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 20:37:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E964B1FA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 17:35:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb2bc9018aso89475067b3.18
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 17:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=TCfmygAlNib7zVXwX3bVBJq4CaYN01HQYK7s1aXYeys=;
        b=DEPk7XiJrejfA4c43In0L/FwP5J46tG2UZAzwSjVVaxlQVgGJaZY3P6NgnCqU4e7He
         NtgUhLr+uEpZnWECDnjBMiTHPM45uknEqK2DAiTjElHswubNaQIHsEj6PFi1/ckVKIwL
         ubyrgJA8ylJb0BOIwVuwq8pTRpTlFf/8D1BYViqV0RuUf3uWSk4qHFgXpUF/uThjzcZ1
         aXyfdZh7BqQ98HUH/neh/MtymghH5W2n4gWS0+sA9jXgN+8ha/eMklOx04eJSEfzKnIC
         oL2wF14ZEcDV3KehF3DDytwUY+3ymfvf+oMaTXelCm5QaoayfjPWz7mXH3aCD1AFBw/a
         JWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=TCfmygAlNib7zVXwX3bVBJq4CaYN01HQYK7s1aXYeys=;
        b=Gds9XWfxP8csVZGu1Kk7tydbCYVL8X/4I1/n3aNIvRt0F9RLGZMkByHo0Gu38lUwko
         TNWr2uEHFu+t4Yg6+/GPhUdceGwFI7TgG+rD/rl0HYDgTpcWWELxqN+eULLPBX2X3WXF
         bkEHG62YWlMV0Sq7BupRJHH95nexApAVLEyKc2sqe88RTSmf3Ecbh1f5U21hjFGsMVn7
         ibecbvgsXJ3mneDHstx2+ryQY/rcuAeZSUUjFQCDPOnX9C8EQ+MNskS03liq6xHx6ors
         jAplPkXapXjNdN9lys2lobx9/p0MEX6Uc0pG1rAw5ibcER22oHNRQPpsG0f33Q4ZNp4A
         fSMA==
X-Gm-Message-State: AOAM532SQx2pobvlYbPi2qCZr9vn7Uwpa8TE+nOzuTGNvf1xq+omfRgp
        rc7VElrf8yDP0Ylqhsfg32IESypf0nsVSxrc4Q==
X-Google-Smtp-Source: ABdhPJyf0AOsATvlaZp+t/zuSHrUCuaDDU2GjX59ggo2ysI6kRfi0rst9Wlz89o3RoRoyvILAmdI93DOn7BehS2ZWQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:2ab4:46a4:a745:b3d2])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:247:0:b0:624:4d24:94ee with SMTP
 id g7-20020a5b0247000000b006244d2494eemr15656181ybp.197.1649464534611; Fri,
 08 Apr 2022 17:35:34 -0700 (PDT)
Date:   Fri,  8 Apr 2022 17:35:27 -0700
Message-Id: <20220409003527.1587028-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v3] EXP rcu: Move expedited grace period (GP) work to RT kthread_worker
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Tim Murray <timmurray@google.com>, Wei Wang <wvw@google.com>,
        Kyle Lin <kylelin@google.com>,
        Chunwei Lu <chunweilu@google.com>,
        Lulu Wang <luluw@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

Changes in v3:
  - Update Kconfig and commit text describing default RCU_EXP_KTHREAD value
    for PREEMT_RT kernels; per Steve

Changes in v2:
  - Add stats on variation: standard deviation, range of maxs, etc; per Paul
  - Make this optimization configurable (CONFIG_RCU_EXP_KTHREAD); per Paul


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
index 24b5f2c2de87..5510d2231c32 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -534,7 +534,12 @@ int rcu_get_gp_kthreads_prio(void);
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
index 60197ea24ceb..2c6c0e0bc83a 100644
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

base-commit: 1a3b1bba7c7a5eb8a11513cf88427cb9d77bc60a
-- 
2.35.1.1178.g4f1659d476-goog


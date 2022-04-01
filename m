Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D5B4EFCED
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352209AbiDAW7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiDAW7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:59:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AE410F6CD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 15:57:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d11b6259adso37879347b3.19
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 15:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=MXD2T5A4d5cpPYWa//yFP+/rApKvY9ylhuwHg4LZcZI=;
        b=SUAzhUAAD6p1EZMwdte6AIxXBGJ2OVaNXtbwGsBRHqoRN95DgNlIte8Y4TJxIp08Hz
         Jgk+qomyIqZmx7fRVomDxN12d70Xrcu6OYp5cqv/NjUecAoDnbYoFx9/VURgQ/STnyR9
         9su35jJ+VJgj5t5dGxTe9bTqicnXahyrGbpka5YzD7r2hcM24fE+jZWK9EOJ0rve3KiU
         /NEkosRdA55r+cO8Po6NdqIgObritC9UYti2tzq3nLg0TQv4Y4hoqVBb6FyGAT/WbHK0
         /3yNQvXGwcsLKo0zNCcSnDxJ2YNENmpad+jUUsX04nf9S7LsvDqMsKmL/U/5+QsvGV1N
         gYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=MXD2T5A4d5cpPYWa//yFP+/rApKvY9ylhuwHg4LZcZI=;
        b=qdse3AZ/Lz+mPZ6ccBhVpd35UpMZ7ewW94J+3DCxNWfXN5jfx/RK1ob8hMmOBm/Mip
         vsXyeeFjDQ2cs0svis+g5YL9TR+23e8cIKFbOcnuhPGp3Vo3s64xXUDeQirTOH0G8CYe
         eiNzZFDVn1x+2Buz4m4jeQQ4t/z2BmlyV7MzhAoGfUsDyxhTt2O47h67drLwIPNc5ZEZ
         gv/xOIZp4BF/edV+E23fBj/L1lEb1RE+7r1RGQ96uIBom+JcmpyVKUf0I0/7XmCfU1Ne
         PYpEXAb89yc/vcWw49JSaHiIRBQtNfZyyuoBjmKdwiPs6np5ij5vTA5YSvAyH5hwkbo0
         XRXA==
X-Gm-Message-State: AOAM530tQLhIcnQa2B5cH0bhIfLZbYur2jOEDKXrVrEMYI7M8QzlU5Wv
        84b/VlYoK+89I2lycudNuqzG5uIpFJFQfI/nRg==
X-Google-Smtp-Source: ABdhPJx38hjxC6wswlzo/RrAr3sl5wCRE5yZ5ONmQGUCl3ZDRtkB7LqJIlQyH601N5JKpu3NWnEfPy+eWnB+U4pdmg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:272c:b057:35a:b8b4])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:72a:b0:634:6843:499c with
 SMTP id l10-20020a056902072a00b006346843499cmr11644105ybt.36.1648853867431;
 Fri, 01 Apr 2022 15:57:47 -0700 (PDT)
Date:   Fri,  1 Apr 2022 15:57:40 -0700
Message-Id: <20220401225740.1984689-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH] RCU: Move expedited grace period (GP) work to RT kthread_worker
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

It was noticed that enabling CONFIG_RCU_BOOST did not help RCU
performance because the workqueues that runs expedited GP work are
subject to scheduling delays. This patch moves the expedited GP
work items to RT kthread_worker.

The results were evaluated on arm64 Android devices (6GB ram) running
5.10 kernel, and caturing trace data during critical user journeys.

The table below compares the time synchronize_rcu_expedited() is blocked:

 ----------------------------------------------------------------------
|                   |      Using WQ    | Using kthead_worker |  Diff   |
-----------------------------------------------------------------------
| Max duration (ns) |    372766967     |     2329671         | -99.38% |
-----------------------------------------------------------------------
| Avg duration (ns) |      2746353.16  |      151242.311     | -94.49% |
 ----------------------------------------------------------------------

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Reported-by: Tim Murray <timmurray@google.com>
Reported-by: Wei Wang <wvw@google.com>
Tested-by: Kyle Lin <kylelin@google.com>
Tested-by: Chunwei Lu <chunweilu@google.com>
Tested-by: Lulu Wang <luluw@google.com>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 kernel/rcu/rcu.h      |  3 ++-
 kernel/rcu/tree.c     | 41 +++++++++++++++++++++++++++++++++++++----
 kernel/rcu/tree.h     |  3 ++-
 kernel/rcu/tree_exp.h | 35 +++++++++++++++--------------------
 4 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 24b5f2c2de87..13d2b74bf19f 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -534,7 +534,8 @@ int rcu_get_gp_kthreads_prio(void);
 void rcu_fwd_progress_check(unsigned long j);
 void rcu_force_quiescent_state(void);
 extern struct workqueue_struct *rcu_gp_wq;
-extern struct workqueue_struct *rcu_par_gp_wq;
+extern struct kthread_worker *rcu_exp_gp_kworker;
+extern struct kthread_worker *rcu_exp_par_gp_kworker;
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
 #ifdef CONFIG_RCU_NOCB_CPU
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4b8189455d5..bd5e672ffa5a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4471,6 +4471,33 @@ static int rcu_pm_notify(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
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
 /*
  * Spawn the kthreads that handle RCU's grace periods.
  */
@@ -4500,6 +4527,10 @@ static int __init rcu_spawn_gp_kthread(void)
 	rcu_spawn_nocb_kthreads();
 	rcu_spawn_boost_kthreads();
 	rcu_spawn_core_kthreads();
+
+	/* Create kthread worker for expedited GPs */
+	rcu_start_exp_gp_kworkers();
+
 	return 0;
 }
 early_initcall(rcu_spawn_gp_kthread);
@@ -4745,7 +4776,6 @@ static void __init rcu_dump_rcu_node_tree(void)
 }
 
 struct workqueue_struct *rcu_gp_wq;
-struct workqueue_struct *rcu_par_gp_wq;
 
 static void __init kfree_rcu_batch_init(void)
 {
@@ -4808,11 +4838,14 @@ void __init rcu_init(void)
 		rcutree_online_cpu(cpu);
 	}
 
-	/* Create workqueue for Tree SRCU and for expedited GPs. */
+	/*
+	 * Create workqueue for Tree SRCU.
+	 *
+	 * Expedited GPs use RT kthread_worker.
+	 * See: rcu_start_exp_gp_kworkers()
+	 */
 	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_gp_wq);
-	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
-	WARN_ON(!rcu_par_gp_wq);
 
 	/* Fill in default value for rcutree.qovld boot parameter. */
 	/* -After- the rcu_node ->lock fields are initialized! */
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 926673ebe355..0193d67a706a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -10,6 +10,7 @@
  */
 
 #include <linux/cache.h>
+#include <linux/kthread.h>
 #include <linux/spinlock.h>
 #include <linux/rtmutex.h>
 #include <linux/threads.h>
@@ -23,7 +24,7 @@
 /* Communicate arguments to a workqueue handler. */
 struct rcu_exp_work {
 	unsigned long rew_s;
-	struct work_struct rew_work;
+	struct kthread_work rew_work;
 };
 
 /* RCU's kthread states for tracing. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 60197ea24ceb..f5f3722c0a74 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -334,7 +334,7 @@ static bool exp_funnel_lock(unsigned long s)
  * Select the CPUs within the specified rcu_node that the upcoming
  * expedited grace period needs to wait for.
  */
-static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
+static void sync_rcu_exp_select_node_cpus(struct kthread_work *wp)
 {
 	int cpu;
 	unsigned long flags;
@@ -423,7 +423,6 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
  */
 static void sync_rcu_exp_select_cpus(void)
 {
-	int cpu;
 	struct rcu_node *rnp;
 
 	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("reset"));
@@ -435,28 +434,27 @@ static void sync_rcu_exp_select_cpus(void)
 		rnp->exp_need_flush = false;
 		if (!READ_ONCE(rnp->expmask))
 			continue; /* Avoid early boot non-existent wq. */
-		if (!READ_ONCE(rcu_par_gp_wq) ||
+		if (!READ_ONCE(rcu_exp_par_gp_kworker) ||
 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
 		    rcu_is_last_leaf_node(rnp)) {
-			/* No workqueues yet or last leaf, do direct call. */
+			/* kthread worker not started yet or last leaf, do direct call. */
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
+		kthread_init_work(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
+		/*
+		 * Use rcu_exp_par_gp_kworker, because flushing a work item from
+		 * another work item on the same kthread worker can result in
+		 * deadlock.
+		 */
+		kthread_queue_work(rcu_exp_par_gp_kworker, &rnp->rew.rew_work);
 		rnp->exp_need_flush = true;
 	}
 
 	/* Wait for workqueue jobs (if any) to complete. */
 	rcu_for_each_leaf_node(rnp)
 		if (rnp->exp_need_flush)
-			flush_work(&rnp->rew.rew_work);
+			kthread_flush_work(&rnp->rew.rew_work);
 }
 
 /*
@@ -625,7 +623,7 @@ static void rcu_exp_sel_wait_wake(unsigned long s)
 /*
  * Work-queue handler to drive an expedited grace period forward.
  */
-static void wait_rcu_exp_gp(struct work_struct *wp)
+static void wait_rcu_exp_gp(struct kthread_work *wp)
 {
 	struct rcu_exp_work *rewp;
 
@@ -848,20 +846,17 @@ void synchronize_rcu_expedited(void)
 	} else {
 		/* Marshall arguments & schedule the expedited grace period. */
 		rew.rew_s = s;
-		INIT_WORK_ONSTACK(&rew.rew_work, wait_rcu_exp_gp);
-		queue_work(rcu_gp_wq, &rew.rew_work);
+		kthread_init_work(&rew.rew_work, wait_rcu_exp_gp);
+		kthread_queue_work(rcu_exp_gp_kworker, &rew.rew_work);
 	}
 
 	/* Wait for expedited grace period to complete. */
 	rnp = rcu_get_root();
 	wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
 		   sync_exp_work_done(s));
-	smp_mb(); /* Workqueue actions happen before return. */
+	smp_mb(); /* kthread actions happen before return. */
 
 	/* Let the next expedited grace period start. */
 	mutex_unlock(&rcu_state.exp_mutex);
-
-	if (likely(!boottime))
-		destroy_work_on_stack(&rew.rew_work);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);

base-commit: 7a3ecddc571cc3294e5d6bb5948ff2b0cfa12735
-- 
2.35.1.1094.g7c7d902a7c-goog


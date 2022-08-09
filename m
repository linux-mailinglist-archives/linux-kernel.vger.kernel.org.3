Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E075D58D964
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 15:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243689AbiHINaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 09:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiHINaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:30:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF1E13D60
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 06:29:58 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M2DNG2yFKzXdQH;
        Tue,  9 Aug 2022 21:25:50 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 21:29:55 +0800
Received: from huawei.com (7.220.126.23) by dggpemm500014.china.huawei.com
 (7.185.36.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 9 Aug
 2022 21:29:54 +0800
From:   zhangsong <zhangsong34@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        zhangsong <zhangsong34@huawei.com>
Subject: [PATCH] sched/fair: Introduce priority load balance to reduce interference from IDLE tasks
Date:   Tue, 9 Aug 2022 21:29:45 +0800
Message-ID: <20220809132945.3710583-1-zhangsong34@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.220.126.23]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For co-location with NORMAL and IDLE tasks, when CFS trigger load balance,
it is reasonable to prefer migrating NORMAL(Latency Sensitive) tasks from
the busy src CPU to dst CPU, and migrating IDLE tasks lastly.

This is very important for reducing interference from IDLE tasks.
So the CFS load balance can be optimized to below:

1.`cfs_tasks` list of CPU rq is owned by NORMAL tasks.
2.`cfs_idle_tasks` list of CPU rq which is owned by IDLE tasks.
3.Prefer to migrate NORMAL tasks of cfs_tasks to dst CPU.
4.Lastly migrate IDLE tasks of cfs_idle_tasks to dst CPU.

This was tested with the following reproduction:
- small number of NORMAL tasks colocated with a large number of IDLE tasks

With this patch, NORMAL tasks latency can be reduced
about 5~10% compared with current.

Signed-off-by: zhangsong <zhangsong34@huawei.com>
---
 kernel/sched/core.c  |  1 +
 kernel/sched/fair.c  | 43 +++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h |  1 +
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..7325c6e552d8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9733,6 +9733,7 @@ void __init sched_init(void)
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
+		INIT_LIST_HEAD(&rq->cfs_idle_tasks);
 
 		rq_attach_root(rq, &def_root_domain);
 #ifdef CONFIG_NO_HZ_COMMON
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 914096c5b1ae..5860d34a8a52 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3034,6 +3034,19 @@ static inline void update_scan_period(struct task_struct *p, int new_cpu)
 
 #endif /* CONFIG_NUMA_BALANCING */
 
+static void
+adjust_rq_cfs_tasks(void (*list_op)(struct list_head *, struct list_head *),
+	struct rq *rq,
+	struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+	if (task_has_idle_policy(task_of(se)) || tg_is_idle(cfs_rq->tg))
+		(*list_op)(&se->group_node, &rq->cfs_idle_tasks);
+	else
+		(*list_op)(&se->group_node, &rq->cfs_tasks);
+}
+
 static void
 account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
@@ -3043,7 +3056,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		struct rq *rq = rq_of(cfs_rq);
 
 		account_numa_enqueue(rq, task_of(se));
-		list_add(&se->group_node, &rq->cfs_tasks);
+		adjust_rq_cfs_tasks(list_add, rq, se);
 	}
 #endif
 	cfs_rq->nr_running++;
@@ -7465,7 +7478,7 @@ done: __maybe_unused;
 	 * the list, so our cfs_tasks list becomes MRU
 	 * one.
 	 */
-	list_move(&p->se.group_node, &rq->cfs_tasks);
+	adjust_rq_cfs_tasks(list_move, rq, &p->se);
 #endif
 
 	if (hrtick_enabled_fair(rq))
@@ -7788,6 +7801,9 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 	if (unlikely(task_has_idle_policy(p)))
 		return 0;
 
+	if (tg_is_idle(cfs_rq_of(&p->se)->tg))
+		return 0;
+
 	/* SMT siblings share cache */
 	if (env->sd->flags & SD_SHARE_CPUCAPACITY)
 		return 0;
@@ -7800,6 +7816,11 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 			 &p->se == cfs_rq_of(&p->se)->last))
 		return 1;
 
+	/* Preempt sched idle cpu do not consider migration cost */
+	if (cpus_share_cache(env->src_cpu, env->dst_cpu) &&
+	    sched_idle_cpu(env->dst_cpu))
+		return 0;
+
 	if (sysctl_sched_migration_cost == -1)
 		return 1;
 
@@ -7990,11 +8011,14 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 static struct task_struct *detach_one_task(struct lb_env *env)
 {
 	struct task_struct *p;
+	struct list_head *tasks = &env->src_rq->cfs_tasks;
+	int loop = 0;
 
 	lockdep_assert_rq_held(env->src_rq);
 
+again:
 	list_for_each_entry_reverse(p,
-			&env->src_rq->cfs_tasks, se.group_node) {
+			tasks, se.group_node) {
 		if (!can_migrate_task(p, env))
 			continue;
 
@@ -8009,6 +8033,10 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 		schedstat_inc(env->sd->lb_gained[env->idle]);
 		return p;
 	}
+	if (++loop == 1) {
+		tasks = &env->src_rq->cfs_idle_tasks;
+		goto again;
+	}
 	return NULL;
 }
 
@@ -8026,6 +8054,7 @@ static int detach_tasks(struct lb_env *env)
 	unsigned long util, load;
 	struct task_struct *p;
 	int detached = 0;
+	int loop = 0;
 
 	lockdep_assert_rq_held(env->src_rq);
 
@@ -8041,6 +8070,7 @@ static int detach_tasks(struct lb_env *env)
 	if (env->imbalance <= 0)
 		return 0;
 
+again:
 	while (!list_empty(tasks)) {
 		/*
 		 * We don't want to steal all, otherwise we may be treated likewise,
@@ -8142,6 +8172,11 @@ static int detach_tasks(struct lb_env *env)
 		list_move(&p->se.group_node, tasks);
 	}
 
+	if (env->imbalance > 0 && ++loop == 1) {
+		tasks = &env->src_rq->cfs_idle_tasks;
+		goto again;
+	}
+
 	/*
 	 * Right now, this is one of only two places we collect this stat
 	 * so we can safely collect detach_one_task() stats here rather
@@ -11643,7 +11678,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 		 * Move the next running task to the front of the list, so our
 		 * cfs_tasks list becomes MRU one.
 		 */
-		list_move(&se->group_node, &rq->cfs_tasks);
+		adjust_rq_cfs_tasks(list_move, rq, se);
 	}
 #endif
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e26688d387ae..accb4eea9769 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1068,6 +1068,7 @@ struct rq {
 	int			online;
 
 	struct list_head cfs_tasks;
+	struct list_head cfs_idle_tasks;
 
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
-- 
2.27.0


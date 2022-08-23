Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31ED59D18E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbiHWGzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiHWGzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:55:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E771C939
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:54:59 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MBg065l5lznTmP;
        Tue, 23 Aug 2022 14:52:38 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 14:54:38 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 23 Aug
 2022 14:54:37 +0800
From:   shangxiaojing <shangxiaojing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>, <cj.chengjian@huawei.com>
Subject: [PATCH -next] sched: Add dequeue_and_put_task and enqueue_and_set_task helper
Date:   Tue, 23 Aug 2022 15:29:47 +0800
Message-ID: <20220823072947.16720-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap repeated code in helper functions dequeue_and_put_task and
enqueue_and_set_task, note that dequeue_and_put_task is not
applyed in __do_set_cpus_allowed cause the lock assert.

Signed-off-by: shangxiaojing <shangxiaojing@huawei.com>
---
 kernel/sched/core.c | 103 ++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 61 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 61436b8e0337..46d6ba551e04 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2540,6 +2540,28 @@ void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_ma
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
+static __always_inline
+void dequeue_and_put_task(struct rq *rq, struct task_struct *p, int flags,
+			  bool *queued, bool *running)
+{
+	*queued = task_on_rq_queued(p);
+	*running = task_current(rq, p);
+	if (*queued)
+		dequeue_task(rq, p, flags);
+	if (*running)
+		put_prev_task(rq, p);
+}
+
+static __always_inline
+void enqueue_and_set_task(struct rq *rq, struct task_struct *p, int flags,
+			  bool queued, bool running)
+{
+	if (queued)
+		enqueue_task(rq, p, flags);
+	if (running)
+		set_next_task(rq, p);
+}
+
 static void
 __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
 {
@@ -2579,10 +2601,7 @@ __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32
 
 	p->sched_class->set_cpus_allowed(p, new_mask, flags);
 
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
+	enqueue_and_set_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK, queued, running);
 }
 
 void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
@@ -6876,8 +6895,9 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
  */
 void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 {
-	int prio, oldprio, queued, running, queue_flag =
+	int prio, oldprio, queue_flag =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+	bool queued, running;
 	const struct sched_class *prev_class;
 	struct rq_flags rf;
 	struct rq *rq;
@@ -6936,12 +6956,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 		queue_flag &= ~DEQUEUE_MOVE;
 
 	prev_class = p->sched_class;
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
-	if (queued)
-		dequeue_task(rq, p, queue_flag);
-	if (running)
-		put_prev_task(rq, p);
+	dequeue_and_put_task(rq, p, queue_flag, &queued, &running);
 
 	/*
 	 * Boosting condition are:
@@ -6975,10 +6990,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 
 	__setscheduler_prio(p, prio);
 
-	if (queued)
-		enqueue_task(rq, p, queue_flag);
-	if (running)
-		set_next_task(rq, p);
+	enqueue_and_set_task(rq, p, queue_flag, queued, running);
 
 	check_class_changed(rq, p, prev_class, oldprio);
 out_unlock:
@@ -7024,22 +7036,14 @@ void set_user_nice(struct task_struct *p, long nice)
 		p->static_prio = NICE_TO_PRIO(nice);
 		goto out_unlock;
 	}
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
-	if (queued)
-		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
-	if (running)
-		put_prev_task(rq, p);
+	dequeue_and_put_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK, &queued, &running);
 
 	p->static_prio = NICE_TO_PRIO(nice);
 	set_load_weight(p, true);
 	old_prio = p->prio;
 	p->prio = effective_prio(p);
 
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
+	enqueue_and_set_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK, queued, running);
 
 	/*
 	 * If the task increased its priority or is running and
@@ -7423,7 +7427,8 @@ static int __sched_setscheduler(struct task_struct *p,
 				bool user, bool pi)
 {
 	int oldpolicy = -1, policy = attr->sched_policy;
-	int retval, oldprio, newprio, queued, running;
+	int retval, oldprio, newprio;
+	bool queued, running;
 	const struct sched_class *prev_class;
 	struct callback_head *head;
 	struct rq_flags rf;
@@ -7588,12 +7593,7 @@ static int __sched_setscheduler(struct task_struct *p,
 			queue_flags &= ~DEQUEUE_MOVE;
 	}
 
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
-	if (queued)
-		dequeue_task(rq, p, queue_flags);
-	if (running)
-		put_prev_task(rq, p);
+	dequeue_and_put_task(rq, p, queue_flags, &queued, &running);
 
 	prev_class = p->sched_class;
 
@@ -7603,18 +7603,15 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 	__setscheduler_uclamp(p, attr);
 
-	if (queued) {
+	if (queued & (oldprio < p->prio)) {
 		/*
 		 * We enqueue to tail when the priority of a task is
 		 * increased (user space view).
 		 */
-		if (oldprio < p->prio)
-			queue_flags |= ENQUEUE_HEAD;
-
-		enqueue_task(rq, p, queue_flags);
+		queue_flags |= ENQUEUE_HEAD;
 	}
-	if (running)
-		set_next_task(rq, p);
+
+	enqueue_and_set_task(rq, p, queue_flags, queued, running);
 
 	check_class_changed(rq, p, prev_class, oldprio);
 
@@ -9094,20 +9091,12 @@ void sched_setnuma(struct task_struct *p, int nid)
 	struct rq *rq;
 
 	rq = task_rq_lock(p, &rf);
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
 
-	if (queued)
-		dequeue_task(rq, p, DEQUEUE_SAVE);
-	if (running)
-		put_prev_task(rq, p);
+	dequeue_and_put_task(rq, p, DEQUEUE_SAVE, &queued, &running);
 
 	p->numa_preferred_nid = nid;
 
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
+	enqueue_and_set_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK, queued, running);
 	task_rq_unlock(rq, p, &rf);
 }
 #endif /* CONFIG_NUMA_BALANCING */
@@ -10198,28 +10187,20 @@ static void sched_change_group(struct task_struct *tsk, int type)
  */
 void sched_move_task(struct task_struct *tsk)
 {
-	int queued, running, queue_flags =
-		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+	bool queued, running;
 	struct rq_flags rf;
 	struct rq *rq;
 
 	rq = task_rq_lock(tsk, &rf);
 	update_rq_clock(rq);
 
-	running = task_current(rq, tsk);
-	queued = task_on_rq_queued(tsk);
-
-	if (queued)
-		dequeue_task(rq, tsk, queue_flags);
-	if (running)
-		put_prev_task(rq, tsk);
+	dequeue_and_put_task(rq, tsk, queue_flags, &queued, &running);
 
 	sched_change_group(tsk, TASK_MOVE_GROUP);
 
-	if (queued)
-		enqueue_task(rq, tsk, queue_flags);
+	enqueue_and_set_task(rq, tsk, queue_flags, queued, running);
 	if (running) {
-		set_next_task(rq, tsk);
 		/*
 		 * After changing group, the running task may have joined a
 		 * throttled one but it's still the running task. Trigger a
-- 
2.17.1


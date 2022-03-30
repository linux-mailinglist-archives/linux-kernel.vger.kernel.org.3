Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEFD4EC99C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348790AbiC3QYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348784AbiC3QYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:24:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC04AF1C1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iOXjzzs0gwl1MoD0PWwTDepz5LLd3mU8QQqCmz4m5b4=; b=RXgB1SZDBj+akWCqrl7SRVacsi
        ypztUqE4+hSnyCDYPXJvfjiW8/5jgz9zjunkJCC+tTM2i0KS0ZT3J8yJ/k/rsCg8PrAUo1gSHJVeN
        3Z8I1eK5P9qCY7ZR1gjuqyFO/T57zy8ek3yqtsWUKbU1vxslkVdy+U+x5ap9mL+CfqBqF7bxRRvL+
        /RnjKwx9lYbLuZbKOqHI8f+OM5b8jRTr3gF0Lh6zhijA4YXM/cq7FTQasqCRg6dsF8Y9YsAV5vhEq
        ZWB/ikUg/6UEKWmFHEBVxO81pwbWbGS3046nrH3v6B7w0A5/Hj1XZrFCxjsCGy+aCe8qDXulkvSpL
        QjT18RZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZb5Y-006FRR-Vf; Wed, 30 Mar 2022 16:22:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 850AC98695C; Wed, 30 Mar 2022 18:22:28 +0200 (CEST)
Date:   Wed, 30 Mar 2022 18:22:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        vincent.guittot@linaro.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        joel@joelfernandes.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Subject: Re: [PATCH] sched/core: Fix forceidle balancing
Message-ID: <20220330162228.GH14330@worktop.programming.kicks-ass.net>
References: <20220330160535.GN8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330160535.GN8939@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 06:05:35PM +0200, Peter Zijlstra wrote:

> rt_mutex_setprio() also uses set_next_task() in the 'change' pattern:
> 
> 	queued = task_on_rq_queued(p); /* p->on_rq == TASK_ON_RQ_QUEUED */
> 	running = task_current(rq, p); /* rq->curr == p */
> 
> 	if (queued)
> 		dequeue_task(...);
> 	if (running)
> 		put_prev_task(...);
> 
> 	/* change task properties */
> 
> 	if (queued)
> 		enqueue_task(...);
> 	if (running)
> 		set_next_task(...);
> 

Also, while procrastinating while writing this changelog, I did the
below... is that worth it?

---
 kernel/sched/core.c | 249 ++++++++++++++++++++++++----------------------------
 1 file changed, 115 insertions(+), 134 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d575b4914925..6455e0bbbeb9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2549,11 +2549,53 @@ void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_ma
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
+struct change_guard {
+	struct task_struct *p;
+	struct rq *rq;
+	unsigned int flags;
+	bool queued, running, done;
+};
+
+static inline struct change_guard
+change_guard_init(struct rq *rq, struct task_struct *p, unsigned int flags)
+{
+	struct change_guard cg = {
+		.rq = rq,
+		.p = p,
+		.flags = flags,
+		.queued = task_on_rq_queued(p),
+		.running = task_current(rq, p),
+	};
+
+	if (cg.queued)
+		dequeue_task(rq, p, flags);
+	if (cg.running)
+		put_prev_task(rq, p);
+
+	return cg;
+}
+
+static inline void change_guard_fini(struct change_guard *cg)
+{
+	if (cg->queued)
+		enqueue_task(cg->rq, cg->p, cg->flags | ENQUEUE_NOCLOCK);
+	if (cg->running)
+		set_next_task(cg->rq, cg->p);
+}
+
+#define __cleanup(_fini)		__attribute__((__cleanup__(_fini)))
+
+#define CHANGE_GUARD(name, _rq, _p, _flags)			\
+	struct change_guard __cleanup(change_guard_fini) name =	\
+		change_guard_init(_rq, _p, _flags)
+
+#define FOR_CHANGE_GUARD(name, _rq, _p, _flags)	\
+	for (CHANGE_GUARD(name, _rq, _p, _flags); !name.done; name.done = true)
+
 static void
 __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
 {
 	struct rq *rq = task_rq(p);
-	bool queued, running;
 
 	/*
 	 * This here violates the locking rules for affinity, since we're only
@@ -2572,26 +2614,16 @@ __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32
 	else
 		lockdep_assert_held(&p->pi_lock);
 
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
-
-	if (queued) {
-		/*
-		 * Because __kthread_bind() calls this on blocked tasks without
-		 * holding rq->lock.
-		 */
-		lockdep_assert_rq_held(rq);
-		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
+	FOR_CHANGE_GUARD(cg, rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK) {
+		if (cg.queued) {
+			/*
+			 * Because __kthread_bind() calls this on blocked tasks without
+			 * holding rq->lock.
+			 */
+			lockdep_assert_rq_held(rq);
+		}
+		p->sched_class->set_cpus_allowed(p, new_mask, flags);
 	}
-	if (running)
-		put_prev_task(rq, p);
-
-	p->sched_class->set_cpus_allowed(p, new_mask, flags);
-
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
 }
 
 void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
@@ -6745,7 +6777,7 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
  */
 void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 {
-	int prio, oldprio, queued, running, queue_flag =
+	int prio, oldprio, queue_flag =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	const struct sched_class *prev_class;
 	struct rq_flags rf;
@@ -6805,49 +6837,39 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 		queue_flag &= ~DEQUEUE_MOVE;
 
 	prev_class = p->sched_class;
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
-	if (queued)
-		dequeue_task(rq, p, queue_flag);
-	if (running)
-		put_prev_task(rq, p);
-
-	/*
-	 * Boosting condition are:
-	 * 1. -rt task is running and holds mutex A
-	 *      --> -dl task blocks on mutex A
-	 *
-	 * 2. -dl task is running and holds mutex A
-	 *      --> -dl task blocks on mutex A and could preempt the
-	 *          running task
-	 */
-	if (dl_prio(prio)) {
-		if (!dl_prio(p->normal_prio) ||
-		    (pi_task && dl_prio(pi_task->prio) &&
-		     dl_entity_preempt(&pi_task->dl, &p->dl))) {
-			p->dl.pi_se = pi_task->dl.pi_se;
-			queue_flag |= ENQUEUE_REPLENISH;
+	FOR_CHANGE_GUARD(cg, rq, p, queue_flag) {
+		/*
+		 * Boosting condition are:
+		 * 1. -rt task is running and holds mutex A
+		 *      --> -dl task blocks on mutex A
+		 *
+		 * 2. -dl task is running and holds mutex A
+		 *      --> -dl task blocks on mutex A and could preempt the
+		 *          running task
+		 */
+		if (dl_prio(prio)) {
+			if (!dl_prio(p->normal_prio) ||
+			    (pi_task && dl_prio(pi_task->prio) &&
+			     dl_entity_preempt(&pi_task->dl, &p->dl))) {
+				p->dl.pi_se = pi_task->dl.pi_se;
+				queue_flag |= ENQUEUE_REPLENISH;
+			} else {
+				p->dl.pi_se = &p->dl;
+			}
+		} else if (rt_prio(prio)) {
+			if (dl_prio(oldprio))
+				p->dl.pi_se = &p->dl;
+			if (oldprio < prio)
+				queue_flag |= ENQUEUE_HEAD;
 		} else {
-			p->dl.pi_se = &p->dl;
+			if (dl_prio(oldprio))
+				p->dl.pi_se = &p->dl;
+			if (rt_prio(oldprio))
+				p->rt.timeout = 0;
 		}
-	} else if (rt_prio(prio)) {
-		if (dl_prio(oldprio))
-			p->dl.pi_se = &p->dl;
-		if (oldprio < prio)
-			queue_flag |= ENQUEUE_HEAD;
-	} else {
-		if (dl_prio(oldprio))
-			p->dl.pi_se = &p->dl;
-		if (rt_prio(oldprio))
-			p->rt.timeout = 0;
-	}
 
-	__setscheduler_prio(p, prio);
-
-	if (queued)
-		enqueue_task(rq, p, queue_flag);
-	if (running)
-		set_next_task(rq, p);
+		__setscheduler_prio(p, prio);
+	}
 
 	check_class_changed(rq, p, prev_class, oldprio);
 out_unlock:
@@ -6869,10 +6891,9 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
 
 void set_user_nice(struct task_struct *p, long nice)
 {
-	bool queued, running;
-	int old_prio;
 	struct rq_flags rf;
 	struct rq *rq;
+	int old_prio;
 
 	if (task_nice(p) == nice || nice < MIN_NICE || nice > MAX_NICE)
 		return;
@@ -6893,22 +6914,12 @@ void set_user_nice(struct task_struct *p, long nice)
 		p->static_prio = NICE_TO_PRIO(nice);
 		goto out_unlock;
 	}
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
-	if (queued)
-		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
-	if (running)
-		put_prev_task(rq, p);
-
-	p->static_prio = NICE_TO_PRIO(nice);
-	set_load_weight(p, true);
-	old_prio = p->prio;
-	p->prio = effective_prio(p);
-
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
+	FOR_CHANGE_GUARD(cg, rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK) {
+		p->static_prio = NICE_TO_PRIO(nice);
+		set_load_weight(p, true);
+		old_prio = p->prio;
+		p->prio = effective_prio(p);
+	}
 
 	/*
 	 * If the task increased its priority or is running and
@@ -7216,8 +7227,8 @@ static int __sched_setscheduler(struct task_struct *p,
 				bool user, bool pi)
 {
 	int oldpolicy = -1, policy = attr->sched_policy;
-	int retval, oldprio, newprio, queued, running;
 	const struct sched_class *prev_class;
+	int retval, oldprio, newprio;
 	struct callback_head *head;
 	struct rq_flags rf;
 	int reset_on_fork;
@@ -7428,33 +7439,24 @@ static int __sched_setscheduler(struct task_struct *p,
 			queue_flags &= ~DEQUEUE_MOVE;
 	}
 
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
-	if (queued)
-		dequeue_task(rq, p, queue_flags);
-	if (running)
-		put_prev_task(rq, p);
-
 	prev_class = p->sched_class;
 
-	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
-		__setscheduler_params(p, attr);
-		__setscheduler_prio(p, newprio);
-	}
-	__setscheduler_uclamp(p, attr);
-
-	if (queued) {
-		/*
-		 * We enqueue to tail when the priority of a task is
-		 * increased (user space view).
-		 */
-		if (oldprio < p->prio)
-			queue_flags |= ENQUEUE_HEAD;
+	FOR_CHANGE_GUARD(cg, rq, p, queue_flags) {
+		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
+			__setscheduler_params(p, attr);
+			__setscheduler_prio(p, newprio);
+		}
+		__setscheduler_uclamp(p, attr);
 
-		enqueue_task(rq, p, queue_flags);
+		if (cg.queued) {
+			/*
+			 * We enqueue to tail when the priority of a task is
+			 * increased (user space view).
+			 */
+			if (oldprio < p->prio)
+				cg.flags |= ENQUEUE_HEAD;
+		}
 	}
-	if (running)
-		set_next_task(rq, p);
 
 	check_class_changed(rq, p, prev_class, oldprio);
 
@@ -8915,25 +8917,13 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
  */
 void sched_setnuma(struct task_struct *p, int nid)
 {
-	bool queued, running;
 	struct rq_flags rf;
 	struct rq *rq;
 
 	rq = task_rq_lock(p, &rf);
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
-
-	if (queued)
-		dequeue_task(rq, p, DEQUEUE_SAVE);
-	if (running)
-		put_prev_task(rq, p);
-
-	p->numa_preferred_nid = nid;
-
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
+	FOR_CHANGE_GUARD(cg, rq, p, DEQUEUE_SAVE) {
+		p->numa_preferred_nid = nid;
+	}
 	task_rq_unlock(rq, p, &rf);
 }
 #endif /* CONFIG_NUMA_BALANCING */
@@ -10035,28 +10025,19 @@ static void sched_change_group(struct task_struct *tsk, int type)
  */
 void sched_move_task(struct task_struct *tsk)
 {
-	int queued, running, queue_flags =
-		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+	bool resched = false;
 	struct rq_flags rf;
 	struct rq *rq;
 
 	rq = task_rq_lock(tsk, &rf);
-	update_rq_clock(rq);
-
-	running = task_current(rq, tsk);
-	queued = task_on_rq_queued(tsk);
 
-	if (queued)
-		dequeue_task(rq, tsk, queue_flags);
-	if (running)
-		put_prev_task(rq, tsk);
-
-	sched_change_group(tsk, TASK_MOVE_GROUP);
+	FOR_CHANGE_GUARD(cg, rq, tsk, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		sched_change_group(tsk, TASK_MOVE_GROUP);
+		if (cg.running)
+			resched = true;
+	}
 
-	if (queued)
-		enqueue_task(rq, tsk, queue_flags);
-	if (running) {
-		set_next_task(rq, tsk);
+	if (resched) {
 		/*
 		 * After changing group, the running task may have joined a
 		 * throttled one but it's still the running task. Trigger a

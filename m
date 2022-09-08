Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38B25B26FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiIHTme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiIHTmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:42:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E29CCD6F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662666123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wa4jMrWf4h46iuaX6C0rsJTKtu2WHz+HFgVSDD+vhso=;
        b=KFaRvjJw77MuzW183f0WWVQnuxdwey274JFCSwzv1fI1oVAQEKRr46qE9R+na9NVwPe8yL
        XLu/TQoeagOkA3SYtpu4JOgy6BkmvHeYKnGYkDIu+Qk92K5lp+oHBuHPwvJY2tlEh5uDFP
        zMlO02TvPGf3tV1l2gRk1b2EhAMzj6Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-Ehcfk8nPO6WUnIkmiVC0gQ-1; Thu, 08 Sep 2022 15:41:54 -0400
X-MC-Unique: Ehcfk8nPO6WUnIkmiVC0gQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 919ED8039B5;
        Thu,  8 Sep 2022 19:41:53 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFCD81415117;
        Thu,  8 Sep 2022 19:41:52 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v8 4/7] sched: Introduce affinity_context structure
Date:   Thu,  8 Sep 2022 15:41:18 -0400
Message-Id: <20220908194121.858462-5-longman@redhat.com>
In-Reply-To: <20220908194121.858462-1-longman@redhat.com>
References: <20220908194121.858462-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new affinity_context structure for passing cpu affinity information
around in core scheduler code. The relevant functions are modified to use
the new structure. There is no functional change.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c     | 114 ++++++++++++++++++++++++++--------------
 kernel/sched/deadline.c |   7 ++-
 kernel/sched/sched.h    |  11 ++--
 3 files changed, 86 insertions(+), 46 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 84544daf3839..b43b851c0399 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2195,14 +2195,18 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 #ifdef CONFIG_SMP
 
 static void
-__do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
+__do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx);
 
 static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  const struct cpumask *new_mask,
-				  u32 flags);
+				  struct affinity_context *ctx);
 
 static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 {
+	struct affinity_context ac = {
+		.new_mask  = cpumask_of(rq->cpu),
+		.flags     = SCA_MIGRATE_DISABLE,
+	};
+
 	if (likely(!p->migration_disabled))
 		return;
 
@@ -2212,7 +2216,7 @@ static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 	/*
 	 * Violates locking rules! see comment in __do_set_cpus_allowed().
 	 */
-	__do_set_cpus_allowed(p, cpumask_of(rq->cpu), SCA_MIGRATE_DISABLE);
+	__do_set_cpus_allowed(p, &ac);
 }
 
 void migrate_disable(void)
@@ -2234,6 +2238,10 @@ EXPORT_SYMBOL_GPL(migrate_disable);
 void migrate_enable(void)
 {
 	struct task_struct *p = current;
+	struct affinity_context ac = {
+		.new_mask  = &p->cpus_mask,
+		.flags     = SCA_MIGRATE_ENABLE,
+	};
 
 	if (p->migration_disabled > 1) {
 		p->migration_disabled--;
@@ -2249,7 +2257,7 @@ void migrate_enable(void)
 	 */
 	preempt_disable();
 	if (p->cpus_ptr != &p->cpus_mask)
-		__set_cpus_allowed_ptr(p, &p->cpus_mask, SCA_MIGRATE_ENABLE);
+		__set_cpus_allowed_ptr(p, &ac);
 	/*
 	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
 	 * regular cpus_mask, otherwise things that race (eg.
@@ -2529,19 +2537,19 @@ int push_cpu_stop(void *arg)
  * sched_class::set_cpus_allowed must do the below, but is not required to
  * actually call this function.
  */
-void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
+void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx)
 {
-	if (flags & (SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) {
-		p->cpus_ptr = new_mask;
+	if (ctx->flags & (SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) {
+		p->cpus_ptr = ctx->new_mask;
 		return;
 	}
 
-	cpumask_copy(&p->cpus_mask, new_mask);
-	p->nr_cpus_allowed = cpumask_weight(new_mask);
+	cpumask_copy(&p->cpus_mask, ctx->new_mask);
+	p->nr_cpus_allowed = cpumask_weight(ctx->new_mask);
 }
 
 static void
-__do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
+__do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
 	struct rq *rq = task_rq(p);
 	bool queued, running;
@@ -2558,7 +2566,7 @@ __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32
 	 *
 	 * XXX do further audits, this smells like something putrid.
 	 */
-	if (flags & SCA_MIGRATE_DISABLE)
+	if (ctx->flags & SCA_MIGRATE_DISABLE)
 		SCHED_WARN_ON(!p->on_cpu);
 	else
 		lockdep_assert_held(&p->pi_lock);
@@ -2577,7 +2585,7 @@ __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32
 	if (running)
 		put_prev_task(rq, p);
 
-	p->sched_class->set_cpus_allowed(p, new_mask, flags);
+	p->sched_class->set_cpus_allowed(p, ctx);
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -2587,7 +2595,12 @@ __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32
 
 void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
-	__do_set_cpus_allowed(p, new_mask, 0);
+	struct affinity_context ac = {
+		.new_mask  = new_mask,
+		.flags     = 0,
+	};
+
+	__do_set_cpus_allowed(p, &ac);
 }
 
 int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
@@ -2840,8 +2853,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
  * Called with both p->pi_lock and rq->lock held; drops both before returning.
  */
 static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
-					 const struct cpumask *new_mask,
-					 u32 flags,
+					 struct affinity_context *ctx,
 					 struct rq *rq,
 					 struct rq_flags *rf)
 	__releases(rq->lock)
@@ -2869,7 +2881,7 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 		cpu_valid_mask = cpu_online_mask;
 	}
 
-	if (!kthread && !cpumask_subset(new_mask, cpu_allowed_mask)) {
+	if (!kthread && !cpumask_subset(ctx->new_mask, cpu_allowed_mask)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -2878,18 +2890,18 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 	 * Must re-check here, to close a race against __kthread_bind(),
 	 * sched_setaffinity() is not guaranteed to observe the flag.
 	 */
-	if ((flags & SCA_CHECK) && (p->flags & PF_NO_SETAFFINITY)) {
+	if ((ctx->flags & SCA_CHECK) && (p->flags & PF_NO_SETAFFINITY)) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (!(flags & SCA_MIGRATE_ENABLE)) {
-		if (cpumask_equal(&p->cpus_mask, new_mask))
+	if (!(ctx->flags & SCA_MIGRATE_ENABLE)) {
+		if (cpumask_equal(&p->cpus_mask, ctx->new_mask))
 			goto out;
 
 		if (WARN_ON_ONCE(p == current &&
 				 is_migration_disabled(p) &&
-				 !cpumask_test_cpu(task_cpu(p), new_mask))) {
+				 !cpumask_test_cpu(task_cpu(p), ctx->new_mask))) {
 			ret = -EBUSY;
 			goto out;
 		}
@@ -2900,15 +2912,15 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 	 * for groups of tasks (ie. cpuset), so that load balancing is not
 	 * immediately required to distribute the tasks within their new mask.
 	 */
-	dest_cpu = cpumask_any_and_distribute(cpu_valid_mask, new_mask);
+	dest_cpu = cpumask_any_and_distribute(cpu_valid_mask, ctx->new_mask);
 	if (dest_cpu >= nr_cpu_ids) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	__do_set_cpus_allowed(p, new_mask, flags);
+	__do_set_cpus_allowed(p, ctx);
 
-	return affine_move_task(rq, p, rf, dest_cpu, flags);
+	return affine_move_task(rq, p, rf, dest_cpu, ctx->flags);
 
 out:
 	task_rq_unlock(rq, p, rf);
@@ -2926,22 +2938,27 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
  * call is not atomic; no spinlocks may be held.
  */
 static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  const struct cpumask *new_mask, u32 flags)
+				  struct affinity_context *ctx)
 {
 	struct rq_flags rf;
 	struct rq *rq;
 
 	rq = task_rq_lock(p, &rf);
-	if (p->user_cpus_ptr && !(flags & SCA_USER) &&
-	    cpumask_and(rq->scratch_mask, new_mask, p->user_cpus_ptr))
-		new_mask = rq->scratch_mask;
+	if (p->user_cpus_ptr && !(ctx->flags & SCA_USER) &&
+	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
+		ctx->new_mask = rq->scratch_mask;
 
-	return __set_cpus_allowed_ptr_locked(p, new_mask, flags, rq, &rf);
+	return __set_cpus_allowed_ptr_locked(p, ctx, rq, &rf);
 }
 
 int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 {
-	return __set_cpus_allowed_ptr(p, new_mask, 0);
+	struct affinity_context ac = {
+		.new_mask  = new_mask,
+		.flags     = 0,
+	};
+
+	return __set_cpus_allowed_ptr(p, &ac);
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
@@ -2958,6 +2975,10 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
 				     struct cpumask *new_mask,
 				     const struct cpumask *subset_mask)
 {
+	struct affinity_context ac = {
+		.new_mask  = new_mask,
+		.flags     = 0,
+	};
 	struct rq_flags rf;
 	struct rq *rq;
 	int err;
@@ -2979,7 +3000,7 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
 		goto err_unlock;
 	}
 
-	return __set_cpus_allowed_ptr_locked(p, new_mask, 0, rq, &rf);
+	return __set_cpus_allowed_ptr_locked(p, &ac, rq, &rf);
 
 err_unlock:
 	task_rq_unlock(rq, p, &rf);
@@ -3032,7 +3053,7 @@ void force_compatible_cpus_allowed_ptr(struct task_struct *p)
 }
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, int flags);
+__sched_setaffinity(struct task_struct *p, struct affinity_context *ctx);
 
 /*
  * Restore the affinity of a task @p which was previously restricted by a
@@ -3043,13 +3064,17 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask, int flags
  */
 void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 {
+	struct affinity_context ac = {
+		.new_mask  = task_user_cpus(p),
+		.flags     = 0,
+	};
 	int ret;
 
 	/*
 	 * Try to restore the old affinity mask with __sched_setaffinity().
 	 * Cpuset masking will be done there too.
 	 */
-	ret = __sched_setaffinity(p, task_user_cpus(p), 0);
+	ret = __sched_setaffinity(p, &ac);
 	WARN_ON_ONCE(ret);
 }
 
@@ -8053,7 +8078,7 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
 #endif
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, int flags)
+__sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 {
 	int retval;
 	cpumask_var_t cpus_allowed, new_mask;
@@ -8067,13 +8092,16 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask, int flags
 	}
 
 	cpuset_cpus_allowed(p, cpus_allowed);
-	cpumask_and(new_mask, mask, cpus_allowed);
+	cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
+
+	ctx->new_mask = new_mask;
+	ctx->flags |= SCA_CHECK;
 
 	retval = dl_task_check_affinity(p, new_mask);
 	if (retval)
 		goto out_free_new_mask;
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | flags);
+	retval = __set_cpus_allowed_ptr(p, ctx);
 	if (retval)
 		goto out_free_new_mask;
 
@@ -8096,6 +8124,7 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask, int flags
 
 long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 {
+	struct affinity_context ac;
 	struct cpumask *user_mask;
 	struct task_struct *p;
 	int retval;
@@ -8137,8 +8166,12 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 		goto out_put_task;
 	}
 	cpumask_copy(user_mask, in_mask);
+	ac = (struct affinity_context){
+		.new_mask  = in_mask,
+		.flags     = SCA_USER,
+	};
 
-	retval = __sched_setaffinity(p, in_mask, SCA_USER);
+	retval = __sched_setaffinity(p, &ac);
 
 	/*
 	 * Save in_mask into user_cpus_ptr after a successful
@@ -8936,6 +8969,7 @@ void show_state_filter(unsigned int state_filter)
 void __init init_idle(struct task_struct *idle, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
+	struct affinity_context ac;
 	unsigned long flags;
 
 	__sched_fork(0, idle);
@@ -8953,13 +8987,17 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	kthread_set_per_cpu(idle, cpu);
 
 #ifdef CONFIG_SMP
+	ac = (struct affinity_context) {
+		.new_mask  = cpumask_of(cpu),
+		.flags     = 0,
+	};
 	/*
 	 * It's possible that init_idle() gets called multiple times on a task,
 	 * in that case do_set_cpus_allowed() will not do the right thing.
 	 *
 	 * And since this is boot we can forgo the serialization.
 	 */
-	set_cpus_allowed_common(idle, cpumask_of(cpu), 0);
+	set_cpus_allowed_common(idle, &ac);
 #endif
 	/*
 	 * We're having a chicken and egg problem, even though we are
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0ab79d819a0d..38fa2c3ef7db 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2486,8 +2486,7 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 }
 
 static void set_cpus_allowed_dl(struct task_struct *p,
-				const struct cpumask *new_mask,
-				u32 flags)
+				struct affinity_context *ctx)
 {
 	struct root_domain *src_rd;
 	struct rq *rq;
@@ -2502,7 +2501,7 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 	 * update. We already made space for us in the destination
 	 * domain (see cpuset_can_attach()).
 	 */
-	if (!cpumask_intersects(src_rd->span, new_mask)) {
+	if (!cpumask_intersects(src_rd->span, ctx->new_mask)) {
 		struct dl_bw *src_dl_b;
 
 		src_dl_b = dl_bw_of(cpu_of(rq));
@@ -2516,7 +2515,7 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 		raw_spin_unlock(&src_dl_b->lock);
 	}
 
-	set_cpus_allowed_common(p, new_mask, flags);
+	set_cpus_allowed_common(p, ctx);
 }
 
 /* Assumes rq->lock is held */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 482b702d65ea..1927c02f68fa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2157,6 +2157,11 @@ extern const u32		sched_prio_to_wmult[40];
 
 #define RETRY_TASK		((void *)-1UL)
 
+struct affinity_context {
+	const struct cpumask *new_mask;
+	unsigned int flags;
+};
+
 struct sched_class {
 
 #ifdef CONFIG_UCLAMP_TASK
@@ -2185,9 +2190,7 @@ struct sched_class {
 
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
 
-	void (*set_cpus_allowed)(struct task_struct *p,
-				 const struct cpumask *newmask,
-				 u32 flags);
+	void (*set_cpus_allowed)(struct task_struct *p, struct affinity_context *ctx);
 
 	void (*rq_online)(struct rq *rq);
 	void (*rq_offline)(struct rq *rq);
@@ -2301,7 +2304,7 @@ extern void update_group_capacity(struct sched_domain *sd, int cpu);
 
 extern void trigger_load_balance(struct rq *rq);
 
-extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
+extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx);
 
 static inline struct task_struct *get_push_task(struct rq *rq)
 {
-- 
2.31.1


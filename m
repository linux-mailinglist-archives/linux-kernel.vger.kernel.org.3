Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797FE5B1BF0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiIHLyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiIHLxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:53:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F1111C7CC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gdpH0kWLi8UqxSaWHUd2qj2PV5vnwW5oLIpyPqA9K/g=; b=MyX+hyxQPUp7FyZmZFn8cqEaCS
        6dKF43yaLQMJ+xxQMl7fQJuz7cjaLr1/E7VsIuKDjJOnaYZUFJTOj/mmxVvbfqwe17SQvMwHCe/qD
        ynz8ePTWndBOCnQLgOoc/Us7SEm+QYSq54Bup3kSUjpnAwR15qbOEyjttBBb5VIOfLvPC6BpBjvRO
        HLEaIQkTsxRHT5picovEOmjWsWR88x03tEwv9Z5JSea6Vdnpj+xl5rMez0yiMvszpjBkH/E4mjgrn
        dpE0s0MEMv+85tvIliyD9Up+puEv079bS58KQSmgWMZGM6oHchodZ33zlcy+SgJ/rEltogPKl3Hqh
        qfdXVFBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWG62-00CJcT-Pe; Thu, 08 Sep 2022 11:53:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 384CA30008D;
        Thu,  8 Sep 2022 13:53:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14B8B2B6534F6; Thu,  8 Sep 2022 13:53:22 +0200 (CEST)
Date:   Thu, 8 Sep 2022 13:53:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v7 4/5] sched: Handle set_cpus_allowed_ptr() &
 sched_setaffinity() race
Message-ID: <YxnXsnDEKKWeAYDY@hirez.programming.kicks-ass.net>
References: <20220902152556.373658-1-longman@redhat.com>
 <20220902152556.373658-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902152556.373658-5-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:25:55AM -0400, Waiman Long wrote:
> Racing is possible between set_cpus_allowed_ptr() and sched_setaffinity()
> or between multiple sched_setaffinity() calls from different
> CPUs. To resolve these race conditions, we need to update both
> user_cpus_ptr and cpus_mask in a single lock critical section instead
> of separated ones. This requires moving the user_cpus_ptr update to
> set_cpus_allowed_common().
> 
> The SCA_USER flag will be used to signify that a user_cpus_ptr update
> will have to be done. The new user_cpus_ptr will be put into the
> a percpu variable pending_user_mask at the beginning of the lock
> crtical section. The pending user mask will then be taken up in
> set_cpus_allowed_common().
> 
> Ideally, user_cpus_ptr should only be updated if the sched_setaffinity()
> is successful. However, this patch will update user_cpus_ptr when the
> first call to __set_cpus_allowed_ptr() is successful. However, if there
> is racing between sched_setaffinity() and cpuset update, the subsequent
> calls to __set_cpus_allowed_ptr() may fail but the user_cpus_ptr will
> still be updated in this corner case. A warning will be printed in this
> corner case.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

OK, so obviously this is terrible :/

What's wrong with something like so ?

---
 kernel/sched/core.c     | 220 ++++++++++++++++++++++++++++++------------------
 kernel/sched/deadline.c |   7 +-
 kernel/sched/sched.h    |  22 ++++-
 3 files changed, 157 insertions(+), 92 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..01ee81f347b1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2195,14 +2195,19 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
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
+		.user_mask = NULL,
+		.new_mask  = cpumask_of(rq->cpu),
+		.flags     = SCA_MIGRATE_DISABLE,
+	};
+
 	if (likely(!p->migration_disabled))
 		return;
 
@@ -2212,7 +2217,7 @@ static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 	/*
 	 * Violates locking rules! see comment in __do_set_cpus_allowed().
 	 */
-	__do_set_cpus_allowed(p, cpumask_of(rq->cpu), SCA_MIGRATE_DISABLE);
+	__do_set_cpus_allowed(p, &ac);
 }
 
 void migrate_disable(void)
@@ -2234,6 +2239,11 @@ EXPORT_SYMBOL_GPL(migrate_disable);
 void migrate_enable(void)
 {
 	struct task_struct *p = current;
+	struct affinity_context ac = {
+		.user_mask = NULL,
+		.new_mask  = &p->cpus_mask,
+		.flags     = SCA_MIGRATE_ENABLE,
+	};
 
 	if (p->migration_disabled > 1) {
 		p->migration_disabled--;
@@ -2249,7 +2259,7 @@ void migrate_enable(void)
 	 */
 	preempt_disable();
 	if (p->cpus_ptr != &p->cpus_mask)
-		__set_cpus_allowed_ptr(p, &p->cpus_mask, SCA_MIGRATE_ENABLE);
+		__set_cpus_allowed_ptr(p, &ac);
 	/*
 	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
 	 * regular cpus_mask, otherwise things that race (eg.
@@ -2529,19 +2539,22 @@ int push_cpu_stop(void *arg)
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
+	if (ctx->flags & SCA_USER)
+		swap(p->user_cpus_ptr, ctx->user_mask);
+
+	cpumask_copy(&p->cpus_mask, ctx->new_mask);
+	p->nr_cpus_allowed = cpumask_weight(ctx->new_mask);
 }
 
 static void
-__do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
+__do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
 	struct rq *rq = task_rq(p);
 	bool queued, running;
@@ -2558,7 +2571,7 @@ __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32
 	 *
 	 * XXX do further audits, this smells like something putrid.
 	 */
-	if (flags & SCA_MIGRATE_DISABLE)
+	if (ctx->flags & SCA_MIGRATE_DISABLE)
 		SCHED_WARN_ON(!p->on_cpu);
 	else
 		lockdep_assert_held(&p->pi_lock);
@@ -2577,7 +2590,7 @@ __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32
 	if (running)
 		put_prev_task(rq, p);
 
-	p->sched_class->set_cpus_allowed(p, new_mask, flags);
+	p->sched_class->set_cpus_allowed(p, ctx);
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -2585,13 +2598,23 @@ __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32
 		set_next_task(rq, p);
 }
 
+/*
+ * Used for kthread_bind() and select_fallback_rq(), in both cases the user
+ * affinity (if any) should be destroyed too.
+ */
 void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
-	__do_set_cpus_allowed(p, new_mask, 0);
+	struct affinity_context ac = {
+		.user_mask = NULL,
+		.new_mask  = new_mask,
+		.flags     = SCA_USER, /* clear the user requested mask */
+	};
+
+	__do_set_cpus_allowed(p, &ac);
+	kfree(ac.user_mask);
 }
 
-int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
-		      int node)
+int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node)
 {
 	if (!src->user_cpus_ptr)
 		return 0;
@@ -2696,6 +2719,8 @@ void release_user_cpus_ptr(struct task_struct *p)
  */
 static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flags *rf,
 			    int dest_cpu, unsigned int flags)
+	__releases(rq->lock)
+	__releases(p->pi_lock)
 {
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
 	bool stop_pending, complete = false;
@@ -2838,8 +2863,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
  * Called with both p->pi_lock and rq->lock held; drops both before returning.
  */
 static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
-					 const struct cpumask *new_mask,
-					 u32 flags,
+					 struct affinity_context *ctx,
 					 struct rq *rq,
 					 struct rq_flags *rf)
 	__releases(rq->lock)
@@ -2848,7 +2872,6 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	bool kthread = p->flags & PF_KTHREAD;
-	struct cpumask *user_mask = NULL;
 	unsigned int dest_cpu;
 	int ret = 0;
 
@@ -2868,7 +2891,7 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 		cpu_valid_mask = cpu_online_mask;
 	}
 
-	if (!kthread && !cpumask_subset(new_mask, cpu_allowed_mask)) {
+	if (!kthread && !cpumask_subset(ctx->new_mask, cpu_allowed_mask)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -2877,18 +2900,18 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
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
@@ -2899,22 +2922,15 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
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
 
-	if (flags & SCA_USER)
-		user_mask = clear_user_cpus_ptr(p);
-
-	ret = affine_move_task(rq, p, rf, dest_cpu, flags);
-
-	kfree(user_mask);
-
-	return ret;
+	return affine_move_task(rq, p, rf, dest_cpu, ctx->flags);
 
 out:
 	task_rq_unlock(rq, p, rf);
@@ -2932,25 +2948,46 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
  * call is not atomic; no spinlocks may be held.
  */
 static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  const struct cpumask *new_mask, u32 flags)
+				  struct affinity_context *ctx)
 {
 	struct rq_flags rf;
 	struct rq *rq;
 
 	rq = task_rq_lock(p, &rf);
-	return __set_cpus_allowed_ptr_locked(p, new_mask, flags, rq, &rf);
+
+	/*
+	 * When this is not a user requestd affinity change, ensure the
+	 * affinity request respects the previous user affinity if at all
+	 * possible.
+	 *
+	 * XXX why can't we allocated scratch_mask before task_rq_lock()
+	 * and return -ENOMEM here?
+	 */
+	if (p->user_cpus_ptr && !(ctx->flags & SCA_USER) &&
+	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
+		ctx->new_mask = rq->scratch_mask;
+
+	return __set_cpus_allowed_ptr_locked(p, ctx, rq, &rf);
 }
 
 int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 {
-	return __set_cpus_allowed_ptr(p, new_mask, 0);
+	struct affinity_context ac = {
+		.user_mask = NULL,
+		.new_mask  = new_mask,
+		.flags     = 0,
+	};
+
+	return __set_cpus_allowed_ptr(p, &ac);
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
 /*
  * Change a given task's CPU affinity to the intersection of its current
- * affinity mask and @subset_mask, writing the resulting mask to @new_mask
- * and pointing @p->user_cpus_ptr to a copy of the old mask.
+ * affinity mask and @subset_mask, writing the resulting mask to @new_mask.
+ * If user_cpus_ptr is defined, use it as the basis for restricting CPU
+ * affinity or use cpu_online_mask instead.
+ *
  * If the resulting mask is empty, leave the affinity unchanged and return
  * -EINVAL.
  */
@@ -2958,17 +2995,15 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
 				     struct cpumask *new_mask,
 				     const struct cpumask *subset_mask)
 {
-	struct cpumask *user_mask = NULL;
+	struct affinity_context ac = {
+		.user_mask = NULL,
+		.new_mask  = new_mask,
+		.flags     = 0,
+	};
 	struct rq_flags rf;
 	struct rq *rq;
 	int err;
 
-	if (!p->user_cpus_ptr) {
-		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
-		if (!user_mask)
-			return -ENOMEM;
-	}
-
 	rq = task_rq_lock(p, &rf);
 
 	/*
@@ -2981,31 +3016,21 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
 		goto err_unlock;
 	}
 
-	if (!cpumask_and(new_mask, &p->cpus_mask, subset_mask)) {
+	if (!cpumask_and(new_mask, task_user_cpus(p), subset_mask)) {
 		err = -EINVAL;
 		goto err_unlock;
 	}
 
-	/*
-	 * We're about to butcher the task affinity, so keep track of what
-	 * the user asked for in case we're able to restore it later on.
-	 */
-	if (user_mask) {
-		cpumask_copy(user_mask, p->cpus_ptr);
-		p->user_cpus_ptr = user_mask;
-	}
-
-	return __set_cpus_allowed_ptr_locked(p, new_mask, 0, rq, &rf);
+	return __set_cpus_allowed_ptr_locked(p, &ac, rq, &rf);
 
 err_unlock:
 	task_rq_unlock(rq, p, &rf);
-	kfree(user_mask);
 	return err;
 }
 
 /*
  * Restrict the CPU affinity of task @p so that it is a subset of
- * task_cpu_possible_mask() and point @p->user_cpu_ptr to a copy of the
+ * task_cpu_possible_mask() and point @p->user_cpus_ptr to a copy of the
  * old affinity mask. If the resulting mask is empty, we warn and walk
  * up the cpuset hierarchy until we find a suitable mask.
  */
@@ -3049,34 +3074,30 @@ void force_compatible_cpus_allowed_ptr(struct task_struct *p)
 }
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
+__sched_setaffinity(struct task_struct *p, struct affinity_context *ctx);
 
 /*
  * Restore the affinity of a task @p which was previously restricted by a
- * call to force_compatible_cpus_allowed_ptr(). This will clear (and free)
- * @p->user_cpus_ptr.
+ * call to force_compatible_cpus_allowed_ptr().
  *
  * It is the caller's responsibility to serialise this with any calls to
  * force_compatible_cpus_allowed_ptr(@p).
  */
 void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 {
-	struct cpumask *user_mask = p->user_cpus_ptr;
-	unsigned long flags;
+	struct affinity_context ac = {
+		.user_mask = NULL,
+		.new_mask  = task_user_cpus(p),
+		.flags     = 0,
+	};
+	int ret;
 
 	/*
-	 * Try to restore the old affinity mask. If this fails, then
-	 * we free the mask explicitly to avoid it being inherited across
-	 * a subsequent fork().
+	 * Try to restore the old affinity mask with __sched_setaffinity().
+	 * Cpuset masking will be done there too.
 	 */
-	if (!user_mask || !__sched_setaffinity(p, user_mask))
-		return;
-
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	user_mask = clear_user_cpus_ptr(p);
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
-
-	kfree(user_mask);
+	ret = __sched_setaffinity(p, &ac);
+	WARN_ON_ONCE(ret);
 }
 
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
@@ -3554,10 +3575,9 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
 #else /* CONFIG_SMP */
 
 static inline int __set_cpus_allowed_ptr(struct task_struct *p,
-					 const struct cpumask *new_mask,
-					 u32 flags)
+					 struct affinity_context *ctx)
 {
-	return set_cpus_allowed_ptr(p, new_mask);
+	return set_cpus_allowed_ptr(p, ctx->new_mask);
 }
 
 static inline void migrate_disable_switch(struct rq *rq, struct task_struct *p) { }
@@ -8079,10 +8099,10 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
 #endif
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
+__sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 {
-	int retval;
 	cpumask_var_t cpus_allowed, new_mask;
+	int retval;
 
 	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
 		return -ENOMEM;
@@ -8093,13 +8113,16 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
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
-	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | SCA_USER);
+	retval = __set_cpus_allowed_ptr(p, ctx);
 	if (retval)
 		goto out_free_new_mask;
 
@@ -8108,6 +8131,8 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 		/*
 		 * We must have raced with a concurrent cpuset update.
 		 * Just reset the cpumask to the cpuset's cpus_allowed.
+		 *
+		 * XXX can we do better here?
 		 */
 		cpumask_copy(new_mask, cpus_allowed);
 		goto again;
@@ -8122,6 +8147,8 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 
 long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 {
+	struct affinity_context ac;
+	struct cpumask *user_mask;
 	struct task_struct *p;
 	int retval;
 
@@ -8156,7 +8183,23 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	if (retval)
 		goto out_put_task;
 
-	retval = __sched_setaffinity(p, in_mask);
+	user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
+	if (!user_mask) {
+		retval = -ENOMEM;
+		goto out_put_task;
+	}
+	cpumask_copy(user_mask, in_mask);
+
+	ac = (struct affinity_context){
+		.user_mask = user_mask,
+		.new_mask  = in_mask,
+		.flags     = SCA_USER,
+	};
+
+	retval = __sched_setaffinity(p, &ac);
+
+	kfree(user_mask);
+
 out_put_task:
 	put_task_struct(p);
 	return retval;
@@ -8938,6 +8981,7 @@ void show_state_filter(unsigned int state_filter)
 void __init init_idle(struct task_struct *idle, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
+	struct affinity_context ac;
 	unsigned long flags;
 
 	__sched_fork(0, idle);
@@ -8955,13 +8999,18 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	kthread_set_per_cpu(idle, cpu);
 
 #ifdef CONFIG_SMP
+	ac = (struct affinity_context) {
+		.user_mask = NULL,
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
@@ -9653,6 +9702,9 @@ void __init sched_init(void)
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 		per_cpu(select_rq_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
+		per_cpu(runqueues.scratch_mask, i) =
+			(cpumask_var_t)kzalloc_node(cpumask_size(),
+						    GFP_KERNEL, cpu_to_node(i));
 	}
 #endif /* CONFIG_CPUMASK_OFFSTACK */
 
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
index e26688d387ae..d53682557db7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1159,6 +1159,9 @@ struct rq {
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
 #endif
+
+	/* Scratch cpumask to be temporarily used under rq_lock */
+	cpumask_var_t		scratch_mask;
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -1881,6 +1884,13 @@ static inline void dirty_sched_domain_sysctl(int cpu)
 #endif
 
 extern int sched_update_scaling(void);
+
+static inline const struct cpumask *task_user_cpus(struct task_struct *p)
+{
+	if (!p->user_cpus_ptr)
+		return cpu_possible_mask; /* &init_task.cpus_mask */
+	return p->user_cpus_ptr;
+}
 #endif /* CONFIG_SMP */
 
 #include "stats.h"
@@ -2147,6 +2157,12 @@ extern const u32		sched_prio_to_wmult[40];
 
 #define RETRY_TASK		((void *)-1UL)
 
+struct affinity_context {
+	struct cpumask *user_mask;
+	const struct cpumask *new_mask;
+	unsigned int flags;
+};
+
 struct sched_class {
 
 #ifdef CONFIG_UCLAMP_TASK
@@ -2175,9 +2191,7 @@ struct sched_class {
 
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
 
-	void (*set_cpus_allowed)(struct task_struct *p,
-				 const struct cpumask *newmask,
-				 u32 flags);
+	void (*set_cpus_allowed)(struct task_struct *p, struct affinity_context *ctx);
 
 	void (*rq_online)(struct rq *rq);
 	void (*rq_offline)(struct rq *rq);
@@ -2291,7 +2305,7 @@ extern void update_group_capacity(struct sched_domain *sd, int cpu);
 
 extern void trigger_load_balance(struct rq *rq);
 
-extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
+extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx);
 
 static inline struct task_struct *get_push_task(struct rq *rq)
 {

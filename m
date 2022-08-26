Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8934A5A1DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243473AbiHZBCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiHZBCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA8FC8766
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661475720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pWAukaYscQLeoLYkRfg3gQQ3hCYcIJFRVyRdaZTCuPc=;
        b=YmC8rQEVWJPDcgrWX9k8lcao3n220jYfpQo6W4m7gqa7S/BqXXVuOP5X5w5byqdMJkGGeE
        q2qNuN2lcntlBv4Pud0heQicrOXnqI2XXhgEJjyknpg0OLkVZi0UgG0zZwOV6MY9Jw4AsH
        16ZcZafpuGWGO7sxRBmIKjDMHkMbqew=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-EcXtD5aePoKk5cAwD4vGdw-1; Thu, 25 Aug 2022 21:01:57 -0400
X-MC-Unique: EcXtD5aePoKk5cAwD4vGdw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 579663C0ED77;
        Fri, 26 Aug 2022 01:01:56 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95E272026D4C;
        Fri, 26 Aug 2022 01:01:55 +0000 (UTC)
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
Subject: [PATCH v6 4/5] sched: Handle set_cpus_allowed_ptr() & sched_setaffinity() race
Date:   Thu, 25 Aug 2022 21:01:18 -0400
Message-Id: <20220826010119.1265764-5-longman@redhat.com>
In-Reply-To: <20220826010119.1265764-1-longman@redhat.com>
References: <20220826010119.1265764-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Racing is possible between set_cpus_allowed_ptr() and sched_setaffinity()
or between multiple sched_setaffinity() calls from different CPUs. To
resolve these race conditions, we need to update both user_cpus_ptr
and cpus_mask in a single lock critical section instead of separated
ones. This requires moving the user_cpus_ptr update to
affine_move_task() before doing task_rq_unlock().

A new argument puser_mask is added to affine_move_task(),
__set_cpus_allowed_ptr_locked() and __set_cpus_allowed_ptr() to do that.

Ideally, user_cpus_ptr should only be updated if the sched_setaffinity()
is successful. However, this patch will update user_cpus_ptr when the
first call to __set_cpus_allowed_ptr() is successful. However, if there
is racing between sched_setaffinity() and cpuset update, the subsequent
calls to __set_cpus_allowed_ptr() may fail but the user_cpus_ptr will
still be updated in this corner case.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 66 ++++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1c2f548e5369..6cd1177fbcea 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2199,7 +2199,7 @@ __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32
 
 static int __set_cpus_allowed_ptr(struct task_struct *p,
 				  const struct cpumask *new_mask,
-				  u32 flags);
+				  u32 flags, struct cpumask **puser_mask);
 
 static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 {
@@ -2249,7 +2249,7 @@ void migrate_enable(void)
 	 */
 	preempt_disable();
 	if (p->cpus_ptr != &p->cpus_mask)
-		__set_cpus_allowed_ptr(p, &p->cpus_mask, SCA_MIGRATE_ENABLE);
+		__set_cpus_allowed_ptr(p, &p->cpus_mask, SCA_MIGRATE_ENABLE, NULL);
 	/*
 	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
 	 * regular cpus_mask, otherwise things that race (eg.
@@ -2618,6 +2618,15 @@ void release_user_cpus_ptr(struct task_struct *p)
 	kfree(clear_user_cpus_ptr(p));
 }
 
+static inline void swap_user_cpus_ptr(struct task_struct *p,
+				      struct cpumask **puser_mask)
+{
+	if (!puser_mask)
+		return;
+
+	swap(p->user_cpus_ptr, *puser_mask);
+}
+
 /*
  * This function is wildly self concurrent; here be dragons.
  *
@@ -2693,9 +2702,12 @@ void release_user_cpus_ptr(struct task_struct *p)
  * Note that the above is safe vs a concurrent migrate_enable(), as any
  * pending affinity completion is preceded by an uninstallation of
  * p->migration_pending done with p->pi_lock held.
+ *
+ * The puser_mask pointer, if defined, will cause its swap with the current
+ * user_cpus_ptr value if operation succeeds.
  */
 static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flags *rf,
-			    int dest_cpu, unsigned int flags)
+			    int dest_cpu, unsigned int flags, struct cpumask **puser_mask)
 	__releases(rq->lock)
 	__releases(p->pi_lock)
 {
@@ -2722,6 +2734,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			complete = true;
 		}
 
+		swap_user_cpus_ptr(p, puser_mask);
 		task_rq_unlock(rq, p, rf);
 
 		if (push_task) {
@@ -2793,6 +2806,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		if (flags & SCA_MIGRATE_ENABLE)
 			p->migration_flags &= ~MDF_PUSH;
 
+		swap_user_cpus_ptr(p, puser_mask);
 		task_rq_unlock(rq, p, rf);
 
 		if (!stop_pending) {
@@ -2813,6 +2827,8 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 				complete = true;
 			}
 		}
+
+		swap_user_cpus_ptr(p, puser_mask);
 		task_rq_unlock(rq, p, rf);
 
 		if (complete)
@@ -2843,7 +2859,8 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 					 const struct cpumask *new_mask,
 					 u32 flags,
 					 struct rq *rq,
-					 struct rq_flags *rf)
+					 struct rq_flags *rf,
+					 struct cpumask **puser_mask)
 	__releases(rq->lock)
 	__releases(p->pi_lock)
 {
@@ -2908,7 +2925,7 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 
 	__do_set_cpus_allowed(p, new_mask, flags);
 
-	return affine_move_task(rq, p, rf, dest_cpu, flags);
+	return affine_move_task(rq, p, rf, dest_cpu, flags, puser_mask);
 
 out:
 	task_rq_unlock(rq, p, rf);
@@ -2926,7 +2943,8 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
  * call is not atomic; no spinlocks may be held.
  */
 static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  const struct cpumask *new_mask, u32 flags)
+				  const struct cpumask *new_mask, u32 flags,
+				  struct cpumask **puser_mask)
 {
 	struct cpumask *alloc_mask = NULL;
 	struct rq_flags rf;
@@ -2934,8 +2952,11 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	int ret;
 
 	rq = task_rq_lock(p, &rf);
-	if (p->user_cpus_ptr) {
 
+	/*
+	 * user_cpus_ptr masking is skipped if puser_mask is defined.
+	 */
+	if (p->user_cpus_ptr && !puser_mask) {
 		/*
 		 * A scratch cpumask is allocated on the percpu runqueues
 		 * to enable additional masking with user_cpus_ptr. This
@@ -2958,7 +2979,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	}
 
 
-	ret = __set_cpus_allowed_ptr_locked(p, new_mask, flags, rq, &rf);
+	ret = __set_cpus_allowed_ptr_locked(p, new_mask, flags, rq, &rf,
+					    puser_mask);
 	if (unlikely(alloc_mask))
 		kfree(alloc_mask);
 	return ret;
@@ -2966,7 +2988,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 
 int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 {
-	return __set_cpus_allowed_ptr(p, new_mask, 0);
+	return __set_cpus_allowed_ptr(p, new_mask, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
@@ -3004,7 +3026,7 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
 		goto err_unlock;
 	}
 
-	return __set_cpus_allowed_ptr_locked(p, new_mask, 0, rq, &rf);
+	return __set_cpus_allowed_ptr_locked(p, new_mask, 0, rq, &rf, NULL);
 
 err_unlock:
 	task_rq_unlock(rq, p, &rf);
@@ -3551,7 +3573,7 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
 
 static inline int __set_cpus_allowed_ptr(struct task_struct *p,
 					 const struct cpumask *new_mask,
-					 u32 flags)
+					 u32 flags, struct cpumask **puser_mask)
 {
 	return set_cpus_allowed_ptr(p, new_mask);
 }
@@ -8109,29 +8131,25 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask, bool save
 		}
 		cpumask_copy(user_mask, mask);
 	}
-again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
+
+	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK,
+					user_mask ? &user_mask : NULL);
 	if (retval)
 		goto out_free_new_mask;
 
-	cpuset_cpus_allowed(p, cpus_allowed);
-	if (!cpumask_subset(new_mask, cpus_allowed)) {
+	for (;;) {
+		cpuset_cpus_allowed(p, cpus_allowed);
+		if (cpumask_subset(new_mask, cpus_allowed))
+			break;
+
 		/*
 		 * We must have raced with a concurrent cpuset update.
 		 * Just reset the cpumask to the cpuset's cpus_allowed.
 		 */
 		cpumask_copy(new_mask, cpus_allowed);
-		goto again;
+		retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK, NULL);
 	}
 
-	if (save_mask) {
-		unsigned long flags;
-
-		/* Use pi_lock to synchronize changes to user_cpus_ptr */
-		raw_spin_lock_irqsave(&p->pi_lock, flags);
-		swap(p->user_cpus_ptr, user_mask);
-		raw_spin_unlock_irqrestore(&p->pi_lock, flags);
-	}
 out_free_new_mask:
 	kfree(user_mask);
 	free_cpumask_var(new_mask);
-- 
2.31.1


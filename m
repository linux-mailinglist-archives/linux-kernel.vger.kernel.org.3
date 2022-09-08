Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E3E5B26FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiIHTmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiIHTmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05811D076C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662666117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NimEyZtTzJQVDtCo9T4viDWAW4CqgFOy4rbVvNAhs2E=;
        b=JvXPOTo8IaW9G8Gs0A+kXCFFOO10Jldk3gtcnI57Sin3Lfn4wHanERew7n9Bxp7oYzLZZI
        /DIVo5zekqG95tdz3v83L7S7SmL0Vx2zTDtbubxpeWwZZzMake1Bg2LprS4kNPfoKE80eg
        hy5EizGf4nrHF6nHvm+2RYRTikStVNY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-dfMMCxefMHuTOeUjeVUErw-1; Thu, 08 Sep 2022 15:41:53 -0400
X-MC-Unique: dfMMCxefMHuTOeUjeVUErw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2463C18A01AD;
        Thu,  8 Sep 2022 19:41:52 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F0891415117;
        Thu,  8 Sep 2022 19:41:51 +0000 (UTC)
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
Subject: [PATCH v8 2/7] sched: Use user_cpus_ptr for saving user provided cpumask in sched_setaffinity()
Date:   Thu,  8 Sep 2022 15:41:16 -0400
Message-Id: <20220908194121.858462-3-longman@redhat.com>
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

The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
Introduce task_struct::user_cpus_ptr to track requested affinity"). It
is currently used only by arm64 arch due to possible asymmetric CPU
setup. This patch extends its usage to save user provided cpumask
when sched_setaffinity() is called for all arches. With this patch
applied, user_cpus_ptr, once allocated after a successful call to
sched_setaffinity(), will only be freed when the task exits.

Since user_cpus_ptr is supposed to be used for "requested
affinity", there is actually no point to save current cpu affinity in
restrict_cpus_allowed_ptr() if sched_setaffinity() has never been called.
Modify the logic to set user_cpus_ptr only in sched_setaffinity() and use
it in restrict_cpus_allowed_ptr() and relax_compatible_cpus_allowed_ptr()
if defined but not changing it.

This will be some changes in behavior for arm64 systems with asymmetric
CPUs in some corner cases. For instance, if sched_setaffinity()
has never been called and there is a cpuset change before
relax_compatible_cpus_allowed_ptr() is called, its subsequent call will
follow what the cpuset allows but not what the previous cpu affinity
setting allows.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c  | 82 ++++++++++++++++++++------------------------
 kernel/sched/sched.h |  7 ++++
 2 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b351e6d173b7..c7c0425974c2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2850,7 +2850,6 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	bool kthread = p->flags & PF_KTHREAD;
-	struct cpumask *user_mask = NULL;
 	unsigned int dest_cpu;
 	int ret = 0;
 
@@ -2909,14 +2908,7 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 
 	__do_set_cpus_allowed(p, new_mask, flags);
 
-	if (flags & SCA_USER)
-		user_mask = clear_user_cpus_ptr(p);
-
-	ret = affine_move_task(rq, p, rf, dest_cpu, flags);
-
-	kfree(user_mask);
-
-	return ret;
+	return affine_move_task(rq, p, rf, dest_cpu, flags);
 
 out:
 	task_rq_unlock(rq, p, rf);
@@ -2951,8 +2943,10 @@ EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
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
@@ -2960,17 +2954,10 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
 				     struct cpumask *new_mask,
 				     const struct cpumask *subset_mask)
 {
-	struct cpumask *user_mask = NULL;
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
@@ -2983,25 +2970,15 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
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
 	return __set_cpus_allowed_ptr_locked(p, new_mask, 0, rq, &rf);
 
 err_unlock:
 	task_rq_unlock(rq, p, &rf);
-	kfree(user_mask);
 	return err;
 }
 
@@ -3055,30 +3032,21 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
 
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
+	ret = __sched_setaffinity(p, task_user_cpus(p));
+	WARN_ON_ONCE(ret);
 }
 
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
@@ -8101,7 +8069,7 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 	if (retval)
 		goto out_free_new_mask;
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | SCA_USER);
+	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
 	if (retval)
 		goto out_free_new_mask;
 
@@ -8124,6 +8092,7 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 
 long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 {
+	struct cpumask *user_mask;
 	struct task_struct *p;
 	int retval;
 
@@ -8158,7 +8127,30 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	if (retval)
 		goto out_put_task;
 
+	user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
+	if (!user_mask) {
+		retval = -ENOMEM;
+		goto out_put_task;
+	}
+	cpumask_copy(user_mask, in_mask);
+
 	retval = __sched_setaffinity(p, in_mask);
+
+	/*
+	 * Save in_mask into user_cpus_ptr after a successful
+	 * __sched_setaffinity() call. pi_lock is used to synchronize
+	 * changes to user_cpus_ptr.
+	 */
+	if (!retval) {
+		unsigned long flags;
+
+		/* Use pi_lock to synchronize changes to user_cpus_ptr */
+		raw_spin_lock_irqsave(&p->pi_lock, flags);
+		swap(p->user_cpus_ptr, user_mask);
+		raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	}
+	kfree(user_mask);
+
 out_put_task:
 	put_task_struct(p);
 	return retval;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e26688d387ae..ac235bc8ef08 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1881,6 +1881,13 @@ static inline void dirty_sched_domain_sysctl(int cpu)
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
-- 
2.31.1


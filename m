Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF105A1DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbiHZBCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiHZBCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD55C888B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661475718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RgHbbh35TxI4ab5aGszNKHNWmr236njETNmEi6FKts0=;
        b=A0y60/AiUTvZaWIR9VFcJDfKPaoPBp7fhaW2dKkreQe4XI3faXvIfrdBt+MfgX+JjSafz7
        1hyRq2kwHULjnA9xR9Sb9Jz5hlbXEOwTlrEhzSPsxecrurgx0z6B7+Jlg/vNE+n6M8Zpb7
        3FErzqYresP87Pwix1xeDjjbSHiZ1+0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-bprPf40xMWWKuZh4jsMECQ-1; Thu, 25 Aug 2022 21:01:55 -0400
X-MC-Unique: bprPf40xMWWKuZh4jsMECQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4C3F80A0B9;
        Fri, 26 Aug 2022 01:01:54 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18EC02026D4C;
        Fri, 26 Aug 2022 01:01:54 +0000 (UTC)
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
Subject: [PATCH v6 2/5] sched: Use user_cpus_ptr for saving user provided cpumask in sched_setaffinity()
Date:   Thu, 25 Aug 2022 21:01:16 -0400
Message-Id: <20220826010119.1265764-3-longman@redhat.com>
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

As a call to sched_setaffinity() will no longer clear user_cpus_ptr
but set it instead, the SCA_USER flag is no longer necessary and can
be removed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c  | 87 +++++++++++++++++++-------------------------
 kernel/sched/sched.h |  8 +++-
 2 files changed, 45 insertions(+), 50 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b351e6d173b7..ac2b103d69dc 100644
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
 
@@ -3051,34 +3028,22 @@ void force_compatible_cpus_allowed_ptr(struct task_struct *p)
 }
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
+__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, bool save_mask);
 
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
-
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
+	__sched_setaffinity(p, task_user_cpus(p), false);
 }
 
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
@@ -8081,10 +8046,11 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
 #endif
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
+__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, bool save_mask)
 {
 	int retval;
 	cpumask_var_t cpus_allowed, new_mask;
+	struct cpumask *user_mask = NULL;
 
 	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
 		return -ENOMEM;
@@ -8100,8 +8066,22 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 	retval = dl_task_check_affinity(p, new_mask);
 	if (retval)
 		goto out_free_new_mask;
+
+	/*
+	 * Save the user requested mask internally now and then update
+	 * user_cpus_ptr later after making sure this call will be
+	 * successful, i.e. retval == 0.
+	 */
+	if (save_mask) {
+		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
+		if (!user_mask) {
+			retval = -ENOMEM;
+			goto out_free_new_mask;
+		}
+		cpumask_copy(user_mask, mask);
+	}
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | SCA_USER);
+	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
 	if (retval)
 		goto out_free_new_mask;
 
@@ -8115,7 +8095,16 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 		goto again;
 	}
 
+	if (save_mask) {
+		unsigned long flags;
+
+		/* Use pi_lock to synchronize changes to user_cpus_ptr */
+		raw_spin_lock_irqsave(&p->pi_lock, flags);
+		swap(p->user_cpus_ptr, user_mask);
+		raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	}
 out_free_new_mask:
+	kfree(user_mask);
 	free_cpumask_var(new_mask);
 out_free_cpus_allowed:
 	free_cpumask_var(cpus_allowed);
@@ -8158,7 +8147,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	if (retval)
 		goto out_put_task;
 
-	retval = __sched_setaffinity(p, in_mask);
+	retval = __sched_setaffinity(p, in_mask, true);
 out_put_task:
 	put_task_struct(p);
 	return retval;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e26688d387ae..a49c17e1c7ea 100644
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
@@ -2283,7 +2290,6 @@ extern struct task_struct *pick_next_task_idle(struct rq *rq);
 #define SCA_CHECK		0x01
 #define SCA_MIGRATE_DISABLE	0x02
 #define SCA_MIGRATE_ENABLE	0x04
-#define SCA_USER		0x08
 
 #ifdef CONFIG_SMP
 
-- 
2.31.1


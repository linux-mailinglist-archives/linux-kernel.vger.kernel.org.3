Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD17E5AB56D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbiIBPj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiIBPie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C7AE97C0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662132376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0wy6hLjATy79OL1SqC+LiGsQtcH52b/o/uPkZmmneno=;
        b=P8Qb/lD0AwQdMW/yZbcJY75R48u2BQubqDRoGjOa4hVXoHNilAXjctK1SG6pbJneurB9Th
        jUzlEr0sKkTtBQFXfwaBipiknlXhGNMPXwmVMd/xU7EtmL5xJrww6zEkxKvjGYCyDSsHeE
        +IQUSl0G5MDGAbfmeqlWb0LKm9ovWwA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-bFzY8bM2PeqUhwJrY892YQ-1; Fri, 02 Sep 2022 11:26:13 -0400
X-MC-Unique: bFzY8bM2PeqUhwJrY892YQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DC14823F09;
        Fri,  2 Sep 2022 15:26:12 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC552141513F;
        Fri,  2 Sep 2022 15:26:11 +0000 (UTC)
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
Subject: [PATCH v7 4/5] sched: Handle set_cpus_allowed_ptr() & sched_setaffinity() race
Date:   Fri,  2 Sep 2022 11:25:55 -0400
Message-Id: <20220902152556.373658-5-longman@redhat.com>
In-Reply-To: <20220902152556.373658-1-longman@redhat.com>
References: <20220902152556.373658-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
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
or between multiple sched_setaffinity() calls from different
CPUs. To resolve these race conditions, we need to update both
user_cpus_ptr and cpus_mask in a single lock critical section instead
of separated ones. This requires moving the user_cpus_ptr update to
set_cpus_allowed_common().

The SCA_USER flag will be used to signify that a user_cpus_ptr update
will have to be done. The new user_cpus_ptr will be put into the
a percpu variable pending_user_mask at the beginning of the lock
crtical section. The pending user mask will then be taken up in
set_cpus_allowed_common().

Ideally, user_cpus_ptr should only be updated if the sched_setaffinity()
is successful. However, this patch will update user_cpus_ptr when the
first call to __set_cpus_allowed_ptr() is successful. However, if there
is racing between sched_setaffinity() and cpuset update, the subsequent
calls to __set_cpus_allowed_ptr() may fail but the user_cpus_ptr will
still be updated in this corner case. A warning will be printed in this
corner case.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 59 ++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 84544daf3839..618341d0fa51 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -111,6 +111,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DEFINE_PER_CPU(struct cpumask **, pending_user_mask);
 
 #ifdef CONFIG_SCHED_DEBUG
 /*
@@ -2199,6 +2200,7 @@ __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32
 
 static int __set_cpus_allowed_ptr(struct task_struct *p,
 				  const struct cpumask *new_mask,
+				  struct cpumask **puser_mask,
 				  u32 flags);
 
 static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
@@ -2249,7 +2251,8 @@ void migrate_enable(void)
 	 */
 	preempt_disable();
 	if (p->cpus_ptr != &p->cpus_mask)
-		__set_cpus_allowed_ptr(p, &p->cpus_mask, SCA_MIGRATE_ENABLE);
+		__set_cpus_allowed_ptr(p, &p->cpus_mask, NULL,
+				       SCA_MIGRATE_ENABLE);
 	/*
 	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
 	 * regular cpus_mask, otherwise things that race (eg.
@@ -2538,6 +2541,12 @@ void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_ma
 
 	cpumask_copy(&p->cpus_mask, new_mask);
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
+
+	/*
+	 * Swap in the new user_cpus_ptr if SCA_USER flag set
+	 */
+	if (flags & SCA_USER)
+		swap(p->user_cpus_ptr, *__this_cpu_read(pending_user_mask));
 }
 
 static void
@@ -2926,12 +2935,19 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
  * call is not atomic; no spinlocks may be held.
  */
 static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  const struct cpumask *new_mask, u32 flags)
+				  const struct cpumask *new_mask,
+				  struct cpumask **puser_mask,
+				  u32 flags)
 {
 	struct rq_flags rf;
 	struct rq *rq;
 
 	rq = task_rq_lock(p, &rf);
+	/*
+	 * CPU won't be preempted or interrupted while holding task_rq_lock().
+	 */
+	__this_cpu_write(pending_user_mask, puser_mask);
+
 	if (p->user_cpus_ptr && !(flags & SCA_USER) &&
 	    cpumask_and(rq->scratch_mask, new_mask, p->user_cpus_ptr))
 		new_mask = rq->scratch_mask;
@@ -2941,7 +2957,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 
 int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 {
-	return __set_cpus_allowed_ptr(p, new_mask, 0);
+	return __set_cpus_allowed_ptr(p, new_mask, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
@@ -3032,7 +3048,8 @@ void force_compatible_cpus_allowed_ptr(struct task_struct *p)
 }
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, int flags);
+__sched_setaffinity(struct task_struct *p, const struct cpumask *mask,
+		    struct cpumask **puser_mask, int flags);
 
 /*
  * Restore the affinity of a task @p which was previously restricted by a
@@ -3049,7 +3066,7 @@ void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 	 * Try to restore the old affinity mask with __sched_setaffinity().
 	 * Cpuset masking will be done there too.
 	 */
-	ret = __sched_setaffinity(p, task_user_cpus(p), 0);
+	ret = __sched_setaffinity(p, task_user_cpus(p), NULL, 0);
 	WARN_ON_ONCE(ret);
 }
 
@@ -3529,6 +3546,7 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
 
 static inline int __set_cpus_allowed_ptr(struct task_struct *p,
 					 const struct cpumask *new_mask,
+					 struct cpumask *user_mask,
 					 u32 flags)
 {
 	return set_cpus_allowed_ptr(p, new_mask);
@@ -8053,7 +8071,8 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
 #endif
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, int flags)
+__sched_setaffinity(struct task_struct *p, const struct cpumask *mask,
+		    struct cpumask **puser_mask, int flags)
 {
 	int retval;
 	cpumask_var_t cpus_allowed, new_mask;
@@ -8072,8 +8091,10 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask, int flags
 	retval = dl_task_check_affinity(p, new_mask);
 	if (retval)
 		goto out_free_new_mask;
+
+	retval = __set_cpus_allowed_ptr(p, new_mask, puser_mask,
+					SCA_CHECK | flags);
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | flags);
 	if (retval)
 		goto out_free_new_mask;
 
@@ -8084,6 +8105,14 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask, int flags
 		 * Just reset the cpumask to the cpuset's cpus_allowed.
 		 */
 		cpumask_copy(new_mask, cpus_allowed);
+		retval = __set_cpus_allowed_ptr(p, new_mask, NULL, SCA_CHECK);
+
+		/*
+		 * Warn in case of the unexpected success in updating
+		 * user_cpus_ptr in first __set_cpus_allowed_ptr() but then
+		 * fails in a subsequent retry.
+		 */
+		WARN_ON_ONCE(retval && (flags | SCA_USER));
 		goto again;
 	}
 
@@ -8138,21 +8167,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	}
 	cpumask_copy(user_mask, in_mask);
 
-	retval = __sched_setaffinity(p, in_mask, SCA_USER);
-
-	/*
-	 * Save in_mask into user_cpus_ptr after a successful
-	 * __sched_setaffinity() call. pi_lock is used to synchronize
-	 * changes to user_cpus_ptr.
-	 */
-	if (!retval) {
-		unsigned long flags;
-
-		/* Use pi_lock to synchronize changes to user_cpus_ptr */
-		raw_spin_lock_irqsave(&p->pi_lock, flags);
-		swap(p->user_cpus_ptr, user_mask);
-		raw_spin_unlock_irqrestore(&p->pi_lock, flags);
-	}
+	retval = __sched_setaffinity(p, in_mask, &user_mask, SCA_USER);
 	kfree(user_mask);
 
 out_put_task:
-- 
2.31.1


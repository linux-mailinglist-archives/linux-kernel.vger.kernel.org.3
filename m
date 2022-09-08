Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600DA5B26F9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiIHTmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiIHTmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A94D1E23
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662666118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKnGg9J9iDoXVutMmsDPvKNQq77bmJ4L3Oh0dX5BhWU=;
        b=UmpJtPQzt6TP4WPkeM+hTUUZhbYG+aE0N1DyAN7XtG5WT5PAHnPJkB7QWxOv6zG76iVUB+
        y6BUbSZEgpaOa5+lbYFLqCKUChP9eLlSp5bJjrvL8JbnquBE1JKYl9fASZB2rWaCDaVP8o
        EO/fma730m9Wi9oWQL39qoMj493XLWg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-p-xDiJO0NKuxwR98MEF8ZQ-1; Thu, 08 Sep 2022 15:41:53 -0400
X-MC-Unique: p-xDiJO0NKuxwR98MEF8ZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D232385A589;
        Thu,  8 Sep 2022 19:41:52 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33677141511A;
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
Subject: [PATCH v8 3/7] sched: Enforce user requested affinity
Date:   Thu,  8 Sep 2022 15:41:17 -0400
Message-Id: <20220908194121.858462-4-longman@redhat.com>
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

It was found that the user requested affinity via sched_setaffinity()
can be easily overwritten by other kernel subsystems without an easy way
to reset it back to what the user requested. For example, any change
to the current cpuset hierarchy may reset the cpumask of the tasks in
the affected cpusets to the default cpuset value even if those tasks
have pre-existing user requested affinity. That is especially easy to
trigger under a cgroup v2 environment where writing "+cpuset" to the
root cgroup's cgroup.subtree_control file will reset the cpus affinity
of all the processes in the system.

That is problematic in a nohz_full environment where the tasks running
in the nohz_full CPUs usually have their cpus affinity explicitly set
and will behave incorrectly if cpus affinity changes.

Fix this problem by looking at user_cpus_ptr in __set_cpus_allowed_ptr()
and use it to restrcit the given cpumask unless there is no overlap. In
that case, it will fallback to the given one. The SCA_USER flag is
reused to indicate intent to set user_cpus_ptr and so user_cpus_ptr
masking should be skipped.

All callers of set_cpus_allowed_ptr() will be affected by this change.
A scratch cpumask is added to percpu runqueues structure for doing
additional masking when user_cpus_ptr is set.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c  | 17 ++++++++++++-----
 kernel/sched/sched.h |  3 +++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c7c0425974c2..84544daf3839 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2932,6 +2932,10 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	struct rq *rq;
 
 	rq = task_rq_lock(p, &rf);
+	if (p->user_cpus_ptr && !(flags & SCA_USER) &&
+	    cpumask_and(rq->scratch_mask, new_mask, p->user_cpus_ptr))
+		new_mask = rq->scratch_mask;
+
 	return __set_cpus_allowed_ptr_locked(p, new_mask, flags, rq, &rf);
 }
 
@@ -3028,7 +3032,7 @@ void force_compatible_cpus_allowed_ptr(struct task_struct *p)
 }
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
+__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, int flags);
 
 /*
  * Restore the affinity of a task @p which was previously restricted by a
@@ -3045,7 +3049,7 @@ void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 	 * Try to restore the old affinity mask with __sched_setaffinity().
 	 * Cpuset masking will be done there too.
 	 */
-	ret = __sched_setaffinity(p, task_user_cpus(p));
+	ret = __sched_setaffinity(p, task_user_cpus(p), 0);
 	WARN_ON_ONCE(ret);
 }
 
@@ -8049,7 +8053,7 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
 #endif
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
+__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, int flags)
 {
 	int retval;
 	cpumask_var_t cpus_allowed, new_mask;
@@ -8069,7 +8073,7 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 	if (retval)
 		goto out_free_new_mask;
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
+	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | flags);
 	if (retval)
 		goto out_free_new_mask;
 
@@ -8134,7 +8138,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	}
 	cpumask_copy(user_mask, in_mask);
 
-	retval = __sched_setaffinity(p, in_mask);
+	retval = __sched_setaffinity(p, in_mask, SCA_USER);
 
 	/*
 	 * Save in_mask into user_cpus_ptr after a successful
@@ -9647,6 +9651,9 @@ void __init sched_init(void)
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 		per_cpu(select_rq_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
+		per_cpu(runqueues.scratch_mask, i) =
+			(cpumask_var_t)kzalloc_node(cpumask_size(),
+						    GFP_KERNEL, cpu_to_node(i));
 	}
 #endif /* CONFIG_CPUMASK_OFFSTACK */
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ac235bc8ef08..482b702d65ea 100644
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
-- 
2.31.1


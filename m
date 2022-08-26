Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A665A1DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbiHZBCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbiHZBCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:02:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA4AC8766
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661475722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r42dpP1Zjg+f4h1R8YYj4bVj8f1p0qFoE3ztVlTnsuw=;
        b=SkYqK9IKnLmQL+BaMzvSLcMU6Nxa5rSHUhHbQYp3ZEeyDgUGcqs0nkeliTCzMSh/nwC2hG
        aPCMxFpysswaPVCUndTT436rlaY8SCeBrC6IVVpZOXhtqipnq/ew+RL21tJMsbE+IdvqmT
        WJR2G4pL7HYOQY5lVsATHzEblhprHa4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-AVmVGsZrO--HWwITdZTlLQ-1; Thu, 25 Aug 2022 21:01:56 -0400
X-MC-Unique: AVmVGsZrO--HWwITdZTlLQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88444805B72;
        Fri, 26 Aug 2022 01:01:55 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D36032026D4C;
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
Subject: [PATCH v6 3/5] sched: Enforce user requested affinity
Date:   Thu, 25 Aug 2022 21:01:17 -0400
Message-Id: <20220826010119.1265764-4-longman@redhat.com>
In-Reply-To: <20220826010119.1265764-1-longman@redhat.com>
References: <20220826010119.1265764-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
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
that case, it will fallback to the given one.

All callers of set_cpus_allowed_ptr() will be affected by this change.
A scratch cpumask is added to percpu runqueues structure for doing
additional masking when user_cpus_ptr is set. The scratch cpumask should
get allocated during cpu activation. A fallback atomic memory allocation
in __set_cpus_allowed_ptr() is also added in case set_cpus_allowed_ptr()
is called before the scratch cpumask is properly allocated.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c  | 36 +++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |  3 +++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ac2b103d69dc..1c2f548e5369 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2928,11 +2928,40 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 static int __set_cpus_allowed_ptr(struct task_struct *p,
 				  const struct cpumask *new_mask, u32 flags)
 {
+	struct cpumask *alloc_mask = NULL;
 	struct rq_flags rf;
 	struct rq *rq;
+	int ret;
 
 	rq = task_rq_lock(p, &rf);
-	return __set_cpus_allowed_ptr_locked(p, new_mask, flags, rq, &rf);
+	if (p->user_cpus_ptr) {
+
+		/*
+		 * A scratch cpumask is allocated on the percpu runqueues
+		 * to enable additional masking with user_cpus_ptr. This
+		 * cpumask, once allocated, will not be freed.
+		 */
+		if (unlikely(!rq->scratch_mask)) {
+			alloc_mask = kmalloc(cpumask_size(), GFP_ATOMIC);
+			if (!rq->scratch_mask && alloc_mask) {
+				rq->scratch_mask = alloc_mask;
+				alloc_mask = NULL;
+			}
+		}
+		/*
+		 * Ignore user_cpus_ptr if atomic memory allocation fails
+		 * or it doesn't intersect new_mask.
+		 */
+		if (rq->scratch_mask &&
+		    cpumask_and(rq->scratch_mask, new_mask, p->user_cpus_ptr))
+			new_mask = rq->scratch_mask;
+	}
+
+
+	ret = __set_cpus_allowed_ptr_locked(p, new_mask, flags, rq, &rf);
+	if (unlikely(alloc_mask))
+		kfree(alloc_mask);
+	return ret;
 }
 
 int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
@@ -9352,6 +9381,11 @@ int sched_cpu_activate(unsigned int cpu)
 		sched_update_numa(cpu, true);
 		sched_domains_numa_masks_set(cpu);
 		cpuset_cpu_active();
+		/*
+		 * Preallocated scratch cpumask
+		 */
+		if (!rq->scratch_mask)
+			rq->scratch_mask = kmalloc(cpumask_size(), GFP_KERNEL);
 	}
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a49c17e1c7ea..66a6bfddd716 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1159,6 +1159,9 @@ struct rq {
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
 #endif
+
+	/* Scratch cpumask to be temporarily used under rq_lock */
+	struct cpumask		*scratch_mask;
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.31.1


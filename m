Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1325B26FE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiIHTmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiIHTmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B994D51D4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662666119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ygU5n+vDab/JrahhgIYA9NLv/bE0KEdNWKARdUa/DEs=;
        b=BgimrHCsiMZw+VHpdeY1feMqqhPwLZ2e6m717qMNsLjzPh0gOi2tajLFNvviCDLWHo3R0O
        UTxoftsJ/i9Nf1l5ClWlWftU/BVtrwQA3I1V2vmKDqYLuWW7/2HugwhabsiRygL2WJ+JaV
        bWmxi9FGgxHJbrd+BXWiDLSWscu/gdA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-n77__nT_NPm4okGGTNKDEg-1; Thu, 08 Sep 2022 15:41:55 -0400
X-MC-Unique: n77__nT_NPm4okGGTNKDEg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EAE2101A56C;
        Thu,  8 Sep 2022 19:41:54 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FE7D1415117;
        Thu,  8 Sep 2022 19:41:53 +0000 (UTC)
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
Subject: [PATCH v8 5/7] sched: Handle set_cpus_allowed_ptr() & sched_setaffinity() race
Date:   Thu,  8 Sep 2022 15:41:19 -0400
Message-Id: <20220908194121.858462-6-longman@redhat.com>
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

Racing is possible between set_cpus_allowed_ptr() and sched_setaffinity()
or between multiple sched_setaffinity() calls from different
CPUs. To resolve these race conditions, we need to update both
user_cpus_ptr and cpus_mask in a single lock critical section instead
of separated ones. This requires moving the user_cpus_ptr update
to set_cpus_allowed_common() by putting the user_mask into the
affinity_context structure.

This patch also changes the handling of the race between the
sched_setaffinity() call and the changing of cpumask of the current
cpuset. In case the new mask conflicts with newly updated cpuset,
the cpus_mask will be reset to the cpuset cpumask and an error value
of -EINVAL will be returned. If a previous user_cpus_ptr value exists,
it will be swapped back in and the new_mask will be further restricted
to what is allowed in the cpumask pointed to by the old user_cpus_ptr.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c  | 44 +++++++++++++++++++++++++++-----------------
 kernel/sched/sched.h |  1 +
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b43b851c0399..1ba5d82d4f3c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2546,6 +2546,12 @@ void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx
 
 	cpumask_copy(&p->cpus_mask, ctx->new_mask);
 	p->nr_cpus_allowed = cpumask_weight(ctx->new_mask);
+
+	/*
+	 * Swap in a new user_cpus_ptr if SCA_USER flag set
+	 */
+	if (ctx->flags & SCA_USER)
+		swap(p->user_cpus_ptr, ctx->user_mask);
 }
 
 static void
@@ -8100,7 +8106,7 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 	retval = dl_task_check_affinity(p, new_mask);
 	if (retval)
 		goto out_free_new_mask;
-again:
+
 	retval = __set_cpus_allowed_ptr(p, ctx);
 	if (retval)
 		goto out_free_new_mask;
@@ -8112,7 +8118,24 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 		 * Just reset the cpumask to the cpuset's cpus_allowed.
 		 */
 		cpumask_copy(new_mask, cpus_allowed);
-		goto again;
+
+		/*
+		 * If SCA_USER is set, a 2nd call to __set_cpus_allowed_ptr()
+		 * will restore the previous user_cpus_ptr value.
+		 *
+		 * In the unlikely event a previous user_cpus_ptr exists,
+		 * we need to further restrict the mask to what is allowed
+		 * by that old user_cpus_ptr.
+		 */
+		if (unlikely((ctx->flags & SCA_USER) && ctx->user_mask)) {
+			bool empty = !cpumask_and(new_mask, new_mask,
+						  ctx->user_mask);
+
+			if (WARN_ON_ONCE(empty))
+				cpumask_copy(new_mask, cpus_allowed);
+		}
+		__set_cpus_allowed_ptr(p, ctx);
+		retval = -EINVAL;
 	}
 
 out_free_new_mask:
@@ -8168,25 +8191,12 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	cpumask_copy(user_mask, in_mask);
 	ac = (struct affinity_context){
 		.new_mask  = in_mask,
+		.user_mask = user_mask,
 		.flags     = SCA_USER,
 	};
 
 	retval = __sched_setaffinity(p, &ac);
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
-	kfree(user_mask);
+	kfree(ac.user_mask);
 
 out_put_task:
 	put_task_struct(p);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1927c02f68fa..110e13b7d78b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2159,6 +2159,7 @@ extern const u32		sched_prio_to_wmult[40];
 
 struct affinity_context {
 	const struct cpumask *new_mask;
+	struct cpumask *user_mask;
 	unsigned int flags;
 };
 
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD8B534AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346369AbiEZHOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346341AbiEZHO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:14:27 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB68A3969C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:14:25 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cs3-20020a17090af50300b001e0808b5838so1022587pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fnvSBK00HYkhNihK4hUnHuTK0u4mSGiraqCdnpeu1iI=;
        b=LEs7yybWWw4H+KEp7l+qyYBrZDtmgqpUaifQnnQsILUShrLGXoOIG+ies4ZUpBNr0X
         OUSpyhHCWMW2wL1Bs6SlZc5oxJlCKc1Ub/q6cVP6m2kz/01Tz1n9ZBi0ipXXSgtcZ3C6
         fNKl1PJyGc9TaSarr48WiKXbI7fGMY0HHXBbEJkbwaI9QGeeac7xw9lIS5oBy04aJYfL
         ox8dk6Vm0JQNkKvtIH2pzPcLwUJvP0E4KoLMxwLsi2R/IFxL704JcC6Meu8FfH3Nxa+b
         3/pkAqF5m2fh/xnIrAG+rnPjKj9si5Jd3CDGnyOMoM7/xX01+ObEVpi3TXvOd9sqAjJL
         GKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fnvSBK00HYkhNihK4hUnHuTK0u4mSGiraqCdnpeu1iI=;
        b=nI/UcxZA7eeevmO2g5e10yibjfLH6/746moS7tRC/MzJ3ypi4cF5gOZVYUCGv35fGV
         2fl5Cy7uagvz74PExEv1Duw0OXj2R7+94yyciG9mMJEwAl4bf1vDrRe+BUH7n0KawlLJ
         W5zkBQ0DgApUmM754vz9nydwga32Vrn4EMGiELRefnV0AL726nBF7wjy0SeYFw0pCek2
         P2uepv2OxZudYRqT5i2z4OYX82E+pCSIEoQ9IrOcqfRqy3sXTCs3R4Svs8gF2P08jL5r
         v/8CoY/61ze3W1wGBTkrFE7YmODOxBkxRj+7mazoGuWGHYXjY1VcO1s1hlslbL6JUrQy
         UbmQ==
X-Gm-Message-State: AOAM530V2kunlMLX0DgHQgWyAXYhQAoUieCcdZ+m0X/VgwoOOyOCkFr0
        vxM7HzwiVJslJkb/GEe3xZacoA==
X-Google-Smtp-Source: ABdhPJyjokAorAGLaFhyF0hLz72hfUPeBbqTarn063k4Q5VxmiWa08W3+mMgeGocLQh0nOlaeWI6Iw==
X-Received: by 2002:a17:90b:23c4:b0:1e0:9e72:e226 with SMTP id md4-20020a17090b23c400b001e09e72e226mr1182976pjb.136.1653549264915;
        Thu, 26 May 2022 00:14:24 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id e24-20020aa78c58000000b005184031963bsm640629pfd.85.2022.05.26.00.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 00:14:24 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, odin@uged.al
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 2/2] sched/fair: optimize and simplify rq leaf_cfs_rq_list
Date:   Thu, 26 May 2022 15:13:54 +0800
Message-Id: <20220526071354.6426-3-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220526071354.6426-1-zhouchengming@bytedance.com>
References: <20220526071354.6426-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We notice the rq leaf_cfs_rq_list has two problems when do bugfix
backports and some test profiling.

1. cfs_rqs under throttled subtree could be added to the list, and
   make their fully decayed ancestors on the list, even though not needed.

2. #1 also make the leaf_cfs_rq_list management complex and error prone,
   this is the list of related bugfix so far:

   commit 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
   commit fe61468b2cbc ("sched/fair: Fix enqueue_task_fair warning")
   commit b34cb07dde7c ("sched/fair: Fix enqueue_task_fair() warning some more")
   commit 39f23ce07b93 ("sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list")
   commit 0258bdfaff5b ("sched/fair: Fix unfairness caused by missing load decay")
   commit a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle")
   commit fdaba61ef8a2 ("sched/fair: Ensure that the CFS parent is added after unthrottling")
   commit 2630cde26711 ("sched/fair: Add ancestors of unthrottled undecayed cfs_rq")

commit 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
delete every cfs_rq under throttled subtree from rq->leaf_cfs_rq_list,
and delete the throttled_hierarchy() test in update_blocked_averages(),
which optimized update_blocked_averages().

But those later bugfix add cfs_rqs under throttled subtree back to
rq->leaf_cfs_rq_list again, with their fully decayed ancestors, for
the integrity of rq->leaf_cfs_rq_list.

This patch takes another method, skip all cfs_rqs under throttled
hierarchy when list_add_leaf_cfs_rq(), to completely make cfs_rqs
under throttled subtree off the leaf_cfs_rq_list.

So we don't need to consider throttled related things in
enqueue_entity(), unthrottle_cfs_rq() and enqueue_task_fair(),
which simplify the code a lot. Also optimize update_blocked_averages()
since cfs_rqs under throttled hierarchy and their ancestors
won't be on the leaf_cfs_rq_list.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v2:
 - move throttled_hierarchy() outside list_add_leaf_cfs_rq(),
   suggested by Vincent.
---
 kernel/sched/fair.c | 77 ++++++++++++---------------------------------
 1 file changed, 20 insertions(+), 57 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5276d05692e0..7438c1865109 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4374,16 +4374,11 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		__enqueue_entity(cfs_rq, se);
 	se->on_rq = 1;
 
-	/*
-	 * When bandwidth control is enabled, cfs might have been removed
-	 * because of a parent been throttled but cfs->nr_running > 1. Try to
-	 * add it unconditionally.
-	 */
-	if (cfs_rq->nr_running == 1 || cfs_bandwidth_used())
-		list_add_leaf_cfs_rq(cfs_rq);
-
-	if (cfs_rq->nr_running == 1)
+	if (cfs_rq->nr_running == 1) {
 		check_enqueue_throttle(cfs_rq);
+		if (!throttled_hierarchy(cfs_rq))
+			list_add_leaf_cfs_rq(cfs_rq);
+	}
 }
 
 static void __clear_buddies_last(struct sched_entity *se)
@@ -4998,11 +4993,18 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	/* update hierarchical throttle state */
 	walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);
 
-	/* Nothing to run but something to decay (on_list)? Complete the branch */
 	if (!cfs_rq->load.weight) {
-		if (cfs_rq->on_list)
-			goto unthrottle_throttle;
-		return;
+		if (!cfs_rq->on_list)
+			return;
+		/*
+		 * Nothing to run but something to decay (on_list)?
+		 * Complete the branch.
+		 */
+		for_each_sched_entity(se) {
+			if (list_add_leaf_cfs_rq(cfs_rq_of(se)))
+				break;
+		}
+		goto unthrottle_throttle;
 	}
 
 	task_delta = cfs_rq->h_nr_running;
@@ -5040,31 +5042,12 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
 			goto unthrottle_throttle;
-
-		/*
-		 * One parent has been throttled and cfs_rq removed from the
-		 * list. Add it back to not break the leaf list.
-		 */
-		if (throttled_hierarchy(qcfs_rq))
-			list_add_leaf_cfs_rq(qcfs_rq);
 	}
 
 	/* At this point se is NULL and we are at root level*/
 	add_nr_running(rq, task_delta);
 
 unthrottle_throttle:
-	/*
-	 * The cfs_rq_throttled() breaks in the above iteration can result in
-	 * incomplete leaf list maintenance, resulting in triggering the
-	 * assertion below.
-	 */
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-
-		if (list_add_leaf_cfs_rq(qcfs_rq))
-			break;
-	}
-
 	assert_list_leaf_cfs_rq(rq);
 
 	/* Determine whether we need to wake up potentially idle CPU: */
@@ -5719,13 +5702,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			goto enqueue_throttle;
-
-               /*
-                * One parent has been throttled and cfs_rq removed from the
-                * list. Add it back to not break the leaf list.
-                */
-               if (throttled_hierarchy(cfs_rq))
-                       list_add_leaf_cfs_rq(cfs_rq);
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -5749,21 +5725,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_overutilized_status(rq);
 
 enqueue_throttle:
-	if (cfs_bandwidth_used()) {
-		/*
-		 * When bandwidth control is enabled; the cfs_rq_throttled()
-		 * breaks in the above iteration can result in incomplete
-		 * leaf list maintenance, resulting in triggering the assertion
-		 * below.
-		 */
-		for_each_sched_entity(se) {
-			cfs_rq = cfs_rq_of(se);
-
-			if (list_add_leaf_cfs_rq(cfs_rq))
-				break;
-		}
-	}
-
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
@@ -11293,9 +11254,10 @@ static inline bool vruntime_normalized(struct task_struct *p)
  */
 static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
-	struct cfs_rq *cfs_rq;
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-	list_add_leaf_cfs_rq(cfs_rq_of(se));
+	if (!throttled_hierarchy(cfs_rq))
+		list_add_leaf_cfs_rq(cfs_rq);
 
 	/* Start to propagate at parent */
 	se = se->parent;
@@ -11304,7 +11266,8 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 		cfs_rq = cfs_rq_of(se);
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
-		list_add_leaf_cfs_rq(cfs_rq);
+		if (!throttled_hierarchy(cfs_rq))
+			list_add_leaf_cfs_rq(cfs_rq);
 	}
 }
 #else
-- 
2.36.1


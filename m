Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E88534D82
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiEZKkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347044AbiEZKkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:40:03 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D56CC17C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:40:02 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id f21so1382626pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrF2vcR0/pW4wvFrzoxssnv5OJSuZjV2lnZF1HbBxGE=;
        b=T4sjHlQ039UKiokC45ZvXjV+o5SwlzUKvmCsUyso6IjbdRJbzPUw3MIFd3ZYb3efFW
         JKAmaB0YtnRsvmP+eN/NpPEBtrFhfwWX5ar4zvSyR+werw47xydHsiu5o2/HbEdZIKGx
         hu1oNQcupimY/0DLqYhTo1hrzD1zlqi3hV8kUiLErv1NuPXvAvRinJvT6iyjJQF8EPQl
         tCYE3n+drJlU6HlqFCzZUNusXOZNe9hH7O71wYLFGAg0bLMbp8iwQXTVEZEQYbWgaOXx
         CkN/yO7toObMkNCsxbk2ebu0znNG9aZqFZSUMuCuNSD9PeQ+9FmmPnolfNiD4jCT1w+M
         oHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrF2vcR0/pW4wvFrzoxssnv5OJSuZjV2lnZF1HbBxGE=;
        b=RMst+zSdideOZi9Mf1DLRZGwAGX4DlVZQgkzxQsDl+LGKk1ktbn7SZj3wkVkrj2baG
         BYcSrRupsgKBvyUfmSezkq4zz6zSWe+pfg+vrtDj982fDsG8CWy6aPTwsJh8QmxJq5Dg
         J7FUPIRrlRJCHmPiz8AHwaBnQ4IhSlHl8wy0I5qUa5EifmpRn5HBSSt+CNNIY3cBEZex
         Ux+tbcwEDsx3HHVMzgIxJx7CuqhwQz1BSTGdi4l8D74fFitXd1Sz6vt2xu/mYsccaRxA
         xQ1MdPn0rcMJjpcShk0Uid3VeFCsFktMWwLNy+4cpgm+pupCa2SO8ivPWYC1T6vZ+hIQ
         4OKA==
X-Gm-Message-State: AOAM5327ZAJvAhZ8w5re1DASMrLEnTqNtQiCa7GdssSh4eRAwx64BaF1
        Q1/3kWbRido/6I4wLHOmf1BsNg==
X-Google-Smtp-Source: ABdhPJz4wHFBx2vm4NrKDY9rqMBv7XryWll7+4lR9FYuLFAqIXaogBH5CTBvml+9g1qZBJFo9/fYiA==
X-Received: by 2002:a63:2365:0:b0:3db:8691:4fb9 with SMTP id u37-20020a632365000000b003db86914fb9mr32010393pgm.261.1653561601519;
        Thu, 26 May 2022 03:40:01 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b0015e8d4eb23dsm1257311ple.135.2022.05.26.03.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:40:01 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, odin@uged.al
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 2/2] sched/fair: optimize and simplify rq leaf_cfs_rq_list
Date:   Thu, 26 May 2022 18:39:29 +0800
Message-Id: <20220526103929.14976-3-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220526103929.14976-1-zhouchengming@bytedance.com>
References: <20220526103929.14976-1-zhouchengming@bytedance.com>
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
v3:
 - fix !CONFIG_FAIR_GROUP_SCHED build error, reported by
   kernel test robot <lkp@intel.com>

v2:
 - move throttled_hierarchy() outside list_add_leaf_cfs_rq(),
   suggested by Vincent.
---
 kernel/sched/fair.c | 81 ++++++++++++---------------------------------
 1 file changed, 22 insertions(+), 59 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c6da204f3068..48ff4330d68a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3114,6 +3114,8 @@ void reweight_task(struct task_struct *p, int prio)
 	load->inv_weight = sched_prio_to_wmult[prio];
 }
 
+static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 #ifdef CONFIG_SMP
 /*
@@ -3224,8 +3226,6 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
 }
 #endif /* CONFIG_SMP */
 
-static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
-
 /*
  * Recomputes the group entity based on the current state of its group
  * runqueue.
@@ -4338,16 +4338,11 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
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
@@ -4962,11 +4957,18 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -5004,31 +5006,12 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -5683,13 +5666,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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
@@ -5713,21 +5689,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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
@@ -11257,9 +11218,10 @@ static inline bool vruntime_normalized(struct task_struct *p)
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
@@ -11268,7 +11230,8 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5985548246
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbiFMIn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbiFMIna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:43:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C037C45;
        Mon, 13 Jun 2022 01:43:29 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:43:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655109807;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qFlh+JT/LpmJEhx/tzjDtxD+DypTrvqsrTrcWWS3VAI=;
        b=RpcyLvcra0pCNTBl6bZZKpIEQVrqghn4CTuV20HfKedZQ+ziGOZo8CgAMsm7oBkc8ftQvP
        Wxgh9xxpc9xhUclNmnf6kWzaDixi/xHQHNhkhzkkLwfCydRJeT9vXL54qkmB/x5FTuPx8Q
        Q248T4GF0tL3l1BwCiGZCSz1qCVMwAVVD1Phx4Sm5P3FHZB2HzeSglSaeBM8O9G7BbLuE6
        nCU6oEjpAeIBScFsfqfDi5BhhZoJB33MxnXvYOp+t1iVFZ96s9XU6pOhbWXEkQO2Vd6GRn
        6e2PlELJ/XeTv3a2HfuOYFo0r+9ksXq1yO2mlhRoB4o4uvhHb6ywDVS9Z8oQJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655109807;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qFlh+JT/LpmJEhx/tzjDtxD+DypTrvqsrTrcWWS3VAI=;
        b=C4zlxNRo180WJSTSSwjrZkhqSdqU+gdY8EMj9R+3bFQTYXicTUg7zz1qJI1sHPfQMEGmBj
        DSWwbWfqZtC/I9Bw==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Optimize and simplify rq leaf_cfs_rq_list
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220601021848.76943-1-zhouchengming@bytedance.com>
References: <20220601021848.76943-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <165510980662.4207.12736171517952290563.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     51bf903b64bdde4e4c9009a9e2b4a589845d9d81
Gitweb:        https://git.kernel.org/tip/51bf903b64bdde4e4c9009a9e2b4a589845d9d81
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Wed, 01 Jun 2022 10:18:48 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:30:00 +02:00

sched/fair: Optimize and simplify rq leaf_cfs_rq_list

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20220601021848.76943-1-zhouchengming@bytedance.com
---
 kernel/sched/fair.c | 92 +++++++++++++-------------------------------
 1 file changed, 28 insertions(+), 64 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1b2cac7..7d8ef01 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3179,6 +3179,8 @@ void reweight_task(struct task_struct *p, int prio)
 	load->inv_weight = sched_prio_to_wmult[prio];
 }
 
+static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 #ifdef CONFIG_SMP
 /*
@@ -3289,8 +3291,6 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
 }
 #endif /* CONFIG_SMP */
 
-static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
-
 /*
  * Recomputes the group entity based on the current state of its group
  * runqueue.
@@ -4403,16 +4403,11 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
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
@@ -5027,11 +5022,18 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -5069,31 +5071,12 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -5748,13 +5731,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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
@@ -5778,21 +5754,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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
@@ -11316,9 +11277,13 @@ static inline bool vruntime_normalized(struct task_struct *p)
  */
 static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
-	struct cfs_rq *cfs_rq;
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+	if (cfs_rq_throttled(cfs_rq))
+		return;
 
-	list_add_leaf_cfs_rq(cfs_rq_of(se));
+	if (!throttled_hierarchy(cfs_rq))
+		list_add_leaf_cfs_rq(cfs_rq);
 
 	/* Start to propagate at parent */
 	se = se->parent;
@@ -11326,14 +11291,13 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 
-		if (!cfs_rq_throttled(cfs_rq)){
-			update_load_avg(cfs_rq, se, UPDATE_TG);
-			list_add_leaf_cfs_rq(cfs_rq);
-			continue;
-		}
+		update_load_avg(cfs_rq, se, UPDATE_TG);
 
-		if (list_add_leaf_cfs_rq(cfs_rq))
+		if (cfs_rq_throttled(cfs_rq))
 			break;
+
+		if (!throttled_hierarchy(cfs_rq))
+			list_add_leaf_cfs_rq(cfs_rq);
 	}
 }
 #else

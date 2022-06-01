Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890D3539B29
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 04:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349097AbiFACTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 22:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiFACTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 22:19:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B643866F88
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 19:19:03 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d22so431618plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 19:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jrSgvQyWeWdspWWG5kiYDhk1wMiZW92w4und9ira2PQ=;
        b=c9Y3Vw3cUEiGeX57Gj16eI1xRXLF5q9aZUIMPBbMUWEVDDaPLeBcYVhGAa7Eop5Yj+
         yJqvWefb14fWT4STfn/eoo7HfCtXEBoxNfM8QdfvnEqAxdc4xFQgh3cYF1HG99E7rGUJ
         y9a7BD10MikzVUmJmdeaUnGNGDyW7MeoZnl4q+ax37NMv+3c+/PcAInf05+9QYypp6ur
         To7OUiEKyurXQi4hoMr/ZE3iy2LSdk19YucxHkBY/hNQL6EK8Ql2AjUAkVEpRKtkgR7O
         Xd6wH9OP5yksT+Rpa09d6KgKFtFgbw1PmxOd/iSoM7Z6v2z2QpuH7N0+ip5VEfCtWxGk
         Oqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jrSgvQyWeWdspWWG5kiYDhk1wMiZW92w4und9ira2PQ=;
        b=C6iX72+PmILwS4J3egfV2GPkmFJqQWLeDlUU8P4971W2d+MB1jY7S6uZHeq0ILxXhO
         Aa1qExQF7Jsfg94ZHyJW3Cpm+qz2rtbWJZqI7u8qmOQgTyFjKLV9yyUMWjrE8D8xdWOg
         QGZ/RIyHWJrvIGImlCJxffzmtt7LZIejF+sSGioqFGsz/5HhvQcSsP/rbEuPfu81evBS
         /gWrqxwQ2v7/Gg79g//Kqc2sb3Q9Slw4tAo+c95HadIATyDhASV33t195M/vzqtnH8f4
         j5OjiklcL51+D4s8Vjd407bfbeChxrbavg0/5IFRDlmluZiKFQlY5wVh/Pkeyw7r0WDO
         PY/A==
X-Gm-Message-State: AOAM532vpHGeY8jEmDlnb8g6lW/OXsnNp3XAUlI54JE1cTvzHbC7bEOL
        XSrnmsNsxQgpViE5+pJFtYk6CQ==
X-Google-Smtp-Source: ABdhPJyqXEmVU4IMnY1jfM1LMVL3J3vp8vuOeKHhRnNDr6bGOgoOMoPgq7lTX58hSF7Fb8Ker307AQ==
X-Received: by 2002:a17:90b:46c6:b0:1e3:524c:7f94 with SMTP id jx6-20020a17090b46c600b001e3524c7f94mr3267751pjb.177.1654049943208;
        Tue, 31 May 2022 19:19:03 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id f70-20020a623849000000b0050dc762817esm134462pfa.88.2022.05.31.19.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 19:19:02 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4] sched/fair: optimize and simplify rq leaf_cfs_rq_list
Date:   Wed,  1 Jun 2022 10:18:48 +0800
Message-Id: <20220601021848.76943-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
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
v4:
 - make sure the attach/detach is propagated down up to
   the throttled cfs_rq. Thanks Vincent.

v3:
 - fix !CONFIG_FAIR_GROUP_SCHED build error, reported by
   kernel test robot <lkp@intel.com>

v2:
 - move throttled_hierarchy() outside list_add_leaf_cfs_rq(),
   suggested by Vincent.
---
 kernel/sched/fair.c | 92 ++++++++++++++-------------------------------
 1 file changed, 28 insertions(+), 64 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048a9326..b3371fa40548 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3144,6 +3144,8 @@ void reweight_task(struct task_struct *p, int prio)
 	load->inv_weight = sched_prio_to_wmult[prio];
 }
 
+static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 #ifdef CONFIG_SMP
 /*
@@ -3254,8 +3256,6 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
 }
 #endif /* CONFIG_SMP */
 
-static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
-
 /*
  * Recomputes the group entity based on the current state of its group
  * runqueue.
@@ -4368,16 +4368,11 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
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
@@ -4992,11 +4987,18 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -5034,31 +5036,12 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -5713,13 +5696,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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
@@ -5743,21 +5719,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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
@@ -11287,9 +11248,13 @@ static inline bool vruntime_normalized(struct task_struct *p)
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
@@ -11297,14 +11262,13 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
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
-- 
2.36.1


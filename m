Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70684CADA7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244651AbiCBSft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244650AbiCBSfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:35:45 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B656D8371
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:35:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBF4A150C;
        Wed,  2 Mar 2022 10:35:00 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E17B3F73D;
        Wed,  2 Mar 2022 10:34:58 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] sched/deadline: Use __node_2_[pdl|dle]() and rb_first_cached() consistently
Date:   Wed,  2 Mar 2022 19:34:31 +0100
Message-Id: <20220302183433.333029-5-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302183433.333029-1-dietmar.eggemann@arm.com>
References: <20220302183433.333029-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deploy __node_2_pdl(node), __node_2_dle(node) and rb_first_cached()
consistently throughout the sched class source file which makes the
code at least easier to read.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/deadline.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index de677b1e3767..3242dd4972e1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -450,7 +450,7 @@ static inline int is_leftmost(struct task_struct *p, struct dl_rq *dl_rq)
 {
 	struct sched_dl_entity *dl_se = &p->dl;
 
-	return dl_rq->root.rb_leftmost == &dl_se->rb_node;
+	return rb_first_cached(&dl_rq->root) == &dl_se->rb_node;
 }
 
 static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq);
@@ -1433,6 +1433,9 @@ void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
 	timer->function = inactive_task_timer;
 }
 
+#define __node_2_dle(node) \
+	rb_entry((node), struct sched_dl_entity, rb_node)
+
 #ifdef CONFIG_SMP
 
 static void inc_dl_deadline(struct dl_rq *dl_rq, u64 deadline)
@@ -1462,10 +1465,9 @@ static void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline)
 		cpudl_clear(&rq->rd->cpudl, rq->cpu);
 		cpupri_set(&rq->rd->cpupri, rq->cpu, rq->rt.highest_prio.curr);
 	} else {
-		struct rb_node *leftmost = dl_rq->root.rb_leftmost;
-		struct sched_dl_entity *entry;
+		struct rb_node *leftmost = rb_first_cached(&dl_rq->root);
+		struct sched_dl_entity *entry = __node_2_dle(leftmost);
 
-		entry = rb_entry(leftmost, struct sched_dl_entity, rb_node);
 		dl_rq->earliest_dl.curr = entry->deadline;
 		cpudl_set(&rq->rd->cpudl, rq->cpu, entry->deadline);
 	}
@@ -1506,9 +1508,6 @@ void dec_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 	dec_dl_migration(dl_se, dl_rq);
 }
 
-#define __node_2_dle(node) \
-	rb_entry((node), struct sched_dl_entity, rb_node)
-
 static inline bool __dl_less(struct rb_node *a, const struct rb_node *b)
 {
 	return dl_time_before(__node_2_dle(a)->deadline, __node_2_dle(b)->deadline);
@@ -1979,7 +1978,7 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
 	if (!left)
 		return NULL;
 
-	return rb_entry(left, struct sched_dl_entity, rb_node);
+	return __node_2_dle(left);
 }
 
 static struct task_struct *pick_task_dl(struct rq *rq)
@@ -2074,15 +2073,17 @@ static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
  */
 static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu)
 {
-	struct rb_node *next_node = rq->dl.pushable_dl_tasks_root.rb_leftmost;
 	struct task_struct *p = NULL;
+	struct rb_node *next_node;
 
 	if (!has_pushable_dl_tasks(rq))
 		return NULL;
 
+	next_node = rb_first_cached(&rq->dl.pushable_dl_tasks_root);
+
 next_node:
 	if (next_node) {
-		p = rb_entry(next_node, struct task_struct, pushable_dl_tasks);
+		p = __node_2_pdl(next_node);
 
 		if (pick_dl_task(rq, p, cpu))
 			return p;
@@ -2248,8 +2249,7 @@ static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
 	if (!has_pushable_dl_tasks(rq))
 		return NULL;
 
-	p = rb_entry(rq->dl.pushable_dl_tasks_root.rb_leftmost,
-		     struct task_struct, pushable_dl_tasks);
+	p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
 
 	BUG_ON(rq->cpu != task_cpu(p));
 	BUG_ON(task_current(rq, p));
-- 
2.25.1


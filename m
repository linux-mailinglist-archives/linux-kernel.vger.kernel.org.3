Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023454D2439
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350745AbiCHW0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350703AbiCHW0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:26:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD10583A3;
        Tue,  8 Mar 2022 14:25:23 -0800 (PST)
Date:   Tue, 08 Mar 2022 22:25:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646778322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tmaAVpUKFoaogGswpTmI+SGhFdy9qXNigjJ1cXMTVFg=;
        b=h9IGhLXGCU+ZuhoqNf0djOkZtpXdZ5zGPJzq9rwqd40EvaC9TBXPdIhJ4m1W44DWtaOLx0
        ELcfu4dIXAYLdGQ6BY3jYY+s4jKGT6iFNSF5J3ChwYmJ72gZyOPPe8QtmWfch8fFYczgfS
        pb4ibwCLr7AW1d1I1rGLRCu1YewO/wq4JNztZKppzfQ4gn7mjt2LPmJLOlEy/Q9ruqVye2
        YJjxqDbPtB33NQnHbzfS7+TNTpvgNW26CHgP+n3P1mFyp4oswNmdoCQ7/M0o9TFw3+X/Du
        MuDLlsqd9MSaaKhqJaPr0nmEtdhi9/ic/6a1EBZdik9W6GVaOVhQimdQteI0jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646778322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tmaAVpUKFoaogGswpTmI+SGhFdy9qXNigjJ1cXMTVFg=;
        b=S6Ol4C/Xibwk03uiMMuNliHHBjkzTSGJq/amHdeG6Vki7rzkxQ/3oCFgbrVz/O2g7RGIlc
        84cDMvkLDV5KlUAA==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Use __node_2_[pdl|dle]() and
 rb_first_cached() consistently
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220302183433.333029-5-dietmar.eggemann@arm.com>
References: <20220302183433.333029-5-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <164677832141.16921.14631511204895969950.tip-bot2@tip-bot2>
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

Commit-ID:     f4478e7c855d2d6b2fde5126ebcca2cb5b34ee36
Gitweb:        https://git.kernel.org/tip/f4478e7c855d2d6b2fde5126ebcca2cb5b34ee36
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Wed, 02 Mar 2022 19:34:31 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 16:08:39 +01:00

sched/deadline: Use __node_2_[pdl|dle]() and rb_first_cached() consistently

Deploy __node_2_pdl(node), __node_2_dle(node) and rb_first_cached()
consistently throughout the sched class source file which makes the
code at least easier to read.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20220302183433.333029-5-dietmar.eggemann@arm.com
---
 kernel/sched/deadline.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index de677b1..3242dd4 100644
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

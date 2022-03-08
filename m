Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD144D243A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350563AbiCHW00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350531AbiCHW0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:26:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723EE583B8;
        Tue,  8 Mar 2022 14:25:22 -0800 (PST)
Date:   Tue, 08 Mar 2022 22:25:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646778320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8o6qWaHT4VJ2d6dz73yaZrtgbAfVD5Or2FQmpSvrUgw=;
        b=g1PrrID62ZydX9J5VRxBH4n90rxVVp1Buku2t0qysn4WmbIctvn3Md4gOW0rB49b0QcSNW
        2AoQ5JsTQgBAnRJ7gdKTkb7rzfqx52tOEtrujBcN49cl/WqWMdNSaQP2Gp/V10ndIPoW/g
        5qH12cxdw3WEUt8w0Xr++eS+b03gIyYaT68IBSp3EKgbjWmjasMRyPRKTajV3/f9wKcw5Y
        kFPdmvnhKNQxPSvdzhvEM4ANw8xMtp4mgZtX09+4F6RUWS7uop6AzZBtiWM2Ww4YxDSfgE
        hh1AFDfIQKpZR3czEtgQaXkQsbPJbBRdgvZOGluOyRhip9B1pgItNLdNvaaTHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646778320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8o6qWaHT4VJ2d6dz73yaZrtgbAfVD5Or2FQmpSvrUgw=;
        b=mD0kvC6kifDvdDhdmu04GzvYn1r4mVfqsIYHqX4P0uZ0MzmDBynXEsMQrelbwuRZrZAkjy
        erU2IA6FVa8m3/CA==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline,rt: Remove unused parameter from
 pick_next_[rt|dl]_entity()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220302183433.333029-7-dietmar.eggemann@arm.com>
References: <20220302183433.333029-7-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <164677831974.16921.1428536187816309062.tip-bot2@tip-bot2>
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

Commit-ID:     821aecd09e5ad2f8d4c3d8195333d272b392f7d3
Gitweb:        https://git.kernel.org/tip/821aecd09e5ad2f8d4c3d8195333d272b392f7d3
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Wed, 02 Mar 2022 19:34:33 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 16:08:40 +01:00

sched/deadline,rt: Remove unused parameter from pick_next_[rt|dl]_entity()

The `struct rq *rq` parameter isn't used. Remove it.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20220302183433.333029-7-dietmar.eggemann@arm.com
---
 kernel/sched/deadline.c | 5 ++---
 kernel/sched/rt.c       | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 93fcef5..11cdc6d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1961,8 +1961,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	deadline_queue_push_tasks(rq);
 }
 
-static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
-						   struct dl_rq *dl_rq)
+static struct sched_dl_entity *pick_next_dl_entity(struct dl_rq *dl_rq)
 {
 	struct rb_node *left = rb_first_cached(&dl_rq->root);
 
@@ -1981,7 +1980,7 @@ static struct task_struct *pick_task_dl(struct rq *rq)
 	if (!sched_dl_runnable(rq))
 		return NULL;
 
-	dl_se = pick_next_dl_entity(rq, dl_rq);
+	dl_se = pick_next_dl_entity(dl_rq);
 	BUG_ON(!dl_se);
 	p = dl_task_of(dl_se);
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index b62e765..67039e5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1719,8 +1719,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	rt_queue_push_tasks(rq);
 }
 
-static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
-						   struct rt_rq *rt_rq)
+static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
 {
 	struct rt_prio_array *array = &rt_rq->active;
 	struct sched_rt_entity *next = NULL;
@@ -1742,7 +1741,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 	struct rt_rq *rt_rq  = &rq->rt;
 
 	do {
-		rt_se = pick_next_rt_entity(rq, rt_rq);
+		rt_se = pick_next_rt_entity(rt_rq);
 		BUG_ON(!rt_se);
 		rt_rq = group_rt_rq(rt_se);
 	} while (rt_rq);

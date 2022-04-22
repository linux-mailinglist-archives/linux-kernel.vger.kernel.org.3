Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8264050B510
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446612AbiDVKbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446547AbiDVKai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:30:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDA754BF5;
        Fri, 22 Apr 2022 03:27:45 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:27:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623263;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/WkXZ9wsxlcwcfCqQFCezZuWBx+EZXyJRY6J8rqNIQ=;
        b=Ftdak4OUQThkTfBDs6iPyMm4ibg2iIQBzCbm5Z747s4DFOmWbe+zHaHMz5+jg7oBVExTfJ
        Ah9eItXE1b8wpd2GAR33BfyFnLCREIsiAql+mOl6ekB2DbqGHyvz9++Hj8A5gwLU7e6G/Q
        zZxgEFdabp1+ZB9lqgQJhf9cZlKvDoN7tyr0YBK12F0ddfmW7mzWnOgc0lSBXs+Xre6C5z
        GWQXG/XLrBGGYQTJh9FgBCXCnUH5oYA+HKXppPEREtofuzhBH7CypZRPDnTC9Xlevl6kAC
        80Jesv8Zn5fmlgRBAuGZy9HmCZXbJ/zUZQOg+scE8z5xkq5Oqb2DQmG3HSgQKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623263;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/WkXZ9wsxlcwcfCqQFCezZuWBx+EZXyJRY6J8rqNIQ=;
        b=oHORoeEo/+iN5oAwHlld7434DDw4D9NABdBM4Ef0pbnYJxsVUQZsZUEsKLG7VW979OkfOC
        RZs58+ViCaPnwYBA==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix cfs_rq_clock_pelt() for throttled cfs_rq
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ben Segall <bsegall@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220408115309.81603-1-zhouchengming@bytedance.com>
References: <20220408115309.81603-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <165062326289.4207.13116115438165020704.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     64eaf50731ac0a8c76ce2fedd50ef6652aabc5ff
Gitweb:        https://git.kernel.org/tip/64eaf50731ac0a8c76ce2fedd50ef6652aabc5ff
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Fri, 08 Apr 2022 19:53:08 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:14:07 +02:00

sched/fair: Fix cfs_rq_clock_pelt() for throttled cfs_rq

Since commit 23127296889f ("sched/fair: Update scale invariance of PELT")
change to use rq_clock_pelt() instead of rq_clock_task(), we should also
use rq_clock_pelt() for throttled_clock_task_time and throttled_clock_task
accounting to get correct cfs_rq_clock_pelt() of throttled cfs_rq. And
rename throttled_clock_task(_time) to be clock_pelt rather than clock_task.

Fixes: 23127296889f ("sched/fair: Update scale invariance of PELT")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ben Segall <bsegall@google.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20220408115309.81603-1-zhouchengming@bytedance.com
---
 kernel/sched/fair.c  | 8 ++++----
 kernel/sched/pelt.h  | 4 ++--
 kernel/sched/sched.h | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 601f8bd..f74b340 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4846,8 +4846,8 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 
 	cfs_rq->throttle_count--;
 	if (!cfs_rq->throttle_count) {
-		cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
-					     cfs_rq->throttled_clock_task;
+		cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
+					     cfs_rq->throttled_clock_pelt;
 
 		/* Add cfs_rq with load or one or more already running entities to the list */
 		if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
@@ -4864,7 +4864,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 
 	/* group is entering throttled state, stop time */
 	if (!cfs_rq->throttle_count) {
-		cfs_rq->throttled_clock_task = rq_clock_task(rq);
+		cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
 		list_del_leaf_cfs_rq(cfs_rq);
 	}
 	cfs_rq->throttle_count++;
@@ -5308,7 +5308,7 @@ static void sync_throttle(struct task_group *tg, int cpu)
 	pcfs_rq = tg->parent->cfs_rq[cpu];
 
 	cfs_rq->throttle_count = pcfs_rq->throttle_count;
-	cfs_rq->throttled_clock_task = rq_clock_task(cpu_rq(cpu));
+	cfs_rq->throttled_clock_pelt = rq_clock_pelt(cpu_rq(cpu));
 }
 
 /* conditionally throttle active cfs_rq's from put_prev_entity() */
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index c336f5f..4ff2ed4 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -145,9 +145,9 @@ static inline u64 rq_clock_pelt(struct rq *rq)
 static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
 	if (unlikely(cfs_rq->throttle_count))
-		return cfs_rq->throttled_clock_task - cfs_rq->throttled_clock_task_time;
+		return cfs_rq->throttled_clock_pelt - cfs_rq->throttled_clock_pelt_time;
 
-	return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_task_time;
+	return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_pelt_time;
 }
 #else
 static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 58263f9..762be73 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -603,8 +603,8 @@ struct cfs_rq {
 	s64			runtime_remaining;
 
 	u64			throttled_clock;
-	u64			throttled_clock_task;
-	u64			throttled_clock_task_time;
+	u64			throttled_clock_pelt;
+	u64			throttled_clock_pelt_time;
 	int			throttled;
 	int			throttle_count;
 	struct list_head	throttled_list;

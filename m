Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB0F49249E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240602AbiARLSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:18:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35114 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbiARLSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:18:16 -0500
Date:   Tue, 18 Jan 2022 11:18:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642504693;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oWKZwKyG+bLylrY0AetNmo/3o9rtAiab3PfnDq35yCA=;
        b=hcdScKru5mldHbtCpgQbb0cmBfXpaP3tv2yHnRJiuK4xypcYYO0W+nPOsCl45qKNZcxjsu
        aBi+xqfWtpllPOLDxl1iwy9Vdme2wW368VL3bCnfGbV7Wu2rLYIfXMmxF40Bx52R9h+6hI
        769JySUExo4TwvWyIK44uM0qHhj5Ecn0BPTLle8wC4Sv415hqWeA49FoWy2e+NKM/fhStC
        e4QTGYAXDdNlF6PEMnJ769o7ERvGgUiX8ILsOikGlCDrTiikupUkgO01c7DGsHhoLOYcB5
        TdjpqWG3wxr+PaqGb4cNmXfhNTW5ueASnoSXrmpueSQ5ybHyzoeGUbITA9omTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642504693;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oWKZwKyG+bLylrY0AetNmo/3o9rtAiab3PfnDq35yCA=;
        b=GdGCQGAVIqBcHZJFvZ9N7fQgw+yVzt2AAHgYv3UIc8iZ/wVvvxOChEMGN/QQZFBOJPj3ip
        B8UJ2HcrMj9bBhCQ==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/pelt: Relax the sync of load_sum with load_avg
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sachin Sant <sachinp@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220111134659.24961-5-vincent.guittot@linaro.org>
References: <20220111134659.24961-5-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <164250469199.16921.17195356283606086939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     2d02fa8cc21a93da35cfba462bf8ab87bf2db651
Gitweb:        https://git.kernel.org/tip/2d02fa8cc21a93da35cfba462bf8ab87bf2db651
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 11 Jan 2022 14:46:59 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Jan 2022 12:09:58 +01:00

sched/pelt: Relax the sync of load_sum with load_avg

Similarly to util_avg and util_sum, don't sync load_sum with the low
bound of load_avg but only ensure that load_sum stays in the correct range.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Link: https://lkml.kernel.org/r/20220111134659.24961-5-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0e87e19..f4f02c2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3028,9 +3028,11 @@ enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	u32 divider = get_pelt_divider(&se->avg);
 	sub_positive(&cfs_rq->avg.load_avg, se->avg.load_avg);
-	cfs_rq->avg.load_sum = cfs_rq->avg.load_avg * divider;
+	sub_positive(&cfs_rq->avg.load_sum, se_weight(se) * se->avg.load_sum);
+	/* See update_cfs_rq_load_avg() */
+	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
+					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
 }
 #else
 static inline void
@@ -3513,9 +3515,10 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
 static inline void
 update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
-	long delta, running_sum, runnable_sum = gcfs_rq->prop_runnable_sum;
+	long delta_avg, running_sum, runnable_sum = gcfs_rq->prop_runnable_sum;
 	unsigned long load_avg;
 	u64 load_sum = 0;
+	s64 delta_sum;
 	u32 divider;
 
 	if (!runnable_sum)
@@ -3542,7 +3545,7 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 		 * assuming all tasks are equally runnable.
 		 */
 		if (scale_load_down(gcfs_rq->load.weight)) {
-			load_sum = div_s64(gcfs_rq->avg.load_sum,
+			load_sum = div_u64(gcfs_rq->avg.load_sum,
 				scale_load_down(gcfs_rq->load.weight));
 		}
 
@@ -3559,19 +3562,22 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	running_sum = se->avg.util_sum >> SCHED_CAPACITY_SHIFT;
 	runnable_sum = max(runnable_sum, running_sum);
 
-	load_sum = (s64)se_weight(se) * runnable_sum;
-	load_avg = div_s64(load_sum, divider);
-
-	se->avg.load_sum = runnable_sum;
+	load_sum = se_weight(se) * runnable_sum;
+	load_avg = div_u64(load_sum, divider);
 
-	delta = load_avg - se->avg.load_avg;
-	if (!delta)
+	delta_avg = load_avg - se->avg.load_avg;
+	if (!delta_avg)
 		return;
 
-	se->avg.load_avg = load_avg;
+	delta_sum = load_sum - (s64)se_weight(se) * se->avg.load_sum;
 
-	add_positive(&cfs_rq->avg.load_avg, delta);
-	cfs_rq->avg.load_sum = cfs_rq->avg.load_avg * divider;
+	se->avg.load_sum = runnable_sum;
+	se->avg.load_avg = load_avg;
+	add_positive(&cfs_rq->avg.load_avg, delta_avg);
+	add_positive(&cfs_rq->avg.load_sum, delta_sum);
+	/* See update_cfs_rq_load_avg() */
+	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
+					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
 }
 
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum)
@@ -3687,7 +3693,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 
 		r = removed_load;
 		sub_positive(&sa->load_avg, r);
-		sa->load_sum = sa->load_avg * divider;
+		sub_positive(&sa->load_sum, r * divider);
+		/* See sa->util_sum below */
+		sa->load_sum = max_t(u32, sa->load_sum, sa->load_avg * PELT_MIN_DIVIDER);
 
 		r = removed_util;
 		sub_positive(&sa->util_avg, r);

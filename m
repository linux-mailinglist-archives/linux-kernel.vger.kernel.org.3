Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679504924A0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbiARLTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbiARLSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:18:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EC7C06175B;
        Tue, 18 Jan 2022 03:18:16 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:18:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642504694;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4SMpOiBiYOOda3CoRuprLQiAjg0xLR2Ijp19/+j3id4=;
        b=FKuSn1iLHl1ipWprEDC40++4F1igBVk0ccldYx3SOK7AObG3Da5g+AaE5qH6EnaFdEH1Bt
        dbckV184Xb1wKnIZLPGUVNqEyXP4x7rTCbRAGZAgZLuMAx1B49ZdlNmMP+K1ixe6+wfZRJ
        9X4ZhXj49WL5F0VMCunptQYIcH20OUx1E55cm2WQFkbxEfXcnC+1X1yAwg4DCdfegBcZRR
        c1bBk+kxZqyvkca2q4YAGfCEe4mN69jmTB0GG7DZKgjpELEE6fwbWpN5ocWZVieF2S57jj
        9I5iazMVBd1SSYeWNCFGscp9rZA+ZvmmvUunP/FPsaLDZ4vg1Rp7Pi4PBlti5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642504694;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4SMpOiBiYOOda3CoRuprLQiAjg0xLR2Ijp19/+j3id4=;
        b=f8PqbjEBZNJGWc+gdqtz4lp4lz1euNMiqYxhHdNbegX2njJAeLS5oggwsIRZ8hrLeCH1E0
        Azjk9RJIDtS7wPCg==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/pelt: Continue to relax the sync of
 util_sum with util_avg
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sachin Sant <sachinp@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220111134659.24961-3-vincent.guittot@linaro.org>
References: <20220111134659.24961-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <164250469375.16921.3196123430425099121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     7ceb77103001544a43e11d7f3a8a69a2c1f422cf
Gitweb:        https://git.kernel.org/tip/7ceb77103001544a43e11d7f3a8a69a2c1f422cf
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 11 Jan 2022 14:46:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Jan 2022 12:09:58 +01:00

sched/pelt: Continue to relax the sync of util_sum with util_avg

Rick reported performance regressions in bugzilla because of cpu frequency
being lower than before:
    https://bugzilla.kernel.org/show_bug.cgi?id=215045

He bisected the problem to:
commit 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")

This commit forces util_sum to be synced with the new util_avg after
removing the contribution of a task and before the next periodic sync. By
doing so util_sum is rounded to its lower bound and might lost up to
LOAD_AVG_MAX-1 of accumulated contribution which has not yet been
reflected in util_avg.

update_tg_cfs_util() is not the only place where we round util_sum and
lost some accumulated contributions that are not already reflected in
util_avg. Modify update_tg_cfs_util() and detach_entity_load_avg() to not
sync util_sum with the new util_avg. Instead of always setting util_sum to
the low bound of util_avg, which can significantly lower the utilization,
we propagate the difference. In addition, we also check that cfs's util_sum
always stays above the lower bound for a given util_avg as it has been
observed that sched_entity's util_sum is sometimes above cfs one.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Link: https://lkml.kernel.org/r/20220111134659.24961-3-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d8f068d..ad2809c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3451,11 +3451,11 @@ void set_task_rq_fair(struct sched_entity *se,
 static inline void
 update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
-	long delta = gcfs_rq->avg.util_avg - se->avg.util_avg;
-	u32 divider;
+	long delta_sum, delta_avg = gcfs_rq->avg.util_avg - se->avg.util_avg;
+	u32 new_sum, divider;
 
 	/* Nothing to update */
-	if (!delta)
+	if (!delta_avg)
 		return;
 
 	/*
@@ -3464,13 +3464,20 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	 */
 	divider = get_pelt_divider(&cfs_rq->avg);
 
+
 	/* Set new sched_entity's utilization */
 	se->avg.util_avg = gcfs_rq->avg.util_avg;
-	se->avg.util_sum = se->avg.util_avg * divider;
+	new_sum = se->avg.util_avg * divider;
+	delta_sum = (long)new_sum - (long)se->avg.util_sum;
+	se->avg.util_sum = new_sum;
 
 	/* Update parent cfs_rq utilization */
-	add_positive(&cfs_rq->avg.util_avg, delta);
-	cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
+	add_positive(&cfs_rq->avg.util_avg, delta_avg);
+	add_positive(&cfs_rq->avg.util_sum, delta_sum);
+
+	/* See update_cfs_rq_load_avg() */
+	cfs_rq->avg.util_sum = max_t(u32, cfs_rq->avg.util_sum,
+					  cfs_rq->avg.util_avg * PELT_MIN_DIVIDER);
 }
 
 static inline void
@@ -3790,7 +3797,11 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	dequeue_load_avg(cfs_rq, se);
 	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
-	cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
+	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
+	/* See update_cfs_rq_load_avg() */
+	cfs_rq->avg.util_sum = max_t(u32, cfs_rq->avg.util_sum,
+					  cfs_rq->avg.util_avg * PELT_MIN_DIVIDER);
+
 	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
 	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * divider;
 

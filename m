Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCCD49249F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbiARLTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:19:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35132 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239939AbiARLSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:18:17 -0500
Date:   Tue, 18 Jan 2022 11:18:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642504693;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CIMje66HarV+dsIRQRwghy6DUk3igtAVNpH922XdAB4=;
        b=QbBFlQq/lwT/B99gEfvxVgnVT4MIEM6+XAuvzwXT9oOxjS8SwF3E0XPdSJHp61Qr+R00FH
        WDFXrV+zrGN0UiyxYWHqd9rekUbMJK37s8J69oSqWQNTWd8zGBEPYyj4xNLrXZFFn9qgXL
        GKJ+6jsx4ppW6xo8sK2aMgnsybZAX8CZQfcIOTjDkAJcl94BATz1/tgRIgu1sP+3AGpCQe
        C4YGmtRDnkHJfw1kgHovEkG5ZY/8w5MBbikEqSpcyAhLECiKsc1eBpefOzh88GA3j3bFzV
        ytSUyRO2FP/a4gSgbI2wa/Yq4R978PvaZw0DUroIcUK7336TrykC0fGySRXSxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642504693;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CIMje66HarV+dsIRQRwghy6DUk3igtAVNpH922XdAB4=;
        b=joTNPe/DdwD0gxQjuvt1FuxVnvcvpk7DrVkhZbDs6kW3BMev4ccOuQ/hdoekDRlHvwmHxs
        QFtnvIvoLYcfkPAg==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/pelt: Relax the sync of runnable_sum with
 runnable_avg
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sachin Sant <sachinp@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220111134659.24961-4-vincent.guittot@linaro.org>
References: <20220111134659.24961-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <164250469285.16921.10661112998534501596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     95246d1ec80b8d19d882cd8eb7ad094e63b41bb8
Gitweb:        https://git.kernel.org/tip/95246d1ec80b8d19d882cd8eb7ad094e63b41bb8
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 11 Jan 2022 14:46:58 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Jan 2022 12:09:58 +01:00

sched/pelt: Relax the sync of runnable_sum with runnable_avg

Similarly to util_avg and util_sum, don't sync runnable_sum with the low
bound of runnable_avg but only ensure that runnable_sum stays in the
correct range.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Link: https://lkml.kernel.org/r/20220111134659.24961-4-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ad2809c..0e87e19 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3483,11 +3483,11 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 static inline void
 update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
-	long delta = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
-	u32 divider;
+	long delta_sum, delta_avg = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
+	u32 new_sum, divider;
 
 	/* Nothing to update */
-	if (!delta)
+	if (!delta_avg)
 		return;
 
 	/*
@@ -3498,11 +3498,16 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
 
 	/* Set new sched_entity's runnable */
 	se->avg.runnable_avg = gcfs_rq->avg.runnable_avg;
-	se->avg.runnable_sum = se->avg.runnable_avg * divider;
+	new_sum = se->avg.runnable_avg * divider;
+	delta_sum = (long)new_sum - (long)se->avg.runnable_sum;
+	se->avg.runnable_sum = new_sum;
 
 	/* Update parent cfs_rq runnable */
-	add_positive(&cfs_rq->avg.runnable_avg, delta);
-	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * divider;
+	add_positive(&cfs_rq->avg.runnable_avg, delta_avg);
+	add_positive(&cfs_rq->avg.runnable_sum, delta_sum);
+	/* See update_cfs_rq_load_avg() */
+	cfs_rq->avg.runnable_sum = max_t(u32, cfs_rq->avg.runnable_sum,
+					      cfs_rq->avg.runnable_avg * PELT_MIN_DIVIDER);
 }
 
 static inline void
@@ -3702,7 +3707,10 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 
 		r = removed_runnable;
 		sub_positive(&sa->runnable_avg, r);
-		sa->runnable_sum = sa->runnable_avg * divider;
+		sub_positive(&sa->runnable_sum, r * divider);
+		/* See sa->util_sum above */
+		sa->runnable_sum = max_t(u32, sa->runnable_sum,
+					      sa->runnable_avg * PELT_MIN_DIVIDER);
 
 		/*
 		 * removed_runnable is the unweighted version of removed_load so we
@@ -3789,12 +3797,6 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
  */
 static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	/*
-	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
-	 * See ___update_load_avg() for details.
-	 */
-	u32 divider = get_pelt_divider(&cfs_rq->avg);
-
 	dequeue_load_avg(cfs_rq, se);
 	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
 	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
@@ -3803,7 +3805,10 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 					  cfs_rq->avg.util_avg * PELT_MIN_DIVIDER);
 
 	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
-	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * divider;
+	sub_positive(&cfs_rq->avg.runnable_sum, se->avg.runnable_sum);
+	/* See update_cfs_rq_load_avg() */
+	cfs_rq->avg.runnable_sum = max_t(u32, cfs_rq->avg.runnable_sum,
+					      cfs_rq->avg.runnable_avg * PELT_MIN_DIVIDER);
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 

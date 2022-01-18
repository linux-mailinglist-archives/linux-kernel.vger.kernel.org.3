Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84A24924A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240880AbiARLTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbiARLSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:18:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7D3C06173F;
        Tue, 18 Jan 2022 03:18:18 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:18:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642504695;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jB+AAfBQ/Cpg9uj9oeKH3BV5Tc6wD+3E2pSJR4k7UQ=;
        b=z030yX/5J7ch2CXzsz55fbTMBa66XTFlUaBypwitSr/udX6d0rwknZhv/PZ4v49aygy0dF
        l7w1npkT5oYB7kn1tGCWXvbd+/LY1ablronUSThREOgJ8IiOLc+b5xqN6mXO56ELZTWbr4
        wDcKxJcBb7YC9SvgzhDlMtehAl5vJtl/hvZDPXQ2NEC6lCoSjsMbqtEGWlr8TC5w31MaU1
        IR6vCYFWgDJ2eED00dvVG71fpBhiTITSa7CwPmTJ2ruZmaNNz3IJX0RZ/PVW+1ksFFodT/
        xiXCRkfvYazUcDzKikzU/M/emZAHSTeuIk9RZMOnUuerKYRUXVOLZtZCdaHL8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642504695;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jB+AAfBQ/Cpg9uj9oeKH3BV5Tc6wD+3E2pSJR4k7UQ=;
        b=jvu7xcoCZGL3KYTm25sHzm2ilWDh1DpBnzm6j+ykSJxcQl9R6t35TrECxydCTeJv97nDUM
        UCCeKweroAz1kEDg==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/pelt: Relax the sync of util_sum with util_avg
Cc:     Rick Yiu <rickyiu@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sachin Sant <sachinp@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220111134659.24961-2-vincent.guittot@linaro.org>
References: <20220111134659.24961-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <164250469466.16921.16764902048134124059.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     98b0d890220d45418cfbc5157b3382e6da5a12ab
Gitweb:        https://git.kernel.org/tip/98b0d890220d45418cfbc5157b3382e6da5a12ab
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 11 Jan 2022 14:46:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Jan 2022 12:09:58 +01:00

sched/pelt: Relax the sync of util_sum with util_avg

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

Instead of always setting util_sum to the low bound of util_avg, which can
significantly lower the utilization of root cfs_rq after propagating the
change down into the hierarchy, we revert the change of util_sum and
propagate the difference.

In addition, we also check that cfs's util_sum always stays above the
lower bound for a given util_avg as it has been observed that
sched_entity's util_sum is sometimes above cfs one.

Fixes: 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")
Reported-by: Rick Yiu <rickyiu@google.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Link: https://lkml.kernel.org/r/20220111134659.24961-2-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 16 +++++++++++++---
 kernel/sched/pelt.h |  4 +++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 095b0aa..d8f068d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3381,7 +3381,6 @@ void set_task_rq_fair(struct sched_entity *se,
 	se->avg.last_update_time = n_last_update_time;
 }
 
-
 /*
  * When on migration a sched_entity joins/leaves the PELT hierarchy, we need to
  * propagate its contribution. The key to this propagation is the invariant
@@ -3449,7 +3448,6 @@ void set_task_rq_fair(struct sched_entity *se,
  * XXX: only do this for the part of runnable > running ?
  *
  */
-
 static inline void
 update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
@@ -3681,7 +3679,19 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 
 		r = removed_util;
 		sub_positive(&sa->util_avg, r);
-		sa->util_sum = sa->util_avg * divider;
+		sub_positive(&sa->util_sum, r * divider);
+		/*
+		 * Because of rounding, se->util_sum might ends up being +1 more than
+		 * cfs->util_sum. Although this is not a problem by itself, detaching
+		 * a lot of tasks with the rounding problem between 2 updates of
+		 * util_avg (~1ms) can make cfs->util_sum becoming null whereas
+		 * cfs_util_avg is not.
+		 * Check that util_sum is still above its lower bound for the new
+		 * util_avg. Given that period_contrib might have moved since the last
+		 * sync, we are only sure that util_sum must be above or equal to
+		 *    util_avg * minimum possible divider
+		 */
+		sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * PELT_MIN_DIVIDER);
 
 		r = removed_runnable;
 		sub_positive(&sa->runnable_avg, r);
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index e06071b..c336f5f 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -37,9 +37,11 @@ update_irq_load_avg(struct rq *rq, u64 running)
 }
 #endif
 
+#define PELT_MIN_DIVIDER	(LOAD_AVG_MAX - 1024)
+
 static inline u32 get_pelt_divider(struct sched_avg *avg)
 {
-	return LOAD_AVG_MAX - 1024 + avg->period_contrib;
+	return PELT_MIN_DIVIDER + avg->period_contrib;
 }
 
 static inline void cfs_se_util_change(struct sched_avg *avg)

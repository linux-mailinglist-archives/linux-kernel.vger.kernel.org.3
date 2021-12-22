Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF2647CF6A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243993AbhLVJiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhLVJiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:38:10 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC660C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:38:09 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso910203wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hMvDR62IkMhQ/MiSQjz51UrBqVfrySQIUkPEdX6cxww=;
        b=P2aJjITVoRikqE+4XjBX1sMjEQBLQ5KBcfABpgtRh/+mFfUNVVLQRzvwbkkYOE7YKp
         w/zOdFbE/Z/aKlLIa03jCN+ESf7TaIM3KdntYXn5MNg7Dgg3BrTRaUVpH8AL5F7yBXV0
         1sWQWNbl5AtdKVyHopqQV2NhiFpjIu7RS0bcNoHgGF3ksUZ4vldGmDc2kVgUNh1U5ErA
         qLnBw9M7nqdV6swmGQ7C9nINGw6wAQUTldSf1rxyWNv63n1grPMNlmheGAhHdzJLD2iK
         lp9V1ImamOjpwINEoTb/Ak9e2BseJpnGIOhnRB2dAPCPCwNqxckRzl0jHd6SQya90pK/
         ZTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hMvDR62IkMhQ/MiSQjz51UrBqVfrySQIUkPEdX6cxww=;
        b=DafOC2MnnCaOpbHgKRN+qnxzVl378tK4lTBx+aw14xVOanZEc4SFBD1ehIfWOjcRHz
         mdvALAxrZ7j7afBOpm/IYrOrnjs/vzkItCWmOJUIL2XqqlNLBz0Yvsfla8K/e1QzXIfM
         Z1PnV7MfqjvDc9micXUcxVnQInDcNMCVRIuz5oY+f6iSRV4kZ66UCsNLHux6RS0riy/K
         xy5Y9bbAeTgLf2Mx0Y/GQ1Sak0oRHxK0J6Tf+W+Hwp0sjHW1M2MmRP3n10TaMilHoKSB
         N++MMdsCRi0krU6lLAnB08NMYC4eay4wYSw/R3X6buYaiu93IAN/Huwb8BdBIQtJlFPo
         h/+Q==
X-Gm-Message-State: AOAM533g1Bpok4M8oPhxqDlEF9ZO9j8ba8OauM2DmTIMp0KnkIcyTOhS
        Qq8CjudGNQbJJK28j3jhjQTGdg==
X-Google-Smtp-Source: ABdhPJz8UVSAKCRKCVMfw9/EoeDJd4HRjFdXuAIoY9Y4MOuh6iUtNLDsligMw/yb4rzsplygG8TcyA==
X-Received: by 2002:a05:600c:5009:: with SMTP id n9mr311658wmr.162.1640165888253;
        Wed, 22 Dec 2021 01:38:08 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:917b:d0f8:bb57:d63b])
        by smtp.gmail.com with ESMTPSA id u19sm1253430wmq.30.2021.12.22.01.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:38:07 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 1/3] sched/pelt: Don't sync hardly util_sum with uti_avg
Date:   Wed, 22 Dec 2021 10:38:00 +0100
Message-Id: <20211222093802.22357-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222093802.22357-1-vincent.guittot@linaro.org>
References: <20211222093802.22357-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
change down into the hierarchy, we revert the commit and propagate the
difference in util_sum.

In addition, we also check that cfs's util_sum always stays above the
lower bound for a given util_avg as it has been observed that
sched_entity's util_sum is sometimes above cfs one.

Fixes: 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")
Reported-by: Rick Yiu <rickyiu@google.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 095b0aa378df..9ac28f0f3645 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3381,6 +3381,7 @@ void set_task_rq_fair(struct sched_entity *se,
 	se->avg.last_update_time = n_last_update_time;
 }
 
+#define MIN_DIVIDER (LOAD_AVG_MAX - 1024)
 
 /*
  * When on migration a sched_entity joins/leaves the PELT hierarchy, we need to
@@ -3449,15 +3450,14 @@ void set_task_rq_fair(struct sched_entity *se,
  * XXX: only do this for the part of runnable > running ?
  *
  */
-
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
@@ -3466,13 +3466,30 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
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
+	/*
+	 * Because of rounding, se->util_sum might ends up being +1 more than
+	 * cfs->util_sum (XXX fix the rounding). Although this is not
+	 * a problem by itself, detaching a lot of tasks with the rounding
+	 * problem between 2 updates of util_avg (~1ms) can make cfs->util_sum
+	 * becoming null whereas cfs_util_avg is not.
+	 * Check that util_sum is still above its lower bound for the new
+	 * util_avg. Given that period_contrib might have moved since the last
+	 * sync, we are only sure that util_sum must be above or equal to
+	 *    util_avg * minimum possible divider
+	 */
+	cfs_rq->avg.util_sum = max_t(u32, cfs_rq->avg.util_sum,
+					  cfs_rq->avg.util_avg * MIN_DIVIDER);
 }
 
 static inline void
@@ -3681,7 +3698,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 
 		r = removed_util;
 		sub_positive(&sa->util_avg, r);
-		sa->util_sum = sa->util_avg * divider;
+		sub_positive(&sa->util_sum, r * divider);
+		/* See update_tg_cfs_util() */
+		sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * MIN_DIVIDER);
 
 		r = removed_runnable;
 		sub_positive(&sa->runnable_avg, r);
@@ -3780,7 +3799,11 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	dequeue_load_avg(cfs_rq, se);
 	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
-	cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
+	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
+	/* See update_tg_cfs_util() */
+	cfs_rq->avg.util_sum = max_t(u32, cfs_rq->avg.util_sum,
+					  cfs_rq->avg.util_avg * MIN_DIVIDER);
+
 	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
 	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * divider;
 
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0890248AECD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbiAKNrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbiAKNrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:47:15 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B62C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:47:15 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k30so15491578wrd.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=evuXX/v2gImyPX1SOtO3snHEFUv8GN/ZKm3pGyafoe8=;
        b=Gn2RKgLREKnM4ChkGpQSG5QfWDSjRykiTGWuwk7FrsHCDyAfP2o9C34Gq6NQ/lgeoZ
         MGP73uq5p0c8sIU/NeO1kTHvlOz9FXQMxTBBGpuPqLyrfDQ1IRyHGcXEe2E/q+BqGVhA
         bVw5qLsUeHAu96OrHlpI0uTQJFqRU2QvMCFQcjFL264eset0p02hUbEvAN0DqZKOOCy4
         Wh/qubQ6AKUSrEMzAAE3lUubedk8ayKnHXL4a+9BNgMwyuLZqMgJ76Mx+ksDA9vI6aau
         FXjD2NcjSTZkfGL3MmPXnfHjAPvnu3+AYVuSL/xTEjniX4iZULdGibG1CRXMfSrCqJx5
         zARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=evuXX/v2gImyPX1SOtO3snHEFUv8GN/ZKm3pGyafoe8=;
        b=YZRqd48NczngMyCon0A82sBLcZmi4hy2pTxXRNX6XdjP45XYOEnUH2eRobk23tANPP
         9zS81B9hjA2NWLoy/N27aeAKqskjcdJj2M5KadvCYXvvrpahQx8UFPo7lsTLovWPI7is
         Kd0dkJY0ZkqFbMHNYozuHu7AIPFebz5WZJg0na9Xjtc5Tb1AbEgKrW3exSeEkYrx6WTT
         rJoGl5l5Ci98odXWRFLis7MiwMq+HgjBeYjNkiuLZ+XxR/JsB39uOBuPsx+apPpmlw4m
         +01q0kV9H05eM92gX/Cv7mYOrNegosDB/DvuTEIZMKNyfvem/wY7+ik7olzE8Jt4kAtq
         od3A==
X-Gm-Message-State: AOAM531whKbcShAWzjfHSr/71rJwiGTxmFcg8pUZc65WmL6jGP8g8gkM
        sOE6PsYwZeG9eQSvRqXxOVTUXA==
X-Google-Smtp-Source: ABdhPJxBD6uv5PhlQA3LpyKuYZR6goOAPSBTcPPS6K0ws6uniDQ9RtuWUmXWjh2rTnMAyd8KdtGH9A==
X-Received: by 2002:adf:f303:: with SMTP id i3mr3799413wro.413.1641908833906;
        Tue, 11 Jan 2022 05:47:13 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:44fe:4c24:d946:283b])
        by smtp.gmail.com with ESMTPSA id az1sm9618411wrb.104.2022.01.11.05.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 05:47:12 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 2/4] sched/pelt: Continue to relax the sync of util_sum with util_avg
Date:   Tue, 11 Jan 2022 14:46:57 +0100
Message-Id: <20220111134659.24961-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111134659.24961-1-vincent.guittot@linaro.org>
References: <20220111134659.24961-1-vincent.guittot@linaro.org>
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

update_tg_cfs_util() is not the only place where we round util_sum and
lost some accumulated contributions that are not already reflected in
util_avg. Modify update_tg_cfs_util() and detach_entity_load_avg() to not
sync util_sum with the new util_avg. Instead of always setting util_sum to
the low bound of util_avg, which can significantly lower the utilization,
we propagate the difference. In addition, we also check that cfs's util_sum
always stays above the lower bound for a given util_avg as it has been
observed that sched_entity's util_sum is sometimes above cfs one.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ed35255fdb85..3eb73ce6ef13 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3453,11 +3453,11 @@ void set_task_rq_fair(struct sched_entity *se,
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
@@ -3466,13 +3466,20 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
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
+					  cfs_rq->avg.util_avg * MIN_DIVIDER);
 }
 
 static inline void
@@ -3792,7 +3799,11 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	dequeue_load_avg(cfs_rq, se);
 	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
-	cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
+	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
+	/* See update_cfs_rq_load_avg() */
+	cfs_rq->avg.util_sum = max_t(u32, cfs_rq->avg.util_sum,
+					  cfs_rq->avg.util_avg * MIN_DIVIDER);
+
 	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
 	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * divider;
 
-- 
2.17.1


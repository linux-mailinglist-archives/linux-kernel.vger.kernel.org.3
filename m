Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C067E47BD25
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhLUJrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbhLUJrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:47:21 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF97C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:47:21 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c4so25689525wrd.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eUZUF2wo2UyiFDUsTYAuoKyT64CXezAhy1cjbYgxVIM=;
        b=r0wt+RXiRKvMp/cPMJlF16Xy6eYnlpehwJegVFYAA+n09FohPvhuwtBJWVIMjjAk45
         qCq2sfppOYDKydRQRpCi9czFF98V2tFqir1OAe4vaI0j75u3/QHy9ahDB0c1IOijdRK2
         r0qhBmDM9Y17gD9EE5PU+35CYsyNo8aSdG0/tpRg5jT+SIGSZHc35P5hUPiWKYF4ZpQA
         pCajmOtJt3Hzta6me0CzyOrE0Fjh7cZS/iKH7tT0XhrtCVg44JmcZsS4vyJjqPVP6v9o
         mxDwWXqqVRiTRkWOzVN4R+0QQ4F4a7GiI8wejchou/Q+qYHNM0tsXFzioudeeOLSeghU
         z2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eUZUF2wo2UyiFDUsTYAuoKyT64CXezAhy1cjbYgxVIM=;
        b=1uoT95pC00KkyJTlDfKiScuAJCdFwngtkLG3PczD+ApI3bhFoN4XRlLZcS1Ls7u2vc
         yWhU89Elg3ytJByJtAJxShi6n8kCIA2lpJiTVIHcV+DnM/yKVHyMCunys3RR4Y7SIijr
         4Uatd+OqjacV3hmOZNCH4hcm2yLzZ9eS6+ZyYgu4/2ag5pwh8rRVr3Py2+xA8RHhUrPk
         v2FuwPIT9Y5Zb9Z/n06D2TvsYwF2PxBdbyo09/ikPOa2/8iTMM2I5Cl4yOwxfK4HunLM
         kdQLnwBPT9ojPTTTirBjIRKa4YaBpXnBBA07jlMzsxkvVSqWHIwILaznRkMHpspQlDJq
         LiHw==
X-Gm-Message-State: AOAM531oLOcbTXNbnTto9Z3DcUMuumD8E0PsuLIyLa37SHtwhAkMMXj4
        lT8IbIv7x7Eq3cizH47p9a8y3g==
X-Google-Smtp-Source: ABdhPJz0/25S6ms6okV83T4Qy8aqNDz+yaavm58UjdfHz75/v0w4yOOZpMG60iAq1mRGL5lnodrIYw==
X-Received: by 2002:a5d:6d06:: with SMTP id e6mr1907815wrq.273.1640080039727;
        Tue, 21 Dec 2021 01:47:19 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d88d:8149:7104:fe7f])
        by smtp.gmail.com with ESMTPSA id l36sm2094926wms.16.2021.12.21.01.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 01:47:19 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/3] sched/pelt: Don't sync hardly runnable_sum with runnable_avg
Date:   Tue, 21 Dec 2021 10:46:52 +0100
Message-Id: <20211221094653.10776-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221094653.10776-1-vincent.guittot@linaro.org>
References: <20211221094653.10776-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to util_avg and util_sum, don't sync runnable_sum with the low
bound of runnable_avg but only ensure that runnable_sum stays in the
correct range.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9ac28f0f3645..7e76b37de219 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3495,11 +3495,11 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
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
@@ -3510,11 +3510,16 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
 
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
+	/* See update_tg_cfs_util() */
+	cfs_rq->avg.runnable_sum = max_t(u32, cfs_rq->avg.runnable_sum,
+					      cfs_rq->avg.runnable_avg * MIN_DIVIDER);
 }
 
 static inline void
@@ -3704,7 +3709,10 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 
 		r = removed_runnable;
 		sub_positive(&sa->runnable_avg, r);
-		sa->runnable_sum = sa->runnable_avg * divider;
+		sub_positive(&sa->runnable_sum, r * divider);
+		/* See update_tg_cfs_util() */
+		sa->runnable_sum = max_t(u32, sa->runnable_sum,
+					      sa->runnable_avg * MIN_DIVIDER);
 
 		/*
 		 * removed_runnable is the unweighted version of removed_load so we
@@ -3805,7 +3813,10 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 					  cfs_rq->avg.util_avg * MIN_DIVIDER);
 
 	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
-	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * divider;
+	sub_positive(&cfs_rq->avg.runnable_sum, se->avg.runnable_sum);
+	/* See update_tg_cfs_util() */
+	cfs_rq->avg.runnable_sum = max_t(u32, cfs_rq->avg.runnable_sum,
+					      cfs_rq->avg.runnable_avg * MIN_DIVIDER);
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
-- 
2.17.1


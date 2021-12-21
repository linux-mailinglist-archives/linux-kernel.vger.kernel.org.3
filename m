Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B9F47BD26
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbhLUJrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbhLUJrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:47:23 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3753C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:47:22 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t18so25620949wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u3W3mlCfAgJ5gfEjsfCazsT5s33lKdpEuxRgIRLM76g=;
        b=kt0H2nMnOXhqYK3RHuFTbkIvbXyGIr5X5ryW8fY80dIVI8cOAQqRUVbzjRnXyfEovt
         7a6KOIisBQyzxXEzha0b/Te+CmRjHsmYKUtQnt4ntkFoYVesh6+F45jCrVM24maByVOh
         e90qVeZQGeVmkloy7tIngHcn0JY7LX4NYjSJhwh6WE1Oa2AGQ9cs+dCSsFUt5xZ+Tut/
         MfC473vUM3tEldVUaYrhnzw1d0aZsPGZErxQWa7LitJUc/qCKJbgcbm4mvIdHhdw/ecw
         1MgZfG7mccvd4vNYTjsbytMZssSC0+HJ1Nj+pyLxh92sHckpLrS+NhG0zFHJglGYITda
         gZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u3W3mlCfAgJ5gfEjsfCazsT5s33lKdpEuxRgIRLM76g=;
        b=0nF/mWgT/pmcmq1SmP/yxzKMy/QLF5r5w1wbjjZ6x7fMjpy9a31B9ep9iObuArGiLW
         EIl4/JPJQNl1N07gVj4R3sbSKMw5wBPmcGkuG+hLYj8ZuxAxJI37wuKb5oWCEeuBxJ72
         KgrxZM1HjYxDw8ifNNaVhc6G/Dh9gixLBJKO+AwNhpI8GGCQt0IrKQkUjHt1DbV9B7dW
         ZQJOF6jR/e9mR4A0oqNh5bbkRSmhVEMzenZNpjcuYKJDzL/GJcI1h5ZnvN8F49m2UzP7
         XNioF9dk6yf753VcYtcc/3zqLmYX4tZHyFS2MyntBRQ0k1DCDopSQ2AGgabHWNmwPNPl
         9ZTg==
X-Gm-Message-State: AOAM530YibOQTREk2R2LiHgnkUqFukI+jFAzYo5vuOkq5xfqHQEp7lTT
        zJOVso86Kmnmepff4wd62nexMA==
X-Google-Smtp-Source: ABdhPJzHkpnmTQwJDojsluqSMs+sIZoqwcsbGtFjTgQPK2nx0KWQsr1p9G6QxyDd+kh9cXKAk4VUug==
X-Received: by 2002:a05:6000:184a:: with SMTP id c10mr1881239wri.376.1640080041414;
        Tue, 21 Dec 2021 01:47:21 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d88d:8149:7104:fe7f])
        by smtp.gmail.com with ESMTPSA id l36sm2094926wms.16.2021.12.21.01.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 01:47:20 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/3] sched/pelt: Don't sync hardly runnable_sum with runnable_avg
Date:   Tue, 21 Dec 2021 10:46:53 +0100
Message-Id: <20211221094653.10776-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221094653.10776-1-vincent.guittot@linaro.org>
References: <20211221094653.10776-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to util_avg and util_sum, don't sync load_sum with the low
bound of load_avg but only ensure that load_sum stays in the correct range.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 47 ++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7e76b37de219..7e6a75c5061c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3025,12 +3025,17 @@ enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	cfs_rq->avg.load_sum += se_weight(se) * se->avg.load_sum;
 }
 
+#define MIN_DIVIDER (LOAD_AVG_MAX - 1024)
+
 static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	u32 divider = get_pelt_divider(&se->avg);
 	sub_positive(&cfs_rq->avg.load_avg, se->avg.load_avg);
-	cfs_rq->avg.load_sum = cfs_rq->avg.load_avg * divider;
+	sub_positive(&cfs_rq->avg.load_sum, se_weight(se) * se->avg.load_sum);
+	/* See update_tg_cfs_util() */
+	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
+					  cfs_rq->avg.load_avg * MIN_DIVIDER);
+
 }
 #else
 static inline void
@@ -3381,8 +3386,6 @@ void set_task_rq_fair(struct sched_entity *se,
 	se->avg.last_update_time = n_last_update_time;
 }
 
-#define MIN_DIVIDER (LOAD_AVG_MAX - 1024)
-
 /*
  * When on migration a sched_entity joins/leaves the PELT hierarchy, we need to
  * propagate its contribution. The key to this propagation is the invariant
@@ -3525,9 +3528,10 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
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
@@ -3554,7 +3558,7 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 		 * assuming all tasks are equally runnable.
 		 */
 		if (scale_load_down(gcfs_rq->load.weight)) {
-			load_sum = div_s64(gcfs_rq->avg.load_sum,
+			load_sum = div_u64(gcfs_rq->avg.load_sum,
 				scale_load_down(gcfs_rq->load.weight));
 		}
 
@@ -3571,19 +3575,22 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
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
+	/* See update_tg_cfs_util() */
+	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
+					  cfs_rq->avg.load_avg * MIN_DIVIDER);
 }
 
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum)
@@ -3699,7 +3706,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 
 		r = removed_load;
 		sub_positive(&sa->load_avg, r);
-		sa->load_sum = sa->load_avg * divider;
+		sub_positive(&sa->load_avg, r * divider);
+		/* See update_tg_cfs_util() */
+		sa->load_sum = max_t(u32, sa->load_sum, sa->load_avg * MIN_DIVIDER);
 
 		r = removed_util;
 		sub_positive(&sa->util_avg, r);
@@ -3799,12 +3808,6 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
-- 
2.17.1


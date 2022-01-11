Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC2B48AECF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbiAKNr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241091AbiAKNrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:47:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDE3C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:47:18 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id o3so33049928wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vuj6hMsLmlTFc4S+ebtak6Be/P54+GKB/p//j3m8mec=;
        b=vNr23HM5zMPvr7nJM5odVjgZyNOfWJ1bZtiLXnV/wG23uLY1KD+RBeRmMNlf6BSlLI
         QU22gPiPziUl05CjRsIKE9LAtcd7WH3QLq6dA986GdUeMb/6ljP5l2dGPfGDA8zB1Thk
         yZmmN0czslXSBXVSr9aAeVatC4iq90XRj6lNO+SbArhx6CYom2hgi3eQkelf8F4Sf818
         Cb3ALYwe/Rhz5CSD0jHh9VO1CWdADdfJMg8zCCx9ZKAu7+3g7Y20vVKwMynpyf0z6aRA
         McTcMLodPouvJd7rw0XC35qinruB7pzvK3vQsaLjMqMaQskhs3w5zrUtVSi6euOMinIY
         /TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vuj6hMsLmlTFc4S+ebtak6Be/P54+GKB/p//j3m8mec=;
        b=O/9o18C0mgXP16Z9emDNnkPSNXFz7UXSH2KRQdLz2wJInErbVS6lHtLYzcgK6FJUJ/
         yPxQ9JX//6miuQBrxXgrWdn7AqRYKtrpdIcPxUWeolXkEiY6b5Kbgh5MDZZFHrD7CKAn
         CGwaAyVzpYTsjRmj5F4//vPYPx31Vl2KOMFdn+TYcKuUcglUlMR/t2GJctLSt8oi1uhK
         xKP2YILzGBilkzBGlRKTM/rZNd81GGdYII+Rc6xceTiZTstK9bwkbETO5qY+ELvf83YU
         6FhGj5gpOfaMGH14mk6lISUYMs0SPqZQf2xw6HiwXsUx2iKGAZ7W8y4SP8QOLIjX9GSI
         BpEw==
X-Gm-Message-State: AOAM532KtZTSuenmzDcod33jKJruXKv0xF2I8iU/srDU0HCr5CU1Nb28
        SFRBk/hNsDqxbkJNKdcc7hTJUg==
X-Google-Smtp-Source: ABdhPJx6JOMrVRczm0P0IhKHjVS2xxieqE/YRqn1yYqP0Gm+WuCaOXfKR2UnDgUuV0HPu8kWLkwk7g==
X-Received: by 2002:a5d:4201:: with SMTP id n1mr2736310wrq.239.1641908837191;
        Tue, 11 Jan 2022 05:47:17 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:44fe:4c24:d946:283b])
        by smtp.gmail.com with ESMTPSA id az1sm9618411wrb.104.2022.01.11.05.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 05:47:16 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 4/4] sched/pelt: Relax the sync of load_sum with load_avg
Date:   Tue, 11 Jan 2022 14:46:59 +0100
Message-Id: <20220111134659.24961-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111134659.24961-1-vincent.guittot@linaro.org>
References: <20220111134659.24961-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to util_avg and util_sum, don't sync load_sum with the low
bound of load_avg but only ensure that load_sum stays in the correct range.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e34de721a630..12d139fed1f7 100644
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
+	/* See update_cfs_rq_load_avg() */
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
@@ -3515,9 +3518,10 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
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
@@ -3544,7 +3548,7 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 		 * assuming all tasks are equally runnable.
 		 */
 		if (scale_load_down(gcfs_rq->load.weight)) {
-			load_sum = div_s64(gcfs_rq->avg.load_sum,
+			load_sum = div_u64(gcfs_rq->avg.load_sum,
 				scale_load_down(gcfs_rq->load.weight));
 		}
 
@@ -3561,19 +3565,22 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	running_sum = se->avg.util_sum >> SCHED_CAPACITY_SHIFT;
 	runnable_sum = max(runnable_sum, running_sum);
 
-	load_sum = (s64)se_weight(se) * runnable_sum;
-	load_avg = div_s64(load_sum, divider);
+	load_sum = se_weight(se) * runnable_sum;
+	load_avg = div_u64(load_sum, divider);
 
-	se->avg.load_sum = runnable_sum;
-
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
+					  cfs_rq->avg.load_avg * MIN_DIVIDER);
 }
 
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum)
@@ -3689,7 +3696,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 
 		r = removed_load;
 		sub_positive(&sa->load_avg, r);
-		sa->load_sum = sa->load_avg * divider;
+		sub_positive(&sa->load_sum, r * divider);
+		/* See sa->util_sum below */
+		sa->load_sum = max_t(u32, sa->load_sum, sa->load_avg * MIN_DIVIDER);
 
 		r = removed_util;
 		sub_positive(&sa->util_avg, r);
-- 
2.17.1


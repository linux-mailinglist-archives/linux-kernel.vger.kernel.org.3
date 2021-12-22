Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5711D47CF6C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244016AbhLVJiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243991AbhLVJiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:38:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F00AC061401
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:38:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso910295wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uje+f8nQbSEgXf+lBRY8ONm+ajTteRb//Kh8q+sMpA8=;
        b=u2ThTkGL5VxWxpEXuHzAEUgyxqxCBZ1aLuZts8Y0JLgxwW2UGc80sKWgrVfQEuZheh
         kImkXo7zkN9QyA+HuZOKlIinVkUiki6poPsnfbZIon6NK1naXMAb6MbZMZkOKV2EvZpc
         zjHGTBlGLdm0bCEmepbIMqfJTmyJ0dwvg+eC1Tb2WRaX2Bb4zzDG9ezI3V8cPlsOzwws
         KorODs2Utbo3QCqpiO+leOSp/k+4YBXtAFZlXksFBNa4o6WSX0dTf5qSpgbLwRQNFYdA
         X1z05X9f99RSjmd6Gb7XovreNdSTygdeKDY3sgtfcbS9k6ZAFlmQo8k1ryLMJGsB7yWU
         a5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uje+f8nQbSEgXf+lBRY8ONm+ajTteRb//Kh8q+sMpA8=;
        b=LOQIbSD0Os1JhqmpuEtNNtE/9URzdXLjEMLynz1OFKWEL+FjBn4uDOkT498yjw+mnv
         Md+pCCSo3115fS+WiZ9mWDvXf4YfszE+YDytQhrAdHtTLpjWmWg8RPTfYxN4i4XUzi6Z
         nBuVYYD3FKWTRk7QDyugAi+5LeS70aoacNj2NHe+GSBZY3lZikTv+fKYNSiQtKBO7/x2
         5jUkaUDDFCcg8AsHwT31mUiBYwC/PVNLbxmwYApGGUnJPq3mgffo7eC1nAkeV7rgqPf6
         GGQjHjkLmApy/UxJ2TjMg9F7Nr08H5yUm2XC2VSruLXMK1I9sAH5Rg3hd925rDJdl3Jq
         EScQ==
X-Gm-Message-State: AOAM533yJ8sZhP52SBXOnZqDzMXjpniCkxwVhbn5HF0IKPQQRhvjToo2
        vI80BfwaHuwzaQ4mNuwcHGpEHg==
X-Google-Smtp-Source: ABdhPJyp32KpJJygx4yRx2ScCV3cyw1u+UI0yUHIqPYNcz4wYrFxTwo1YRxntVNnjEkkraxk1Yw9YQ==
X-Received: by 2002:a05:600c:2059:: with SMTP id p25mr290557wmg.151.1640165891075;
        Wed, 22 Dec 2021 01:38:11 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:917b:d0f8:bb57:d63b])
        by smtp.gmail.com with ESMTPSA id u19sm1253430wmq.30.2021.12.22.01.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:38:10 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 3/3] sched/pelt: Don't sync hardly load_sum with load_avg
Date:   Wed, 22 Dec 2021 10:38:02 +0100
Message-Id: <20211222093802.22357-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222093802.22357-1-vincent.guittot@linaro.org>
References: <20211222093802.22357-1-vincent.guittot@linaro.org>
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
index b4c350715c16..488213d98770 100644
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
+		sub_positive(&sa->load_sum, r * divider);
+		/* See update_tg_cfs_util() */
+		sa->load_sum = max_t(u32, sa->load_sum, sa->load_avg * MIN_DIVIDER);
 
 		r = removed_util;
 		sub_positive(&sa->util_avg, r);
-- 
2.17.1


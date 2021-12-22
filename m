Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D62547CF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhLVJiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239938AbhLVJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:38:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00225C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:38:10 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso910255wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xYgRf06omlSEbyJ8xFAIaAEi1ubJMvI0YG4FIRkDadY=;
        b=ymw+Pgnw00Zx+i4K7YnmdJ2aouUNH+Y3jCSxTSWufyHEV7sfkn1EIkXNdCWd7+ESZA
         huctIxoCqB4gOU55Kt4ntR4+kvzkRiAsEGnXYjJia2yNkPklcdIbXllPYKtjsO86pnmY
         HY4dP6epdEVicgbTmEG057nT4CzWy5ZRgESIbkojhMkiNoW6EnOgcsQpThy7YJiTPA1r
         mJYr7N4o7kUM19xnUZ266ExBo08KZm5/SFjIx3p/l1fIgXy8TrAX97ED8AGpASspBE86
         +CdKG/vTzDKa+HFeN2QU4h2auK841ueUt8EzU/JRfrGX3J6LJ8XiyAiFjM1Vmo/WmPas
         EPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xYgRf06omlSEbyJ8xFAIaAEi1ubJMvI0YG4FIRkDadY=;
        b=MFiQjya8f5Ts9zuuJatM8VlMMz/6oh9H1YuoqBG7oCx/fm9eNt7XLQKG6vXXwHoOtN
         KVmGyjDbjujRK9MtOtcqW/x2rDDHT54rVIrLdOdX1r5xn8jEo2YPDfe76dxc5bkAE8p6
         ny0wjL3xuVKT+ndJUmDJPqctzuGrfe7UucR43ZBOGRWx4fXttL+5YESM6p1uD2auWzz+
         yUI3G/yF1eNM4OU1mGq29LFxgBVPVB215sWrv3U5MkUNRRyBK2zxfpCgdrO5cegGywcd
         8RMNGJePLG8HvMx7enN1SZ9TZjbx0QlFsgqTxAhkJhpConksWIvRk7Rk0XXrB7G5pH1o
         4e6w==
X-Gm-Message-State: AOAM532pfsFUDkGZhWQTt9sRBQnNZzO+onwi/NDKo5kpEDTaz1Nf5Wuw
        ivgnzemyDmHeTJ5SLZg+iRnn0w==
X-Google-Smtp-Source: ABdhPJy77aXyjoMQkvcUx+JmSsSWk6mToRso2LAJIlcohxMYZGn7XMjOlmatJxWVJ8QfDdq7Ltgpeg==
X-Received: by 2002:a7b:c1d5:: with SMTP id a21mr297154wmj.97.1640165889505;
        Wed, 22 Dec 2021 01:38:09 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:917b:d0f8:bb57:d63b])
        by smtp.gmail.com with ESMTPSA id u19sm1253430wmq.30.2021.12.22.01.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:38:09 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 2/3] sched/pelt: Don't sync hardly runnable_sum with runnable_avg
Date:   Wed, 22 Dec 2021 10:38:01 +0100
Message-Id: <20211222093802.22357-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222093802.22357-1-vincent.guittot@linaro.org>
References: <20211222093802.22357-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to util_avg and util_sum, don't sync runnable_sum with the low
bound of runnable_avg but only ensure that runnable_sum stays in the
correct range.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9ac28f0f3645..b4c350715c16 100644
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
@@ -3791,12 +3799,6 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
@@ -3805,7 +3807,10 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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


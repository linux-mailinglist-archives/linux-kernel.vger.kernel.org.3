Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5234148AECE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbiAKNrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241038AbiAKNrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:47:17 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF0BC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:47:17 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v123so11074330wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w+4pWCkbc5+/uOsA877Kk9lzlaHC1gngeuGc+JbN+s4=;
        b=HlcDeQuNG9XdkZLn6fFhutXjktn7sYn6cln+iG7CRb2Q7HpaJs4s1SibSz7DrYaDwK
         MuEN5xplHr89BE5hcSgJEOlv3Ld4MRQW/A2ECQ9lYSlbDOevmUPHY3xwS+mVRbxeZM5f
         /a8jCACFTccu5Xaq+73kU3/VJsOIDpa35kWeySbFR+xswZsxl9KV+3E+E+r1orHStUa8
         fkJdP3W+NYvEKBuUZWB7MSFgJQBS7Z6rL3HFNxaq25wOtreHAgolLo/9jiCxfOFrfYyL
         7WJQZiovToc76ID0+GVx1wDuFcGET8QE+frpkLbHk/aH+tItxxS0bcSiRkoVeu0Qa0bd
         H0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w+4pWCkbc5+/uOsA877Kk9lzlaHC1gngeuGc+JbN+s4=;
        b=aigIovhxnEOeKQy3Rusivr08aCw3/0T2VsHEF07SRCBHbZgr5zejvRoyLY96L5S3AB
         cSSpChDs6Y4rqtvzghc1QRs87XJBA0f3cSfUbmAbYQUtbIQj06mM/ejzUstjujrfcpEG
         9vdcGxrwBWka15fiFeC0Nj75/mPGaTHODSl8bidTegTEanHgYIseP6pdzyfEBei38O5S
         aiQRJ9wwR0QZmq7wT2SsoRTLB+jg9osTYKLJ+Y8SYOWwc4koA3nGtXG9seQdPN/H6fQ2
         12D5xC3YX3Ro3Go+JQ1FEoEfUjdzFwtwtBHsC9Qv6I6VxvnQMcUwZyDtMsfqeaOJ8jgs
         iBNw==
X-Gm-Message-State: AOAM5338ZgXUuGmE7a8fSx9tX6/QWSA6seIvby7/mEWzxb/U96o0i3CG
        piXj+gVN5UI/CnwlEWiBdrxqHA==
X-Google-Smtp-Source: ABdhPJx1RWrb3mlwqoWW+g5yUOam0f4FahwfjAVAAa02bp8IjxnmyPasCGV8na+5KP3WeWpccyV4RQ==
X-Received: by 2002:a05:600c:4991:: with SMTP id h17mr2591827wmp.14.1641908835607;
        Tue, 11 Jan 2022 05:47:15 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:44fe:4c24:d946:283b])
        by smtp.gmail.com with ESMTPSA id az1sm9618411wrb.104.2022.01.11.05.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 05:47:14 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 3/4] sched/pelt: Relax the sync of runnable_sum with runnable_avg
Date:   Tue, 11 Jan 2022 14:46:58 +0100
Message-Id: <20220111134659.24961-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111134659.24961-1-vincent.guittot@linaro.org>
References: <20220111134659.24961-1-vincent.guittot@linaro.org>
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
index 3eb73ce6ef13..e34de721a630 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3485,11 +3485,11 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
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
@@ -3500,11 +3500,16 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
 
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
+					      cfs_rq->avg.runnable_avg * MIN_DIVIDER);
 }
 
 static inline void
@@ -3704,7 +3709,10 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 
 		r = removed_runnable;
 		sub_positive(&sa->runnable_avg, r);
-		sa->runnable_sum = sa->runnable_avg * divider;
+		sub_positive(&sa->runnable_sum, r * divider);
+		/* See sa->util_sum above */
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
+	/* See update_cfs_rq_load_avg() */
+	cfs_rq->avg.runnable_sum = max_t(u32, cfs_rq->avg.runnable_sum,
+					      cfs_rq->avg.runnable_avg * MIN_DIVIDER);
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
-- 
2.17.1


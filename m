Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9025586388
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbiHAE3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239647AbiHAE2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:28:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8339313F4B
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ha11so9797498pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MF8vit1pzG5l/SDs5xaftECSlzOvu9Mvi/2q+XylMVk=;
        b=7+mdjoRv3mAvaUsy/qaAqhIYUHnFhezVR2vZwwAlFIVwXdSwYRO6mwRJo5YwkyX2xm
         w0nJsBSfCBMbFdMsrc9F1Bye1kKKsSUgknIHjIBqb2KUpeLO2HrNVNX18ADlsMdXV9/u
         khn3T3GUscsXQ3Ju5KF8pxHrUQHRYdg8WG5qBj1sAsPQQNBbtiu/E3AguAwoKKQde44v
         uFSG2PMpXEbsOil4TOLca6ibOSf8BUzGWCwOZj9ECc1V7x06Z9nAhxZ60QJOn3kw9f91
         6kkNZ6f9Bu5QJBhONo/OBOn+p0nlXs+kD6BNyxknJlo1kfcAkVmvCm+7eVKatdKus8SG
         FQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MF8vit1pzG5l/SDs5xaftECSlzOvu9Mvi/2q+XylMVk=;
        b=p9T18MQfahM8FEYyya8t/BgLM/dKJHUdDK8Hoss+vXH4RxBAGopLkop6+nvRoKpp/o
         tfDjvmz2RH5aoDqyeqei5FwgBm/tPUqs0RUucBQnRCJ6idy8vPL7g/EaTBGmmAkApf3F
         +b3ZORS987zKSuNX7w2oaSbKUWTOThDYfQQCSZx3cGrKjzVQwWHWaC2el8WlF2L+aXCB
         31d8YdxnMs8p5TwCstcwxt6k4gLBtjAulM3JPF1V4nfajKWwDpPoktBAX0J9jywmqRVb
         bKIM7ra6QDOnJL+LzgQqC+4N+sguIuSMTt5toy2ZHWj/uiQG3cW478ELfE5LbmOmxFPC
         UYIA==
X-Gm-Message-State: ACgBeo2xDNdGKY5zZJV4yJjZ0nfs86zWA1jM6Lmw/a54m181ZBm/gRCn
        DQsW4zUSIes68/gvP1AL6quv0Q==
X-Google-Smtp-Source: AA6agR7/2W0lgoYct0viSrbCL+9fFWA7Ftr7sCPcpxtGoRtRb7ZnC5KEK1VOskIud253AtdsW4OxqQ==
X-Received: by 2002:a17:90b:4b8a:b0:1f5:942:dcc6 with SMTP id lr10-20020a17090b4b8a00b001f50942dcc6mr1595918pjb.78.1659328120088;
        Sun, 31 Jul 2022 21:28:40 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id ot10-20020a17090b3b4a00b001f326ead012sm7012202pjb.37.2022.07.31.21.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 21:28:39 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 10/10] sched/fair: don't init util/runnable_avg for !fair task
Date:   Mon,  1 Aug 2022 12:27:45 +0800
Message-Id: <20220801042745.7794-11-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801042745.7794-1-zhouchengming@bytedance.com>
References: <20220801042745.7794-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

post_init_entity_util_avg() init task util_avg according to the cpu util_avg
at the time of fork, which will decay when switched_to_fair() some time later,
we'd better to not set them at all in the case of !fair task.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 18e3dff606db..071c159605e7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -833,20 +833,6 @@ void post_init_entity_util_avg(struct task_struct *p)
 	long cpu_scale = arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq)));
 	long cap = (long)(cpu_scale - cfs_rq->avg.util_avg) / 2;
 
-	if (cap > 0) {
-		if (cfs_rq->avg.util_avg != 0) {
-			sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
-			sa->util_avg /= (cfs_rq->avg.load_avg + 1);
-
-			if (sa->util_avg > cap)
-				sa->util_avg = cap;
-		} else {
-			sa->util_avg = cap;
-		}
-	}
-
-	sa->runnable_avg = sa->util_avg;
-
 	if (p->sched_class != &fair_sched_class) {
 		/*
 		 * For !fair tasks do:
@@ -861,6 +847,20 @@ void post_init_entity_util_avg(struct task_struct *p)
 		se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
 		return;
 	}
+
+	if (cap > 0) {
+		if (cfs_rq->avg.util_avg != 0) {
+			sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
+			sa->util_avg /= (cfs_rq->avg.load_avg + 1);
+
+			if (sa->util_avg > cap)
+				sa->util_avg = cap;
+		} else {
+			sa->util_avg = cap;
+		}
+	}
+
+	sa->runnable_avg = sa->util_avg;
 }
 
 #else /* !CONFIG_SMP */
-- 
2.36.1


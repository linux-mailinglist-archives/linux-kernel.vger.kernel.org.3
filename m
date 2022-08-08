Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEA358C8E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbiHHM71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243201AbiHHM6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:58:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D1FE03B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:58:42 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y1so2859457plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jpsF7ETAikN9eZ5FGIx/2HtxGomhcrX08v3cHOIgq4s=;
        b=bI8LP6BjxCL0bqdcccNqSD2f8AhFDRwqb8ulXK2KG669BulvbmqdNcAW8e9JRKBVJp
         7IAzBihMZf5bvJyOiGRZpA9XlxbOqpHTVOQeXTNazLdsby7PUNxZUsdbZKAC/97xXZoP
         NVvx1+TmQtD9DL+c7ekvZxVFeZZi1U+UdHJr5kCDu2S5jf2zedoEQKHj22pN6uHJzRfm
         e03GymSbax+9EEOv9iRi4o6LeVnXVLaIdhBaW0zaiwyi1aOqM2aqYQaNtwoXyt4xHfDn
         9mO4/IGz0RhrRWNXvJRKBT4F5st0PXGXGJQGOJuiTEZuimgRh6kw1z9xk08/xHoFjfIX
         Skhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jpsF7ETAikN9eZ5FGIx/2HtxGomhcrX08v3cHOIgq4s=;
        b=5WVOG4lIkPQAmSokcqirKXO1GuK98dR5t8Nyln3gOOHSI+82K9m2lIR9IjvJyUtiTM
         KbpbrV+sV2GqByNHcRaDKDJneiIS6EP6tksGPshorYtNgl/NKLNMi4Pnn/JGjVuWaM1z
         W2Ckf3JdGOMbxT7IcyjrVIjXRhG15f6HxES5+406R5fLOkCPsMAxW74kTge9DHGLNViQ
         8PWzyAISDEbatkb6Hy9I3YIupeEOHEOQtXe3vJETH0inGIyN+wDM+0YlNw9ZCBxbIgc3
         BA4tNWyoK+8PGhCLilV6xPFvfHcPLxi487fHOL5jjFluiS0Hn6pkyk9kVl01RN/1Tym8
         Zp6w==
X-Gm-Message-State: ACgBeo3MsSepstgB2BMMPcbGzTkld3RTZ9Mc88KvDNNxpaQrsBYfw27z
        CJnYp3YrruyxqJRUicJyHr1xCg==
X-Google-Smtp-Source: AA6agR5U+DoK1A/N8tpDIReBu2dxP1u9In+jBYtvXn28w9TMCnLUT1a9B5QDKh1X1paQua4SwjcJcg==
X-Received: by 2002:a17:903:2301:b0:16e:f916:22b4 with SMTP id d1-20020a170903230100b0016ef91622b4mr18259293plh.52.1659963521803;
        Mon, 08 Aug 2022 05:58:41 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090ae28e00b001f4ebd47ae7sm8057722pjz.54.2022.08.08.05.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:58:41 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 9/9] sched/fair: don't init util/runnable_avg for !fair task
Date:   Mon,  8 Aug 2022 20:57:45 +0800
Message-Id: <20220808125745.22566-10-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808125745.22566-1-zhouchengming@bytedance.com>
References: <20220808125745.22566-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 2063e30b2a8f..082174cb0e47 100644
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


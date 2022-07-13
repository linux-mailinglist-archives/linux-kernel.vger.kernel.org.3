Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AA5572C23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiGMEFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiGMEFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:05:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD1AD9E1C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:05:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y9so9159965pff.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f93VPJMo4dHwbuo4a1UCu4R/br+7n9ckKJLpiQoogmM=;
        b=pRG/gyxrG4hbJEoORBlZiJlSSvOAGy3zKqhZJWJLpXhvdvuD4ljjc6ESeL8CssbOfJ
         0QRzA63ZVkMrDGBz5ixEZ9AQq6FGUuEZhZ2GWAA35HbBdo/cNw626TmZ1R9G8aCZo1x5
         AVHdaykY00PZ5f2gzMv1sRXLEupt67gkvzJQvIU/zk3v3TNIUwFL/QufRp8YhVR8bJl0
         2Bbzk6fK+L/dBpA5jIc1swpdvw4sBq6eBEGimcGCNlZ0cMCUZ6aUU+N54p0BqT+SqkI7
         t4XgrGMtuQXuT9CpwKjCLtnzCb+xnn7R+H8vIfEiYQkxX3FyLsm5EqXz7URdTUiyhpvj
         L/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f93VPJMo4dHwbuo4a1UCu4R/br+7n9ckKJLpiQoogmM=;
        b=HrmClZyo00Oa7kiRmG8P+WW5VQjwJ4eUbTJe5G+WIJc9sp/6yuB+DLjbwUrcLXWoBN
         9KJU9RSMaVQyESNeIlDI9k/WuKxKyfDZ2xo9EhQgw5o0I/Q7kGUz+lkjEqRyS1hSazys
         TLQqcccn/SclVpmf7GTftTPw/cQQVBFKwqk892oqFYqRrC8cJtSMKLZc/0FOY6eBKSxb
         EjRK2OQzz5kDutBF0rDI478FPyirdAh95RpyiX5IAVTwskb2eGQTkMa1LzoIj5fd9EGq
         Ko5o6MVF+sgBtyOpuphjTRvzkJLJivrzLRN2E2t28SO+lb/lp9zuC2wRbL4HFJ0h6iD8
         H96w==
X-Gm-Message-State: AJIora8EYzh3kZKN1tVqmX1vFcSuRjFFmNOPInfTqr16U+NT7TZyIOTo
        c59YAb9LrY3pPHrA0dhPAGGsOw==
X-Google-Smtp-Source: AGRyM1vqOkE19zRkRioANm9tOhYUZ8kXz2U+a4MQaR+istmts1vMjVYnITWAL9WJflUjQ9AGOQLpZg==
X-Received: by 2002:a63:8148:0:b0:415:6fba:af3f with SMTP id t69-20020a638148000000b004156fbaaf3fmr1339090pgd.277.1657685109941;
        Tue, 12 Jul 2022 21:05:09 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016bd16f8acbsm6858942plg.114.2022.07.12.21.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:05:09 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 06/10] sched/fair: delete superfluous SKIP_AGE_LOAD
Date:   Wed, 13 Jul 2022 12:04:26 +0800
Message-Id: <20220713040430.25778-7-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713040430.25778-1-zhouchengming@bytedance.com>
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
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

There are three types of attach_entity_cfs_rq():

1. task migrate to CPU
2. task move to cgroup
3. task switched to fair from !fair

The case1 and case2 already have sched_avg last_update_time
reset to 0 when attach_entity_cfs_rq().

We will make case3 also have last_update_time reset to 0 when
attach_entity_cfs_rq() in the following patches.

So it makes no difference whether SKIP_AGE_LOAD is set or not.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 171bc22bc142..29811869c1fe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4001,9 +4001,8 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
  * Optional action to be done while updating the load average
  */
 #define UPDATE_TG	0x1
-#define SKIP_AGE_LOAD	0x2
-#define DO_ATTACH	0x4
-#define DO_DETACH	0x8
+#define DO_ATTACH	0x2
+#define DO_DETACH	0x4
 
 /* Update task and its cfs_rq load average */
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
@@ -4015,7 +4014,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	 * Track task load average for carrying it to new CPU after migrated, and
 	 * track group sched_entity load average for task_h_load calc in migration
 	 */
-	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
+	if (se->avg.last_update_time)
 		__update_load_avg_se(now, cfs_rq, se);
 
 	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
@@ -4298,7 +4297,6 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 }
 
 #define UPDATE_TG	0x0
-#define SKIP_AGE_LOAD	0x0
 #define DO_ATTACH	0x0
 #define DO_DETACH	0x0
 
@@ -11540,7 +11538,7 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 	/* Synchronize entity with its cfs_rq */
-	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
+	update_load_avg(cfs_rq, se, 0);
 	attach_entity_load_avg(cfs_rq, se);
 	update_tg_load_avg(cfs_rq);
 	propagate_entity_cfs_rq(se);
-- 
2.36.1


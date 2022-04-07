Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1586F4F71F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbiDGCUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiDGCT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:19:57 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D7013D3E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 19:17:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c23so3670235plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 19:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5atly7sML1X4/jGyyghqH6t1h2Chae3QqY9pLFPntK0=;
        b=nVdu9jX9MshKx7kZxBTf7EkLrkUx7WsG1yF6UZ+Qtsq1OWNjznR3xnzvjOaM+27eDo
         H/2cvX09qmwqjS7OYVO8WUG/bOk8MXuwyDyGDHqIFPh8eqwplC7Faat+dd4r/jzhi/xF
         Gwekjq8aHGWKEo/gC1NpuR7WnoVqXEpEEo906lu70iSjmSvNhRX6MotigFuJivRRf8lQ
         +Jg3vNuhjkdLZ6z+/tVq5yx8D6ZZUCuKNUqUz9PQ9CQW4alQSi+U7tbQYolayNw64QJS
         sf6lZ06kbC9BBbPgF9BM3sqjaMgTQsHv1dThecY7zvAXg71To1fsgvJlq1bUVeEHc2Op
         BbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5atly7sML1X4/jGyyghqH6t1h2Chae3QqY9pLFPntK0=;
        b=fb1/DpsFE5uC8RIZn2+wMvkO2Pc85Bojpb4TgpspPBVVG5r6gaCy3SdDC6jr6u9xtl
         hdiQANhIJbj3XadYRaDeZQTTsJDYcXIj0fuyoQvVXVrCYZmVpbOs3D5kHbHJZPSd+R+8
         pXRkTH8Ui+xL7COdgZHBQpF1D1dgFIWYFnUN3NwzissGkC4OLpJx3aruZWyYEAG+UM0L
         9gWfDrn2ZCQtF0QmbuPU9oK/SnPfQKfaCTy9ediZMn59cdoSH4UMvJPbskdSc0A6gfbR
         V8YII47XszMzD+gsa48TnBVFbgXOLqIypq3LhcW+NOtCfHimikEUOb8EoK/s3L7LVVBy
         JHsg==
X-Gm-Message-State: AOAM533xAS6LQiwYLPeK899aTMecgaxSZMep0EhtLOmrI+SB71YIJdKd
        o2H/r+MuHJ8Xs0qs+wvMqkzTJA==
X-Google-Smtp-Source: ABdhPJyJlmJylKrrrWMohTAUZEx2NB1xftfQCS24V97esmj0lyIRAvv/pK/FUibx7Tb8wXV8XnAmzQ==
X-Received: by 2002:a17:902:db0f:b0:156:9bf0:952d with SMTP id m15-20020a170902db0f00b001569bf0952dmr11548070plx.52.1649297879022;
        Wed, 06 Apr 2022 19:17:59 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6c:f010:ec92:b46d:e5a7:1343])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a0026ca00b004fb266fb186sm20847353pfw.73.2022.04.06.19.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 19:17:58 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 1/2] sched/fair: Fix cfs_rq_clock_pelt() for throttled cfs_rq
Date:   Thu,  7 Apr 2022 10:17:28 +0800
Message-Id: <20220407021729.16655-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
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

Since commit 23127296889f ("sched/fair: Update scale invariance of PELT")
change to use rq_clock_pelt() instead of rq_clock_task(), we should also
use rq_clock_pelt() for throttled_clock_task_time and throttled_clock_task
accounting.

Fixes: 23127296889f ("sched/fair: Update scale invariance of PELT")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d67ab..e6fa5d1141b4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4846,7 +4846,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 
 	cfs_rq->throttle_count--;
 	if (!cfs_rq->throttle_count) {
-		cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
+		cfs_rq->throttled_clock_task_time += rq_clock_pelt(rq) -
 					     cfs_rq->throttled_clock_task;
 
 		/* Add cfs_rq with load or one or more already running entities to the list */
@@ -4864,7 +4864,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 
 	/* group is entering throttled state, stop time */
 	if (!cfs_rq->throttle_count) {
-		cfs_rq->throttled_clock_task = rq_clock_task(rq);
+		cfs_rq->throttled_clock_task = rq_clock_pelt(rq);
 		list_del_leaf_cfs_rq(cfs_rq);
 	}
 	cfs_rq->throttle_count++;
@@ -5308,7 +5308,7 @@ static void sync_throttle(struct task_group *tg, int cpu)
 	pcfs_rq = tg->parent->cfs_rq[cpu];
 
 	cfs_rq->throttle_count = pcfs_rq->throttle_count;
-	cfs_rq->throttled_clock_task = rq_clock_task(cpu_rq(cpu));
+	cfs_rq->throttled_clock_task = rq_clock_pelt(cpu_rq(cpu));
 }
 
 /* conditionally throttle active cfs_rq's from put_prev_entity() */
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAB150B3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351173AbiDVJSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445882AbiDVJNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:13:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A24BB847
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:10:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s17so9510190plg.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G8S0f1fxh4tyjKf+IoZyuPgywpYwOEgpWk257TfqhQI=;
        b=d4wk5OPV0Zah6tt7VlyuF11yJsiCW6MgsfsalPD7a7HYycnmRNy+tjvAvkYU7EyWo/
         bDu5pyb6bQA6X3p99ngSNjMDWTgXp/lpLH7EWvt9tdmfoUjn4cfdEtHvrpBUkgIcWAZ8
         HXcUY3BC0ze5Xagu/AioHT5xTu3HQPMrjGb7k6GYzUiEuQcvJlQNvJUJ1RBrVX3Rmr2V
         8u7yzfDpOyJxwWplB2iFYmqElYyvNxqZao1xapDmF3Ry8sqKiSZ59RdIqfRqIhIP63LH
         JX1bADYycSryyEhwT3GWRP+WWA+Cx/lhWRV2QN8eCHqBHbx9vuM7gzlObJnWpV3wA+k7
         Kxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8S0f1fxh4tyjKf+IoZyuPgywpYwOEgpWk257TfqhQI=;
        b=AZz5hDzgD7367EaPQFtdVT/Z8E9tgmFoIyRMuxS7Byk3sOG9+E9gXorGWo3PTi/eOR
         xIDe1HL1TEoPXxZ5zvw45G6CrIourHspj6jf5GjHLtZdBBttlHxhFm6HZhR8kNMmgctr
         DggwwYxCuX0eu03XajOvGauZPYOEc2KTdgOf1YqWoTunfwDRreZcDTKv99xFsmCIBXdF
         bgLdTclPcc+X/LQvfhFbSJJpWqjUKxz4GardZQOgQhxZotARaoPD5F9Uzkdt5MUTfquF
         yklkulGRMcbgR/KHvTUAfcU6wvaZ1XtyO4xwUHaMVTu7HNbDMq4z8HWy0OrXTvws9Bqz
         1aZA==
X-Gm-Message-State: AOAM531lBFqMbtYpKp1jIYKx9wdYiVubqO5rpuNtsUE89898naQ35WCR
        oKeY2GLIAdPG/rsUbYzWppeQjA==
X-Google-Smtp-Source: ABdhPJz+j6iCMBbmMv2F+PtTyVy2Vkfyw2jgwAOMpNg1dazx/7ebgmLR9gHVessAIIG2LBvr3jIYLw==
X-Received: by 2002:a17:903:290:b0:15c:1c87:e66c with SMTP id j16-20020a170903029000b0015c1c87e66cmr1803213plr.61.1650618619137;
        Fri, 22 Apr 2022 02:10:19 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id oe7-20020a17090b394700b001d8995368a9sm559239pjb.35.2022.04.22.02.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:10:18 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v2 2/2] sched/dl: Remove some comments and adjust code in push_dl_task
Date:   Fri, 22 Apr 2022 17:09:44 +0800
Message-Id: <20220422090944.52618-3-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220422090944.52618-1-jiahao.os@bytedance.com>
References: <20220422090944.52618-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change to call update_rq_clock() before activate_task()
commit 840d719604b0 ("sched/deadline: Update rq_clock of later_rq
when pushing a task") is no longer needed since commit f4904815f97a
("sched/deadline: Fix double accounting of rq/running bw in push & pull")
removed the add_running_bw() before the activate_task().

So we remove some comments that are no longer needed and update
rq clock in activate_task().

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/deadline.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fb4255ae0b2c..8eb694ed7ac1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2319,13 +2319,7 @@ static int push_dl_task(struct rq *rq)
 
 	deactivate_task(rq, next_task, 0);
 	set_task_cpu(next_task, later_rq->cpu);
-
-	/*
-	 * Update the later_rq clock here, because the clock is used
-	 * by the cpufreq_update_util() inside __add_running_bw().
-	 */
-	update_rq_clock(later_rq);
-	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
+	activate_task(later_rq, next_task, 0);
 	ret = 1;
 
 	resched_curr(later_rq);
-- 
2.32.0


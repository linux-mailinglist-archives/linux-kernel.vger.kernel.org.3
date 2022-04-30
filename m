Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B49515B9E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 10:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358535AbiD3JCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 05:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241524AbiD3JCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 05:02:33 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4B223BDF
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 01:59:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i1so2856845plg.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 01:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6LLr6p6UjMmtIcgHFGWIZLSTwHROwXgBfoPFVeHgl8Y=;
        b=NGtCL/GhI4IsEMFFo2qIetG2ubiEimVIHu96aNVgnUYqhI/ErLjI9Vuja67ZXIoNlb
         AqzEtM1kkGkWUMvefGrXQSZ4CrNPVr6o6w+fBfcn0pTi51F9SiJkpRCBxDAqLpvKAWn2
         dXUjcC8hxWLqJELHo/sOVWdtI+1O4uISRFcOju4YPRYg9vwtT1xbEEPoIBRICpRa8PPb
         j436UvCuI2jCcelRN06q0Sd9ylkw87e394KuA9S4q4ZAsjzkfIt3CDiN1ekyttoJnEHv
         7lBb0JmbAcL3Jix0OrgC7mbe/hEB+RQWuIWWV6bEc9Rc8kqQsgtRw0uzLwcSFziWoNvM
         ktaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6LLr6p6UjMmtIcgHFGWIZLSTwHROwXgBfoPFVeHgl8Y=;
        b=IbXyUNxGidf9pmN7c0ftrJys9XBLDR3D3dgSBmzOI1DnYeJ+fyEM01EV9jjfIaKq/P
         iV+AJ7bwSntwZ/q7ruvtNKrbdcZSJtuA3d3pvAPHju1FUYtOWKZP+KwlFTucTMvOxfVR
         XEzEHN/F3RDoJK12Fefahu69XoJjtt66mtuPGzVzjuCQEJalnTp/MjXm0hZWhZU2vfa6
         Czvv1Cl8e7q1hgEvcUuyIk3XAnsG65+8MJ0GmOUM0lMu3BKJc/LRfFxDFh9hN7/VAWIC
         bwKOkY+2+rb7JC95UlUks2GulcMiHbBhCZsqBULZLI4U2MnN8hUTAshYRjsmZN7YRqON
         4V3w==
X-Gm-Message-State: AOAM530nYdr4QIqFDQP8tF4JcjWwtJpm4xOs4pLczwlPoYK7bVKOeEFe
        Zxvs9Xb+bdK0oqFUKD6GRE8RUw==
X-Google-Smtp-Source: ABdhPJwoB7JuNbW29XhrENTgeRsnISzdGnOokl29c9fleTFo3NElipLz3hDGD+q2yDTasUGspc0BtA==
X-Received: by 2002:a17:90b:3806:b0:1da:26fd:7add with SMTP id mq6-20020a17090b380600b001da26fd7addmr3335320pjb.228.1651309151790;
        Sat, 30 Apr 2022 01:59:11 -0700 (PDT)
Received: from localhost.localdomain ([240e:390:e65:5bb0:6169:3d99:b5ff:4a84])
        by smtp.gmail.com with ESMTPSA id c14-20020a62e80e000000b0050dc76281desm1026782pfi.184.2022.04.30.01.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 01:59:11 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v4 2/2] sched/deadline: Remove superfluous rq clock update in push_dl_task()
Date:   Sat, 30 Apr 2022 16:58:43 +0800
Message-Id: <20220430085843.62939-3-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220430085843.62939-1-jiahao.os@bytedance.com>
References: <20220430085843.62939-1-jiahao.os@bytedance.com>
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

The change to call update_rq_clock() before activate_task()
commit 840d719604b0 ("sched/deadline: Update rq_clock of later_rq
when pushing a task") is no longer needed since commit f4904815f97a
("sched/deadline: Fix double accounting of rq/running bw in push & pull")
removed the add_running_bw() before the activate_task().

So we remove some comments that are no longer needed and update
rq clock in activate_task().

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/sched/deadline.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b61281d10458..877f55f3a60e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2320,13 +2320,7 @@ static int push_dl_task(struct rq *rq)
 
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


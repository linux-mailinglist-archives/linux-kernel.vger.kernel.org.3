Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3788597C67
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243120AbiHRDp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242973AbiHRDpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:45:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D413594135
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:45:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z187so412094pfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=T9NjXKCirMmjalxT2TDdOclIHIt09Z9HaaeNsJZTPXw=;
        b=qE6DbIRbQ4pGOYMM7dQuG0ute6j4MLfn+kSU2L8olPgM9KcEPDsVwiKmJVC6kpvv8v
         p7VIzbkR9pYOUX+2uBUm3xWU3TEpz7o8+e0m2GCj8mPK8n2Prq8c3YiJewStyWBy7o7C
         ZaC5siCeTyy5vJYtAGdZpvy9/TdKemDwFty59NocSszDMomsa7ssbYMhA91G1CiGWVgh
         a+qHGjAqNHGKAYXK/Yqs8lsl8QzzFRIxDt5uYHhG/lda7oqEAlQO/Y4b5KWZAGyIstKG
         9Ub7hRiHV5hGFKzjwwOBqqPahV3b88sMNSeF1Q5mYL+y6p/wvO7smwUwFRMGJSh54fGy
         2oxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=T9NjXKCirMmjalxT2TDdOclIHIt09Z9HaaeNsJZTPXw=;
        b=H9aITPowGvGlmI1i0bhhqDyk8TgYIXamFxO7j2E1AkwS8GQ9euTP3oFaXzeYUbLlmg
         TBUTe8iNGZ+L62rkdK+Qmh1X/XgzJMfLGx1j1LT2eUT/6PUQAqEGgLPGFLIWSEawIb81
         aF0+Y2p2asm1llZJQa7Bk96QDHD5VGCtOBBan8WEo5OFrp0iCIpbCrtR517w8dmPXd2T
         CHDyD0aXQlCQ3RRMs9rfuojJScYoOFYQHW3T8sxbGEtYQWxSKRydRIdn9KlJ3lrbL0qq
         Mm1JXZvy1LlVOFF6Ql5F6UTR6kQw0LoITpBlAC6JXiOCe2GCDrTMf2G5yE5JC6tFAy9u
         CrvQ==
X-Gm-Message-State: ACgBeo3yFHTIjXhh3EDKD6WrUDoWhc5ilxvT2i4K4X8e6FhADkJbeOGe
        V+oGpbIDoYqLEQFMV0WkvaHS1g==
X-Google-Smtp-Source: AA6agR7FBHeX1XxF0Tmwrm8aBmDcSaAbYpuXymjV0tYaGcbiRAhsQeq38UhXnmRh2LL4yL7M/ypE2A==
X-Received: by 2002:a05:6a00:1a88:b0:52f:52df:ce57 with SMTP id e8-20020a056a001a8800b0052f52dfce57mr1140692pfv.71.1660794352409;
        Wed, 17 Aug 2022 20:45:52 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id m11-20020a65564b000000b00419acadde52sm268700pgs.46.2022.08.17.20.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 20:45:52 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 3/9] sched/fair: reset sched_avg last_update_time before set_task_rq()
Date:   Thu, 18 Aug 2022 11:43:37 +0800
Message-Id: <20220818034343.87625-4-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818034343.87625-1-zhouchengming@bytedance.com>
References: <20220818034343.87625-1-zhouchengming@bytedance.com>
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

set_task_rq() -> set_task_rq_fair() will try to synchronize the blocked
task's sched_avg when migrate, which is not needed for already detached
task.

task_change_group_fair() will detached the task sched_avg from prev cfs_rq
first, so reset sched_avg last_update_time before set_task_rq() to avoid that.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4b95599aa951..5a704109472a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11824,12 +11824,12 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 static void task_change_group_fair(struct task_struct *p)
 {
 	detach_task_cfs_rq(p);
-	set_task_rq(p, task_cpu(p));
 
 #ifdef CONFIG_SMP
 	/* Tell se's cfs_rq has been changed -- migrated */
 	p->se.avg.last_update_time = 0;
 #endif
+	set_task_rq(p, task_cpu(p));
 	attach_task_cfs_rq(p);
 }
 
-- 
2.37.2


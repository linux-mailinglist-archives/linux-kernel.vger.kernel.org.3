Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70818572C26
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiGMEFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiGMEFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:05:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F78D9E1B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:05:22 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 72so9432252pge.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+2tUbyN2xCwMNnYylDuWSr4Ej/rDbj2w3froYdg0Q9I=;
        b=P7qQ0aXggkw+HRGyGnwGQUN4Ud+8NUR/peIiuMfu02rzQ/bNWeltmRIUSWcFMiA9A6
         5j7PDwOHC4NsC59zdDPIVjsG/sbiyrLD+SqPbXHq7uBxr2UqFpJ3LNwl9z5CAkQY58bM
         0YftkC6HDJ9DRddF0ppbnBuNLLM8x+6+RqFIflRtvaTGKTnKCLIYgbe2B1Kp5Oxc3nwQ
         yEwsFxWizmNgvkFSMSC6lt9aOSlXGYZOg04nXP7ZDn/GS6/Fau8PZpo1K1aLJ672iRgJ
         UZrKwO/fH1qdVsitGLCulSpRWZWiaXjVJ10BdXUDmiuM0kC1WseG2SYVho/ZM/tBDLGg
         7k7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+2tUbyN2xCwMNnYylDuWSr4Ej/rDbj2w3froYdg0Q9I=;
        b=Y4kNSKxvO7/5toAZIjhAtt3QsYpws0IhDzKk7VUSOwQmcjWGlIOfOW7RfcDkci1G74
         5prvutcyR0Royk6FRAwJHy6NI36Zy1JjnhYqqgFVmK6DLKmsVT3XdGHydNawEXCyU+6s
         FoU5XsgTomszjrsdEHYhcAj+7OCv0/mXw9PYkpP6AWWl3og2IdLYGMVKhpTieuXk0SWN
         ddg4iYwR8zTbj6aNGcES6MAZKTVfcDJB3ZhVWcepwKf516T8QOc/NEqZeIMggtFtVhjR
         Xzq7+mhZXgT+a9u799F2sIFyemLzKFyEdgOlOlFZPu9fk1lP7AGrFJh+3qtQjZ4f6fHy
         uqfg==
X-Gm-Message-State: AJIora9eCSMuZ3kV15zI+sb6Is9G0oAI8SW9nx1G64gq8OB6VegPEei6
        VCriujKPUwS+MalMOXzK1C3Ymw==
X-Google-Smtp-Source: AGRyM1u6cXFHA6c24+Zt2sngu9RaumNXGT5FU4M2mMn5qYUeliCH0e7zSV4ly5ZeraCfygLbA09qqw==
X-Received: by 2002:a05:6a00:a1f:b0:525:3ad6:fb7e with SMTP id p31-20020a056a000a1f00b005253ad6fb7emr1208891pfh.68.1657685121712;
        Tue, 12 Jul 2022 21:05:21 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016bd16f8acbsm6858942plg.114.2022.07.12.21.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:05:21 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 09/10] sched/fair: stop load tracking when task switched_from_fair()
Date:   Wed, 13 Jul 2022 12:04:29 +0800
Message-Id: <20220713040430.25778-10-zhouchengming@bytedance.com>
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

The same reason as the previous commit, if we don't reset the
sched_avg last_update_time to 0, after a while in switched_to_fair():

switched_to_fair
  attach_task_cfs_rq
    attach_entity_cfs_rq
      update_load_avg
        __update_load_avg_se(now, cfs_rq, se)

The delta (now - sa->last_update_time) will wrongly contribute/decay
sched_avg depends on the task running/runnable status at that time.

This patch reset it's sched_avg last_update_time to 0, stop load
tracking for !fair task, later in switched_to_fair() ->
update_load_avg(), we can use its saved sched_avg.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 50f65a2ede32..576028f5a09e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11552,6 +11552,11 @@ static void attach_task_cfs_rq(struct task_struct *p)
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
 {
 	detach_task_cfs_rq(p);
+
+#ifdef CONFIG_SMP
+	/* Stop load tracking for !fair task */
+	p->se.avg.last_update_time = 0;
+#endif
 }
 
 static void switched_to_fair(struct rq *rq, struct task_struct *p)
-- 
2.36.1


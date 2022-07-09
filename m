Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A08856CA4A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 17:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiGIPQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 11:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiGIPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 11:15:51 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4004AD42
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 08:15:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s27so1254962pga.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r3mxdMtzYN4EG2h1+j1zeQY1fxjwsNicM4bDMcwOEsI=;
        b=7u0xD4mTqOLbBezgkWkuZtIRvBOqah++R4agGmLSbq+QuvxRnkEM15nWPvShqHXPBT
         NXQR1TJTEcVa3HYCFAWE4K65/6HCS0vDdKqXXZR1QhVwr3Q3cHujwPgg1h9MKVFkgv8Z
         Ry/Qg2qTfh3M6wP2x3hr3YhASxgQZNwUn4Fxb2ToWQCK/tcylUUhVAmh06CSN6CITDsL
         Le/O3eyZn3EFB9bsP1xaa3WTFKAf2NVN4+Lt5WsVdfMEZPmfFy2+kQCC5ZwPlAT/gves
         iFB3QfJXmNmOL/8HJkLK1BwISr6zRdUJXcOtlPEvp8YKsEgSGS9abdjmuJx6/+Otp+h8
         fRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r3mxdMtzYN4EG2h1+j1zeQY1fxjwsNicM4bDMcwOEsI=;
        b=WZd/4iy/5n3SjiZMr1YCjCwHVo+od1ixEHms7BgCi5X5BAAvDMrKDuzJj7KgG3CMd6
         6j6X7CHjM6cvEUriBU4DnLbHEAdxHoP2tyi706JQzx3ja4FDrT2Jwrh1PGEyrZNXKCQS
         sk+NsvA3Aiz88OntvyweWE1+hFy3An3pwgzz1/mSpeZeqIQQ19ODYhTYodlwFrsJIQq5
         pr1XKpeuefTDkmiJRiuqgHTekGNbYbQ/hC75UwTBvkm+FLk0sTZhhFCWKU9Oqdc8tcj6
         ei+EDZJHRUP3u/a3zf0kTH9c7ORZpUPexgn+3exaPyQyKpaDd3MaaogNbOTgosFFS+hR
         UkFw==
X-Gm-Message-State: AJIora+FVuamCSfKA3zph6KSuPJc48+jMNOToLzgpG2dL4mxwJ+LLdv/
        +YGSM/AmPPfii5OTXELZyz7wKA==
X-Google-Smtp-Source: AGRyM1u4ITSSIedQ0QLA9OhiYdi+G3XG/9XwxCU/ntryEEx2YnWFoXG+saoGBggSt2zY0XLwLiairA==
X-Received: by 2002:aa7:8186:0:b0:528:c344:ed6e with SMTP id g6-20020aa78186000000b00528c344ed6emr9281105pfi.35.1657379748820;
        Sat, 09 Jul 2022 08:15:48 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e63:e730:5493:aabd:e56d:65e6])
        by smtp.gmail.com with ESMTPSA id bo20-20020a17090b091400b001ef8d2f72fesm1295709pjb.45.2022.07.09.08.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:15:48 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 6/8] sched/fair: stop load tracking when task switched_from_fair()
Date:   Sat,  9 Jul 2022 23:13:51 +0800
Message-Id: <20220709151353.32883-7-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220709151353.32883-1-zhouchengming@bytedance.com>
References: <20220709151353.32883-1-zhouchengming@bytedance.com>
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
index 153a2c6c1069..ca714eedeec5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11563,6 +11563,11 @@ static void attach_task_cfs_rq(struct task_struct *p)
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


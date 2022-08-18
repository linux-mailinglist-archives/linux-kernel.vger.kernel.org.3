Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5570F598377
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244746AbiHRMsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244755AbiHRMsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:48:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84A52A718
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:30 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ch17-20020a17090af41100b001fa74771f61so5520635pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=T9NjXKCirMmjalxT2TDdOclIHIt09Z9HaaeNsJZTPXw=;
        b=lTOUDukXsvG/6rAvduxob2gKwGj+B639SQL6eLxF3eEcf0yx5heQIWGyLcA9Gq+/H/
         P43lhpJ0RO5NS7hDc9DKjef4RGuOISGA2c9S7w5Kpry1/XtYhD7nnXjyWzuhxAWIHcar
         q5zam4fFzlgvDkBG0kyLxRcO61TSkm4m/gPxip5MQ4YgTNLbXZFLYwZt8kNpzFx6PvdL
         yncd1gCyRwbTW0xHgC/uktt1IJSfDp4m1tC1IBCpaYemhf9Vx1H9usy9Q6mXFuyL35rX
         p80E4gDReRmMAGgqJhbQ3tUGt8k6waokN3gslH6VhAUzF3Zuvje11REHybrRjyHqKwC0
         1Ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=T9NjXKCirMmjalxT2TDdOclIHIt09Z9HaaeNsJZTPXw=;
        b=S76DdmQdRLPOv5AA4fLvf59NKhNwE2IUtKfsXHLap+cVAVxw4AOa7WDTUkSo55NCA2
         y3mYj6l8/aedlyULaUCmlNjuDdLSKOgAb8u8zPKmasLdxDDw4rDLduXAarZ04cSZn1Oq
         WXbUvMHwRbXR+nXc105DdiQjP+D3MtiCvWHfIu+gfNSHbS5bEUy0Fyh4coLU6pp4cDAK
         xQHjalc6hawLcR+hZ/KtuwdSvM+EZ2kGzDd261einX8pVjMlbZA211D85/Q8Z9stOXJc
         cAYu1jgR8+168+Uxv9K0wC5eK/nZgvmyNWxj3PV/gf8qjaiDE7DWnOySDPaoRRH4cEUQ
         UEqA==
X-Gm-Message-State: ACgBeo1OPv/W8QQQl6IT7J8D5DpJtnit483IoXYvrODVznWlVZKhG59a
        FGUtSNG1lrufa0hkbwCTOA3eUg==
X-Google-Smtp-Source: AA6agR6h8+4VINgdP6HSuwC/yqQ83xfHm/C0Lse34ove4ebilNZgFlymrKn7vwoCfQy/JIE5U11Euw==
X-Received: by 2002:a17:902:d503:b0:16f:1503:4815 with SMTP id b3-20020a170902d50300b0016f15034815mr2704563plg.17.1660826910475;
        Thu, 18 Aug 2022 05:48:30 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id c16-20020a621c10000000b0052f3a7bc29fsm1477449pfc.202.2022.08.18.05.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 05:48:30 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v6 3/9] sched/fair: reset sched_avg last_update_time before set_task_rq()
Date:   Thu, 18 Aug 2022 20:47:59 +0800
Message-Id: <20220818124805.601-4-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818124805.601-1-zhouchengming@bytedance.com>
References: <20220818124805.601-1-zhouchengming@bytedance.com>
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


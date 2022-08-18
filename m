Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BF3597C64
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243163AbiHRDqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243136AbiHRDqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:46:18 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC58956B5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:46:17 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m2so492431pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7cI2F3yXPonauMWsO3HcY8FVNQRGdZ4rG2wgR3FbNkc=;
        b=rmqR1dPNdfpW3nRVRnGjOLgNPZx5moCpN/Vj8TSCGNZu69GhYskWNPAVhe7fbzt1UM
         00idvx2FZjjuMtDQp1P1z4NZLmiHOc3uxK7+PW0/mBCcAtyhdzGV7ChIsbZLXHIMG8WO
         ypCoNEkhHjJZLEPRrXhXCWVMkT2E3H8wziWvEDgpoTHIM/dAfhZPhPKUajuefu1VVzSm
         4T9KFgGu0BfQTJK+eOGwWhLv/2KYcPIqkBIv+t+U+0RoPex4Fzh1mXLzY+bCsSVVLoCS
         tzx58VuLr4VOEmKrZAsU7o3lKssppqed4vBx6KX5GBYTE6dVg8T991CHXfq6TWun/hCz
         T+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7cI2F3yXPonauMWsO3HcY8FVNQRGdZ4rG2wgR3FbNkc=;
        b=UWUS+Kqf1DPLAKh5RLPsyUJziiFUTWL2RB/wIfz/zVPwEJDddHfNEq+L/DlgpdxRFk
         GNkj7Lit0GFMymYv9S0ZgUc091OvKbA4SJq/UKdHtWedKJnk7NzdwX5KYPvAH26Gb8vl
         pM/vQ5QUANCjQrOw3oGHuYQ5BOpij2HvaRPzHer+P4YQ2G3I8r4VilDtDERPskeIuOu/
         Fi0ZYFJKGYvUoQrw1Ea5+MugnQ/UrHg15kQzdNgQnPmxF2GAminsjvDjaZPT9YDowHH4
         viebHcoQt5vTLHzygkXCCo3/LEL0bYNaGtpIGWqodsUTwH3SpNA2myIWd4iSnarue5r+
         zkpw==
X-Gm-Message-State: ACgBeo2PajE7R7IO94bDIQ4Zq0zoXc0wsYaqXLYXITDrTVn8othWZ+68
        KconbeZ8vuj4wrkwr0zyej6/aw==
X-Google-Smtp-Source: AA6agR5raRrJtTp7ad5RUuJ5jzzsYPF7j/ZkwcYV5JTEdY4R5PF3Xw0+5tHcRevk5WvWfkGbHrDZ5Q==
X-Received: by 2002:a17:902:c94d:b0:16d:c10a:650e with SMTP id i13-20020a170902c94d00b0016dc10a650emr1174768pla.29.1660794377183;
        Wed, 17 Aug 2022 20:46:17 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id m11-20020a65564b000000b00419acadde52sm268700pgs.46.2022.08.17.20.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 20:46:16 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 9/9] sched/fair: don't init util/runnable_avg for !fair task
Date:   Thu, 18 Aug 2022 11:43:43 +0800
Message-Id: <20220818034343.87625-10-zhouchengming@bytedance.com>
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

post_init_entity_util_avg() init task util_avg according to the cpu util_avg
at the time of fork, which will decay when switched_to_fair() some time later,
we'd better to not set them at all in the case of !fair task.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aacf38a72714..235b59b9d75a 100644
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
2.37.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC41056CA4C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 17:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiGIPQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 11:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiGIPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 11:15:44 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA023F327
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 08:15:42 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id o18so1267338pgu.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyQhbFtrplLKMrzdaQSrG/fm24rVGc+yJtNT/T1DzNc=;
        b=vUbs5Li7MbwcOqpyEkG/FnGoWX2JzN203czND92oZYxEVQz7u9bC9qx1Zk3XF0ChWi
         ZKbG5FDGafzXsuRCYFtTebAiZD7AM/YBwFdhxneJyhUhD27cXrZOUMsqhBjtsuTuKCYR
         2sEqF47AB/iHAKjDgTggTonDsxoK1CCs/Wj6etV0IV3NyLfSXZz/8GIhgcjVlHZTbpgZ
         pE7mzGYuAuafKSdyqsq3CI5LjH8duqtPNWLvHXzu5IzCyUAfw9QTk5G6lM1U3AXsdYgR
         WkEDHH8lOCVM5+/Lkdu5R8ZQ98ZeDu3GDCFd9NhGGBwzSAYbnRBOEfBxpGYsFGnsbaRi
         5qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyQhbFtrplLKMrzdaQSrG/fm24rVGc+yJtNT/T1DzNc=;
        b=5sK+ux/vcZamusrfLdgAacupa6ByD4YFVj/NEQteEMkQ4teK1WMzD9pFQXDNtjaYS8
         nd2nOLgFL/si6czE7yDgsMn2r7oDgB7FKodzh2aOBGFSpSCUVd3yx/XtJk8ECVvAQMZI
         NmyHq3tAPgWb3skeUIK4EusKMQWpg7mcbnaS0hVH5wgOjoV9nLPookjxs12fRGxCDNZ0
         CQ/ZOx8onjFiRLblrm8u4JPre95BI9M+X4nLW8hL7lwhlnmzj78cbMUjt+C0m0yQLB1n
         9zd8tMDzZ4EM2g12BHwqt893VOWdiSCXwRDioNgPb+NmdWzu//KC7XmaM/Vdo8pdL3YX
         B5hQ==
X-Gm-Message-State: AJIora+RbXSMH8lIB69D2PevJCl/tsUqAPlcN0pwk8fgIgmTzPVSABa+
        0i8aiPJ4nucaahYDGNwI8XDYDw==
X-Google-Smtp-Source: AGRyM1sOZ7vtQ9fOG91CDTDbdC9PYAuK0ZtYEG+ptrERrujsAqOMWCVozwunq52AWOjNJLMoeinu5g==
X-Received: by 2002:a63:f14b:0:b0:412:6c21:f1ed with SMTP id o11-20020a63f14b000000b004126c21f1edmr8379398pgk.198.1657379742274;
        Sat, 09 Jul 2022 08:15:42 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e63:e730:5493:aabd:e56d:65e6])
        by smtp.gmail.com with ESMTPSA id bo20-20020a17090b091400b001ef8d2f72fesm1295709pjb.45.2022.07.09.08.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:15:42 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 5/8] sched/fair: fix load tracking for new forked !fair task
Date:   Sat,  9 Jul 2022 23:13:50 +0800
Message-Id: <20220709151353.32883-6-zhouchengming@bytedance.com>
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

New forked !fair task will set its sched_avg last_update_time to
the pelt_clock of cfs_rq, after a while in switched_to_fair():

switched_to_fair
  attach_task_cfs_rq
    attach_entity_cfs_rq
      update_load_avg
        __update_load_avg_se(now, cfs_rq, se)

the delta (now - sa->last_update_time) will contribute/decay sched_avg
depends on the task running/runnable status at that time.

This patch don't set sched_avg last_update_time of new forked !fair
task, leave it to 0. So later in update_load_avg(), we don't need to
contribute/decay the wrong delta (now - sa->last_update_time).

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 171bc22bc142..153a2c6c1069 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -849,22 +849,8 @@ void post_init_entity_util_avg(struct task_struct *p)
 
 	sa->runnable_avg = sa->util_avg;
 
-	if (p->sched_class != &fair_sched_class) {
-		/*
-		 * For !fair tasks do:
-		 *
-		update_cfs_rq_load_avg(now, cfs_rq);
-		attach_entity_load_avg(cfs_rq, se);
-		switched_from_fair(rq, p);
-		 *
-		 * such that the next switched_to_fair() has the
-		 * expected state.
-		 */
-		se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
-		return;
-	}
-
-	attach_entity_cfs_rq(se);
+	if (p->sched_class == &fair_sched_class)
+		attach_entity_cfs_rq(se);
 }
 
 #else /* !CONFIG_SMP */
-- 
2.36.1


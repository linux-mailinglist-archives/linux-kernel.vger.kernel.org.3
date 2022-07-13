Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A164E572C25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiGMEFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGMEFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:05:19 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB45CD9E34
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:05:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so1698878pjn.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKc5oxxSnwUEVTMGnUgWrj+YyCWOHtHYSRx6xfCDJcM=;
        b=WWivEGjL3hc7GWXCPy6ggOjPusMqq9kFr+B3NaWX98cjyuRLqCdjlIi2caIUISJoQO
         VHpV7b2x1ngMim3fSK04doD/Xxguvusa3KqO7r+QWUkUujjqtFweHgqYr8+qdWv+NxDs
         H3A/I3Nm+gjNK5fEF/0KtwttfVLUiiVgLSCvgdFHyZYjpv0kmP3hwQD3VpFQ6atwu6t0
         9PCXf0eG9ODsHX66+eq2bYmeejbFlOv9+a4YpfOlVg5mteIJf84jzy4jEMlvHHUMQDvW
         rK9z7j8+NWVxo91rLC0t6CE60yohzfvj8wGQ3EKZapuDvfGVQFiCtcERucjTi2GWg5XS
         UVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKc5oxxSnwUEVTMGnUgWrj+YyCWOHtHYSRx6xfCDJcM=;
        b=JMkhGrQP/QI6m6bHbe+WUU0Whk1JmARkasgTYh2MkmI6kUUwfcpZ+EwWHenl3fpgEI
         sJX/Tukme/C5ah1PQ5cRi1+JOMbg1DJeqmkZ96a67fikZCfPhxRzQgGT8N8uyrCUQzef
         lxTuCVq3slvn9JbDHI+euDHk/q5Fr5EWQpVmk7POJtJg8vr/3xtWnZqrnhS6sSlrHKFk
         egMzy5amKwNtRz+IKDlDWF9CW7C2QOgU2uLRQujCZ7Yt7w4HyVEP/aXUbkb+e2Vy7vF+
         IXK6NarWqUmn2EwnhDzA/JQFRDpfuhdso/oAQZ+X3H+l29BJqjCmjj7FyTLhnyFAAXgq
         WJog==
X-Gm-Message-State: AJIora8j96empMAHMuJVQAYRypyiosmc4c0ktUGnA0ix2835XeEqScHx
        bbATvaLVBTq15dehCbFlFF6uqw==
X-Google-Smtp-Source: AGRyM1tdM481aRAYI85nG1/rBJy4W0WtnyGZpw8n3/RDyXqboZeUoOjLyxgFkfnRyfI5s+trR7iGwA==
X-Received: by 2002:a17:902:cec2:b0:16c:3deb:a062 with SMTP id d2-20020a170902cec200b0016c3deba062mr1618135plg.136.1657685117961;
        Tue, 12 Jul 2022 21:05:17 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016bd16f8acbsm6858942plg.114.2022.07.12.21.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:05:17 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 08/10] sched/fair: fix load tracking for new forked !fair task
Date:   Wed, 13 Jul 2022 12:04:28 +0800
Message-Id: <20220713040430.25778-9-zhouchengming@bytedance.com>
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
index 51fc20c161a3..50f65a2ede32 100644
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13E94F9495
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiDHL4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiDHLzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:55:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780B2E5E34
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:53:45 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id s2so8180006pfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kdl4QXqXhnKygshp8ZcUE319jCG3NXsTZBDr9jERR9M=;
        b=SzLJjl7CWZJKh77B4MWkO9JqtpYiZRO4PQDZSk/42JdjzBus23rlMvSSyusmidzbQE
         YJBdwgFIFxyGb0h/GeUqN59CsK6zAVttFmCCgMp6yv5ncBJ+dcExF9O3qP6lp8BVNeR8
         rZ1VfdWmD62lAPM+l+5qaIrXPbGERiU5E4rRQCoNQthB+CMiVFl+Vh/GbWbn8VaYxwUX
         Fg4MupROcMUU2YzwgwGqI4Eo/cAOXCteHhcfxt7RjjizZH+LUonka1Bh759HY6DLnAMQ
         0YX+6hR6tSdlhN9Z3ODerobpJi5NaF5EIVban7JVyWqSPE1+CrWqJsVX+Qob4Py8Yw7t
         tiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kdl4QXqXhnKygshp8ZcUE319jCG3NXsTZBDr9jERR9M=;
        b=oA0hBa0TNEw0owFMVI6p+RiE6CO5bafEvaO8zrWcBGNTxIw15VSwiKwKYWe1FrfHZF
         1LjqK7KJ//P0CFU1KtCorRBQ2MKZLv0950yyU6RFCT8dpP3fKpisnpUnfXREb/0p4p2v
         xhKHwldLVrcO5E8rlb8BSB7hXalaRRy4p8uFXqCJjdxqwudnr/PiZZhLgp2UZEtYD/55
         AL52vWc0KP8nZcbHnNN84mZx/P7jndxmURo0NQYWhO6M7oITkT2QVfNYubncTds+NpAh
         2cSxYEsHwaTFagnDS3ZOPaI3jbRZPfHW8lnl38sXQO3DAqIgxj7PLIPliyOOqhZtVK1x
         FroA==
X-Gm-Message-State: AOAM533Qf3TxtSWbJ27fzSxoxM7va8rXOMob/2zm4hT1U7X4VW60Kfpa
        CttB1u0D+YNeUmK1m6znl7fAiQ==
X-Google-Smtp-Source: ABdhPJxH5pgFUBr+wY6Kh7RiSYy24mTAYqFOK+oI+et1czR31xb/93dTYm/4RKc/ZgpxlrKRFzUVOQ==
X-Received: by 2002:a05:6a00:e14:b0:4fe:3cdb:23f with SMTP id bq20-20020a056a000e1400b004fe3cdb023fmr19371062pfb.86.1649418824808;
        Fri, 08 Apr 2022 04:53:44 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6c:f010:a5e3:608e:7730:5b8e])
        by smtp.gmail.com with ESMTPSA id w123-20020a623081000000b005056a4d71e3sm5185409pfw.77.2022.04.08.04.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 04:53:43 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 1/2] sched/fair: Fix cfs_rq_clock_pelt() for throttled cfs_rq
Date:   Fri,  8 Apr 2022 19:53:08 +0800
Message-Id: <20220408115309.81603-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 23127296889f ("sched/fair: Update scale invariance of PELT")
change to use rq_clock_pelt() instead of rq_clock_task(), we should also
use rq_clock_pelt() for throttled_clock_task_time and throttled_clock_task
accounting to get correct cfs_rq_clock_pelt() of throttled cfs_rq. And
rename throttled_clock_task(_time) to be clock_pelt rather than clock_task.

Fixes: 23127296889f ("sched/fair: Update scale invariance of PELT")
Reviewed-by: Ben Segall <bsegall@google.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v2:
 - rename throttled_clock_task(_time) to be clock_pelt rather than
   clock_task, thanks Ben.
 - add Reviewed-by tags.
---
 kernel/sched/fair.c  | 8 ++++----
 kernel/sched/pelt.h  | 4 ++--
 kernel/sched/sched.h | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d67ab..dc73c3b500a5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4846,8 +4846,8 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 
 	cfs_rq->throttle_count--;
 	if (!cfs_rq->throttle_count) {
-		cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
-					     cfs_rq->throttled_clock_task;
+		cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
+					     cfs_rq->throttled_clock_pelt;
 
 		/* Add cfs_rq with load or one or more already running entities to the list */
 		if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
@@ -4864,7 +4864,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 
 	/* group is entering throttled state, stop time */
 	if (!cfs_rq->throttle_count) {
-		cfs_rq->throttled_clock_task = rq_clock_task(rq);
+		cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
 		list_del_leaf_cfs_rq(cfs_rq);
 	}
 	cfs_rq->throttle_count++;
@@ -5308,7 +5308,7 @@ static void sync_throttle(struct task_group *tg, int cpu)
 	pcfs_rq = tg->parent->cfs_rq[cpu];
 
 	cfs_rq->throttle_count = pcfs_rq->throttle_count;
-	cfs_rq->throttled_clock_task = rq_clock_task(cpu_rq(cpu));
+	cfs_rq->throttled_clock_pelt = rq_clock_pelt(cpu_rq(cpu));
 }
 
 /* conditionally throttle active cfs_rq's from put_prev_entity() */
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index c336f5f481bc..4ff2ed4f8fa1 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -145,9 +145,9 @@ static inline u64 rq_clock_pelt(struct rq *rq)
 static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
 	if (unlikely(cfs_rq->throttle_count))
-		return cfs_rq->throttled_clock_task - cfs_rq->throttled_clock_task_time;
+		return cfs_rq->throttled_clock_pelt - cfs_rq->throttled_clock_pelt_time;
 
-	return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_task_time;
+	return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_pelt_time;
 }
 #else
 static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 58263f90c559..762be73972bd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -603,8 +603,8 @@ struct cfs_rq {
 	s64			runtime_remaining;
 
 	u64			throttled_clock;
-	u64			throttled_clock_task;
-	u64			throttled_clock_task_time;
+	u64			throttled_clock_pelt;
+	u64			throttled_clock_pelt_time;
 	int			throttled;
 	int			throttle_count;
 	struct list_head	throttled_list;
-- 
2.35.1


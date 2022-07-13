Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F89572C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiGMEE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiGMEEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:04:53 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77225D64CC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:04:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q82so9378641pgq.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IZT91HMRNNtPd10faSgbS3j67ADoK0u+DYdIQS+mTiY=;
        b=S8C7w9KHiVRvT79rFyh7CVOkBN8zB7MCFm/ZNpvVfKlNfSX/VpN16Siks7am88MirZ
         gQhgRMCjWVQN/T/R5pSDIuxyARTYMlnzPEF2ZLxXjZRxpBHmceld/dT3kqeOEaSkXtoV
         Y25qN6pUNkQfEDKks1byU4/9EtLEf/KW6+x+BAsO4H7DgQ3aKB10LgsE3ab/bxEyjt/3
         hkgvmtmQc+tFB62SuR3qLxrpAXwx0iXxriR6I+UGxkPjydxUehcmM7oNbNSUiyTkMq6R
         i4r5OFHmdPUh+dlIbmYQS6JCYF5x0h4cLNn2j6aShrgEbiprC0IwID2+40dNcXEuIBX9
         gpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IZT91HMRNNtPd10faSgbS3j67ADoK0u+DYdIQS+mTiY=;
        b=7wDhYyQqAAzL7/0CJbRB1rzyuv74cFhk8VPiTecxcyE7xGju+oBZkAFSnZ3lMeVdYO
         2tchEzSwuokjOQankeaXhjH16I1CZvC5omaW6gAtGFvVcMkgqePthWeg0l79wGNP5G/B
         JMDHihry4t0cp4Gh1r+DhEXEwnfV9IwvGHABUCPPHy8a4mm9NBfOr0Mz4dvv9hEnX3MU
         uWywtRU6WnM7W3QKL/+A5rx12uDEKZ+JHUzlM6UE2JBlfB380WF/3963VVIDDygKGna2
         I9xA4GWXyWCcCcjLcrnIcJZTDobR2FLE/16YRlDrsg/Clf3+dkxNpRM+9jQOIaGVbgnF
         O22w==
X-Gm-Message-State: AJIora/V9RkGW0SXa0lV7NX5/vNU9SxhG1jgZbk3P6c33fPrJfgaD6nP
        nhNFZXju1jXR4vacBeXvuAnB9Q==
X-Google-Smtp-Source: AGRyM1sa+nvuWiefQNpEgLzEJt+hJzf3ZxcsE7DZE33zGPUd8m+1V1a09LxAEXSMMSioEyUrrVN/wA==
X-Received: by 2002:a63:c53:0:b0:412:6f28:7a87 with SMTP id 19-20020a630c53000000b004126f287a87mr1400964pgm.136.1657685090980;
        Tue, 12 Jul 2022 21:04:50 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016bd16f8acbsm6858942plg.114.2022.07.12.21.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:04:50 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 01/10] sched/fair: combine detach into dequeue when migrating task
Date:   Wed, 13 Jul 2022 12:04:21 +0800
Message-Id: <20220713040430.25778-2-zhouchengming@bytedance.com>
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

When we are migrating task out of the CPU, we can combine detach and
propagation into dequeue_entity() to save the detach_entity_cfs_rq()
in migrate_task_rq_fair().

This optimization is like combining DO_ATTACH in the enqueue_entity()
when migrating task to the CPU.

So we don't have to traverse the CFS tree extra time to do the
detach_entity_cfs_rq() -> propagate_entity_cfs_rq() call, which
wouldn't be called anymore with this patch's change.

detach_task()
  deactivate_task()
    dequeue_task_fair()
      for_each_sched_entity(se)
        dequeue_entity()
          update_load_avg() /* (1) */
            detach_entity_load_avg()

  set_task_cpu()
    migrate_task_rq_fair()
      detach_entity_cfs_rq() /* (2) */
        update_load_avg();
        detach_entity_load_avg();
        propagate_entity_cfs_rq();
          for_each_sched_entity()
            update_load_avg()

This patch save the detach_entity_cfs_rq() called in (2) by doing
the detach_entity_load_avg() for a CPU migrating task inside (1)
(the task being the first se in the loop)

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a78d2e3b9d49..0689b94ed70b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4003,6 +4003,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 #define UPDATE_TG	0x1
 #define SKIP_AGE_LOAD	0x2
 #define DO_ATTACH	0x4
+#define DO_DETACH	0x8
 
 /* Update task and its cfs_rq load average */
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
@@ -4020,7 +4021,14 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
 	decayed |= propagate_entity_load_avg(se);
 
-	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
+	if (flags & DO_DETACH) {
+		/*
+		 * DO_DETACH means we're here from dequeue_entity()
+		 * and we are migrating task out of the CPU.
+		 */
+		detach_entity_load_avg(cfs_rq, se);
+		update_tg_load_avg(cfs_rq);
+	} else if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
 
 		/*
 		 * DO_ATTACH means we're here from enqueue_entity().
@@ -4292,6 +4300,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 #define UPDATE_TG	0x0
 #define SKIP_AGE_LOAD	0x0
 #define DO_ATTACH	0x0
+#define DO_DETACH	0x0
 
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
@@ -4511,6 +4520,11 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 static void
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
+	int action = UPDATE_TG;
+
+	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
+		action |= DO_DETACH;
+
 	/*
 	 * Update run-time statistics of the 'current'.
 	 */
@@ -4524,7 +4538,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
 	 */
-	update_load_avg(cfs_rq, se, UPDATE_TG);
+	update_load_avg(cfs_rq, se, action);
 	se_update_runnable(se);
 
 	update_stats_dequeue_fair(cfs_rq, se, flags);
@@ -7076,8 +7090,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	return new_cpu;
 }
 
-static void detach_entity_cfs_rq(struct sched_entity *se);
-
 /*
  * Called immediately before a task is migrated to a new CPU; task_cpu(p) and
  * cfs_rq_of(p) references at time of call are still valid and identify the
@@ -7099,15 +7111,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
 	}
 
-	if (p->on_rq == TASK_ON_RQ_MIGRATING) {
-		/*
-		 * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
-		 * rq->lock and can modify state directly.
-		 */
-		lockdep_assert_rq_held(task_rq(p));
-		detach_entity_cfs_rq(se);
-
-	} else {
+	if (!task_on_rq_migrating(p)) {
 		remove_entity_load_avg(se);
 
 		/*
-- 
2.36.1


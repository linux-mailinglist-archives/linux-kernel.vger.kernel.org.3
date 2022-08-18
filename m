Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9360598373
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244774AbiHRMs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244736AbiHRMsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:48:41 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060D545061
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id k14so1470128pfh.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3GAWkeAWlGlQB12EQDsOtb30kGIL9nEjgqc5w218gmE=;
        b=O7YDg2VmxasAb1DQCpuyjpEk6JSlTzJsb19hs4ahJpS7uTTDV6ggic5GgKY2idsj4v
         OSdsUFMyu1JpDHkmJIjvy9khPOIdvqB/cz0PdqKK9i4k1OVEIJJ+gqe7rEH0y5V77gDw
         AKNwJRp5ROCRMNqGQZ9VXpCwZk2/f1L9vLWXCRYGAEhCWrnI1//SA+LzEaTO0X+XIHjs
         ajq872F0J2y+lH8w7EUZffQgkL4dq6ZQ4zmHDHFk4Ul5oPGC+hPYGPaRX6QO+CziJiB4
         d9/O13ogHhBg5LlXurBVFz8MUfGM1Z9exv23YwO6nT1UPswxsC+F1DXZe3U4YIXCx1Xr
         8CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3GAWkeAWlGlQB12EQDsOtb30kGIL9nEjgqc5w218gmE=;
        b=JOa1kW6ZJd6iosUUPL1OqNHa3dFrOjEjSvI92UU7PSV7Nq+EW/GFlqi6lx1TO0hI43
         QQs6wzsg+20rrHdOBWlQ3BElH4i+9azNoLLXjhnXqVIPGLq/JqI4+VxUN3mErvVtQuhP
         zQHWzcYIO4TT2ahOiIP88YCddd68VCbvzcnYklO2oEA5JFNK1rXnOozu3Ju4+6Eusvx5
         NmMPK8kixxmag8U+ZfW2bz+syU1r/m+78d+WASD2v3GO5MapEyM2b6pBmcYy6o8Vpg9j
         zH1B0TnMs8WSni2ZCrmu4eDes+MHjlPfjIW5RyvhNfc33Ph0PMtc2tewjzuy1sRhJzJV
         2xDw==
X-Gm-Message-State: ACgBeo3LHRIiCRfrQt5ZmNzWqv2gTAhM9x0UVENyjT53hmdfGUY06vKk
        sro47HxwiKmx+82t2ZPpl/ww4Q==
X-Google-Smtp-Source: AA6agR48J0rChbWVkjzEfrbmteqn64dE6NHwacBHrdrrnUfTBobL318LrBVkYwTDcHelm+2f4q/zYg==
X-Received: by 2002:a63:d70b:0:b0:415:f5f1:dd19 with SMTP id d11-20020a63d70b000000b00415f5f1dd19mr2310305pgg.273.1660826919498;
        Thu, 18 Aug 2022 05:48:39 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id c16-20020a621c10000000b0052f3a7bc29fsm1477449pfc.202.2022.08.18.05.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 05:48:39 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v6 5/9] sched/fair: combine detach into dequeue when migrating task
Date:   Thu, 18 Aug 2022 20:48:01 +0800
Message-Id: <20220818124805.601-6-zhouchengming@bytedance.com>
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

When we are migrating task out of the CPU, we can combine detach and
propagation into dequeue_entity() to save the detach_entity_cfs_rq()
in migrate_task_rq_fair().

This optimization is like combining DO_ATTACH in the enqueue_entity()
when migrating task to the CPU. So we don't have to traverse the CFS tree
extra time to do the detach_entity_cfs_rq() -> propagate_entity_cfs_rq(),
which wouldn't be called anymore with this patch's change.

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
 kernel/sched/fair.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 372e5f4a49a3..1eb3fb3d95c3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4167,6 +4167,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 #define UPDATE_TG	0x1
 #define SKIP_AGE_LOAD	0x2
 #define DO_ATTACH	0x4
+#define DO_DETACH	0x8
 
 /* Update task and its cfs_rq load average */
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
@@ -4196,6 +4197,13 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		attach_entity_load_avg(cfs_rq, se);
 		update_tg_load_avg(cfs_rq);
 
+	} else if (flags & DO_DETACH) {
+		/*
+		 * DO_DETACH means we're here from dequeue_entity()
+		 * and we are migrating task out of the CPU.
+		 */
+		detach_entity_load_avg(cfs_rq, se);
+		update_tg_load_avg(cfs_rq);
 	} else if (decayed) {
 		cfs_rq_util_change(cfs_rq, 0);
 
@@ -4456,6 +4464,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 #define UPDATE_TG	0x0
 #define SKIP_AGE_LOAD	0x0
 #define DO_ATTACH	0x0
+#define DO_DETACH	0x0
 
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
@@ -4676,6 +4685,11 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
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
@@ -4690,7 +4704,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
 	 */
-	update_load_avg(cfs_rq, se, UPDATE_TG);
+	update_load_avg(cfs_rq, se, action);
 	se_update_runnable(se);
 
 	update_stats_dequeue_fair(cfs_rq, se, flags);
@@ -7242,8 +7256,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	return new_cpu;
 }
 
-static void detach_entity_cfs_rq(struct sched_entity *se);
-
 /*
  * Called immediately before a task is migrated to a new CPU; task_cpu(p) and
  * cfs_rq_of(p) references at time of call are still valid and identify the
@@ -7265,15 +7277,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
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
2.37.2


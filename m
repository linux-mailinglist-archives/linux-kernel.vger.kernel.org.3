Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04117551DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243188AbiFTOVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244097AbiFTOV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:21:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF00147558
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:36:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so1146743pjj.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eCAoe29EBiPTzk/vFzOmNSRY5Vl8DK3KBtOJG6UlV8E=;
        b=Pg5a7m6s0vjD/nJh3llC1zxSPB8Xv6mHgQSbWFb8ZK/WRfgNwo7nQPiMGrTwZZuIKc
         kPHkRdg/v9ZCJbqJz3Ga8/RakxCTpPITohVH4b0cJCx29lQNmAJyFHttNjOLIaZhhRtV
         WhVmD5rHbiN0K6anskQRr/lNDt8uWyex+/y2d9CqIlsfaXNhsY2SiOLKKRbZwCtblRgu
         1gBfZ0RmARgpSpeoLiyRR2/6YIkMkO8eJcr/mEYln5tIlr8WOly6kYRgJtbkxd3aRxEt
         y1b7/pS4JKI01EEGPmmYFYiJVHrKVosvu94bhwWvIiOh2FmvYqteGEkn0hMjjIDo2foZ
         ii2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eCAoe29EBiPTzk/vFzOmNSRY5Vl8DK3KBtOJG6UlV8E=;
        b=n/YrnQ6E1hVdyy7SUklIJ0nBNLQ8bMm73qdnKTLV9syq23JCztBjstrAae7wIsV1UE
         bptyVcZb+MmX2NnuEdpT4BPnMBsLh7CcbPHRu7dMbEMTX1sUft6K+pypdeVT1Az6p4fa
         AbvdqMK5r8PqugAg6YyLFwS2tFKzX9V/gSXrNRFAkZWebV+yF7Gen0a/o3D2pGd9pmWG
         7kyDqVhkhX7I35pDjeLQYp84594JOD+VBw/XL0+IuECW+KtrxJHrR0ZqDrKtnsj02Uas
         jbgEuG+PHU7JLy/00RccF5v3jkRBs9XYq80q0roj3Ji+GVHvo87aA8xJPkxx1Xe6oBYu
         yqUQ==
X-Gm-Message-State: AJIora/r3gQTN6jHG+RTHdnyrl1E+AKhr9ShpoqrcpnBeooSbNiA7xTl
        o26EtS3bKzuIUGoYPw8Q0Q+iVg==
X-Google-Smtp-Source: AGRyM1v8ZRd50pfl7nEp+lJ0xPCuaLT2ShZFVp7wPmDSba5Evq+z3TUkj1HA3zSf/BK3RLaB2KybZg==
X-Received: by 2002:a17:902:eccf:b0:168:faa0:4eed with SMTP id a15-20020a170902eccf00b00168faa04eedmr23623736plh.139.1655732175685;
        Mon, 20 Jun 2022 06:36:15 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id c11-20020aa7952b000000b0052521fd273fsm2363893pfp.218.2022.06.20.06.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 06:36:15 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4] sched/fair: combine detach into dequeue when migrating task
Date:   Mon, 20 Jun 2022 21:36:08 +0800
Message-Id: <20220620133608.78498-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
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
-> propagate_entity_cfs_rq() call in detach_entity_cfs_rq() in
migrate_task_rq_fair().

This optimization is like combining DO_ATTACH in the enqueue_entity()
when migrating task to the CPU.

So we don't have to traverse the CFS tree extra time to do the
detach_entity_cfs_rq() -> propagate_entity_cfs_rq() call, which
wouldn't be called anymore with this patch's change.

Copied from Dietmar's much clearer comment:

detach_task()
  deactivate_task()
    dequeue_task_fair()
      for_each_sched_entity(se)
        dequeue_entity()
          update_load_avg() /* (1) */

  set_task_cpu()
    migrate_task_rq_fair()
      /* called detach_entity_cfs_rq() before the patch (2) */

This patch save the propagate_entity_cfs_rq(&p->se) call from (2)
by doing the detach_entity_load_avg(), update_tg_load_avg() for
a migrating task inside (1) (the task being the first se in the loop)

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v4:
 - change the commit message a little.
 - remove the forward declaration of detach_entity_cfs_rq()
 - remove verbose comments in code.

v3:
 - change to use task_on_rq_migrating() and put Dietmar's much clearer
   description in the commit message. Thanks!

v2:
 - fix !CONFIG_SMP build error
---
 kernel/sched/fair.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8bed75757e65..31d53c11e244 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3931,6 +3931,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 #define UPDATE_TG	0x1
 #define SKIP_AGE_LOAD	0x2
 #define DO_ATTACH	0x4
+#define DO_DETACH	0x8
 
 /* Update task and its cfs_rq load average */
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
@@ -3948,7 +3949,14 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
@@ -4241,6 +4249,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 #define UPDATE_TG	0x0
 #define SKIP_AGE_LOAD	0x0
 #define DO_ATTACH	0x0
+#define DO_DETACH	0x0
 
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
@@ -4460,6 +4469,11 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
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
@@ -4473,7 +4487,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
 	 */
-	update_load_avg(cfs_rq, se, UPDATE_TG);
+	update_load_avg(cfs_rq, se, action);
 	se_update_runnable(se);
 
 	update_stats_dequeue_fair(cfs_rq, se, flags);
@@ -6938,8 +6952,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	return new_cpu;
 }
 
-static void detach_entity_cfs_rq(struct sched_entity *se);
-
 /*
  * Called immediately before a task is migrated to a new CPU; task_cpu(p) and
  * cfs_rq_of(p) references at time of call are still valid and identify the
@@ -6973,15 +6985,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 		se->vruntime -= min_vruntime;
 	}
 
-	if (p->on_rq == TASK_ON_RQ_MIGRATING) {
-		/*
-		 * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
-		 * rq->lock and can modify state directly.
-		 */
-		lockdep_assert_rq_held(task_rq(p));
-		detach_entity_cfs_rq(&p->se);
-
-	} else {
+	if (!task_on_rq_migrating(p)) {
 		/*
 		 * We are supposed to update the task to "current" time, then
 		 * its up to date and ready to go to new CPU/cfs_rq. But we
-- 
2.36.1


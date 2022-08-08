Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BA358C8DA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243125AbiHHM6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243044AbiHHM62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:58:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324B6DF6C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:58:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gj1so8748840pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qdtwmrd3K+yo5ke7Mzb2tAO/7l7k81YO75qxr88Biq8=;
        b=FVmambr2q0CvkJzOrF5RbNJcyYhfHt7Db55rK895lJJ+t9IcjSQo5hVssX5K3NEYOR
         KP/ayg5VykPzjYcI4F0ks1v3WXNSJXdY8nfOsmcNOTWz0IJt2vb7ZnZFyP3eriL+xYe5
         abVtTevaL5oHvwshONjEjxR3YHivCKx46HoI1ik9IOV9Lt7f5dbqh6hW7OjQPUXYch3m
         Ztcu50/jzx1+QKJHHtNJ2l02G11KhOa0IPmlGD8vjQODVmTHzqIrDTrMxt68/K77kCpH
         e+qKsmSsJwH50ZludEd8mWhs7EMMpEYYGTlu5LpHX/MNHenNT9WBfkTyC2h0nqKesL+w
         QLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qdtwmrd3K+yo5ke7Mzb2tAO/7l7k81YO75qxr88Biq8=;
        b=yzhTpx4a9E5xztP1f1yhHVX5+rrr3ZQe9jIuS4pEuDLyNhLU4Eo1aCRwcBxw7sKRta
         or0W+kWCW/fem97J5DamCU8T8gmulB60auyOUZ2rvC2RUeZfdCJsgn4XVGfOWX87WkL1
         +IhqN105VsU7Lgs8ZRF6qh9kYjHEifTjsJ5YrD5o8KHmHsVJ4GFH9IKckWo/N1RRiLPK
         TLrDxMIGfaqq7S5gi1UDhHZhEkU1oP9Zqtp+5Abpo7aUzuXbVJc3U769XlTNs7Cvz2G1
         SO1m6RpxMIjjpEg8xxilF6H9uN4jis43mhA6HIHst8Ag8kemVmUNDFgdPzStsgtPD9rH
         MIhA==
X-Gm-Message-State: ACgBeo3w4uoSTHUosZEFZ+XN1ch6DFPYeTvLEdV3At+myPfE7MeVrkwU
        xCmNAXr0nNpErTJelcnqj45/6A==
X-Google-Smtp-Source: AA6agR4InW6AC+NUJ45iMNAeRFFnyoSy/+jreyY9wxGVYlGRG2GsZdbCmiMzi837E4ontTkS6KLmlQ==
X-Received: by 2002:a17:90a:7885:b0:1f2:1825:ae7e with SMTP id x5-20020a17090a788500b001f21825ae7emr20375010pjk.39.1659963502778;
        Mon, 08 Aug 2022 05:58:22 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090ae28e00b001f4ebd47ae7sm8057722pjz.54.2022.08.08.05.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:58:22 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 5/9] sched/fair: combine detach into dequeue when migrating task
Date:   Mon,  8 Aug 2022 20:57:41 +0800
Message-Id: <20220808125745.22566-6-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808125745.22566-1-zhouchengming@bytedance.com>
References: <20220808125745.22566-1-zhouchengming@bytedance.com>
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
index 52de8302b336..f52e7dc7f22d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4003,6 +4003,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 #define UPDATE_TG	0x1
 #define SKIP_AGE_LOAD	0x2
 #define DO_ATTACH	0x4
+#define DO_DETACH	0x8
 
 /* Update task and its cfs_rq load average */
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
@@ -4032,6 +4033,13 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
 
@@ -4292,6 +4300,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 #define UPDATE_TG	0x0
 #define SKIP_AGE_LOAD	0x0
 #define DO_ATTACH	0x0
+#define DO_DETACH	0x0
 
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
@@ -4512,6 +4521,11 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
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
@@ -4526,7 +4540,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
 	 */
-	update_load_avg(cfs_rq, se, UPDATE_TG);
+	update_load_avg(cfs_rq, se, action);
 	se_update_runnable(se);
 
 	update_stats_dequeue_fair(cfs_rq, se, flags);
@@ -7078,8 +7092,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	return new_cpu;
 }
 
-static void detach_entity_cfs_rq(struct sched_entity *se);
-
 /*
  * Called immediately before a task is migrated to a new CPU; task_cpu(p) and
  * cfs_rq_of(p) references at time of call are still valid and identify the
@@ -7101,15 +7113,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
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


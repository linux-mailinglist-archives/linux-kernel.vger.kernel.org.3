Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1C3586386
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbiHAE2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbiHAE2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:28:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5943DFD1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:20 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s206so8697358pgs.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wEr/YAo8Ety4XQg4L8nCVzG/mDAKtkMhP0Ioite8Q7A=;
        b=XeSrugbfI6aj60VUwq5iG9EJ82tjnNEdsgnUqDJs7DYGkzhraMvOD/HQwnD8utZyyZ
         UONKm86ENSbC8Y70Y6vIhBuWpYTNlQUHup/hhxc5NPl5wnyyLmHYrcykEtFsrg9C4A5O
         T00t4t6wlH13+z9q7+56lF8D+jaJ0k7d9Ez3EUtr5LblKKaa2ZKTwI7tKzP7950fvZpb
         CpFPD2vJeFEjnpfmqbqJ+wQaY2bJ3B7lzW1dgNJ87hq/EajLRCmJ9ssUvIUU4swGQQw+
         t3corhQfkEBxS/RhKW+eJmJRsqq5QZYL7ihm97RYrbDUx3l+hCx67mudAe8AOl5lTOqe
         T/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEr/YAo8Ety4XQg4L8nCVzG/mDAKtkMhP0Ioite8Q7A=;
        b=Z5d8HfBcnmldac7g474n0FWJ6t9bLy+uOaE9iGrUtQKtneaUqta6b4Y5XVLvQGTc9M
         2IHHC9uf99SfU/ptuDfsxANaW/cm9HxQaMI29H4rgWPdYIqsirsrDKEwYB95WeTm2APK
         gF8U16gzt6s6mm6IfeO90P3DzDanKuAiFuIY2S80p8aOI0OGRRSaGN8al41SCQcoXMUG
         xtJi+nrgA9wawIVg0DNw6OizJ03N+za3sRXElFGqJVid2H6OWHmAfiQZ9yphQgoVSL3A
         kxl5pNpao4JZkdMfW5zpLSf09Q6jnteKC8+EpHI9nr+JW0xhAasnjAM+os3+lxDNoaAP
         thUA==
X-Gm-Message-State: AJIora/2TBoxOuWvlqSxtop0czWqv7e2eraUQ3M43U5zGPjVRN18mr/3
        Qdd/jby/HqMFIoao1kjjNKHTeA==
X-Google-Smtp-Source: AGRyM1sTksTYMLANJ9c9Sx+2lC3dOIYFdAde2PUFP39zo101buENMk9SQnevPmmhdmsgrw2jsKqSEQ==
X-Received: by 2002:a63:4503:0:b0:419:7b8c:cb11 with SMTP id s3-20020a634503000000b004197b8ccb11mr11771437pga.446.1659328100430;
        Sun, 31 Jul 2022 21:28:20 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id ot10-20020a17090b3b4a00b001f326ead012sm7012202pjb.37.2022.07.31.21.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 21:28:20 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 05/10] sched/fair: combine detach into dequeue when migrating task
Date:   Mon,  1 Aug 2022 12:27:40 +0800
Message-Id: <20220801042745.7794-6-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801042745.7794-1-zhouchengming@bytedance.com>
References: <20220801042745.7794-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 kernel/sched/fair.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 956aed56ac1e..ba8b937854b4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4003,6 +4003,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 #define UPDATE_TG	0x1
 #define SKIP_AGE_LOAD	0x2
 #define DO_ATTACH	0x4
+#define DO_DETACH	0x8
 
 /* Update task and its cfs_rq load average */
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
@@ -4031,7 +4032,13 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		 */
 		attach_entity_load_avg(cfs_rq, se);
 		update_tg_load_avg(cfs_rq);
-
+	} else if (flags & DO_DETACH) {
+		/*
+		 * DO_DETACH means we're here from dequeue_entity()
+		 * and we are migrating task out of the CPU.
+		 */
+		detach_entity_load_avg(cfs_rq, se);
+		update_tg_load_avg(cfs_rq);
 	} else if (decayed) {
 		cfs_rq_util_change(cfs_rq, 0);
 
@@ -4292,6 +4299,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 #define UPDATE_TG	0x0
 #define SKIP_AGE_LOAD	0x0
 #define DO_ATTACH	0x0
+#define DO_DETACH	0x0
 
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
@@ -4512,6 +4520,11 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
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
@@ -4526,7 +4539,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
 	 */
-	update_load_avg(cfs_rq, se, UPDATE_TG);
+	update_load_avg(cfs_rq, se, action);
 	se_update_runnable(se);
 
 	update_stats_dequeue_fair(cfs_rq, se, flags);
@@ -7081,8 +7094,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	return new_cpu;
 }
 
-static void detach_entity_cfs_rq(struct sched_entity *se);
-
 /*
  * Called immediately before a task is migrated to a new CPU; task_cpu(p) and
  * cfs_rq_of(p) references at time of call are still valid and identify the
@@ -7104,15 +7115,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
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


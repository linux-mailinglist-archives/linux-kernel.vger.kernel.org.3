Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9C656CA47
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 17:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGIPPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 11:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiGIPPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 11:15:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AAD326C9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 08:15:20 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so4494813pjn.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 08:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IZT91HMRNNtPd10faSgbS3j67ADoK0u+DYdIQS+mTiY=;
        b=pR8HidnzAjT3a8n+geJywPAeXSIBe/KfkoyaAJoQcWrNvVWGI9oI/0tRm7V6x7sRhE
         h68GX0ZLVSNYqeG0QVdRDCSuLbUhbzPRlCpXzbQr/v32IUEMHzRPsxW3EDBxqjeQsbm8
         fq1ikyte92bthqlhFKlNQtTCQmBPWWVxuoMCYN/kzuuUSaWjR72DlIy6y4TPuTIBgWgw
         18CwI6NY+3r9CopD/GWWeb7qBvrj/Gw+vy0VGTLr1qXNjblEkbKfpcjAPmlI+pB4z+1j
         Xz+RfcqJHGqa+bIg/jKGG2d66dacY35DvmN0KvKDL7jklg01Od1VrYQFX/CpAJS1BOjW
         PCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IZT91HMRNNtPd10faSgbS3j67ADoK0u+DYdIQS+mTiY=;
        b=vFPCrq95dQuNTGsd+gDI+4oceVjBPnM2I1JuaFJDpgjTcHcbbD4h3OhGp4Yg3kZzdG
         xl1ZiodfXxaI/iin+K8d9AICChuWkMAs83pZyn9d1RaMEd3Atln8bTzE3RKyd5plVO7D
         ivRQpDH3LpatnB2YyRVladca1dWVU8FJx10H1dWd0Ma3rv8vZQG2WJTVohy4qlAHlVOx
         hfxohUVIBAbIIvrZbBv6WCgjA+ppJR5WO5g/D6/irklcdzuo6+2V2f6hyBjKp3PhFGEm
         /Jb9d6J5+UFa29tPWc5DnwO9kkB8a5hKjZrgsfv5i3/fJ6wPqrA3KTfbS0P2fkrvV6Q0
         fyew==
X-Gm-Message-State: AJIora/7CoTZsMJxhUR5FtEeV3/w0VSVcRzWxog4n5m/A6j5l3gMqgrd
        85BIIkOCDyVTQOxrN11gDlLRdQ==
X-Google-Smtp-Source: AGRyM1swfGvYFgVFmPaq+46N7eBvo4NdhDZosSD4HyLFgqcT1blLZz/ZLuqU9i0kZmRkEFrjgcDJOw==
X-Received: by 2002:a17:90a:d195:b0:1ef:b15e:8cb5 with SMTP id fu21-20020a17090ad19500b001efb15e8cb5mr6514559pjb.228.1657379719774;
        Sat, 09 Jul 2022 08:15:19 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e63:e730:5493:aabd:e56d:65e6])
        by smtp.gmail.com with ESMTPSA id bo20-20020a17090b091400b001ef8d2f72fesm1295709pjb.45.2022.07.09.08.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:15:19 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 1/8] sched/fair: combine detach into dequeue when migrating task
Date:   Sat,  9 Jul 2022 23:13:46 +0800
Message-Id: <20220709151353.32883-2-zhouchengming@bytedance.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C869455F306
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiF2B64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiF2B6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:58:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9B21F607
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:58:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id t21so13686229pfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l2cjPj2rGQYi4IE2tVl3hOTOPJB5V96R0meZ4b9cHtY=;
        b=q6v56ze5/ph7rfOuScMbsXs4S2SoZHwR7bh2WYvbZEC4a3gm1agQiwIpGjf3UbOhPc
         CMMDKc/wAnSRbVye633p7+ZrOK1RknUTdV28iRiWMV/xNnkWdhGF6nwT2W9Y3zN3VM39
         37meV/f0e4GbWWKqX4DayXOQaUhFWRDExPb/3nnxnJfDBAIXCdupnouyl2bsUCCqjegV
         ASZPZQQaUmAp0NQMZgwe8z+NgcAPeL6Be/Dv8FMtSSUCcLDPkcS87IZF7HUFn2oHR9pb
         RmEDmmerhjfj7ozsMLHwc3y1QTT450m9iHt+W76pvdWEVbuIhPT0kp1Agd71pmGbC0vm
         Oyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l2cjPj2rGQYi4IE2tVl3hOTOPJB5V96R0meZ4b9cHtY=;
        b=2b/eEnqPn3Lhy+e5m19nz3i9VFWNaCVLitRylDa+/10ADQkIZNRvCEZU2eh42/UvDw
         p8cMdS92dsRQUK3wqysaTQdKVaUPVnKcC9Tt33v7EmtNlIRisSAsDoRmnl9Sd7BF3P6G
         WCRecOxFv5v3OJdr2mEZNlcXcWXB9N9id+KHs/e/TaJTPHKZ2kdAXLhPUyVlGa+635uX
         0pB2/IasGEqdrkVucrZYsO/+C4fo/gBRYG/nQ+iLat7hkXcrAFhVVDKOjUmYpjgormJ+
         JqcHe30eUbk2dMsa2sBCxcVfFSYU1G+AhD6EfGDe+1CbXwIDqXODfC7+2yfRF0ZzuNnj
         C1kw==
X-Gm-Message-State: AJIora/UL3m+6aqTaFTBXHbVvMThEFRcPbIYIy7AmYRDiy3497KgpPK6
        k0wO6ZyZqhWHh86n3Rws1dwAKw==
X-Google-Smtp-Source: AGRyM1vMw39HmKM14XX+Qo7MOVdGShw02oI13NchFH/A/DNJlm+gFcsXirL/oKAKqzvzQUfrAIWcdA==
X-Received: by 2002:a63:f24d:0:b0:40d:ed5f:1729 with SMTP id d13-20020a63f24d000000b0040ded5f1729mr861219pgk.338.1656467929749;
        Tue, 28 Jun 2022 18:58:49 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id f5-20020aa79d85000000b005187431876fsm10135114pfq.180.2022.06.28.18.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 18:58:49 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5] sched/fair: combine detach into dequeue when migrating task
Date:   Wed, 29 Jun 2022 09:58:34 +0800
Message-Id: <20220629015834.98407-1-zhouchengming@bytedance.com>
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

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v5:
 - improve the commit message suggested by Vincent.

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


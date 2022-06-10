Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235CE546541
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243227AbiFJLNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344921AbiFJLNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:13:40 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ACB6348
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:13:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x4so15021410pfj.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LVa3XUxgHKX1MSYbB7p045eDLlQ/+b7ejFaAsKdJpTI=;
        b=74AR0ovxnSvd6fosuLJuwY3kqMZo9hWdh1O4YoRW1DEWfeXFDHHOvXoEm2aVzE9VjY
         RgPYUU/X/Dz+4Jhpack8ClrtgEUEWfaZyb90s2HhlYgJLrTySaz81e+ga3cCI3imWVhV
         lOeuDfnr3TocYUOK4C2SH7ipMTFqgay1yPEwKCcCPZudz9HJBD9lJtiOqjDvA8iyN/6L
         CXHgbJkQId1SHrQPn2/kDaH54o1vXu0caRLgGWq4/ogMoNW6tDdpbEw9ns9G/o4PopIn
         a1ADbAgJQ3kTZ2o3cl/9Sa8sClks5qtoJm4iZXxh7HdvOoHajsSOuHNhXlrBTyCOPbdh
         N2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LVa3XUxgHKX1MSYbB7p045eDLlQ/+b7ejFaAsKdJpTI=;
        b=BQuzfprryAkSVVUV2lsiuGEEMQDJh5bFYSTFKVsM3JXGunnftyIixPhDwgbRw1ecJm
         nJ7Xmukw7Px2dOI3svJIVWyHpnr8nccwaMXm8CEZUbgVCFs4PiYe+2MLc2iNMjjO0Ys7
         apD1bjz8uBLiTMIEbiQck86NrSYF9sFIbraZwtVz1o5sAVyFVOyQCPgJqiNEJupIQP9Q
         ucqD8TgqC6cSWWs8uRYPsOKsWAoDipclwOGlzj9oOmwg3Bg64C+zDOnT050VqhdygI9L
         1rLzqVDkAU+l0lnVoUmDdGIKHhL5hqvIaAdHEBiaMuJQp//cZYpsCvxjgSPY1SMoNfOh
         oh7Q==
X-Gm-Message-State: AOAM531uuTJwkyAW4Wu/1p987wQxJX2ug/5NEPRAZmxDs4wUyohcqQeT
        fOee6VVXIaeoj4JMXvHpEiZaXw==
X-Google-Smtp-Source: ABdhPJxez3dVgnFFd0Ik5qQAg2OYJnHt4X42odo1jVXM0qHZ5s0lzGsHPZgMW932by+VVOKRzqM5VQ==
X-Received: by 2002:a63:6cb:0:b0:403:af21:972e with SMTP id 194-20020a6306cb000000b00403af21972emr2140137pgg.90.1654859616039;
        Fri, 10 Jun 2022 04:13:36 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id g126-20020a625284000000b0050dc76281e0sm19190862pfb.186.2022.06.10.04.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 04:13:35 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3] sched/fair: combine detach into dequeue when migrating task
Date:   Fri, 10 Jun 2022 19:13:27 +0800
Message-Id: <20220610111327.47925-1-zhouchengming@bytedance.com>
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

When we are migrating task out of the CPU, we can combine detach
into dequeue_entity() to save the independent detach_entity_cfs_rq()
in migrate_task_rq_fair().

This optimization is like combining DO_ATTACH in the enqueue_entity()
when migrating task to the CPU.

So we don't have to traverse the CFS tree twice to do the
detach_entity_cfs_rq() -> propagate_entity_cfs_rq() call, this one
wouldn't be called anymore with this patch's change.

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
v3:
 - change to use task_on_rq_migrating() and put Dietmar's much clearer
   description in the commit message. Thanks!

v2:
 - fix !CONFIG_SMP build error
---
 kernel/sched/fair.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e0cd4052e32f..db85c3c2415a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3896,6 +3896,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 #define UPDATE_TG	0x1
 #define SKIP_AGE_LOAD	0x2
 #define DO_ATTACH	0x4
+#define DO_DETACH	0x8
 
 /* Update task and its cfs_rq load average */
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
@@ -3913,7 +3914,14 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
@@ -4206,6 +4214,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 #define UPDATE_TG	0x0
 #define SKIP_AGE_LOAD	0x0
 #define DO_ATTACH	0x0
+#define DO_DETACH	0x0
 
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
@@ -4426,6 +4435,14 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 static void
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
+	int action = UPDATE_TG;
+
+	/*
+	 * If we are migrating task from the CPU, detach load_avg when dequeue.
+	 */
+	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
+		action |= DO_DETACH;
+
 	/*
 	 * Update run-time statistics of the 'current'.
 	 */
@@ -4440,7 +4457,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
 	 */
-	update_load_avg(cfs_rq, se, UPDATE_TG);
+	update_load_avg(cfs_rq, se, action);
 	se_update_runnable(se);
 
 	update_stats_dequeue_fair(cfs_rq, se, flags);
@@ -6940,15 +6957,10 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
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
+	/*
+	 * In case of TASK_ON_RQ_MIGRATING we already detach in dequeue_entity.
+	 */
+	if (!task_on_rq_migrating(p)) {
 		/*
 		 * We are supposed to update the task to "current" time, then
 		 * its up to date and ready to go to new CPU/cfs_rq. But we
-- 
2.36.1


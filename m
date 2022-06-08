Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD2A54242A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbiFHGBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 02:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348355AbiFHF6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:58:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4AA23F230
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 21:26:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so17264669pjt.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 21:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MG06AiedEDpBT2ELwumy/meoTwkYbia36HrYS8TF6uo=;
        b=RRzuKyw+GsxX729knO443eK1Cb/n1vec65Mt6DNmQgk08vY02SwL3T047DqjeR+sqQ
         E0kuPTBKwvIogPYc7wepPiLUU7am5myRKp9wli/oFPlrxhd0vR2ZjoH5jjjf2FY5rPTO
         z0VxhfSu4uqPWsrg4Xkanxpn/DgwZJk+kUzb2Cmxp4+2p3vuYamZVsstThpw3XwIEyx1
         wFfo0EEWjrUs/woL3zYNwt+aRyFLxj6ZV2j+qvtzu2xRVopNr+tLNkc3+Mw6VEPw9IMF
         jNZYf7XpZdgTHb1XAa7tGiHFtIw4AD09hIRZJj/cdedBNeuxUS5E6Ar8pgAXMXS4NWLi
         ZHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MG06AiedEDpBT2ELwumy/meoTwkYbia36HrYS8TF6uo=;
        b=4CXMqxUB7frPhNuC0a+OAPyg82yyOI2XkDEgMQVUk84TitxcVFaG90wVJlgIItGdbx
         NQ6liHYTZ66aUDWBTTjyZl7+gaPfKYsAq1YeaIYt067Z7+nYmqqHvmMm6hN39aGKE/BH
         B3l3cX8I1ovUZ7MB1N7c/XUsLXJ3VsQRg3h7zmTwS0Ri/4P2RnizEEaSCZJcu8TXIGeg
         qGSJ5j6Tu1UqcLxK4lNBi70H60uMkZT5r48x78Tw92qtUTq0jhhdXUUWrC0lqkP61rMw
         cBECIKI0gDp61+1NiFFIYUgem6rGsgfO6GO+yVGA3z7IseQgJLLdk2lcKck63adD70au
         dWhQ==
X-Gm-Message-State: AOAM532QR2mRM5uDi7yLxBQhwQfUx9/QOI2VpwoWn0w86YPv4254V62a
        aFgFrvWmvB88lnUk0HxVHf884w==
X-Google-Smtp-Source: ABdhPJxhenWzpCxoyOV165belZOoCBZNw8Vl+91wVvYo9oJ+aOjy9oUisF4XXuRkg9u3eKrx2jQ65g==
X-Received: by 2002:a17:902:bf07:b0:167:6daa:f49c with SMTP id bi7-20020a170902bf0700b001676daaf49cmr17808997plb.9.1654662410264;
        Tue, 07 Jun 2022 21:26:50 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id k20-20020a17090aaa1400b001dc37aef4ffsm12723060pjq.48.2022.06.07.21.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 21:26:49 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] sched/fair: combine detach into dequeue when migrating task
Date:   Wed,  8 Jun 2022 12:26:05 +0800
Message-Id: <20220608042605.60720-1-zhouchengming@bytedance.com>
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

So we don't have to traverse the CFS tree twice to do these load
detach and propagation.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e0cd4052e32f..1db7c97a5fe6 100644
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
@@ -4426,6 +4434,14 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 static void
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
+	int action = UPDATE_TG;
+
+	/*
+	 * If we are migrating task from the CPU, detach load_avg when dequeue.
+	 */
+	if (entity_is_task(se) && task_of(se)->on_rq == TASK_ON_RQ_MIGRATING)
+		action |= DO_DETACH;
+
 	/*
 	 * Update run-time statistics of the 'current'.
 	 */
@@ -4440,7 +4456,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
 	 */
-	update_load_avg(cfs_rq, se, UPDATE_TG);
+	update_load_avg(cfs_rq, se, action);
 	se_update_runnable(se);
 
 	update_stats_dequeue_fair(cfs_rq, se, flags);
@@ -6940,15 +6956,10 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
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
+	if (p->on_rq != TASK_ON_RQ_MIGRATING) {
 		/*
 		 * We are supposed to update the task to "current" time, then
 		 * its up to date and ready to go to new CPU/cfs_rq. But we
-- 
2.36.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD660544233
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 05:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbiFIDxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 23:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiFIDxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:53:39 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085831D2AF2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 20:53:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so25639878pjo.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 20:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsyrJt/Y83W3Qo6hWuEVvkJGad12G8r8Bpik58Kjxik=;
        b=n0hYzS5gN41IRRMANjhTJMuHum3PXM46YcLc//RuqcG8xu85iit9DrNUoQ8yx8ZlFK
         sXs2+1b2AhxSC8kJm4bSqlGSnuA+bKhRe3c1aHmQX8iQyHzKfeFhLH8jeupwzkLV0N2b
         3amEgnicRBgahjqx+ErkNBcfuvlaQryp6ut6h3V2XIn/nFEkDgK7y5G585EfG5XGOTZo
         mjpq7sC5SgBlC7z6EwgZUQ5U1EUAtXF+5FLM4A6TJ1bNZrjTdHZfcrAboTJ3vGHT+UlH
         46Po2FF7xqO+1oOeKoXLp055rdCKm4kUMPZ+GDjUYtJyi549D5hxH9WG2ERPoylr5xDL
         KA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsyrJt/Y83W3Qo6hWuEVvkJGad12G8r8Bpik58Kjxik=;
        b=jzpdWiuj5fsDAcRWjIQkk/8zOmiGz1mk+MZ2llIzJWXICXDXH9Y/p6LHgBT8f5Z9bD
         62MlKLb6/aLxA4L9D66JwuVvG+rUMsy3mYSitmBfYeerf2fFUGY8/ZE6ez7SSc2j5GQ2
         wqfJn3Jf/9Pifk6N7WudPhPYYDMa5QJMylAIlA1DS+83pEafxgP/wItHHEPIsv6Tae8S
         4VrsD8Vg+A0gx4KE++308u2g/j1e9mPJVIoksYhknUYheqTeb6AyoVJlT6YDpPixGNtA
         sOTKnfuHLdrvr/12oyCzg9W1xTH4iNdJQp2ERwiM/HU1QNTdMszLYguGTurmM6Igx+s2
         R0zg==
X-Gm-Message-State: AOAM533ItYeDHlhGhybGSr+hx957oa/VlVJCNBH2B47ga98wKlxsrrIt
        +6d6NuDziJYJF2p6bzJYyrQ/mg==
X-Google-Smtp-Source: ABdhPJz71muuWUm9jAd5slRxvO4G7z2vjXnp/fCaOACmlPQJGRvR19E4wKTPdiEmzkN8YZjCOFqZ/g==
X-Received: by 2002:a17:902:d312:b0:168:9573:8043 with SMTP id b18-20020a170902d31200b0016895738043mr6536732plc.44.1654746818400;
        Wed, 08 Jun 2022 20:53:38 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id bb7-20020a170902bc8700b001624dab05edsm15596522plb.8.2022.06.08.20.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 20:53:37 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2] sched/fair: combine detach into dequeue when migrating task
Date:   Thu,  9 Jun 2022 11:53:26 +0800
Message-Id: <20220609035326.91544-1-zhouchengming@bytedance.com>
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
v2:
 - fix !CONFIG_SMP build error
---
 kernel/sched/fair.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e0cd4052e32f..9052685db375 100644
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
+	if (entity_is_task(se) && task_of(se)->on_rq == TASK_ON_RQ_MIGRATING)
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
+	if (p->on_rq != TASK_ON_RQ_MIGRATING) {
 		/*
 		 * We are supposed to update the task to "current" time, then
 		 * its up to date and ready to go to new CPU/cfs_rq. But we
-- 
2.36.1


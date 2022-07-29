Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA922584F67
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 13:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbiG2LNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 07:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiG2LNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:13:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E88067AC0E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:13:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 572501576;
        Fri, 29 Jul 2022 04:13:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 558AF3F73D;
        Fri, 29 Jul 2022 04:13:31 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] sched/deadline: Use sched_dl_entity's dl_density in dl_task_fits_capacity()
Date:   Fri, 29 Jul 2022 13:13:05 +0200
Message-Id: <20220729111305.1275158-4-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220729111305.1275158-1-dietmar.eggemann@arm.com>
References: <20220729111305.1275158-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save a multiplication in dl_task_fits_capacity() by using already
maintained per-sched_dl_entity (i.e. per-task) `dl_runtime/dl_deadline`
(dl_density).

  cap_scale(dl_deadline, cap) >= dl_runtime

  dl_deadline * cap >> SCHED_CAPACITY_SHIFT >= dl_runtime

  cap >= dl_runtime << SCHED_CAPACITY_SHIFT / dl_deadline

  cap >= (dl_runtime << BW_SHIFT / dl_deadline) >>
				BW_SHIFT - SCHED_CAPACITY_SHIFT

  cap >= dl_density >> BW_SHIFT - SCHED_CAPACITY_SHIFT

__sched_setscheduler()->__checkparam_dl() ensures that the 2 corner
cases (if conditions) `runtime == RUNTIME_INF (-1)` and `period == 0`
of to_ratio(deadline, runtime) are not met when setting dl_density in
__sched_setscheduler()-> __setscheduler_params()->__setparam_dl().

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/sched.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 72704b2b4a45..cdfe52cd8d39 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -320,21 +320,6 @@ struct dl_bw {
 	u64			total_bw;
 };
 
-/*
- * Verify the fitness of task @p to run on @cpu taking into account the
- * CPU original capacity and the runtime/deadline ratio of the task.
- *
- * The function will return true if the CPU original capacity of the
- * @cpu scaled by SCHED_CAPACITY_SCALE >= runtime/deadline ratio of the
- * task and false otherwise.
- */
-static inline bool dl_task_fits_capacity(struct task_struct *p, int cpu)
-{
-	unsigned long cap = arch_scale_cpu_capacity(cpu);
-
-	return cap_scale(p->dl.dl_deadline, cap) >= p->dl.dl_runtime;
-}
-
 extern void init_dl_bw(struct dl_bw *dl_b);
 extern int  sched_dl_global_validate(void);
 extern void sched_dl_do_global(void);
@@ -2894,6 +2879,21 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 				 enum cpu_util_type type,
 				 struct task_struct *p);
 
+/*
+ * Verify the fitness of task @p to run on @cpu taking into account the
+ * CPU original capacity and the runtime/deadline ratio of the task.
+ *
+ * The function will return true if the original capacity of @cpu is
+ * greater than or equal to task's deadline density right shifted by
+ * (BW_SHIFT - SCHED_CAPACITY_SHIFT) and false otherwise.
+ */
+static inline bool dl_task_fits_capacity(struct task_struct *p, int cpu)
+{
+	unsigned long cap = arch_scale_cpu_capacity(cpu);
+
+	return cap >= p->dl.dl_density >> (BW_SHIFT - SCHED_CAPACITY_SHIFT);
+}
+
 static inline unsigned long cpu_bw_dl(struct rq *rq)
 {
 	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
-- 
2.25.1


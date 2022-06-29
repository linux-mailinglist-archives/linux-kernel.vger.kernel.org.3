Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7EF55FFCA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiF2MVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiF2MV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:21:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 207A62FFF4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:21:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DADA169C;
        Wed, 29 Jun 2022 05:21:27 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0AD0A3F66F;
        Wed, 29 Jun 2022 05:21:24 -0700 (PDT)
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
Subject: [PATCH 3/3] sched/deadline: Use sched_dl_entity's dl_density in dl_task_fits_capacity()
Date:   Wed, 29 Jun 2022 14:20:53 +0200
Message-Id: <20220629122053.287165-4-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629122053.287165-1-dietmar.eggemann@arm.com>
References: <20220629122053.287165-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

  with BW_SHIFT = 2 x SCHED_CAPACITY_SHIFT

  cap >= (dl_runtime << BW_SHIFT / dl_deadline) >> SCHED_CAPACITY_SHIFT

  cap >= dl_density >> SCHED_CAPACITY_SHIFT

__sched_setscheduler()->__checkparam_dl() ensures that the 2 corner
cases (if conditions) `runtime == RUNTIME_INF (-1)` and `period == 0`
of to_ratio(deadline, runtime) are not met when setting dl_density in
__sched_setscheduler()-> __setscheduler_params()->__setparam_dl().

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/sched.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 79f65a6799c6..555f58d6c3a6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -324,15 +324,15 @@ struct dl_bw {
  * Verify the fitness of task @p to run on @cpu taking into account the
  * CPU original capacity and the runtime/deadline ratio of the task.
  *
- * The function will return true if the CPU original capacity of the
- * @cpu scaled by SCHED_CAPACITY_SCALE >= runtime/deadline ratio of the
- * task and false otherwise.
+ * The function will return true if the original capacity of @cpu is
+ * greater than or equal to task's deadline density right shifted by
+ * SCHED_CAPACITY_SHIFT and false otherwise.
  */
 static inline bool dl_task_fits_capacity(struct task_struct *p, int cpu)
 {
 	unsigned long cap = arch_scale_cpu_capacity(cpu);
 
-	return cap_scale(p->dl.dl_deadline, cap) >= p->dl.dl_runtime;
+	return cap >= p->dl.dl_density >> SCHED_CAPACITY_SHIFT;
 }
 
 extern void init_dl_bw(struct dl_bw *dl_b);
-- 
2.25.1


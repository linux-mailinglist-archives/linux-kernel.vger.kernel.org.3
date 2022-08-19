Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4395599E89
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 17:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349798AbiHSPeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349788AbiHSPeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:34:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6ED9F2CCBD
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:33:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AAE5175A;
        Fri, 19 Aug 2022 08:33:59 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 89B463F66F;
        Fri, 19 Aug 2022 08:33:54 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     qperret@google.com, Pierre Gondois <pierre.gondois@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 2/2] sched/fair: Use IRQ scaling for all sched classes
Date:   Fri, 19 Aug 2022 17:33:20 +0200
Message-Id: <20220819153320.291720-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819153320.291720-1-pierre.gondois@arm.com>
References: <20220819153320.291720-1-pierre.gondois@arm.com>
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

The time spent executing IRQ handlers is not reflected in the
utilization of CPU. IRQ scaling reduces rq CFS, RT and DL
util by reflecting the CPU capacity reduction due to IRQs.

commit 9033ea11889f ("cpufreq/schedutil: Take time spent in interrupts
into account")
introduced the notion of IRQ scaling for the now called
effective_cpu_util() function with the following expression (for the
CPU util):
  IRQ util_avg + (max_cap - IRQ util_avg / max_cap ) * /Sum rq util_avg

commit 523e979d3164 ("sched/core: Use PELT for scale_rt_capacity()")
introduced IRQ scaling for scale_rt_capacity(), but without scaling
RT and DL rq util.

scale_rt_capacity() excludes RT and DL rq signals from IRQ scaling.
Only the available capacity is scaled. However RT and DL rq util
should also be scaled.

Applying IRQ scaling allows to extract the IRQ util avg. So IRQ util
avg should also be subtracted from the available capacity.
Thermal pressure is not execution time but reduces the maximum
possible capacity of a CPU. So IRQ scaling should not be applied.

Thus, in this order:
 - subtract thermal pressure
 - apply IRQ scaling on the remaining capacity (RT + DL + CFS + free)
 - subtract IRQ util

Also, sort variables in reverse tree order.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/sched/fair.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcae7bdd5582..546e490d6753 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8468,16 +8468,23 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 
 static unsigned long scale_rt_capacity(int cpu)
 {
-	struct rq *rq = cpu_rq(cpu);
 	unsigned long max = arch_scale_cpu_capacity(cpu);
+	struct rq *rq = cpu_rq(cpu);
+	unsigned long irq, thermal;
 	unsigned long used, free;
-	unsigned long irq;
 
 	irq = cpu_util_irq(rq);
 
 	if (unlikely(irq >= max))
 		return 1;
 
+	thermal = thermal_load_avg(rq);
+	if (unlikely(thermal >= max))
+		return 1;
+
+	free = max - thermal;
+	free = scale_irq_capacity(free, irq, max);
+
 	/*
 	 * avg_rt.util_avg and avg_dl.util_avg track binary signals
 	 * (running and not running) with weights 0 and 1024 respectively.
@@ -8486,14 +8493,12 @@ static unsigned long scale_rt_capacity(int cpu)
 	 */
 	used = READ_ONCE(rq->avg_rt.util_avg);
 	used += READ_ONCE(rq->avg_dl.util_avg);
-	used += thermal_load_avg(rq);
+	used += irq;
 
-	if (unlikely(used >= max))
+	if (unlikely(used >= free))
 		return 1;
 
-	free = max - used;
-
-	return scale_irq_capacity(free, irq, max);
+	return free - used;
 }
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
-- 
2.25.1


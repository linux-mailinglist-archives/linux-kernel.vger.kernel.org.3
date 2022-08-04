Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2280D589D9E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbiHDOh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239948AbiHDOg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:36:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 172174D820
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:36:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 822D311FB;
        Thu,  4 Aug 2022 07:36:55 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.10.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56C3A3F73B;
        Thu,  4 Aug 2022 07:36:53 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2 8/9] sched/fair: Detect capacity inversion
Date:   Thu,  4 Aug 2022 15:36:08 +0100
Message-Id: <20220804143609.515789-9-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804143609.515789-1-qais.yousef@arm.com>
References: <20220804143609.515789-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check each performance domain to see if thermal pressure is causing its
capacity to be lower than another performance domain.

We assume that each performance domain has CPUs with the same
capacities, which is similar to an assumption made in energy_model.c

We also assume that thermal pressure impacts all CPUs in a performance
domain equally.

If there're multiple performance domains with the same capacity_orig, we
will trigger a capacity inversion if the domain is under thermal
pressure.

The new cpu_in_capacity_inversion() should help users to know when
information about capacity_orig are not reliable and can opt in to use
the inverted capacity as the 'actual' capacity_orig.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/fair.c  | 63 +++++++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h | 19 +++++++++++++
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 59ba7106ddc6..cb32dc9a057f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8659,16 +8659,73 @@ static unsigned long scale_rt_capacity(int cpu)
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
+	unsigned long capacity_orig = arch_scale_cpu_capacity(cpu);
 	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
+	struct rq *rq = cpu_rq(cpu);
 
-	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
+	rq->cpu_capacity_orig = capacity_orig;
 
 	if (!capacity)
 		capacity = 1;
 
-	cpu_rq(cpu)->cpu_capacity = capacity;
-	trace_sched_cpu_capacity_tp(cpu_rq(cpu));
+	rq->cpu_capacity = capacity;
+
+	/*
+	 * Detect if the performance domain is in capacity inversion state.
+	 *
+	 * Capacity inversion happens when another perf domain with equal or
+	 * lower capacity_orig_of() ends up having higher capacity than this
+	 * domain after subtracting thermal pressure.
+	 *
+	 * We only take into account thermal pressure in this detection as it's
+	 * the only metric that actually results in *real* reduction of
+	 * capacity due to performance points (OPPs) being dropped/become
+	 * unreachable due to thermal throttling.
+	 *
+	 * We assume:
+	 *   * That all cpus in a perf domain have the same capacity_orig
+	 *     (same uArch).
+	 *   * Thermal pressure will impact all cpus in this perf domain
+	 *     equally.
+	 */
+	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+		unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
+		struct perf_domain *pd = rcu_dereference(rq->rd->pd);
+
+		rq->cpu_capacity_inverted = 0;
+
+		for (; pd; pd = pd->next) {
+			struct cpumask *pd_span = perf_domain_span(pd);
+			unsigned long pd_cap_orig, pd_cap;
+
+			cpu = cpumask_any(pd_span);
+			pd_cap_orig = arch_scale_cpu_capacity(cpu);
+
+			if (capacity_orig < pd_cap_orig)
+				continue;
+
+			/*
+			 * handle the case of multiple perf domains have the
+			 * same capacity_orig but one of them is under higher
+			 * thermal pressure. We record it as capacity
+			 * inversion.
+			 */
+			if (capacity_orig == pd_cap_orig) {
+				pd_cap = pd_cap_orig - thermal_load_avg(cpu_rq(cpu));
+
+				if (pd_cap > inv_cap) {
+					rq->cpu_capacity_inverted = inv_cap;
+					break;
+				}
+			} else if (pd_cap_orig > inv_cap) {
+				rq->cpu_capacity_inverted = inv_cap;
+				break;
+			}
+		}
+	}
+
+	trace_sched_cpu_capacity_tp(rq);
 
 	sdg->sgc->capacity = capacity;
 	sdg->sgc->min_capacity = capacity;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index caf017f7def6..541a70fa55b3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1033,6 +1033,7 @@ struct rq {
 
 	unsigned long		cpu_capacity;
 	unsigned long		cpu_capacity_orig;
+	unsigned long		cpu_capacity_inverted;
 
 	struct callback_head	*balance_callback;
 
@@ -2865,6 +2866,24 @@ static inline unsigned long capacity_orig_of(int cpu)
 	return cpu_rq(cpu)->cpu_capacity_orig;
 }
 
+/*
+ * Returns inverted capacity if the CPU is in capacity inversion state.
+ * 0 otherwise.
+ *
+ * Capacity inversion detection only considers thermal impact where actual
+ * performance points (OPPs) gets dropped.
+ *
+ * Capacity inversion state happens when another performance domain that has
+ * equal or lower capacity_orig_of() becomes effectively larger than the perf
+ * domain this CPU belongs to due to thermal pressure throttling it hard.
+ *
+ * See comment in update_cpu_capacity().
+ */
+static inline unsigned long cpu_in_capacity_inversion(int cpu)
+{
+	return cpu_rq(cpu)->cpu_capacity_inverted;
+}
+
 /**
  * enum cpu_util_type - CPU utilization type
  * @FREQUENCY_UTIL:	Utilization used to select frequency
-- 
2.25.1


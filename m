Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C915A4DC7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbiCQNhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbiCQNhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:37:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 769071DEC22;
        Thu, 17 Mar 2022 06:35:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31BFE1570;
        Thu, 17 Mar 2022 06:35:58 -0700 (PDT)
Received: from e126645.arm.com (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C1D583F766;
        Thu, 17 Mar 2022 06:35:53 -0700 (PDT)
From:   Pierre Gondois <Pierre.Gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Lukasz.Luba@arm.com,
        Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com,
        mka@chromium.org, daniel.lezcano@linaro.org,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v1 3/3] cpufreq: CPPC: Register EM based on efficiency class information
Date:   Thu, 17 Mar 2022 14:34:17 +0100
Message-Id: <20220317133419.3901736-4-Pierre.Gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317133419.3901736-1-Pierre.Gondois@arm.com>
References: <20220317133419.3901736-1-Pierre.Gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Performance states and energy consumption values are not advertised
in ACPI. In the GicC structure of the MADT table, the "Processor
Power Efficiency Class field" (called efficiency class from now)
allows to describe the relative energy efficiency of CPUs.

To leverage the EM and EAS, the CPPC driver creates a set of
artificial performance states and registers them in the Energy Model
(EM), such as:
- Every 20 capacity unit, a performance state is created.
- The energy cost of each performance state gradually increases.
No power value is generated as only the cost is used in the EM.

During task placement, a task can raise the frequency of its whole
pd. This can make EAS place a task on a pd with CPUs that are
individually less energy efficient.
As cost values are artificial, and to place tasks on CPUs with the
lower efficiency class, a gap in cost values is generated for adjacent
efficiency classes.
E.g.:
- efficiency class = 0, capacity is in [0-1024], so cost values
  are in [0: 51] (one performance state every 20 capacity unit)
- efficiency class = 1, capacity is in [0-1024], cost values
  are in [1*gap+0: 1*gap+51].

The value of the cost gap is chosen to absorb a the energy of 4 CPUs
at their maximum capacity. This means that between:
1- a pd of 4 CPUs, each of them being used at almost their full
   capacity. Their efficiency class is N.
2- a CPU using almost none of its capacity. Its efficiency class is
   N+1
EAS will choose the first option.

Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 142 +++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index a6cd95c3b474..b65586511bc3 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -425,6 +425,129 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 static bool efficiency_class_populated;
 static DEFINE_PER_CPU(unsigned int, efficiency_class);
 
+/* Create an artificial performance state every CPPC_EM_CAP_STEP capacity unit. */
+#define CPPC_EM_CAP_STEP	(20)
+/* Increase the cost value by CPPC_EM_COST_STEP every performance state. */
+#define CPPC_EM_COST_STEP	(1)
+/* Add a cost gap correspnding to the energy of 4 CPUs. */
+#define CPPC_EM_COST_GAP	(4 * SCHED_CAPACITY_SCALE * CPPC_EM_COST_STEP \
+				/ CPPC_EM_CAP_STEP)
+
+static unsigned int get_perf_level_count(struct cpufreq_policy *policy)
+{
+	struct cppc_perf_caps *perf_caps;
+	unsigned int min_cap, max_cap;
+	struct cppc_cpudata *cpu_data;
+	int cpu = policy->cpu;
+
+	cpu_data = cppc_cpufreq_search_cpu_data(cpu);
+	perf_caps = &cpu_data->perf_caps;
+	max_cap = arch_scale_cpu_capacity(cpu);
+	min_cap = div_u64(max_cap * perf_caps->lowest_perf, perf_caps->highest_perf);
+	if ((min_cap == 0) || (max_cap < min_cap))
+		return 0;
+	return 1 + max_cap / CPPC_EM_CAP_STEP - min_cap / CPPC_EM_CAP_STEP;
+}
+
+/*
+ * The cost is defined as:
+ *   cost = power * max_frequency / frequency
+ */
+static inline unsigned long compute_cost(int cpu, int step)
+{
+	return CPPC_EM_COST_GAP * per_cpu(efficiency_class, cpu) +
+			step * CPPC_EM_COST_STEP;
+}
+
+static int cppc_get_cpu_power(struct device *cpu_dev,
+		unsigned long *power, unsigned long *KHz)
+{
+	unsigned long perf_step, perf_prev, perf, perf_check;
+	unsigned int min_step, max_step, step, step_check;
+	unsigned long prev_freq = *KHz;
+	unsigned int min_cap, max_cap;
+
+	struct cppc_perf_caps *perf_caps;
+	struct cppc_cpudata *cpu_data;
+
+	cpu_data = cppc_cpufreq_search_cpu_data(cpu_dev->id);
+	perf_caps = &cpu_data->perf_caps;
+	max_cap = arch_scale_cpu_capacity(cpu_dev->id);
+	min_cap = div_u64(max_cap * perf_caps->lowest_perf,
+			perf_caps->highest_perf);
+
+	perf_step = CPPC_EM_CAP_STEP * perf_caps->highest_perf / max_cap;
+	min_step = min_cap / CPPC_EM_CAP_STEP;
+	max_step = max_cap / CPPC_EM_CAP_STEP;
+
+	perf_prev = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
+	step = perf_prev / perf_step;
+
+	if (step > max_step)
+		return -EINVAL;
+
+	if (min_step == max_step) {
+		step = max_step;
+		perf = perf_caps->highest_perf;
+	} else if (step < min_step) {
+		step = min_step;
+		perf = perf_caps->lowest_perf;
+	} else {
+		step++;
+		if (step == max_step)
+			perf = perf_caps->highest_perf;
+		else
+			perf = step * perf_step;
+	}
+
+	*KHz = cppc_cpufreq_perf_to_khz(cpu_data, perf);
+	perf_check = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
+	step_check = perf_check / perf_step;
+
+	/*
+	 * To avoid bad integer approximation, check that new frequency value
+	 * increased and that the new frequency will be converted to the
+	 * desired step value.
+	 */
+	while ((*KHz == prev_freq) || (step_check != step)) {
+		perf++;
+		*KHz = cppc_cpufreq_perf_to_khz(cpu_data, perf);
+		perf_check = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
+		step_check = perf_check / perf_step;
+	}
+
+	/*
+	 * With an artificial EM, only the cost value is used. Still the power
+	 * is populated such as 0 < power < EM_MAX_POWER. This allows to add
+	 * more sense to the artificial performance states.
+	 */
+	*power = compute_cost(cpu_dev->id, step);
+
+	return 0;
+}
+
+static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
+		unsigned long *cost)
+{
+	unsigned long perf_step, perf_prev;
+	struct cppc_perf_caps *perf_caps;
+	struct cppc_cpudata *cpu_data;
+	unsigned int max_cap;
+	int step;
+
+	cpu_data = cppc_cpufreq_search_cpu_data(cpu_dev->id);
+	perf_caps = &cpu_data->perf_caps;
+	max_cap = arch_scale_cpu_capacity(cpu_dev->id);
+
+	perf_prev = cppc_cpufreq_khz_to_perf(cpu_data, KHz);
+	perf_step = CPPC_EM_CAP_STEP * perf_caps->highest_perf / max_cap;
+	step = perf_prev / perf_step;
+
+	*cost = compute_cost(cpu_dev->id, step);
+
+	return 0;
+}
+
 static int populate_efficiency_class(void)
 {
 	unsigned int min = UINT_MAX, max = 0, class;
@@ -472,6 +595,21 @@ static int populate_efficiency_class(void)
 	return 0;
 }
 
+static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data;
+	struct em_data_callback em_cb =
+		EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
+
+	if (!efficiency_class_populated)
+		return;
+
+	cpu_data = cppc_cpufreq_search_cpu_data(policy->cpu);
+	em_dev_register_perf_domain(get_cpu_device(policy->cpu),
+			get_perf_level_count(policy), &em_cb,
+			cpu_data->shared_cpu_map, 0);
+}
+
 #else
 
 static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
@@ -482,6 +620,9 @@ static int populate_efficiency_class(void)
 {
 	return 0;
 }
+static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
+{
+}
 #endif
 
 
@@ -753,6 +894,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.init = cppc_cpufreq_cpu_init,
 	.exit = cppc_cpufreq_cpu_exit,
 	.set_boost = cppc_cpufreq_set_boost,
+	.register_em = cppc_cpufreq_register_em,
 	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
 };
-- 
2.25.1


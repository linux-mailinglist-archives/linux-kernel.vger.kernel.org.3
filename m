Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72557554E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359056AbiFVO7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240195AbiFVO6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:58:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A83F817E1C;
        Wed, 22 Jun 2022 07:58:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CCF71477;
        Wed, 22 Jun 2022 07:58:14 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.38.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 825973F792;
        Wed, 22 Jun 2022 07:58:11 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        dietmar.eggemann@arm.com, nm@ti.com, sboyd@kernel.org,
        sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] PM: EM: convert power field to micro-Watts precision and align drivers
Date:   Wed, 22 Jun 2022 15:57:59 +0100
Message-Id: <20220622145802.13032-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220622145802.13032-1-lukasz.luba@arm.com>
References: <20220622145802.13032-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The milli-Watts precision causes rounding errors while calculating
efficiency cost for each OPP. This is especially visible in the 'simple'
Energy Model (EM), where the power for each OPP is provided from OPP
framework. This can cause some OPPs to be marked inefficient, while
using micro-Watts precision that might not happen.

Update all EM users which access 'power' field and assume the value is
in milli-Watts.

Solve also an issue with potential overflow in calculation of energy
estimation on 32bit machine. It's needed now since the power value
(thus the 'cost' as well) are higher.

Example calculation which shows the rounding error and impact:

power = 'dyn-power-coeff' * volt_mV * volt_mV * freq_MHz

power_a_uW = (100 * 600mW * 600mW * 500MHz) / 10^6 = 18000
power_a_mW = (100 * 600mW * 600mW * 500MHz) / 10^9 = 18

power_b_uW = (100 * 605mW * 605mW * 600MHz) / 10^6 = 21961
power_b_mW = (100 * 605mW * 605mW * 600MHz) / 10^9 = 21

max_freq = 2000MHz

cost_a_mW = 18 * 2000MHz/500MHz = 72
cost_a_uW = 18000 * 2000MHz/500MHz = 72000

cost_b_mW = 21 * 2000MHz/600MHz = 70 // <- artificially better
cost_b_uW = 21961 * 2000MHz/600MHz = 73203

The 'cost_b_mW' (which is based on old milli-Watts) is misleadingly
better that the 'cost_b_uW' (this patch uses micro-Watts) and such
would have impact on the 'inefficient OPPs' information in the Cpufreq
framework. This patch set removes the rounding issue.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c |  7 +--
 drivers/cpufreq/scmi-cpufreq.c        |  6 +++
 drivers/opp/of.c                      | 15 ++++---
 drivers/powercap/dtpm_cpu.c           |  5 +--
 drivers/thermal/cpufreq_cooling.c     | 13 +++++-
 drivers/thermal/devfreq_cooling.c     | 19 ++++++--
 include/linux/energy_model.h          | 63 ++++++++++++++++++++-------
 kernel/power/energy_model.c           | 31 ++++++++-----
 8 files changed, 114 insertions(+), 45 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 813cccbfe934..f0e0a35c7f21 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -51,7 +51,7 @@ static const u16 cpufreq_mtk_offsets[REG_ARRAY_SIZE] = {
 };
 
 static int __maybe_unused
-mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *mW,
+mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *uW,
 			  unsigned long *KHz)
 {
 	struct mtk_cpufreq_data *data;
@@ -71,8 +71,9 @@ mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *mW,
 	i--;
 
 	*KHz = data->table[i].frequency;
-	*mW = readl_relaxed(data->reg_bases[REG_EM_POWER_TBL] +
-			    i * LUT_ROW_SIZE) / 1000;
+	/* Provide micro-Watts value to the Energy Model */
+	*uW = readl_relaxed(data->reg_bases[REG_EM_POWER_TBL] +
+			    i * LUT_ROW_SIZE);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 6d2a4cf46db7..bfd35583d653 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/scmi_protocol.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 struct scmi_data {
 	int domain_id;
@@ -99,6 +100,7 @@ static int __maybe_unused
 scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
 		   unsigned long *KHz)
 {
+	bool power_scale_mw = perf_ops->power_scale_mw_get(ph);
 	unsigned long Hz;
 	int ret, domain;
 
@@ -112,6 +114,10 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
 	if (ret)
 		return ret;
 
+	/* Provide bigger resolution power to the Energy Model */
+	if (power_scale_mw)
+		*power *= MICROWATT_PER_MILLIWATT;
+
 	/* The EM framework specifies the frequency in KHz. */
 	*KHz = Hz / 1000;
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index ea8fc9e1f7e3..74c33cebeb29 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1482,12 +1482,12 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
  * It provides the power used by @dev at @kHz if it is the frequency of an
  * existing OPP, or at the frequency of the first OPP above @kHz otherwise
  * (see dev_pm_opp_find_freq_ceil()). This function updates @kHz to the ceiled
- * frequency and @mW to the associated power.
+ * frequency and @uW to the associated power.
  *
  * Returns 0 on success or a proper -EINVAL value in case of error.
  */
 static int __maybe_unused
-_get_dt_power(struct device *dev, unsigned long *mW, unsigned long *kHz)
+_get_dt_power(struct device *dev, unsigned long *uW, unsigned long *kHz)
 {
 	struct dev_pm_opp *opp;
 	unsigned long opp_freq, opp_power;
@@ -1504,7 +1504,7 @@ _get_dt_power(struct device *dev, unsigned long *mW, unsigned long *kHz)
 		return -EINVAL;
 
 	*kHz = opp_freq / 1000;
-	*mW = opp_power / 1000;
+	*uW = opp_power;
 
 	return 0;
 }
@@ -1514,14 +1514,14 @@ _get_dt_power(struct device *dev, unsigned long *mW, unsigned long *kHz)
  * This computes the power estimated by @dev at @kHz if it is the frequency
  * of an existing OPP, or at the frequency of the first OPP above @kHz otherwise
  * (see dev_pm_opp_find_freq_ceil()). This function updates @kHz to the ceiled
- * frequency and @mW to the associated power. The power is estimated as
+ * frequency and @uW to the associated power. The power is estimated as
  * P = C * V^2 * f with C being the device's capacitance and V and f
  * respectively the voltage and frequency of the OPP.
  *
  * Returns -EINVAL if the power calculation failed because of missing
  * parameters, 0 otherwise.
  */
-static int __maybe_unused _get_power(struct device *dev, unsigned long *mW,
+static int __maybe_unused _get_power(struct device *dev, unsigned long *uW,
 				     unsigned long *kHz)
 {
 	struct dev_pm_opp *opp;
@@ -1551,9 +1551,10 @@ static int __maybe_unused _get_power(struct device *dev, unsigned long *mW,
 		return -EINVAL;
 
 	tmp = (u64)cap * mV * mV * (Hz / 1000000);
-	do_div(tmp, 1000000000);
+	/* Provide power in micro-Watts */
+	do_div(tmp, 1000000);
 
-	*mW = (unsigned long)tmp;
+	*uW = (unsigned long)tmp;
 	*kHz = Hz / 1000;
 
 	return 0;
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index f5eced0842b3..61c5ff80bd30 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -53,7 +53,7 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 
 	for (i = 0; i < pd->nr_perf_states; i++) {
 
-		power = pd->table[i].power * MICROWATT_PER_MILLIWATT * nr_cpus;
+		power = pd->table[i].power * nr_cpus;
 
 		if (power > power_limit)
 			break;
@@ -63,8 +63,7 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 
 	freq_qos_update_request(&dtpm_cpu->qos_req, freq);
 
-	power_limit = pd->table[i - 1].power *
-		MICROWATT_PER_MILLIWATT * nr_cpus;
+	power_limit = pd->table[i - 1].power * nr_cpus;
 
 	return power_limit;
 }
diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index b8151d95a806..dc19e7c80751 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -21,6 +21,7 @@
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
+#include <linux/units.h>
 
 #include <trace/events/thermal.h>
 
@@ -101,6 +102,7 @@ static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
 static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
 			     u32 freq)
 {
+	unsigned long power_mw;
 	int i;
 
 	for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
@@ -108,16 +110,23 @@ static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
 			break;
 	}
 
-	return cpufreq_cdev->em->table[i + 1].power;
+	power_mw = cpufreq_cdev->em->table[i + 1].power;
+	power_mw /= MICROWATT_PER_MILLIWATT;
+
+	return power_mw;
 }
 
 static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 			     u32 power)
 {
+	unsigned long em_power_mw;
 	int i;
 
 	for (i = cpufreq_cdev->max_level; i > 0; i--) {
-		if (power >= cpufreq_cdev->em->table[i].power)
+		/* Convert EM power to milli-Watts to make safe comparison */
+		em_power_mw = cpufreq_cdev->em->table[i].power;
+		em_power_mw /= MICROWATT_PER_MILLIWATT;
+		if (power >= em_power_mw)
 			break;
 	}
 
diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 8c76f9655e57..8d1260f65061 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -200,7 +200,11 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 		res = dfc->power_ops->get_real_power(df, power, freq, voltage);
 		if (!res) {
 			state = dfc->capped_state;
+
+			/* Convert EM power into milli-Watts first */
 			dfc->res_util = dfc->em_pd->table[state].power;
+			dfc->res_util /= MICROWATT_PER_MILLIWATT;
+
 			dfc->res_util *= SCALE_ERROR_MITIGATION;
 
 			if (*power > 1)
@@ -218,8 +222,10 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 
 		_normalize_load(&status);
 
-		/* Scale power for utilization */
+		/* Convert EM power into milli-Watts first */
 		*power = dfc->em_pd->table[perf_idx].power;
+		*power /= MICROWATT_PER_MILLIWATT;
+		/* Scale power for utilization */
 		*power *= status.busy_time;
 		*power >>= 10;
 	}
@@ -244,6 +250,7 @@ static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
 
 	perf_idx = dfc->max_state - state;
 	*power = dfc->em_pd->table[perf_idx].power;
+	*power /= MICROWATT_PER_MILLIWATT;
 
 	return 0;
 }
@@ -254,7 +261,7 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	struct devfreq *df = dfc->devfreq;
 	struct devfreq_dev_status status;
-	unsigned long freq;
+	unsigned long freq, em_power_mw;
 	s32 est_power;
 	int i;
 
@@ -279,9 +286,13 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 	 * Find the first cooling state that is within the power
 	 * budget. The EM power table is sorted ascending.
 	 */
-	for (i = dfc->max_state; i > 0; i--)
-		if (est_power >= dfc->em_pd->table[i].power)
+	for (i = dfc->max_state; i > 0; i--) {
+		/* Convert EM power to milli-Watts to make safe comparison */
+		em_power_mw = dfc->em_pd->table[i].power;
+		em_power_mw /= MICROWATT_PER_MILLIWATT;
+		if (est_power >= em_power_mw)
 			break;
+	}
 
 	*state = dfc->max_state - i;
 	dfc->capped_state = *state;
diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 8419bffb4398..a8199168c2a5 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -62,7 +62,7 @@ struct em_perf_domain {
 /*
  *  em_perf_domain flags:
  *
- *  EM_PERF_DOMAIN_MILLIWATTS: The power values are in milli-Watts or some
+ *  EM_PERF_DOMAIN_MICROWATTS: The power values are in micro-Watts or some
  *  other scale.
  *
  *  EM_PERF_DOMAIN_SKIP_INEFFICIENCIES: Skip inefficient states when estimating
@@ -71,7 +71,7 @@ struct em_perf_domain {
  *  EM_PERF_DOMAIN_ARTIFICIAL: The power values are artificial and might be
  *  created by platform missing real power information
  */
-#define EM_PERF_DOMAIN_MILLIWATTS BIT(0)
+#define EM_PERF_DOMAIN_MICROWATTS BIT(0)
 #define EM_PERF_DOMAIN_SKIP_INEFFICIENCIES BIT(1)
 #define EM_PERF_DOMAIN_ARTIFICIAL BIT(2)
 
@@ -79,22 +79,53 @@ struct em_perf_domain {
 #define em_is_artificial(em) ((em)->flags & EM_PERF_DOMAIN_ARTIFICIAL)
 
 #ifdef CONFIG_ENERGY_MODEL
-#define EM_MAX_POWER 0xFFFF
+/*
+ * The max power value in micro-Watts. The limit of 64 Watts is set as
+ * a safety net to not overflow multiplications on 32bit platforms. The
+ * 32bit value limit for total Perf Domain power implies a limit of
+ * maximum CPUs in such domain to 64.
+ */
+#define EM_MAX_POWER (64000000) /* 64 Watts */
+
+/*
+ * Validate if the 'cost' value won't cause overflow on 32bit machine
+ * in the em_cpu_energy(). This is unlikely on existing 32bit platforms
+ * with small number of CPUs in a Performance Domain and/or small power
+ * value. Although, the issue would be triggered when we have more than
+ * 64 CPUs in a single Perf. Domain and each of them consumes 64 Watts.
+ *
+ * We are safe on 64bit machine.
+ */
+#ifdef CONFIG_64BIT
+#define em_validate_cost(cost, num_devs) (false)
+#else
+/*
+ * Simulate maximum possible sum utilization and multiply by
+ * cost/cpu_scale, which is in fact 'cost * num_devs'
+ */
+#define em_validate_cost(cost, num_devs)		\
+	((((u64)(cost) * (num_devs)) >= UINT_MAX))
+#endif
 
 /*
- * Increase resolution of energy estimation calculations for 64-bit
- * architectures. The extra resolution improves decision made by EAS for the
- * task placement when two Performance Domains might provide similar energy
- * estimation values (w/o better resolution the values could be equal).
+ * To avoid an overflow on 32bit machines while calculating the energy
+ * use a different order in the operation. First divide by the 'cpu_scale'
+ * which would reduce big value stored in the 'cost' field, then multiply by
+ * the 'sum_util'. This would allow to handle existing platforms, which have
+ * e.g. power ~1.3 Watt at max freq, so the 'cost' value > 1mln micro-Watts.
+ * In such scenario, where there are 4 CPUs in the Perf. Domain the 'sum_util'
+ * could be 4096, then multiplication: 'cost' * 'sum_util'  would overflow.
+ * This reordering of operations has some limitations, we lose small
+ * precision in the estimation (comparing to 64bit platform w/o reordering).
  *
- * We increase resolution only if we have enough bits to allow this increased
- * resolution (i.e. 64-bit). The costs for increasing resolution when 32-bit
- * are pretty high and the returns do not justify the increased costs.
+ * We are safe on 64bit machine.
  */
 #ifdef CONFIG_64BIT
-#define em_scale_power(p) ((p) * 1000)
+#define em_estimate_energy(cost, sum_util, scale_cpu) \
+	(((cost) * (sum_util)) / (scale_cpu))
 #else
-#define em_scale_power(p) (p)
+#define em_estimate_energy(cost, sum_util, scale_cpu) \
+	(((cost) / (scale_cpu)) * (sum_util))
 #endif
 
 struct em_data_callback {
@@ -112,7 +143,7 @@ struct em_data_callback {
 	 * and frequency.
 	 *
 	 * In case of CPUs, the power is the one of a single CPU in the domain,
-	 * expressed in milli-Watts or an abstract scale. It is expected to
+	 * expressed in micro-Watts or an abstract scale. It is expected to
 	 * fit in the [0, EM_MAX_POWER] range.
 	 *
 	 * Return 0 on success.
@@ -148,7 +179,7 @@ struct em_perf_domain *em_cpu_get(int cpu);
 struct em_perf_domain *em_pd_get(struct device *dev);
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				struct em_data_callback *cb, cpumask_t *span,
-				bool milliwatts);
+				bool microwatts);
 void em_dev_unregister_perf_domain(struct device *dev);
 
 /**
@@ -273,7 +304,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 *   pd_nrg = ------------------------                       (4)
 	 *                  scale_cpu
 	 */
-	return ps->cost * sum_util / scale_cpu;
+	return em_estimate_energy(ps->cost, sum_util, scale_cpu);
 }
 
 /**
@@ -297,7 +328,7 @@ struct em_data_callback {};
 static inline
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				struct em_data_callback *cb, cpumask_t *span,
-				bool milliwatts)
+				bool microwatts)
 {
 	return -EINVAL;
 }
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 6c373f2960e7..910668ec8838 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -108,10 +108,11 @@ static void em_debug_remove_pd(struct device *dev) {}
 
 static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 				int nr_states, struct em_data_callback *cb,
-				unsigned long flags)
+				unsigned long flags, int num_devs)
 {
 	unsigned long power, freq, prev_freq = 0, prev_cost = ULONG_MAX;
 	struct em_perf_state *table;
+	unsigned long max_cost = 0;
 	int i, ret;
 	u64 fmax;
 
@@ -145,7 +146,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 
 		/*
 		 * The power returned by active_state() is expected to be
-		 * positive and to fit into 16 bits.
+		 * positive and be in range.
 		 */
 		if (!power || power > EM_MAX_POWER) {
 			dev_err(dev, "EM: invalid power: %lu\n",
@@ -170,7 +171,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 				goto free_ps_table;
 			}
 		} else {
-			power_res = em_scale_power(table[i].power);
+			power_res = table[i].power;
 			cost = div64_u64(fmax * power_res, table[i].frequency);
 		}
 
@@ -183,6 +184,15 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 		} else {
 			prev_cost = table[i].cost;
 		}
+
+		if (max_cost < table[i].cost)
+			max_cost = table[i].cost;
+	}
+
+	/* Check if it won't overflow during energy estimation. */
+	if (em_validate_cost(max_cost, num_devs)) {
+		dev_err(dev, "EM: too big 'cost' value: %lu\n",	max_cost);
+		goto free_ps_table;
 	}
 
 	pd->table = table;
@@ -199,9 +209,9 @@ static int em_create_pd(struct device *dev, int nr_states,
 			struct em_data_callback *cb, cpumask_t *cpus,
 			unsigned long flags)
 {
+	int cpu, ret, num_devs = 1;
 	struct em_perf_domain *pd;
 	struct device *cpu_dev;
-	int cpu, ret;
 
 	if (_is_cpu_device(dev)) {
 		pd = kzalloc(sizeof(*pd) + cpumask_size(), GFP_KERNEL);
@@ -209,13 +219,14 @@ static int em_create_pd(struct device *dev, int nr_states,
 			return -ENOMEM;
 
 		cpumask_copy(em_span_cpus(pd), cpus);
+		num_devs = cpumask_weight(cpus);
 	} else {
 		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
 		if (!pd)
 			return -ENOMEM;
 	}
 
-	ret = em_create_perf_table(dev, pd, nr_states, cb, flags);
+	ret = em_create_perf_table(dev, pd, nr_states, cb, flags, num_devs);
 	if (ret) {
 		kfree(pd);
 		return ret;
@@ -314,13 +325,13 @@ EXPORT_SYMBOL_GPL(em_cpu_get);
  * @cpus	: Pointer to cpumask_t, which in case of a CPU device is
  *		obligatory. It can be taken from i.e. 'policy->cpus'. For other
  *		type of devices this should be set to NULL.
- * @milliwatts	: Flag indicating that the power values are in milliWatts or
+ * @microwatts	: Flag indicating that the power values are in micro-Watts or
  *		in some other scale. It must be set properly.
  *
  * Create Energy Model tables for a performance domain using the callbacks
  * defined in cb.
  *
- * The @milliwatts is important to set with correct value. Some kernel
+ * The @microwatts is important to set with correct value. Some kernel
  * sub-systems might rely on this flag and check if all devices in the EM are
  * using the same scale.
  *
@@ -331,7 +342,7 @@ EXPORT_SYMBOL_GPL(em_cpu_get);
  */
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				struct em_data_callback *cb, cpumask_t *cpus,
-				bool milliwatts)
+				bool microwatts)
 {
 	unsigned long cap, prev_cap = 0;
 	unsigned long flags = 0;
@@ -381,8 +392,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 		}
 	}
 
-	if (milliwatts)
-		flags |= EM_PERF_DOMAIN_MILLIWATTS;
+	if (microwatts)
+		flags |= EM_PERF_DOMAIN_MICROWATTS;
 	else if (cb->get_cost)
 		flags |= EM_PERF_DOMAIN_ARTIFICIAL;
 
-- 
2.17.1


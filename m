Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242294F6DB7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 00:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbiDFWKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 18:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbiDFWKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:10:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC71B1D12FF;
        Wed,  6 Apr 2022 15:08:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AE9812FC;
        Wed,  6 Apr 2022 15:08:36 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.9.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE7613F5A1;
        Wed,  6 Apr 2022 15:08:34 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        amit.kachhap@gmail.com, linux-pm@vger.kernel.org
Subject: [RFC PATCH v3 5/5] thermal: cpufreq_cooling: Improve power estimation using Cpufreq Active Stats
Date:   Wed,  6 Apr 2022 23:08:09 +0100
Message-Id: <20220406220809.22555-6-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406220809.22555-1-lukasz.luba@arm.com>
References: <20220406220809.22555-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpufreq_cooling has dedicated APIs for thermal governor called
Intelligent Power Allocation (IPA). IPA needs the CPUs power used by the
devices in the past.  Based on this, IPA tries to estimate the power
budget, allocate new budget and split it across cooling devices for the
next period (keeping the system in the thermal envelope).  When the input
power estimated value has big error, the whole mechanism does not work
properly. The old power estimation assumes constant CPU frequency during
the whole IPA period (e.g. 100ms). This can cause big error in the power
estimation, especially when SchedUtil governor and Uclamp is used and
frequency is often adjusted to the current need. This can be visible in

Thus, introduce a new mechanism which solves the CPU frequency sampling
problem and missing proper residency. Use Cpufreq Active Stats calculate
the CPU power used for a given IPA period.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpufreq_cooling.c | 131 ++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 0bfb8eebd126..a609bd55ed80 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -12,6 +12,7 @@
  */
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpufreq_stats.h>
 #include <linux/cpu_cooling.h>
 #include <linux/device.h>
 #include <linux/energy_model.h>
@@ -61,6 +62,7 @@ struct time_in_idle {
  * @policy: cpufreq policy.
  * @idle_time: idle time stats
  * @qos_req: PM QoS contraint to apply
+ * @ast_mon: Cpufreq Active Stats Monitor array of pointers
  *
  * This structure is required for keeping information of each registered
  * cpufreq_cooling_device.
@@ -75,6 +77,9 @@ struct cpufreq_cooling_device {
 	struct time_in_idle *idle_time;
 #endif
 	struct freq_qos_request qos_req;
+#ifdef CONFIG_CPU_FREQ_STAT
+	struct cpufreq_active_stats_monitor **ast_mon;
+#endif
 };
 
 #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
@@ -124,6 +129,106 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 	return cpufreq_cdev->em->table[i].frequency;
 }
 
+#ifdef CONFIG_CPU_FREQ_STAT
+static u32 account_cpu_power(struct cpufreq_active_stats_monitor *ast_mon,
+			     struct em_perf_domain *em)
+{
+	u64 single_power, residency, total_time;
+	struct cpufreq_active_stats_state *result;
+	u32 power = 0;
+	int i;
+
+	mutex_lock(&ast_mon->lock);
+	result = ast_mon->snapshot.result;
+	total_time = ast_mon->local_period;
+
+	for (i = 0; i < ast_mon->states_count; i++) {
+		residency = result->residency[i];
+		single_power = em->table[i].power * residency;
+		single_power = div64_u64(single_power, total_time);
+		power += (u32)single_power;
+	}
+
+	mutex_unlock(&ast_mon->lock);
+
+	return power;
+}
+
+static u32 get_power_est(struct cpufreq_cooling_device *cdev)
+{
+	int num_cpus, ret, i;
+	u32 total_power = 0;
+
+	num_cpus = cpumask_weight(cdev->policy->related_cpus);
+
+	for (i = 0; i < num_cpus; i++) {
+		ret = cpufreq_active_stats_cpu_update_monitor(cdev->ast_mon[i]);
+		if (ret)
+			return 0;
+
+		total_power += account_cpu_power(cdev->ast_mon[i], cdev->em);
+	}
+
+	return total_power;
+}
+
+static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
+				       u32 *power)
+{
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	struct cpufreq_policy *policy = cpufreq_cdev->policy;
+
+	*power = get_power_est(cpufreq_cdev);
+
+	trace_thermal_power_cpu_get_power(policy->related_cpus, 0, 0, 0,
+					  *power);
+
+	return 0;
+}
+
+static void clean_cpu_monitoring(struct cpufreq_cooling_device *cdev)
+{
+	int num_cpus, i;
+
+	if (!cdev->ast_mon)
+		return;
+
+	num_cpus = cpumask_weight(cdev->policy->related_cpus);
+
+	for (i = 0; i < num_cpus; i++)
+		cpufreq_active_stats_cpu_free_monitor(cdev->ast_mon[i++]);
+
+	kfree(cdev->ast_mon);
+	cdev->ast_mon = NULL;
+}
+
+static int setup_cpu_monitoring(struct cpufreq_cooling_device *cdev)
+{
+	int cpu, cpus, i = 0;
+
+	if (cdev->ast_mon)
+		return 0;
+
+	cpus = cpumask_weight(cdev->policy->related_cpus);
+
+	cdev->ast_mon = kcalloc(cpus, sizeof(cdev->ast_mon), GFP_KERNEL);
+	if (!cdev->ast_mon)
+		return -ENOMEM;
+
+	for_each_cpu(cpu, cdev->policy->related_cpus) {
+		cdev->ast_mon[i] = cpufreq_active_stats_setup(cpu);
+		if (IS_ERR_OR_NULL(cdev->ast_mon[i++]))
+			goto cleanup;
+	}
+
+	return 0;
+
+cleanup:
+	clean_cpu_monitoring(cdev);
+	return -EINVAL;
+}
+#else /* !CONFIG_CPU_FREQ_STATS */
+
 /**
  * get_load() - get load for a cpu
  * @cpufreq_cdev: struct cpufreq_cooling_device for the cpu
@@ -184,6 +289,15 @@ static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_cdev,
 	return (raw_cpu_power * cpufreq_cdev->last_load) / 100;
 }
 
+static void clean_cpu_monitoring(struct cpufreq_cooling_device *cpufreq_cdev)
+{
+}
+
+static int setup_cpu_monitoring(struct cpufreq_cooling_device *cpufreq_cdev)
+{
+	return 0;
+}
+
 /**
  * cpufreq_get_requested_power() - get the current power
  * @cdev:	&thermal_cooling_device pointer
@@ -252,6 +366,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 
 	return 0;
 }
+#endif
 
 /**
  * cpufreq_state2power() - convert a cpu cdev state to power consumed
@@ -323,6 +438,20 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
+static int cpufreq_change_governor(struct thermal_cooling_device *cdev,
+				   bool governor_up)
+{
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	int ret = 0;
+
+	if (governor_up)
+		ret = setup_cpu_monitoring(cpufreq_cdev);
+	else
+		clean_cpu_monitoring(cpufreq_cdev);
+
+	return ret;
+}
+
 static inline bool em_is_sane(struct cpufreq_cooling_device *cpufreq_cdev,
 			      struct em_perf_domain *em) {
 	struct cpufreq_policy *policy;
@@ -562,6 +691,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		cooling_ops->get_requested_power = cpufreq_get_requested_power;
 		cooling_ops->state2power = cpufreq_state2power;
 		cooling_ops->power2state = cpufreq_power2state;
+		cooling_ops->change_governor = cpufreq_change_governor;
 	} else
 #endif
 	if (policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED) {
@@ -686,6 +816,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	thermal_cooling_device_unregister(cdev);
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
+	clean_cpu_monitoring(cpufreq_cdev);
 	free_idle_time(cpufreq_cdev);
 	kfree(cpufreq_cdev);
 }
-- 
2.17.1


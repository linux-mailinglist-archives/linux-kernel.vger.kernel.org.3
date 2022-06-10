Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528FB546317
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348485AbiFJKEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347467AbiFJKEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:04:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 792E5B2EA9;
        Fri, 10 Jun 2022 03:03:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 391661576;
        Fri, 10 Jun 2022 03:03:59 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.39.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1533C3F766;
        Fri, 10 Jun 2022 03:03:56 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        dietmar.eggemann@arm.com
Subject: [PATCH 2/3] thermal: cpufreq_cooling : Refactor thermal_power_cpu_get_power
Date:   Fri, 10 Jun 2022 11:03:42 +0100
Message-Id: <20220610100343.32378-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610100343.32378-1-lukasz.luba@arm.com>
References: <20220610100343.32378-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the thermal_power_cpu_get_power trace event by removing
complicated cpumask and variable length array. Now the tools parsing trace
output don't have to hassle to get this power data. The simplified format
version uses 'policy->cpu'. Remove also the 'load' information completely
since there is very little value of it in this trace event. To get the
CPUs' load (or utilization) there are other dedicated trace hooks in the
kernel. This patch also simplifies and speeds-up the main cooling code
when that trace event is enabled.

Rename the trace event to avoid confusion of tools which parse the trace
file.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpufreq_cooling.c | 18 +-----------------
 include/trace/events/thermal.h    | 28 ++++++++--------------------
 2 files changed, 9 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index e33183785fac..2ef1dc2b96a3 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -214,16 +214,9 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 	u32 total_load = 0;
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 	struct cpufreq_policy *policy = cpufreq_cdev->policy;
-	u32 *load_cpu = NULL;
 
 	freq = cpufreq_quick_get(policy->cpu);
 
-	if (trace_thermal_power_cpu_get_power_enabled()) {
-		u32 ncpus = cpumask_weight(policy->related_cpus);
-
-		load_cpu = kcalloc(ncpus, sizeof(*load_cpu), GFP_KERNEL);
-	}
-
 	for_each_cpu(cpu, policy->related_cpus) {
 		u32 load;
 
@@ -233,22 +226,13 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 			load = 0;
 
 		total_load += load;
-		if (load_cpu)
-			load_cpu[i] = load;
-
-		i++;
 	}
 
 	cpufreq_cdev->last_load = total_load;
 
 	*power = get_dynamic_power(cpufreq_cdev, freq);
 
-	if (load_cpu) {
-		trace_thermal_power_cpu_get_power(policy->related_cpus, freq,
-						  load_cpu, i, *power);
-
-		kfree(load_cpu);
-	}
+	trace_thermal_power_cpu_get_power_simple(policy->cpu, *power);
 
 	return 0;
 }
diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
index 8a5f04888abd..e58bf3072f32 100644
--- a/include/trace/events/thermal.h
+++ b/include/trace/events/thermal.h
@@ -92,34 +92,22 @@ TRACE_EVENT(thermal_zone_trip,
 );
 
 #ifdef CONFIG_CPU_THERMAL
-TRACE_EVENT(thermal_power_cpu_get_power,
-	TP_PROTO(const struct cpumask *cpus, unsigned long freq, u32 *load,
-		size_t load_len, u32 dynamic_power),
+TRACE_EVENT(thermal_power_cpu_get_power_simple,
+	TP_PROTO(int cpu, u32 power),
 
-	TP_ARGS(cpus, freq, load, load_len, dynamic_power),
+	TP_ARGS(cpu, power),
 
 	TP_STRUCT__entry(
-		__bitmask(cpumask, num_possible_cpus())
-		__field(unsigned long, freq          )
-		__dynamic_array(u32,   load, load_len)
-		__field(size_t,        load_len      )
-		__field(u32,           dynamic_power )
+		__field(int, cpu)
+		__field(u32, power)
 	),
 
 	TP_fast_assign(
-		__assign_bitmask(cpumask, cpumask_bits(cpus),
-				num_possible_cpus());
-		__entry->freq = freq;
-		memcpy(__get_dynamic_array(load), load,
-			load_len * sizeof(*load));
-		__entry->load_len = load_len;
-		__entry->dynamic_power = dynamic_power;
+		__entry->cpu = cpu;
+		__entry->power = power;
 	),
 
-	TP_printk("cpus=%s freq=%lu load={%s} dynamic_power=%d",
-		__get_bitmask(cpumask), __entry->freq,
-		__print_array(__get_dynamic_array(load), __entry->load_len, 4),
-		__entry->dynamic_power)
+	TP_printk("cpu=%d power=%u", __entry->cpu, __entry->power)
 );
 
 TRACE_EVENT(thermal_power_cpu_limit,
-- 
2.17.1


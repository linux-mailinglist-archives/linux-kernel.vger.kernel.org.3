Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592DC5499FC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbiFMR2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiFMR1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:27:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF4EE129C01;
        Mon, 13 Jun 2022 05:43:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 942F21596;
        Mon, 13 Jun 2022 05:43:43 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.35.216])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 77EB83F73B;
        Mon, 13 Jun 2022 05:43:41 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mingo@redhat.com
Subject: [PATCH v2 2/4] thermal: cpufreq_cooling : Refactor thermal_power_cpu_get_power tracing
Date:   Mon, 13 Jun 2022 13:43:25 +0100
Message-Id: <20220613124327.30766-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613124327.30766-1-lukasz.luba@arm.com>
References: <20220613124327.30766-1-lukasz.luba@arm.com>
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

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpufreq_cooling.c | 18 +-----------------
 include/trace/events/thermal.h    | 28 ++++++++--------------------
 2 files changed, 9 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index ad8b86f5281b..492a67e267e8 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -216,16 +216,9 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
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
 
@@ -235,22 +228,13 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
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


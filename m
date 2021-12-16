Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7754477B90
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbhLPSdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:33:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:45019 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231582AbhLPSdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:33:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="239515597"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="239515597"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 10:33:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="546088595"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga001.jf.intel.com with ESMTP; 16 Dec 2021 10:33:08 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     lenb@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Update EPP for AlderLake mobile
Date:   Thu, 16 Dec 2021 10:33:05 -0800
Message-Id: <20211216183305.3152807-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an expectation from users that they can get frequency specified
by cpufreq/cpuinfo_max_freq when conditions permit. But with AlderLake
mobile it may not be possible. This is possible that frequency is clipped
based on the system power-up EPP value. In this case users can update
cpufreq/energy_performance_preference to some performance oriented EPP to
limit clipping of frequencies.

To get out of box behavior as the prior generations of CPUs, update EPP
for AlderLake mobile CPUs on boot. On prior generations of CPUs EPP = 128
was enough to get maximum frequency, but with AlderLake mobile the
equivalent EPP is 102. Since EPP is model specific, this is possible that
they have different meaning on each generation of CPU.

The current EPP string "balance_performance" corresponds to EPP = 128.
Change the EPP corresponding to "balance_performance" to 102 for only
AlderLake mobile CPUs and update this on each CPU during boot.

To implement reuse epp_values[] array and update the modified EPP at the
index for BALANCE_PERFORMANCE. Add a dummy EPP_INDEX_DEFAULT to
epp_values[] to match indexes in the energy_perf_strings[].

After HWP PM is enabled also update EPP when "balance_performance" is
redefined for the very first time after the boot on each CPU. On
subsequent suspend/resume or offline/online the old EPP is restored,
so no specific action is needed.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 79 ++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dec2a5649ac1..1408411f4618 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -664,19 +664,29 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
  *	3		balance_power
  *	4		power
  */
+
+enum energy_perf_value_index {
+	EPP_INDEX_DEFAULT = 0,
+	EPP_INDEX_PERFORMANCE,
+	EPP_INDEX_BALANCE_PERFORMANCE,
+	EPP_INDEX_BALANCE_POWERSAVE,
+	EPP_INDEX_POWERSAVE,
+};
+
 static const char * const energy_perf_strings[] = {
-	"default",
-	"performance",
-	"balance_performance",
-	"balance_power",
-	"power",
+	[EPP_INDEX_DEFAULT] = "default",
+	[EPP_INDEX_PERFORMANCE] = "performance",
+	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
+	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
+	[EPP_INDEX_POWERSAVE] = "power",
 	NULL
 };
-static const unsigned int epp_values[] = {
-	HWP_EPP_PERFORMANCE,
-	HWP_EPP_BALANCE_PERFORMANCE,
-	HWP_EPP_BALANCE_POWERSAVE,
-	HWP_EPP_POWERSAVE
+static unsigned int epp_values[] = {
+	[EPP_INDEX_DEFAULT] = 0, /* Unused index */
+	[EPP_INDEX_PERFORMANCE] = HWP_EPP_PERFORMANCE,
+	[EPP_INDEX_BALANCE_PERFORMANCE] = HWP_EPP_BALANCE_PERFORMANCE,
+	[EPP_INDEX_BALANCE_POWERSAVE] = HWP_EPP_BALANCE_POWERSAVE,
+	[EPP_INDEX_POWERSAVE] = HWP_EPP_POWERSAVE,
 };
 
 static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data, int *raw_epp)
@@ -690,14 +700,14 @@ static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data, int *raw
 		return epp;
 
 	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
-		if (epp == HWP_EPP_PERFORMANCE)
-			return 1;
-		if (epp == HWP_EPP_BALANCE_PERFORMANCE)
-			return 2;
-		if (epp == HWP_EPP_BALANCE_POWERSAVE)
-			return 3;
-		if (epp == HWP_EPP_POWERSAVE)
-			return 4;
+		if (epp == epp_values[EPP_INDEX_PERFORMANCE])
+			return EPP_INDEX_PERFORMANCE;
+		if (epp == epp_values[EPP_INDEX_BALANCE_PERFORMANCE])
+			return EPP_INDEX_BALANCE_PERFORMANCE;
+		if (epp == epp_values[EPP_INDEX_BALANCE_POWERSAVE])
+			return EPP_INDEX_BALANCE_POWERSAVE;
+		if (epp == epp_values[EPP_INDEX_POWERSAVE])
+			return EPP_INDEX_POWERSAVE;
 		*raw_epp = epp;
 		return 0;
 	} else if (boot_cpu_has(X86_FEATURE_EPB)) {
@@ -757,7 +767,7 @@ static int intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
 		if (use_raw)
 			epp = raw_epp;
 		else if (epp == -EINVAL)
-			epp = epp_values[pref_index - 1];
+			epp = epp_values[pref_index];
 
 		/*
 		 * To avoid confusion, refuse to set EPP to any values different
@@ -843,7 +853,7 @@ static ssize_t store_energy_performance_preference(
 		 * upfront.
 		 */
 		if (!raw)
-			epp = ret ? epp_values[ret - 1] : cpu->epp_default;
+			epp = ret ? epp_values[ret] : cpu->epp_default;
 
 		if (cpu->epp_cached != epp) {
 			int err;
@@ -1679,10 +1689,18 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
 	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
-	if (cpudata->epp_default == -EINVAL)
-		cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
 
 	intel_pstate_enable_hwp_interrupt(cpudata);
+
+	if (cpudata->epp_default >= 0)
+		return;
+
+	if (epp_values[EPP_INDEX_BALANCE_PERFORMANCE] == HWP_EPP_BALANCE_PERFORMANCE) {
+		cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
+	} else {
+		cpudata->epp_default = epp_values[EPP_INDEX_BALANCE_PERFORMANCE];
+		intel_pstate_set_epp(cpudata, cpudata->epp_default);
+	}
 }
 
 static int atom_get_min_pstate(void)
@@ -3349,6 +3367,16 @@ static bool intel_pstate_hwp_is_enabled(void)
 	return !!(value & 0x1);
 }
 
+static const struct x86_cpu_id intel_epp_balance_perf[] = {
+	/*
+	 * Set EPP value as 102, this is the max suggested EPP
+	 * which can result in one core turbo frequency for
+	 * AlderLake Mobile CPUs.
+	 */
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, 102),
+	{}
+};
+
 static int __init intel_pstate_init(void)
 {
 	static struct cpudata **_all_cpu_data;
@@ -3438,6 +3466,13 @@ static int __init intel_pstate_init(void)
 
 	intel_pstate_sysfs_expose_params();
 
+	if (hwp_active) {
+		const struct x86_cpu_id *id = x86_match_cpu(intel_epp_balance_perf);
+
+		if (id)
+			epp_values[EPP_INDEX_BALANCE_PERFORMANCE] = id->driver_data;
+	}
+
 	mutex_lock(&intel_pstate_driver_lock);
 	rc = intel_pstate_register_driver(default_driver);
 	mutex_unlock(&intel_pstate_driver_lock);
-- 
2.31.1


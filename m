Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56964714C4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 17:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhLKQdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 11:33:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:47356 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231455AbhLKQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 11:33:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="218564677"
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="218564677"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 08:33:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="462902902"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga003.jf.intel.com with ESMTP; 11 Dec 2021 08:33:49 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        rafael@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] x86: intel_epb: Allow model specific normal EPB value
Date:   Sat, 11 Dec 2021 08:33:27 -0800
Message-Id: <20211211163327.3093169-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current EPB "normal" is defined as 6 and set whenever power-up EPB
value is 0. This setting resulted in the desired out of box power and
performance for several CPU generations. But this value is not suitable
for AlderLake mobile CPUs, as this resulted in higher uncore power.
Since EPB is model specific, this is not unreasonable to have different
behavior.

Allow a capability where "normal" EPB can be redefined. For AlderLake
mobile CPUs this desired normal value is 7.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/kernel/cpu/intel_epb.c | 45 +++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index f4dd73396f28..fbaf12e43f41 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -16,6 +16,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/pm.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
 
@@ -58,6 +59,22 @@ static DEFINE_PER_CPU(u8, saved_epb);
 #define EPB_SAVED	0x10ULL
 #define MAX_EPB		EPB_MASK
 
+enum energy_perf_value_index {
+	EPB_INDEX_PERFORMANCE,
+	EPB_INDEX_BALANCE_PERFORMANCE,
+	EPB_INDEX_NORMAL,
+	EPB_INDEX_BALANCE_POWERSAVE,
+	EPB_INDEX_POWERSAVE,
+};
+
+static u8 energ_perf_values[] = {
+	[EPB_INDEX_PERFORMANCE] = ENERGY_PERF_BIAS_PERFORMANCE,
+	[EPB_INDEX_BALANCE_PERFORMANCE] = ENERGY_PERF_BIAS_BALANCE_PERFORMANCE,
+	[EPB_INDEX_NORMAL] = ENERGY_PERF_BIAS_NORMAL,
+	[EPB_INDEX_BALANCE_POWERSAVE] = ENERGY_PERF_BIAS_BALANCE_POWERSAVE,
+	[EPB_INDEX_POWERSAVE] = ENERGY_PERF_BIAS_POWERSAVE,
+};
+
 static int intel_epb_save(void)
 {
 	u64 epb;
@@ -90,7 +107,7 @@ static void intel_epb_restore(void)
 		 */
 		val = epb & EPB_MASK;
 		if (val == ENERGY_PERF_BIAS_PERFORMANCE) {
-			val = ENERGY_PERF_BIAS_NORMAL;
+			val = energ_perf_values[EPB_INDEX_NORMAL];
 			pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
 		}
 	}
@@ -103,18 +120,11 @@ static struct syscore_ops intel_epb_syscore_ops = {
 };
 
 static const char * const energy_perf_strings[] = {
-	"performance",
-	"balance-performance",
-	"normal",
-	"balance-power",
-	"power"
-};
-static const u8 energ_perf_values[] = {
-	ENERGY_PERF_BIAS_PERFORMANCE,
-	ENERGY_PERF_BIAS_BALANCE_PERFORMANCE,
-	ENERGY_PERF_BIAS_NORMAL,
-	ENERGY_PERF_BIAS_BALANCE_POWERSAVE,
-	ENERGY_PERF_BIAS_POWERSAVE
+	[EPB_INDEX_PERFORMANCE] = "performance",
+	[EPB_INDEX_BALANCE_PERFORMANCE] = "balance-performance",
+	[EPB_INDEX_NORMAL] = "normal",
+	[EPB_INDEX_BALANCE_POWERSAVE] = "balance-power",
+	[EPB_INDEX_POWERSAVE] = "power",
 };
 
 static ssize_t energy_perf_bias_show(struct device *dev,
@@ -193,13 +203,22 @@ static int intel_epb_offline(unsigned int cpu)
 	return 0;
 }
 
+static const struct x86_cpu_id intel_epb_normal[] = {
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, 7),
+	{}
+};
+
 static __init int intel_epb_init(void)
 {
+	const struct x86_cpu_id *id = x86_match_cpu(intel_epb_normal);
 	int ret;
 
 	if (!boot_cpu_has(X86_FEATURE_EPB))
 		return -ENODEV;
 
+	if (id)
+		energ_perf_values[EPB_INDEX_NORMAL] = id->driver_data;
+
 	ret = cpuhp_setup_state(CPUHP_AP_X86_INTEL_EPB_ONLINE,
 				"x86/intel/epb:online", intel_epb_online,
 				intel_epb_offline);
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273AA48B166
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349749AbiAKPyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:54:43 -0500
Received: from foss.arm.com ([217.140.110.172]:48650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349717AbiAKPym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:54:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21C826D;
        Tue, 11 Jan 2022 07:54:42 -0800 (PST)
Received: from e126645.arm.com (unknown [10.57.67.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 42BA23F774;
        Tue, 11 Jan 2022 07:54:40 -0800 (PST)
From:   Pierre Gondois <Pierre.Gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Lukasz Luba <lukasz.luba@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2] cpufreq: CPPC: Fix performance/frequency conversion
Date:   Tue, 11 Jan 2022 16:54:19 +0100
Message-Id: <20220111155419.943980-1-Pierre.Gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUfreq governors request CPU frequencies using information
on current CPU usage. The CPPC driver converts them to
performance requests. Frequency targets are computed as:
	target_freq = (util / cpu_capacity) * max_freq
target_freq is then clamped between [policy->min, policy->max].

The CPPC driver converts performance values to frequencies
(and vice-versa) using cppc_cpufreq_perf_to_khz() and
cppc_cpufreq_khz_to_perf(). These functions both use two different
factors depending on the range of the input value. For
cppc_cpufreq_khz_to_perf():
- (NOMINAL_PERF / NOMINAL_FREQ) or
- (LOWEST_PERF / LOWEST_FREQ)
and for cppc_cpufreq_perf_to_khz():
- (NOMINAL_FREQ / NOMINAL_PERF) or
- ((NOMINAL_PERF - LOWEST_FREQ) / (NOMINAL_PERF - LOWEST_PERF))

This means:
1- the functions are not inverse for some values:
   (perf_to_khz(khz_to_perf(x)) != x)
2- cppc_cpufreq_perf_to_khz(LOWEST_PERF) can sometimes give
   a different value from LOWEST_FREQ due to integer approximation
3- it is implied that performance and frequency are proportional
   (NOMINAL_FREQ / NOMINAL_PERF) == (LOWEST_PERF / LOWEST_FREQ)

This patch changes the conversion functions to an affine function.
This fixes the 3 points above.

Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 43 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index db17196266e4..5024d9af2e6e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -303,52 +303,48 @@ static u64 cppc_get_dmi_max_khz(void)
 
 /*
  * If CPPC lowest_freq and nominal_freq registers are exposed then we can
- * use them to convert perf to freq and vice versa
- *
- * If the perf/freq point lies between Nominal and Lowest, we can treat
- * (Low perf, Low freq) and (Nom Perf, Nom freq) as 2D co-ordinates of a line
- * and extrapolate the rest
- * For perf/freq > Nominal, we use the ratio perf:freq at Nominal for conversion
+ * use them to convert perf to freq and vice versa. The conversion is
+ * extrapolated as an affine function passing by the 2 points:
+ *  - (Low perf, Low freq)
+ *  - (Nominal perf, Nominal perf)
  */
 static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu_data,
 					     unsigned int perf)
 {
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	s64 retval, offset = 0;
 	static u64 max_khz;
 	u64 mul, div;
 
 	if (caps->lowest_freq && caps->nominal_freq) {
-		if (perf >= caps->nominal_perf) {
-			mul = caps->nominal_freq;
-			div = caps->nominal_perf;
-		} else {
-			mul = caps->nominal_freq - caps->lowest_freq;
-			div = caps->nominal_perf - caps->lowest_perf;
-		}
+		mul = caps->nominal_freq - caps->lowest_freq;
+		div = caps->nominal_perf - caps->lowest_perf;
+		offset = caps->nominal_freq - (u64)caps->nominal_perf * mul / div;
 	} else {
 		if (!max_khz)
 			max_khz = cppc_get_dmi_max_khz();
 		mul = max_khz;
 		div = caps->highest_perf;
 	}
-	return (u64)perf * mul / div;
+
+	retval = offset + (u64)perf * mul / div;
+	if (retval >= 0)
+		return retval;
+	return 0;
 }
 
 static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu_data,
 					     unsigned int freq)
 {
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	s64 retval, offset = 0;
 	static u64 max_khz;
 	u64  mul, div;
 
 	if (caps->lowest_freq && caps->nominal_freq) {
-		if (freq >= caps->nominal_freq) {
-			mul = caps->nominal_perf;
-			div = caps->nominal_freq;
-		} else {
-			mul = caps->lowest_perf;
-			div = caps->lowest_freq;
-		}
+		mul = caps->nominal_perf - caps->lowest_perf;
+		div = caps->nominal_freq - caps->lowest_freq;
+		offset = caps->nominal_perf - (u64)caps->nominal_freq * mul / div;
 	} else {
 		if (!max_khz)
 			max_khz = cppc_get_dmi_max_khz();
@@ -356,7 +352,10 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu_data,
 		div = max_khz;
 	}
 
-	return (u64)freq * mul / div;
+	retval = offset + (u64)freq * mul / div;
+	if (retval >= 0)
+		return retval;
+	return 0;
 }
 
 static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
-- 
2.25.1


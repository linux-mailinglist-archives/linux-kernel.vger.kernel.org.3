Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8703D4AD2A6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345402AbiBHIBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348684AbiBHIA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:00:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94760C0401EF;
        Tue,  8 Feb 2022 00:00:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F50911D4;
        Tue,  8 Feb 2022 00:00:55 -0800 (PST)
Received: from e126645.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 72AE63F718;
        Tue,  8 Feb 2022 00:00:53 -0800 (PST)
From:   Pierre Gondois <Pierre.Gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Lukasz.Luba@arm.com,
        Morten.Rasmussen@arm.com, Pierre Gondois <Pierre.Gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3] cpufreq: CPPC: Fix performance/frequency conversion
Date:   Tue,  8 Feb 2022 09:01:09 +0100
Message-Id: <20220208080109.697904-1-Pierre.Gondois@arm.com>
X-Mailer: git-send-email 2.25.1
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
index d4c27022b9c9..e0ff09d66c96 100644
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
+		offset = caps->nominal_freq - div64_u64(caps->nominal_perf * mul, div);
 	} else {
 		if (!max_khz)
 			max_khz = cppc_get_dmi_max_khz();
 		mul = max_khz;
 		div = caps->highest_perf;
 	}
-	return (u64)perf * mul / div;
+
+	retval = offset + div64_u64(perf * mul, div);
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
+		offset = caps->nominal_perf - div64_u64(caps->nominal_freq * mul, div);
 	} else {
 		if (!max_khz)
 			max_khz = cppc_get_dmi_max_khz();
@@ -356,7 +352,10 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu_data,
 		div = max_khz;
 	}
 
-	return (u64)freq * mul / div;
+	retval = offset + div64_u64(freq * mul, div);
+	if (retval >= 0)
+		return retval;
+	return 0;
 }
 
 static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
-- 
2.25.1


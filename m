Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1025815D3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbiGZPAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239184AbiGZPAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:00:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A15B1DEB7;
        Tue, 26 Jul 2022 08:00:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0768D1FB;
        Tue, 26 Jul 2022 08:00:21 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49D633F73B;
        Tue, 26 Jul 2022 08:00:20 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        robert.moore@intel.com, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] ACPI: CPPC: Disable FIE if registers in PCC regions
Date:   Tue, 26 Jul 2022 09:59:48 -0500
Message-Id: <20220726145948.2194684-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCC regions utilize a mailbox to set/retrieve register values used by
the CPPC code. This is fine as long as the operations are
infrequent. With the FIE code enabled though the overhead can range
from 2-11% of system CPU overhead (ex: as measured by top) on Arm
based machines.

So, before enabling FIE assure none of the registers used by
cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
enable a module parameter which can also disable it at boot or module
reload.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/cppc_acpi.c       | 31 +++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 19 +++++++++++++++----
 include/acpi/cppc_acpi.h       |  5 +++++
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 3c6d4ef87be0..ad84c55b6409 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1246,6 +1246,37 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
 
+int cppc_perf_ctrs_in_pcc(void)
+{
+	int cpu;
+	struct cpc_desc *cpc_desc;
+	struct cpc_register_resource *delivered_reg, *reference_reg,
+		*ref_perf_reg, *ctr_wrap_reg;
+
+	for_each_present_cpu(cpu) {
+		cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+		delivered_reg = &cpc_desc->cpc_regs[DELIVERED_CTR];
+		reference_reg = &cpc_desc->cpc_regs[REFERENCE_CTR];
+		ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
+		ctr_wrap_reg = &cpc_desc->cpc_regs[CTR_WRAP_TIME];
+
+		/*
+		 * If reference perf register is not supported then we should
+		 * use the nominal perf value
+		 */
+		if (!CPC_SUPPORTED(ref_perf_reg))
+			ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
+
+		/* Are any of the regs PCC ?*/
+		if (CPC_IN_PCC(delivered_reg) || CPC_IN_PCC(reference_reg) ||
+			CPC_IN_PCC(ctr_wrap_reg) || CPC_IN_PCC(ref_perf_reg)) {
+			return true;
+		}
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
+
 /**
  * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
  * @cpunum: CPU from which to read counters.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 24eaf0ec344d..a66d3013d0f8 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -63,6 +63,10 @@ static struct cppc_workaround_oem_info wa_info[] = {
 
 static struct cpufreq_driver cppc_cpufreq_driver;
 
+static bool fie_disabled;
+module_param(fie_disabled, bool, 0444);
+MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE)");
+
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 
 /* Frequency invariance support */
@@ -158,7 +162,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 	struct cppc_freq_invariance *cppc_fi;
 	int cpu, ret;
 
-	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
+	if (fie_disabled)
 		return;
 
 	for_each_cpu(cpu, policy->cpus) {
@@ -199,7 +203,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
 	struct cppc_freq_invariance *cppc_fi;
 	int cpu;
 
-	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
+	if (fie_disabled)
 		return;
 
 	/* policy->cpus will be empty here, use related_cpus instead */
@@ -229,7 +233,12 @@ static void __init cppc_freq_invariance_init(void)
 	};
 	int ret;
 
-	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
+	if (cppc_perf_ctrs_in_pcc()) {
+		pr_debug("FIE not enabled on systems with registers in PCC\n");
+		fie_disabled = true;
+	}
+
+	if (fie_disabled)
 		return;
 
 	kworker_fie = kthread_create_worker(0, "cppc_fie");
@@ -247,7 +256,7 @@ static void __init cppc_freq_invariance_init(void)
 
 static void cppc_freq_invariance_exit(void)
 {
-	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
+	if (fie_disabled)
 		return;
 
 	kthread_destroy_worker(kworker_fie);
@@ -940,6 +949,8 @@ static void cppc_check_hisi_workaround(void)
 		}
 	}
 
+	fie_disabled = true;
+
 	acpi_put_table(tbl);
 }
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index d389bab54241..f4ff571fcdcb 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -140,6 +140,7 @@ extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_enable(int cpu, bool enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
+extern int cppc_perf_ctrs_in_pcc(void);
 extern bool acpi_cpc_valid(void);
 extern bool cppc_allow_fast_switch(void);
 extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
@@ -173,6 +174,10 @@ static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
 {
 	return -ENOTSUPP;
 }
+extern int cppc_perf_ctrs_in_pcc(void)
+{
+	return false;
+}
 static inline bool acpi_cpc_valid(void)
 {
 	return false;
-- 
2.37.1


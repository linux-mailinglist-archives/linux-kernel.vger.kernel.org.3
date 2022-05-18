Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5345E52B61D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiERJJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiERJJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:09:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D34E13F928;
        Wed, 18 May 2022 02:09:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4682B1042;
        Wed, 18 May 2022 02:09:30 -0700 (PDT)
Received: from pierre123.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB7183F66F;
        Wed, 18 May 2022 02:09:27 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, dietmar.eggemann@arm.com,
        sudeep.holla@arm.com, Pierre Gondois <Pierre.Gondois@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH v2 4/5] cpufreq: CPPC: Enable fast_switch
Date:   Wed, 18 May 2022 11:09:00 +0200
Message-Id: <20220518090901.2724518-4-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518090901.2724518-1-pierre.gondois@arm.com>
References: <20220518090901.2724518-1-pierre.gondois@arm.com>
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

From: Pierre Gondois <Pierre.Gondois@arm.com>

The communication mean of the _CPC desired performance can be
PCC, System Memory, System IO, or Functional Fixed Hardware.

commit b7898fda5bc7 ("cpufreq: Support for fast frequency switching")
fast_switching is 'for switching CPU frequencies from interrupt
context'.
Writes to SystemMemory and SystemIo are fast and suitable this.
This is not the case for PCC and might not be the case for FFH.

Enable fast_switching for the cppc_cpufreq driver in above cases.

Add cppc_allow_fast_switch() to check the desired performance
register address space and set fast_switching accordingly.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/acpi/cppc_acpi.c       | 18 ++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 24 ++++++++++++++++++++++++
 include/acpi/cppc_acpi.h       |  5 +++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 840223c12540..3b299b28a8af 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -434,6 +434,24 @@ bool acpi_cpc_valid(void)
 }
 EXPORT_SYMBOL_GPL(acpi_cpc_valid);
 
+bool cppc_allow_fast_switch(void)
+{
+	struct cpc_register_resource *desired_reg;
+	struct cpc_desc *cpc_ptr;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
+		desired_reg = &cpc_ptr->cpc_regs[DESIRED_PERF];
+		if (!CPC_IN_SYSTEM_MEMORY(desired_reg) &&
+				!CPC_IN_SYSTEM_IO(desired_reg))
+			return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(cppc_allow_fast_switch);
+
 /**
  * acpi_get_psd_map - Map the CPUs in the freq domain of a given cpu
  * @cpu: Find all CPUs that share a domain with cpu.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 82d370ae6a4a..000a0c610c30 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -389,6 +389,27 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 	return ret;
 }
 
+static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
+					      unsigned int target_freq)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int cpu = policy->cpu;
+	u32 desired_perf;
+	int ret;
+
+	desired_perf = cppc_cpufreq_khz_to_perf(cpu_data, target_freq);
+	cpu_data->perf_ctrls.desired_perf = desired_perf;
+	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+
+	if (ret) {
+		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
+			 cpu, ret);
+		return 0;
+	}
+
+	return target_freq;
+}
+
 static int cppc_verify_policy(struct cpufreq_policy_data *policy)
 {
 	cpufreq_verify_within_cpu_limits(policy);
@@ -536,6 +557,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		goto out;
 	}
 
+	policy->fast_switch_possible = cppc_allow_fast_switch();
+
 	/*
 	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
 	 * is supported.
@@ -681,6 +704,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.verify = cppc_verify_policy,
 	.target = cppc_cpufreq_set_target,
 	.get = cppc_cpufreq_get_rate,
+	.fast_switch = cppc_cpufreq_fast_switch,
 	.init = cppc_cpufreq_cpu_init,
 	.exit = cppc_cpufreq_cpu_exit,
 	.set_boost = cppc_cpufreq_set_boost,
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 92b7ea8d8f5e..c6108581d97d 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -141,6 +141,7 @@ extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_enable(int cpu, bool enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern bool acpi_cpc_valid(void);
+extern bool cppc_allow_fast_switch(void);
 extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
 extern unsigned int cppc_get_transition_latency(int cpu);
 extern bool cpc_ffh_supported(void);
@@ -175,6 +176,10 @@ static inline bool acpi_cpc_valid(void)
 {
 	return false;
 }
+static inline bool cppc_allow_fast_switch(void)
+{
+	return false;
+}
 static inline unsigned int cppc_get_transition_latency(int cpu)
 {
 	return CPUFREQ_ETERNAL;
-- 
2.25.1


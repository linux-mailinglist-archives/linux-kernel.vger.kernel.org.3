Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CC94CAD04
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244438AbiCBSK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244437AbiCBSKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:10:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17FF67E58E;
        Wed,  2 Mar 2022 10:10:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2B821424;
        Wed,  2 Mar 2022 10:10:06 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.195.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0EB7E3F73D;
        Wed,  2 Mar 2022 10:10:04 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sean Kelley <skelley@nvidia.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/3] arch_topology: obtain cpu capacity using information from CPPC
Date:   Wed,  2 Mar 2022 18:09:12 +0000
Message-Id: <20220302180913.13229-3-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
In-Reply-To: <20220302180913.13229-1-ionela.voinescu@arm.com>
References: <20220302180913.13229-1-ionela.voinescu@arm.com>
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

Define topology_init_cpu_capacity_cppc() to use highest performance
values from _CPC objects to obtain and set maximum capacity information
for each CPU. acpi_cppc_processor_probe() is a good point at which to
trigger the initialization of CPU (u-arch) capacity values, as at this
point the highest performance values can be obtained from each CPU's
_CPC objects. Architectures can therefore use this functionality
through arch_init_invariance_cppc().

The performance scale used by CPPC is a unified scale for all CPUs in
the system. Therefore, by obtaining the raw highest performance values
from the _CPC objects, and normalizing them on the [0, 1024] capacity
scale, used by the task scheduler, we obtain the CPU capacity of each
CPU.

While an ACPI Notify(0x85) could alert about a change in the highest
performance value, which should in turn retrigger the CPU capacity
computations, this notification is not currently handled by the ACPI
processor driver. When supported, a call to arch_init_invariance_cppc()
would perform the update.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c  | 40 +++++++++++++++++++++++++++++++++++
 include/linux/arch_topology.h |  4 ++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 976154140f0b..ad2d95920ad1 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -339,6 +339,46 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 	return !ret;
 }
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+#include <acpi/cppc_acpi.h>
+
+void topology_init_cpu_capacity_cppc(void)
+{
+	struct cppc_perf_caps perf_caps;
+	int cpu;
+
+	if (likely(acpi_disabled || !acpi_cpc_valid()))
+		return;
+
+	raw_capacity = kcalloc(num_possible_cpus(), sizeof(*raw_capacity),
+			       GFP_KERNEL);
+	if (!raw_capacity)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		if (!cppc_get_perf_caps(cpu, &perf_caps) &&
+		    (perf_caps.highest_perf >= perf_caps.nominal_perf) &&
+		    (perf_caps.highest_perf >= perf_caps.lowest_perf)) {
+			raw_capacity[cpu] = perf_caps.highest_perf;
+			pr_debug("cpu_capacity: CPU%d cpu_capacity=%u (raw).\n",
+				 cpu, raw_capacity[cpu]);
+			continue;
+		}
+
+		pr_err("cpu_capacity: CPU%d missing/invalid highest performance.\n", cpu);
+		pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
+		goto exit;
+	}
+
+	topology_normalize_cpu_scale();
+	schedule_work(&update_topology_flags_work);
+	pr_debug("cpu_capacity: cpu_capacity initialization done\n");
+
+exit:
+	free_raw_capacity();
+}
+#endif
+
 #ifdef CONFIG_CPU_FREQ
 static cpumask_var_t cpus_to_visit;
 static void parsing_done_workfn(struct work_struct *work);
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index cce6136b300a..58cbe18d825c 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -11,6 +11,10 @@
 void topology_normalize_cpu_scale(void);
 int topology_update_cpu_topology(void);
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+void topology_init_cpu_capacity_cppc(void);
+#endif
+
 struct device_node;
 bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D204DC7B2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiCQNhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiCQNhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:37:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6E361DB8AF;
        Thu, 17 Mar 2022 06:35:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F7121570;
        Thu, 17 Mar 2022 06:35:51 -0700 (PDT)
Received: from e126645.arm.com (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 084393F766;
        Thu, 17 Mar 2022 06:35:46 -0700 (PDT)
From:   Pierre Gondois <Pierre.Gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Lukasz.Luba@arm.com,
        Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com,
        mka@chromium.org, daniel.lezcano@linaro.org,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>, Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v1 2/3] cpufreq: CPPC: Add per_cpu efficiency_class
Date:   Thu, 17 Mar 2022 14:34:16 +0100
Message-Id: <20220317133419.3901736-3-Pierre.Gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317133419.3901736-1-Pierre.Gondois@arm.com>
References: <20220317133419.3901736-1-Pierre.Gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ACPI, describing power efficiency of CPUs can be done through the
following arm specific field:
ACPI 6.4, s5.2.12.14 'GIC CPU Interface (GICC) Structure',
'Processor Power Efficiency Class field':
  Describes the relative power efficiency of the associated pro-
  cessor. Lower efficiency class numbers are more efficient than
  higher ones (e.g. efficiency class 0 should be treated as more
  efficient than efficiency class 1). However, absolute values
  of this number have no meaning: 2 isn’t necessarily half as
  efficient as 1.

The efficiency_class field is stored in the GicC structure of the
ACPI MADT table and it's currently supported in Linux for arm64 only.
Thus, this new functionality is introduced for arm64 only.

To allow the cppc_cpufreq driver to know and preprocess the
efficiency_class values of all the CPUs, add a per_cpu efficiency_class
variable to store them. Also add a static efficiency_class_populated
to let the driver know efficiency_class values are usable and register
an artificial Energy Model (EM) based on normalized class values.

At least 2 different efficiency classes must be present,
otherwise there is no use in creating an Energy Model.

The efficiency_class values are squeezed in [0:#efficiency_class-1]
while conserving the order. For instance, efficiency classes of:
  [111, 212, 250]
will be mapped to:
  [0 (was 111), 1 (was 212), 2 (was 250)].

Each policy being independently registered in the driver, populating
the per_cpu efficiency_class is done only once at the driver
initialization. This prevents from having each policy re-searching the
efficiency_class values of other CPUs.

The patch also exports acpi_cpu_get_madt_gicc() to fetch the GicC
structure of the ACPI MADT table for each CPU.

Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
---
 arch/arm64/kernel/smp.c        |  1 +
 drivers/cpufreq/cppc_cpufreq.c | 55 ++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 27df5c1e6baa..56637cbea5d6 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -512,6 +512,7 @@ struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu)
 {
 	return &cpu_madt_gicc[cpu];
 }
+EXPORT_SYMBOL(acpi_cpu_get_madt_gicc);
 
 /*
  * acpi_map_gic_cpu_interface - parse processor MADT entry
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 8f950fe72765..a6cd95c3b474 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -422,12 +422,66 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
 }
 
+static bool efficiency_class_populated;
+static DEFINE_PER_CPU(unsigned int, efficiency_class);
+
+static int populate_efficiency_class(void)
+{
+	unsigned int min = UINT_MAX, max = 0, class;
+	struct acpi_madt_generic_interrupt *gicc;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		gicc = acpi_cpu_get_madt_gicc(cpu);
+		if (!gicc)
+			return -ENODEV;
+
+		per_cpu(efficiency_class, cpu) = gicc->efficiency_class;
+		min = min_t(unsigned int, min, gicc->efficiency_class);
+		max = max_t(unsigned int, max, gicc->efficiency_class);
+	}
+
+	if (min == max) {
+		pr_debug("Efficiency classes are all equal (=%d). "
+			"No EM registered", max);
+		return -EINVAL;
+	}
+
+	/*
+	 * Squeeze efficiency class values on [0:#efficiency_class-1].
+	 * Values are per spec in [0:255].
+	 */
+	for (class = 0; class < 256; class++) {
+		unsigned int new_min, curr;
+
+		new_min = UINT_MAX;
+		for_each_possible_cpu(cpu) {
+			curr = per_cpu(efficiency_class, cpu);
+			if (curr == min)
+				per_cpu(efficiency_class, cpu) = class;
+			else if (curr > min)
+				new_min = min(new_min, curr);
+		}
+
+		if (new_min == UINT_MAX)
+			break;
+		min = new_min;
+	}
+
+	efficiency_class_populated = true;
+	return 0;
+}
+
 #else
 
 static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 {
 	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
 }
+static int populate_efficiency_class(void)
+{
+	return 0;
+}
 #endif
 
 
@@ -757,6 +811,7 @@ static int __init cppc_cpufreq_init(void)
 
 	cppc_check_hisi_workaround();
 	cppc_freq_invariance_init();
+	populate_efficiency_class();
 
 	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
 	if (ret)
-- 
2.25.1


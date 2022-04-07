Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31874F7966
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242866AbiDGIUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbiDGIUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:20:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7985F7B126;
        Thu,  7 Apr 2022 01:18:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47B9B11FB;
        Thu,  7 Apr 2022 01:18:35 -0700 (PDT)
Received: from e126645.nice.arm.com (e126645.nice.arm.com [10.34.129.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2BD3E3F5A1;
        Thu,  7 Apr 2022 01:18:31 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Lukasz.Luba@arm.com,
        Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com, maz@kernel.org,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>, Rob Herring <robh@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 2/3] cpufreq: CPPC: Add per_cpu efficiency_class
Date:   Thu,  7 Apr 2022 10:16:17 +0200
Message-Id: <20220407081620.1662192-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407081620.1662192-1-pierre.gondois@arm.com>
References: <20220407081620.1662192-1-pierre.gondois@arm.com>
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

From: Pierre Gondois <Pierre.Gondois@arm.com>

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
 drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 27df5c1e6baa..67243011279d 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -512,6 +512,7 @@ struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu)
 {
 	return &cpu_madt_gicc[cpu];
 }
+EXPORT_SYMBOL_GPL(acpi_cpu_get_madt_gicc);
 
 /*
  * acpi_map_gic_cpu_interface - parse processor MADT entry
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index ffcd9704add2..67a9f48939b6 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -422,12 +422,55 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
 }
 
+static bool efficiency_class_populated;
+static DEFINE_PER_CPU(unsigned int, efficiency_class);
+
+static int populate_efficiency_class(void)
+{
+	struct acpi_madt_generic_interrupt *gicc;
+	DECLARE_BITMAP(used_classes, 256) = {};
+	int class, cpu, index;
+
+	for_each_possible_cpu(cpu) {
+		gicc = acpi_cpu_get_madt_gicc(cpu);
+		class = gicc->efficiency_class;
+		bitmap_set(used_classes, class, 1);
+	}
+
+	if (bitmap_weight(used_classes, 256) <= 1) {
+		pr_debug("Efficiency classes are all equal (=%d). "
+			"No EM registered", class);
+		return -EINVAL;
+	}
+
+	/*
+	 * Squeeze efficiency class values on [0:#efficiency_class-1].
+	 * Values are per spec in [0:255].
+	 */
+	index = 0;
+	for_each_set_bit(class, used_classes, 256) {
+		for_each_possible_cpu(cpu) {
+			gicc = acpi_cpu_get_madt_gicc(cpu);
+			if (gicc->efficiency_class == class)
+				per_cpu(efficiency_class, cpu) = index;
+		}
+		index++;
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
 
 
@@ -757,6 +800,7 @@ static int __init cppc_cpufreq_init(void)
 
 	cppc_check_hisi_workaround();
 	cppc_freq_invariance_init();
+	populate_efficiency_class();
 
 	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
 	if (ret)
-- 
2.25.1


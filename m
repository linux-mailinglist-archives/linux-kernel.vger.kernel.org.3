Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F2F53FF71
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244249AbiFGMyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244237AbiFGMyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:54:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D096D6FD00
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:54:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B1DE11FB;
        Tue,  7 Jun 2022 05:54:10 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.195.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 742BC3F73B;
        Tue,  7 Jun 2022 05:54:09 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: errata: add detection for AMEVCNTR01 incrementing incorrectly
Date:   Tue,  7 Jun 2022 13:53:40 +0100
Message-Id: <20220607125340.13635-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMU counter AMEVCNTR01 (constant counter) should increment at the same
rate as the system counter. On affected Cortex-A510 cores, AMEVCNTR01
increments incorrectly giving a significantly higher output value. This
results in inaccurate task scheduler utilization tracking and incorrect
feedback on CPU frequency.

Work around this problem in the arm64 topology code by always returning 0
when reading the affected counter. This will disable all users of this
counter from using it either for frequency invariance or as FFH reference
counter. This effect is the same to firmware disabling affected counters.

Details on how the two features are affected by this erratum:

 - AMU counters will not be used for frequency invariance for affected
   CPUs and CPUs in the same cpufreq policy. AMUs can still be used for
   frequency invariance for unaffected CPUs in the system. Although
   unlikely, if no alternative method can be found to support frequency
   invariance for affected CPUs (cpufreq based or solution based on
   platform counters) frequency invariance will be disabled. Please check
   the chapter on frequency invariance at
   Documentation/scheduler/sched-capacity.rst for details of its effect.

 - Given that FFH can be used to fetch either the core or constant counter
   values, restrictions are lifted regarding any of these counters
   returning a valid (!0) value. Therefore FFH is considered supported
   if there is a least one CPU that support AMUs, independent of any
   counters being enabled or affected by this erratum.

The above is achieved through adding a new erratum: ARM64_ERRATUM_2457168.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: James Morse <james.morse@arm.com>
---

Hi,


This patch is based on the information in the A510 Errata Notice,
version 13.0 at [1] and applies on v5.19-rc1.

[1] https://developer.arm.com/documentation/SDEN2397589/1300/?lang=en

Thanks,
Ionela.

 Documentation/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                     | 18 ++++++++++++++++++
 arch/arm64/include/asm/cpufeature.h    |  5 +++++
 arch/arm64/kernel/cpufeature.c         | 13 +++++++++++++
 arch/arm64/kernel/topology.c           | 10 ++++++++--
 5 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index d27db84d585e..d9aff50c26cd 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -52,6 +52,8 @@ stable kernels.
 | Allwinner      | A64/R18         | UNKNOWN1        | SUN50I_ERRATUM_UNKNOWN1     |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2064142        | ARM64_ERRATUM_2064142       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2038923        | ARM64_ERRATUM_2038923       |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1652a9800ebe..a7bab0312261 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -880,6 +880,24 @@ config ARM64_ERRATUM_1902691
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_2457168
+	bool "Cortex-A510: 2457168: workaround for AMEVCNTR01 incrementing incorrectly"
+	depends on ARM64_AMU_EXTN
+	default y
+	help
+	  This option adds the workaround for ARM Cortex-A510 erratum 2457168.
+
+	  The AMU counter AMEVCNTR01 (constant counter) should increment at the same rate
+	  as the system counter. On affected Cortex-A510 cores AMEVCNTR01 increments
+	  incorrectly giving a significantly higher output value.
+
+	  Work around this problem in the arm64 topology code by always returning 0 when
+	  reading the affected counter. This will disable all users of this counter from
+	  using it. This effect is the same as firmware disabling affected counters.
+
+	  If unsure, say Y.
+
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 14a8f3d93add..80e0c700cecf 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -881,11 +881,16 @@ static inline bool cpu_has_pan(void)
 #ifdef CONFIG_ARM64_AMU_EXTN
 /* Check whether the cpu supports the Activity Monitors Unit (AMU) */
 extern bool cpu_has_amu_feat(int cpu);
+extern bool cpu_has_broken_amu_constcnt(void);
 #else
 static inline bool cpu_has_amu_feat(int cpu)
 {
 	return false;
 }
+static inline bool cpu_has_broken_amu_constcnt(void)
+{
+	return false;
+}
 #endif
 
 /* Get a cpu that supports the Activity Monitors Unit (AMU) */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 42ea2bd856c6..b9e4b2bd2c63 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1791,6 +1791,19 @@ int get_cpu_with_amu_feat(void)
 	return cpumask_any(&amu_cpus);
 }
 
+bool cpu_has_broken_amu_constcnt(void)
+{
+	/* List of CPUs which have broken AMEVCNTR01 (constant counter) */
+	static const struct midr_range cpus[] = {
+#ifdef CONFIG_ARM64_ERRATUM_2457168
+		MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1),
+#endif
+		{},
+	};
+
+	return is_midr_in_range(read_cpuid_id(), cpus);
+}
+
 static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
 {
 	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU)) {
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 9ab78ad826e2..d4b0b0a40515 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -127,7 +127,8 @@ int __init parse_acpi_topology(void)
 
 #ifdef CONFIG_ARM64_AMU_EXTN
 #define read_corecnt()	read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0)
-#define read_constcnt()	read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0)
+#define read_constcnt()	(cpu_has_broken_amu_constcnt() ? 0UL : \
+			read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0))
 #else
 #define read_corecnt()	(0UL)
 #define read_constcnt()	(0UL)
@@ -342,7 +343,12 @@ int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
  */
 bool cpc_ffh_supported(void)
 {
-	return freq_counters_valid(get_cpu_with_amu_feat());
+	int cpu = get_cpu_with_amu_feat();
+
+	if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
+		return false;
+
+	return true;
 }
 
 int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E446596E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239389AbiHQMQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiHQMQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:16:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A04F2861CC
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:16:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 247A2113E;
        Wed, 17 Aug 2022 05:16:05 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.195.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6EA793F67D;
        Wed, 17 Aug 2022 05:16:03 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: [RESEND PATCH v2] arm64: errata: add detection for AMEVCNTR01 incrementing incorrectly
Date:   Wed, 17 Aug 2022 13:15:51 +0100
Message-Id: <20220817121551.21790-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Work around this problem by returning 0 when reading the affected counter
in key locations that results in disabling all users of this counter from
using it either for frequency invariance or as FFH reference counter. This
effect is the same to firmware disabling affected counters.

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
version 13.0 at [1] and applies on v5.19-rc5.

v2 RESEND: v2 rebased on 6.0-rc1

v1 -> v2:
 - v1 at [2]
 - Move detection of erratum in cpu_errata.c
 - Limit checking for affected CPUs to the init phase for FIE (Frequency
   Invariance Engine). For FFH we'll still check for affected CPUs at each
   read of the constant counter, but reads happen less often (driven by
   sysfs reads) compared to FIE (on the tick).

[1] https://developer.arm.com/documentation/SDEN2397589/1300/?lang=en
[2] https://lore.kernel.org/lkml/20220607125340.13635-1-ionela.voinescu@arm.com/

Thanks,
Ionela.


 Documentation/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                     | 17 +++++++++++++++++
 arch/arm64/kernel/cpu_errata.c         | 10 ++++++++++
 arch/arm64/kernel/cpufeature.c         |  5 ++++-
 arch/arm64/kernel/topology.c           | 10 ++++++++--
 arch/arm64/tools/cpucaps               |  1 +
 6 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 33b04db8408f..fda97b3fcf01 100644
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
index 571cc234d0b3..9fb9fff08c94 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -917,6 +917,23 @@ config ARM64_ERRATUM_1902691
 
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
+	  Work around this problem by returning 0 when reading the affected counter in
+	  key locations that results in disabling all users of this counter. This effect
+	  is the same to firmware disabling affected counters.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 7e6289e709fc..810dd3c39882 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -654,6 +654,16 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2)
 	},
 #endif
+#ifdef CONFIG_ARM64_ERRATUM_2457168
+	{
+		.desc = "ARM erratum 2457168",
+		.capability = ARM64_WORKAROUND_2457168,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
+
+		/* Cortex-A510 r0p0-r1p1 */
+		CAP_MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1)
+	},
+#endif
 #ifdef CONFIG_ARM64_ERRATUM_2038923
 	{
 		.desc = "ARM erratum 2038923",
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 907401e4fffb..af4de817d712 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1870,7 +1870,10 @@ static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
 		pr_info("detected CPU%d: Activity Monitors Unit (AMU)\n",
 			smp_processor_id());
 		cpumask_set_cpu(smp_processor_id(), &amu_cpus);
-		update_freq_counters_refs();
+
+		/* 0 reference values signal broken/disabled counters */
+		if (!this_cpu_has_cap(ARM64_WORKAROUND_2457168))
+			update_freq_counters_refs();
 	}
 }
 
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 869ffc4d4484..5d7efb15f7cf 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -301,7 +301,8 @@ static void cpu_read_corecnt(void *val)
 
 static void cpu_read_constcnt(void *val)
 {
-	*(u64 *)val = read_constcnt();
+	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_2457168) ?
+		      0UL : read_constcnt();
 }
 
 static inline
@@ -328,7 +329,12 @@ int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
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
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 779653771507..63b2484ce6c3 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -67,6 +67,7 @@ WORKAROUND_1902691
 WORKAROUND_2038923
 WORKAROUND_2064142
 WORKAROUND_2077057
+WORKAROUND_2457168
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
 WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
-- 
2.25.1


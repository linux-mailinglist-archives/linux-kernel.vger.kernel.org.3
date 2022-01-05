Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF29484D3C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 06:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbiAEFGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 00:06:24 -0500
Received: from foss.arm.com ([217.140.110.172]:39178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232448AbiAEFGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 00:06:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7167B1042;
        Tue,  4 Jan 2022 21:06:20 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.72.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 740C03F66F;
        Tue,  4 Jan 2022 21:06:17 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] coresight: trbe: Work around the ignored system register writes
Date:   Wed,  5 Jan 2022 10:35:57 +0530
Message-Id: <1641359159-22726-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641359159-22726-1-git-send-email-anshuman.khandual@arm.com>
References: <1641359159-22726-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TRBE implementations affected by Arm erratum #2064142 might fail to write
into certain system registers after the TRBE has been disabled. Under some
conditions after TRBE has been disabled, writes into certain TRBE registers
TRBLIMITR_EL1, TRBPTR_EL1, TRBBASER_EL1, TRBSR_EL1 and TRBTRG_EL1 will be
ignored and not be effected.

Work around this problem in the TRBE driver by executing TSB CSYNC and DSB
just after the trace collection has stopped and before performing a system
register write to one of the affected registers. This adds a new cpu errata
in arm64 errata framework and also updates TRBE driver as required.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-doc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/arm64/silicon-errata.rst       |  2 +
 arch/arm64/Kconfig                           | 18 +++++++
 arch/arm64/kernel/cpu_errata.c               |  9 ++++
 arch/arm64/tools/cpucaps                     |  1 +
 drivers/hwtracing/coresight/coresight-trbe.c | 54 ++++++++++++++------
 drivers/hwtracing/coresight/coresight-trbe.h |  8 ---
 6 files changed, 68 insertions(+), 24 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 5342e895fb60..c9b30e6c2b6c 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -52,6 +52,8 @@ stable kernels.
 | Allwinner      | A64/R18         | UNKNOWN1        | SUN50I_ERRATUM_UNKNOWN1     |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #2064142        | ARM64_ERRATUM_2064142       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319        |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319        |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf9bb17..2105b68d88db 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -778,6 +778,24 @@ config ARM64_ERRATUM_2224489
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_2064142
+	bool "Cortex-A510: 2064142: workaround TRBE register writes while disabled"
+	depends on CORESIGHT_TRBE
+	default y
+	help
+	  This option adds the workaround for ARM Cortex-A510 erratum 2064142.
+
+	  Affected Cortex-A510 core might fail to write into system registers after the
+	  TRBE has been disabled. Under some conditions after the TRBE has been disabled
+	  writes into TRBE registers TRBLIMITR_EL1, TRBPTR_EL1, TRBBASER_EL1, TRBSR_EL1,
+	  and TRBTRG_EL1 will be ignored and will not be effected.
+
+	  Work around this in the driver by executing TSB CSYNC and DSB after collection
+	  is stopped and before performing a system register write to one of the affected
+	  registers.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 9e1c1aef9ebd..cbb7d5a9aee7 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -597,6 +597,15 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
 		CAP_MIDR_RANGE_LIST(trbe_write_out_of_range_cpus),
 	},
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_2064142
+	{
+		.desc = "ARM erratum 2064142",
+		.capability = ARM64_WORKAROUND_2064142,
+
+		/* Cortex-A510 r0p0 - r0p2 */
+		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2)
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 870c39537dd0..fca3cb329e1d 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -55,6 +55,7 @@ WORKAROUND_1418040
 WORKAROUND_1463225
 WORKAROUND_1508412
 WORKAROUND_1542419
+WORKAROUND_2064142
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
 WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 276862c07e32..ec24b62b2cec 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -91,10 +91,12 @@ struct trbe_buf {
  */
 #define TRBE_WORKAROUND_OVERWRITE_FILL_MODE	0
 #define TRBE_WORKAROUND_WRITE_OUT_OF_RANGE	1
+#define TRBE_WORKAROUND_SYSREG_WRITE_FAILURE	2
 
 static int trbe_errata_cpucaps[] = {
 	[TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
 	[TRBE_WORKAROUND_WRITE_OUT_OF_RANGE] = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
+	[TRBE_WORKAROUND_SYSREG_WRITE_FAILURE] = ARM64_WORKAROUND_2064142,
 	-1,		/* Sentinel, must be the last entry */
 };
 
@@ -167,6 +169,11 @@ static inline bool trbe_may_write_out_of_range(struct trbe_cpudata *cpudata)
 	return trbe_has_erratum(cpudata, TRBE_WORKAROUND_WRITE_OUT_OF_RANGE);
 }
 
+static inline bool trbe_may_fail_sysreg_write(struct trbe_cpudata *cpudata)
+{
+	return trbe_has_erratum(cpudata, TRBE_WORKAROUND_SYSREG_WRITE_FAILURE);
+}
+
 static int trbe_alloc_node(struct perf_event *event)
 {
 	if (event->cpu == -1)
@@ -174,30 +181,42 @@ static int trbe_alloc_node(struct perf_event *event)
 	return cpu_to_node(event->cpu);
 }
 
-static void trbe_drain_buffer(void)
+static inline void trbe_drain_buffer(void)
 {
 	tsb_csync();
 	dsb(nsh);
 }
 
-static void trbe_drain_and_disable_local(void)
+static inline void set_trbe_disabled(struct trbe_cpudata *cpudata)
 {
 	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
 
-	trbe_drain_buffer();
-
 	/*
 	 * Disable the TRBE without clearing LIMITPTR which
 	 * might be required for fetching the buffer limits.
 	 */
 	trblimitr &= ~TRBLIMITR_ENABLE;
 	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
+
+	/*
+	 * Errata affected TRBE implementation will need TSB CSYNC and
+	 * DSB in order to prevent subsequent writes into certain TRBE
+	 * system registers from being ignored and not effected.
+	 */
+	if (trbe_may_fail_sysreg_write(cpudata))
+		trbe_drain_buffer();
 	isb();
 }
 
-static void trbe_reset_local(void)
+static void trbe_drain_and_disable_local(struct trbe_cpudata *cpudata)
 {
-	trbe_drain_and_disable_local();
+	trbe_drain_buffer();
+	set_trbe_disabled(cpudata);
+}
+
+static void trbe_reset_local(struct trbe_cpudata *cpudata)
+{
+	trbe_drain_and_disable_local(cpudata);
 	write_sysreg_s(0, SYS_TRBLIMITR_EL1);
 	write_sysreg_s(0, SYS_TRBPTR_EL1);
 	write_sysreg_s(0, SYS_TRBBASER_EL1);
@@ -234,7 +253,7 @@ static void trbe_stop_and_truncate_event(struct perf_output_handle *handle)
 	 * at event_stop(). So disable the TRBE here and leave
 	 * the update_buffer() to return a 0 size.
 	 */
-	trbe_drain_and_disable_local();
+	trbe_drain_and_disable_local(buf->cpudata);
 	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
 	perf_aux_output_end(handle, 0);
 	*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
@@ -579,8 +598,7 @@ static void trbe_enable_hw(struct trbe_buf *buf)
 	WARN_ON(buf->trbe_hw_base < buf->trbe_base);
 	WARN_ON(buf->trbe_write < buf->trbe_hw_base);
 	WARN_ON(buf->trbe_write >= buf->trbe_limit);
-	set_trbe_disabled();
-	isb();
+	set_trbe_disabled(buf->cpudata);
 	clr_trbe_status();
 	set_trbe_base_pointer(buf->trbe_hw_base);
 	set_trbe_write_pointer(buf->trbe_write);
@@ -775,7 +793,7 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
 	 * the TRBE here will ensure that no IRQ could be generated when the perf
 	 * handle gets freed in etm_event_stop().
 	 */
-	trbe_drain_and_disable_local();
+	trbe_drain_and_disable_local(cpudata);
 
 	/* Check if there is a pending interrupt and handle it here */
 	status = read_sysreg_s(SYS_TRBSR_EL1);
@@ -986,7 +1004,7 @@ static int arm_trbe_disable(struct coresight_device *csdev)
 	if (cpudata->mode != CS_MODE_PERF)
 		return -EINVAL;
 
-	trbe_drain_and_disable_local();
+	trbe_drain_and_disable_local(cpudata);
 	buf->cpudata = NULL;
 	cpudata->buf = NULL;
 	cpudata->mode = CS_MODE_DISABLED;
@@ -1028,7 +1046,7 @@ static int trbe_handle_overflow(struct perf_output_handle *handle)
 		 * is able to detect this with a disconnected handle
 		 * (handle->event = NULL).
 		 */
-		trbe_drain_and_disable_local();
+		trbe_drain_and_disable_local(buf->cpudata);
 		*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
 		return -EINVAL;
 	}
@@ -1062,6 +1080,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 {
 	struct perf_output_handle **handle_ptr = dev;
 	struct perf_output_handle *handle = *handle_ptr;
+	struct trbe_buf *buf = etm_perf_sink_config(handle);
 	enum trbe_fault_action act;
 	u64 status;
 	bool truncated = false;
@@ -1082,7 +1101,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 	 * Ensure the trace is visible to the CPUs and
 	 * any external aborts have been resolved.
 	 */
-	trbe_drain_and_disable_local();
+	trbe_drain_and_disable_local(buf->cpudata);
 	clr_trbe_irq();
 	isb();
 
@@ -1167,8 +1186,9 @@ static const struct attribute_group *arm_trbe_groups[] = {
 static void arm_trbe_enable_cpu(void *info)
 {
 	struct trbe_drvdata *drvdata = info;
+	struct trbe_cpudata *cpudata = this_cpu_ptr(drvdata->cpudata);
 
-	trbe_reset_local();
+	trbe_reset_local(cpudata);
 	enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
 }
 
@@ -1276,7 +1296,7 @@ static void arm_trbe_remove_coresight_cpu(void *info)
 	struct coresight_device *trbe_csdev = coresight_get_percpu_sink(cpu);
 
 	disable_percpu_irq(drvdata->irq);
-	trbe_reset_local();
+	trbe_reset_local(cpudata);
 	if (trbe_csdev) {
 		coresight_unregister(trbe_csdev);
 		cpudata->drvdata = NULL;
@@ -1349,8 +1369,10 @@ static int arm_trbe_cpu_teardown(unsigned int cpu, struct hlist_node *node)
 	struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
 
 	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
+		struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
+
 		disable_percpu_irq(drvdata->irq);
-		trbe_reset_local();
+		trbe_reset_local(cpudata);
 	}
 	return 0;
 }
diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
index abf3e36082f0..30e4d7db4f8e 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.h
+++ b/drivers/hwtracing/coresight/coresight-trbe.h
@@ -91,14 +91,6 @@ static inline bool is_trbe_running(u64 trbsr)
 #define TRBE_FILL_MODE_WRAP		1
 #define TRBE_FILL_MODE_CIRCULAR_BUFFER	3
 
-static inline void set_trbe_disabled(void)
-{
-	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
-
-	trblimitr &= ~TRBLIMITR_ENABLE;
-	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
-}
-
 static inline bool get_trbe_flag_update(u64 trbidr)
 {
 	return trbidr & TRBIDR_FLAG;
-- 
2.25.1


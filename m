Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A318486F7E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344238AbiAGBKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:10:38 -0500
Received: from foss.arm.com ([217.140.110.172]:34230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345138AbiAGBKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:10:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90E9C1042;
        Thu,  6 Jan 2022 17:10:33 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 301F73F5A1;
        Thu,  6 Jan 2022 17:10:29 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/7] coresight: trbe: Work around the ignored system register writes
Date:   Fri,  7 Jan 2022 06:40:06 +0530
Message-Id: <1641517808-5735-6-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641517808-5735-1-git-send-email-anshuman.khandual@arm.com>
References: <1641517808-5735-1-git-send-email-anshuman.khandual@arm.com>
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
register write to one of the affected registers. This just updates the TRBE
driver as required.

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
 arch/arm64/Kconfig                           |  2 +-
 drivers/hwtracing/coresight/coresight-trbe.c | 54 ++++++++++++++------
 drivers/hwtracing/coresight/coresight-trbe.h |  8 ---
 3 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f1651cb71ef3..b6d62672bf7d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -780,7 +780,7 @@ config ARM64_ERRATUM_2224489
 
 config ARM64_ERRATUM_2064142
 	bool "Cortex-A510: 2064142: workaround TRBE register writes while disabled"
-	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
 	default y
 	help
 	  This option adds the workaround for ARM Cortex-A510 erratum 2064142.
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 276862c07e32..850e9fca6847 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -91,10 +91,12 @@ struct trbe_buf {
  */
 #define TRBE_WORKAROUND_OVERWRITE_FILL_MODE	0
 #define TRBE_WORKAROUND_WRITE_OUT_OF_RANGE	1
+#define TRBE_NEEDS_DRAIN_AFTER_DISABLE		2
 
 static int trbe_errata_cpucaps[] = {
 	[TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
 	[TRBE_WORKAROUND_WRITE_OUT_OF_RANGE] = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
+	[TRBE_NEEDS_DRAIN_AFTER_DISABLE] = ARM64_WORKAROUND_2064142,
 	-1,		/* Sentinel, must be the last entry */
 };
 
@@ -167,6 +169,11 @@ static inline bool trbe_may_write_out_of_range(struct trbe_cpudata *cpudata)
 	return trbe_has_erratum(cpudata, TRBE_WORKAROUND_WRITE_OUT_OF_RANGE);
 }
 
+static inline bool trbe_needs_drain_after_disable(struct trbe_cpudata *cpudata)
+{
+	return trbe_has_erratum(cpudata, TRBE_NEEDS_DRAIN_AFTER_DISABLE);
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
+	if (trbe_needs_drain_after_disable(cpudata))
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


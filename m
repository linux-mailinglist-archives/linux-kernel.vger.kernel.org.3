Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9050486F7F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345133AbiAGBKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:10:41 -0500
Received: from foss.arm.com ([217.140.110.172]:34242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345086AbiAGBKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:10:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F4271042;
        Thu,  6 Jan 2022 17:10:37 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2EBEE3F5A1;
        Thu,  6 Jan 2022 17:10:33 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/7] coresight: trbe: Work around the invalid prohibited states
Date:   Fri,  7 Jan 2022 06:40:07 +0530
Message-Id: <1641517808-5735-7-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641517808-5735-1-git-send-email-anshuman.khandual@arm.com>
References: <1641517808-5735-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TRBE implementations affected by Arm erratum #2038923 might get TRBE into
an inconsistent view on whether trace is prohibited within the CPU. As a
result, the trace buffer or trace buffer state might be corrupted. This
happens after TRBE buffer has been enabled by setting TRBLIMITR_EL1.E,
followed by just a single context synchronization event before execution
changes from a context, in which trace is prohibited to one where it isn't,
or vice versa. In these mentioned conditions, the view of whether trace is
prohibited is inconsistent between parts of the CPU, and the trace buffer
or the trace buffer state might be corrupted.

Work around this problem in the TRBE driver by preventing an inconsistent
view of whether the trace is prohibited or not based on TRBLIMITR_EL1.E by
immediately following a change to TRBLIMITR_EL1.E with at least one ISB
instruction before an ERET, or two ISB instructions if no ERET is to take
place. This just updates the TRBE driver as required.

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
 drivers/hwtracing/coresight/coresight-trbe.c | 48 +++++++++++++++-----
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b6d62672bf7d..209e481acf0d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -798,7 +798,7 @@ config ARM64_ERRATUM_2064142
 
 config ARM64_ERRATUM_2038923
 	bool "Cortex-A510: 2038923: workaround TRBE corruption with enable"
-	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
 	default y
 	help
 	  This option adds the workaround for ARM Cortex-A510 erratum 2038923.
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 850e9fca6847..c4cc529749f8 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -92,11 +92,13 @@ struct trbe_buf {
 #define TRBE_WORKAROUND_OVERWRITE_FILL_MODE	0
 #define TRBE_WORKAROUND_WRITE_OUT_OF_RANGE	1
 #define TRBE_NEEDS_DRAIN_AFTER_DISABLE		2
+#define TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE	3
 
 static int trbe_errata_cpucaps[] = {
 	[TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
 	[TRBE_WORKAROUND_WRITE_OUT_OF_RANGE] = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
 	[TRBE_NEEDS_DRAIN_AFTER_DISABLE] = ARM64_WORKAROUND_2064142,
+	[TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE] = ARM64_WORKAROUND_2038923,
 	-1,		/* Sentinel, must be the last entry */
 };
 
@@ -174,6 +176,11 @@ static inline bool trbe_needs_drain_after_disable(struct trbe_cpudata *cpudata)
 	return trbe_has_erratum(cpudata, TRBE_NEEDS_DRAIN_AFTER_DISABLE);
 }
 
+static inline bool trbe_needs_ctxt_sync_after_enable(struct trbe_cpudata *cpudata)
+{
+	return trbe_has_erratum(cpudata, TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE);
+}
+
 static int trbe_alloc_node(struct perf_event *event)
 {
 	if (event->cpu == -1)
@@ -187,6 +194,28 @@ static inline void trbe_drain_buffer(void)
 	dsb(nsh);
 }
 
+static inline void set_trbe_enabled(struct trbe_cpudata *cpudata, u64 trblimitr)
+{
+	/*
+	 * Enable the TRBE without clearing LIMITPTR which
+	 * might be required for fetching the buffer limits.
+	 */
+	trblimitr |= TRBLIMITR_ENABLE;
+	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
+
+	/* Synchronize the TRBE enable event */
+	isb();
+
+	/*
+	 * Errata affected TRBE implementation will need an additional
+	 * context synchronization in order to prevent an inconsistent
+	 * TRBE prohibited region view on the CPU which could possibly
+	 * corrupt the TRBE buffer or the TRBE state.
+	 */
+	if (trbe_needs_ctxt_sync_after_enable(cpudata))
+		isb();
+}
+
 static inline void set_trbe_disabled(struct trbe_cpudata *cpudata)
 {
 	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
@@ -555,9 +584,10 @@ static void clr_trbe_status(void)
 	write_sysreg_s(trbsr, SYS_TRBSR_EL1);
 }
 
-static void set_trbe_limit_pointer_enabled(unsigned long addr)
+static void set_trbe_limit_pointer_enabled(struct trbe_buf *buf)
 {
 	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
+	unsigned long addr = buf->trbe_limit;
 
 	WARN_ON(!IS_ALIGNED(addr, (1UL << TRBLIMITR_LIMIT_SHIFT)));
 	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
@@ -585,12 +615,7 @@ static void set_trbe_limit_pointer_enabled(unsigned long addr)
 	trblimitr |= (TRBE_TRIG_MODE_IGNORE & TRBLIMITR_TRIG_MODE_MASK) <<
 		      TRBLIMITR_TRIG_MODE_SHIFT;
 	trblimitr |= (addr & PAGE_MASK);
-
-	trblimitr |= TRBLIMITR_ENABLE;
-	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
-
-	/* Synchronize the TRBE enable event */
-	isb();
+	set_trbe_enabled(buf->cpudata, trblimitr);
 }
 
 static void trbe_enable_hw(struct trbe_buf *buf)
@@ -608,7 +633,7 @@ static void trbe_enable_hw(struct trbe_buf *buf)
 	 * till now before enabling the TRBE.
 	 */
 	isb();
-	set_trbe_limit_pointer_enabled(buf->trbe_limit);
+	set_trbe_limit_pointer_enabled(buf);
 }
 
 static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *handle,
@@ -1013,16 +1038,15 @@ static int arm_trbe_disable(struct coresight_device *csdev)
 
 static void trbe_handle_spurious(struct perf_output_handle *handle)
 {
-	u64 limitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
+	struct trbe_buf *buf = etm_perf_sink_config(handle);
+	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
 
 	/*
 	 * If the IRQ was spurious, simply re-enable the TRBE
 	 * back without modifying the buffer parameters to
 	 * retain the trace collected so far.
 	 */
-	limitr |= TRBLIMITR_ENABLE;
-	write_sysreg_s(limitr, SYS_TRBLIMITR_EL1);
-	isb();
+	set_trbe_enabled(buf->cpudata, trblimitr);
 }
 
 static int trbe_handle_overflow(struct perf_output_handle *handle)
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D06B49B640
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiAYOaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:30:08 -0500
Received: from foss.arm.com ([217.140.110.172]:46652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1579100AbiAYOXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:23:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFED613D5;
        Tue, 25 Jan 2022 06:21:29 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.42.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B7FAA3F793;
        Tue, 25 Jan 2022 06:21:25 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 RESEND 7/7] coresight: trbe: Work around the trace data corruption
Date:   Tue, 25 Jan 2022 19:50:37 +0530
Message-Id: <1643120437-14352-8-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643120437-14352-1-git-send-email-anshuman.khandual@arm.com>
References: <1643120437-14352-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TRBE implementations affected by Arm erratum #1902691 might corrupt trace
data or deadlock, when it's being written into the memory. Workaround this
problem in the driver, by preventing TRBE initialization on affected cpus.
The firmware must have disabled the access to TRBE for the kernel on such
implementations. This will cover the kernel for any firmware that doesn't
do this already. This just updates the TRBE driver as required.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-doc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig                           |  2 +-
 drivers/hwtracing/coresight/coresight-trbe.c | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f37c9d2d697d..ee0fe8a04b9b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -821,7 +821,7 @@ config ARM64_ERRATUM_2038923
 
 config ARM64_ERRATUM_1902691
 	bool "Cortex-A510: 1902691: workaround TRBE trace corruption"
-	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
 	default y
 	help
 	  This option adds the workaround for ARM Cortex-A510 erratum 1902691.
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 6254ba598df2..75b608bc400b 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -93,12 +93,14 @@ struct trbe_buf {
 #define TRBE_WORKAROUND_WRITE_OUT_OF_RANGE	1
 #define TRBE_NEEDS_DRAIN_AFTER_DISABLE		2
 #define TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE	3
+#define TRBE_IS_BROKEN				4
 
 static int trbe_errata_cpucaps[] = {
 	[TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
 	[TRBE_WORKAROUND_WRITE_OUT_OF_RANGE] = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
 	[TRBE_NEEDS_DRAIN_AFTER_DISABLE] = ARM64_WORKAROUND_2064142,
 	[TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE] = ARM64_WORKAROUND_2038923,
+	[TRBE_IS_BROKEN] = ARM64_WORKAROUND_1902691,
 	-1,		/* Sentinel, must be the last entry */
 };
 
@@ -192,6 +194,11 @@ static inline bool trbe_needs_ctxt_sync_after_enable(struct trbe_cpudata *cpudat
 	return trbe_has_erratum(cpudata, TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE);
 }
 
+static inline bool trbe_is_broken(struct trbe_cpudata *cpudata)
+{
+	return trbe_has_erratum(cpudata, TRBE_IS_BROKEN);
+}
+
 static int trbe_alloc_node(struct perf_event *event)
 {
 	if (event->cpu == -1)
@@ -1288,6 +1295,11 @@ static void arm_trbe_probe_cpu(void *info)
 	 */
 	trbe_check_errata(cpudata);
 
+	if (trbe_is_broken(cpudata)) {
+		pr_err("Disabling TRBE on cpu%d due to erratum\n", cpu);
+		goto cpu_clear;
+	}
+
 	/*
 	 * If the TRBE is affected by erratum TRBE_WORKAROUND_OVERWRITE_FILL_MODE,
 	 * we must always program the TBRPTR_EL1, 256bytes from a page
-- 
2.25.1


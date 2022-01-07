Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934BD486F79
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345126AbiAGBK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:10:27 -0500
Received: from foss.arm.com ([217.140.110.172]:34202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345101AbiAGBK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:10:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9424C1042;
        Thu,  6 Jan 2022 17:10:25 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C25F3F5A1;
        Thu,  6 Jan 2022 17:10:22 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/7] arm64: errata: Add detection for TRBE invalid prohibited states
Date:   Fri,  7 Jan 2022 06:40:04 +0530
Message-Id: <1641517808-5735-4-git-send-email-anshuman.khandual@arm.com>
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
or the trace buffer state might be corrupted. This adds a new errata
ARM64_ERRATUM_2038923 in arm64 errata framework.

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
 Documentation/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                     | 23 +++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c         |  9 +++++++++
 arch/arm64/tools/cpucaps               |  1 +
 4 files changed, 35 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index c9b30e6c2b6c..e0ef3e9a4b8b 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -54,6 +54,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2064142        | ARM64_ERRATUM_2064142       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #2038923        | ARM64_ERRATUM_2038923       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319        |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319        |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e27ccfe9fa9c..188eae6ef28d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -796,6 +796,29 @@ config ARM64_ERRATUM_2064142
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_2038923
+	bool "Cortex-A510: 2038923: workaround TRBE corruption with enable"
+	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	default y
+	help
+	  This option adds the workaround for ARM Cortex-A510 erratum 2038923.
+
+	  Affected Cortex-A510 core might cause an inconsistent view on whether trace is
+	  prohibited within the CPU. As a result, the trace buffer or trace buffer state
+	  might be corrupted. This happens after TRBE buffer has been enabled by setting
+	  TRBLIMITR_EL1.E, followed by just a single context synchronization event before
+	  execution changes from a context, in which trace is prohibited to one where it
+	  isn't, or vice versa. In these mentioned conditions, the view of whether trace
+	  is prohibited is inconsistent between parts of the CPU, and the trace buffer or
+	  the trace buffer state might be corrupted.
+
+	  Work around this in the driver by preventing an inconsistent view of whether the
+	  trace is prohibited or not based on TRBLIMITR_EL1.E by immediately following a
+	  change to TRBLIMITR_EL1.E with at least one ISB instruction before an ERET, or
+	  two ISB instructions if no ERET is to take place.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index cbb7d5a9aee7..60b0c1f1d912 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -607,6 +607,15 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2)
 	},
 #endif
+#ifdef CONFIG_ARM64_ERRATUM_2038923
+	{
+		.desc = "ARM erratum 2038923",
+		.capability = ARM64_WORKAROUND_2038923,
+
+		/* Cortex-A510 r0p0 - r0p2 */
+		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2)
+	},
+#endif
 	{
 	}
 };
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index fca3cb329e1d..45a06d36d080 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -56,6 +56,7 @@ WORKAROUND_1463225
 WORKAROUND_1508412
 WORKAROUND_1542419
 WORKAROUND_2064142
+WORKAROUND_2038923
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
 WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
-- 
2.25.1


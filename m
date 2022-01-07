Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32682486F7B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbiAGBKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:10:31 -0500
Received: from foss.arm.com ([217.140.110.172]:34216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345101AbiAGBKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:10:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9259F1042;
        Thu,  6 Jan 2022 17:10:29 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 319F73F5A1;
        Thu,  6 Jan 2022 17:10:25 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/7] arm64: errata: Add detection for TRBE trace data corruption
Date:   Fri,  7 Jan 2022 06:40:05 +0530
Message-Id: <1641517808-5735-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641517808-5735-1-git-send-email-anshuman.khandual@arm.com>
References: <1641517808-5735-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TRBE implementations affected by Arm erratum #1902691 might corrupt trace
data or deadlock, when it's being written into the memory. So effectively
TRBE is broken and hence cannot be used to capture trace data. This adds
a new errata ARM64_ERRATUM_1902691 in arm64 errata framework.

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
 arch/arm64/Kconfig                     | 18 ++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c         |  9 +++++++++
 arch/arm64/tools/cpucaps               |  1 +
 4 files changed, 30 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index e0ef3e9a4b8b..50018f60c4d4 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -56,6 +56,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2038923        | ARM64_ERRATUM_2038923       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #1902691        | ARM64_ERRATUM_1902691       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319        |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319        |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 188eae6ef28d..f1651cb71ef3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -819,6 +819,24 @@ config ARM64_ERRATUM_2038923
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_1902691
+	bool "Cortex-A510: 1902691: workaround TRBE trace corruption"
+	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	default y
+	help
+	  This option adds the workaround for ARM Cortex-A510 erratum 1902691.
+
+	  Affected Cortex-A510 core might cause trace data corruption, when being written
+	  into the memory. Effectively TRBE is broken and hence cannot be used to capture
+	  trace data.
+
+	  Work around this problem in the driver by just preventing TRBE initialization on
+	  affected cpus. The firmware must have disabled the access to TRBE for the kernel
+	  on such implementations. This will cover the kernel for any firmware that doesn't
+	  do this already.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 60b0c1f1d912..a3336dfb5a8a 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -615,6 +615,15 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		/* Cortex-A510 r0p0 - r0p2 */
 		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2)
 	},
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_1902691
+	{
+		.desc = "ARM erratum 1902691",
+		.capability = ARM64_WORKAROUND_1902691,
+
+		/* Cortex-A510 r0p0 - r0p1 */
+		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 1)
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 45a06d36d080..e7719e8f18de 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -57,6 +57,7 @@ WORKAROUND_1508412
 WORKAROUND_1542419
 WORKAROUND_2064142
 WORKAROUND_2038923
+WORKAROUND_1902691
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
 WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB20648C117
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352130AbiALJfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:35:17 -0500
Received: from foss.arm.com ([217.140.110.172]:57336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352119AbiALJfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:35:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B302AD6E;
        Wed, 12 Jan 2022 01:35:12 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.66.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E37E33F766;
        Wed, 12 Jan 2022 01:35:09 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: errata: Update ARM64_ERRATUM_[2119858|2224489] with Cortex-X2 ranges
Date:   Wed, 12 Jan 2022 15:04:59 +0530
Message-Id: <1641980099-20315-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641980099-20315-1-git-send-email-anshuman.khandual@arm.com>
References: <1641980099-20315-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errata ARM64_ERRATUM_[2119858|2224489] also affect some Cortex-X2 ranges as
well. Lets update these errata definition and detection to accommodate all
new Cortex-X2 based cpu MIDR ranges.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig             | 12 ++++++------
 arch/arm64/kernel/cpu_errata.c |  2 ++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf9bb17..d8046c832225 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -671,14 +671,14 @@ config ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 	bool
 
 config ARM64_ERRATUM_2119858
-	bool "Cortex-A710: 2119858: workaround TRBE overwriting trace data in FILL mode"
+	bool "Cortex-A710/X2: 2119858: workaround TRBE overwriting trace data in FILL mode"
 	default y
 	depends on CORESIGHT_TRBE
 	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 	help
-	  This option adds the workaround for ARM Cortex-A710 erratum 2119858.
+	  This option adds the workaround for ARM Cortex-A710/X2 erratum 2119858.
 
-	  Affected Cortex-A710 cores could overwrite up to 3 cache lines of trace
+	  Affected Cortex-A710/X2 cores could overwrite up to 3 cache lines of trace
 	  data at the base of the buffer (pointed to by TRBASER_EL1) in FILL mode in
 	  the event of a WRAP event.
 
@@ -761,14 +761,14 @@ config ARM64_ERRATUM_2253138
 	  If unsure, say Y.
 
 config ARM64_ERRATUM_2224489
-	bool "Cortex-A710: 2224489: workaround TRBE writing to address out-of-range"
+	bool "Cortex-A710/X2: 2224489: workaround TRBE writing to address out-of-range"
 	depends on CORESIGHT_TRBE
 	default y
 	select ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
 	help
-	  This option adds the workaround for ARM Cortex-A710 erratum 2224489.
+	  This option adds the workaround for ARM Cortex-A710/X2 erratum 2224489.
 
-	  Affected Cortex-A710 cores might write to an out-of-range address, not reserved
+	  Affected Cortex-A710/X2 cores might write to an out-of-range address, not reserved
 	  for TRBE. Under some conditions, the TRBE might generate a write to the next
 	  virtually addressed page following the last page of the TRBE address space
 	  (i.e., the TRBLIMITR_EL1.LIMIT), instead of wrapping around to the base.
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 9e1c1aef9ebd..29cc062a4153 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -347,6 +347,7 @@ static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_2119858
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+	MIDR_RANGE(MIDR_CORTEX_X2, 0, 0, 2, 0),
 #endif
 	{},
 };
@@ -371,6 +372,7 @@ static struct midr_range trbe_write_out_of_range_cpus[] = {
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_2224489
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+	MIDR_RANGE(MIDR_CORTEX_X2, 0, 0, 2, 0),
 #endif
 	{},
 };
-- 
2.20.1


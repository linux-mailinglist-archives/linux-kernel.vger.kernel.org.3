Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B780451CD50
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387292AbiEFAEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387212AbiEFAC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:02:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49201612B4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795080; x=1683331080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=NgL6S1cr5J9GxlUSQa9DYNpqQacM6MNmaOCrW38i9fU=;
  b=DViodAtavYHO6WN7lMdblj+RO5AQ1oVwFfzmW3y2h3wtAoTVQEIoM6qk
   Y4UP8A/P94s6XYQZa4synSRSxcj2Ld4WrhRLDHMaoU/UveSjo2zHJXzw+
   wUzMF6CyCx/S1ojveZuqdQ4ucmEpyWPozaJ10rQTXB+7nRFJ7eDUez9a7
   83MOCuGIPNxqRMVi+MN/baDrM9LInn/wGyZwz3jl8W0T8pAG7xz0M2Shu
   v9jkhwJa1aUR1o1Ppt7C2P4PGrsHfanw1ft9C6SEtM6Dk9rLHuLXYj9Jd
   ZYBdT1cjxwl9jcYDRCuclm5w7xs9X9c8eR090HCAbEHfiSaeoAx7AQmL7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283661"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283661"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914448"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:55 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v6 26/29] x86/watchdog: Add a shim hardlockup detector
Date:   Thu,  5 May 2022 17:00:05 -0700
Message-Id: <20220506000008.30892-27-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic hardlockup detector is based on perf. It also provides a set
of weak functions that CPU architectures can override. Add a shim
hardlockup detector for x86 that overrides such functions and can
select between perf and HPET implementations of the detector.

For clarity, add the intermediate Kconfig symbol X86_HARDLOCKUP_DETECTOR
that is selected whenever the core of the hardlockup detector is
selected.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Added watchdog_nmi_start() to be used when tsc_khz is recalibrated.
 * Always build the x86-specific hardlockup detector shim; not only
   when the HPET-based detector is selected.
 * Corrected a typo in comment in watchdog_nmi_probe() (Ani)
 * Removed useless local ret variable in watchdog_nmi_enable(). (Ani)

Changes since v4:
 * Use a switch to enable and disable the various available detectors.
   (Andi)

Changes since v3:
 * Fixed style in multi-line comment. (Randy Dunlap)

Changes since v2:
 * Pass cpu number as argument to hardlockup_detector_[enable|disable].
   (Thomas Gleixner)

Changes since v1:
 * Introduced this patch: Added an x86-specific shim hardlockup
   detector. (Nicholas Piggin)
---
 arch/x86/Kconfig.debug         |  3 ++
 arch/x86/kernel/Makefile       |  2 +
 arch/x86/kernel/watchdog_hld.c | 85 ++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 arch/x86/kernel/watchdog_hld.c

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index bc34239589db..599001157847 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -6,6 +6,9 @@ config TRACE_IRQFLAGS_NMI_SUPPORT
 config EARLY_PRINTK_USB
 	bool
 
+config X86_HARDLOCKUP_DETECTOR
+	def_bool y if HARDLOCKUP_DETECTOR_CORE
+
 config X86_VERBOSE_BOOTUP
 	bool "Enable verbose x86 bootup info messages"
 	default y
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index c700b00a2d86..af3d54e4c836 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -114,6 +114,8 @@ obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_VM86)		+= vm86_32.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
+obj-$(CONFIG_X86_HARDLOCKUP_DETECTOR) += watchdog_hld.o
+
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 obj-$(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET) += watchdog_hld_hpet.o
 
diff --git a/arch/x86/kernel/watchdog_hld.c b/arch/x86/kernel/watchdog_hld.c
new file mode 100644
index 000000000000..ef11f0af4ef5
--- /dev/null
+++ b/arch/x86/kernel/watchdog_hld.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A shim hardlockup detector. It overrides the weak stubs of the generic
+ * implementation to select between the perf- or the hpet-based implementation.
+ *
+ * Copyright (C) Intel Corporation 2022
+ */
+
+#include <linux/nmi.h>
+#include <asm/hpet.h>
+
+enum x86_hardlockup_detector {
+	X86_HARDLOCKUP_DETECTOR_PERF,
+	X86_HARDLOCKUP_DETECTOR_HPET,
+};
+
+static enum __read_mostly x86_hardlockup_detector detector_type;
+
+int watchdog_nmi_enable(unsigned int cpu)
+{
+	switch (detector_type) {
+	case X86_HARDLOCKUP_DETECTOR_PERF:
+		hardlockup_detector_perf_enable();
+		break;
+	case X86_HARDLOCKUP_DETECTOR_HPET:
+		hardlockup_detector_hpet_enable(cpu);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+void watchdog_nmi_disable(unsigned int cpu)
+{
+	switch (detector_type) {
+	case X86_HARDLOCKUP_DETECTOR_PERF:
+		hardlockup_detector_perf_disable();
+		break;
+	case X86_HARDLOCKUP_DETECTOR_HPET:
+		hardlockup_detector_hpet_disable(cpu);
+		break;
+	}
+}
+
+int __init watchdog_nmi_probe(void)
+{
+	int ret;
+
+	/*
+	 * Try first with the HPET hardlockup detector. It will only
+	 * succeed if selected at build time and requested in the
+	 * nmi_watchdog command-line parameter. This ensures that the
+	 * perf-based detector is used by default, if selected at
+	 * build time.
+	 */
+	ret = hardlockup_detector_hpet_init();
+	if (!ret) {
+		detector_type = X86_HARDLOCKUP_DETECTOR_HPET;
+		return ret;
+	}
+
+	ret = hardlockup_detector_perf_init();
+	if (!ret) {
+		detector_type = X86_HARDLOCKUP_DETECTOR_PERF;
+		return ret;
+	}
+
+	return 0;
+}
+
+void watchdog_nmi_stop(void)
+{
+	/* Only the HPET lockup detector defines a stop function. */
+	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET)
+		hardlockup_detector_hpet_stop();
+}
+
+void watchdog_nmi_start(void)
+{
+	/* Only the HPET lockup detector defines a start function. */
+	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET)
+		hardlockup_detector_hpet_start();
+}
-- 
2.17.1


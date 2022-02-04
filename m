Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35504A9165
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356129AbiBDADg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:03:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:8517 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241161AbiBDADb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643933011; x=1675469011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rmmSAM16z8RnkHc97boUyZm+0sNhRRp1bzZIQE44To4=;
  b=GdTHziREg1ais8Ykma320O2KP9i5Z1g3jL4IFNjlos6tnEsC/TvYrj8p
   nyWpRQbDfuPdqEzDc/O0DTrNd7x313dt0loL+TzF6xLBLZO8NRKbVLY+h
   98Eq3TCRkLTE3q9KbWyTwP7GjlkuMyk93gz5XgJHlR7sCEMV53E8Wk3q/
   +lRlFbueeRRcPIsEkkAZSetrvIv2GpbAkDr05FsfdkyyvHzLbVmVN0da/
   RTnWNIVV+4N3bXfCwHSJkbfYeMJ5+HVwdBSvDkFkbi3RZaxXTXLjSSvKm
   VvRFMTrjbSuPzZXbRA44ZrIPBO7C3N6oxlR3rsUZu0vT27aVR2rD+1Djd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="272779957"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="272779957"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 16:03:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="620684669"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Feb 2022 16:03:30 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 1/4] platform/x86/intel/uncore-freq: Move to uncore-frequency folder
Date:   Thu,  3 Feb 2022 16:03:03 -0800
Message-Id: <20220204000306.2517447-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204000306.2517447-1-srinivas.pandruvada@linux.intel.com>
References: <20220204000306.2517447-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@intel.com>

Move the current driver from platform/x86/intel/uncore-frequency.c
to platform/x86/intel/uncore-frequency/uncore-frequency.c.

No functional changes are expected.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel/Kconfig            | 14 ++-----------
 drivers/platform/x86/intel/Makefile           |  4 ++--
 .../x86/intel/uncore-frequency/Kconfig        | 21 +++++++++++++++++++
 .../x86/intel/uncore-frequency/Makefile       |  7 +++++++
 .../{ => uncore-frequency}/uncore-frequency.c |  0
 5 files changed, 32 insertions(+), 14 deletions(-)
 create mode 100644 drivers/platform/x86/intel/uncore-frequency/Kconfig
 create mode 100644 drivers/platform/x86/intel/uncore-frequency/Makefile
 rename drivers/platform/x86/intel/{ => uncore-frequency}/uncore-frequency.c (100%)

diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 8e65086bb6c8..ff754b60076e 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -12,6 +12,8 @@ source "drivers/platform/x86/intel/pmt/Kconfig"
 source "drivers/platform/x86/intel/speed_select_if/Kconfig"
 source "drivers/platform/x86/intel/telemetry/Kconfig"
 source "drivers/platform/x86/intel/wmi/Kconfig"
+source "drivers/platform/x86/intel/uncore-frequency/Kconfig"
+
 
 config INTEL_HID_EVENT
 	tristate "Intel HID Event"
@@ -159,18 +161,6 @@ config INTEL_TURBO_MAX_3
 	  This driver is only required when the system is not using Hardware
 	  P-States (HWP). In HWP mode, priority can be read from ACPI tables.
 
-config INTEL_UNCORE_FREQ_CONTROL
-	tristate "Intel Uncore frequency control driver"
-	depends on X86_64
-	help
-	  This driver allows control of Uncore frequency limits on
-	  supported server platforms.
-
-	  Uncore frequency controls RING/LLC (last-level cache) clocks.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel-uncore-frequency.
-
 config INTEL_VSEC
 	tristate "Intel Vendor Specific Extended Capabilities Driver"
 	depends on PCI
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 35f2066578b2..1d5ada7b4d32 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -13,6 +13,8 @@ obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += speed_select_if/
 obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 obj-$(CONFIG_INTEL_WMI)			+= wmi/
+obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)	+= uncore-frequency/
+
 
 # Intel input drivers
 intel-hid-y				:= hid.o
@@ -48,5 +50,3 @@ intel-smartconnect-y			:= smartconnect.o
 obj-$(CONFIG_INTEL_SMARTCONNECT)	+= intel-smartconnect.o
 intel_turbo_max_3-y			:= turbo_max_3.o
 obj-$(CONFIG_INTEL_TURBO_MAX_3)		+= intel_turbo_max_3.o
-intel-uncore-frequency-y		:= uncore-frequency.o
-obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)	+= intel-uncore-frequency.o
diff --git a/drivers/platform/x86/intel/uncore-frequency/Kconfig b/drivers/platform/x86/intel/uncore-frequency/Kconfig
new file mode 100644
index 000000000000..21b209124916
--- /dev/null
+++ b/drivers/platform/x86/intel/uncore-frequency/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Uncore Frquency control drivers
+#
+
+menu "Intel Uncore Frequency Control"
+	depends on X86_64 || COMPILE_TEST
+
+config INTEL_UNCORE_FREQ_CONTROL
+	tristate "Intel Uncore frequency control driver"
+	depends on X86_64
+	help
+	  This driver allows control of Uncore frequency limits on
+	  supported server platforms.
+
+	  Uncore frequency controls RING/LLC (last-level cache) clocks.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel-uncore-frequency.
+
+endmenu
diff --git a/drivers/platform/x86/intel/uncore-frequency/Makefile b/drivers/platform/x86/intel/uncore-frequency/Makefile
new file mode 100644
index 000000000000..e22186a480e2
--- /dev/null
+++ b/drivers/platform/x86/intel/uncore-frequency/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for linux/drivers/platform/x86/intel/uncore-frequency
+#
+
+obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)	+= intel-uncore-frequency.o
+intel-uncore-frequency-y		:= uncore-frequency.o
diff --git a/drivers/platform/x86/intel/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
similarity index 100%
rename from drivers/platform/x86/intel/uncore-frequency.c
rename to drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
-- 
2.31.1


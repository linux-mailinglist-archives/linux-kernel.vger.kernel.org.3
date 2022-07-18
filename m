Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165E85785DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiGROx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiGROx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:53:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F403DDF88;
        Mon, 18 Jul 2022 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658156005; x=1689692005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m6F0uNnAlUN7XIP9hhbwmVRdn+FbI1Q9PO7sWV4MdNk=;
  b=aDqJfTyAzjUK2iPQRp1weBzSPsQXUK90r4dTUmE22lps31rQ4r7Zht4O
   Z10tdsyTlW2E7t3DVWGa0SPkaObh3q5ZOO2S4cNwRRxE4dwBE9vbaaSRs
   zWWw2fu+sB4gPX9zowqMqv0UbiKZS6XGYeK3W/NLRvsTg8/R00hgP0A8e
   uw+b0LtyxsKgK5yi6zn24oE39m++FuQr6vllxz0mzF4326MrYsYAyUO8E
   LQnctYiuJl+6ox1VMOZrpxNw1FFbJ3nXFAne8fV/dOypEIe7YmOPTZoos
   apJgjes+lQLDdvkZzRdLmBnoGwzxXMs+4QAYxS83WTDEBobYTSqBqCl+z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="287389123"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="287389123"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 07:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="739496124"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jul 2022 07:53:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DB46B10E; Mon, 18 Jul 2022 17:53:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, Kate Hsuan <hpa@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/1] platform/x86: p2sb: Move out of X86_PLATFORM_DEVICES dependency
Date:   Mon, 18 Jul 2022 17:53:28 +0300
Message-Id: <20220718145328.14374-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The P2SB library is used for various drivers, including server
platforms. That's why the dependency on X86_PLATFORM_DEVICES
seems superfluous.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v2: added X86 to the dependencies of P2SB (Hans), added Rb tag (Hans)
 drivers/platform/x86/Kconfig            | 12 ++++++++++++
 drivers/platform/x86/Makefile           |  4 ++++
 drivers/platform/x86/intel/Kconfig      | 12 ------------
 drivers/platform/x86/intel/Makefile     |  2 --
 drivers/platform/x86/{intel => }/p2sb.c |  0
 5 files changed, 16 insertions(+), 14 deletions(-)
 rename drivers/platform/x86/{intel => }/p2sb.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index bc4013e950ed..21e03bb901d2 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1164,6 +1164,18 @@ config WINMATE_FM07_KEYS
 
 endif # X86_PLATFORM_DEVICES
 
+config P2SB
+	bool "Primary to Sideband (P2SB) bridge access support"
+	depends on PCI && X86
+	help
+	  The Primary to Sideband (P2SB) bridge is an interface to some
+	  PCI devices connected through it. In particular, SPI NOR controller
+	  in Intel Apollo Lake SoC is one of such devices.
+
+	  The main purpose of this library is to unhide P2SB device in case
+	  firmware kept it hidden on some platforms in order to access devices
+	  behind it.
+
 config PMC_ATOM
        def_bool y
        depends on PCI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 4a59f47a46e2..f04001431c91 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -120,6 +120,10 @@ obj-$(CONFIG_X86_ANDROID_TABLETS)	+= x86-android-tablets.o
 # Intel uncore drivers
 obj-$(CONFIG_INTEL_IPS)				+= intel_ips.o
 
+# Intel miscellaneous drivers
+intel_p2sb-y				:= p2sb.o
+obj-$(CONFIG_P2SB)			+= intel_p2sb.o
+
 # Intel PMIC / PMC / P-Unit devices
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
 obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index c9cfbaae436b..794968bda115 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -70,18 +70,6 @@ config INTEL_OAKTRAIL
 	  enable/disable the Camera, WiFi, BT etc. devices. If in doubt, say Y
 	  here; it will only load on supported platforms.
 
-config P2SB
-	bool "Primary to Sideband (P2SB) bridge access support"
-	depends on PCI
-	help
-	  The Primary to Sideband (P2SB) bridge is an interface to some
-	  PCI devices connected through it. In particular, SPI NOR controller
-	  in Intel Apollo Lake SoC is one of such devices.
-
-	  The main purpose of this library is to unhide P2SB device in case
-	  firmware kept it hidden on some platforms in order to access devices
-	  behind it.
-
 config INTEL_BXTWC_PMIC_TMU
 	tristate "Intel Broxton Whiskey Cove TMU Driver"
 	depends on INTEL_SOC_PMIC_BXTWC
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 741a9404db98..717933dd0cfd 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -28,8 +28,6 @@ intel_int0002_vgpio-y			:= int0002_vgpio.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 intel_oaktrail-y			:= oaktrail.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
-intel_p2sb-y				:= p2sb.o
-obj-$(CONFIG_P2SB)			+= intel_p2sb.o
 intel_sdsi-y				:= sdsi.o
 obj-$(CONFIG_INTEL_SDSI)		+= intel_sdsi.o
 intel_vsec-y				:= vsec.o
diff --git a/drivers/platform/x86/intel/p2sb.c b/drivers/platform/x86/p2sb.c
similarity index 100%
rename from drivers/platform/x86/intel/p2sb.c
rename to drivers/platform/x86/p2sb.c
-- 
2.35.1


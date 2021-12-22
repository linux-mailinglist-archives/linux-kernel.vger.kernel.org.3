Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA40A47D7FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbhLVTt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:49:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:25635 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345312AbhLVTtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640202591; x=1671738591;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+u45g5FS9ncjvOzB2qszi41Ir5iwmdP/6PPp75iwrjs=;
  b=B3zIJNi/ko5XbykmlWpMM6sAX5FqonzaGJecFHZbPaDeFuY4RHN87brj
   54ySmnlf4ddPX0rVf3vEXwE1mM3DuG+o3S+BCEW0tlwc2wl+6Sycbt6sH
   efMCd0rxsxm3TS8IjiVwz6yeN1BWH7Q8Hso4k3tHQHHa4VfhhOm7o7cnL
   ZIClPhK9saEOwyRi9D2GYag9nl7fR5ciK7hUbMprFk1ZVL1fnkh6BJZdG
   VI2gUVRcpRpr3QZsC9SK7j3xWB5q2LjwObhUI8cUMqv57XLRWxbwcQbj8
   /rZj82zBIP+lcmaOhlBepB4cE/rOI6kCBjKGIPhDhqRd+uViX9m2G3vrv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="304067528"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="304067528"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 11:49:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="664375492"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2021 11:49:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1C601FE; Wed, 22 Dec 2021 21:49:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
Subject: [PATCH v1 1/1] platform/x86/intel: Remove X86_PLATFORM_DRIVERS_INTEL
Date:   Wed, 22 Dec 2021 21:49:41 +0200
Message-Id: <20211222194941.76054-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While introduction of this menu brings a nice view in the configuration tools,
it brought more issues than solves, i.e. it prevents to locate files in the
intel/ subfolder without touching non-related Kconfig dependencies elsewhere.
Drop X86_PLATFORM_DRIVERS_INTEL altogether.

Note, on x86 it's enabled by default and it's quite unlikely anybody wants to
disable all of the modules in this submenu.

Fixes: 8bd836feb6ca ("platform/x86: intel_skl_int3472: Move to intel/ subfolder")
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/Makefile      |  2 +-
 drivers/platform/x86/intel/Kconfig | 15 ---------------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index dfb7ca88f012..18b11769073b 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -69,7 +69,7 @@ obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
 obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 
 # Intel
-obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
+obj-y				+= intel/
 
 # MSI
 obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index e0cc64dcf72c..f8b53f24f6f2 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -3,19 +3,6 @@
 # Intel x86 Platform Specific Drivers
 #
 
-menuconfig X86_PLATFORM_DRIVERS_INTEL
-	bool "Intel x86 Platform Specific Device Drivers"
-	default y
-	help
-	  Say Y here to get to see options for device drivers for
-	  various Intel x86 platforms, including vendor-specific
-	  drivers. This option alone does not add any kernel code.
-
-	  If you say N, all options in this submenu will be skipped
-	  and disabled.
-
-if X86_PLATFORM_DRIVERS_INTEL
-
 source "drivers/platform/x86/intel/atomisp2/Kconfig"
 source "drivers/platform/x86/intel/int1092/Kconfig"
 source "drivers/platform/x86/intel/int33fe/Kconfig"
@@ -195,5 +182,3 @@ config INTEL_UNCORE_FREQ_CONTROL
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-uncore-frequency.
-
-endif # X86_PLATFORM_DRIVERS_INTEL
-- 
2.34.1


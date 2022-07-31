Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5E258613F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 22:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbiGaUNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 16:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiGaUND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:13:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9EDEE07
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659298382; x=1690834382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mSjwg+d6IVWVm+Xe0h2TaAOWoxuqXJl5bodxlLMEj4I=;
  b=XfMCj9sg7t8Ua/VMQcIcOlaF+YhgnJMvupIwtiHWyACaCMQculzF1U9q
   q+h3/qN4VSgI4IP6bGIte/pVjyJ1SxQIPjsXPer+vnZS6vdLP5RKON7U2
   ZsSGgcv9ce93IIvz+aCYbdRjUZgPt1fhjKc4slzv0mnGmY/noHZ+595nf
   q4VPYXvR+7vz+cnSGfWlUIrRLfTAd1Q89j6D+BSJd2k2/slk+1GtNyQrE
   qBSsbmUFV7TTo3lPAsKGSNYNUw2E3EE43Np6XgvUNn151iKuz9Hjdq1qb
   eerykAYhFHXeM17P9sCB7PZhMfR1rFJor4gJWckb8IeFNijHF2RIApEXi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="314841144"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="314841144"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 13:13:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="601824036"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 31 Jul 2022 13:13:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7BFFD1DF; Sun, 31 Jul 2022 23:13:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2 07/10] mfd: intel_soc_pmic_crc: Drop redundant ACPI_PTR() and ifdeffery
Date:   Sun, 31 Jul 2022 23:12:55 +0300
Message-Id: <20220731201258.11262-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com>
References: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver depends on ACPI, ACPI_PTR() resolution is always the same.
Otherwise a compiler may produce a warning.

That said, the rule of thumb either ugly ifdeffery with ACPI_PTR or
none should be used in a driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v2: added tags and rebased on top of new patch 1

 drivers/mfd/Kconfig              | 4 ++--
 drivers/mfd/intel_soc_pmic_crc.c | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index abb58ab1a1a4..60196bdc8a1d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -589,8 +589,8 @@ config LPC_SCH
 
 config INTEL_SOC_PMIC
 	bool "Support for Crystal Cove PMIC"
-	depends on ACPI && HAS_IOMEM && I2C=y && GPIOLIB && COMMON_CLK
-	depends on X86 || COMPILE_TEST
+	depends on HAS_IOMEM && I2C=y && GPIOLIB && COMMON_CLK
+	depends on (X86 && ACPI) || COMPILE_TEST
 	depends on I2C_DESIGNWARE_PLATFORM=y
 	select MFD_CORE
 	select REGMAP_I2C
diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index d68ed5b35fd9..17fcb10930f6 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -8,9 +8,9 @@
  * Author: Zhu, Lejun <lejun.zhu@linux.intel.com>
  */
 
-#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/intel_soc_pmic.h>
@@ -259,19 +259,17 @@ static const struct i2c_device_id intel_soc_pmic_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, intel_soc_pmic_i2c_id);
 
-#if defined(CONFIG_ACPI)
 static const struct acpi_device_id intel_soc_pmic_acpi_match[] = {
 	{ "INT33FD" },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, intel_soc_pmic_acpi_match);
-#endif
 
 static struct i2c_driver intel_soc_pmic_i2c_driver = {
 	.driver = {
 		.name = "intel_soc_pmic_i2c",
 		.pm = pm_sleep_ptr(&crystal_cove_pm_ops),
-		.acpi_match_table = ACPI_PTR(intel_soc_pmic_acpi_match),
+		.acpi_match_table = intel_soc_pmic_acpi_match,
 	},
 	.probe = intel_soc_pmic_i2c_probe,
 	.remove = intel_soc_pmic_i2c_remove,
-- 
2.35.1


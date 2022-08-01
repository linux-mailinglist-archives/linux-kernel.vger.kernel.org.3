Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEB7586855
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiHALnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiHALnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:43:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6293718A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659354157; x=1690890157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7JBvDZP4p/BKzgaZNqGL310E8vtr+lPCaObHWNq+O1o=;
  b=PcIc0+gqI+3wZ9k4pOLAC1hb0Sz5bLbgYF6k8o/FqPMk+eEhHDianQtw
   P984ufQSV4JJXxkSSwX8CvqyBooTsbF0xQTUE0Gj1Ig57vpCZ7SXkwAzB
   xttZ21HUsLy5bcjQMsiOAGxVE/+T0CP42i861SaXN+CcTElpVOwbe3uo0
   Lz41Me7IYlmOlNz8QuTbp6WotFKq6PO27Ybyh+FMPLlEv+w8ZkzIa8/II
   p6hV1HhpQZr5gpMnXqFSrvoL61NrAM12sHkMpDIOSOVXb8ZyYTTSxPb1U
   45MsROmLe9LMx7PZrWduf3UsN97tHXf0rGOTYfDWo002vCf+jGpJy5AQv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="289136874"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="289136874"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 04:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="691434139"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Aug 2022 04:42:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 27258119; Mon,  1 Aug 2022 14:42:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v3 07/10] mfd: intel_soc_pmic_crc: Drop redundant ACPI_PTR() and ifdeffery
Date:   Mon,  1 Aug 2022 14:42:08 +0300
Message-Id: <20220801114211.36267-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
References: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

v3: no changes
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


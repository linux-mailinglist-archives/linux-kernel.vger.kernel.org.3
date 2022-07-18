Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AD1578231
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiGRMXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiGRMXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:23:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB57255B2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658147013; x=1689683013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wRanRGGsZdo76h1hCNteQXl2rHIR0kqsJxIMcDkDU5M=;
  b=jXLXrOBzqUKcz5CPA2Hk8K6PFBfPW12ADjvnYsiAlAU/ZcI8OAJisUQF
   QQLuTo2FtHlKMmbJdVFmp5cS7xsvXO7vdDwEz0xQTYTO5nuFaSWfSc8zJ
   WfTCTw80m0ZZ1dBJSYXiljinrFc9UMifmEToCBZWZPBL4jD291tbiCxH4
   q9Hv+CwIB6iETgOsxeHxzzWbeU7PgKseQoT7+hRCk8TiNAIaVesPN6b6l
   W7rNwGcbOizj6OUjVJn/TyraXQjB8ULpDguOJQ+FVbjYehEHtTfE+0X2F
   RT/S2TO9us6HjOW/yd2/VHaDCIQZwtCFsbWmz+5z7e3JGg+FYp8pLkvMV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="273035535"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="273035535"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 05:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="773712591"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 18 Jul 2022 05:23:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5B9ED25F; Mon, 18 Jul 2022 15:23:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [RESEND][PATCH v1 4/9] mfd: intel_soc_pmic_crc: Drop redundant ACPI_PTR() and ifdeffery
Date:   Mon, 18 Jul 2022 15:23:23 +0300
Message-Id: <20220718122328.8287-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
References: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
 drivers/mfd/Kconfig              | 4 ++--
 drivers/mfd/intel_soc_pmic_crc.c | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3b59456f5545..2bbfeeac6f8e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -588,8 +588,8 @@ config LPC_SCH
 
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
index c034e226a0bb..f1e5fdd846b3 100644
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
@@ -254,19 +254,17 @@ static const struct i2c_device_id intel_soc_pmic_i2c_id[] = {
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


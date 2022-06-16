Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C000C54E949
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbiFPSZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbiFPSZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:25:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE942506D1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655403933; x=1686939933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F5TmVdUsOr6x4fRtTzIjzcJSM5ltZv4cGKwo84+MqaM=;
  b=mX8iCuC7uasqmC6qFAaust2CCuUaN7Rr3IEwzu0ZaNinqhQxnpMzlueq
   AcNOHCz3+TQ7z2zB2gGSfxhgFUKZLWplfOAnsIzNGdFOvFT7JiV8hKuYd
   YfvxRnrTwhFHWuuVkuJyTLexFPYDJeWgqpObzT621zEumIoolkFLOcVqk
   PCSB5knHfsAvEP0WgqnxMmnCniNgXbMoDlJ+r99YzXXCxPXpQotdGTO3z
   4o8QeWlbfUk+O9gdztHv3D31SiHS3yCggOUuEFfEHhQuSQONdW7+SsECn
   GgUPW7SwnAYYQ+ADJWB4ADQkT7i1pjOmaoIpCGS8MzDRo6CZF4r9LuqAV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280353765"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280353765"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 11:25:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="589759618"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2022 11:25:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 51D163B9; Thu, 16 Jun 2022 21:25:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 6/9] mfd: intel_soc_pmic_crc: Drop redundant ACPI_PTR() and ifdeffery
Date:   Thu, 16 Jun 2022 21:25:21 +0300
Message-Id: <20220616182524.7956-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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


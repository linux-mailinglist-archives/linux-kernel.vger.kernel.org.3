Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226BE54E94A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377612AbiFPSZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiFPSZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:25:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3055044A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655403931; x=1686939931;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MMLRM+uN4vDM2IW962qIFRZNfliR5WiWkfUE0aH2Qww=;
  b=d7rEyla8zAevCMuIqVL2s3T48w42i+cejKJHKRn6uIAxYbstH50F5kUq
   r6dukIsFeNYZ6GCmv37FLfbVcfqDwFGQRhOkBtWbnBaSpb+gzj0o1p5bN
   XZL1AWep4Jm53cBfRnJ4RYkETl50XI+54zNXoAwNqHyALwcyXC/f7IBdT
   8as0jl3vnSw5zCnYogOKPwcO8Xvmu5uQE5ujJxAmJIaJHMoKCZnXdmsLP
   f44ke2adZgQd1lPpLyhuucVP6zyglAqUutWk0JxDuyLSyuR3RB05mMQ6F
   nSqaOSzbBpSebazY0YgzDJQBZbHXU7vRFp8LYSN9Uq/B41CJv02sa8rV7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280034963"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280034963"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 11:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="613259378"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 16 Jun 2022 11:25:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 00F80109; Thu, 16 Jun 2022 21:25:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to crc
Date:   Thu, 16 Jun 2022 21:25:16 +0300
Message-Id: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core part is misleading since its only purpose to serve Crystal Cove PMIC,
although for couple of different platforms. Merge core part into crc one.

Advantages among others are:
- speed up a compilation and build
- decreasing the code base
- reducing noise in the namespace by making some data static and const

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/Makefile              |   3 +-
 drivers/mfd/intel_soc_pmic_core.c | 160 -----------------------------
 drivers/mfd/intel_soc_pmic_core.h |  25 -----
 drivers/mfd/intel_soc_pmic_crc.c  | 162 ++++++++++++++++++++++++++++--
 4 files changed, 157 insertions(+), 193 deletions(-)
 delete mode 100644 drivers/mfd/intel_soc_pmic_core.c
 delete mode 100644 drivers/mfd/intel_soc_pmic_core.h

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf659d6..61db669f864c 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -236,8 +236,7 @@ obj-$(CONFIG_MFD_RT4831)	+= rt4831.o
 obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
 obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
 
-intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
-obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
+obj-$(CONFIG_INTEL_SOC_PMIC)		+= intel_soc_pmic_crc.o
 obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)	+= intel_soc_pmic_bxtwc.o
 obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)	+= intel_soc_pmic_chtwc.o
 obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
deleted file mode 100644
index 5e8c94e008ed..000000000000
--- a/drivers/mfd/intel_soc_pmic_core.c
+++ /dev/null
@@ -1,160 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Intel SoC PMIC MFD Driver
- *
- * Copyright (C) 2013, 2014 Intel Corporation. All rights reserved.
- *
- * Author: Yang, Bin <bin.yang@intel.com>
- * Author: Zhu, Lejun <lejun.zhu@linux.intel.com>
- */
-
-#include <linux/acpi.h>
-#include <linux/i2c.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/mfd/core.h>
-#include <linux/mfd/intel_soc_pmic.h>
-#include <linux/platform_data/x86/soc.h>
-#include <linux/pwm.h>
-#include <linux/regmap.h>
-
-#include "intel_soc_pmic_core.h"
-
-/* PWM consumed by the Intel GFX */
-static struct pwm_lookup crc_pwm_lookup[] = {
-	PWM_LOOKUP("crystal_cove_pwm", 0, "0000:00:02.0", "pwm_pmic_backlight", 0, PWM_POLARITY_NORMAL),
-};
-
-static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
-				    const struct i2c_device_id *i2c_id)
-{
-	struct device *dev = &i2c->dev;
-	struct intel_soc_pmic_config *config;
-	struct intel_soc_pmic *pmic;
-	int ret;
-
-	if (soc_intel_is_byt())
-		config = &intel_soc_pmic_config_byt_crc;
-	else
-		config = &intel_soc_pmic_config_cht_crc;
-
-	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
-	if (!pmic)
-		return -ENOMEM;
-
-	dev_set_drvdata(dev, pmic);
-
-	pmic->regmap = devm_regmap_init_i2c(i2c, config->regmap_config);
-	if (IS_ERR(pmic->regmap))
-		return PTR_ERR(pmic->regmap);
-
-	pmic->irq = i2c->irq;
-
-	ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
-				  config->irq_flags | IRQF_ONESHOT,
-				  0, config->irq_chip,
-				  &pmic->irq_chip_data);
-	if (ret)
-		return ret;
-
-	ret = enable_irq_wake(pmic->irq);
-	if (ret)
-		dev_warn(dev, "Can't enable IRQ as wake source: %d\n", ret);
-
-	/* Add lookup table for crc-pwm */
-	pwm_add_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
-
-	/* To distuingish this domain from the GPIO/charger's irqchip domains */
-	irq_domain_update_bus_token(regmap_irq_get_domain(pmic->irq_chip_data),
-				    DOMAIN_BUS_NEXUS);
-
-	ret = mfd_add_devices(dev, -1, config->cell_dev,
-			      config->n_cell_devs, NULL, 0,
-			      regmap_irq_get_domain(pmic->irq_chip_data));
-	if (ret)
-		goto err_del_irq_chip;
-
-	return 0;
-
-err_del_irq_chip:
-	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
-	return ret;
-}
-
-static int intel_soc_pmic_i2c_remove(struct i2c_client *i2c)
-{
-	struct intel_soc_pmic *pmic = dev_get_drvdata(&i2c->dev);
-
-	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
-
-	/* remove crc-pwm lookup table */
-	pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
-
-	mfd_remove_devices(&i2c->dev);
-
-	return 0;
-}
-
-static void intel_soc_pmic_shutdown(struct i2c_client *i2c)
-{
-	struct intel_soc_pmic *pmic = dev_get_drvdata(&i2c->dev);
-
-	disable_irq(pmic->irq);
-
-	return;
-}
-
-#if defined(CONFIG_PM_SLEEP)
-static int intel_soc_pmic_suspend(struct device *dev)
-{
-	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
-
-	disable_irq(pmic->irq);
-
-	return 0;
-}
-
-static int intel_soc_pmic_resume(struct device *dev)
-{
-	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
-
-	enable_irq(pmic->irq);
-
-	return 0;
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(intel_soc_pmic_pm_ops, intel_soc_pmic_suspend,
-			 intel_soc_pmic_resume);
-
-static const struct i2c_device_id intel_soc_pmic_i2c_id[] = {
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, intel_soc_pmic_i2c_id);
-
-#if defined(CONFIG_ACPI)
-static const struct acpi_device_id intel_soc_pmic_acpi_match[] = {
-	{ "INT33FD" },
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, intel_soc_pmic_acpi_match);
-#endif
-
-static struct i2c_driver intel_soc_pmic_i2c_driver = {
-	.driver = {
-		.name = "intel_soc_pmic_i2c",
-		.pm = &intel_soc_pmic_pm_ops,
-		.acpi_match_table = ACPI_PTR(intel_soc_pmic_acpi_match),
-	},
-	.probe = intel_soc_pmic_i2c_probe,
-	.remove = intel_soc_pmic_i2c_remove,
-	.id_table = intel_soc_pmic_i2c_id,
-	.shutdown = intel_soc_pmic_shutdown,
-};
-
-module_i2c_driver(intel_soc_pmic_i2c_driver);
-
-MODULE_DESCRIPTION("I2C driver for Intel SoC PMIC");
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Yang, Bin <bin.yang@intel.com>");
-MODULE_AUTHOR("Zhu, Lejun <lejun.zhu@linux.intel.com>");
diff --git a/drivers/mfd/intel_soc_pmic_core.h b/drivers/mfd/intel_soc_pmic_core.h
deleted file mode 100644
index d490685845eb..000000000000
--- a/drivers/mfd/intel_soc_pmic_core.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Intel SoC PMIC MFD Driver
- *
- * Copyright (C) 2012-2014 Intel Corporation. All rights reserved.
- *
- * Author: Yang, Bin <bin.yang@intel.com>
- * Author: Zhu, Lejun <lejun.zhu@linux.intel.com>
- */
-
-#ifndef __INTEL_SOC_PMIC_CORE_H__
-#define __INTEL_SOC_PMIC_CORE_H__
-
-struct intel_soc_pmic_config {
-	unsigned long irq_flags;
-	struct mfd_cell *cell_dev;
-	int n_cell_devs;
-	const struct regmap_config *regmap_config;
-	const struct regmap_irq_chip *irq_chip;
-};
-
-extern struct intel_soc_pmic_config intel_soc_pmic_config_byt_crc;
-extern struct intel_soc_pmic_config intel_soc_pmic_config_cht_crc;
-
-#endif	/* __INTEL_SOC_PMIC_CORE_H__ */
diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 5bb0367bd974..b5974dfcc603 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -2,18 +2,21 @@
 /*
  * Device access for Crystal Cove PMIC
  *
- * Copyright (C) 2013, 2014 Intel Corporation. All rights reserved.
+ * Copyright (C) 2012-2014 Intel Corporation. All rights reserved.
  *
  * Author: Yang, Bin <bin.yang@intel.com>
  * Author: Zhu, Lejun <lejun.zhu@linux.intel.com>
  */
 
+#include <linux/acpi.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/regmap.h>
+#include <linux/module.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/intel_soc_pmic.h>
-
-#include "intel_soc_pmic_core.h"
+#include <linux/platform_data/x86/soc.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
 
 #define CRYSTAL_COVE_MAX_REGISTER	0xC6
 
@@ -132,7 +135,20 @@ static const struct regmap_irq_chip crystal_cove_irq_chip = {
 	.mask_base = CRYSTAL_COVE_REG_MIRQLVL1,
 };
 
-struct intel_soc_pmic_config intel_soc_pmic_config_byt_crc = {
+/* PWM consumed by the Intel GFX */
+static struct pwm_lookup crc_pwm_lookup[] = {
+	PWM_LOOKUP("crystal_cove_pwm", 0, "0000:00:02.0", "pwm_pmic_backlight", 0, PWM_POLARITY_NORMAL),
+};
+
+struct intel_soc_pmic_config {
+	unsigned long irq_flags;
+	struct mfd_cell *cell_dev;
+	int n_cell_devs;
+	const struct regmap_config *regmap_config;
+	const struct regmap_irq_chip *irq_chip;
+};
+
+static const struct intel_soc_pmic_config intel_soc_pmic_config_byt_crc = {
 	.irq_flags = IRQF_TRIGGER_RISING,
 	.cell_dev = crystal_cove_byt_dev,
 	.n_cell_devs = ARRAY_SIZE(crystal_cove_byt_dev),
@@ -140,10 +156,144 @@ struct intel_soc_pmic_config intel_soc_pmic_config_byt_crc = {
 	.irq_chip = &crystal_cove_irq_chip,
 };
 
-struct intel_soc_pmic_config intel_soc_pmic_config_cht_crc = {
+static const struct intel_soc_pmic_config intel_soc_pmic_config_cht_crc = {
 	.irq_flags = IRQF_TRIGGER_RISING,
 	.cell_dev = crystal_cove_cht_dev,
 	.n_cell_devs = ARRAY_SIZE(crystal_cove_cht_dev),
 	.regmap_config = &crystal_cove_regmap_config,
 	.irq_chip = &crystal_cove_irq_chip,
 };
+
+static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
+				    const struct i2c_device_id *i2c_id)
+{
+	const struct intel_soc_pmic_config *config;
+	struct device *dev = &i2c->dev;
+	struct intel_soc_pmic *pmic;
+	int ret;
+
+	if (soc_intel_is_byt())
+		config = &intel_soc_pmic_config_byt_crc;
+	else
+		config = &intel_soc_pmic_config_cht_crc;
+
+	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
+	if (!pmic)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, pmic);
+
+	pmic->regmap = devm_regmap_init_i2c(i2c, config->regmap_config);
+	if (IS_ERR(pmic->regmap))
+		return PTR_ERR(pmic->regmap);
+
+	pmic->irq = i2c->irq;
+
+	ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
+				  config->irq_flags | IRQF_ONESHOT,
+				  0, config->irq_chip,
+				  &pmic->irq_chip_data);
+	if (ret)
+		return ret;
+
+	ret = enable_irq_wake(pmic->irq);
+	if (ret)
+		dev_warn(dev, "Can't enable IRQ as wake source: %d\n", ret);
+
+	/* Add lookup table for crc-pwm */
+	pwm_add_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
+
+	/* To distuingish this domain from the GPIO/charger's irqchip domains */
+	irq_domain_update_bus_token(regmap_irq_get_domain(pmic->irq_chip_data),
+				    DOMAIN_BUS_NEXUS);
+
+	ret = mfd_add_devices(dev, -1, config->cell_dev,
+			      config->n_cell_devs, NULL, 0,
+			      regmap_irq_get_domain(pmic->irq_chip_data));
+	if (ret)
+		goto err_del_irq_chip;
+
+	return 0;
+
+err_del_irq_chip:
+	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
+	return ret;
+}
+
+static int intel_soc_pmic_i2c_remove(struct i2c_client *i2c)
+{
+	struct intel_soc_pmic *pmic = dev_get_drvdata(&i2c->dev);
+
+	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
+
+	/* remove crc-pwm lookup table */
+	pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
+
+	mfd_remove_devices(&i2c->dev);
+
+	return 0;
+}
+
+static void intel_soc_pmic_shutdown(struct i2c_client *i2c)
+{
+	struct intel_soc_pmic *pmic = dev_get_drvdata(&i2c->dev);
+
+	disable_irq(pmic->irq);
+
+	return;
+}
+
+#if defined(CONFIG_PM_SLEEP)
+static int intel_soc_pmic_suspend(struct device *dev)
+{
+	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
+
+	disable_irq(pmic->irq);
+
+	return 0;
+}
+
+static int intel_soc_pmic_resume(struct device *dev)
+{
+	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
+
+	enable_irq(pmic->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(intel_soc_pmic_pm_ops, intel_soc_pmic_suspend,
+			 intel_soc_pmic_resume);
+
+static const struct i2c_device_id intel_soc_pmic_i2c_id[] = {
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, intel_soc_pmic_i2c_id);
+
+#if defined(CONFIG_ACPI)
+static const struct acpi_device_id intel_soc_pmic_acpi_match[] = {
+	{ "INT33FD" },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, intel_soc_pmic_acpi_match);
+#endif
+
+static struct i2c_driver intel_soc_pmic_i2c_driver = {
+	.driver = {
+		.name = "intel_soc_pmic_i2c",
+		.pm = &intel_soc_pmic_pm_ops,
+		.acpi_match_table = ACPI_PTR(intel_soc_pmic_acpi_match),
+	},
+	.probe = intel_soc_pmic_i2c_probe,
+	.remove = intel_soc_pmic_i2c_remove,
+	.id_table = intel_soc_pmic_i2c_id,
+	.shutdown = intel_soc_pmic_shutdown,
+};
+
+module_i2c_driver(intel_soc_pmic_i2c_driver);
+
+MODULE_DESCRIPTION("I2C driver for Intel SoC PMIC");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Yang, Bin <bin.yang@intel.com>");
+MODULE_AUTHOR("Zhu, Lejun <lejun.zhu@linux.intel.com>");
-- 
2.35.1


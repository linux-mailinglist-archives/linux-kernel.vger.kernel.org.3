Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9E358684F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiHALmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiHALmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:42:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473F128737
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659354125; x=1690890125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2cuZop3cf89zepiQgKWLMcw0L5xjrOf98HrsxPDmZHk=;
  b=RVTouJdzDSX2whZo9IeJO9DA0DOu4MZZxWdgN3lqHe9vtU7UFFe5rg85
   9qBUFiSBmsSe6iJQB8d8TWI7W0/L2sUEWWiGYXpazbLB8dgQXU3dPVPWz
   kR9LSGtcU4CJYPGVSts1Y4lsFBcFYYrKpEXJfhWOlFnZ/XX3UTBX4DfYy
   LOEEwEVshi2OTxqcTHHawPtytvvlIDSU9jHSUvpUPZCI0Z7Ht/m7fMubt
   uB+rv0SWTs2406F/KEOmoZBz5NNAbL/yUZodpMbcIWj+rRKvDD5wo9Sa0
   ZOcaxG2tygbXs2p2h/gG67UaxKcuDlXATw0BmYAXvAks9aKgtAEHI5zEV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="375427544"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="375427544"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 04:42:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="744235863"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Aug 2022 04:42:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E804B86; Mon,  1 Aug 2022 14:42:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v3 02/10] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to crc
Date:   Mon,  1 Aug 2022 14:42:03 +0300
Message-Id: <20220801114211.36267-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
References: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---

v3: removed not used file (Christophe)
v2: added tags and rebased on top of new patch 1

 drivers/mfd/Makefile              |   3 +-
 drivers/mfd/intel_soc_pmic_core.c | 161 -----------------------------
 drivers/mfd/intel_soc_pmic_core.h |  25 -----
 drivers/mfd/intel_soc_pmic_crc.c  | 163 ++++++++++++++++++++++++++++--
 4 files changed, 158 insertions(+), 194 deletions(-)
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
index 85d070bce0e2..000000000000
--- a/drivers/mfd/intel_soc_pmic_core.c
+++ /dev/null
@@ -1,161 +0,0 @@
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
-	pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
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
index 5bb0367bd974..c4e6456976f5 100644
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
@@ -140,10 +156,145 @@ struct intel_soc_pmic_config intel_soc_pmic_config_byt_crc = {
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
+	pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
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


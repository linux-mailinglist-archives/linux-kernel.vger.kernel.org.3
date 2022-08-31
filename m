Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2AE5A7F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiHaNqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiHaNqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:46:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C902540E05;
        Wed, 31 Aug 2022 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661953519; x=1693489519;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CPz8tFvmjCETRnWkDdN4A4m76OAij9MXx2jCl1f/FVc=;
  b=mNGMjpBI4rKbW6z09pVA8AI1j2pd2j8Xyd6RZ0R+5xNocss09+cY0Tz5
   xVkMeohK8I7zFwA4b8ht0XNM8ICbg2UglcdXChAkbptcAlhtpiJMEXYG9
   EqDWasPiUbIY9PLvm0pyizg0g2KtATAAS3FhVTuoCWm4Fm3jyj6vGdMVI
   lepami1I+gTNMxfaBoEk6HXvUD/RjAaA57UxhXAcZRQVbJMg3zxmhDmUp
   UYRNbKK+Avu/wDdsNaBw9biQKIwQFcB7qAMqkgpuE36qtVEF0LCNTc9FX
   nUf+Fisyc7GgL6yCbQhpqDVZcF4apegO/YOfISCbyPxCC3dusoxRpoPVD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="293024296"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="293024296"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 06:45:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="589035277"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 31 Aug 2022 06:45:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 265F3174; Wed, 31 Aug 2022 16:45:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jianqun Xu <jay.xu@rock-chips.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] gpio: rockchip: Switch to use fwnode instead of of_node
Date:   Wed, 31 Aug 2022 16:45:16 +0300
Message-Id: <20220831134516.78108-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library now accepts fwnode as a firmware node, so
switch the driver to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed compilation errors (LKP), replace some OF calls (Bart)
 drivers/gpio/gpio-rockchip.c       | 38 +++++++++++-------------------
 drivers/pinctrl/pinctrl-rockchip.h |  2 --
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index bb50335239ac..e8fa99fd4c80 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -14,12 +14,11 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/pinctrl/pinconf-generic.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include "../pinctrl/core.h"
@@ -518,7 +517,7 @@ static int rockchip_interrupts_register(struct rockchip_pin_bank *bank)
 	struct irq_chip_generic *gc;
 	int ret;
 
-	bank->domain = irq_domain_add_linear(bank->of_node, 32,
+	bank->domain = irq_domain_create_linear(dev_fwnode(bank->dev), 32,
 					&irq_generic_chip_ops, NULL);
 	if (!bank->domain) {
 		dev_warn(bank->dev, "could not init irq domain for bank %s\n",
@@ -606,14 +605,10 @@ static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
 	 * files which don't set the "gpio-ranges" property or systems that
 	 * utilize ACPI the driver has to call gpiochip_add_pin_range().
 	 */
-	if (!of_property_read_bool(bank->of_node, "gpio-ranges")) {
-		struct device_node *pctlnp = of_get_parent(bank->of_node);
+	if (!device_property_read_bool(bank->dev, "gpio-ranges")) {
 		struct pinctrl_dev *pctldev = NULL;
 
-		if (!pctlnp)
-			return -ENODATA;
-
-		pctldev = of_pinctrl_get(pctlnp);
+		pctldev = pinctrl_get(bank->dev->parent);
 		if (!pctldev)
 			return -ENODEV;
 
@@ -641,23 +636,20 @@ static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
 
 static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 {
+	struct platform_device *pdev = to_platform_device(bank->dev);
+	struct device_node *np = bank->dev->of_node;
 	struct resource res;
 	int id = 0;
 
-	if (of_address_to_resource(bank->of_node, 0, &res)) {
-		dev_err(bank->dev, "cannot find IO resource for bank\n");
-		return -ENOENT;
-	}
-
-	bank->reg_base = devm_ioremap_resource(bank->dev, &res);
+	bank->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bank->reg_base))
 		return PTR_ERR(bank->reg_base);
 
-	bank->irq = irq_of_parse_and_map(bank->of_node, 0);
+	bank->irq = platform_get_irq(pdev, 0);
 	if (!bank->irq)
 		return -EINVAL;
 
-	bank->clk = of_clk_get(bank->of_node, 0);
+	bank->clk = of_clk_get(np, 0);
 	if (IS_ERR(bank->clk))
 		return PTR_ERR(bank->clk);
 
@@ -668,7 +660,7 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 	if (id == GPIO_TYPE_V2 || id == GPIO_TYPE_V2_1) {
 		bank->gpio_regs = &gpio_regs_v2;
 		bank->gpio_type = GPIO_TYPE_V2;
-		bank->db_clk = of_clk_get(bank->of_node, 1);
+		bank->db_clk = of_clk_get(np, 1);
 		if (IS_ERR(bank->db_clk)) {
 			dev_err(bank->dev, "cannot find debounce clk\n");
 			clk_disable_unprepare(bank->clk);
@@ -705,17 +697,16 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *pctlnp = of_get_parent(np);
 	struct pinctrl_dev *pctldev = NULL;
 	struct rockchip_pin_bank *bank = NULL;
 	struct rockchip_pin_deferred *cfg;
 	static int gpio;
 	int id, ret;
 
-	if (!np || !pctlnp)
+	if (!dev->parent)
 		return -ENODEV;
 
-	pctldev = of_pinctrl_get(pctlnp);
+	pctldev = pinctrl_get(dev->parent);
 	if (!pctldev)
 		return -EPROBE_DEFER;
 
@@ -728,7 +719,6 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	bank->dev = dev;
-	bank->of_node = np;
 
 	raw_spin_lock_init(&bank->slock);
 
@@ -776,7 +766,7 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 	mutex_unlock(&bank->deferred_lock);
 
 	platform_set_drvdata(pdev, bank);
-	dev_info(dev, "probed %pOF\n", np);
+	dev_info(dev, "probed %pfw\n", dev_fwnode(dev));
 
 	return 0;
 }
diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
index 4759f336941e..37a0501bcc03 100644
--- a/drivers/pinctrl/pinctrl-rockchip.h
+++ b/drivers/pinctrl/pinctrl-rockchip.h
@@ -299,7 +299,6 @@ struct rockchip_drv {
  * @drv: array describing the 4 drive strength sources of the bank
  * @pull_type: array describing the 4 pull type sources of the bank
  * @valid: is all necessary information present
- * @of_node: dt node of this bank
  * @drvdata: common pinctrl basedata
  * @domain: irqdomain of the gpio bank
  * @gpio_chip: gpiolib chip
@@ -327,7 +326,6 @@ struct rockchip_pin_bank {
 	struct rockchip_drv		drv[4];
 	enum rockchip_pin_pull_type	pull_type[4];
 	bool				valid;
-	struct device_node		*of_node;
 	struct rockchip_pinctrl		*drvdata;
 	struct irq_domain		*domain;
 	struct gpio_chip		gpio_chip;
-- 
2.35.1


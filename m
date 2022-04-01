Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB43E4EEB98
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344439AbiDAKjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344972AbiDAKiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:38:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31A4266B6C;
        Fri,  1 Apr 2022 03:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648809380; x=1680345380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=quiOeAqtTm+C8H3Wl/anEY+Gx1ydJ3w0/kutBLStKno=;
  b=Cx+zHo2tvuxU0ChVsBggZxwCDMHsLOdKTrl4ZAnqH1PLvAu380ehx0s4
   /K2SlEJglop0ofDsSDBrdfkAzAebAntEz9ku6yaNqx2J3LHyjx7sOiQjW
   TJz0MUXCy87WFvblImJLaBgQr1PPKnP2TV3348BZ04pzEdrNrUNd1C9m9
   3SLxAbVA0wkH/L/IC7bHo1Gm8oBxMmTxv/gHFqn5pXbxvfTjekm2NWUI6
   FzlERmz/uGXxWgA43d8ZbZlVBDbEcsbQ1DpzWHu846skEequUxTaiPQC2
   +Exx8pb0yjE3P7tPeu0UDyiO7gAYkqbRab+1d8juhfNHcdPDpus5oF4oY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="260281485"
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="260281485"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 03:36:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="640496022"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Apr 2022 03:35:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CED55323; Fri,  1 Apr 2022 13:36:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Qianggui Song <qianggui.song@amlogic.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v4 05/13] pinctrl: samsung: Switch to use for_each_gpiochip_node() helper
Date:   Fri,  1 Apr 2022 13:35:56 +0300
Message-Id: <20220401103604.8705-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
References: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
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

Switch the code to use for_each_gpiochip_node() helper.

While at it, in order to avoid additional churn in the future,
switch to fwnode APIs where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c  |  8 +++---
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c |  2 +-
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c |  4 +--
 drivers/pinctrl/samsung/pinctrl-samsung.c | 30 +++++++++++------------
 drivers/pinctrl/samsung/pinctrl-samsung.h |  2 +-
 5 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index c1c4ffbae6e2..6d7ca1758292 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -307,7 +307,7 @@ __init int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
 		}
 		bank->irq_chip->chip.name = bank->name;
 
-		bank->irq_domain = irq_domain_add_linear(bank->of_node,
+		bank->irq_domain = irq_domain_create_linear(bank->fwnode,
 				bank->nr_pins, &exynos_eint_irqd_ops, bank);
 		if (!bank->irq_domain) {
 			dev_err(dev, "gpio irq domain add failed\n");
@@ -565,7 +565,7 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 		}
 		bank->irq_chip->chip.name = bank->name;
 
-		bank->irq_domain = irq_domain_add_linear(bank->of_node,
+		bank->irq_domain = irq_domain_create_linear(bank->fwnode,
 				bank->nr_pins, &exynos_eint_irqd_ops, bank);
 		if (!bank->irq_domain) {
 			dev_err(dev, "wkup irq domain add failed\n");
@@ -573,7 +573,7 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 			return -ENXIO;
 		}
 
-		if (!of_find_property(bank->of_node, "interrupts", NULL)) {
+		if (!fwnode_property_present(bank->fwnode, "interrupts")) {
 			bank->eint_type = EINT_TYPE_WKUP_MUX;
 			++muxed_banks;
 			continue;
@@ -588,7 +588,7 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 		}
 
 		for (idx = 0; idx < bank->nr_pins; ++idx) {
-			irq = irq_of_parse_and_map(bank->of_node, idx);
+			irq = irq_of_parse_and_map(to_of_node(bank->fwnode), idx);
 			if (!irq) {
 				dev_err(dev, "irq number for eint-%s-%d not found\n",
 							bank->name, idx);
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
index ac1eba30cf40..625cb1065eaf 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
@@ -525,7 +525,7 @@ static int s3c24xx_eint_init(struct samsung_pinctrl_drv_data *d)
 		ops = (bank->eint_offset == 0) ? &s3c24xx_gpf_irq_ops
 					       : &s3c24xx_gpg_irq_ops;
 
-		bank->irq_domain = irq_domain_add_linear(bank->of_node,
+		bank->irq_domain = irq_domain_create_linear(bank->fwnode,
 				bank->nr_pins, ops, ddata);
 		if (!bank->irq_domain) {
 			dev_err(dev, "wkup irq domain add failed\n");
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
index c5f95a1071ae..c5d92db4fdb1 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
@@ -471,7 +471,7 @@ static int s3c64xx_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
 		mask = bank->eint_mask;
 		nr_eints = fls(mask);
 
-		bank->irq_domain = irq_domain_add_linear(bank->of_node,
+		bank->irq_domain = irq_domain_create_linear(bank->fwnode,
 					nr_eints, &s3c64xx_gpio_irqd_ops, bank);
 		if (!bank->irq_domain) {
 			dev_err(dev, "gpio irq domain add failed\n");
@@ -743,7 +743,7 @@ static int s3c64xx_eint_eint0_init(struct samsung_pinctrl_drv_data *d)
 			return -ENOMEM;
 		ddata->bank = bank;
 
-		bank->irq_domain = irq_domain_add_linear(bank->of_node,
+		bank->irq_domain = irq_domain_create_linear(bank->fwnode,
 				nr_eints, &s3c64xx_eint0_irqd_ops, ddata);
 		if (!bank->irq_domain) {
 			dev_err(dev, "wkup irq domain add failed\n");
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index f610beab23a0..26d309d2516d 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
@@ -966,7 +967,7 @@ static int samsung_gpiolib_register(struct platform_device *pdev,
 		gc->base = bank->grange.base;
 		gc->ngpio = bank->nr_pins;
 		gc->parent = &pdev->dev;
-		gc->of_node = bank->of_node;
+		gc->fwnode = bank->fwnode;
 		gc->label = bank->name;
 
 		ret = devm_gpiochip_add_data(&pdev->dev, gc, bank);
@@ -1002,27 +1003,25 @@ samsung_pinctrl_get_soc_data_for_of_alias(struct platform_device *pdev)
 	return &(of_data->ctrl[id]);
 }
 
-static void samsung_banks_of_node_put(struct samsung_pinctrl_drv_data *d)
+static void samsung_banks_node_put(struct samsung_pinctrl_drv_data *d)
 {
 	struct samsung_pin_bank *bank;
 	unsigned int i;
 
 	bank = d->pin_banks;
 	for (i = 0; i < d->nr_banks; ++i, ++bank)
-		of_node_put(bank->of_node);
+		fwnode_handle_put(bank->fwnode);
 }
 
 /*
  * Iterate over all driver pin banks to find one matching the name of node,
  * skipping optional "-gpio" node suffix. When found, assign node to the bank.
  */
-static void samsung_banks_of_node_get(struct device *dev,
-				      struct samsung_pinctrl_drv_data *d,
-				      struct device_node *node)
+static void samsung_banks_node_get(struct device *dev, struct samsung_pinctrl_drv_data *d)
 {
 	const char *suffix = "-gpio-bank";
 	struct samsung_pin_bank *bank;
-	struct device_node *child;
+	struct fwnode_handle *child;
 	/* Pin bank names are up to 4 characters */
 	char node_name[20];
 	unsigned int i;
@@ -1038,17 +1037,17 @@ static void samsung_banks_of_node_get(struct device *dev,
 			continue;
 		}
 
-		for_each_child_of_node(node, child) {
-			if (!of_find_property(child, "gpio-controller", NULL))
-				continue;
-			if (of_node_name_eq(child, node_name))
+		for_each_gpiochip_node(dev, child) {
+			struct device_node *np = to_of_node(child);
+
+			if (of_node_name_eq(np, node_name))
 				break;
-			else if (of_node_name_eq(child, bank->name))
+			if (of_node_name_eq(np, bank->name))
 				break;
 		}
 
 		if (child)
-			bank->of_node = child;
+			bank->fwnode = child;
 		else
 			dev_warn(dev, "Missing node for bank %s - invalid DTB\n",
 				 bank->name);
@@ -1061,7 +1060,6 @@ static const struct samsung_pin_ctrl *
 samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 			     struct platform_device *pdev)
 {
-	struct device_node *node = pdev->dev.of_node;
 	const struct samsung_pin_bank_data *bdata;
 	const struct samsung_pin_ctrl *ctrl;
 	struct samsung_pin_bank *bank;
@@ -1125,7 +1123,7 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 	 */
 	d->virt_base = virt_base[0];
 
-	samsung_banks_of_node_get(&pdev->dev, d, node);
+	samsung_banks_node_get(&pdev->dev, d);
 
 	d->pin_base = pin_base;
 	pin_base += d->nr_pins;
@@ -1186,7 +1184,7 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 err_unregister:
 	samsung_pinctrl_unregister(pdev, drvdata);
 err_put_banks:
-	samsung_banks_of_node_put(drvdata);
+	samsung_banks_node_put(drvdata);
 	return ret;
 }
 
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 5b32d3f30fcd..fc6f5199c548 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -165,7 +165,7 @@ struct samsung_pin_bank {
 
 	u32		pin_base;
 	void		*soc_priv;
-	struct device_node *of_node;
+	struct fwnode_handle *fwnode;
 	struct samsung_pinctrl_drv_data *drvdata;
 	struct irq_domain *irq_domain;
 	struct gpio_chip gpio_chip;
-- 
2.35.1


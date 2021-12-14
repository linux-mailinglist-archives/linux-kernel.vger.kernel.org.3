Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32084474313
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhLNM7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:59:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:29468 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234209AbhLNM7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:59:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325246338"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="325246338"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 04:59:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="505350205"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 14 Dec 2021 04:58:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D0F2815C; Tue, 14 Dec 2021 14:58:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Radim Pavlik <radim.pavlik@tbs-biometrics.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-mediatek@lists.infradead.org,
        linux-oxnas@groups.io, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Sean Wang <sean.wang@kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Gross <agross@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org
Subject: [PATCH v2 1/2] pinctrl: Get rid of duplicate of_node assignment in the drivers
Date:   Tue, 14 Dec 2021 14:58:54 +0200
Message-Id: <20211214125855.33207-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library does copy the of_node from the parent device of
the GPIO chip, there is no need to repeat this in the individual
drivers. Remove these assignment all at once.

For the details one may look into the of_gpio_dev_init() implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/pinctrl/actions/pinctrl-owl.c      | 1 -
 drivers/pinctrl/bcm/pinctrl-bcm2835.c      | 1 -
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c   | 1 -
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c     | 1 -
 drivers/pinctrl/cirrus/pinctrl-lochnagar.c | 3 ---
 drivers/pinctrl/mediatek/pinctrl-moore.c   | 7 +++----
 drivers/pinctrl/mediatek/pinctrl-paris.c   | 5 ++---
 drivers/pinctrl/pinctrl-amd.c              | 3 ---
 drivers/pinctrl/pinctrl-at91-pio4.c        | 1 -
 drivers/pinctrl/pinctrl-at91.c             | 1 -
 drivers/pinctrl/pinctrl-digicolor.c        | 5 ++---
 drivers/pinctrl/pinctrl-mcp23s08.c         | 1 -
 drivers/pinctrl/pinctrl-ocelot.c           | 1 -
 drivers/pinctrl/pinctrl-oxnas.c            | 1 -
 drivers/pinctrl/pinctrl-pic32.c            | 2 +-
 drivers/pinctrl/pinctrl-stmfx.c            | 1 -
 drivers/pinctrl/pinctrl-sx150x.c           | 3 ---
 drivers/pinctrl/pinctrl-xway.c             | 1 -
 drivers/pinctrl/qcom/pinctrl-msm.c         | 1 -
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c   | 1 -
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c    | 1 -
 drivers/pinctrl/renesas/pinctrl-rza2.c     | 1 -
 drivers/pinctrl/spear/pinctrl-plgpio.c     | 1 -
 drivers/pinctrl/vt8500/pinctrl-wmt.c       | 1 -
 24 files changed, 8 insertions(+), 37 deletions(-)

diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
index 781f2200ed58..ed46abc15d72 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.c
+++ b/drivers/pinctrl/actions/pinctrl-owl.c
@@ -874,7 +874,6 @@ static int owl_gpio_init(struct owl_pinctrl *pctrl)
 	chip->label = dev_name(pctrl->dev);
 	chip->parent = pctrl->dev;
 	chip->owner = THIS_MODULE;
-	chip->of_node = pctrl->dev->of_node;
 
 	pctrl->irq_chip.name = chip->of_node->name;
 	pctrl->irq_chip.irq_ack = owl_gpio_irq_ack;
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 2abcc6ce4eba..c677be102938 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -1222,7 +1222,6 @@ static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 
 	pc->gpio_chip = *pdata->gpio_chip;
 	pc->gpio_chip.parent = dev;
-	pc->gpio_chip.of_node = np;
 
 	for (i = 0; i < BCM2835_NUM_BANKS; i++) {
 		unsigned long events;
diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index a7a0dd638a26..52fa2f4cd618 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -836,7 +836,6 @@ static int iproc_gpio_probe(struct platform_device *pdev)
 	chip->num_banks = (ngpios + NGPIOS_PER_BANK - 1) / NGPIOS_PER_BANK;
 	gc->label = dev_name(dev);
 	gc->parent = dev;
-	gc->of_node = dev->of_node;
 	gc->request = iproc_gpio_request;
 	gc->free = iproc_gpio_free;
 	gc->direction_input = iproc_gpio_direction_input;
diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
index e03142895f61..643dbd315033 100644
--- a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
@@ -648,7 +648,6 @@ static int nsp_gpio_probe(struct platform_device *pdev)
 	gc->ngpio = val;
 	gc->label = dev_name(dev);
 	gc->parent = dev;
-	gc->of_node = dev->of_node;
 	gc->request = gpiochip_generic_request;
 	gc->free = gpiochip_generic_free;
 	gc->direction_input = nsp_gpio_direction_input;
diff --git a/drivers/pinctrl/cirrus/pinctrl-lochnagar.c b/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
index 670ac53a3141..3fda4446d70b 100644
--- a/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
+++ b/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
@@ -1161,9 +1161,6 @@ static int lochnagar_pin_probe(struct platform_device *pdev)
 	priv->gpio_chip.can_sleep = true;
 	priv->gpio_chip.parent = dev;
 	priv->gpio_chip.base = -1;
-#ifdef CONFIG_OF_GPIO
-	priv->gpio_chip.of_node = dev->of_node;
-#endif
 
 	switch (lochnagar->type) {
 	case LOCHNAGAR1:
diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index ad3b67163973..5bfaa84839c7 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -519,7 +519,7 @@ static int mtk_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 	return mtk_eint_set_debounce(hw->eint, desc->eint.eint_n, debounce);
 }
 
-static int mtk_build_gpiochip(struct mtk_pinctrl *hw, struct device_node *np)
+static int mtk_build_gpiochip(struct mtk_pinctrl *hw)
 {
 	struct gpio_chip *chip = &hw->chip;
 	int ret;
@@ -536,7 +536,6 @@ static int mtk_build_gpiochip(struct mtk_pinctrl *hw, struct device_node *np)
 	chip->set_config	= mtk_gpio_set_config;
 	chip->base		= -1;
 	chip->ngpio		= hw->soc->npins;
-	chip->of_node		= np;
 	chip->of_gpio_n_cells	= 2;
 
 	ret = gpiochip_add_data(chip, hw);
@@ -550,7 +549,7 @@ static int mtk_build_gpiochip(struct mtk_pinctrl *hw, struct device_node *np)
 	 * Documentation/devicetree/bindings/gpio/gpio.txt on how to
 	 * bind pinctrl and gpio drivers via the "gpio-ranges" property.
 	 */
-	if (!of_find_property(np, "gpio-ranges", NULL)) {
+	if (!of_find_property(hw->dev->of_node, "gpio-ranges", NULL)) {
 		ret = gpiochip_add_pin_range(chip, dev_name(hw->dev), 0, 0,
 					     chip->ngpio);
 		if (ret < 0) {
@@ -691,7 +690,7 @@ int mtk_moore_pinctrl_probe(struct platform_device *pdev,
 			 "Failed to add EINT, but pinctrl still can work\n");
 
 	/* Build gpiochip should be after pinctrl_enable is done */
-	err = mtk_build_gpiochip(hw, pdev->dev.of_node);
+	err = mtk_build_gpiochip(hw);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add gpio_chip\n");
 		return err;
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 4c6f6d967b18..f9f9110f2107 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -895,7 +895,7 @@ static int mtk_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 	return mtk_eint_set_debounce(hw->eint, desc->eint.eint_n, debounce);
 }
 
-static int mtk_build_gpiochip(struct mtk_pinctrl *hw, struct device_node *np)
+static int mtk_build_gpiochip(struct mtk_pinctrl *hw)
 {
 	struct gpio_chip *chip = &hw->chip;
 	int ret;
@@ -913,7 +913,6 @@ static int mtk_build_gpiochip(struct mtk_pinctrl *hw, struct device_node *np)
 	chip->set_config	= mtk_gpio_set_config;
 	chip->base		= -1;
 	chip->ngpio		= hw->soc->npins;
-	chip->of_node		= np;
 	chip->of_gpio_n_cells	= 2;
 
 	ret = gpiochip_add_data(chip, hw);
@@ -1037,7 +1036,7 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev,
 			 "Failed to add EINT, but pinctrl still can work\n");
 
 	/* Build gpiochip should be after pinctrl_enable is done */
-	err = mtk_build_gpiochip(hw, pdev->dev.of_node);
+	err = mtk_build_gpiochip(hw);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add gpio_chip\n");
 		return err;
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index ecab9064a845..1a7d686494ff 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -1009,9 +1009,6 @@ static int amd_gpio_probe(struct platform_device *pdev)
 	gpio_dev->gc.owner			= THIS_MODULE;
 	gpio_dev->gc.parent			= &pdev->dev;
 	gpio_dev->gc.ngpio			= resource_size(res) / 4;
-#if defined(CONFIG_OF_GPIO)
-	gpio_dev->gc.of_node			= pdev->dev.of_node;
-#endif
 
 	gpio_dev->hwbank_num = gpio_dev->gc.ngpio / 64;
 	gpio_dev->groups = kerncz_groups;
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 03c32b2c5d30..fafd1f55cba7 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -1136,7 +1136,6 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	atmel_pioctrl->gpio_chip = &atmel_gpio_chip;
-	atmel_pioctrl->gpio_chip->of_node = dev->of_node;
 	atmel_pioctrl->gpio_chip->ngpio = atmel_pioctrl->npins;
 	atmel_pioctrl->gpio_chip->label = dev_name(dev);
 	atmel_pioctrl->gpio_chip->parent = dev;
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 6022496bb6a9..d91a010e65f5 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1868,7 +1868,6 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	at91_chip->chip = at91_gpio_template;
 
 	chip = &at91_chip->chip;
-	chip->of_node = np;
 	chip->label = dev_name(&pdev->dev);
 	chip->parent = &pdev->dev;
 	chip->owner = THIS_MODULE;
diff --git a/drivers/pinctrl/pinctrl-digicolor.c b/drivers/pinctrl/pinctrl-digicolor.c
index ff702cfbaa28..cc3546fc4610 100644
--- a/drivers/pinctrl/pinctrl-digicolor.c
+++ b/drivers/pinctrl/pinctrl-digicolor.c
@@ -233,7 +233,7 @@ static void dc_gpio_set(struct gpio_chip *chip, unsigned gpio, int value)
 	spin_unlock_irqrestore(&pmap->lock, flags);
 }
 
-static int dc_gpiochip_add(struct dc_pinmap *pmap, struct device_node *np)
+static int dc_gpiochip_add(struct dc_pinmap *pmap)
 {
 	struct gpio_chip *chip = &pmap->chip;
 	int ret;
@@ -248,7 +248,6 @@ static int dc_gpiochip_add(struct dc_pinmap *pmap, struct device_node *np)
 	chip->set		= dc_gpio_set;
 	chip->base		= -1;
 	chip->ngpio		= PINS_COUNT;
-	chip->of_node		= np;
 	chip->of_gpio_n_cells	= 2;
 
 	spin_lock_init(&pmap->lock);
@@ -326,7 +325,7 @@ static int dc_pinctrl_probe(struct platform_device *pdev)
 		return PTR_ERR(pmap->pctl);
 	}
 
-	return dc_gpiochip_add(pmap, pdev->dev.of_node);
+	return dc_gpiochip_add(pmap);
 }
 
 static const struct of_device_id dc_pinctrl_ids[] = {
diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index bccebe43dd6a..695236636d05 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -551,7 +551,6 @@ int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 	mcp->chip.set = mcp23s08_set;
 #ifdef CONFIG_OF_GPIO
 	mcp->chip.of_gpio_n_cells = 2;
-	mcp->chip.of_node = dev->of_node;
 #endif
 
 	mcp->chip.base = base;
diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 42aab9ba049a..fc969208d904 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1748,7 +1748,6 @@ static int ocelot_gpiochip_register(struct platform_device *pdev,
 	gc->ngpio = info->desc->npins;
 	gc->parent = &pdev->dev;
 	gc->base = -1;
-	gc->of_node = info->dev->of_node;
 	gc->label = "ocelot-gpio";
 
 	irq = irq_of_parse_and_map(gc->of_node, 0);
diff --git a/drivers/pinctrl/pinctrl-oxnas.c b/drivers/pinctrl/pinctrl-oxnas.c
index cebd810bd6d1..fb10a8473ebe 100644
--- a/drivers/pinctrl/pinctrl-oxnas.c
+++ b/drivers/pinctrl/pinctrl-oxnas.c
@@ -1232,7 +1232,6 @@ static int oxnas_gpio_probe(struct platform_device *pdev)
 
 	bank->id = id;
 	bank->gpio_chip.parent = &pdev->dev;
-	bank->gpio_chip.of_node = np;
 	bank->gpio_chip.ngpio = ngpios;
 	girq = &bank->gpio_chip.irq;
 	girq->chip = &bank->irq_chip;
diff --git a/drivers/pinctrl/pinctrl-pic32.c b/drivers/pinctrl/pinctrl-pic32.c
index 748dabd8db6e..37acfdfc2cae 100644
--- a/drivers/pinctrl/pinctrl-pic32.c
+++ b/drivers/pinctrl/pinctrl-pic32.c
@@ -2241,7 +2241,7 @@ static int pic32_gpio_probe(struct platform_device *pdev)
 	}
 
 	bank->gpio_chip.parent = &pdev->dev;
-	bank->gpio_chip.of_node = np;
+
 	girq = &bank->gpio_chip.irq;
 	girq->chip = &bank->irq_chip;
 	girq->parent_handler = pic32_gpio_irq_handler;
diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
index 5fa2488fae87..ab4dde40d3ed 100644
--- a/drivers/pinctrl/pinctrl-stmfx.c
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -675,7 +675,6 @@ static int stmfx_pinctrl_probe(struct platform_device *pdev)
 	pctl->gpio_chip.base = -1;
 	pctl->gpio_chip.ngpio = pctl->pctl_desc.npins;
 	pctl->gpio_chip.can_sleep = true;
-	pctl->gpio_chip.of_node = np;
 
 	pctl->irq_chip.name = dev_name(pctl->dev);
 	pctl->irq_chip.irq_mask = stmfx_pinctrl_irq_mask;
diff --git a/drivers/pinctrl/pinctrl-sx150x.c b/drivers/pinctrl/pinctrl-sx150x.c
index 484a3b9e875c..a87ea3b95cf4 100644
--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -1163,9 +1163,6 @@ static int sx150x_probe(struct i2c_client *client,
 	pctl->gpio.set = sx150x_gpio_set;
 	pctl->gpio.set_config = gpiochip_generic_config;
 	pctl->gpio.parent = dev;
-#ifdef CONFIG_OF_GPIO
-	pctl->gpio.of_node = dev->of_node;
-#endif
 	pctl->gpio.can_sleep = true;
 	pctl->gpio.label = devm_kstrdup(dev, client->name, GFP_KERNEL);
 	if (!pctl->gpio.label)
diff --git a/drivers/pinctrl/pinctrl-xway.c b/drivers/pinctrl/pinctrl-xway.c
index 5e3f31b55eb7..3a03beb8a755 100644
--- a/drivers/pinctrl/pinctrl-xway.c
+++ b/drivers/pinctrl/pinctrl-xway.c
@@ -1763,7 +1763,6 @@ static int pinmux_xway_probe(struct platform_device *pdev)
 	/* register the gpio chip */
 	xway_chip.parent = &pdev->dev;
 	xway_chip.owner = THIS_MODULE;
-	xway_chip.of_node = pdev->dev.of_node;
 	ret = devm_gpiochip_add_data(&pdev->dev, &xway_chip, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register gpio chip\n");
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index ae09e2dd8a50..780878dede9e 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1264,7 +1264,6 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	chip->label = dev_name(pctrl->dev);
 	chip->parent = pctrl->dev;
 	chip->owner = THIS_MODULE;
-	chip->of_node = pctrl->dev->of_node;
 	if (msm_gpio_needs_valid_mask(pctrl))
 		chip->init_valid_mask = msm_gpio_init_valid_mask;
 
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index b5949f766a7a..1b41adda8129 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -773,7 +773,6 @@ static int pm8xxx_gpio_probe(struct platform_device *pdev)
 	pctrl->chip = pm8xxx_gpio_template;
 	pctrl->chip.base = -1;
 	pctrl->chip.parent = &pdev->dev;
-	pctrl->chip.of_node = pdev->dev.of_node;
 	pctrl->chip.of_gpio_n_cells = 2;
 	pctrl->chip.label = dev_name(pctrl->dev);
 	pctrl->chip.ngpio = pctrl->npins;
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
index 842940594c4a..49893a5133a8 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
@@ -857,7 +857,6 @@ static int pm8xxx_mpp_probe(struct platform_device *pdev)
 	pctrl->chip = pm8xxx_mpp_template;
 	pctrl->chip.base = -1;
 	pctrl->chip.parent = &pdev->dev;
-	pctrl->chip.of_node = pdev->dev.of_node;
 	pctrl->chip.of_gpio_n_cells = 2;
 	pctrl->chip.label = dev_name(pctrl->dev);
 	pctrl->chip.ngpio = pctrl->npins;
diff --git a/drivers/pinctrl/renesas/pinctrl-rza2.c b/drivers/pinctrl/renesas/pinctrl-rza2.c
index 32829eb9656c..c0a04f1ee994 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza2.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza2.c
@@ -240,7 +240,6 @@ static int rza2_gpio_register(struct rza2_pinctrl_priv *priv)
 	int ret;
 
 	chip.label = devm_kasprintf(priv->dev, GFP_KERNEL, "%pOFn", np);
-	chip.of_node = np;
 	chip.parent = priv->dev;
 	chip.ngpio = priv->npins;
 
diff --git a/drivers/pinctrl/spear/pinctrl-plgpio.c b/drivers/pinctrl/spear/pinctrl-plgpio.c
index b36449724f3f..ada401ef4342 100644
--- a/drivers/pinctrl/spear/pinctrl-plgpio.c
+++ b/drivers/pinctrl/spear/pinctrl-plgpio.c
@@ -581,7 +581,6 @@ static int plgpio_probe(struct platform_device *pdev)
 	plgpio->chip.label = dev_name(&pdev->dev);
 	plgpio->chip.parent = &pdev->dev;
 	plgpio->chip.owner = THIS_MODULE;
-	plgpio->chip.of_node = pdev->dev.of_node;
 
 	if (!IS_ERR(plgpio->clk)) {
 		ret = clk_prepare(plgpio->clk);
diff --git a/drivers/pinctrl/vt8500/pinctrl-wmt.c b/drivers/pinctrl/vt8500/pinctrl-wmt.c
index 65b97e240196..6fac30de1c6a 100644
--- a/drivers/pinctrl/vt8500/pinctrl-wmt.c
+++ b/drivers/pinctrl/vt8500/pinctrl-wmt.c
@@ -565,7 +565,6 @@ int wmt_pinctrl_probe(struct platform_device *pdev,
 
 	data->gpio_chip = wmt_gpio_chip;
 	data->gpio_chip.parent = &pdev->dev;
-	data->gpio_chip.of_node = pdev->dev.of_node;
 	data->gpio_chip.ngpio = data->nbanks * 32;
 
 	platform_set_drvdata(pdev, data);
-- 
2.33.0


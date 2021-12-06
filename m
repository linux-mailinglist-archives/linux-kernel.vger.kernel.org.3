Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C114696BB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbhLFNWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:22:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:41880 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244270AbhLFNWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:22:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="261344034"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="261344034"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 05:19:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="579370408"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 Dec 2021 05:18:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 138A5144; Mon,  6 Dec 2021 15:18:59 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Baruch Siach <baruch@tkos.co.il>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Tony Lindgren <tony@atomide.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-power@fi.rohmeurope.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Cc:     Ray Jui <rjui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Keerthy <j-keerthy@ti.com>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 1/3] gpio: Get rid of duplicate of_node assignment in the drivers
Date:   Mon,  6 Dec 2021 15:18:50 +0200
Message-Id: <20211206131852.74746-1-andriy.shevchenko@linux.intel.com>
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

While at it, remove duplicate parent device assignment where it is the case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: mentioned parent removal (Linus), dropped change of the removed code
 drivers/gpio/gpio-adnp.c            | 1 -
 drivers/gpio/gpio-amdpt.c           | 4 +---
 drivers/gpio/gpio-bd71828.c         | 1 -
 drivers/gpio/gpio-brcmstb.c         | 1 -
 drivers/gpio/gpio-davinci.c         | 1 -
 drivers/gpio/gpio-eic-sprd.c        | 1 -
 drivers/gpio/gpio-em.c              | 1 -
 drivers/gpio/gpio-ge.c              | 1 -
 drivers/gpio/gpio-grgpio.c          | 1 -
 drivers/gpio/gpio-gw-pld.c          | 1 -
 drivers/gpio/gpio-mt7621.c          | 1 -
 drivers/gpio/gpio-mvebu.c           | 1 -
 drivers/gpio/gpio-omap.c            | 3 ---
 drivers/gpio/gpio-palmas.c          | 4 +---
 drivers/gpio/gpio-pmic-eic-sprd.c   | 1 -
 drivers/gpio/gpio-raspberrypi-exp.c | 1 -
 drivers/gpio/gpio-rda.c             | 2 --
 drivers/gpio/gpio-rockchip.c        | 3 ---
 drivers/gpio/gpio-sama5d2-piobu.c   | 1 -
 drivers/gpio/gpio-sprd.c            | 1 -
 drivers/gpio/gpio-stmpe.c           | 1 -
 drivers/gpio/gpio-tc3589x.c         | 1 -
 drivers/gpio/gpio-tegra186.c        | 1 -
 drivers/gpio/gpio-tps65218.c        | 3 ---
 drivers/gpio/gpio-vf610.c           | 1 -
 25 files changed, 2 insertions(+), 36 deletions(-)

diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index 8eedfc6451df..cc349d4e4973 100644
--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -458,7 +458,6 @@ static int adnp_gpio_setup(struct adnp *adnp, unsigned int num_gpios,
 	chip->ngpio = num_gpios;
 	chip->label = adnp->client->name;
 	chip->parent = &adnp->client->dev;
-	chip->of_node = chip->parent->of_node;
 	chip->owner = THIS_MODULE;
 
 	if (is_irq_controller) {
diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
index bbf53e289141..afe59fb79821 100644
--- a/drivers/gpio/gpio-amdpt.c
+++ b/drivers/gpio/gpio-amdpt.c
@@ -104,9 +104,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
 	pt_gpio->gc.request          = pt_gpio_request;
 	pt_gpio->gc.free             = pt_gpio_free;
 	pt_gpio->gc.ngpio            = PT_TOTAL_GPIO;
-#if defined(CONFIG_OF_GPIO)
-	pt_gpio->gc.of_node          = dev->of_node;
-#endif
+
 	ret = gpiochip_add_data(&pt_gpio->gc, pt_gpio);
 	if (ret) {
 		dev_err(dev, "Failed to register GPIO lib\n");
diff --git a/drivers/gpio/gpio-bd71828.c b/drivers/gpio/gpio-bd71828.c
index c8e382b53f2f..b2ccc320c7b5 100644
--- a/drivers/gpio/gpio-bd71828.c
+++ b/drivers/gpio/gpio-bd71828.c
@@ -121,7 +121,6 @@ static int bd71828_probe(struct platform_device *pdev)
 	 * "gpio-reserved-ranges" and exclude them from control
 	 */
 	bdgpio->gpio.ngpio = 4;
-	bdgpio->gpio.of_node = dev->parent->of_node;
 	bdgpio->regmap = dev_get_regmap(dev->parent, NULL);
 	if (!bdgpio->regmap)
 		return -ENODEV;
diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 895a79936248..176c264bb959 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -703,7 +703,6 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 			goto fail;
 		}
 
-		gc->of_node = np;
 		gc->owner = THIS_MODULE;
 		gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", dev->of_node);
 		if (!gc->label) {
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index cb5afaa7ed48..f960587f86a3 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -254,7 +254,6 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 #ifdef CONFIG_OF_GPIO
 	chips->chip.of_gpio_n_cells = 2;
 	chips->chip.parent = dev;
-	chips->chip.of_node = dev->of_node;
 	chips->chip.request = gpiochip_generic_request;
 	chips->chip.free = gpiochip_generic_free;
 #endif
diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 865ab2b34fdd..8d722e026e9c 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -609,7 +609,6 @@ static int sprd_eic_probe(struct platform_device *pdev)
 	sprd_eic->chip.ngpio = pdata->num_eics;
 	sprd_eic->chip.base = -1;
 	sprd_eic->chip.parent = &pdev->dev;
-	sprd_eic->chip.of_node = pdev->dev.of_node;
 	sprd_eic->chip.direction_input = sprd_eic_direction_input;
 	switch (sprd_eic->type) {
 	case SPRD_EIC_DEBOUNCE:
diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index 90b336e6ee27..858e6ebbb584 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -306,7 +306,6 @@ static int em_gio_probe(struct platform_device *pdev)
 	}
 
 	gpio_chip = &p->gpio_chip;
-	gpio_chip->of_node = dev->of_node;
 	gpio_chip->direction_input = em_gio_direction_input;
 	gpio_chip->get = em_gio_get;
 	gpio_chip->direction_output = em_gio_direction_output;
diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
index 636952769bc8..f6a3de99f7db 100644
--- a/drivers/gpio/gpio-ge.c
+++ b/drivers/gpio/gpio-ge.c
@@ -82,7 +82,6 @@ static int __init gef_gpio_probe(struct platform_device *pdev)
 	gc->base = -1;
 	gc->ngpio = (u16)(uintptr_t)of_device_get_match_data(&pdev->dev);
 	gc->of_gpio_n_cells = 2;
-	gc->of_node = pdev->dev.of_node;
 
 	/* This function adds a memory mapped GPIO chip */
 	ret = devm_gpiochip_add_data(&pdev->dev, gc, NULL);
diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index f954359c9544..23d447e17a67 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -358,7 +358,6 @@ static int grgpio_probe(struct platform_device *ofdev)
 	priv->imask = gc->read_reg(regs + GRGPIO_IMASK);
 	priv->dev = &ofdev->dev;
 
-	gc->of_node = np;
 	gc->owner = THIS_MODULE;
 	gc->to_irq = grgpio_to_irq;
 	gc->label = devm_kasprintf(&ofdev->dev, GFP_KERNEL, "%pOF", np);
diff --git a/drivers/gpio/gpio-gw-pld.c b/drivers/gpio/gpio-gw-pld.c
index 242112ff60ee..77a3fbd46111 100644
--- a/drivers/gpio/gpio-gw-pld.c
+++ b/drivers/gpio/gpio-gw-pld.c
@@ -82,7 +82,6 @@ static int gw_pld_probe(struct i2c_client *client,
 	gw->chip.base = -1;
 	gw->chip.can_sleep = true;
 	gw->chip.parent = dev;
-	gw->chip.of_node = np;
 	gw->chip.owner = THIS_MODULE;
 	gw->chip.label = dev_name(dev);
 	gw->chip.ngpio = 8;
diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index c3658a597a80..52b49e7a0a80 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -217,7 +217,6 @@ mediatek_gpio_bank_probe(struct device *dev,
 	memset(rg, 0, sizeof(*rg));
 
 	spin_lock_init(&rg->lock);
-	rg->chip.of_node = node;
 	rg->bank = bank;
 
 	dat = mtk->base + GPIO_REG_DATA + (rg->bank * GPIO_BANK_STRIDE);
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 8f429d9f3661..4c1f9e1091b7 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1183,7 +1183,6 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	mvchip->chip.base = id * MVEBU_MAX_GPIO_PER_BANK;
 	mvchip->chip.ngpio = ngpios;
 	mvchip->chip.can_sleep = false;
-	mvchip->chip.of_node = np;
 	mvchip->chip.dbg_show = mvebu_gpio_dbg_show;
 
 	if (soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K)
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 415e8df89d6f..e099c39e0355 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1419,9 +1419,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	bank->is_mpuio = pdata->is_mpuio;
 	bank->non_wakeup_gpios = pdata->non_wakeup_gpios;
 	bank->regs = pdata->regs;
-#ifdef CONFIG_OF_GPIO
-	bank->chip.of_node = of_node_get(node);
-#endif
 
 	if (node) {
 		if (!of_property_read_bool(node, "ti,gpio-always-on"))
diff --git a/drivers/gpio/gpio-palmas.c b/drivers/gpio/gpio-palmas.c
index e8e9029ba5bd..bac10c2faf56 100644
--- a/drivers/gpio/gpio-palmas.c
+++ b/drivers/gpio/gpio-palmas.c
@@ -170,9 +170,7 @@ static int palmas_gpio_probe(struct platform_device *pdev)
 	palmas_gpio->gpio_chip.set	= palmas_gpio_set;
 	palmas_gpio->gpio_chip.get	= palmas_gpio_get;
 	palmas_gpio->gpio_chip.parent = &pdev->dev;
-#ifdef CONFIG_OF_GPIO
-	palmas_gpio->gpio_chip.of_node = pdev->dev.of_node;
-#endif
+
 	palmas_pdata = dev_get_platdata(palmas->dev);
 	if (palmas_pdata && palmas_pdata->gpio_base)
 		palmas_gpio->gpio_chip.base = palmas_pdata->gpio_base;
diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index 938285190566..e518490c4b68 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -331,7 +331,6 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 	pmic_eic->chip.ngpio = SPRD_PMIC_EIC_NR;
 	pmic_eic->chip.base = -1;
 	pmic_eic->chip.parent = &pdev->dev;
-	pmic_eic->chip.of_node = pdev->dev.of_node;
 	pmic_eic->chip.direction_input = sprd_pmic_eic_direction_input;
 	pmic_eic->chip.request = sprd_pmic_eic_request;
 	pmic_eic->chip.free = sprd_pmic_eic_free;
diff --git a/drivers/gpio/gpio-raspberrypi-exp.c b/drivers/gpio/gpio-raspberrypi-exp.c
index 64a552ecc2ad..3c414e0005fc 100644
--- a/drivers/gpio/gpio-raspberrypi-exp.c
+++ b/drivers/gpio/gpio-raspberrypi-exp.c
@@ -221,7 +221,6 @@ static int rpi_exp_gpio_probe(struct platform_device *pdev)
 	rpi_gpio->gc.parent = dev;
 	rpi_gpio->gc.label = MODULE_NAME;
 	rpi_gpio->gc.owner = THIS_MODULE;
-	rpi_gpio->gc.of_node = np;
 	rpi_gpio->gc.base = -1;
 	rpi_gpio->gc.ngpio = NUM_GPIO;
 
diff --git a/drivers/gpio/gpio-rda.c b/drivers/gpio/gpio-rda.c
index 463846431183..0d03f525dcd3 100644
--- a/drivers/gpio/gpio-rda.c
+++ b/drivers/gpio/gpio-rda.c
@@ -240,8 +240,6 @@ static int rda_gpio_probe(struct platform_device *pdev)
 	rda_gpio->chip.label = dev_name(dev);
 	rda_gpio->chip.ngpio = ngpios;
 	rda_gpio->chip.base = -1;
-	rda_gpio->chip.parent = dev;
-	rda_gpio->chip.of_node = np;
 
 	if (rda_gpio->irq >= 0) {
 		rda_gpio->irq_chip.name = "rda-gpio",
diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index c1b8e5dbbcc4..a4c4e4584f5b 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -584,9 +584,6 @@ static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
 	gc->ngpio = bank->nr_pins;
 	gc->label = bank->name;
 	gc->parent = bank->dev;
-#ifdef CONFIG_OF_GPIO
-	gc->of_node = of_node_get(bank->of_node);
-#endif
 
 	ret = gpiochip_add_data(gc, bank);
 	if (ret) {
diff --git a/drivers/gpio/gpio-sama5d2-piobu.c b/drivers/gpio/gpio-sama5d2-piobu.c
index b7c950658170..3e95da717fc9 100644
--- a/drivers/gpio/gpio-sama5d2-piobu.c
+++ b/drivers/gpio/gpio-sama5d2-piobu.c
@@ -192,7 +192,6 @@ static int sama5d2_piobu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, piobu);
 	piobu->chip.label = pdev->name;
 	piobu->chip.parent = &pdev->dev;
-	piobu->chip.of_node = pdev->dev.of_node;
 	piobu->chip.owner = THIS_MODULE,
 	piobu->chip.get_direction = sama5d2_piobu_get_direction,
 	piobu->chip.direction_input = sama5d2_piobu_direction_input,
diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
index 9dd9dabb579e..9bff63990eee 100644
--- a/drivers/gpio/gpio-sprd.c
+++ b/drivers/gpio/gpio-sprd.c
@@ -237,7 +237,6 @@ static int sprd_gpio_probe(struct platform_device *pdev)
 	sprd_gpio->chip.ngpio = SPRD_GPIO_NR;
 	sprd_gpio->chip.base = -1;
 	sprd_gpio->chip.parent = &pdev->dev;
-	sprd_gpio->chip.of_node = pdev->dev.of_node;
 	sprd_gpio->chip.request = sprd_gpio_request;
 	sprd_gpio->chip.free = sprd_gpio_free;
 	sprd_gpio->chip.get = sprd_gpio_get;
diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index dd4d58b4ae49..0fa4f0a93378 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -477,7 +477,6 @@ static int stmpe_gpio_probe(struct platform_device *pdev)
 	stmpe_gpio->chip = template_chip;
 	stmpe_gpio->chip.ngpio = stmpe->num_gpios;
 	stmpe_gpio->chip.parent = &pdev->dev;
-	stmpe_gpio->chip.of_node = np;
 	stmpe_gpio->chip.base = -1;
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
diff --git a/drivers/gpio/gpio-tc3589x.c b/drivers/gpio/gpio-tc3589x.c
index 8d158492488f..443fe975bf13 100644
--- a/drivers/gpio/gpio-tc3589x.c
+++ b/drivers/gpio/gpio-tc3589x.c
@@ -319,7 +319,6 @@ static int tc3589x_gpio_probe(struct platform_device *pdev)
 	tc3589x_gpio->chip.ngpio = tc3589x->num_gpio;
 	tc3589x_gpio->chip.parent = &pdev->dev;
 	tc3589x_gpio->chip.base = -1;
-	tc3589x_gpio->chip.of_node = np;
 
 	girq = &tc3589x_gpio->chip.irq;
 	girq->chip = &tc3589x_gpio_irq_chip;
diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index c026e7141e4e..7d90df8c097e 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -748,7 +748,6 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	gpio->gpio.names = (const char * const *)names;
 
 #if defined(CONFIG_OF_GPIO)
-	gpio->gpio.of_node = pdev->dev.of_node;
 	gpio->gpio.of_gpio_n_cells = 2;
 	gpio->gpio.of_xlate = tegra186_gpio_of_xlate;
 #endif /* CONFIG_OF_GPIO */
diff --git a/drivers/gpio/gpio-tps65218.c b/drivers/gpio/gpio-tps65218.c
index 912382be48e1..e1d425a18854 100644
--- a/drivers/gpio/gpio-tps65218.c
+++ b/drivers/gpio/gpio-tps65218.c
@@ -196,9 +196,6 @@ static int tps65218_gpio_probe(struct platform_device *pdev)
 	tps65218_gpio->tps65218 = tps65218;
 	tps65218_gpio->gpio_chip = template_chip;
 	tps65218_gpio->gpio_chip.parent = &pdev->dev;
-#ifdef CONFIG_OF_GPIO
-	tps65218_gpio->gpio_chip.of_node = pdev->dev.of_node;
-#endif
 
 	return devm_gpiochip_add_data(&pdev->dev, &tps65218_gpio->gpio_chip,
 				      tps65218_gpio);
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index e0f2b67558e7..20780c35da1b 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -298,7 +298,6 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	}
 
 	gc = &port->gc;
-	gc->of_node = np;
 	gc->parent = dev;
 	gc->label = "vf610-gpio";
 	gc->ngpio = VF610_GPIO_PER_PORT;
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047E7466B8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377055AbhLBVVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:21:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:48712 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377022AbhLBVVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:21:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="237067786"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="237067786"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 13:17:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="541381178"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 02 Dec 2021 13:17:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B5DAE165; Thu,  2 Dec 2021 23:17:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
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
Subject: [PATCH v1 3/3] gpio: Propagate firmware node from a parent device
Date:   Thu,  2 Dec 2021 23:08:39 +0200
Message-Id: <20211202210839.79140-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211202210839.79140-1-andriy.shevchenko@linux.intel.com>
References: <20211202210839.79140-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating MFD platform devices the firmware node is left unset.
This, in particular, prevents GPIO library to use it for different
purposes. Propagate firmware node from the parent device and let
GPIO library do the right thing.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-arizona.c  | 5 ++---
 drivers/gpio/gpio-tps6586x.c | 5 ++---
 drivers/gpio/gpio-tps65910.c | 6 +++---
 drivers/gpio/gpio-twl6040.c  | 5 ++---
 drivers/gpio/gpio-wm831x.c   | 5 ++---
 5 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-arizona.c b/drivers/gpio/gpio-arizona.c
index 2bc173c352ce..02f9ae19cd44 100644
--- a/drivers/gpio/gpio-arizona.c
+++ b/drivers/gpio/gpio-arizona.c
@@ -151,6 +151,8 @@ static int arizona_gpio_probe(struct platform_device *pdev)
 	struct arizona_gpio *arizona_gpio;
 	int ret;
 
+	device_set_node(&pdev->dev, dev_fwnode(pdev->dev.parent));
+
 	arizona_gpio = devm_kzalloc(&pdev->dev, sizeof(*arizona_gpio),
 				    GFP_KERNEL);
 	if (!arizona_gpio)
@@ -159,9 +161,6 @@ static int arizona_gpio_probe(struct platform_device *pdev)
 	arizona_gpio->arizona = arizona;
 	arizona_gpio->gpio_chip = template_chip;
 	arizona_gpio->gpio_chip.parent = &pdev->dev;
-#ifdef CONFIG_OF_GPIO
-	arizona_gpio->gpio_chip.of_node = arizona->dev->of_node;
-#endif
 
 	switch (arizona->type) {
 	case WM5102:
diff --git a/drivers/gpio/gpio-tps6586x.c b/drivers/gpio/gpio-tps6586x.c
index da0304b764a5..c5713524b581 100644
--- a/drivers/gpio/gpio-tps6586x.c
+++ b/drivers/gpio/gpio-tps6586x.c
@@ -77,6 +77,8 @@ static int tps6586x_gpio_probe(struct platform_device *pdev)
 	struct tps6586x_platform_data *pdata;
 	struct tps6586x_gpio *tps6586x_gpio;
 
+	device_set_node(&pdev->dev, dev_fwnode(pdev->dev.parent));
+
 	pdata = dev_get_platdata(pdev->dev.parent);
 	tps6586x_gpio = devm_kzalloc(&pdev->dev,
 				sizeof(*tps6586x_gpio), GFP_KERNEL);
@@ -97,9 +99,6 @@ static int tps6586x_gpio_probe(struct platform_device *pdev)
 	tps6586x_gpio->gpio_chip.get	= tps6586x_gpio_get;
 	tps6586x_gpio->gpio_chip.to_irq	= tps6586x_gpio_to_irq;
 
-#ifdef CONFIG_OF_GPIO
-	tps6586x_gpio->gpio_chip.of_node = pdev->dev.parent->of_node;
-#endif
 	if (pdata && pdata->gpio_base)
 		tps6586x_gpio->gpio_chip.base = pdata->gpio_base;
 	else
diff --git a/drivers/gpio/gpio-tps65910.c b/drivers/gpio/gpio-tps65910.c
index 7fa8c841081f..321e6945f0be 100644
--- a/drivers/gpio/gpio-tps65910.c
+++ b/drivers/gpio/gpio-tps65910.c
@@ -111,6 +111,8 @@ static int tps65910_gpio_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
+	device_set_node(&pdev->dev, dev_fwnode(pdev->dev.parent));
+
 	tps65910_gpio = devm_kzalloc(&pdev->dev,
 				sizeof(*tps65910_gpio), GFP_KERNEL);
 	if (!tps65910_gpio)
@@ -137,9 +139,7 @@ static int tps65910_gpio_probe(struct platform_device *pdev)
 	tps65910_gpio->gpio_chip.set	= tps65910_gpio_set;
 	tps65910_gpio->gpio_chip.get	= tps65910_gpio_get;
 	tps65910_gpio->gpio_chip.parent = &pdev->dev;
-#ifdef CONFIG_OF_GPIO
-	tps65910_gpio->gpio_chip.of_node = tps65910->dev->of_node;
-#endif
+
 	if (pdata && pdata->gpio_base)
 		tps65910_gpio->gpio_chip.base = pdata->gpio_base;
 	else
diff --git a/drivers/gpio/gpio-twl6040.c b/drivers/gpio/gpio-twl6040.c
index 648fb418d775..6c3fbf382dba 100644
--- a/drivers/gpio/gpio-twl6040.c
+++ b/drivers/gpio/gpio-twl6040.c
@@ -80,6 +80,8 @@ static int gpo_twl6040_probe(struct platform_device *pdev)
 	struct twl6040 *twl6040 = dev_get_drvdata(twl6040_core_dev);
 	int ret;
 
+	device_set_node(&pdev->dev, dev_fwnode(pdev->dev.parent));
+
 	twl6040gpo_chip.base = -1;
 
 	if (twl6040_get_revid(twl6040) < TWL6041_REV_ES2_0)
@@ -88,9 +90,6 @@ static int gpo_twl6040_probe(struct platform_device *pdev)
 		twl6040gpo_chip.ngpio = 1; /* twl6041 have 1 GPO */
 
 	twl6040gpo_chip.parent = &pdev->dev;
-#ifdef CONFIG_OF_GPIO
-	twl6040gpo_chip.of_node = twl6040_core_dev->of_node;
-#endif
 
 	ret = devm_gpiochip_add_data(&pdev->dev, &twl6040gpo_chip, NULL);
 	if (ret < 0) {
diff --git a/drivers/gpio/gpio-wm831x.c b/drivers/gpio/gpio-wm831x.c
index 9cf1e5ebb352..7eaf8a28638c 100644
--- a/drivers/gpio/gpio-wm831x.c
+++ b/drivers/gpio/gpio-wm831x.c
@@ -262,6 +262,8 @@ static int wm831x_gpio_probe(struct platform_device *pdev)
 	struct wm831x_pdata *pdata = &wm831x->pdata;
 	struct wm831x_gpio *wm831x_gpio;
 
+	device_set_node(&pdev->dev, dev_fwnode(pdev->dev.parent));
+
 	wm831x_gpio = devm_kzalloc(&pdev->dev, sizeof(*wm831x_gpio),
 				   GFP_KERNEL);
 	if (wm831x_gpio == NULL)
@@ -275,9 +277,6 @@ static int wm831x_gpio_probe(struct platform_device *pdev)
 		wm831x_gpio->gpio_chip.base = pdata->gpio_base;
 	else
 		wm831x_gpio->gpio_chip.base = -1;
-#ifdef CONFIG_OF_GPIO
-	wm831x_gpio->gpio_chip.of_node = wm831x->dev->of_node;
-#endif
 
 	return devm_gpiochip_add_data(&pdev->dev, &wm831x_gpio->gpio_chip, wm831x_gpio);
 }
-- 
2.33.0


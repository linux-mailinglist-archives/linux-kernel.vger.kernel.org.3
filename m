Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF344731F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbhLMQjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:39:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:18179 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240898AbhLMQjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:39:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="238995719"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="238995719"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 08:39:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="609150188"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 13 Dec 2021 08:39:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E553114F; Mon, 13 Dec 2021 18:39:47 +0200 (EET)
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
        linux-rpi-kernel@lists.infradead.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org, linux-oxnas@groups.io,
        linux-stm32@st-md-mailman.stormreply.com,
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
Subject: [PATCH v1 2/2] pinctrl: Propagate firmware node from a parent device
Date:   Mon, 13 Dec 2021 18:39:29 +0200
Message-Id: <20211213163929.7509-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211213163929.7509-1-andriy.shevchenko@linux.intel.com>
References: <20211213163929.7509-1-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/cirrus/pinctrl-madera-core.c | 3 ++-
 drivers/pinctrl/pinctrl-as3722.c             | 4 ++--
 drivers/pinctrl/pinctrl-da9062.c             | 5 ++---
 drivers/pinctrl/pinctrl-max77620.c           | 3 ++-
 drivers/pinctrl/pinctrl-rk805.c              | 4 ++--
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/cirrus/pinctrl-madera-core.c b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
index dce2626384a9..b48646bd3f55 100644
--- a/drivers/pinctrl/cirrus/pinctrl-madera-core.c
+++ b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
@@ -1004,13 +1004,14 @@ static int madera_pin_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
+	device_set_node(&pdev->dev, dev_fwnode(pdev->dev.parent));
+
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->dev = &pdev->dev;
 	priv->madera = madera;
-	pdev->dev.of_node = madera->dev->of_node;
 
 	switch (madera->type) {
 	case CS47L15:
diff --git a/drivers/pinctrl/pinctrl-as3722.c b/drivers/pinctrl/pinctrl-as3722.c
index 13c193156363..d5d0f62fa55b 100644
--- a/drivers/pinctrl/pinctrl-as3722.c
+++ b/drivers/pinctrl/pinctrl-as3722.c
@@ -551,12 +551,13 @@ static int as3722_pinctrl_probe(struct platform_device *pdev)
 	struct as3722_pctrl_info *as_pci;
 	int ret;
 
+	device_set_node(&pdev->dev, dev_fwnode(pdev->dev.parent));
+
 	as_pci = devm_kzalloc(&pdev->dev, sizeof(*as_pci), GFP_KERNEL);
 	if (!as_pci)
 		return -ENOMEM;
 
 	as_pci->dev = &pdev->dev;
-	as_pci->dev->of_node = pdev->dev.parent->of_node;
 	as_pci->as3722 = dev_get_drvdata(pdev->dev.parent);
 	platform_set_drvdata(pdev, as_pci);
 
@@ -578,7 +579,6 @@ static int as3722_pinctrl_probe(struct platform_device *pdev)
 
 	as_pci->gpio_chip = as3722_gpio_chip;
 	as_pci->gpio_chip.parent = &pdev->dev;
-	as_pci->gpio_chip.of_node = pdev->dev.parent->of_node;
 	ret = gpiochip_add_data(&as_pci->gpio_chip, as_pci);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Couldn't register gpiochip, %d\n", ret);
diff --git a/drivers/pinctrl/pinctrl-da9062.c b/drivers/pinctrl/pinctrl-da9062.c
index 1c08579f0198..678e33d81856 100644
--- a/drivers/pinctrl/pinctrl-da9062.c
+++ b/drivers/pinctrl/pinctrl-da9062.c
@@ -256,6 +256,8 @@ static int da9062_pctl_probe(struct platform_device *pdev)
 	struct da9062_pctl *pctl;
 	int i;
 
+	device_set_node(&pdev->dev, dev_fwnode(pdev->dev.parent));
+
 	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
 	if (!pctl)
 		return -ENOMEM;
@@ -277,9 +279,6 @@ static int da9062_pctl_probe(struct platform_device *pdev)
 	pctl->gc = reference_gc;
 	pctl->gc.label = dev_name(&pdev->dev);
 	pctl->gc.parent = &pdev->dev;
-#ifdef CONFIG_OF_GPIO
-	pctl->gc.of_node = parent->of_node;
-#endif
 
 	platform_set_drvdata(pdev, pctl);
 
diff --git a/drivers/pinctrl/pinctrl-max77620.c b/drivers/pinctrl/pinctrl-max77620.c
index c643ed43ebbf..4b60ff20e9f7 100644
--- a/drivers/pinctrl/pinctrl-max77620.c
+++ b/drivers/pinctrl/pinctrl-max77620.c
@@ -551,12 +551,13 @@ static int max77620_pinctrl_probe(struct platform_device *pdev)
 	struct max77620_pctrl_info *mpci;
 	int i;
 
+	device_set_node(&pdev->dev, dev_fwnode(pdev->dev.parent));
+
 	mpci = devm_kzalloc(&pdev->dev, sizeof(*mpci), GFP_KERNEL);
 	if (!mpci)
 		return -ENOMEM;
 
 	mpci->dev = &pdev->dev;
-	mpci->dev->of_node = pdev->dev.parent->of_node;
 	mpci->rmap = max77620->rmap;
 
 	mpci->pins = max77620_pins_desc;
diff --git a/drivers/pinctrl/pinctrl-rk805.c b/drivers/pinctrl/pinctrl-rk805.c
index c6f4229eb106..528832b54b29 100644
--- a/drivers/pinctrl/pinctrl-rk805.c
+++ b/drivers/pinctrl/pinctrl-rk805.c
@@ -420,18 +420,18 @@ static int rk805_pinctrl_probe(struct platform_device *pdev)
 	struct rk805_pctrl_info *pci;
 	int ret;
 
+	device_set_node(&pdev->dev, dev_fwnode(pdev->dev.parent));
+
 	pci = devm_kzalloc(&pdev->dev, sizeof(*pci), GFP_KERNEL);
 	if (!pci)
 		return -ENOMEM;
 
 	pci->dev = &pdev->dev;
-	pci->dev->of_node = pdev->dev.parent->of_node;
 	pci->rk808 = dev_get_drvdata(pdev->dev.parent);
 
 	pci->pinctrl_desc = rk805_pinctrl_desc;
 	pci->gpio_chip = rk805_gpio_chip;
 	pci->gpio_chip.parent = &pdev->dev;
-	pci->gpio_chip.of_node = pdev->dev.parent->of_node;
 
 	platform_set_drvdata(pdev, pci);
 
-- 
2.33.0


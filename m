Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D036C4EC74B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347525AbiC3Owo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347290AbiC3OwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:52:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF054705D;
        Wed, 30 Mar 2022 07:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648651828; x=1680187828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=COUulyeuXYB02WRu4IA8muZoBPEP1IIwdGcDW9byqQg=;
  b=EALGJEoo3QOQuumS981C42MBnwxrL20OP4sfrFDPE3SXALjF2HvR/AFc
   Xs8Ri7AR2Is0Vc4+6Zb7ixwpFVu7PaX9RKtUtyOlYWyPvrfB3MGnCrNjT
   M5Hh+EscnDAQURKy2Xsw4n7fm+/JJt+kkm1sJviDYZm36AuFU5pBeXNql
   Pa3s+NKxeSnoj6nnIbtJDHxZvnNy17SF18qWMBWstCu+bQmLjmf6Exzkx
   mzn0//3SU2eSNfBLVMzGV+EyhSKsuvJFFgM82JzG8VD5h6yf5A3UoNmXj
   hmIIGeZXZoRkJu14QMn4c8f/jY9kcEyQrjkbAoCShP+uQmxTPnws/kU2f
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="258391439"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="258391439"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:50:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="788030808"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2022 07:50:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 89975602; Wed, 30 Mar 2022 17:50:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Qianggui Song <qianggui.song@amlogic.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
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
Subject: [PATCH v3 08/13] pinctrl: npcm7xx: Switch to use for_each_gpiochip_node() helper
Date:   Wed, 30 Mar 2022 17:50:25 +0300
Message-Id: <20220330145030.1562-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330145030.1562-1-andriy.shevchenko@linux.intel.com>
References: <20220330145030.1562-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the code to use for_each_gpiochip_node() helper.

While at it, in order to avoid additional churn in the future,
do the following:
- use a temporary variable for struct device pointer to shorten a few lines
- get rid of a temporary variable for vIRQ number, assign it directly
- switch to fwnode APIs where it makes sense

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 142 ++++++++++------------
 1 file changed, 62 insertions(+), 80 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 9557fac5d11c..90a184a28ae7 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -17,6 +17,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 /* GCR registers */
@@ -1862,88 +1863,69 @@ static int npcm7xx_gpio_of(struct npcm7xx_pinctrl *pctrl)
 {
 	int ret = -ENXIO;
 	struct resource res;
-	int id = 0, irq;
-	struct device_node *np;
-	struct of_phandle_args pinspec;
-
-	for_each_available_child_of_node(pctrl->dev->of_node, np)
-		if (of_find_property(np, "gpio-controller", NULL)) {
-			ret = of_address_to_resource(np, 0, &res);
-			if (ret < 0) {
-				dev_err(pctrl->dev,
-					"Resource fail for GPIO bank %u\n", id);
-				return ret;
-			}
-
-			pctrl->gpio_bank[id].base =
-				ioremap(res.start, resource_size(&res));
-
-			irq = irq_of_parse_and_map(np, 0);
-			if (irq < 0) {
-				dev_err(pctrl->dev,
-					"No IRQ for GPIO bank %u\n", id);
-				ret = irq;
-				return ret;
-			}
-
-			ret = bgpio_init(&pctrl->gpio_bank[id].gc,
-					 pctrl->dev, 4,
-					 pctrl->gpio_bank[id].base +
-					 NPCM7XX_GP_N_DIN,
-					 pctrl->gpio_bank[id].base +
-					 NPCM7XX_GP_N_DOUT,
-					 NULL,
-					 NULL,
-					 pctrl->gpio_bank[id].base +
-					 NPCM7XX_GP_N_IEM,
-					 BGPIOF_READ_OUTPUT_REG_SET);
-			if (ret) {
-				dev_err(pctrl->dev, "bgpio_init() failed\n");
-				return ret;
-			}
-
-			ret = of_parse_phandle_with_fixed_args(np,
-							       "gpio-ranges", 3,
-							       0, &pinspec);
-			if (ret < 0) {
-				dev_err(pctrl->dev,
-					"gpio-ranges fail for GPIO bank %u\n",
-					id);
-				return ret;
-			}
-
-			pctrl->gpio_bank[id].irq = irq;
-			pctrl->gpio_bank[id].irq_chip = npcmgpio_irqchip;
-			pctrl->gpio_bank[id].gc.parent = pctrl->dev;
-			pctrl->gpio_bank[id].irqbase =
-				id * NPCM7XX_GPIO_PER_BANK;
-			pctrl->gpio_bank[id].pinctrl_id = pinspec.args[0];
-			pctrl->gpio_bank[id].gc.base = pinspec.args[1];
-			pctrl->gpio_bank[id].gc.ngpio = pinspec.args[2];
-			pctrl->gpio_bank[id].gc.owner = THIS_MODULE;
-			pctrl->gpio_bank[id].gc.label =
-				devm_kasprintf(pctrl->dev, GFP_KERNEL, "%pOF",
-					       np);
-			if (pctrl->gpio_bank[id].gc.label == NULL)
-				return -ENOMEM;
-
-			pctrl->gpio_bank[id].gc.dbg_show = npcmgpio_dbg_show;
-			pctrl->gpio_bank[id].direction_input =
-				pctrl->gpio_bank[id].gc.direction_input;
-			pctrl->gpio_bank[id].gc.direction_input =
-				npcmgpio_direction_input;
-			pctrl->gpio_bank[id].direction_output =
-				pctrl->gpio_bank[id].gc.direction_output;
-			pctrl->gpio_bank[id].gc.direction_output =
-				npcmgpio_direction_output;
-			pctrl->gpio_bank[id].request =
-				pctrl->gpio_bank[id].gc.request;
-			pctrl->gpio_bank[id].gc.request = npcmgpio_gpio_request;
-			pctrl->gpio_bank[id].gc.free = npcmgpio_gpio_free;
-			pctrl->gpio_bank[id].gc.of_node = np;
-			id++;
+	struct device *dev = pctrl->dev;
+	struct fwnode_reference_args args;
+	struct fwnode_handle *child;
+	int id = 0;
+
+	for_each_gpiochip_node(dev, child) {
+		struct device_node *np = to_of_node(child);
+
+		ret = of_address_to_resource(np, 0, &res);
+		if (ret < 0) {
+			dev_err(dev, "Resource fail for GPIO bank %u\n", id);
+			return ret;
+		}
+
+		pctrl->gpio_bank[id].base = ioremap(res.start, resource_size(&res));
+
+		ret = bgpio_init(&pctrl->gpio_bank[id].gc, dev, 4,
+				 pctrl->gpio_bank[id].base + NPCM7XX_GP_N_DIN,
+				 pctrl->gpio_bank[id].base + NPCM7XX_GP_N_DOUT,
+				 NULL,
+				 NULL,
+				 pctrl->gpio_bank[id].base + NPCM7XX_GP_N_IEM,
+				 BGPIOF_READ_OUTPUT_REG_SET);
+		if (ret) {
+			dev_err(dev, "bgpio_init() failed\n");
+			return ret;
 		}
 
+		ret = fwnode_property_get_reference_args(child, "gpio-ranges", NULL, 3, 0, &args);
+		if (ret < 0) {
+			dev_err(dev, "gpio-ranges fail for GPIO bank %u\n", id);
+			return ret;
+		}
+
+		ret = irq_of_parse_and_map(np, 0);
+		if (ret < 0) {
+			dev_err(dev, "No IRQ for GPIO bank %u\n", id);
+			return ret;
+		}
+		pctrl->gpio_bank[id].irq = ret;
+		pctrl->gpio_bank[id].irq_chip = npcmgpio_irqchip;
+		pctrl->gpio_bank[id].irqbase = id * NPCM7XX_GPIO_PER_BANK;
+		pctrl->gpio_bank[id].pinctrl_id = args.args[0];
+		pctrl->gpio_bank[id].gc.base = args.args[1];
+		pctrl->gpio_bank[id].gc.ngpio = args.args[2];
+		pctrl->gpio_bank[id].gc.owner = THIS_MODULE;
+		pctrl->gpio_bank[id].gc.parent = dev;
+		pctrl->gpio_bank[id].gc.label = devm_kasprintf(dev, GFP_KERNEL, "%pfw", child);
+		if (pctrl->gpio_bank[id].gc.label == NULL)
+			return -ENOMEM;
+
+		pctrl->gpio_bank[id].gc.dbg_show = npcmgpio_dbg_show;
+		pctrl->gpio_bank[id].direction_input = pctrl->gpio_bank[id].gc.direction_input;
+		pctrl->gpio_bank[id].gc.direction_input = npcmgpio_direction_input;
+		pctrl->gpio_bank[id].direction_output = pctrl->gpio_bank[id].gc.direction_output;
+		pctrl->gpio_bank[id].gc.direction_output = npcmgpio_direction_output;
+		pctrl->gpio_bank[id].request = pctrl->gpio_bank[id].gc.request;
+		pctrl->gpio_bank[id].gc.request = npcmgpio_gpio_request;
+		pctrl->gpio_bank[id].gc.free = npcmgpio_gpio_free;
+		pctrl->gpio_bank[id].gc.fwnode = child;
+		id++;
+	}
+
 	pctrl->bank_num = id;
 	return ret;
 }
-- 
2.35.1


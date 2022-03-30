Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B068E4EC774
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347521AbiC3Oyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347673AbiC3Owz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:52:55 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D9A4D9FA;
        Wed, 30 Mar 2022 07:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648651857; x=1680187857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JTI2sWpV0UzE6IeL8l7wpen8kbwzDYKP8YDjk2kp5w4=;
  b=evgJUDjrHsT7ldTYR+yEkIMjrbcU8HcIeBQNQIO45NgKOrSRZLi+iAhq
   FMYkF8a2mXbnHbUvOE0D3mJDP0caMPtq0RU+8dvmQosOYtwlMADcxEmWq
   V1t9AXdjopmZ/UnXpu3stYP+3KSn3IWkEIIlvUeclZetkdJY63z3SVujH
   QHBP69d+zlGPH3Y2/Xlo3Q3hqeMx+p8I0KSzLvpF17rl57iapIlAxnYjI
   ivCBJp4TGjoNgVG1a+IA/mpiUPoTzYS1dwm8nIZcyL5D9ITg/ghfyWsC2
   3ZKATIsiVOZUoFpojeDrN1Et1By6W4aabDGpC9Un7m3Oqfp3I4uoQtNCc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="320259365"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="320259365"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:50:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="546889516"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Mar 2022 07:50:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AAE0A698; Wed, 30 Mar 2022 17:50:33 +0300 (EEST)
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
Subject: [PATCH v3 11/13] pinctrl: meson: Replace custom code by gpiochip_node_count() call
Date:   Wed, 30 Mar 2022 17:50:28 +0300
Message-Id: <20220330145030.1562-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330145030.1562-1-andriy.shevchenko@linux.intel.com>
References: <20220330145030.1562-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have generic function to count GPIO controller nodes
under a given device, there is no need to open code it. Replace
custom code by gpiochip_node_count() call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 28 ++++++++++++---------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 5b46a0979db7..1b078da81523 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -49,6 +49,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
 
@@ -662,27 +663,22 @@ static struct regmap *meson_map_resource(struct meson_pinctrl *pc,
 	return devm_regmap_init_mmio(pc->dev, base, &meson_regmap_config);
 }
 
-static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc,
-				  struct device_node *node)
+static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc)
 {
-	struct device_node *np, *gpio_np = NULL;
+	struct device_node *gpio_np;
+	unsigned int chips;
 
-	for_each_child_of_node(node, np) {
-		if (!of_find_property(np, "gpio-controller", NULL))
-			continue;
-		if (gpio_np) {
-			dev_err(pc->dev, "multiple gpio nodes\n");
-			of_node_put(np);
-			return -EINVAL;
-		}
-		gpio_np = np;
-	}
-
-	if (!gpio_np) {
+	chips = gpiochip_node_count(pc->dev);
+	if (!chips) {
 		dev_err(pc->dev, "no gpio node found\n");
 		return -EINVAL;
 	}
+	if (chips > 1) {
+		dev_err(pc->dev, "multiple gpio nodes\n");
+		return -EINVAL;
+	}
 
+	gpio_np = to_of_node(device_get_named_child_node(pc->dev, "gpio-controller"));
 	pc->of_node = gpio_np;
 
 	pc->reg_mux = meson_map_resource(pc, gpio_np, "mux");
@@ -751,7 +747,7 @@ int meson_pinctrl_probe(struct platform_device *pdev)
 	pc->dev = dev;
 	pc->data = (struct meson_pinctrl_data *) of_device_get_match_data(dev);
 
-	ret = meson_pinctrl_parse_dt(pc, dev->of_node);
+	ret = meson_pinctrl_parse_dt(pc);
 	if (ret)
 		return ret;
 
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03AD4EB0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbiC2PcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238671AbiC2PbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:31:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986A311BD98;
        Tue, 29 Mar 2022 08:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648567775; x=1680103775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1uhnGCeQRRhPDv5FfIf14aURC8nLj45dxjP/6kq7UUg=;
  b=Rr/LmO6yzXibx08Pai2ic5cgSPWXkx0YIQr2lQrIT74K3TPftuz8OrzQ
   QY5HQs/5u44zEvy2mdRTY6d4xavI9C+jvFlBCiuVAFvKC8cMQYy30i+hd
   Ixc0CIxGgLtfapqTulJaVdpBy3CbXyQ1/QuoT8L4pKBwhwodKT6QZMaBJ
   gtXTLEAi2D2IHpLsFlehU/EgTyDQCjHVUwEyLRk90yrXV2E4a3tUqC5Xz
   zaNjntDBVLxHX9D4Qkfv2okhV3pldczcwVPilxQsvCIDT4YQ0Vj4cx4Dc
   gqoRnFMttX9xv9pEmn/gmOYpO6Q2N0SxA0lXuIBMQ1LfdeL6Qfd2QVm/a
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322460298"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="322460298"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 08:29:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="546425146"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2022 08:29:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5FAC0314; Tue, 29 Mar 2022 18:29:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Qianggui Song <qianggui.song@amlogic.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 07/13] pinctrl: renesas: rza1: Switch to use for_each_gpiochip_node() helper
Date:   Tue, 29 Mar 2022 18:29:20 +0300
Message-Id: <20220329152926.50958-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com>
References: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com>
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

Switch the code to use for_each_gpiochip_node() helper.

While at it, in order to avoid additional churn in the future,
switch to fwnode APIs where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/renesas/pinctrl-rza1.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rza1.c b/drivers/pinctrl/renesas/pinctrl-rza1.c
index 5075d5cebe8c..74183f36567b 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza1.c
@@ -24,6 +24,7 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #include "../core.h"
@@ -1166,17 +1167,17 @@ static const struct pinmux_ops rza1_pinmux_ops = {
  * @range: pin range to register to pinctrl core
  */
 static int rza1_parse_gpiochip(struct rza1_pinctrl *rza1_pctl,
-			       struct device_node *np,
+			       struct fwnode_handle *fwnode,
 			       struct gpio_chip *chip,
 			       struct pinctrl_gpio_range *range)
 {
 	const char *list_name = "gpio-ranges";
-	struct of_phandle_args of_args;
+	struct fwnode_reference_args of_args;
 	unsigned int gpioport;
 	u32 pinctrl_base;
 	int ret;
 
-	ret = of_parse_phandle_with_fixed_args(np, list_name, 3, 0, &of_args);
+	ret = fwnode_property_get_reference_args(fwnode, list_name, NULL, 3, 0, &of_args);
 	if (ret) {
 		dev_err(rza1_pctl->dev, "Unable to parse %s list property\n",
 			list_name);
@@ -1197,13 +1198,12 @@ static int rza1_parse_gpiochip(struct rza1_pinctrl *rza1_pctl,
 
 	*chip		= rza1_gpiochip_template;
 	chip->base	= -1;
-	chip->label	= devm_kasprintf(rza1_pctl->dev, GFP_KERNEL, "%pOFn",
-					 np);
+	chip->label	= devm_kasprintf(rza1_pctl->dev, GFP_KERNEL, "%pfw", fwnode);
 	if (!chip->label)
 		return -ENOMEM;
 
 	chip->ngpio	= of_args.args[2];
-	chip->of_node	= np;
+	chip->fwnode	= fwnode;
 	chip->parent	= rza1_pctl->dev;
 
 	range->id	= gpioport;
@@ -1232,10 +1232,9 @@ static int rza1_parse_gpiochip(struct rza1_pinctrl *rza1_pctl,
  */
 static int rza1_gpio_register(struct rza1_pinctrl *rza1_pctl)
 {
-	struct device_node *np = rza1_pctl->dev->of_node;
 	struct pinctrl_gpio_range *gpio_ranges;
 	struct gpio_chip *gpio_chips;
-	struct device_node *child;
+	struct fwnode_handle *child;
 	unsigned int ngpiochips;
 	unsigned int i;
 	int ret;
@@ -1254,14 +1253,11 @@ static int rza1_gpio_register(struct rza1_pinctrl *rza1_pctl)
 		return -ENOMEM;
 
 	i = 0;
-	for_each_child_of_node(np, child) {
-		if (!of_property_read_bool(child, "gpio-controller"))
-			continue;
-
+	for_each_gpiochip_node(rza1_pctl->dev, child) {
 		ret = rza1_parse_gpiochip(rza1_pctl, child, &gpio_chips[i],
 					  &gpio_ranges[i]);
 		if (ret) {
-			of_node_put(child);
+			fwnode_handle_put(child);
 			return ret;
 		}
 
-- 
2.35.1


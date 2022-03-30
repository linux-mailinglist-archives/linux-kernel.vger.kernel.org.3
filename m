Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443AB4EC752
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347492AbiC3Oww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347359AbiC3OwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:52:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5118A2716A;
        Wed, 30 Mar 2022 07:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648651828; x=1680187828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z1Wwebtp9mgYOoY8j5lm8osB9jE0USQeFWSvh/mZP9o=;
  b=lW4S5w4JSKLBvdiTxE2bD/WIQMnQXeVeEgriYf+bhYkB2mMdDGOrhDUQ
   GgZ5RqDsLuu+7nvYJmKoCMnvcXu59oUobffQOtiS8zRHIXFxHMdn+5lhv
   kj5WPBlKmQBD9Jmdu7H0tU9H3h5ihl/w/6bDYlDa6LX7MGc+8iKrdvcEj
   U/63sk5JRkwgM427kFcFWqtqAS8KTowN3mIGb64NszvGahrHCoUFALW6q
   nUF3Bl+9jj01XbMGMky2IRLGIcKw9MjcY6ZGJFGzFNmI1YIZjH9ucNNR3
   K77h3Y4yG/kWzcaT1QNKiGJ8VM3SDcq29OeA1nT26amJ+Rs73ObLidx/j
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259533333"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="259533333"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:50:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="521916028"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 30 Mar 2022 07:50:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7BD675F8; Wed, 30 Mar 2022 17:50:33 +0300 (EEST)
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
Subject: [PATCH v3 07/13] pinctrl: renesas: rza1: Switch to use for_each_gpiochip_node() helper
Date:   Wed, 30 Mar 2022 17:50:24 +0300
Message-Id: <20220330145030.1562-8-andriy.shevchenko@linux.intel.com>
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

Switch the code to use for_each_gpiochip_node() helper.

While at it, in order to avoid additional churn in the future,
switch to fwnode APIs where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rza1.c | 30 +++++++++++---------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rza1.c b/drivers/pinctrl/renesas/pinctrl-rza1.c
index acc00b1a955d..529c0fc4ec06 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza1.c
@@ -24,6 +24,7 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #include "../core.h"
@@ -1161,22 +1162,22 @@ static const struct pinmux_ops rza1_pinmux_ops = {
  * defined by gpio device tree binding documentation.
  *
  * @rza1_pctl: RZ/A1 pin controller device
- * @np: of gpio-controller node
+ * @fwnode: gpio-controller firmware node
  * @chip: gpio chip to register to gpiolib
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
+	struct fwnode_reference_args args;
 	unsigned int gpioport;
 	u32 pinctrl_base;
 	int ret;
 
-	ret = of_parse_phandle_with_fixed_args(np, list_name, 3, 0, &of_args);
+	ret = fwnode_property_get_reference_args(fwnode, list_name, NULL, 3, 0, &args);
 	if (ret) {
 		dev_err(rza1_pctl->dev, "Unable to parse %s list property\n",
 			list_name);
@@ -1187,7 +1188,7 @@ static int rza1_parse_gpiochip(struct rza1_pinctrl *rza1_pctl,
 	 * Find out on which port this gpio-chip maps to by inspecting the
 	 * second argument of the "gpio-ranges" property.
 	 */
-	pinctrl_base = of_args.args[1];
+	pinctrl_base = args.args[1];
 	gpioport = RZA1_PIN_ID_TO_PORT(pinctrl_base);
 	if (gpioport >= RZA1_NPORTS) {
 		dev_err(rza1_pctl->dev,
@@ -1197,19 +1198,18 @@ static int rza1_parse_gpiochip(struct rza1_pinctrl *rza1_pctl,
 
 	*chip		= rza1_gpiochip_template;
 	chip->base	= -1;
-	chip->label	= devm_kasprintf(rza1_pctl->dev, GFP_KERNEL, "%pOFn",
-					 np);
+	chip->ngpio	= args.args[2];
+	chip->label	= devm_kasprintf(rza1_pctl->dev, GFP_KERNEL, "%pfwP", fwnode);
 	if (!chip->label)
 		return -ENOMEM;
 
-	chip->ngpio	= of_args.args[2];
-	chip->of_node	= np;
+	chip->fwnode	= fwnode;
 	chip->parent	= rza1_pctl->dev;
 
 	range->id	= gpioport;
 	range->name	= chip->label;
 	range->pin_base	= range->base = pinctrl_base;
-	range->npins	= of_args.args[2];
+	range->npins	= args.args[2];
 	range->gc	= chip;
 
 	ret = devm_gpiochip_add_data(rza1_pctl->dev, chip,
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


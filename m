Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9348E501B92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245234AbiDNTFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345055AbiDNTFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:05:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DBAEA347;
        Thu, 14 Apr 2022 12:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649962972; x=1681498972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DKcjs5P6/J4J40ANpQxsRNN9gqCAV/44HTd2AkmL+k0=;
  b=bqI/Rw+53x6SjMA71kmYawMbvO4CNnhWoiRRFE6wXpbJwqei7aZrbmIy
   jtZbfmy9b6U9nJYvjfr+xC5nY/+oTDfQoEFgW6U4er0YZ3Iz7enbdg5lv
   t3ta8fLsCMFkC2o0LgGzTBuRPn51Da7YwPKXX85dntMx0SuwVqqVxhlJt
   UQKarmjBkoa6XEM7zPxoERnIUmsjTVKS2YIT7/uyC5NmIVZ6cDr56hMtx
   76WxVBF5E5ggKjWPqhadUCND0ZN0UkSosiPLfi0CpKIdg9oozuWMtQ6ep
   SKDAyPcYPVUVXF9zwIgxwOaCaX/l38mIfb4dOVj998G7mjZWrsYhTqcEU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262455005"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="262455005"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 12:02:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="656121825"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 14 Apr 2022 12:02:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ACE2C379; Thu, 14 Apr 2022 22:02:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 6/6] pinctrl: meson: Replace custom code by gpiochip_node_count() call
Date:   Thu, 14 Apr 2022 22:02:42 +0300
Message-Id: <20220414190242.22178-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
References: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 5b46a0979db7..cc2cd73ff8f9 100644
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
 
+	gpio_np = to_of_node(gpiochip_node_get_first(pc->dev));
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


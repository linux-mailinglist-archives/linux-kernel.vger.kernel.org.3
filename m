Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84DA5AD8AE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 20:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiIESA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 14:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIESAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 14:00:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85FD2612D;
        Mon,  5 Sep 2022 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662400822; x=1693936822;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Eh/xw1+J5xp9FOGQqFCGHq3ic13Sy42VEYyyfiqZmHo=;
  b=PYRscV5kTmemC3paubJepjL7JS1eX3dF/4/0kAcUCE677f7LuHUUnNfM
   QVNDYGAnFC7iwTpqW+cRo7FZeIywR6gWL7kp05NQpSQ/1PEhOe43PCeXt
   uHbIRUZXrBs3RArZGahNJ/pm7mHf4T9ahhDeOH4GPMekLZ6U5+jDqYtQJ
   rPh9TuctUiZz/aKDY0LK1mWVCs4TfE2jksvsMOp3eQNkruTmhNP6h/eyx
   /H5L8FnzxtE49rD+9iZ3qUXSTY28SpFNFCtS5Zjq7GIy9tY5NFPhhXNDp
   qRDnqEwJR7iM2i1LE6cZ9JszcL+3HROniHn0niqAR2kK6TTjyos/MHp+u
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="279446843"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="279446843"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 11:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="590991845"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 05 Sep 2022 11:00:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4E3D0101; Mon,  5 Sep 2022 21:00:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 1/1] pinctrl: meson: Switch to use fwnode instead of of_node
Date:   Mon,  5 Sep 2022 21:00:34 +0300
Message-Id: <20220905180034.73132-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library now accepts fwnode as a firmware node, so
switch the driver to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 7 +++----
 drivers/pinctrl/meson/pinctrl-meson.h | 4 +++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index cc2cd73ff8f9..530f3f934e19 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -608,6 +608,7 @@ static int meson_gpiolib_register(struct meson_pinctrl *pc)
 
 	pc->chip.label = pc->data->name;
 	pc->chip.parent = pc->dev;
+	pc->chip.fwnode = pc->fwnode;
 	pc->chip.request = gpiochip_generic_request;
 	pc->chip.free = gpiochip_generic_free;
 	pc->chip.set_config = gpiochip_generic_config;
@@ -619,8 +620,6 @@ static int meson_gpiolib_register(struct meson_pinctrl *pc)
 	pc->chip.base = -1;
 	pc->chip.ngpio = pc->data->num_pins;
 	pc->chip.can_sleep = false;
-	pc->chip.of_node = pc->of_node;
-	pc->chip.of_gpio_n_cells = 2;
 
 	ret = gpiochip_add_data(&pc->chip, pc);
 	if (ret) {
@@ -678,8 +677,8 @@ static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc)
 		return -EINVAL;
 	}
 
-	gpio_np = to_of_node(gpiochip_node_get_first(pc->dev));
-	pc->of_node = gpio_np;
+	pc->fwnode = gpiochip_node_get_first(pc->dev);
+	gpio_np = to_of_node(pc->fwnode);
 
 	pc->reg_mux = meson_map_resource(pc, gpio_np, "mux");
 	if (IS_ERR_OR_NULL(pc->reg_mux)) {
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index b197827027bd..34fc4e8612e4 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -12,6 +12,8 @@
 #include <linux/types.h>
 #include <linux/module.h>
 
+struct fwnode_handle;
+
 struct meson_pinctrl;
 
 /**
@@ -131,7 +133,7 @@ struct meson_pinctrl {
 	struct regmap *reg_gpio;
 	struct regmap *reg_ds;
 	struct gpio_chip chip;
-	struct device_node *of_node;
+	struct fwnode_handle *fwnode;
 };
 
 #define FUNCTION(fn)							\
-- 
2.35.1


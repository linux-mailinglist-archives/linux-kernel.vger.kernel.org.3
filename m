Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F34518810
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbiECPRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238024AbiECPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:17:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15013A733;
        Tue,  3 May 2022 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651590816; x=1683126816;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mYnSAOvC5DFnIhD6BJCtSc2xdFahiiF03HgPdymFLKk=;
  b=bEJedMIAMP+jwluJPRAF5hgdhaAXl7fvswoiD9eEmhZ1Q8khMIyLKa9Z
   8bz8IqFtZnqEUPOV5xF2gbCzGgF359DbJbY1J9KZEKkS8H7+ou/7BUdqt
   tSnAKn04xAoTmOEzHV0VxeOYXqNkLedyuIkIQ1uCOYcabTtLfNhQnE+9H
   dPjVJlv8JBrZRkJYdd+EcpOPEHrQB1ErcqFgz1BltOVmGHCjMLFzrYa1d
   HLfQLF8HNmtEqs85s63NF6g5Gc4Rp58HTL6GAVV0CS04nXLq7qsh8AKLD
   4BpwZb68KQsI1ILIYonRERHAYdHk1nEFFZJm12URXyUmE3l9LS/m8G6kX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267379493"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="267379493"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 08:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="562242112"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 03 May 2022 08:13:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 47CAC179; Tue,  3 May 2022 18:13:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] pinctrl: equilibrium: Switch to use fwnode instead of of_node
Date:   Tue,  3 May 2022 18:13:21 +0300
Message-Id: <20220503151321.58800-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library now accepts fwnode as a firmware node, so
switch the driver to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-equilibrium.c | 11 +++++------
 drivers/pinctrl/pinctrl-equilibrium.h | 10 ++++++----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-equilibrium.c b/drivers/pinctrl/pinctrl-equilibrium.c
index 3f0143087cc7..99cf24eb67ae 100644
--- a/drivers/pinctrl/pinctrl-equilibrium.c
+++ b/drivers/pinctrl/pinctrl-equilibrium.c
@@ -11,6 +11,7 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #include "core.h"
 #include "pinconf.h"
@@ -167,11 +168,9 @@ static int gpiochip_setup(struct device *dev, struct eqbr_gpio_ctrl *gctrl)
 
 	gc = &gctrl->chip;
 	gc->label = gctrl->name;
-#if defined(CONFIG_OF_GPIO)
-	gc->of_node = gctrl->node;
-#endif
+	gc->fwnode = gctrl->fwnode;
 
-	if (!of_property_read_bool(gctrl->node, "interrupt-controller")) {
+	if (!fwnode_property_read_bool(gctrl->fwnode, "interrupt-controller")) {
 		dev_dbg(dev, "gc %s: doesn't act as interrupt controller!\n",
 			gctrl->name);
 		return 0;
@@ -209,7 +208,7 @@ static int gpiolib_reg(struct eqbr_pinctrl_drv_data *drvdata)
 
 	for (i = 0; i < drvdata->nr_gpio_ctrls; i++) {
 		gctrl = drvdata->gpio_ctrls + i;
-		np = gctrl->node;
+		np = to_of_node(gctrl->fwnode);
 
 		gctrl->name = devm_kasprintf(dev, GFP_KERNEL, "gpiochip%d", i);
 		if (!gctrl->name)
@@ -895,7 +894,7 @@ static int pinbank_probe(struct eqbr_pinctrl_drv_data *drvdata)
 
 		pinbank_init(np_gpio, drvdata, banks + i, i);
 
-		gctrls[i].node = np_gpio;
+		gctrls[i].fwnode = of_fwnode_handle(np_gpio);
 		gctrls[i].bank = banks + i;
 		i++;
 	}
diff --git a/drivers/pinctrl/pinctrl-equilibrium.h b/drivers/pinctrl/pinctrl-equilibrium.h
index 83cb7dafc657..0c635a5b79f0 100644
--- a/drivers/pinctrl/pinctrl-equilibrium.h
+++ b/drivers/pinctrl/pinctrl-equilibrium.h
@@ -95,22 +95,24 @@ struct eqbr_pin_bank {
 	u32			aval_pinmap;
 };
 
+struct fwnode_handle;
+
 /**
  * struct eqbr_gpio_ctrl: represent a gpio controller.
- * @node: device node of gpio controller.
+ * @chip: gpio chip.
+ * @fwnode: firmware node of gpio controller.
  * @bank: pointer to corresponding pin bank.
  * @membase: base address of the gpio controller.
- * @chip: gpio chip.
  * @ic:   irq chip.
  * @name: gpio chip name.
  * @virq: irq number of the gpio chip to parent's irq domain.
  * @lock: spin lock to protect gpio register write.
  */
 struct eqbr_gpio_ctrl {
-	struct device_node	*node;
+	struct gpio_chip	chip;
+	struct fwnode_handle	*fwnode;
 	struct eqbr_pin_bank	*bank;
 	void __iomem		*membase;
-	struct gpio_chip	chip;
 	struct irq_chip		ic;
 	const char		*name;
 	unsigned int		virq;
-- 
2.35.1


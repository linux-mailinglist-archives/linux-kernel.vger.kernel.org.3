Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D495A7F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiHaNza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiHaNzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:55:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0B224954;
        Wed, 31 Aug 2022 06:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661954104; x=1693490104;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Me5kuSeD0lKqMI1ajfOQJ4feSTG7yhDhoYqU/db12HU=;
  b=L0vOQX6eFMIgrfVCJ+BPfaQq6ScYoOBEYHgVq9vdmTt0IMW+KBFiyJuf
   NCzHmkUqbbY0qx2vStvBPhpoZTQ1jTj2fxkEn1jsDtEP0D8DE5JNLiqPO
   ZSLFqaJR0ZrlyhqQedGFDYTrYy7g/e4zcMbpUaqefrqbk8hQYqoLHpLNO
   eqxKH3Z+Jzw+7rv+ndV806Qr8xPY9hOVrHbkup9KBv/z0q8prgRm1GKHl
   +NVNCCUOribsgmTeV26Y+mqKwonAy1RhSaX8WobLk5zghNvPyaOYCO1H/
   Hl9CxiTwGh5ztTjB8fxsh5X9rjk3n2aoJRrVATW4Jow3OV7bCEn30+RMk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296235432"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="296235432"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 06:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="645237549"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 31 Aug 2022 06:54:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 56403174; Wed, 31 Aug 2022 16:55:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/1] pinctrl: pistachio: Switch to use fwnode instead of
Date:   Wed, 31 Aug 2022 16:55:12 +0300
Message-Id: <20220831135512.78407-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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
v2: fixed compilation error (LKP)
 drivers/pinctrl/pinctrl-pistachio.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-pistachio.c b/drivers/pinctrl/pinctrl-pistachio.c
index 5de691c630b4..940ed3fff63a 100644
--- a/drivers/pinctrl/pinctrl-pistachio.c
+++ b/drivers/pinctrl/pinctrl-pistachio.c
@@ -10,13 +10,13 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -1347,46 +1347,45 @@ static struct pistachio_gpio_bank pistachio_gpio_banks[] = {
 
 static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
 {
-	struct device_node *node = pctl->dev->of_node;
 	struct pistachio_gpio_bank *bank;
 	unsigned int i;
 	int irq, ret = 0;
 
 	for (i = 0; i < pctl->nbanks; i++) {
 		char child_name[sizeof("gpioXX")];
-		struct device_node *child;
+		struct fwnode_handle *child;
 		struct gpio_irq_chip *girq;
 
 		snprintf(child_name, sizeof(child_name), "gpio%d", i);
-		child = of_get_child_by_name(node, child_name);
+		child = device_get_named_child_node(pctl->dev, child_name);
 		if (!child) {
 			dev_err(pctl->dev, "No node for bank %u\n", i);
 			ret = -ENODEV;
 			goto err;
 		}
 
-		if (!of_find_property(child, "gpio-controller", NULL)) {
+		if (!fwnode_property_present(child, "gpio-controller")) {
+			fwnode_handle_put(child);
 			dev_err(pctl->dev,
 				"No gpio-controller property for bank %u\n", i);
-			of_node_put(child);
 			ret = -ENODEV;
 			goto err;
 		}
 
-		irq = irq_of_parse_and_map(child, 0);
-		if (!irq) {
+		ret = fwnode_irq_get(child, 0);
+		if (ret < 0) {
+			fwnode_handle_put(child);
 			dev_err(pctl->dev, "No IRQ for bank %u\n", i);
-			of_node_put(child);
-			ret = -EINVAL;
 			goto err;
 		}
+		irq = ret;
 
 		bank = &pctl->gpio_banks[i];
 		bank->pctl = pctl;
 		bank->base = pctl->base + GPIO_BANK_BASE(i);
 
 		bank->gpio_chip.parent = pctl->dev;
-		bank->gpio_chip.of_node = child;
+		bank->gpio_chip.fwnode = child;
 
 		girq = &bank->gpio_chip.irq;
 		girq->chip = &bank->irq_chip;
-- 
2.35.1


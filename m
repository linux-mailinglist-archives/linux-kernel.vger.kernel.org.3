Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C70D5AD940
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 20:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiIESvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 14:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiIESuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 14:50:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028135EDD6;
        Mon,  5 Sep 2022 11:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662403849; x=1693939849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZTj2nmkgcLu3QTI5ZuLWIR3EG8xTNQmi+IkgjkuRQCM=;
  b=WX43+NkX9kRnukAEIEPjyakjPEyrJpyHFw9fHf0kDBVO5BTKkbqCdfP2
   0Ek0MykyQ7pJjBXQxcdUkV+MaGPVpdzeEV9U7sRWiwdGFuvOfCopaOfOe
   +u0L0NEybozqqUKkkqBRObwGkGGY+n4W31Wh6hWwoOkxtgTaFibdPEsj3
   GlE1Xn3sumRHOnbH07zUhXndYdoCi0hE+pCPb0qCtdi/ixEwpc1cN6Hy5
   WudQPiPr78CXc1eQPRsNN8rC66yErH/Inj1qNmYNyYpN1Dz7OlehlNKoq
   qw3rn6RQWcfZXzUkALOYLYKXb8rm+t2uKqL2fGbLKkCySCXlbJdZeb8io
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="294026417"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="294026417"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 11:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="717429161"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 05 Sep 2022 11:50:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 99765101; Mon,  5 Sep 2022 21:51:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pinctrl: ingenic: Switch to use fwnode instead of of_node
Date:   Mon,  5 Sep 2022 21:51:02 +0300
Message-Id: <20220905185102.74056-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
 drivers/pinctrl/pinctrl-ingenic.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 3a9ee9c8af11..7e732076dedf 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -12,14 +12,14 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -4152,7 +4152,7 @@ static const struct of_device_id ingenic_gpio_of_matches[] __initconst = {
 };
 
 static int __init ingenic_gpio_probe(struct ingenic_pinctrl *jzpc,
-				     struct device_node *node)
+				     struct fwnode_handle *fwnode)
 {
 	struct ingenic_gpio_chip *jzgc;
 	struct device *dev = jzpc->dev;
@@ -4160,7 +4160,7 @@ static int __init ingenic_gpio_probe(struct ingenic_pinctrl *jzpc,
 	unsigned int bank;
 	int err;
 
-	err = of_property_read_u32(node, "reg", &bank);
+	err = fwnode_property_read_u32(fwnode, "reg", &bank);
 	if (err) {
 		dev_err(dev, "Cannot read \"reg\" property: %i\n", err);
 		return err;
@@ -4185,7 +4185,7 @@ static int __init ingenic_gpio_probe(struct ingenic_pinctrl *jzpc,
 
 	jzgc->gc.ngpio = 32;
 	jzgc->gc.parent = dev;
-	jzgc->gc.of_node = node;
+	jzgc->gc.fwnode = fwnode;
 	jzgc->gc.owner = THIS_MODULE;
 
 	jzgc->gc.set = ingenic_gpio_set;
@@ -4196,9 +4196,12 @@ static int __init ingenic_gpio_probe(struct ingenic_pinctrl *jzpc,
 	jzgc->gc.request = gpiochip_generic_request;
 	jzgc->gc.free = gpiochip_generic_free;
 
-	jzgc->irq = irq_of_parse_and_map(node, 0);
-	if (!jzgc->irq)
+	err = fwnode_irq_get(fwnode, 0);
+	if (err < 0)
+		return err;
+	if (!err)
 		return -EINVAL;
+	jzgc->irq = err;
 
 	girq = &jzgc->gc.irq;
 	gpio_irq_chip_set_chip(girq, &ingenic_gpio_irqchip);
@@ -4227,12 +4230,12 @@ static int __init ingenic_pinctrl_probe(struct platform_device *pdev)
 	struct pinctrl_desc *pctl_desc;
 	void __iomem *base;
 	const struct ingenic_chip_info *chip_info;
-	struct device_node *node;
 	struct regmap_config regmap_config;
+	struct fwnode_handle *fwnode;
 	unsigned int i;
 	int err;
 
-	chip_info = of_device_get_match_data(dev);
+	chip_info = device_get_match_data(dev);
 	if (!chip_info) {
 		dev_err(dev, "Unsupported SoC\n");
 		return -EINVAL;
@@ -4319,11 +4322,11 @@ static int __init ingenic_pinctrl_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, jzpc->map);
 
-	for_each_child_of_node(dev->of_node, node) {
-		if (of_match_node(ingenic_gpio_of_matches, node)) {
-			err = ingenic_gpio_probe(jzpc, node);
+	device_for_each_child_node(dev, fwnode) {
+		if (of_match_node(ingenic_gpio_of_matches, to_of_node(fwnode))) {
+			err = ingenic_gpio_probe(jzpc, fwnode);
 			if (err) {
-				of_node_put(node);
+				fwnode_handle_put(fwnode);
 				return err;
 			}
 		}
-- 
2.35.1


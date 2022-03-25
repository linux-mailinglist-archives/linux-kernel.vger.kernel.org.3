Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBECF4E7DD0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiCYUIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiCYUH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:07:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CE02BB19;
        Fri, 25 Mar 2022 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648238655; x=1679774655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+3cMN1f1lEcXuRBrNDyNybfnJAqjD8jUdUQVryZwyuU=;
  b=VGbWWgqKbqXccXQql6hhvf8UAJkQJ6ZRaxfzgmH2DkLmuc1H//obZUyN
   Ev4MPix2rKWPgIqduFRM5sAoC4/6XGJ2ORuIFWU2C2XmNTl19WkzH9dgE
   GcExgFY7xAwFwf8Qsy/W6tvD8xXwY0bEqBSBLIGse1JkapXVlm/eRjP3L
   fOaYRBr3i65Sg/Mdy/gsrIFBo1alTeWdzlal6E5JCX29dM8Veao4sxs1n
   JPkts368v6zLr1YmsOteitgqyf7QkmmQKwrL7hjKzyKx1VABcxI/8m/Bw
   U7F0r+JPdsdnWdRK8eYn88BEplqn++SzIT60y8mwVH9CgAPORtXl7uzMp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="258427150"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="258427150"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 13:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="561956350"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 25 Mar 2022 13:04:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A508B314; Fri, 25 Mar 2022 22:04:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 5/5] pinctrl: armada-37xx: Replace custom code by gpiochip_count() call
Date:   Fri, 25 Mar 2022 22:03:38 +0200
Message-Id: <20220325200338.54270-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325200338.54270-1-andriy.shevchenko@linux.intel.com>
References: <20220325200338.54270-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have generic function to count GPIO controller nodes
under given device, there is no need to open code it. Replace
custom code by gpiochip_count() call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 24 +++++++++------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 08cad14042e2..ba94125f6566 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -728,22 +728,18 @@ static int armada_37xx_irqchip_register(struct platform_device *pdev,
 	struct gpio_irq_chip *girq = &gc->irq;
 	struct device *dev = &pdev->dev;
 	struct device_node *np;
-	int ret = -ENODEV, i, nr_irq_parent;
+	unsigned int nr_child_nodes, i;
+	int ret;
 
 	/* Check if we have at least one gpio-controller child node */
-	for_each_child_of_node(dev->of_node, np) {
-		if (of_property_read_bool(np, "gpio-controller")) {
-			ret = 0;
-			break;
-		}
-	}
-	if (ret)
-		return dev_err_probe(dev, ret, "no gpio-controller child node\n");
+	nr_child_nodes = gpiochip_count(dev);
+	if (!nr_child_nodes)
+		return dev_err_probe(dev, -ENODEV, "no gpio-controller child node\n");
 
-	nr_irq_parent = of_irq_count(np);
 	spin_lock_init(&info->irq_lock);
 
-	if (!nr_irq_parent) {
+	nr_child_nodes = of_irq_count(np);
+	if (!nr_child_nodes) {
 		dev_err(dev, "invalid or no IRQ\n");
 		return 0;
 	}
@@ -766,11 +762,11 @@ static int armada_37xx_irqchip_register(struct platform_device *pdev,
 	 * controller. But we do not take advantage of this and use
 	 * the chained irq with all of them.
 	 */
-	girq->num_parents = nr_irq_parent;
-	girq->parents = devm_kcalloc(dev, nr_irq_parent, sizeof(*girq->parents), GFP_KERNEL);
+	girq->num_parents = nr_child_nodes;
+	girq->parents = devm_kcalloc(dev, nr_child_nodes, sizeof(*girq->parents), GFP_KERNEL);
 	if (!girq->parents)
 		return -ENOMEM;
-	for (i = 0; i < nr_irq_parent; i++) {
+	for (i = 0; i < nr_child_nodes; i++) {
 		int irq = irq_of_parse_and_map(np, i);
 
 		if (irq < 0)
-- 
2.35.1


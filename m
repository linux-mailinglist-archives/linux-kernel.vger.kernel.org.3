Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9409F51E66D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 12:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384165AbiEGK1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 06:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243948AbiEGK06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 06:26:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF60517E1;
        Sat,  7 May 2022 03:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651918991; x=1683454991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZFgriWo4QmnK8I4aKqpEp72LmAajKhhg7MNjxcrFCVE=;
  b=RU5MJT1697SA4yC2jYorgLiHFOAt5IR4OD8j3Y5ds8DkA0ynzClg+5jF
   scl+NC0EeHhEELKtP8e/6vcJ2m7jLZTtYUac5s66jFN9IS4zg5fGlgTZH
   SKRe6C0HL8Tmf2ZcRuSBCM6W2fY2SkKw9KUiCylgZ6b84mv8h1d0y3xke
   fMesqV0VQXx9AnTEBa0FWgc6+UqeXFNAIDZvIOaHNB34Gm+vgyVMPgOlD
   6mkjFlt9N0LIn1r6HToJqUVdNjjKl2ngBQu+sYvBssQhR/Cl31DN/iIR9
   1GfIHwGWO2MYfk9p5OaB1wNfkxi/Wbzy07loMObIuhmV5dc4sMoLDCpL5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="355123994"
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="355123994"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 03:23:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="695561328"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 07 May 2022 03:23:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 039B3155; Sat,  7 May 2022 13:23:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] pinctrl: stm32: Unshadow np variable in stm32_pctl_probe()
Date:   Sat,  7 May 2022 13:22:57 +0300
Message-Id: <20220507102257.26414-1-andriy.shevchenko@linux.intel.com>
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

The np variable is used globally for stm32_pctl_probe() and in one of
its code branches. cppcheck is not happy with that:

  pinctrl-stm32.c:1530:23: warning: Local variable 'np' shadows outer variable [shadowVariable]

Instead of simply renaming one of the variables convert some code to
use a device pointer directly.

Fixes: bb949ed9b16b ("pinctrl: stm32: Switch to use for_each_gpiochip_node() helper")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index e73f2d24611f..5d1d067b2247 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1364,8 +1364,9 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
 	return err;
 }
 
-static struct irq_domain *stm32_pctrl_get_irq_domain(struct device_node *np)
+static struct irq_domain *stm32_pctrl_get_irq_domain(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct device_node *parent;
 	struct irq_domain *domain;
 
@@ -1482,23 +1483,19 @@ static int stm32_pctrl_create_pins_tab(struct stm32_pinctrl *pctl,
 
 int stm32_pctl_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	const struct stm32_pinctrl_match_data *match_data;
 	struct fwnode_handle *child;
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct stm32_pinctrl *pctl;
 	struct pinctrl_pin_desc *pins;
 	int i, ret, hwlock_id;
 	unsigned int banks;
 
-	if (!np)
-		return -EINVAL;
-
-	match = of_match_device(dev->driver->of_match_table, dev);
-	if (!match || !match->data)
+	match_data = device_get_match_data(dev);
+	if (!match_data)
 		return -EINVAL;
 
-	if (!of_find_property(np, "pins-are-numbered", NULL)) {
+	if (!device_property_present(dev, "pins-are-numbered")) {
 		dev_err(dev, "only support pins-are-numbered format\n");
 		return -EINVAL;
 	}
@@ -1510,7 +1507,7 @@ int stm32_pctl_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pctl);
 
 	/* check for IRQ controller (may require deferred probe) */
-	pctl->domain = stm32_pctrl_get_irq_domain(np);
+	pctl->domain = stm32_pctrl_get_irq_domain(pdev);
 	if (IS_ERR(pctl->domain))
 		return PTR_ERR(pctl->domain);
 
@@ -1526,10 +1523,10 @@ int stm32_pctl_probe(struct platform_device *pdev)
 	spin_lock_init(&pctl->irqmux_lock);
 
 	pctl->dev = dev;
-	pctl->match_data = match->data;
+	pctl->match_data = match_data;
 
 	/*  get optional package information */
-	if (!of_property_read_u32(np, "st,package", &pctl->pkg))
+	if (!device_property_read_u32(dev, "st,package", &pctl->pkg))
 		dev_dbg(pctl->dev, "package detected: %x\n", pctl->pkg);
 
 	pctl->pins = devm_kcalloc(pctl->dev, pctl->match_data->npins,
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8157E5AB84D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiIBSev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiIBSe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:34:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B4110D9A;
        Fri,  2 Sep 2022 11:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662143208; x=1693679208;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=BDT5EmdqjuMJqMI5cl7RV/oDMZZp4jG1VH1Y9bjPvBA=;
  b=MB6bGupnzcyWew3eYr/XVpYj9RRbYdjIeDZkOnkDw0/lcFbhzXkKq7iI
   dCW8Lk8q+r4R2+LRf+6/nEpaT+R+gtkSUfz0Gpsl859ym+sBwmGex9Rp2
   obP5RcHFLy66xqaH4gaNnHu8Bcbcf19/X7FapmzbICcHetE0ztF6Af8DA
   2fswu0oIiMIJGveoXoNJtFygbKut9XkgLaf0YRnm4vynb8Ujox/VN58zy
   1tq8Uftl9B+/LUVmw6QiTtJawA3hKLElyufysd4qsSqZg/8NLlIVmN427
   CViWjDUafHTsScA7F0hFOxAy36DaX1oDBk6qQ6bDuxlpEtGZgMELXsPMy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="296832723"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="296832723"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="615791657"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Sep 2022 11:26:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1F48449F; Fri,  2 Sep 2022 21:27:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/17] pinctrl: cy8c95x0: Enable GPIO range
Date:   Fri,  2 Sep 2022 21:26:40 +0300
Message-Id: <20220902182650.83098-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
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

Since it's a pin control, GPIO counterpart needs to know the mapping
between pin numbering and GPIO numbering. Enable this by calling
gpiochip_add_pin_range() at the chip addition time.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index eac8b073e19f..f09311d2d3fa 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -801,7 +801,20 @@ static void cy8c95x0_gpio_set_multiple(struct gpio_chip *gc,
 	cy8c95x0_write_regs_mask(chip, CY8C95X0_OUTPUT, bits, mask);
 }
 
-static int cy8c95x0_setup_gpiochip(struct cy8c95x0_pinctrl *chip, int ngpio)
+static int cy8c95x0_add_pin_ranges(struct gpio_chip *gc)
+{
+	struct cy8c95x0_pinctrl *chip = gpiochip_get_data(gc);
+	struct device *dev = chip->dev;
+	int ret;
+
+	ret = gpiochip_add_pin_range(gc, dev_name(dev), 0, 0, chip->tpin);
+	if (ret)
+		dev_err(dev, "failed to add GPIO pin range\n");
+
+	return ret;
+}
+
+static int cy8c95x0_setup_gpiochip(struct cy8c95x0_pinctrl *chip)
 {
 	struct gpio_chip *gc = &chip->gpio_chip;
 
@@ -814,9 +827,10 @@ static int cy8c95x0_setup_gpiochip(struct cy8c95x0_pinctrl *chip, int ngpio)
 	gc->set_multiple = cy8c95x0_gpio_set_multiple;
 	gc->set_config = cy8c95x0_gpio_set_config;
 	gc->can_sleep = true;
+	gc->add_pin_ranges = cy8c95x0_add_pin_ranges;
 
 	gc->base = -1;
-	gc->ngpio = ngpio;
+	gc->ngpio = chip->tpin;
 
 	gc->parent = chip->dev;
 	gc->owner = THIS_MODULE;
@@ -1328,11 +1342,11 @@ static int cy8c95x0_probe(struct i2c_client *client)
 			goto err_exit;
 	}
 
-	ret = cy8c95x0_setup_gpiochip(chip, chip->tpin);
+	ret = cy8c95x0_setup_pinctrl(chip);
 	if (ret)
 		goto err_exit;
 
-	ret = cy8c95x0_setup_pinctrl(chip);
+	ret = cy8c95x0_setup_gpiochip(chip);
 	if (ret)
 		goto err_exit;
 
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F014501B94
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345115AbiDNTF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245234AbiDNTFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:05:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C14EA343;
        Thu, 14 Apr 2022 12:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649962968; x=1681498968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A0aFgjBgiv4WjziTFwIZjoDlAYjSNTm8rHyC38Bfo30=;
  b=hLEIobCN+HBRByWHMltn9eK1sxRvf1/Xsw6IGwxE7EMcAR18X/Gp9fZn
   MN4Qa+R/f4VAjWCst1Pf0MlweHaiM/6zbHx3xXbVAKjjT5K8Cse413ZY1
   9lDMlnQxKwEz4tO0vu7ysX85sY3HY88k8P/NTCp/LcxnNYDqEF3WOHjTJ
   DeozBYA1PU/RB36Iu4urc8/JgAeqCA28NtGSCM1IeloCw4rWgSZnb51RM
   ELDssxFQ4Q9YAzCjO52xUTjCBQ3XMPjo8rL/LUvs0NFR7KUhRAvxZl0HL
   FXffyz4LPD6B0djiiVL6VaPgHP7UMyjXbza4BoYwbIMzHaZYdWYgNlraL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="244896044"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="244896044"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 12:02:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="725486343"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 14 Apr 2022 12:02:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 908E82AE; Thu, 14 Apr 2022 22:02:43 +0300 (EEST)
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
Subject: [PATCH v5 4/6] pinctrl: meson: Rename REG_* to MESON_REG_*
Date:   Thu, 14 Apr 2022 22:02:40 +0300
Message-Id: <20220414190242.22178-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
References: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
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

Currently compilation test fails on x86 due to name collision. The usual
way to fix that is to move both conflicting parts to their own namespaces.

Rename REG_* to MESON_REG_* as a prerequisite for enabling COMPILE_TEST.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 24 +++++++++++------------
 drivers/pinctrl/meson/pinctrl-meson.h | 28 +++++++++++++--------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 49851444a6e3..5b46a0979db7 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -218,13 +218,13 @@ static int meson_pinconf_set_output(struct meson_pinctrl *pc,
 				    unsigned int pin,
 				    bool out)
 {
-	return meson_pinconf_set_gpio_bit(pc, pin, REG_DIR, !out);
+	return meson_pinconf_set_gpio_bit(pc, pin, MESON_REG_DIR, !out);
 }
 
 static int meson_pinconf_get_output(struct meson_pinctrl *pc,
 				    unsigned int pin)
 {
-	int ret = meson_pinconf_get_gpio_bit(pc, pin, REG_DIR);
+	int ret = meson_pinconf_get_gpio_bit(pc, pin, MESON_REG_DIR);
 
 	if (ret < 0)
 		return ret;
@@ -236,13 +236,13 @@ static int meson_pinconf_set_drive(struct meson_pinctrl *pc,
 				   unsigned int pin,
 				   bool high)
 {
-	return meson_pinconf_set_gpio_bit(pc, pin, REG_OUT, high);
+	return meson_pinconf_set_gpio_bit(pc, pin, MESON_REG_OUT, high);
 }
 
 static int meson_pinconf_get_drive(struct meson_pinctrl *pc,
 				   unsigned int pin)
 {
-	return meson_pinconf_get_gpio_bit(pc, pin, REG_OUT);
+	return meson_pinconf_get_gpio_bit(pc, pin, MESON_REG_OUT);
 }
 
 static int meson_pinconf_set_output_drive(struct meson_pinctrl *pc,
@@ -269,7 +269,7 @@ static int meson_pinconf_disable_bias(struct meson_pinctrl *pc,
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg, &bit);
+	meson_calc_reg_and_bit(bank, pin, MESON_REG_PULLEN, &reg, &bit);
 	ret = regmap_update_bits(pc->reg_pullen, reg, BIT(bit), 0);
 	if (ret)
 		return ret;
@@ -288,7 +288,7 @@ static int meson_pinconf_enable_bias(struct meson_pinctrl *pc, unsigned int pin,
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
+	meson_calc_reg_and_bit(bank, pin, MESON_REG_PULL, &reg, &bit);
 	if (pull_up)
 		val = BIT(bit);
 
@@ -296,7 +296,7 @@ static int meson_pinconf_enable_bias(struct meson_pinctrl *pc, unsigned int pin,
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg, &bit);
+	meson_calc_reg_and_bit(bank, pin, MESON_REG_PULLEN, &reg, &bit);
 	ret = regmap_update_bits(pc->reg_pullen, reg, BIT(bit),	BIT(bit));
 	if (ret)
 		return ret;
@@ -321,7 +321,7 @@ static int meson_pinconf_set_drive_strength(struct meson_pinctrl *pc,
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, pin, REG_DS, &reg, &bit);
+	meson_calc_reg_and_bit(bank, pin, MESON_REG_DS, &reg, &bit);
 
 	if (drive_strength_ua <= 500) {
 		ds_val = MESON_PINCONF_DRV_500UA;
@@ -407,7 +407,7 @@ static int meson_pinconf_get_pull(struct meson_pinctrl *pc, unsigned int pin)
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg, &bit);
+	meson_calc_reg_and_bit(bank, pin, MESON_REG_PULLEN, &reg, &bit);
 
 	ret = regmap_read(pc->reg_pullen, reg, &val);
 	if (ret)
@@ -416,7 +416,7 @@ static int meson_pinconf_get_pull(struct meson_pinctrl *pc, unsigned int pin)
 	if (!(val & BIT(bit))) {
 		conf = PIN_CONFIG_BIAS_DISABLE;
 	} else {
-		meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
+		meson_calc_reg_and_bit(bank, pin, MESON_REG_PULL, &reg, &bit);
 
 		ret = regmap_read(pc->reg_pull, reg, &val);
 		if (ret)
@@ -447,7 +447,7 @@ static int meson_pinconf_get_drive_strength(struct meson_pinctrl *pc,
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, pin, REG_DS, &reg, &bit);
+	meson_calc_reg_and_bit(bank, pin, MESON_REG_DS, &reg, &bit);
 
 	ret = regmap_read(pc->reg_ds, reg, &val);
 	if (ret)
@@ -595,7 +595,7 @@ static int meson_gpio_get(struct gpio_chip *chip, unsigned gpio)
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, gpio, REG_IN, &reg, &bit);
+	meson_calc_reg_and_bit(bank, gpio, MESON_REG_IN, &reg, &bit);
 	regmap_read(pc->reg_gpio, reg, &val);
 
 	return !!(val & BIT(bit));
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index ff5372e0a475..b197827027bd 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -63,13 +63,13 @@ struct meson_reg_desc {
  * enum meson_reg_type - type of registers encoded in @meson_reg_desc
  */
 enum meson_reg_type {
-	REG_PULLEN,
-	REG_PULL,
-	REG_DIR,
-	REG_OUT,
-	REG_IN,
-	REG_DS,
-	NUM_REG,
+	MESON_REG_PULLEN,
+	MESON_REG_PULL,
+	MESON_REG_DIR,
+	MESON_REG_OUT,
+	MESON_REG_IN,
+	MESON_REG_DS,
+	MESON_NUM_REG,
 };
 
 /**
@@ -102,7 +102,7 @@ struct meson_bank {
 	unsigned int last;
 	int irq_first;
 	int irq_last;
-	struct meson_reg_desc regs[NUM_REG];
+	struct meson_reg_desc regs[MESON_NUM_REG];
 };
 
 struct meson_pinctrl_data {
@@ -150,12 +150,12 @@ struct meson_pinctrl {
 		.irq_first	= fi,					\
 		.irq_last	= li,					\
 		.regs = {						\
-			[REG_PULLEN]	= { per, peb },			\
-			[REG_PULL]	= { pr, pb },			\
-			[REG_DIR]	= { dr, db },			\
-			[REG_OUT]	= { or, ob },			\
-			[REG_IN]	= { ir, ib },			\
-			[REG_DS]	= { dsr, dsb },			\
+			[MESON_REG_PULLEN]	= { per, peb },		\
+			[MESON_REG_PULL]	= { pr, pb },		\
+			[MESON_REG_DIR]		= { dr, db },		\
+			[MESON_REG_OUT]		= { or, ob },		\
+			[MESON_REG_IN]		= { ir, ib },		\
+			[MESON_REG_DS]		= { dsr, dsb },		\
 		},							\
 	 }
 
-- 
2.35.1


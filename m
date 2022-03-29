Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485BB4EB09D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbiC2Pbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbiC2PbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:31:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48579108199;
        Tue, 29 Mar 2022 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648567768; x=1680103768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kMudTMtGxVZVHwV5VTjyiNEvYYx7Ej7e2ciD6y9y198=;
  b=cHhXrTnF77KEWLhT3V6RZX34IM+y7Mhhv80bOF4VyCHXvkHjtsjb2Dr7
   RzTjUOzyjRsYGBayQnKIoCVIrkSYc/7XmHdGwAsjyQpnQCYEnnHVn0ubi
   5P44GVGoZhY38HDbSnNDOy+lXgWHcdLAW0dVq9BTLIc8VN7FyhmTeJ0GI
   wXJVawEoPiqkteFjuANACsCh+ZNJjl4/2wD+SAB+R+NkE8GJifkFOvD2C
   SiLzupm/noLtgC9pj27OQptO8p9T2szwIghZfikRF77dTV+dOynvEyNqJ
   pyurWt1AQBAMHjAJ0CjT+BfYq1A30GvqkWAcSUMlzLlrtNEYVTMu/NWfW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259463026"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="259463026"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 08:29:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="649486724"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 29 Mar 2022 08:29:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7CEB63F2; Tue, 29 Mar 2022 18:29:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Qianggui Song <qianggui.song@amlogic.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 09/13] pinctrl: meson: Rename REG_* to MREG_*
Date:   Tue, 29 Mar 2022 18:29:22 +0300
Message-Id: <20220329152926.50958-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com>
References: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com>
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

Rename REG_* to MREG_* as a prerequisite for enabling COMPILE_TEST.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 24 ++++++++++++------------
 drivers/pinctrl/meson/pinctrl-meson.h | 24 ++++++++++++------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 49851444a6e3..64da61ba2bb9 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -218,13 +218,13 @@ static int meson_pinconf_set_output(struct meson_pinctrl *pc,
 				    unsigned int pin,
 				    bool out)
 {
-	return meson_pinconf_set_gpio_bit(pc, pin, REG_DIR, !out);
+	return meson_pinconf_set_gpio_bit(pc, pin, MREG_DIR, !out);
 }
 
 static int meson_pinconf_get_output(struct meson_pinctrl *pc,
 				    unsigned int pin)
 {
-	int ret = meson_pinconf_get_gpio_bit(pc, pin, REG_DIR);
+	int ret = meson_pinconf_get_gpio_bit(pc, pin, MREG_DIR);
 
 	if (ret < 0)
 		return ret;
@@ -236,13 +236,13 @@ static int meson_pinconf_set_drive(struct meson_pinctrl *pc,
 				   unsigned int pin,
 				   bool high)
 {
-	return meson_pinconf_set_gpio_bit(pc, pin, REG_OUT, high);
+	return meson_pinconf_set_gpio_bit(pc, pin, MREG_OUT, high);
 }
 
 static int meson_pinconf_get_drive(struct meson_pinctrl *pc,
 				   unsigned int pin)
 {
-	return meson_pinconf_get_gpio_bit(pc, pin, REG_OUT);
+	return meson_pinconf_get_gpio_bit(pc, pin, MREG_OUT);
 }
 
 static int meson_pinconf_set_output_drive(struct meson_pinctrl *pc,
@@ -269,7 +269,7 @@ static int meson_pinconf_disable_bias(struct meson_pinctrl *pc,
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg, &bit);
+	meson_calc_reg_and_bit(bank, pin, MREG_PULLEN, &reg, &bit);
 	ret = regmap_update_bits(pc->reg_pullen, reg, BIT(bit), 0);
 	if (ret)
 		return ret;
@@ -288,7 +288,7 @@ static int meson_pinconf_enable_bias(struct meson_pinctrl *pc, unsigned int pin,
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
+	meson_calc_reg_and_bit(bank, pin, MREG_PULL, &reg, &bit);
 	if (pull_up)
 		val = BIT(bit);
 
@@ -296,7 +296,7 @@ static int meson_pinconf_enable_bias(struct meson_pinctrl *pc, unsigned int pin,
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg, &bit);
+	meson_calc_reg_and_bit(bank, pin, MREG_PULLEN, &reg, &bit);
 	ret = regmap_update_bits(pc->reg_pullen, reg, BIT(bit),	BIT(bit));
 	if (ret)
 		return ret;
@@ -321,7 +321,7 @@ static int meson_pinconf_set_drive_strength(struct meson_pinctrl *pc,
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, pin, REG_DS, &reg, &bit);
+	meson_calc_reg_and_bit(bank, pin, MREG_DS, &reg, &bit);
 
 	if (drive_strength_ua <= 500) {
 		ds_val = MESON_PINCONF_DRV_500UA;
@@ -407,7 +407,7 @@ static int meson_pinconf_get_pull(struct meson_pinctrl *pc, unsigned int pin)
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg, &bit);
+	meson_calc_reg_and_bit(bank, pin, MREG_PULLEN, &reg, &bit);
 
 	ret = regmap_read(pc->reg_pullen, reg, &val);
 	if (ret)
@@ -416,7 +416,7 @@ static int meson_pinconf_get_pull(struct meson_pinctrl *pc, unsigned int pin)
 	if (!(val & BIT(bit))) {
 		conf = PIN_CONFIG_BIAS_DISABLE;
 	} else {
-		meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
+		meson_calc_reg_and_bit(bank, pin, MREG_PULL, &reg, &bit);
 
 		ret = regmap_read(pc->reg_pull, reg, &val);
 		if (ret)
@@ -447,7 +447,7 @@ static int meson_pinconf_get_drive_strength(struct meson_pinctrl *pc,
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, pin, REG_DS, &reg, &bit);
+	meson_calc_reg_and_bit(bank, pin, MREG_DS, &reg, &bit);
 
 	ret = regmap_read(pc->reg_ds, reg, &val);
 	if (ret)
@@ -595,7 +595,7 @@ static int meson_gpio_get(struct gpio_chip *chip, unsigned gpio)
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, gpio, REG_IN, &reg, &bit);
+	meson_calc_reg_and_bit(bank, gpio, MREG_IN, &reg, &bit);
 	regmap_read(pc->reg_gpio, reg, &val);
 
 	return !!(val & BIT(bit));
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index ff5372e0a475..c00d9ad27843 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -63,12 +63,12 @@ struct meson_reg_desc {
  * enum meson_reg_type - type of registers encoded in @meson_reg_desc
  */
 enum meson_reg_type {
-	REG_PULLEN,
-	REG_PULL,
-	REG_DIR,
-	REG_OUT,
-	REG_IN,
-	REG_DS,
+	MREG_PULLEN,
+	MREG_PULL,
+	MREG_DIR,
+	MREG_OUT,
+	MREG_IN,
+	MREG_DS,
 	NUM_REG,
 };
 
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
+			[MREG_PULLEN]	= { per, peb },			\
+			[MREG_PULL]	= { pr, pb },			\
+			[MREG_DIR]	= { dr, db },			\
+			[MREG_OUT]	= { or, ob },			\
+			[MREG_IN]	= { ir, ib },			\
+			[MREG_DS]	= { dsr, dsb },			\
 		},							\
 	 }
 
-- 
2.35.1


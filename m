Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D325A4E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiH2Njs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiH2Njh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:39:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B48091D0B;
        Mon, 29 Aug 2022 06:39:36 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:c9c8:35ca:a27e:68d0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E0F706601EFD;
        Mon, 29 Aug 2022 14:39:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661780375;
        bh=YPBC2ZGfDEC3siJavEeAXGqNt/bIFS7SELauum05Ixs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=meG8L5zNJOSYdEfGbfLU3hYjg7MKBQjnaz80UCWpzPuhQyzBfs9QrQjTJGXdvMcz1
         1oCq9v2xOkS7mlahOJWdEuMUTMWFrHZHfpXEEHQPFT0X3lCWjtOk2lzTE3YRJPgL5u
         Qhj3VyrM+qTYo0mkQhEoC8g736YPA6LDMJ4VRzoCuviepZg93OB2JZX9XiQx5OmeiY
         ipQQCkPWahBV7yU2dFe0BQkDtU8tr32rjvdU+bNRldxCONKeZgRgals1WNn+xUuPP3
         tjwUFNV7whPMlZBn+zaWmsPC4kDGaY5lSkHng+1PRa977sSDlrAKReeTsBARXLV7E7
         b3ctpy72k4cfQ==
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] gpio: pca953x: Fix pca953x_gpio_set_pull_up_down()
Date:   Mon, 29 Aug 2022 14:39:20 +0100
Message-Id: <20220829133923.1114555-3-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829133923.1114555-1-martyn.welch@collabora.com>
References: <20220829133923.1114555-1-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous fix (dc87f6dd058a gpio: pca953x: Fix pca953x_gpio_set_config)
identified that pinconf_to_config_param() needed to be used to isolate
the config_param from the pinconf in pca953x_gpio_set_config(). This fix
however did not consider that this would also be needed in
pca953x_gpio_set_pull_up_down() to which it passes this config.

Perform a similar call in pca953x_gpio_set_pull_up_down() to isolate the
configuration parameter there as well, rather than passing it from
pca953x_gpio_set_config() as the configuration argument may also be needed
in pca953x_gpio_set_pull_up_down() at a later date.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
 drivers/gpio/gpio-pca953x.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index ecd7d169470b..41e7ff83a735 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -551,6 +551,7 @@ static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
 	u8 pull_en_reg = pca953x_recalc_addr(chip, PCAL953X_PULL_EN, offset);
 	u8 pull_sel_reg = pca953x_recalc_addr(chip, PCAL953X_PULL_SEL, offset);
 	u8 bit = BIT(offset % BANK_SZ);
+	enum pin_config_param param = pinconf_to_config_param(config);
 	int ret;
 
 	/*
@@ -563,9 +564,9 @@ static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
 	mutex_lock(&chip->i2c_lock);
 
 	/* Configure pull-up/pull-down */
-	if (config == PIN_CONFIG_BIAS_PULL_UP)
+	if (param == PIN_CONFIG_BIAS_PULL_UP)
 		ret = regmap_write_bits(chip->regmap, pull_sel_reg, bit, bit);
-	else if (config == PIN_CONFIG_BIAS_PULL_DOWN)
+	else if (param == PIN_CONFIG_BIAS_PULL_DOWN)
 		ret = regmap_write_bits(chip->regmap, pull_sel_reg, bit, 0);
 	else
 		ret = 0;
@@ -573,7 +574,7 @@ static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
 		goto exit;
 
 	/* Disable/Enable pull-up/pull-down */
-	if (config == PIN_CONFIG_BIAS_DISABLE)
+	if (param == PIN_CONFIG_BIAS_DISABLE)
 		ret = regmap_write_bits(chip->regmap, pull_en_reg, bit, 0);
 	else
 		ret = regmap_write_bits(chip->regmap, pull_en_reg, bit, bit);
-- 
2.35.1


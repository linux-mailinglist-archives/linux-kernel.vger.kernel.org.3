Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14830512FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiD1Jtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242453AbiD1Jgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:36:37 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC3A95486;
        Thu, 28 Apr 2022 02:33:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p12so3820749pfn.0;
        Thu, 28 Apr 2022 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1AZOCN0gvek/FGxRO1VvIesAbLD/uY9lQokPwBAiQ2Q=;
        b=YEYbQR26QvFnDG1PF6w7QmYol2Q4GQydBVEBYqkJQSs++Okx23pEQjpCAt5udpWvGb
         dBTvY0C0tpTxrUH6R/rVogmdLJDwlNG/XqT51/lcIkfu9xBTInEARdPEYECYebAltRCF
         uXKK0TO3OPXz6RiAzb4NjEIuyn2222h/vJ52mccpd+O4COvwSAwKqJGUHuPRRXlj8F4f
         ofh+Y+/bUfNyOykSrDXX87I9SlaeReno5yJ8C+A8ITIWIQjUvnxhsyZ9eTg1dNcJoR1H
         TVeub9I20Rqm4QaTkw56oUBCe24BMGdOC16MQoe70pJo/dlg2wSmV9lfkCIMnh1HzaLb
         IxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1AZOCN0gvek/FGxRO1VvIesAbLD/uY9lQokPwBAiQ2Q=;
        b=hC3OzbJghDeF+DjI5InpizNJCDV4GfSYMWZKeQ+WhmaPbwuGVFJchkoJzXRscpa0EK
         5XiDm1dtt2MzKlzRYipVA7mZ5zgE8dAxM5N2fG0ORIOZh7itm3Drq1FgLDBpAPrW6xja
         HXOt4qZanirtbdxjosgoUTvFlUa3uFXiatCwoafoC7tYU3tfpb6RveKnn2Gqzjoeyl1t
         ZF/+8ePCDDICx5maSRvTDND3yvbhSRPnAaz1FBznyLKsnCXk5h5KgFhiabJh5OaRi6vu
         g4L1uFJnTzbaz4fRdqnSRViga+Mibno7+IWMJwthKRvvJobF7IXRmnPsgVXC9qKrlS5e
         8Yqw==
X-Gm-Message-State: AOAM533Hx4j8x/gh65D6E5SDu3MWnsLaxg/e/q/hdCcuERGv4EZFOLup
        wxkEjbJQ6dVCIo86G8xvi3Y=
X-Google-Smtp-Source: ABdhPJylt6gFnhP5FlWXUj5/mfYFMndmtRqiV4Nbt5NTYp3aJm4jKwrBC422Bj1EFurlkueUfKl/mg==
X-Received: by 2002:a62:fb0e:0:b0:505:fd9e:9218 with SMTP id x14-20020a62fb0e000000b00505fd9e9218mr34800820pfm.78.1651138402659;
        Thu, 28 Apr 2022 02:33:22 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:2b1f:d169:337e:6359:8ff7])
        by smtp.gmail.com with ESMTPSA id i66-20020a628745000000b0050d36a5fe70sm15457932pfe.127.2022.04.28.02.33.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:33:22 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     pavel@ucw.cz, matthias.bgg@gmail.com
Cc:     cy_huang@richtek.com, jacek.anaszewski@gmail.com,
        gene_chen@richtek.com, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] leds: flash: mt6360: Add mt6360 isnk channel hardware timer dimming mode support
Date:   Thu, 28 Apr 2022 17:32:44 +0800
Message-Id: <1651138365-17362-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651138365-17362-1-git-send-email-u0084500@gmail.com>
References: <1651138365-17362-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add mt6360 isnk channel hardware timer dimming mode support.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/leds/flash/leds-mt6360.c | 209 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 203 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/flash/leds-mt6360.c b/drivers/leds/flash/leds-mt6360.c
index 712cd46..8fe3dc4 100644
--- a/drivers/leds/flash/leds-mt6360.c
+++ b/drivers/leds/flash/leds-mt6360.c
@@ -24,9 +24,19 @@ enum {
 	MT6360_MAX_LEDS
 };
 
+#define MT6360_ISNK_PWM_MODE		0
+#define MT6360_ISNK_CC_MODE		2
+
 #define MT6360_REG_RGBEN		0x380
 #define MT6360_REG_ISNK(_led_no)	(0x381 + (_led_no))
+#define MT6360_REG_DIM(_led_no)		(0x385 + (_led_no))
+#define MT6360_REG_FREQ1		0x389
+#define MT6360_REG_FREQ2		0x38A
 #define MT6360_ISNK_ENMASK(_led_no)	BIT(7 - (_led_no))
+#define MT6360_FREQ13_MASK		GENMASK(7, 5)
+#define MT6360_FREQ2_MASK		GENMASK(4, 2)
+#define MT6360_ISNK_MODE_MASK		GENMASK(7, 6)
+#define MT6360_ISNK_MODE_SHFT		6
 #define MT6360_ISNK_MASK		GENMASK(4, 0)
 #define MT6360_CHRINDSEL_MASK		BIT(3)
 
@@ -98,13 +108,128 @@ struct mt6360_priv {
 	struct mt6360_led leds[];
 };
 
+static int mt6360_get_selected_freq_duty(unsigned long on, unsigned long off,
+					 unsigned int *fsel, unsigned int *dsel)
+{
+	static const unsigned int freq_ms[] = { 8000, 4000, 2000, 1000,
+						500, 250, 8, 4 };
+	unsigned int sum = on + off;
+	int i;
+
+	/* Check if val is less than the smallest or larger then the largest */
+	if (sum > freq_ms[0] || sum < freq_ms[ARRAY_SIZE(freq_ms) - 1])
+		return -EINVAL;
+
+	/* Find the frequency for less or equal one */
+	for (i = 0; i < ARRAY_SIZE(freq_ms) - 1; i++) {
+		if (sum >= freq_ms[i])
+			break;
+	}
+
+	*fsel = i;
+	*dsel = on * 255 / sum;
+	return 0;
+}
+
+static int mt6360_set_pwm_dimming_param(struct mt6360_priv *priv,
+					unsigned int led_no, unsigned int fsel,
+					unsigned int dsel)
+{
+	unsigned int freq_reg, freq_mask, freq_shift;
+	int ret;
+
+	switch (led_no) {
+	case MT6360_LED_ISNK1:
+		freq_reg = MT6360_REG_FREQ1;
+		freq_mask = MT6360_FREQ13_MASK;
+		break;
+	case MT6360_LED_ISNK2:
+		freq_reg = MT6360_REG_FREQ1;
+		freq_mask = MT6360_FREQ2_MASK;
+		break;
+	case MT6360_LED_ISNK3:
+		freq_reg = MT6360_REG_FREQ2;
+		freq_mask = MT6360_FREQ13_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	freq_shift = ffs(freq_mask) - 1;
+
+	ret = regmap_update_bits(priv->regmap, freq_reg, freq_mask,
+				 fsel << freq_shift);
+	if (ret)
+		return ret;
+
+	return regmap_write(priv->regmap, MT6360_REG_DIM(led_no), dsel);
+}
+
+static int mt6360_mc_blink_set(struct led_classdev *lcdev, unsigned long *don,
+			       unsigned long *doff)
+{
+	struct led_classdev_mc *mccdev = lcdev_to_mccdev(lcdev);
+	struct mt6360_led *led = container_of(mccdev, struct mt6360_led, mc);
+	struct mt6360_priv *priv = led->priv;
+	unsigned int freq_sel, duty_sel;
+	u8 mc_reg[3];
+	int i, ret;
+
+	if (!*don && !*doff)
+		*don = *doff = 500;
+
+	mutex_lock(&priv->lock);
+
+	ret = regmap_raw_read(priv->regmap, MT6360_REG_ISNK(0), mc_reg, 3);
+	if (ret)
+		goto out;
+
+	/* Configure all subleds to CC mode first */
+	for (i = 0; i < mccdev->num_colors; i++) {
+		struct mc_subled *subled = mccdev->subled_info + i;
+		int ch_idx = subled->channel;
+
+		mc_reg[ch_idx] &= ~MT6360_ISNK_MODE_MASK;
+		mc_reg[ch_idx] |= MT6360_ISNK_CC_MODE << MT6360_ISNK_MODE_SHFT;
+	}
+
+	ret = regmap_raw_write(priv->regmap, MT6360_REG_ISNK(0), mc_reg, 3);
+	if (ret)
+		goto out;
+
+	/* Get the desired selector for frequency and duty */
+	ret = mt6360_get_selected_freq_duty(*don, *doff, &freq_sel, &duty_sel);
+	if (ret)
+		goto out;
+
+	/* Configure all subleds dim freq/duty and change to PWM mode */
+	for (i = 0; i < mccdev->num_colors; i++) {
+		struct mc_subled *subled = mccdev->subled_info + i;
+		int ch_idx = subled->channel;
+
+		ret = mt6360_set_pwm_dimming_param(priv, ch_idx, freq_sel,
+						   duty_sel);
+		if (ret)
+			goto out;
+
+		mc_reg[ch_idx] &= ~MT6360_ISNK_MODE_MASK;
+		mc_reg[ch_idx] |= MT6360_ISNK_PWM_MODE << MT6360_ISNK_MODE_SHFT;
+	}
+
+	ret = regmap_raw_write(priv->regmap, MT6360_REG_ISNK(0), mc_reg, 3);
+
+out:
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
 static int mt6360_mc_brightness_set(struct led_classdev *lcdev,
 				    enum led_brightness level)
 {
 	struct led_classdev_mc *mccdev = lcdev_to_mccdev(lcdev);
 	struct mt6360_led *led = container_of(mccdev, struct mt6360_led, mc);
 	struct mt6360_priv *priv = led->priv;
-	u32 real_bright, enable_mask = 0, enable = 0;
+	u32 real_bright, enable_mask = 0, enable = 0, val;
 	int i, ret;
 
 	mutex_lock(&priv->lock);
@@ -113,11 +238,25 @@ static int mt6360_mc_brightness_set(struct led_classdev *lcdev,
 
 	for (i = 0; i < mccdev->num_colors; i++) {
 		struct mc_subled *subled = mccdev->subled_info + i;
+		unsigned int bright_reg = MT6360_REG_ISNK(subled->channel);
 
 		real_bright = min(lcdev->max_brightness, subled->brightness);
-		ret = regmap_update_bits(priv->regmap,
-					 MT6360_REG_ISNK(subled->channel),
-					 MT6360_ISNK_MASK, real_bright);
+
+		ret = regmap_read(priv->regmap, bright_reg, &val);
+		if (ret)
+			goto out;
+
+		/* Assign the new brightness value */
+		val &= ~MT6360_ISNK_MASK;
+		val |= (real_bright & MT6360_ISNK_MASK);
+
+		/* If LED_OFF, always configure back to CC mode */
+		if (level == LED_OFF) {
+			val &= ~MT6360_ISNK_MODE_MASK;
+			val |= MT6360_ISNK_CC_MODE << MT6360_ISNK_MODE_SHFT;
+		}
+
+		ret = regmap_write(priv->regmap, bright_reg, val);
 		if (ret)
 			goto out;
 
@@ -134,6 +273,44 @@ static int mt6360_mc_brightness_set(struct led_classdev *lcdev,
 	return ret;
 }
 
+static int mt6360_isnk_blink_set(struct led_classdev *lcdev, unsigned long *don,
+				 unsigned long *doff)
+{
+	struct mt6360_led *led = container_of(lcdev, struct mt6360_led, isnk);
+	struct mt6360_priv *priv = led->priv;
+	unsigned int freq_sel, duty_sel;
+	int ret;
+
+	if (!*don && !*doff)
+		*don = *doff = 500;
+
+	mutex_lock(&priv->lock);
+
+	ret = regmap_update_bits(priv->regmap, MT6360_REG_ISNK(led->led_no),
+				 MT6360_ISNK_MODE_MASK,
+				 MT6360_ISNK_CC_MODE << MT6360_ISNK_MODE_SHFT);
+	if (ret)
+		goto out;
+
+	/* Get the desired selector for frequency and duty */
+	ret = mt6360_get_selected_freq_duty(*don, *doff, &freq_sel, &duty_sel);
+	if (ret)
+		goto out;
+
+	ret = mt6360_set_pwm_dimming_param(priv, led->led_no, freq_sel,
+					   duty_sel);
+	if (ret)
+		goto out;
+
+	ret = regmap_update_bits(priv->regmap, MT6360_REG_ISNK(led->led_no),
+				 MT6360_ISNK_MODE_MASK,
+				 MT6360_ISNK_PWM_MODE << MT6360_ISNK_MODE_SHFT);
+
+out:
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
 static int mt6360_isnk_brightness_set(struct led_classdev *lcdev,
 				      enum led_brightness level)
 {
@@ -141,12 +318,27 @@ static int mt6360_isnk_brightness_set(struct led_classdev *lcdev,
 	struct mt6360_priv *priv = led->priv;
 	u32 enable_mask = MT6360_ISNK_ENMASK(led->led_no);
 	u32 val = level ? MT6360_ISNK_ENMASK(led->led_no) : 0;
+	unsigned int bright_val;
 	int ret;
 
 	mutex_lock(&priv->lock);
 
-	ret = regmap_update_bits(priv->regmap, MT6360_REG_ISNK(led->led_no),
-				 MT6360_ISNK_MASK, level);
+	ret = regmap_read(priv->regmap, MT6360_REG_ISNK(led->led_no),
+			  &bright_val);
+	if (ret)
+		goto out;
+
+	bright_val &= ~MT6360_ISNK_MASK;
+	bright_val |= (level & MT6360_ISNK_MASK);
+
+	/* If LED_OFF, always configure back to CC mode */
+	if (led->led_no != MT6360_LED_ISNKML && level == LED_OFF) {
+		bright_val &= ~MT6360_ISNK_MODE_MASK;
+		bright_val |= MT6360_ISNK_CC_MODE << MT6360_ISNK_MODE_SHFT;
+	}
+
+	ret = regmap_write(priv->regmap, MT6360_REG_ISNK(led->led_no),
+			   bright_val);
 	if (ret)
 		goto out;
 
@@ -666,6 +858,7 @@ static int mt6360_init_isnk_properties(struct mt6360_led *led,
 
 		lcdev = &led->mc.led_cdev;
 		lcdev->brightness_set_blocking = mt6360_mc_brightness_set;
+		lcdev->blink_set = mt6360_mc_blink_set;
 	} else {
 		if (led->led_no == MT6360_LED_ISNKML) {
 			step_uA = MT6360_ISNKML_STEPUA;
@@ -674,6 +867,10 @@ static int mt6360_init_isnk_properties(struct mt6360_led *led,
 
 		lcdev = &led->isnk;
 		lcdev->brightness_set_blocking = mt6360_isnk_brightness_set;
+
+		/* Suppose only ISNK1/2/3 support mode change */
+		if (led->led_no != MT6360_LED_ISNKML)
+			lcdev->blink_set = mt6360_isnk_blink_set;
 	}
 
 	ret = fwnode_property_read_u32(init_data->fwnode, "led-max-microamp",
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F201568524
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiGFKTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbiGFKSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:18:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C73F25EA2;
        Wed,  6 Jul 2022 03:18:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f2so15991872wrr.6;
        Wed, 06 Jul 2022 03:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jkVxNLKA00gltOAHa0/vhCLo5Cyuj70II52l+bRNn6w=;
        b=maDjwrqFytwlh8grZ70DFvRHsznzNtqDB+FD7IAm+vv5G75jXaKWn3PeSADVEiGHaw
         CYfKCn9otiQTjzT3bDDGYGGxqZTpYslWpu3ZRTqHjg37uiYHA1ohCqTOU++KQ3HF/rUa
         LglkZprEtTSr3afduHR081AijXdC+lZJIan6qgrHhD1fEs2AeCIFs0n8AUqki2Quhu0L
         5LsVKcY/kw130VuSjVwD+D9KrfIfp8mGvY9ao5Tc1tM5DU19ziSDkJjuR92cpZN47kVD
         1/4RWZzk5BuEbdTY9uc9VnV0wddG8kPKVNQXrh6dsELDl6uq4HZo1pjCvgZ/YVG/6kWg
         bDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jkVxNLKA00gltOAHa0/vhCLo5Cyuj70II52l+bRNn6w=;
        b=BMgn/VPv2oCg4DrLsCFxAfFbvJ4WxfBAQJ4+G5OUSF0x2rp8ThHfzOScQN3dUKIzVB
         KaNd76FlBUHDVMHrPAjvxhL20ZDPSR8JweTHt97uomncJvJIvYfRXISQlMZYgfsbPS6O
         2eZlEL3GstmhaY+ca910TY5HcwA6ftiPAdqiIp1Nrkx264TNHnz6uQlSPxvEKk2HaVPF
         xpQnl6u7tq9glJA8TPkZBV3V2Php/2ZnIlyEpMk1o8JXXcVzlKhmqxsig/GSgtC9OOnd
         uDytFwAlckMmNTSKu3Qbx+imfpuOZp158083a3q+LJFgJhen/is+WPB7WQt9qJ81ovBW
         lpXA==
X-Gm-Message-State: AJIora9GR1m2yL058J4n0aLWAxqKuCZqV6SVOE61AvJG7+br3kIfnMY0
        PwDL6g79nbxIFpvFnd5ctCY=
X-Google-Smtp-Source: AGRyM1tm85sBQd4166CS+LgU2kfBPoFYwgtnyZcNQJ4fQmvowbSzGgM/DI5/4eZm10dsBsn911mijA==
X-Received: by 2002:a5d:5908:0:b0:21d:6e91:9f3 with SMTP id v8-20020a5d5908000000b0021d6e9109f3mr10585693wrd.52.1657102718620;
        Wed, 06 Jul 2022 03:18:38 -0700 (PDT)
Received: from localhost (92.40.202.167.threembb.co.uk. [92.40.202.167])
        by smtp.gmail.com with ESMTPSA id l26-20020a1ced1a000000b003a03ae64f57sm4453298wmh.8.2022.07.06.03.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:18:37 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 05/13] mfd: axp20x: Add support for AXP192
Date:   Wed,  6 Jul 2022 11:18:54 +0100
Message-Id: <20220706101902.4984-6-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220706101902.4984-1-aidanmacdonald.0x0@gmail.com>
References: <20220706101902.4984-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP192 PMIC is similar to the AXP202/AXP209, but with different
regulators, additional GPIOs, and a different IRQ register layout.

Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/axp20x-i2c.c   |   2 +
 drivers/mfd/axp20x.c       | 141 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h |  84 ++++++++++++++++++++++
 3 files changed, 227 insertions(+)

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index 00ab48018d8d..9ada58fad77f 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -62,6 +62,7 @@ static int axp20x_i2c_remove(struct i2c_client *i2c)
 #ifdef CONFIG_OF
 static const struct of_device_id axp20x_i2c_of_match[] = {
 	{ .compatible = "x-powers,axp152", .data = (void *)AXP152_ID },
+	{ .compatible = "x-powers,axp192", .data = (void *)AXP192_ID },
 	{ .compatible = "x-powers,axp202", .data = (void *)AXP202_ID },
 	{ .compatible = "x-powers,axp209", .data = (void *)AXP209_ID },
 	{ .compatible = "x-powers,axp221", .data = (void *)AXP221_ID },
@@ -75,6 +76,7 @@ MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
 
 static const struct i2c_device_id axp20x_i2c_id[] = {
 	{ "axp152", 0 },
+	{ "axp192", 0 },
 	{ "axp202", 0 },
 	{ "axp209", 0 },
 	{ "axp221", 0 },
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 8161a5dc68e8..3586bb13d7fc 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -34,6 +34,7 @@
 
 static const char * const axp20x_model_names[] = {
 	"AXP152",
+	"AXP192",
 	"AXP202",
 	"AXP209",
 	"AXP221",
@@ -92,6 +93,35 @@ static const struct regmap_access_table axp20x_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(axp20x_volatile_ranges),
 };
 
+static const struct regmap_range axp192_writeable_ranges[] = {
+	regmap_reg_range(AXP192_DATACACHE(0), AXP192_DATACACHE(5)),
+	regmap_reg_range(AXP192_PWR_OUT_CTRL, AXP192_IRQ5_STATE),
+	regmap_reg_range(AXP20X_DCDC_MODE, AXP192_N_RSTO_CTRL),
+	regmap_reg_range(AXP20X_CC_CTRL, AXP20X_CC_CTRL),
+};
+
+static const struct regmap_range axp192_volatile_ranges[] = {
+	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP192_USB_OTG_STATUS),
+	regmap_reg_range(AXP192_IRQ1_STATE, AXP192_IRQ4_STATE),
+	regmap_reg_range(AXP192_IRQ5_STATE, AXP192_IRQ5_STATE),
+	regmap_reg_range(AXP20X_ACIN_V_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
+	regmap_reg_range(AXP20X_TIMER_CTRL, AXP20X_TIMER_CTRL),
+	regmap_reg_range(AXP192_GPIO2_0_STATE, AXP192_GPIO2_0_STATE),
+	regmap_reg_range(AXP192_GPIO4_3_STATE, AXP192_GPIO4_3_STATE),
+	regmap_reg_range(AXP192_N_RSTO_CTRL, AXP192_N_RSTO_CTRL),
+	regmap_reg_range(AXP20X_CHRG_CC_31_24, AXP20X_CC_CTRL),
+};
+
+static const struct regmap_access_table axp192_writeable_table = {
+	.yes_ranges	= axp192_writeable_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(axp192_writeable_ranges),
+};
+
+static const struct regmap_access_table axp192_volatile_table = {
+	.yes_ranges	= axp192_volatile_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(axp192_volatile_ranges),
+};
+
 /* AXP22x ranges are shared with the AXP809, as they cover the same range */
 static const struct regmap_range axp22x_writeable_ranges[] = {
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
@@ -173,6 +203,19 @@ static const struct resource axp152_pek_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
 };
 
+static const struct resource axp192_ac_power_supply_resources[] = {
+	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_ACIN_PLUGIN, "ACIN_PLUGIN"),
+	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_ACIN_REMOVAL, "ACIN_REMOVAL"),
+	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_ACIN_OVER_V, "ACIN_OVER_V"),
+};
+
+static const struct resource axp192_usb_power_supply_resources[] = {
+	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
+	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
+	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_VBUS_VALID, "VBUS_VALID"),
+	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID"),
+};
+
 static const struct resource axp20x_ac_power_supply_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_PLUGIN, "ACIN_PLUGIN"),
 	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_REMOVAL, "ACIN_REMOVAL"),
@@ -245,6 +288,15 @@ static const struct regmap_config axp152_regmap_config = {
 	.cache_type	= REGCACHE_RBTREE,
 };
 
+static const struct regmap_config axp192_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.wr_table	= &axp192_writeable_table,
+	.volatile_table	= &axp192_volatile_table,
+	.max_register	= AXP20X_CC_CTRL,
+	.cache_type	= REGCACHE_RBTREE,
+};
+
 static const struct regmap_config axp20x_regmap_config = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
@@ -304,6 +356,42 @@ static const struct regmap_irq axp152_regmap_irqs[] = {
 	INIT_REGMAP_IRQ(AXP152, GPIO0_INPUT,		2, 0),
 };
 
+static const struct regmap_irq axp192_regmap_irqs[] = {
+	INIT_REGMAP_IRQ(AXP192, ACIN_OVER_V,		0, 7),
+	INIT_REGMAP_IRQ(AXP192, ACIN_PLUGIN,		0, 6),
+	INIT_REGMAP_IRQ(AXP192, ACIN_REMOVAL,		0, 5),
+	INIT_REGMAP_IRQ(AXP192, VBUS_OVER_V,		0, 4),
+	INIT_REGMAP_IRQ(AXP192, VBUS_PLUGIN,		0, 3),
+	INIT_REGMAP_IRQ(AXP192, VBUS_REMOVAL,		0, 2),
+	INIT_REGMAP_IRQ(AXP192, VBUS_V_LOW,		0, 1),
+	INIT_REGMAP_IRQ(AXP192, BATT_PLUGIN,		1, 7),
+	INIT_REGMAP_IRQ(AXP192, BATT_REMOVAL,	        1, 6),
+	INIT_REGMAP_IRQ(AXP192, BATT_ENT_ACT_MODE,	1, 5),
+	INIT_REGMAP_IRQ(AXP192, BATT_EXIT_ACT_MODE,	1, 4),
+	INIT_REGMAP_IRQ(AXP192, CHARG,		        1, 3),
+	INIT_REGMAP_IRQ(AXP192, CHARG_DONE,		1, 2),
+	INIT_REGMAP_IRQ(AXP192, BATT_TEMP_HIGH,	        1, 1),
+	INIT_REGMAP_IRQ(AXP192, BATT_TEMP_LOW,	        1, 0),
+	INIT_REGMAP_IRQ(AXP192, DIE_TEMP_HIGH,	        2, 7),
+	INIT_REGMAP_IRQ(AXP192, CHARG_I_LOW,		2, 6),
+	INIT_REGMAP_IRQ(AXP192, DCDC1_V_LONG,	        2, 5),
+	INIT_REGMAP_IRQ(AXP192, DCDC2_V_LONG,	        2, 4),
+	INIT_REGMAP_IRQ(AXP192, DCDC3_V_LONG,	        2, 3),
+	INIT_REGMAP_IRQ(AXP192, PEK_SHORT,		2, 1),
+	INIT_REGMAP_IRQ(AXP192, PEK_LONG,		2, 0),
+	INIT_REGMAP_IRQ(AXP192, N_OE_PWR_ON,		3, 7),
+	INIT_REGMAP_IRQ(AXP192, N_OE_PWR_OFF,	        3, 6),
+	INIT_REGMAP_IRQ(AXP192, VBUS_VALID,		3, 5),
+	INIT_REGMAP_IRQ(AXP192, VBUS_NOT_VALID,	        3, 4),
+	INIT_REGMAP_IRQ(AXP192, VBUS_SESS_VALID,	3, 3),
+	INIT_REGMAP_IRQ(AXP192, VBUS_SESS_END,	        3, 2),
+	INIT_REGMAP_IRQ(AXP192, LOW_PWR_LVL,	        3, 0),
+	INIT_REGMAP_IRQ(AXP192, TIMER,			4, 7),
+	INIT_REGMAP_IRQ(AXP192, GPIO2_INPUT,		4, 2),
+	INIT_REGMAP_IRQ(AXP192, GPIO1_INPUT,		4, 1),
+	INIT_REGMAP_IRQ(AXP192, GPIO0_INPUT,		4, 0),
+};
+
 static const struct regmap_irq axp20x_regmap_irqs[] = {
 	INIT_REGMAP_IRQ(AXP20X, ACIN_OVER_V,		0, 7),
 	INIT_REGMAP_IRQ(AXP20X, ACIN_PLUGIN,		0, 6),
@@ -514,6 +602,32 @@ static const struct regmap_irq_chip axp152_regmap_irq_chip = {
 	.num_regs		= 3,
 };
 
+static unsigned int axp192_get_irq_reg(struct regmap_irq_chip_data *data,
+				       unsigned int base, int index)
+{
+	/* linear mapping for IRQ1 to IRQ4 */
+	if (index < 4)
+		return base + index;
+
+	/* handle IRQ5 separately */
+	if (base == AXP192_IRQ1_EN)
+		return AXP192_IRQ5_EN;
+
+	return AXP192_IRQ5_STATE;
+}
+
+static const struct regmap_irq_chip axp192_regmap_irq_chip = {
+	.name			= "axp192_irq_chip",
+	.status_base		= AXP192_IRQ1_STATE,
+	.ack_base		= AXP192_IRQ1_STATE,
+	.unmask_base		= AXP192_IRQ1_EN,
+	.init_ack_masked	= true,
+	.irqs			= axp192_regmap_irqs,
+	.num_irqs		= ARRAY_SIZE(axp192_regmap_irqs),
+	.num_regs		= 5,
+	.get_irq_reg		= axp192_get_irq_reg,
+};
+
 static const struct regmap_irq_chip axp20x_regmap_irq_chip = {
 	.name			= "axp20x_irq_chip",
 	.status_base		= AXP20X_IRQ1_STATE,
@@ -588,6 +702,27 @@ static const struct regmap_irq_chip axp809_regmap_irq_chip = {
 	.num_regs		= 5,
 };
 
+static const struct mfd_cell axp192_cells[] = {
+	{
+		.name		= "axp192-adc",
+		.of_compatible	= "x-powers,axp192-adc",
+	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp192-battery-power-supply",
+	}, {
+		.name		= "axp20x-ac-power-supply",
+		.of_compatible	= "x-powers,axp202-ac-power-supply",
+		.num_resources	= ARRAY_SIZE(axp192_ac_power_supply_resources),
+		.resources	= axp192_ac_power_supply_resources,
+	}, {
+		.name		= "axp20x-usb-power-supply",
+		.of_compatible	= "x-powers,axp192-usb-power-supply",
+		.num_resources	= ARRAY_SIZE(axp192_usb_power_supply_resources),
+		.resources	= axp192_usb_power_supply_resources,
+	},
+	{	.name		= "axp20x-regulator" },
+};
+
 static const struct mfd_cell axp20x_cells[] = {
 	{
 		.name		= "axp20x-gpio",
@@ -865,6 +1000,12 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		axp20x->regmap_cfg = &axp152_regmap_config;
 		axp20x->regmap_irq_chip = &axp152_regmap_irq_chip;
 		break;
+	case AXP192_ID:
+		axp20x->nr_cells = ARRAY_SIZE(axp192_cells);
+		axp20x->cells = axp192_cells;
+		axp20x->regmap_cfg = &axp192_regmap_config;
+		axp20x->regmap_irq_chip = &axp192_regmap_irq_chip;
+		break;
 	case AXP202_ID:
 	case AXP209_ID:
 		axp20x->nr_cells = ARRAY_SIZE(axp20x_cells);
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 9ab0e2fca7ea..c9a9ee8ec246 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -12,6 +12,7 @@
 
 enum axp20x_variants {
 	AXP152_ID = 0,
+	AXP192_ID,
 	AXP202_ID,
 	AXP209_ID,
 	AXP221_ID,
@@ -24,6 +25,7 @@ enum axp20x_variants {
 	NR_AXP20X_VARIANTS,
 };
 
+#define AXP192_DATACACHE(m)		(0x06 + (m))
 #define AXP20X_DATACACHE(m)		(0x04 + (m))
 
 /* Power supply */
@@ -45,6 +47,13 @@ enum axp20x_variants {
 #define AXP152_DCDC_FREQ		0x37
 #define AXP152_DCDC_MODE		0x80
 
+#define AXP192_USB_OTG_STATUS		0x04
+#define AXP192_PWR_OUT_CTRL		0x12
+#define AXP192_DCDC2_V_OUT		0x23
+#define AXP192_DCDC1_V_OUT		0x26
+#define AXP192_DCDC3_V_OUT		0x27
+#define AXP192_LDO2_3_V_OUT		0x28
+
 #define AXP20X_PWR_INPUT_STATUS		0x00
 #define AXP20X_PWR_OP_MODE		0x01
 #define AXP20X_USB_OTG_STATUS		0x02
@@ -139,6 +148,17 @@ enum axp20x_variants {
 #define AXP152_IRQ2_STATE		0x49
 #define AXP152_IRQ3_STATE		0x4a
 
+#define AXP192_IRQ1_EN			0x40
+#define AXP192_IRQ2_EN			0x41
+#define AXP192_IRQ3_EN			0x42
+#define AXP192_IRQ4_EN			0x43
+#define AXP192_IRQ1_STATE		0x44
+#define AXP192_IRQ2_STATE		0x45
+#define AXP192_IRQ3_STATE		0x46
+#define AXP192_IRQ4_STATE		0x47
+#define AXP192_IRQ5_EN			0x4a
+#define AXP192_IRQ5_STATE		0x4d
+
 #define AXP20X_IRQ1_EN			0x40
 #define AXP20X_IRQ2_EN			0x41
 #define AXP20X_IRQ3_EN			0x42
@@ -153,6 +173,11 @@ enum axp20x_variants {
 #define AXP20X_IRQ6_STATE		0x4d
 
 /* ADC */
+#define AXP192_GPIO2_V_ADC_H		0x68
+#define AXP192_GPIO2_V_ADC_L		0x69
+#define AXP192_GPIO3_V_ADC_H		0x6a
+#define AXP192_GPIO3_V_ADC_L		0x6b
+
 #define AXP20X_ACIN_V_ADC_H		0x56
 #define AXP20X_ACIN_V_ADC_L		0x57
 #define AXP20X_ACIN_I_ADC_H		0x58
@@ -182,6 +207,8 @@ enum axp20x_variants {
 #define AXP20X_IPSOUT_V_HIGH_L		0x7f
 
 /* Power supply */
+#define AXP192_GPIO30_IN_RANGE		0x85
+
 #define AXP20X_DCDC_MODE		0x80
 #define AXP20X_ADC_EN1			0x82
 #define AXP20X_ADC_EN2			0x83
@@ -210,6 +237,16 @@ enum axp20x_variants {
 #define AXP152_PWM1_FREQ_Y		0x9c
 #define AXP152_PWM1_DUTY_CYCLE		0x9d
 
+#define AXP192_GPIO0_CTRL		0x90
+#define AXP192_LDO_IO0_V_OUT		0x91
+#define AXP192_GPIO1_CTRL		0x92
+#define AXP192_GPIO2_CTRL		0x93
+#define AXP192_GPIO2_0_STATE		0x94
+#define AXP192_GPIO4_3_CTRL		0x95
+#define AXP192_GPIO4_3_STATE		0x96
+#define AXP192_GPIO2_0_PULL		0x97
+#define AXP192_N_RSTO_CTRL		0x9e
+
 #define AXP20X_GPIO0_CTRL		0x90
 #define AXP20X_LDO5_V_OUT		0x91
 #define AXP20X_GPIO1_CTRL		0x92
@@ -287,6 +324,17 @@ enum axp20x_variants {
 #define AXP288_FG_TUNE5             0xed
 
 /* Regulators IDs */
+enum {
+	AXP192_DCDC1 = 0,
+	AXP192_DCDC2,
+	AXP192_DCDC3,
+	AXP192_LDO1,
+	AXP192_LDO2,
+	AXP192_LDO3,
+	AXP192_LDO_IO0,
+	AXP192_REG_ID_MAX
+};
+
 enum {
 	AXP20X_LDO1 = 0,
 	AXP20X_LDO2,
@@ -440,6 +488,42 @@ enum {
 	AXP152_IRQ_GPIO0_INPUT,
 };
 
+enum axp192_irqs {
+	AXP192_IRQ_ACIN_OVER_V = 1,
+	AXP192_IRQ_ACIN_PLUGIN,
+	AXP192_IRQ_ACIN_REMOVAL,
+	AXP192_IRQ_VBUS_OVER_V,
+	AXP192_IRQ_VBUS_PLUGIN,
+	AXP192_IRQ_VBUS_REMOVAL,
+	AXP192_IRQ_VBUS_V_LOW,
+	AXP192_IRQ_BATT_PLUGIN,
+	AXP192_IRQ_BATT_REMOVAL,
+	AXP192_IRQ_BATT_ENT_ACT_MODE,
+	AXP192_IRQ_BATT_EXIT_ACT_MODE,
+	AXP192_IRQ_CHARG,
+	AXP192_IRQ_CHARG_DONE,
+	AXP192_IRQ_BATT_TEMP_HIGH,
+	AXP192_IRQ_BATT_TEMP_LOW,
+	AXP192_IRQ_DIE_TEMP_HIGH,
+	AXP192_IRQ_CHARG_I_LOW,
+	AXP192_IRQ_DCDC1_V_LONG,
+	AXP192_IRQ_DCDC2_V_LONG,
+	AXP192_IRQ_DCDC3_V_LONG,
+	AXP192_IRQ_PEK_SHORT = 22,
+	AXP192_IRQ_PEK_LONG,
+	AXP192_IRQ_N_OE_PWR_ON,
+	AXP192_IRQ_N_OE_PWR_OFF,
+	AXP192_IRQ_VBUS_VALID,
+	AXP192_IRQ_VBUS_NOT_VALID,
+	AXP192_IRQ_VBUS_SESS_VALID,
+	AXP192_IRQ_VBUS_SESS_END,
+	AXP192_IRQ_LOW_PWR_LVL = 31,
+	AXP192_IRQ_TIMER,
+	AXP192_IRQ_GPIO2_INPUT = 37,
+	AXP192_IRQ_GPIO1_INPUT,
+	AXP192_IRQ_GPIO0_INPUT,
+};
+
 enum {
 	AXP20X_IRQ_ACIN_OVER_V = 1,
 	AXP20X_IRQ_ACIN_PLUGIN,
-- 
2.35.1


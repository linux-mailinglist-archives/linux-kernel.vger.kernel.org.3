Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26504563489
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiGANpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiGANpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:45:01 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EB522B32;
        Fri,  1 Jul 2022 06:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1656683088; bh=2s8nJyuQ+/Ud0yK9ExncnZIwC5tTDS0OFfRS0EBqJeA=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=XM6wZBy5y0+vd0/UTa/fsovRhRqDe6lDYue6gu3nPd+ZwNo2UOjylZ24TEBNMp8pl
         yLH86OvKehI35WpfDb/bQhQ4NhhcgJJfCYzxH0bV4Xr0Jwy/I1oY5ouWijysO5caf1
         NmR+tLOU9SBkbeoniDGKEBLgnuRufoZwtECaQq14=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.207]
        Fri,  1 Jul 2022 15:44:48 +0200 (CEST)
X-EA-Auth: y5rzmDNvsa5MtTpmFWR4BvF83W1ikCb58r57I32S2ChzgEgIp6xVkcDlsqhgDuiqzfjvsgdq7BZ+rLKeZWMK+tY++0l3vPKCKy9wD0EQADw=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v2 5/6] leds: is31fl319x: Move chipset-specific values in chipdef struct
Date:   Fri,  1 Jul 2022 15:44:12 +0200
Message-Id: <20220701134415.4017794-6-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220701134415.4017794-1-vincent.knecht@mailoo.org>
References: <20220701134415.4017794-1-vincent.knecht@mailoo.org>
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

Allow setting chips' specifics in chipdef struct by adding fields for:
- the reset register address
- a pointer to a regmap_config struct
- a pointer to a brightness_set function
- current default, min and max values
- a boolean to distinguish 319{0,1,3} and 319{6,9} chips
and use those fields in places where distinction has to be made.

The fields for 319{0,1,3} still point to 319{6,9} values.
No functional change.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 drivers/leds/leds-is31fl319x.c | 206 ++++++++++++++++++++-------------
 1 file changed, 123 insertions(+), 83 deletions(-)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index 1dd5c3d4ad74..eb8601a203a8 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -78,38 +78,56 @@ struct is31fl319x_chip {
 
 struct is31fl319x_chipdef {
 	int num_leds;
+	u8 reset_reg;
+	const struct regmap_config *is31fl319x_regmap_config;
+	int (*brightness_set)(struct led_classdev *cdev, enum led_brightness brightness);
+	u32 current_default;
+	u32 current_min;
+	u32 current_max;
+	bool is_3196or3199;
 };
 
-static const struct is31fl319x_chipdef is31fl3190_cdef = {
-	.num_leds = 1,
-};
-
-static const struct is31fl319x_chipdef is31fl3193_cdef = {
-	.num_leds = 3,
-};
+static bool is31fl319x_readable_reg(struct device *dev, unsigned int reg)
+{ /* we have no readable registers */
+	return false;
+}
 
-static const struct is31fl319x_chipdef is31fl3196_cdef = {
-	.num_leds = 6,
-};
+static bool is31fl3196_volatile_reg(struct device *dev, unsigned int reg)
+{ /* volatile registers are not cached */
+	switch (reg) {
+	case IS31FL3196_DATA_UPDATE:
+	case IS31FL3196_TIME_UPDATE:
+	case IS31FL3196_RESET:
+		return true; /* always write-through */
+	default:
+		return false;
+	}
+}
 
-static const struct is31fl319x_chipdef is31fl3199_cdef = {
-	.num_leds = 9,
+static const struct reg_default is31fl3196_reg_defaults[] = {
+	{ IS31FL3196_CONFIG1, 0x00},
+	{ IS31FL3196_CONFIG2, 0x00},
+	{ IS31FL3196_PWM(0), 0x00},
+	{ IS31FL3196_PWM(1), 0x00},
+	{ IS31FL3196_PWM(2), 0x00},
+	{ IS31FL3196_PWM(3), 0x00},
+	{ IS31FL3196_PWM(4), 0x00},
+	{ IS31FL3196_PWM(5), 0x00},
+	{ IS31FL3196_PWM(6), 0x00},
+	{ IS31FL3196_PWM(7), 0x00},
+	{ IS31FL3196_PWM(8), 0x00},
 };
 
-static const struct of_device_id of_is31fl319x_match[] = {
-	{ .compatible = "issi,is31fl3190", .data = &is31fl3190_cdef, },
-	{ .compatible = "issi,is31fl3191", .data = &is31fl3190_cdef, },
-	{ .compatible = "issi,is31fl3193", .data = &is31fl3193_cdef, },
-	{ .compatible = "issi,is31fl3196", .data = &is31fl3196_cdef, },
-	{ .compatible = "issi,is31fl3199", .data = &is31fl3199_cdef, },
-	{ .compatible = "si-en,sn3190",    .data = &is31fl3190_cdef, },
-	{ .compatible = "si-en,sn3191",    .data = &is31fl3190_cdef, },
-	{ .compatible = "si-en,sn3193",    .data = &is31fl3193_cdef, },
-	{ .compatible = "si-en,sn3196",    .data = &is31fl3196_cdef, },
-	{ .compatible = "si-en,sn3199",    .data = &is31fl3199_cdef, },
-	{ }
+static struct regmap_config is31fl3196_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = IS31FL3196_REG_CNT,
+	.cache_type = REGCACHE_FLAT,
+	.readable_reg = is31fl319x_readable_reg,
+	.volatile_reg = is31fl3196_volatile_reg,
+	.reg_defaults = is31fl3196_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(is31fl3196_reg_defaults),
 };
-MODULE_DEVICE_TABLE(of, of_is31fl319x_match);
 
 static int is31fl3196_brightness_set(struct led_classdev *cdev,
 				     enum led_brightness brightness)
@@ -175,9 +193,69 @@ static int is31fl3196_brightness_set(struct led_classdev *cdev,
 	return ret;
 }
 
+static const struct is31fl319x_chipdef is31fl3190_cdef = {
+	.num_leds = 1,
+	.reset_reg = IS31FL3196_RESET,
+	.is31fl319x_regmap_config = &is31fl3196_regmap_config,
+	.brightness_set = is31fl3196_brightness_set,
+	.current_default = IS31FL3196_CURRENT_DEFAULT,
+	.current_min = IS31FL3196_CURRENT_MIN,
+	.current_max = IS31FL3196_CURRENT_MAX,
+	.is_3196or3199 = true,
+};
+
+static const struct is31fl319x_chipdef is31fl3193_cdef = {
+	.num_leds = 3,
+	.reset_reg = IS31FL3196_RESET,
+	.is31fl319x_regmap_config = &is31fl3196_regmap_config,
+	.brightness_set = is31fl3196_brightness_set,
+	.current_default = IS31FL3196_CURRENT_DEFAULT,
+	.current_min = IS31FL3196_CURRENT_MIN,
+	.current_max = IS31FL3196_CURRENT_MAX,
+	.is_3196or3199 = true,
+};
+
+static const struct is31fl319x_chipdef is31fl3196_cdef = {
+	.num_leds = 6,
+	.reset_reg = IS31FL3196_RESET,
+	.is31fl319x_regmap_config = &is31fl3196_regmap_config,
+	.brightness_set = is31fl3196_brightness_set,
+	.current_default = IS31FL3196_CURRENT_DEFAULT,
+	.current_min = IS31FL3196_CURRENT_MIN,
+	.current_max = IS31FL3196_CURRENT_MAX,
+	.is_3196or3199 = true,
+};
+
+static const struct is31fl319x_chipdef is31fl3199_cdef = {
+	.num_leds = 9,
+	.reset_reg = IS31FL3196_RESET,
+	.is31fl319x_regmap_config = &is31fl3196_regmap_config,
+	.brightness_set = is31fl3196_brightness_set,
+	.current_default = IS31FL3196_CURRENT_DEFAULT,
+	.current_min = IS31FL3196_CURRENT_MIN,
+	.current_max = IS31FL3196_CURRENT_MAX,
+	.is_3196or3199 = true,
+};
+
+static const struct of_device_id of_is31fl319x_match[] = {
+	{ .compatible = "issi,is31fl3190", .data = &is31fl3190_cdef, },
+	{ .compatible = "issi,is31fl3191", .data = &is31fl3190_cdef, },
+	{ .compatible = "issi,is31fl3193", .data = &is31fl3193_cdef, },
+	{ .compatible = "issi,is31fl3196", .data = &is31fl3196_cdef, },
+	{ .compatible = "issi,is31fl3199", .data = &is31fl3199_cdef, },
+	{ .compatible = "si-en,sn3190",    .data = &is31fl3190_cdef, },
+	{ .compatible = "si-en,sn3191",    .data = &is31fl3190_cdef, },
+	{ .compatible = "si-en,sn3193",    .data = &is31fl3193_cdef, },
+	{ .compatible = "si-en,sn3196",    .data = &is31fl3196_cdef, },
+	{ .compatible = "si-en,sn3199",    .data = &is31fl3199_cdef, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, of_is31fl319x_match);
+
 static int is31fl319x_parse_child_dt(const struct device *dev,
 				     const struct device_node *child,
-				     struct is31fl319x_led *led)
+				     struct is31fl319x_led *led,
+				     struct is31fl319x_chip *is31)
 {
 	struct led_classdev *cdev = &led->cdev;
 	int ret;
@@ -190,14 +268,14 @@ static int is31fl319x_parse_child_dt(const struct device *dev,
 	if (ret < 0 && ret != -EINVAL) /* is optional */
 		return ret;
 
-	led->max_microamp = IS31FL3196_CURRENT_DEFAULT;
+	led->max_microamp = is31->cdef->current_default;
 	ret = of_property_read_u32(child, "led-max-microamp",
 				   &led->max_microamp);
 	if (!ret) {
-		if (led->max_microamp < IS31FL3196_CURRENT_MIN)
+		if (led->max_microamp < is31->cdef->current_min)
 			return -EINVAL;	/* not supported */
 		led->max_microamp = min(led->max_microamp,
-					  IS31FL3196_CURRENT_MAX);
+					is31->cdef->current_max);
 	}
 
 	return 0;
@@ -258,7 +336,7 @@ static int is31fl319x_parse_dt(struct device *dev,
 			goto put_child_node;
 		}
 
-		ret = is31fl319x_parse_child_dt(dev, child, led);
+		ret = is31fl319x_parse_child_dt(dev, child, led, is31);
 		if (ret) {
 			dev_err(dev, "led %u DT parsing failed\n", reg);
 			goto put_child_node;
@@ -268,10 +346,12 @@ static int is31fl319x_parse_dt(struct device *dev,
 	}
 
 	is31->audio_gain_db = 0;
-	ret = of_property_read_u32(np, "audio-gain-db", &is31->audio_gain_db);
-	if (!ret)
-		is31->audio_gain_db = min(is31->audio_gain_db,
-					  IS31FL3196_AUDIO_GAIN_DB_MAX);
+	if (is31->cdef->is_3196or3199) {
+		ret = of_property_read_u32(np, "audio-gain-db", &is31->audio_gain_db);
+		if (!ret)
+			is31->audio_gain_db = min(is31->audio_gain_db,
+						  IS31FL3196_AUDIO_GAIN_DB_MAX);
+	}
 
 	return 0;
 
@@ -280,48 +360,6 @@ static int is31fl319x_parse_dt(struct device *dev,
 	return ret;
 }
 
-static bool is31fl319x_readable_reg(struct device *dev, unsigned int reg)
-{ /* we have no readable registers */
-	return false;
-}
-
-static bool is31fl3196_volatile_reg(struct device *dev, unsigned int reg)
-{ /* volatile registers are not cached */
-	switch (reg) {
-	case IS31FL3196_DATA_UPDATE:
-	case IS31FL3196_TIME_UPDATE:
-	case IS31FL3196_RESET:
-		return true; /* always write-through */
-	default:
-		return false;
-	}
-}
-
-static const struct reg_default is31fl3196_reg_defaults[] = {
-	{ IS31FL3196_CONFIG1, 0x00},
-	{ IS31FL3196_CONFIG2, 0x00},
-	{ IS31FL3196_PWM(0), 0x00},
-	{ IS31FL3196_PWM(1), 0x00},
-	{ IS31FL3196_PWM(2), 0x00},
-	{ IS31FL3196_PWM(3), 0x00},
-	{ IS31FL3196_PWM(4), 0x00},
-	{ IS31FL3196_PWM(5), 0x00},
-	{ IS31FL3196_PWM(6), 0x00},
-	{ IS31FL3196_PWM(7), 0x00},
-	{ IS31FL3196_PWM(8), 0x00},
-};
-
-static struct regmap_config is31fl3196_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = IS31FL3196_REG_CNT,
-	.cache_type = REGCACHE_FLAT,
-	.readable_reg = is31fl319x_readable_reg,
-	.volatile_reg = is31fl3196_volatile_reg,
-	.reg_defaults = is31fl3196_reg_defaults,
-	.num_reg_defaults = ARRAY_SIZE(is31fl3196_reg_defaults),
-};
-
 static inline int is31fl3196_microamp_to_cs(struct device *dev, u32 microamp)
 { /* round down to nearest supported value (range check done by caller) */
 	u32 step = microamp / IS31FL3196_CURRENT_STEP;
@@ -343,7 +381,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	int err;
 	int i = 0;
-	u32 aggregated_led_microamp = IS31FL3196_CURRENT_MAX;
+	u32 aggregated_led_microamp;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -EIO;
@@ -365,7 +403,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 	}
 
 	is31->client = client;
-	is31->regmap = devm_regmap_init_i2c(client, &is31fl3196_regmap_config);
+	is31->regmap = devm_regmap_init_i2c(client, is31->cdef->is31fl319x_regmap_config);
 	if (IS_ERR(is31->regmap)) {
 		dev_err(&client->dev, "failed to allocate register map\n");
 		err = PTR_ERR(is31->regmap);
@@ -375,7 +413,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, is31);
 
 	/* check for write-reply from chip (we can't read any registers) */
-	err = regmap_write(is31->regmap, IS31FL3196_RESET, 0x00);
+	err = regmap_write(is31->regmap, is31->cdef->reset_reg, 0x00);
 	if (err < 0) {
 		dev_err(&client->dev, "no response from chip write: err = %d\n",
 			err);
@@ -388,14 +426,16 @@ static int is31fl319x_probe(struct i2c_client *client,
 	 * But the chip does not allow to limit individual LEDs.
 	 * So we take minimum from all subnodes for safety of hardware.
 	 */
+	aggregated_led_microamp = is31->cdef->current_max;
 	for (i = 0; i < is31->cdef->num_leds; i++)
 		if (is31->leds[i].configured &&
 		    is31->leds[i].max_microamp < aggregated_led_microamp)
 			aggregated_led_microamp = is31->leds[i].max_microamp;
 
-	regmap_write(is31->regmap, IS31FL3196_CONFIG2,
-		     is31fl3196_microamp_to_cs(dev, aggregated_led_microamp) |
-		     is31fl3196_db_to_gain(is31->audio_gain_db));
+	if (is31->cdef->is_3196or3199)
+		regmap_write(is31->regmap, IS31FL3196_CONFIG2,
+			     is31fl3196_microamp_to_cs(dev, aggregated_led_microamp) |
+			     is31fl3196_db_to_gain(is31->audio_gain_db));
 
 	for (i = 0; i < is31->cdef->num_leds; i++) {
 		struct is31fl319x_led *led = &is31->leds[i];
@@ -404,7 +444,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 			continue;
 
 		led->chip = is31;
-		led->cdev.brightness_set_blocking = is31fl3196_brightness_set;
+		led->cdev.brightness_set_blocking = is31->cdef->brightness_set;
 
 		err = devm_led_classdev_register(&client->dev, &led->cdev);
 		if (err < 0)
-- 
2.35.3




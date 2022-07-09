Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F0956C884
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiGIJsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGIJrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:47:31 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF6767CAB;
        Sat,  9 Jul 2022 02:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1657360031; bh=LpEX2A+MFyDHACQMGbFUVipiSwhL1LxI/7Jun0xXolI=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=ZuNBMYB+5G49hziWlANCCuHSgaLTdkN2bAKSL43xMkxgdQlAUuDZL1Hq74X9YNEjD
         YSWy87oq0jefmVfe1v6dz3Da/vcEvT/4kOlxJk0cHAnwhD9oYH18fqkHL96FbPAUOJ
         BhM5Ui+42WjxW57dLjWjfpGQC2PyfZS0F6GKYzWE=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.207]
        Sat,  9 Jul 2022 11:47:11 +0200 (CEST)
X-EA-Auth: j7ZkyIhfSqMk93/uJ+7w3OlbMbm9vNFqWgKMCL1fn7+cdjb4L55GTJllYYVV6LrkoZ4tSBJtRNnDLf2rESUahs07rc3kQMFUIZQzr9A4rpE=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        hns@goldelico.com
Subject: [PATCH v4 5/7] leds: is31fl319x: Move chipset-specific values in chipdef struct
Date:   Sat,  9 Jul 2022 11:46:38 +0200
Message-Id: <20220709094642.4078222-6-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220709094642.4078222-1-vincent.knecht@mailoo.org>
References: <20220709094642.4078222-1-vincent.knecht@mailoo.org>
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
v4:
- Fix non standard place for comments
---
 drivers/leds/leds-is31fl319x.c | 208 ++++++++++++++++++++-------------
 1 file changed, 125 insertions(+), 83 deletions(-)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index 672b0e9e1d85..fe0cb68b583b 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -78,38 +78,58 @@ struct is31fl319x_chip {
 
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
+{
+	/* we have no readable registers */
+	return false;
+}
 
-static const struct is31fl319x_chipdef is31fl3196_cdef = {
-	.num_leds = 6,
-};
+static bool is31fl3196_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/* volatile registers are not cached */
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
+	{ IS31FL3196_CONFIG1, 0x00 },
+	{ IS31FL3196_CONFIG2, 0x00 },
+	{ IS31FL3196_PWM(0), 0x00 },
+	{ IS31FL3196_PWM(1), 0x00 },
+	{ IS31FL3196_PWM(2), 0x00 },
+	{ IS31FL3196_PWM(3), 0x00 },
+	{ IS31FL3196_PWM(4), 0x00 },
+	{ IS31FL3196_PWM(5), 0x00 },
+	{ IS31FL3196_PWM(6), 0x00 },
+	{ IS31FL3196_PWM(7), 0x00 },
+	{ IS31FL3196_PWM(8), 0x00 },
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
@@ -175,9 +195,69 @@ static int is31fl3196_brightness_set(struct led_classdev *cdev,
 	return ret;
 }
 
+static const struct is31fl319x_chipdef is31fl3190_cdef = {
+	.num_leds = 1,
+	.reset_reg = IS31FL3196_RESET,
+	.is31fl319x_regmap_config = &is31fl3196_regmap_config,
+	.brightness_set = is31fl3196_brightness_set,
+	.current_default = IS31FL3196_CURRENT_uA_DEFAULT,
+	.current_min = IS31FL3196_CURRENT_uA_MIN,
+	.current_max = IS31FL3196_CURRENT_uA_MAX,
+	.is_3196or3199 = true,
+};
+
+static const struct is31fl319x_chipdef is31fl3193_cdef = {
+	.num_leds = 3,
+	.reset_reg = IS31FL3196_RESET,
+	.is31fl319x_regmap_config = &is31fl3196_regmap_config,
+	.brightness_set = is31fl3196_brightness_set,
+	.current_default = IS31FL3196_CURRENT_uA_DEFAULT,
+	.current_min = IS31FL3196_CURRENT_uA_MIN,
+	.current_max = IS31FL3196_CURRENT_uA_MAX,
+	.is_3196or3199 = true,
+};
+
+static const struct is31fl319x_chipdef is31fl3196_cdef = {
+	.num_leds = 6,
+	.reset_reg = IS31FL3196_RESET,
+	.is31fl319x_regmap_config = &is31fl3196_regmap_config,
+	.brightness_set = is31fl3196_brightness_set,
+	.current_default = IS31FL3196_CURRENT_uA_DEFAULT,
+	.current_min = IS31FL3196_CURRENT_uA_MIN,
+	.current_max = IS31FL3196_CURRENT_uA_MAX,
+	.is_3196or3199 = true,
+};
+
+static const struct is31fl319x_chipdef is31fl3199_cdef = {
+	.num_leds = 9,
+	.reset_reg = IS31FL3196_RESET,
+	.is31fl319x_regmap_config = &is31fl3196_regmap_config,
+	.brightness_set = is31fl3196_brightness_set,
+	.current_default = IS31FL3196_CURRENT_uA_DEFAULT,
+	.current_min = IS31FL3196_CURRENT_uA_MIN,
+	.current_max = IS31FL3196_CURRENT_uA_MAX,
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
@@ -190,14 +270,14 @@ static int is31fl319x_parse_child_dt(const struct device *dev,
 	if (ret < 0 && ret != -EINVAL) /* is optional */
 		return ret;
 
-	led->max_microamp = IS31FL3196_CURRENT_uA_DEFAULT;
+	led->max_microamp = is31->cdef->current_default;
 	ret = of_property_read_u32(child, "led-max-microamp",
 				   &led->max_microamp);
 	if (!ret) {
-		if (led->max_microamp < IS31FL3196_CURRENT_uA_MIN)
+		if (led->max_microamp < is31->cdef->current_min)
 			return -EINVAL;	/* not supported */
 		led->max_microamp = min(led->max_microamp,
-					  IS31FL3196_CURRENT_uA_MAX);
+					is31->cdef->current_max);
 	}
 
 	return 0;
@@ -258,7 +338,7 @@ static int is31fl319x_parse_dt(struct device *dev,
 			goto put_child_node;
 		}
 
-		ret = is31fl319x_parse_child_dt(dev, child, led);
+		ret = is31fl319x_parse_child_dt(dev, child, led, is31);
 		if (ret) {
 			dev_err(dev, "led %u DT parsing failed\n", reg);
 			goto put_child_node;
@@ -268,10 +348,12 @@ static int is31fl319x_parse_dt(struct device *dev,
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
 
@@ -280,48 +362,6 @@ static int is31fl319x_parse_dt(struct device *dev,
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
-	{ IS31FL3196_CONFIG1, 0x00 },
-	{ IS31FL3196_CONFIG2, 0x00 },
-	{ IS31FL3196_PWM(0), 0x00 },
-	{ IS31FL3196_PWM(1), 0x00 },
-	{ IS31FL3196_PWM(2), 0x00 },
-	{ IS31FL3196_PWM(3), 0x00 },
-	{ IS31FL3196_PWM(4), 0x00 },
-	{ IS31FL3196_PWM(5), 0x00 },
-	{ IS31FL3196_PWM(6), 0x00 },
-	{ IS31FL3196_PWM(7), 0x00 },
-	{ IS31FL3196_PWM(8), 0x00 },
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
 	u32 step = microamp / IS31FL3196_CURRENT_uA_STEP;
@@ -343,7 +383,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	int err;
 	int i = 0;
-	u32 aggregated_led_microamp = IS31FL3196_CURRENT_uA_MAX;
+	u32 aggregated_led_microamp;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -EIO;
@@ -365,7 +405,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 	}
 
 	is31->client = client;
-	is31->regmap = devm_regmap_init_i2c(client, &is31fl3196_regmap_config);
+	is31->regmap = devm_regmap_init_i2c(client, is31->cdef->is31fl319x_regmap_config);
 	if (IS_ERR(is31->regmap)) {
 		dev_err(&client->dev, "failed to allocate register map\n");
 		err = PTR_ERR(is31->regmap);
@@ -375,7 +415,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, is31);
 
 	/* check for write-reply from chip (we can't read any registers) */
-	err = regmap_write(is31->regmap, IS31FL3196_RESET, 0x00);
+	err = regmap_write(is31->regmap, is31->cdef->reset_reg, 0x00);
 	if (err < 0) {
 		dev_err(&client->dev, "no response from chip write: err = %d\n",
 			err);
@@ -388,14 +428,16 @@ static int is31fl319x_probe(struct i2c_client *client,
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
@@ -404,7 +446,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 			continue;
 
 		led->chip = is31;
-		led->cdev.brightness_set_blocking = is31fl3196_brightness_set;
+		led->cdev.brightness_set_blocking = is31->cdef->brightness_set;
 
 		err = devm_led_classdev_register(&client->dev, &led->cdev);
 		if (err < 0)
-- 
2.35.3




Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08D556C881
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiGIJsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGIJr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:47:27 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7B866BA8;
        Sat,  9 Jul 2022 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1657360028; bh=pLcUMgv/dXKmKRrmwVdSVuZEeAXknvxXhBkD5ccNHBs=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=kD7oaT0dSqLof4/zuGK8WMRZWTiypwKUio676Lj1s/VjTVV/xEC/uH4KMfL8XgZNk
         fyW3j8ZKanOM8t86ZSchp2ehUuBcq22vZ1/Kh+KLAIDjfkXr/qrM0MQj/0ZdX6254B
         gmRYQThde93wBElwLYH8qlSjEwoluF+cV+QGrkwQ=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.207]
        Sat,  9 Jul 2022 11:47:08 +0200 (CEST)
X-EA-Auth: 2j4qNF0WGiLsGZimLTWIQs78Ug5NAewu7w28ZeVvjSthJCq4t3x9yRKIE6MtRN3U1rPwSKjDKeX7BKYod0No9+IwzzypwnCD8AzXZGsPTr8=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        hns@goldelico.com
Subject: [PATCH v4 4/7] leds: is31fl319x: Use non-wildcard names for vars, structs and defines
Date:   Sat,  9 Jul 2022 11:46:37 +0200
Message-Id: <20220709094642.4078222-5-vincent.knecht@mailoo.org>
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

In order to add real support for is31fl3190, is31fl3191 and is31fl3193,
rename variant-dependent elements to not use 319X where needed.

3190 suffix is used for is31fl3190, is31fl3191 and is31fl3193 circuits.
3196 suffix is used for is31fl3196 and is31fl3199.

Those two groups have different register maps, current settings and even
a different interpretation of the software shutdown bit:
https://lumissil.com/assets/pdf/core/IS31FL3190_DS.pdf
https://lumissil.com/assets/pdf/core/IS31FL3191_DS.pdf
https://lumissil.com/assets/pdf/core/IS31FL3193_DS.pdf
https://lumissil.com/assets/pdf/core/IS31FL3196_DS.pdf
https://lumissil.com/assets/pdf/core/IS31FL3199_DS.pdf

Rename variables, structures and defines in preparation of the splitting.
No functional nor behaviour change.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
v4:
- Reinstate u32 cast for IS31FL319X_AUDIO_GAIN_DB_MAX
  to silence a warning wrt. min() macro
- Fix missing space before } in is31fl3196_reg_defaults

v3:
- rename IS31FL3196_BREATH_MASK to IS31FL3196_BREATH_MARK
  since it refers to "breathing mark" function, not to a bitmask
- use GENMASK for IS31FL3196_CONFIG2_CS_MASK (Andy)
- get rid of u32 castings in defines (Andy)
- add _uA_ in IS31FL3196_CURRENT defines to denote the unit (Andy)
- fix stuctures typo in commit message (Andy)
---
 drivers/leds/leds-is31fl319x.c | 142 ++++++++++++++++-----------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index 0db5d4988131..672b0e9e1d85 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -21,39 +21,39 @@
 
 /* register numbers */
 #define IS31FL319X_SHUTDOWN		0x00
-#define IS31FL319X_CTRL1		0x01
-#define IS31FL319X_CTRL2		0x02
-#define IS31FL319X_CONFIG1		0x03
-#define IS31FL319X_CONFIG2		0x04
-#define IS31FL319X_RAMP_MODE		0x05
-#define IS31FL319X_BREATH_MASK		0x06
-#define IS31FL319X_PWM(channel)		(0x07 + channel)
-#define IS31FL319X_DATA_UPDATE		0x10
-#define IS31FL319X_T0(channel)		(0x11 + channel)
-#define IS31FL319X_T123_1		0x1a
-#define IS31FL319X_T123_2		0x1b
-#define IS31FL319X_T123_3		0x1c
-#define IS31FL319X_T4(channel)		(0x1d + channel)
-#define IS31FL319X_TIME_UPDATE		0x26
-#define IS31FL319X_RESET		0xff
-
-#define IS31FL319X_REG_CNT		(IS31FL319X_RESET + 1)
+#define IS31FL3196_CTRL1		0x01
+#define IS31FL3196_CTRL2		0x02
+#define IS31FL3196_CONFIG1		0x03
+#define IS31FL3196_CONFIG2		0x04
+#define IS31FL3196_RAMP_MODE		0x05
+#define IS31FL3196_BREATH_MARK		0x06
+#define IS31FL3196_PWM(channel)		(0x07 + channel)
+#define IS31FL3196_DATA_UPDATE		0x10
+#define IS31FL3196_T0(channel)		(0x11 + channel)
+#define IS31FL3196_T123_1		0x1a
+#define IS31FL3196_T123_2		0x1b
+#define IS31FL3196_T123_3		0x1c
+#define IS31FL3196_T4(channel)		(0x1d + channel)
+#define IS31FL3196_TIME_UPDATE		0x26
+#define IS31FL3196_RESET		0xff
+
+#define IS31FL3196_REG_CNT		(IS31FL3196_RESET + 1)
 
 #define IS31FL319X_MAX_LEDS		9
 
 /* CS (Current Setting) in CONFIG2 register */
-#define IS31FL319X_CONFIG2_CS_SHIFT	4
-#define IS31FL319X_CONFIG2_CS_MASK	0x7
-#define IS31FL319X_CONFIG2_CS_STEP_REF	12
+#define IS31FL3196_CONFIG2_CS_SHIFT	4
+#define IS31FL3196_CONFIG2_CS_MASK	GENMASK(2, 0)
+#define IS31FL3196_CONFIG2_CS_STEP_REF	12
 
-#define IS31FL319X_CURRENT_MIN		((u32)5000)
-#define IS31FL319X_CURRENT_MAX		((u32)40000)
-#define IS31FL319X_CURRENT_STEP		((u32)5000)
-#define IS31FL319X_CURRENT_DEFAULT	((u32)20000)
+#define IS31FL3196_CURRENT_uA_MIN	5000
+#define IS31FL3196_CURRENT_uA_MAX	40000
+#define IS31FL3196_CURRENT_uA_STEP	5000
+#define IS31FL3196_CURRENT_uA_DEFAULT	20000
 
 /* Audio gain in CONFIG2 register */
-#define IS31FL319X_AUDIO_GAIN_DB_MAX	((u32)21)
-#define IS31FL319X_AUDIO_GAIN_DB_STEP	((u32)3)
+#define IS31FL3196_AUDIO_GAIN_DB_MAX	((u32)21)
+#define IS31FL3196_AUDIO_GAIN_DB_STEP	3
 
 /*
  * regmap is used as a cache of chip's register space,
@@ -111,7 +111,7 @@ static const struct of_device_id of_is31fl319x_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_is31fl319x_match);
 
-static int is31fl319x_brightness_set(struct led_classdev *cdev,
+static int is31fl3196_brightness_set(struct led_classdev *cdev,
 				     enum led_brightness brightness)
 {
 	struct is31fl319x_led *led = container_of(cdev, struct is31fl319x_led,
@@ -127,7 +127,7 @@ static int is31fl319x_brightness_set(struct led_classdev *cdev,
 	mutex_lock(&is31->lock);
 
 	/* update PWM register */
-	ret = regmap_write(is31->regmap, IS31FL319X_PWM(chan), brightness);
+	ret = regmap_write(is31->regmap, IS31FL3196_PWM(chan), brightness);
 	if (ret < 0)
 		goto out;
 
@@ -141,7 +141,7 @@ static int is31fl319x_brightness_set(struct led_classdev *cdev,
 		 * the current setting, we read from the regmap cache
 		 */
 
-		ret = regmap_read(is31->regmap, IS31FL319X_PWM(i), &pwm_value);
+		ret = regmap_read(is31->regmap, IS31FL3196_PWM(i), &pwm_value);
 		dev_dbg(&is31->client->dev, "%s read %d: ret=%d: %d\n",
 			__func__, i, ret, pwm_value);
 		on = ret >= 0 && pwm_value > LED_OFF;
@@ -157,10 +157,10 @@ static int is31fl319x_brightness_set(struct led_classdev *cdev,
 	if (ctrl1 > 0 || ctrl2 > 0) {
 		dev_dbg(&is31->client->dev, "power up %02x %02x\n",
 			ctrl1, ctrl2);
-		regmap_write(is31->regmap, IS31FL319X_CTRL1, ctrl1);
-		regmap_write(is31->regmap, IS31FL319X_CTRL2, ctrl2);
+		regmap_write(is31->regmap, IS31FL3196_CTRL1, ctrl1);
+		regmap_write(is31->regmap, IS31FL3196_CTRL2, ctrl2);
 		/* update PWMs */
-		regmap_write(is31->regmap, IS31FL319X_DATA_UPDATE, 0x00);
+		regmap_write(is31->regmap, IS31FL3196_DATA_UPDATE, 0x00);
 		/* enable chip from shut down */
 		ret = regmap_write(is31->regmap, IS31FL319X_SHUTDOWN, 0x01);
 	} else {
@@ -190,14 +190,14 @@ static int is31fl319x_parse_child_dt(const struct device *dev,
 	if (ret < 0 && ret != -EINVAL) /* is optional */
 		return ret;
 
-	led->max_microamp = IS31FL319X_CURRENT_DEFAULT;
+	led->max_microamp = IS31FL3196_CURRENT_uA_DEFAULT;
 	ret = of_property_read_u32(child, "led-max-microamp",
 				   &led->max_microamp);
 	if (!ret) {
-		if (led->max_microamp < IS31FL319X_CURRENT_MIN)
+		if (led->max_microamp < IS31FL3196_CURRENT_uA_MIN)
 			return -EINVAL;	/* not supported */
 		led->max_microamp = min(led->max_microamp,
-					  IS31FL319X_CURRENT_MAX);
+					  IS31FL3196_CURRENT_uA_MAX);
 	}
 
 	return 0;
@@ -271,7 +271,7 @@ static int is31fl319x_parse_dt(struct device *dev,
 	ret = of_property_read_u32(np, "audio-gain-db", &is31->audio_gain_db);
 	if (!ret)
 		is31->audio_gain_db = min(is31->audio_gain_db,
-					  IS31FL319X_AUDIO_GAIN_DB_MAX);
+					  IS31FL3196_AUDIO_GAIN_DB_MAX);
 
 	return 0;
 
@@ -285,55 +285,55 @@ static bool is31fl319x_readable_reg(struct device *dev, unsigned int reg)
 	return false;
 }
 
-static bool is31fl319x_volatile_reg(struct device *dev, unsigned int reg)
+static bool is31fl3196_volatile_reg(struct device *dev, unsigned int reg)
 { /* volatile registers are not cached */
 	switch (reg) {
-	case IS31FL319X_DATA_UPDATE:
-	case IS31FL319X_TIME_UPDATE:
-	case IS31FL319X_RESET:
+	case IS31FL3196_DATA_UPDATE:
+	case IS31FL3196_TIME_UPDATE:
+	case IS31FL3196_RESET:
 		return true; /* always write-through */
 	default:
 		return false;
 	}
 }
 
-static const struct reg_default is31fl319x_reg_defaults[] = {
-	{ IS31FL319X_CONFIG1, 0x00},
-	{ IS31FL319X_CONFIG2, 0x00},
-	{ IS31FL319X_PWM(0), 0x00},
-	{ IS31FL319X_PWM(1), 0x00},
-	{ IS31FL319X_PWM(2), 0x00},
-	{ IS31FL319X_PWM(3), 0x00},
-	{ IS31FL319X_PWM(4), 0x00},
-	{ IS31FL319X_PWM(5), 0x00},
-	{ IS31FL319X_PWM(6), 0x00},
-	{ IS31FL319X_PWM(7), 0x00},
-	{ IS31FL319X_PWM(8), 0x00},
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
 
-static struct regmap_config regmap_config = {
+static struct regmap_config is31fl3196_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.max_register = IS31FL319X_REG_CNT,
+	.max_register = IS31FL3196_REG_CNT,
 	.cache_type = REGCACHE_FLAT,
 	.readable_reg = is31fl319x_readable_reg,
-	.volatile_reg = is31fl319x_volatile_reg,
-	.reg_defaults = is31fl319x_reg_defaults,
-	.num_reg_defaults = ARRAY_SIZE(is31fl319x_reg_defaults),
+	.volatile_reg = is31fl3196_volatile_reg,
+	.reg_defaults = is31fl3196_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(is31fl3196_reg_defaults),
 };
 
-static inline int is31fl319x_microamp_to_cs(struct device *dev, u32 microamp)
+static inline int is31fl3196_microamp_to_cs(struct device *dev, u32 microamp)
 { /* round down to nearest supported value (range check done by caller) */
-	u32 step = microamp / IS31FL319X_CURRENT_STEP;
+	u32 step = microamp / IS31FL3196_CURRENT_uA_STEP;
 
-	return ((IS31FL319X_CONFIG2_CS_STEP_REF - step) &
-		IS31FL319X_CONFIG2_CS_MASK) <<
-		IS31FL319X_CONFIG2_CS_SHIFT; /* CS encoding */
+	return ((IS31FL3196_CONFIG2_CS_STEP_REF - step) &
+		IS31FL3196_CONFIG2_CS_MASK) <<
+		IS31FL3196_CONFIG2_CS_SHIFT; /* CS encoding */
 }
 
-static inline int is31fl319x_db_to_gain(u32 dezibel)
+static inline int is31fl3196_db_to_gain(u32 dezibel)
 { /* round down to nearest supported value (range check done by caller) */
-	return dezibel / IS31FL319X_AUDIO_GAIN_DB_STEP;
+	return dezibel / IS31FL3196_AUDIO_GAIN_DB_STEP;
 }
 
 static int is31fl319x_probe(struct i2c_client *client,
@@ -343,7 +343,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	int err;
 	int i = 0;
-	u32 aggregated_led_microamp = IS31FL319X_CURRENT_MAX;
+	u32 aggregated_led_microamp = IS31FL3196_CURRENT_uA_MAX;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -EIO;
@@ -365,7 +365,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 	}
 
 	is31->client = client;
-	is31->regmap = devm_regmap_init_i2c(client, &regmap_config);
+	is31->regmap = devm_regmap_init_i2c(client, &is31fl3196_regmap_config);
 	if (IS_ERR(is31->regmap)) {
 		dev_err(&client->dev, "failed to allocate register map\n");
 		err = PTR_ERR(is31->regmap);
@@ -375,7 +375,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, is31);
 
 	/* check for write-reply from chip (we can't read any registers) */
-	err = regmap_write(is31->regmap, IS31FL319X_RESET, 0x00);
+	err = regmap_write(is31->regmap, IS31FL3196_RESET, 0x00);
 	if (err < 0) {
 		dev_err(&client->dev, "no response from chip write: err = %d\n",
 			err);
@@ -393,9 +393,9 @@ static int is31fl319x_probe(struct i2c_client *client,
 		    is31->leds[i].max_microamp < aggregated_led_microamp)
 			aggregated_led_microamp = is31->leds[i].max_microamp;
 
-	regmap_write(is31->regmap, IS31FL319X_CONFIG2,
-		     is31fl319x_microamp_to_cs(dev, aggregated_led_microamp) |
-		     is31fl319x_db_to_gain(is31->audio_gain_db));
+	regmap_write(is31->regmap, IS31FL3196_CONFIG2,
+		     is31fl3196_microamp_to_cs(dev, aggregated_led_microamp) |
+		     is31fl3196_db_to_gain(is31->audio_gain_db));
 
 	for (i = 0; i < is31->cdef->num_leds; i++) {
 		struct is31fl319x_led *led = &is31->leds[i];
@@ -404,7 +404,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 			continue;
 
 		led->chip = is31;
-		led->cdev.brightness_set_blocking = is31fl319x_brightness_set;
+		led->cdev.brightness_set_blocking = is31fl3196_brightness_set;
 
 		err = devm_led_classdev_register(&client->dev, &led->cdev);
 		if (err < 0)
-- 
2.35.3




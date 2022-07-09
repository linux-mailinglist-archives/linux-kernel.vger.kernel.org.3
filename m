Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5943856C880
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiGIJsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiGIJra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:47:30 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C59266B95;
        Sat,  9 Jul 2022 02:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1657360036; bh=1+vh9VTFnt5gm/N3KxucKgiPLJLaNPtL9AV0RV0iAcY=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=U5SPGydGcZ5O3r2a0VjNarhmTMkPymTC2pVx4X0DeLV70ghTuaTqe2vfTw+CvJObK
         r+/0+j2LOrdSAIKa6KMlmeuYgDjovPye6pjnuu4aoCvhUzwT0OOXkwARkgGUJsXVpb
         +FXj9UBymu0lyNMRqOIYuS40jjNdISUnVW7AIDYQ=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.207]
        Sat,  9 Jul 2022 11:47:16 +0200 (CEST)
X-EA-Auth: 4lN7U8692EwOZ0xzqJMkQspYAzC9vXKGvNrsukW/G5pVEnFBJ6/EKLP0HG5DgYbql0ozLzEDHvJ77/fcEgxle+wMpzJibBkVje4nTeBA/JI=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        hns@goldelico.com
Subject: [PATCH v4 7/7] leds: is31fl319x: Cleanup formatting and dev_dbg calls
Date:   Sat,  9 Jul 2022 11:46:40 +0200
Message-Id: <20220709094642.4078222-8-vincent.knecht@mailoo.org>
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

Fix remaining non-standard place for comments.

Remove remaining dev_dbg after regmap_read in is31fl3196_brightness_set.

Remove __func__ in dev_dbg calls, instead adding "channel" string to
describe the first displayed value.

Change remaining container_of() call to be on one line,
as well as a few others.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 drivers/leds/leds-is31fl319x.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index 2314922bc009..056cf3bcffdc 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -198,7 +198,7 @@ static int is31fl3190_brightness_set(struct led_classdev *cdev,
 	int i;
 	u8 ctrl = 0;
 
-	dev_dbg(&is31->client->dev, "%s %d: %d\n", __func__, chan, brightness);
+	dev_dbg(&is31->client->dev, "channel %d: %d\n", chan, brightness);
 
 	mutex_lock(&is31->lock);
 
@@ -245,15 +245,14 @@ static int is31fl3190_brightness_set(struct led_classdev *cdev,
 static int is31fl3196_brightness_set(struct led_classdev *cdev,
 				     enum led_brightness brightness)
 {
-	struct is31fl319x_led *led = container_of(cdev, struct is31fl319x_led,
-						  cdev);
+	struct is31fl319x_led *led = container_of(cdev, struct is31fl319x_led, cdev);
 	struct is31fl319x_chip *is31 = led->chip;
 	int chan = led - is31->leds;
 	int ret;
 	int i;
 	u8 ctrl1 = 0, ctrl2 = 0;
 
-	dev_dbg(&is31->client->dev, "%s %d: %d\n", __func__, chan, brightness);
+	dev_dbg(&is31->client->dev, "channel %d: %d\n", chan, brightness);
 
 	mutex_lock(&is31->lock);
 
@@ -273,8 +272,6 @@ static int is31fl3196_brightness_set(struct led_classdev *cdev,
 		 */
 
 		ret = regmap_read(is31->regmap, IS31FL3196_PWM(i), &pwm_value);
-		dev_dbg(&is31->client->dev, "%s read %d: ret=%d: %d\n",
-			__func__, i, ret, pwm_value);
 		on = ret >= 0 && pwm_value > LED_OFF;
 
 		if (i < 3)
@@ -404,9 +401,7 @@ static int is31fl319x_parse_dt(struct device *dev,
 	if (!np)
 		return -ENODEV;
 
-	is31->shutdown_gpio = devm_gpiod_get_optional(dev,
-						"shutdown",
-						GPIOD_OUT_HIGH);
+	is31->shutdown_gpio = devm_gpiod_get_optional(dev, "shutdown", GPIOD_OUT_HIGH);
 	if (IS_ERR(is31->shutdown_gpio)) {
 		ret = PTR_ERR(is31->shutdown_gpio);
 		dev_err(dev, "Failed to get shutdown gpio: %d\n", ret);
@@ -493,7 +488,8 @@ static inline int is31fl3190_microamp_to_cs(struct device *dev, u32 microamp)
 }
 
 static inline int is31fl3196_microamp_to_cs(struct device *dev, u32 microamp)
-{ /* round down to nearest supported value (range check done by caller) */
+{
+	/* round down to nearest supported value (range check done by caller) */
 	u32 step = microamp / IS31FL3196_CURRENT_uA_STEP;
 
 	return ((IS31FL3196_CONFIG2_CS_STEP_REF - step) &
@@ -502,7 +498,8 @@ static inline int is31fl3196_microamp_to_cs(struct device *dev, u32 microamp)
 }
 
 static inline int is31fl3196_db_to_gain(u32 dezibel)
-{ /* round down to nearest supported value (range check done by caller) */
+{
+	/* round down to nearest supported value (range check done by caller) */
 	return dezibel / IS31FL3196_AUDIO_GAIN_DB_STEP;
 }
 
@@ -547,8 +544,7 @@ static int is31fl319x_probe(struct i2c_client *client,
 	/* check for write-reply from chip (we can't read any registers) */
 	err = regmap_write(is31->regmap, is31->cdef->reset_reg, 0x00);
 	if (err < 0) {
-		dev_err(&client->dev, "no response from chip write: err = %d\n",
-			err);
+		dev_err(&client->dev, "no response from chip write: err = %d\n", err);
 		err = -EIO; /* does not answer */
 		goto free_mutex;
 	}
-- 
2.35.3




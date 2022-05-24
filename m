Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FFA532507
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiEXINr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiEXINm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:13:42 -0400
X-Greylist: delayed 72 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 May 2022 01:13:37 PDT
Received: from atl4mhfb03.myregisteredsite.com (atl4mhfb03.myregisteredsite.com [209.17.115.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820A175216
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:13:35 -0700 (PDT)
Received: from jax4mhob08.registeredsite.com (jax4mhob08.myregisteredsite.com [64.69.218.88])
        by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 24O8COEs008924
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:12:24 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.203])
        by jax4mhob08.registeredsite.com (8.14.4/8.14.4) with ESMTP id 24O8CJKN032526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:12:20 -0400
Received: (qmail 5159 invoked by uid 0); 24 May 2022 08:12:18 -0000
X-TCPREMOTEIP: 204.168.181.193
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@204.168.181.193)
  by 0 with ESMTPA; 24 May 2022 08:12:18 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        martink@posteo.de, geert+renesas@glider.be, john@metanate.com,
        hechtb@gmail.com, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] Input: st1232 - Support power supply regulators
Date:   Tue, 24 May 2022 10:12:16 +0200
Message-Id: <20220524081216.8550-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_FAIL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the VDD and IOVDD power supply inputs. This allows the
chip to share its supplies with other components (e.g. panel) and manage
them.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 .../input/touchscreen/sitronix,st1232.yaml    |  6 +++
 drivers/input/touchscreen/st1232.c            | 54 ++++++++++++++++---
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
index 1d8ca19fd37a..240be8d49232 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
@@ -28,6 +28,12 @@ properties:
     description: A phandle to the reset GPIO
     maxItems: 1
 
+  vdd-supply:
+    description: Power supply regulator for the chip
+
+  vddio-supply:
+    description: Power supply regulator for the I2C bus
+
 required:
   - compatible
   - reg
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index e38ba3e4f183..d9c9f6f1f11a 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -44,6 +44,11 @@
 #define REG_XY_COORDINATES	0x12
 #define ST_TS_MAX_FINGERS	10
 
+enum st1232_regulators {
+	ST1232_REGULATOR_VDD,
+	ST1232_REGULATOR_IOVDD,
+};
+
 struct st_chip_info {
 	bool	have_z;
 	u16	max_area;
@@ -56,6 +61,7 @@ struct st1232_ts_data {
 	struct touchscreen_properties prop;
 	struct dev_pm_qos_request low_latency_req;
 	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data regulators[2];
 	const struct st_chip_info *chip_info;
 	int read_buf_len;
 	u8 *read_buf;
@@ -197,17 +203,36 @@ static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void st1232_ts_power(struct st1232_ts_data *ts, bool poweron)
+static int st1232_ts_power_on(struct st1232_ts_data *ts)
+{
+	int err;
+
+	err = regulator_bulk_enable(ARRAY_SIZE(ts->regulators), ts->regulators);
+	if (err)
+		return err;
+
+	usleep_range(5000, 6000);
+
+	if (ts->reset_gpio)
+		gpiod_set_value_cansleep(ts->reset_gpio, 0);
+
+	return 0;
+}
+
+static void st1232_ts_power_off(struct st1232_ts_data *ts)
 {
 	if (ts->reset_gpio)
-		gpiod_set_value_cansleep(ts->reset_gpio, !poweron);
+		gpiod_set_value_cansleep(ts->reset_gpio, 1);
+	usleep_range(100, 150);
+	regulator_bulk_disable(ARRAY_SIZE(ts->regulators), ts->regulators);
 }
 
-static void st1232_ts_power_off(void *data)
+static void st1232_ts_power_off_action(void *data)
 {
-	st1232_ts_power(data, false);
+	st1232_ts_power_off(data);
 }
 
+
 static const struct st_chip_info st1232_chip_info = {
 	.have_z		= true,
 	.max_area	= 0xff,
@@ -266,6 +291,14 @@ static int st1232_ts_probe(struct i2c_client *client,
 	ts->client = client;
 	ts->input_dev = input_dev;
 
+	ts->regulators[ST1232_REGULATOR_VDD].supply = "vdd";
+	ts->regulators[ST1232_REGULATOR_IOVDD].supply = "iovdd";
+	error = devm_regulator_bulk_get(&client->dev,
+					ARRAY_SIZE(ts->regulators),
+					ts->regulators);
+	if (error)
+		return error;
+
 	ts->reset_gpio = devm_gpiod_get_optional(&client->dev, NULL,
 						 GPIOD_OUT_HIGH);
 	if (IS_ERR(ts->reset_gpio)) {
@@ -275,9 +308,14 @@ static int st1232_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
-	st1232_ts_power(ts, true);
+	error = st1232_ts_power_on(ts);
+	if (error) {
+		dev_err(&client->dev, "Failed to power on: %d\n", error);
+		return error;
+	}
 
-	error = devm_add_action_or_reset(&client->dev, st1232_ts_power_off, ts);
+	error = devm_add_action_or_reset(&client->dev,
+					 st1232_ts_power_off_action, ts);
 	if (error) {
 		dev_err(&client->dev,
 			"Failed to install power off action: %d\n", error);
@@ -348,7 +386,7 @@ static int __maybe_unused st1232_ts_suspend(struct device *dev)
 	disable_irq(client->irq);
 
 	if (!device_may_wakeup(&client->dev))
-		st1232_ts_power(ts, false);
+		st1232_ts_power_off(ts);
 
 	return 0;
 }
@@ -359,7 +397,7 @@ static int __maybe_unused st1232_ts_resume(struct device *dev)
 	struct st1232_ts_data *ts = i2c_get_clientdata(client);
 
 	if (!device_may_wakeup(&client->dev))
-		st1232_ts_power(ts, true);
+		st1232_ts_power_on(ts);
 
 	enable_irq(client->irq);
 
-- 
2.17.1


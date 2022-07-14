Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB99A575775
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbiGNWMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241022AbiGNWMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:12:20 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CEE70E6C;
        Thu, 14 Jul 2022 15:12:19 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LkTHl3jbhzDqmJ;
        Thu, 14 Jul 2022 22:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1657836739; bh=ssoi08sEhr0Lz2fizpI6XjmymvgbqQVIa2Tf3XLP/Pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8GCSOJSf7KQ1YpC5YBsMMam2DmcDV+rYRcfKBdTV1B+NiQOZydBID06H3omfUr5l
         sw5fgLPWj9/JTEJABkM22UAjHX7IPBU/3ODapgsFhwDKAd0PLISIT6yY3lzgmkvTCi
         7m5Nk5hBTzObCs7R1bFpJPZG+KDURD+SCQaHJDSM=
X-Riseup-User-ID: CE49D1B04BF757D7B4CAE73DCFC36B2EBAFFEF4D8B795BB0DC5B5BFE06971E4C
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4LkTHg5S10z1yWZ;
        Thu, 14 Jul 2022 22:12:15 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        andrzej.hajda@intel.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH RESEND 1/2] media: s5c73m3: Replace legacy gpio interface for gpiod
Date:   Thu, 14 Jul 2022 19:12:01 -0300
Message-Id: <20220714221202.86768-2-mairacanal@riseup.net>
In-Reply-To: <20220714221202.86768-1-mairacanal@riseup.net>
References: <20220714221202.86768-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maíra Canal <maira.canal@usp.br>

Considering the current transition of the GPIO subsystem, remove all
dependencies of the legacy GPIO interface (linux/gpio.h and linux
/of_gpio.h) and replace it with the descriptor-based GPIO approach.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/media/i2c/s5c73m3/s5c73m3-core.c | 95 ++++++++++--------------
 drivers/media/i2c/s5c73m3/s5c73m3.h      |  9 +--
 include/media/i2c/s5c73m3.h              | 15 +---
 3 files changed, 44 insertions(+), 75 deletions(-)

diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-core.c b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
index e2b88c5e4f98..8af785fbf25b 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3-core.c
+++ b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
@@ -10,12 +10,11 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/media.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/of_graph.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sizes.h>
@@ -1347,22 +1346,26 @@ static int s5c73m3_oif_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 	return 0;
 }
 
-static int s5c73m3_gpio_set_value(struct s5c73m3 *priv, int id, u32 val)
+static int s5c73m3_gpio_set_value(struct gpio_desc *gpio, int val)
 {
-	if (!gpio_is_valid(priv->gpio[id].gpio))
+	if (!gpio)
 		return 0;
-	gpio_set_value(priv->gpio[id].gpio, !!val);
+	gpiod_set_value(gpio, !!val);
 	return 1;
 }
 
-static int s5c73m3_gpio_assert(struct s5c73m3 *priv, int id)
+static int s5c73m3_gpio_assert(struct gpio_desc *gpio)
 {
-	return s5c73m3_gpio_set_value(priv, id, priv->gpio[id].level);
+	int val = gpiod_get_value(gpio);
+
+	return s5c73m3_gpio_set_value(gpio, val);
 }
 
-static int s5c73m3_gpio_deassert(struct s5c73m3 *priv, int id)
+static int s5c73m3_gpio_deassert(struct gpio_desc *gpio)
 {
-	return s5c73m3_gpio_set_value(priv, id, !priv->gpio[id].level);
+	int val = gpiod_get_value(gpio);
+
+	return s5c73m3_gpio_set_value(gpio, !val);
 }
 
 static int __s5c73m3_power_on(struct s5c73m3 *state)
@@ -1386,10 +1389,10 @@ static int __s5c73m3_power_on(struct s5c73m3 *state)
 	v4l2_dbg(1, s5c73m3_dbg, &state->oif_sd, "clock frequency: %ld\n",
 					clk_get_rate(state->clock));
 
-	s5c73m3_gpio_deassert(state, STBY);
+	s5c73m3_gpio_deassert(state->gpio_stby);
 	usleep_range(100, 200);
 
-	s5c73m3_gpio_deassert(state, RSET);
+	s5c73m3_gpio_deassert(state->gpio_reset);
 	usleep_range(50, 100);
 
 	return 0;
@@ -1404,10 +1407,10 @@ static int __s5c73m3_power_off(struct s5c73m3 *state)
 {
 	int i, ret;
 
-	if (s5c73m3_gpio_assert(state, RSET))
+	if (s5c73m3_gpio_assert(state->gpio_reset))
 		usleep_range(10, 50);
 
-	if (s5c73m3_gpio_assert(state, STBY))
+	if (s5c73m3_gpio_assert(state->gpio_stby))
 		usleep_range(100, 200);
 
 	clk_disable_unprepare(state->clock);
@@ -1545,50 +1548,34 @@ static const struct v4l2_subdev_ops oif_subdev_ops = {
 
 static int s5c73m3_configure_gpios(struct s5c73m3 *state)
 {
-	static const char * const gpio_names[] = {
-		"S5C73M3_STBY", "S5C73M3_RST"
-	};
 	struct i2c_client *c = state->i2c_client;
-	struct s5c73m3_gpio *g = state->gpio;
-	int ret, i;
+	struct device *dev = &c->dev;
+	struct device_node *np = dev->of_node;
 
-	for (i = 0; i < GPIO_NUM; ++i) {
-		unsigned int flags = GPIOF_DIR_OUT;
-		if (g[i].level)
-			flags |= GPIOF_INIT_HIGH;
-		ret = devm_gpio_request_one(&c->dev, g[i].gpio, flags,
-					    gpio_names[i]);
-		if (ret) {
-			v4l2_err(c, "failed to request gpio %s\n",
-				 gpio_names[i]);
-			return ret;
-		}
+	state->gpio_stby = gpiod_get_from_of_node(np, "standby-gpios", 0, GPIOD_ASIS,
+			"S5C73M3_STBY");
+
+	if (IS_ERR(state->gpio_stby)) {
+		v4l2_err(c, "failed to request gpio S5C73M3_STBY");
+		return PTR_ERR(state->gpio_stby);
 	}
-	return 0;
-}
 
-static int s5c73m3_parse_gpios(struct s5c73m3 *state)
-{
-	static const char * const prop_names[] = {
-		"standby-gpios", "xshutdown-gpios",
-	};
-	struct device *dev = &state->i2c_client->dev;
-	struct device_node *node = dev->of_node;
-	int ret, i;
+	if (state->gpio_stby)
+		gpiod_direction_output(state->gpio_stby,
+				!gpiod_is_active_low(state->gpio_stby));
 
-	for (i = 0; i < GPIO_NUM; ++i) {
-		enum of_gpio_flags of_flags;
+	state->gpio_reset = gpiod_get_from_of_node(np, "xshutdown-gpios", 0, GPIOD_ASIS,
+			"S5C73M3_RST");
 
-		ret = of_get_named_gpio_flags(node, prop_names[i],
-					      0, &of_flags);
-		if (ret < 0) {
-			dev_err(dev, "failed to parse %s DT property\n",
-				prop_names[i]);
-			return -EINVAL;
-		}
-		state->gpio[i].gpio = ret;
-		state->gpio[i].level = !(of_flags & OF_GPIO_ACTIVE_LOW);
+	if (IS_ERR(state->gpio_reset)) {
+		v4l2_err(c, "failed to request gpio S5C73M3_RST");
+		return PTR_ERR(state->gpio_reset);
 	}
+
+	if (state->gpio_reset)
+		gpiod_direction_output(state->gpio_reset,
+				!gpiod_is_active_low(state->gpio_reset));
+
 	return 0;
 }
 
@@ -1608,8 +1595,8 @@ static int s5c73m3_get_platform_data(struct s5c73m3 *state)
 		}
 
 		state->mclk_frequency = pdata->mclk_frequency;
-		state->gpio[STBY] = pdata->gpio_stby;
-		state->gpio[RSET] = pdata->gpio_reset;
+		state->gpio_stby = pdata->gpio_stby;
+		state->gpio_reset = pdata->gpio_reset;
 		return 0;
 	}
 
@@ -1624,10 +1611,6 @@ static int s5c73m3_get_platform_data(struct s5c73m3 *state)
 					state->mclk_frequency);
 	}
 
-	ret = s5c73m3_parse_gpios(state);
-	if (ret < 0)
-		return -EINVAL;
-
 	node_ep = of_graph_get_next_endpoint(node, NULL);
 	if (!node_ep) {
 		dev_warn(dev, "no endpoint defined for node: %pOF\n", node);
diff --git a/drivers/media/i2c/s5c73m3/s5c73m3.h b/drivers/media/i2c/s5c73m3/s5c73m3.h
index c3fcfdd3ea66..f0056ae6e51a 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3.h
+++ b/drivers/media/i2c/s5c73m3/s5c73m3.h
@@ -351,12 +351,6 @@ struct s5c73m3_ctrls {
 	struct v4l2_ctrl *scene_mode;
 };
 
-enum s5c73m3_gpio_id {
-	STBY,
-	RSET,
-	GPIO_NUM,
-};
-
 enum s5c73m3_resolution_types {
 	RES_ISP,
 	RES_JPEG,
@@ -383,7 +377,8 @@ struct s5c73m3 {
 	u32 i2c_read_address;
 
 	struct regulator_bulk_data supplies[S5C73M3_MAX_SUPPLIES];
-	struct s5c73m3_gpio gpio[GPIO_NUM];
+	struct gpio_desc *gpio_stby;
+	struct gpio_desc *gpio_reset;
 
 	struct clk *clock;
 
diff --git a/include/media/i2c/s5c73m3.h b/include/media/i2c/s5c73m3.h
index a51f1025ba1c..caad855a8394 100644
--- a/include/media/i2c/s5c73m3.h
+++ b/include/media/i2c/s5c73m3.h
@@ -17,19 +17,10 @@
 #ifndef MEDIA_S5C73M3__
 #define MEDIA_S5C73M3__
 
+#include <linux/gpio/consumer.h>
 #include <linux/videodev2.h>
 #include <media/v4l2-mediabus.h>
 
-/**
- * struct s5c73m3_gpio - data structure describing a GPIO
- * @gpio:  GPIO number
- * @level: indicates active state of the @gpio
- */
-struct s5c73m3_gpio {
-	int gpio;
-	int level;
-};
-
 /**
  * struct s5c73m3_platform_data - s5c73m3 driver platform data
  * @mclk_frequency: sensor's master clock frequency in Hz
@@ -44,8 +35,8 @@ struct s5c73m3_gpio {
 struct s5c73m3_platform_data {
 	unsigned long mclk_frequency;
 
-	struct s5c73m3_gpio gpio_reset;
-	struct s5c73m3_gpio gpio_stby;
+	struct gpio_desc *gpio_reset;
+	struct gpio_desc *gpio_stby;
 
 	enum v4l2_mbus_type bus_type;
 	u8 nlanes;
-- 
2.36.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23B95AF64C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiIFUqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiIFUqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:46:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923C590831;
        Tue,  6 Sep 2022 13:46:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so12655287pji.1;
        Tue, 06 Sep 2022 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+uE2OEeTSrokniRUKVeWp7PzNk6FLry2MePwrph1C0k=;
        b=JZqbwed6xQRkzyAtazNLZMl444ymjk6tFBd86gMebJSMpkFR39OHGEz7gKYbdMEK2i
         N2r/Ze/Q0QI/xySvJxy/EkVrgyyqanHbGQufT0FVxxCljI7pnRXSKqYuU8cOWFFG5Lwe
         D7TSEu3MzRS/DtsYSdgVKIloDZhXpXNbCwHP3Y/QZSQviRAYNIohec+B0YRMb7JNpnDr
         Eqdu3bNfXbKWH4eDxN/U+ZJQIDIOnmj2Klc1dDZBJHnwKntnpKNLSYwYeMixc5hyOtZM
         xqpIB7TZnFSgqD3filQZ+o9b68Xjup8pV3toBCAY6gTYZOV8fR4DkYerPTXxczaDB6Cs
         E69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+uE2OEeTSrokniRUKVeWp7PzNk6FLry2MePwrph1C0k=;
        b=RMBIjg2LW151NAd5NZ+qevAlT2n1xi+rXNQpUfBPJjnKVxYV4EgdGqPo3fa/7zpcWX
         melWi6A/xTvAVQIjE9/HfKAbwwSAGIyxJTK+Irs0Pnb2cQ8CcCySWJAc5uHTit0vBFca
         4fnRZB/KVc9NKHy5u5mZfd2o9uVqBAVq5x/k0LvKXwwfejxy1s8B45v5st/Uc12XD+nf
         UqT1gqbZqwdeX86zo5Y3sX7uYA6HDEZ6LhkPwnT6MNq9G/emkGYLEtMA32XVHJXrojys
         LM5LA10FNun4yFoXcnBeR17zPdNMh+LrveN+S4hToghUyBUzcM6Xt0k78QAsYYDxbGtw
         quUQ==
X-Gm-Message-State: ACgBeo1S0y1yQ254QBEXdj0YKe3HJ4kEXadR2U51ZeTMOtV3Y+3pBh5W
        D6i/YGXl9s39YDcnzRy7Q1s=
X-Google-Smtp-Source: AA6agR5hKK8y659yqVejNGy7IDtFQYF4kbWHKp4IlGMNtbtW3MLwQJemz5rB/V90qGGjfaVSEnhKLg==
X-Received: by 2002:a17:90a:3c89:b0:1fa:acc2:bafe with SMTP id g9-20020a17090a3c8900b001faacc2bafemr26940728pjc.84.1662497168913;
        Tue, 06 Sep 2022 13:46:08 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:abc4:5d24:5a73:a96b])
        by smtp.gmail.com with ESMTPSA id s11-20020aa78bcb000000b0053e1c157f62sm2601827pfd.71.2022.09.06.13.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 13:46:08 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] media: i2c: s5c73m3: switch to using gpiod API
Date:   Tue,  6 Sep 2022 13:46:03 -0700
Message-Id: <20220906204603.3762756-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220906204603.3762756-1-dmitry.torokhov@gmail.com>
References: <20220906204603.3762756-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches the driver away from legacy gpio/of_gpio API to
gpiod API, and removes use of of_get_named_gpio_flags() which I want to
make private to gpiolib.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/media/i2c/s5c73m3/s5c73m3-core.c | 63 +++++++-----------------
 drivers/media/i2c/s5c73m3/s5c73m3.h      |  7 +--
 2 files changed, 20 insertions(+), 50 deletions(-)

diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-core.c b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
index 561c1a1583ac..f1e073ed5f99 100644
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
@@ -1348,20 +1347,20 @@ static int s5c73m3_oif_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 
 static int s5c73m3_gpio_set_value(struct s5c73m3 *priv, int id, u32 val)
 {
-	if (!gpio_is_valid(priv->gpio[id].gpio))
+	if (!priv->gpio[id])
 		return 0;
-	gpio_set_value(priv->gpio[id].gpio, !!val);
+	gpiod_set_value_cansleep(priv->gpio[id], val);
 	return 1;
 }
 
 static int s5c73m3_gpio_assert(struct s5c73m3 *priv, int id)
 {
-	return s5c73m3_gpio_set_value(priv, id, priv->gpio[id].level);
+	return s5c73m3_gpio_set_value(priv, id, 1);
 }
 
 static int s5c73m3_gpio_deassert(struct s5c73m3 *priv, int id)
 {
-	return s5c73m3_gpio_set_value(priv, id, !priv->gpio[id].level);
+	return s5c73m3_gpio_set_value(priv, id, 0);
 }
 
 static int __s5c73m3_power_on(struct s5c73m3 *state)
@@ -1544,49 +1543,29 @@ static const struct v4l2_subdev_ops oif_subdev_ops = {
 
 static int s5c73m3_configure_gpios(struct s5c73m3 *state)
 {
-	static const char * const gpio_names[] = {
-		"S5C73M3_STBY", "S5C73M3_RST"
-	};
+	static const char * const name[] = { "standby", "xshutdown" };
+	static const char * const label[] = { "S5C73M3_STBY", "S5C73M3_RST" };
 	struct i2c_client *c = state->i2c_client;
-	struct s5c73m3_gpio *g = state->gpio;
+	struct gpio_desc *gpio;
 	int ret, i;
 
 	for (i = 0; i < GPIO_NUM; ++i) {
-		unsigned int flags = GPIOF_DIR_OUT;
-		if (g[i].level)
-			flags |= GPIOF_INIT_HIGH;
-		ret = devm_gpio_request_one(&c->dev, g[i].gpio, flags,
-					    gpio_names[i]);
+		gpio = devm_gpiod_get(&c->dev, name[i], GPIOD_OUT_HIGH);
+		ret = PTR_ERR_OR_ZERO(gpio);
 		if (ret) {
-			v4l2_err(c, "failed to request gpio %s\n",
-				 gpio_names[i]);
+			v4l2_err(c, "failed to request gpio %s: %d\n",
+				 name[i], ret);
 			return ret;
 		}
-	}
-	return 0;
-}
-
-static int s5c73m3_parse_gpios(struct s5c73m3 *state)
-{
-	static const char * const prop_names[] = {
-		"standby-gpios", "xshutdown-gpios",
-	};
-	struct device *dev = &state->i2c_client->dev;
-	struct device_node *node = dev->of_node;
-	int ret, i;
 
-	for (i = 0; i < GPIO_NUM; ++i) {
-		enum of_gpio_flags of_flags;
-
-		ret = of_get_named_gpio_flags(node, prop_names[i],
-					      0, &of_flags);
-		if (ret < 0) {
-			dev_err(dev, "failed to parse %s DT property\n",
-				prop_names[i]);
-			return -EINVAL;
+		ret = gpiod_set_consumer_name(gpio, label[i]);
+		if (ret) {
+			v4l2_err(c, "failed to set up name for gpio %s: %d\n",
+				 name[i], ret);
+			return ret;
 		}
-		state->gpio[i].gpio = ret;
-		state->gpio[i].level = !(of_flags & OF_GPIO_ACTIVE_LOW);
+
+		state->gpio[i] = gpio;
 	}
 	return 0;
 }
@@ -1613,10 +1592,6 @@ static int s5c73m3_get_dt_data(struct s5c73m3 *state)
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
index d68528898249..9887d03fcdeb 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3.h
+++ b/drivers/media/i2c/s5c73m3/s5c73m3.h
@@ -356,11 +356,6 @@ enum s5c73m3_gpio_id {
 	GPIO_NUM,
 };
 
-struct s5c73m3_gpio {
-	int gpio;
-	int level;
-};
-
 enum s5c73m3_resolution_types {
 	RES_ISP,
 	RES_JPEG,
@@ -387,7 +382,7 @@ struct s5c73m3 {
 	u32 i2c_read_address;
 
 	struct regulator_bulk_data supplies[S5C73M3_MAX_SUPPLIES];
-	struct s5c73m3_gpio gpio[GPIO_NUM];
+	struct gpio_desc *gpio[GPIO_NUM];
 
 	struct clk *clock;
 
-- 
2.37.2.789.g6183377224-goog


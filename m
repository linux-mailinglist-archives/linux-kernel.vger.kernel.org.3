Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7015AF64A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiIFUqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiIFUqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:46:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA76490831;
        Tue,  6 Sep 2022 13:46:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id t3so7382337ply.2;
        Tue, 06 Sep 2022 13:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=GuIivC+qPDg0hONIQ5BU4xKk92IJxSYeo/CaLwV8Nb0=;
        b=T7FM32+PTxokphNYR8VYWik4NFvL0xjEEppLzgLo81R/OFYnV6oNlwk1RvnFJBqfaA
         7x33LXmqK/jA/hwOYAbWL2XshvK+14y23uHZHoUJcy84tdd1Edekx7oBjqkrGFk0BlQS
         exFk53KcCL0q267x/IPc30A7dkMfPI6l5aLe3pj1HFLBBBgzw/NWBRuWOu3GrOloN01V
         mrk/JJWg0u2Oelsv/w9RYRqzL3X05IMP+aLM7GiKP8Z2jMRbleK4iQkmpXQbabpuz1Ss
         aNqoRKUEo9Tal8pFkMQZU5bKURJi7ffW9gWzSFbVTtlRxUuYxkcaBj3MxUhI1mO7ZmNl
         hFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=GuIivC+qPDg0hONIQ5BU4xKk92IJxSYeo/CaLwV8Nb0=;
        b=dtzN5emgNvIGxvFdDOk9V9x9IR5NlriuCCobDzJ6yONNXR1MrkAAXmlxfEJxzMXJYf
         QthEKMfjfdp7qy1HODCtbvOntgX9y1HTrrqsiYhfWPl/eBYEavCp+xFaL1Vhh4toOrXj
         usppXLlGWVLWUXhhhdueOz/5B4hDV5IK2Q26vm75i59kvdhZ4dGij9RFGP++cKlROyYA
         jwaGx22hwGfw1szCNRggzMWiyXFs0QSwyGJuBEjLUmdmyMZCqk7anF9f+5feX4TwgbMJ
         CpRQ5uWIvy6GTpydBs/auXZRP2zt+TNhDfnZ0slm9nejXe3TwIXIFo6qFQ+GQedjl0k8
         n83w==
X-Gm-Message-State: ACgBeo2vGd8sB1oIGDW48jbK1f/bCCQIjJzNkavEcxsTlVjiPA9qAMpX
        dZcOYAlFz3tWQtxBU+Ajg98=
X-Google-Smtp-Source: AA6agR6UkN1shlfurO4k8Gyi5YlB5iw3Mo+kgJg/ACuinMEuyNYg8iUpvg//jacMecS1jZOxMkZEvA==
X-Received: by 2002:a17:90b:1d0a:b0:200:6638:2453 with SMTP id on10-20020a17090b1d0a00b0020066382453mr192293pjb.237.1662497166121;
        Tue, 06 Sep 2022 13:46:06 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:abc4:5d24:5a73:a96b])
        by smtp.gmail.com with ESMTPSA id s11-20020aa78bcb000000b0053e1c157f62sm2601827pfd.71.2022.09.06.13.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 13:46:05 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] media: s5k5baf: switch to using gpiod API
Date:   Tue,  6 Sep 2022 13:46:01 -0700
Message-Id: <20220906204603.3762756-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
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
 drivers/media/i2c/s5k5baf.c | 64 +++++++++++--------------------------
 1 file changed, 18 insertions(+), 46 deletions(-)

diff --git a/drivers/media/i2c/s5k5baf.c b/drivers/media/i2c/s5k5baf.c
index 5c2253ab3b6f..960fbf6428ea 100644
--- a/drivers/media/i2c/s5k5baf.c
+++ b/drivers/media/i2c/s5k5baf.c
@@ -13,11 +13,10 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/media.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/of_graph.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -228,11 +227,6 @@ static const char * const s5k5baf_supply_names[] = {
 };
 #define S5K5BAF_NUM_SUPPLIES ARRAY_SIZE(s5k5baf_supply_names)
 
-struct s5k5baf_gpio {
-	int gpio;
-	int level;
-};
-
 enum s5k5baf_gpio_id {
 	STBY,
 	RSET,
@@ -284,7 +278,7 @@ struct s5k5baf_fw {
 };
 
 struct s5k5baf {
-	struct s5k5baf_gpio gpios[NUM_GPIOS];
+	struct gpio_desc *gpios[NUM_GPIOS];
 	enum v4l2_mbus_type bus_type;
 	u8 nlanes;
 	struct regulator_bulk_data supplies[S5K5BAF_NUM_SUPPLIES];
@@ -936,16 +930,12 @@ static void s5k5baf_hw_set_test_pattern(struct s5k5baf *state, int id)
 
 static void s5k5baf_gpio_assert(struct s5k5baf *state, int id)
 {
-	struct s5k5baf_gpio *gpio = &state->gpios[id];
-
-	gpio_set_value(gpio->gpio, gpio->level);
+	gpiod_set_value_cansleep(state->gpios[id], 1);
 }
 
 static void s5k5baf_gpio_deassert(struct s5k5baf *state, int id)
 {
-	struct s5k5baf_gpio *gpio = &state->gpios[id];
-
-	gpio_set_value(gpio->gpio, !gpio->level);
+	gpiod_set_value_cansleep(state->gpios[id], 0);
 }
 
 static int s5k5baf_power_on(struct s5k5baf *state)
@@ -1799,44 +1789,30 @@ static const struct v4l2_subdev_ops s5k5baf_subdev_ops = {
 
 static int s5k5baf_configure_gpios(struct s5k5baf *state)
 {
-	static const char * const name[] = { "S5K5BAF_STBY", "S5K5BAF_RST" };
+	static const char * const name[] = { "stbyn", "rstn" };
+	static const char * const label[] = { "S5K5BAF_STBY", "S5K5BAF_RST" };
 	struct i2c_client *c = v4l2_get_subdevdata(&state->sd);
-	struct s5k5baf_gpio *g = state->gpios;
+	struct gpio_desc *gpio;
 	int ret, i;
 
 	for (i = 0; i < NUM_GPIOS; ++i) {
-		int flags = GPIOF_DIR_OUT;
-		if (g[i].level)
-			flags |= GPIOF_INIT_HIGH;
-		ret = devm_gpio_request_one(&c->dev, g[i].gpio, flags, name[i]);
-		if (ret < 0) {
-			v4l2_err(c, "failed to request gpio %s\n", name[i]);
+		gpio = devm_gpiod_get(&c->dev, name[i], GPIOD_OUT_HIGH);
+		ret = PTR_ERR_OR_ZERO(gpio);
+		if (ret) {
+			v4l2_err(c, "failed to request gpio %s: %d\n",
+				 name[i], ret);
 			return ret;
 		}
-	}
-	return 0;
-}
-
-static int s5k5baf_parse_gpios(struct s5k5baf_gpio *gpios, struct device *dev)
-{
-	static const char * const names[] = {
-		"stbyn-gpios",
-		"rstn-gpios",
-	};
-	struct device_node *node = dev->of_node;
-	enum of_gpio_flags flags;
-	int ret, i;
 
-	for (i = 0; i < NUM_GPIOS; ++i) {
-		ret = of_get_named_gpio_flags(node, names[i], 0, &flags);
-		if (ret < 0) {
-			dev_err(dev, "no %s GPIO pin provided\n", names[i]);
+		ret = gpiod_set_consumer_name(gpio, label[i]);
+		if (ret) {
+			v4l2_err(c, "failed to set up name for gpio %s: %d\n",
+				 name[i], ret);
 			return ret;
 		}
-		gpios[i].gpio = ret;
-		gpios[i].level = !(flags & OF_GPIO_ACTIVE_LOW);
-	}
 
+		state->gpios[i] = gpio;
+	}
 	return 0;
 }
 
@@ -1860,10 +1836,6 @@ static int s5k5baf_parse_device_node(struct s5k5baf *state, struct device *dev)
 			 state->mclk_frequency);
 	}
 
-	ret = s5k5baf_parse_gpios(state->gpios, dev);
-	if (ret < 0)
-		return ret;
-
 	node_ep = of_graph_get_next_endpoint(node, NULL);
 	if (!node_ep) {
 		dev_err(dev, "no endpoint defined at node %pOF\n", node);
-- 
2.37.2.789.g6183377224-goog


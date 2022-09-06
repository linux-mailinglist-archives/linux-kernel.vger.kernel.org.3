Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691245AF64B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiIFUqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiIFUqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:46:09 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513D89082D;
        Tue,  6 Sep 2022 13:46:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 65so2332857pfx.0;
        Tue, 06 Sep 2022 13:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=56ggZAvVwxUQqooWk5v+V39OxTKDncO2SngkQniryTQ=;
        b=d7sof0+r0kln9XNTxiBUmbsuWOtsAmBNz+y20S7Aj9Aa2vasoQ16u9+hLgof89JJZQ
         SfuxiZhT83lP4GavE13naOtrPJmeqemR8cn/tw8aZZLzXXdFBC4j2BP4cuGX1Cf8kvQJ
         FWXhLvO8FTz6flaXWBb/9yXQezKdQIAImdSEOwBGtREabbft62fjzcWRmHTOfwf2Cg7z
         EW3wP61IOQwtzhl9Lnm7xofjgHR3+b53tdeUUZ4a9o6aeHtjNnsgYc75cW8Hlzpu4IVt
         UAN3hvYieRGy2n6ED4mHNd8t1kZMj1nfyFbIpWWjt6B3FtqxRvaCQ+7IP6SGAXlf0umU
         /yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=56ggZAvVwxUQqooWk5v+V39OxTKDncO2SngkQniryTQ=;
        b=kgiOV1LjHEuLzYBcmDsOMCR2q3kVXK/R0uq1YhErC2pcOOKJf58anAm5dNf24WQL00
         I0R/5D/mx+q38WN1P2P79TzhZMFHs2aIeOMBwg3bTtRYv+WfBylgd9H/rzAJLaDG2lij
         hNNFrUyKrk0jOGmis0DMXpY0Yb2jS/1B5GrVt9v0Y21/E98Ja9APivh4GDtOvKddKVd9
         M5jWxk6e/H6XTUA6p5cwe6lrUOCpYgkaWbMn0EOwCAJBxf/TauZk4v3AJ3K3nfyNR2Rh
         0RJyjb5ciGFSk76eM5Cu9VueWCP4XvdfhIuhqz9VyDdshASKEbL8uZiKFSqrVtot8Xyv
         TRZQ==
X-Gm-Message-State: ACgBeo29JWg262jtrYtuI25oUyS0/Kx1Y/t8iUVitaJdS6ew6jYjwmZC
        mttJpktL8TdwQGWFP9QCPBw=
X-Google-Smtp-Source: AA6agR6Y97WpI4Z6KT0KHrWydyDlcCD5V4cBC0l4b/7P6AJY897/csmEXRHUASrGCRc9A2OeNDVPEg==
X-Received: by 2002:a05:6a00:816:b0:52f:43f9:b644 with SMTP id m22-20020a056a00081600b0052f43f9b644mr268517pfk.57.1662497167579;
        Tue, 06 Sep 2022 13:46:07 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:abc4:5d24:5a73:a96b])
        by smtp.gmail.com with ESMTPSA id s11-20020aa78bcb000000b0053e1c157f62sm2601827pfd.71.2022.09.06.13.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 13:46:07 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] media: i2c: s5c73m3: remove support for platform data
Date:   Tue,  6 Sep 2022 13:46:02 -0700
Message-Id: <20220906204603.3762756-2-dmitry.torokhov@gmail.com>
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

There are no existing users of s5c73m3_platform_data in the tree, and
new users shoudl either be using device tree, ACPI, or static device
properties, so let's remove it from the driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/media/i2c/s5c73m3/s5c73m3-core.c  | 19 ++------
 drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c |  2 -
 drivers/media/i2c/s5c73m3/s5c73m3.h       |  6 ++-
 include/media/i2c/s5c73m3.h               | 56 -----------------------
 4 files changed, 9 insertions(+), 74 deletions(-)
 delete mode 100644 include/media/i2c/s5c73m3.h

diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-core.c b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
index d96ba58ce1e5..561c1a1583ac 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3-core.c
+++ b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
@@ -27,7 +27,6 @@
 #include <media/v4l2-device.h>
 #include <media/v4l2-subdev.h>
 #include <media/v4l2-mediabus.h>
-#include <media/i2c/s5c73m3.h>
 #include <media/v4l2-fwnode.h>
 
 #include "s5c73m3.h"
@@ -1592,26 +1591,16 @@ static int s5c73m3_parse_gpios(struct s5c73m3 *state)
 	return 0;
 }
 
-static int s5c73m3_get_platform_data(struct s5c73m3 *state)
+static int s5c73m3_get_dt_data(struct s5c73m3 *state)
 {
 	struct device *dev = &state->i2c_client->dev;
-	const struct s5c73m3_platform_data *pdata = dev->platform_data;
 	struct device_node *node = dev->of_node;
 	struct device_node *node_ep;
 	struct v4l2_fwnode_endpoint ep = { .bus_type = 0 };
 	int ret;
 
-	if (!node) {
-		if (!pdata) {
-			dev_err(dev, "Platform data not specified\n");
-			return -EINVAL;
-		}
-
-		state->mclk_frequency = pdata->mclk_frequency;
-		state->gpio[STBY] = pdata->gpio_stby;
-		state->gpio[RSET] = pdata->gpio_reset;
-		return 0;
-	}
+	if (!node)
+		return -EINVAL;
 
 	state->clock = devm_clk_get(dev, S5C73M3_CLK_NAME);
 	if (IS_ERR(state->clock))
@@ -1666,7 +1655,7 @@ static int s5c73m3_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	state->i2c_client = client;
-	ret = s5c73m3_get_platform_data(state);
+	ret = s5c73m3_get_dt_data(state);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c b/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c
index 141ad0ba7f5a..1c8103670fa2 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c
+++ b/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c
@@ -10,7 +10,6 @@
 #include <linux/sizes.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/media.h>
@@ -24,7 +23,6 @@
 #include <media/v4l2-device.h>
 #include <media/v4l2-subdev.h>
 #include <media/v4l2-mediabus.h>
-#include <media/i2c/s5c73m3.h>
 
 #include "s5c73m3.h"
 
diff --git a/drivers/media/i2c/s5c73m3/s5c73m3.h b/drivers/media/i2c/s5c73m3/s5c73m3.h
index c3fcfdd3ea66..d68528898249 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3.h
+++ b/drivers/media/i2c/s5c73m3/s5c73m3.h
@@ -15,7 +15,6 @@
 #include <media/v4l2-common.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-subdev.h>
-#include <media/i2c/s5c73m3.h>
 
 #define DRIVER_NAME			"S5C73M3"
 
@@ -357,6 +356,11 @@ enum s5c73m3_gpio_id {
 	GPIO_NUM,
 };
 
+struct s5c73m3_gpio {
+	int gpio;
+	int level;
+};
+
 enum s5c73m3_resolution_types {
 	RES_ISP,
 	RES_JPEG,
diff --git a/include/media/i2c/s5c73m3.h b/include/media/i2c/s5c73m3.h
deleted file mode 100644
index a51f1025ba1c..000000000000
--- a/include/media/i2c/s5c73m3.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * Samsung LSI S5C73M3 8M pixel camera driver
- *
- * Copyright (C) 2012, Samsung Electronics, Co., Ltd.
- * Sylwester Nawrocki <s.nawrocki@samsung.com>
- * Andrzej Hajda <a.hajda@samsung.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-#ifndef MEDIA_S5C73M3__
-#define MEDIA_S5C73M3__
-
-#include <linux/videodev2.h>
-#include <media/v4l2-mediabus.h>
-
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
-/**
- * struct s5c73m3_platform_data - s5c73m3 driver platform data
- * @mclk_frequency: sensor's master clock frequency in Hz
- * @gpio_reset:  GPIO driving RESET pin
- * @gpio_stby:   GPIO driving STBY pin
- * @bus_type:    bus type
- * @nlanes:      maximum number of MIPI-CSI lanes used
- * @horiz_flip:  default horizontal image flip value, non zero to enable
- * @vert_flip:   default vertical image flip value, non zero to enable
- */
-
-struct s5c73m3_platform_data {
-	unsigned long mclk_frequency;
-
-	struct s5c73m3_gpio gpio_reset;
-	struct s5c73m3_gpio gpio_stby;
-
-	enum v4l2_mbus_type bus_type;
-	u8 nlanes;
-	u8 horiz_flip;
-	u8 vert_flip;
-};
-
-#endif /* MEDIA_S5C73M3__ */
-- 
2.37.2.789.g6183377224-goog


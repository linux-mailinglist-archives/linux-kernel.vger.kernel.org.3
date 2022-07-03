Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23B25646F7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiGCLKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiGCLKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:10:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB3C95A7;
        Sun,  3 Jul 2022 04:10:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f2so4072184wrr.6;
        Sun, 03 Jul 2022 04:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8mLa6YcJ8/LXS3JX6YxujO7pIsxppw7hodqInEX9ajw=;
        b=ab7Rio2GCTDvhPeqJGMtzyfo957Uh8UdAwwT9mq2XpxQHFbgq22302eaYgiX9T6e7m
         ZvRlEDPD/2icwrzFPQfExwkWzlnv9VYjuXYaZEm0yj0VB5ojYNlmw52+d2QzNWwDgPPe
         4TASz7OEZ9z8DdADuHfKbs9FqVOVgQczhSU7FXMm80TQrSCk0c78/RvyXFdMlgOHbhV/
         +1CPRpTBuKxOirpQoPyyz6CDJOGSGBcoyHQgtLYgHK0FD4x39yCC78xn2sXjRESHD52e
         BrdVlpuMnOuAr8sGzCA+AOqC2WNEQuHL16u+XPZWD9IMzkQjN7xNgnULUfTfYxk0Xqlu
         iusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8mLa6YcJ8/LXS3JX6YxujO7pIsxppw7hodqInEX9ajw=;
        b=DjCFjGYuo36sTSiJhY51iOSZ57CMO8tu6nsm2L8Jzk1y4mOiTQ/7d+OjrwR/U4JMDg
         3SXUah9ma1V+9h+5kThrqZjmWJA5KEs6sEXm7TiGqKhV9GTGNmPzWj0k0mgTV6fVlR/f
         nSIhRIAbAX74aQ1l+GBY/S1ZKs7PPQtmrgoF65YRvp1JGs3c+bEGF0XVJpbRLAZTsUUf
         huRRt/EUIvH55PvoIL0ojg8nQy6n8nqKK/uIY37AVFBwv+GPsnKoyldtQ+S6IjYu5sg0
         iu6C826uhAdrz1iLbEo9XeOigby4nyRWcGO4xRGxya6/VI+rzZkeQNTZXR5kxFYZhyRG
         RYVA==
X-Gm-Message-State: AJIora/xza388Ms4p3mPvs9uvQm4XA0n0NIE18me5B/LDJq3W9Lano87
        8NCp0VAc2RJcitgVFNo5Yl0=
X-Google-Smtp-Source: AGRyM1twLWvI9q5JpGIybFHUO9Ryc2CLbeMQvjL8oYmSwzzh2WE/rDXDRDAae8kUIkiRSP6Q/nhC9Q==
X-Received: by 2002:adf:fa8d:0:b0:21d:6a23:f627 with SMTP id h13-20020adffa8d000000b0021d6a23f627mr69498wrr.295.1656846611274;
        Sun, 03 Jul 2022 04:10:11 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id v4-20020a7bcb44000000b0039746638d6esm15825418wmj.33.2022.07.03.04.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:10:10 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] gpio: regmap: Support a custom ->to_irq() hook
Date:   Sun,  3 Jul 2022 12:10:57 +0100
Message-Id: <20220703111057.23246-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
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

Some GPIO chips require a custom to_irq() callback for mapping
their IRQs, eg. because their interrupts come from a parent IRQ
chip where the GPIO offset doesn't map 1-to-1 with hwirq number.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/gpio/gpio-regmap.c  | 17 +++++++++++++++++
 include/linux/gpio/regmap.h |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 4bc01329fb14..d11b202e51fd 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -34,6 +34,8 @@ struct gpio_regmap {
 				unsigned int *reg, unsigned int *mask,
 				unsigned int *values);
 
+	int (*to_irq)(struct gpio_regmap *gpio, unsigned int offset);
+
 	void *driver_data;
 };
 
@@ -193,6 +195,13 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
 	return gpio_regmap_set_direction(chip, offset, true);
 }
 
+static int gpio_regmap_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gpio_regmap *gpio = gpiochip_get_data(chip);
+
+	return gpio->to_irq(gpio, offset);
+}
+
 void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
 {
 	return gpio->driver_data;
@@ -242,6 +251,10 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	if (config->reg_field_xlate && config->reg_mask_xlate)
 		return ERR_PTR(-EINVAL);
 
+	/* an irq_domain will override the to_irq hook, so don't allow both */
+	if (config->irq_domain && config->to_irq)
+		return ERR_PTR(-EINVAL);
+
 	gpio = kzalloc(sizeof(*gpio), GFP_KERNEL);
 	if (!gpio)
 		return ERR_PTR(-ENOMEM);
@@ -253,6 +266,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	gpio->reg_stride = config->reg_stride;
 	gpio->reg_mask_xlate = config->reg_mask_xlate;
 	gpio->reg_field_xlate = config->reg_field_xlate;
+	gpio->to_irq = config->to_irq;
 	gpio->reg_dat_base = config->reg_dat_base;
 	gpio->reg_set_base = config->reg_set_base;
 	gpio->reg_clr_base = config->reg_clr_base;
@@ -302,6 +316,9 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 		chip->direction_output = gpio_regmap_direction_output;
 	}
 
+	if (gpio->to_irq)
+		chip->to_irq = gpio_regmap_to_irq;
+
 	ret = gpiochip_add_data(chip, gpio);
 	if (ret < 0)
 		goto err_free_gpio;
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 47acea8cca32..9755854d6747 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -45,6 +45,8 @@ struct regmap;
  *			to register, mask, and field values. If not given
  *			the default gpio_regmap_field_xlate() is used, which
  *			is implemented in terms of ->reg_mask_xlate.
+ * @to_irq:		(Optional) hook for supporting custom IRQ mappings,
+ *			behaves the same as the gpio_chip to_irq hook.
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
@@ -102,6 +104,8 @@ struct gpio_regmap_config {
 				unsigned int *reg, unsigned int *mask,
 				unsigned int *values);
 
+	int (*to_irq)(struct gpio_regmap *gpio, unsigned int offset);
+
 	void *drvdata;
 };
 
-- 
2.35.1


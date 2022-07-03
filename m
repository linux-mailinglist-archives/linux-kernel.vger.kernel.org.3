Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175735646F8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiGCLKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiGCLKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:10:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643B49592;
        Sun,  3 Jul 2022 04:10:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o4so9451400wrh.3;
        Sun, 03 Jul 2022 04:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NnWDUihgr5jPMSJE1D1pbzPafcNF7TIIlv1psn+j5PE=;
        b=AxnWT9DaV8kDjN+0yTfzTMngYnTV7/tpf3lZKeUrYFmtRi/+ftl6riiJ2V9MNZnEfN
         stjYp7wUtd+HKeimGHxaL3uevGK6IBr3/DRNGav6roT9xcogGOlrKsw8VpuDdYp0dyEq
         32+7yp9d15y9QkD9HFkGogRHCF5OrPuksZ5XTQ1D2TLK1+gExcZOurVSKw5TEhwCfNdm
         PvDj1ExN6FWe2ECP5d0vr3ELvDIJdSVZNqhycyx7rBjy6g66BMcIXV8HV9vefoKjdKSI
         P+sHrDDOw98Oda3Yz6uXwPK7AX0MDa4UtJly4hFRypfuD7F+LiEbeSpGiMZltolaGNRG
         4Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NnWDUihgr5jPMSJE1D1pbzPafcNF7TIIlv1psn+j5PE=;
        b=Vti/cTWH9a50u1fjAGGDwZFYEdWcvnlKDyxNbzVGFGPsAIMMJ7vOU4UkCRbC/5OuF4
         pCtqA145ncqbEKf1IMZqPzSitnjdiszvoN+SfmEa3mNRfiy/2y0M+NIAvhoRGFExsQpL
         1cGoMpB5FopabSmih9C4zXk4855ei6vGWOFrX2lZlyNhtxYswFqqHm1ews0deS/CMCvH
         bj4+Nf6wFkvIDPraQGY/nQZWMAPKrCCo3AAE+Sb6yVqSj2cwyJ9F0QtLWWlCQ4era4Y1
         o5iyDWz51xK0ntkbUbGnflBK5wVhJcWyg1P1dqnBg3l+Ij37mACxdd96E+xDeeQwsck0
         /dKQ==
X-Gm-Message-State: AJIora9BFmWTv3LT0p94t2z2o43gBZiKUXmitp1uN1kpO4xsotKhofTo
        zFmHpxMXrGciGT61POcJZCA=
X-Google-Smtp-Source: AGRyM1t9RZi4x5aFVNhvNF2/jVQYe9hEMWU/svUs9LRckjn4o3t9MZifA8VBXWznQDoxuN8pZ6SSfA==
X-Received: by 2002:a5d:518a:0:b0:21a:39f4:b352 with SMTP id k10-20020a5d518a000000b0021a39f4b352mr21899873wrv.92.1656846607923;
        Sun, 03 Jul 2022 04:10:07 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d59a5000000b0021d20461bbbsm16408330wrr.88.2022.07.03.04.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:10:07 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] gpio: regmap: Support registers with more than one bit per GPIO
Date:   Sun,  3 Jul 2022 12:10:55 +0100
Message-Id: <20220703111057.23246-2-aidanmacdonald.0x0@gmail.com>
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

Some devices use a multi-bit register field to change the GPIO
input/output direction. Add the ->reg_field_xlate() callback to
support such devices in gpio-regmap.

->reg_field_xlate() builds on ->reg_mask_xlate() by allowing the
driver to return a mask and values to describe a register field.
gpio-regmap will use the mask to isolate the field and compare or
update it using the values to implement GPIO level and direction
get and set ops.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/gpio/gpio-regmap.c  | 73 +++++++++++++++++++++----------------
 include/linux/gpio/regmap.h | 14 +++++++
 2 files changed, 56 insertions(+), 31 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 6383136cbe59..9256b922c654 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -27,6 +27,10 @@ struct gpio_regmap {
 	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
 			      unsigned int offset, unsigned int *reg,
 			      unsigned int *mask);
+	void (*reg_field_xlate)(struct gpio_regmap *gpio,
+				unsigned int base, unsigned int offset,
+				unsigned int *reg, unsigned int *mask,
+				unsigned int *values);
 
 	void *driver_data;
 };
@@ -52,10 +56,22 @@ static int gpio_regmap_simple_xlate(struct gpio_regmap *gpio,
 	return 0;
 }
 
+static void
+gpio_regmap_simple_field_xlate(struct gpio_regmap *gpio,
+			       unsigned int base, unsigned int offset,
+			       unsigned int *reg, unsigned int *mask,
+			       unsigned int *values)
+{
+	gpio->reg_mask_xlate(gpio, base, offset, reg, mask);
+	values[0] = 0;
+	values[1] = *mask;
+}
+
 static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
 	unsigned int base, val, reg, mask;
+	unsigned int values[2];
 	int ret;
 
 	/* we might not have an output register if we are input only */
@@ -64,15 +80,13 @@ static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
 	else
 		base = gpio_regmap_addr(gpio->reg_set_base);
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
-	if (ret)
-		return ret;
+	gpio->reg_field_xlate(gpio, base, offset, &reg, &mask, values);
 
 	ret = regmap_read(gpio->regmap, reg, &val);
 	if (ret)
 		return ret;
 
-	return !!(val & mask);
+	return (val & mask) == values[1];
 }
 
 static void gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
@@ -81,12 +95,10 @@ static void gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
 	unsigned int base = gpio_regmap_addr(gpio->reg_set_base);
 	unsigned int reg, mask;
+	unsigned int values[2];
 
-	gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
-	if (val)
-		regmap_update_bits(gpio->regmap, reg, mask, mask);
-	else
-		regmap_update_bits(gpio->regmap, reg, mask, 0);
+	gpio->reg_field_xlate(gpio, base, offset, &reg, &mask, values);
+	regmap_update_bits(gpio->regmap, reg, mask, values[!!val]);
 }
 
 static void gpio_regmap_set_with_clear(struct gpio_chip *chip,
@@ -94,14 +106,15 @@ static void gpio_regmap_set_with_clear(struct gpio_chip *chip,
 {
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
 	unsigned int base, reg, mask;
+	unsigned int values[2];
 
 	if (val)
 		base = gpio_regmap_addr(gpio->reg_set_base);
 	else
 		base = gpio_regmap_addr(gpio->reg_clr_base);
 
-	gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
-	regmap_write(gpio->regmap, reg, mask);
+	gpio->reg_field_xlate(gpio, base, offset, &reg, &mask, values);
+	regmap_update_bits(gpio->regmap, reg, mask, values[1]);
 }
 
 static int gpio_regmap_get_direction(struct gpio_chip *chip,
@@ -109,6 +122,7 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
 {
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
 	unsigned int base, val, reg, mask;
+	unsigned int values[2];
 	int invert, ret;
 
 	if (gpio->reg_dir_out_base) {
@@ -121,47 +135,36 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
 		return -EOPNOTSUPP;
 	}
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
-	if (ret)
-		return ret;
+	gpio->reg_field_xlate(gpio, base, offset, &reg, &mask, values);
 
 	ret = regmap_read(gpio->regmap, reg, &val);
 	if (ret)
 		return ret;
 
-	if (!!(val & mask) ^ invert)
-		return GPIO_LINE_DIRECTION_OUT;
-	else
+	if ((val & mask) == values[invert])
 		return GPIO_LINE_DIRECTION_IN;
+	else
+		return GPIO_LINE_DIRECTION_OUT;
 }
 
 static int gpio_regmap_set_direction(struct gpio_chip *chip,
 				     unsigned int offset, bool output)
 {
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
-	unsigned int base, val, reg, mask;
-	int invert, ret;
+	unsigned int base, reg, mask;
+	unsigned int values[2];
 
 	if (gpio->reg_dir_out_base) {
 		base = gpio_regmap_addr(gpio->reg_dir_out_base);
-		invert = 0;
 	} else if (gpio->reg_dir_in_base) {
 		base = gpio_regmap_addr(gpio->reg_dir_in_base);
-		invert = 1;
+		output = !output;
 	} else {
 		return -EOPNOTSUPP;
 	}
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
-	if (ret)
-		return ret;
-
-	if (invert)
-		val = output ? 0 : mask;
-	else
-		val = output ? mask : 0;
-
-	return regmap_update_bits(gpio->regmap, reg, mask, val);
+	gpio->reg_field_xlate(gpio, base, offset, &reg, &mask, values);
+	return regmap_update_bits(gpio->regmap, reg, mask, values[output]);
 }
 
 static int gpio_regmap_direction_input(struct gpio_chip *chip,
@@ -215,6 +218,10 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	if (config->reg_dir_out_base && config->reg_dir_in_base)
 		return ERR_PTR(-EINVAL);
 
+	/* only one of these should be provided */
+	if (config->reg_field_xlate && config->reg_mask_xlate)
+		return ERR_PTR(-EINVAL);
+
 	gpio = kzalloc(sizeof(*gpio), GFP_KERNEL);
 	if (!gpio)
 		return ERR_PTR(-ENOMEM);
@@ -225,6 +232,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	gpio->ngpio_per_reg = config->ngpio_per_reg;
 	gpio->reg_stride = config->reg_stride;
 	gpio->reg_mask_xlate = config->reg_mask_xlate;
+	gpio->reg_field_xlate = config->reg_field_xlate;
 	gpio->reg_dat_base = config->reg_dat_base;
 	gpio->reg_set_base = config->reg_set_base;
 	gpio->reg_clr_base = config->reg_clr_base;
@@ -242,6 +250,9 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	if (!gpio->reg_mask_xlate)
 		gpio->reg_mask_xlate = gpio_regmap_simple_xlate;
 
+	if (!gpio->reg_field_xlate)
+		gpio->reg_field_xlate = gpio_regmap_simple_field_xlate;
+
 	chip = &gpio->gpio_chip;
 	chip->parent = config->parent;
 	chip->fwnode = config->fwnode;
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index a9f7b7faf57b..a673dbfe88a3 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -37,6 +37,10 @@ struct regmap;
  *			offset to a register/bitmask pair. If not
  *			given the default gpio_regmap_simple_xlate()
  *			is used.
+ * @reg_field_xlate:	(Optional) Translates base address and GPIO offset
+ *			to register, mask, and field values. If not given
+ *			the default gpio_regmap_field_xlate() is used, which
+ *			is implemented in terms of ->reg_mask_xlate.
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
@@ -45,6 +49,12 @@ struct regmap;
  * register and mask pair. The base address is one of the given register
  * base addresses in this structure.
  *
+ * ->reg_field_xlate supports chips that have more than one bit per GPIO for
+ * controlling the output level or direction. In addition to the register and
+ * mask it should output field values for low/high level or in/out direction
+ * in ``values[0]`` and ``values[1]``. If ->reg_field_xlate is provided then
+ * it overrides any ->reg_mask_xlate callback.
+ *
  * Although all register base addresses are marked as optional, there are
  * several rules:
  *     1. if you only have @reg_dat_base set, then it is input-only
@@ -81,6 +91,10 @@ struct gpio_regmap_config {
 	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
 			      unsigned int offset, unsigned int *reg,
 			      unsigned int *mask);
+	void (*reg_field_xlate)(struct gpio_regmap *gpio,
+				unsigned int base, unsigned int offset,
+				unsigned int *reg, unsigned int *mask,
+				unsigned int *values);
 
 	void *drvdata;
 };
-- 
2.35.1


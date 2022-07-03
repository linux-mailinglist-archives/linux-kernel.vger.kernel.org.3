Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1B15646F6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiGCLKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiGCLKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:10:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1C6959A;
        Sun,  3 Jul 2022 04:10:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 205-20020a1c02d6000000b003a03567d5e9so5875863wmc.1;
        Sun, 03 Jul 2022 04:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AC+2/tXKJ2KFamOafvmGavz/orcqkE8PLkh+zUIqBTY=;
        b=mIEzhiU+Y3RZxJo7A2cfXOnbIf7tpwWBjDrWVj3arGYnXT0iqIL8RVjIjDsyLZwrx8
         Vi2vw1IWABtxEDhsqjolhv8smRt1jd2g000eKm5FY/p0339j8Pad87qMyPif0Hjd9kfX
         pwt+DZ5I/CahGBQ6CD27ck/fiSax69JdMdtANvHmi8PS4Jo/NrIYBOzqjdFz2oRHHxNr
         Mmh2G///1X7OMA6Rf9IJBoBszJcho8TKYcq9zgr/lti11V9Q6mK3Xil9dLv8NlQN46Cy
         1tDEo4LV53CdCS0h9STVW+Vi3ENV7vL274+GvwUbgVSpf8rR+8aVpqthJtlDxE6FUzrr
         bOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AC+2/tXKJ2KFamOafvmGavz/orcqkE8PLkh+zUIqBTY=;
        b=IiL/Yu/Kydop2Jz/sLGs8AfO6HMii/z9MjpoIItfgAQTbiackSf5mcvfL814tyzCL6
         AxdfBhwTqWGMV6DtTHx+Od6Q/fl4Et8FA5mtglh2ZN21cO5UEbsikVZV1e/JueUSg0xv
         vB56BITzTqH0sLb4BkGJflw0f1K1OPWEcXnkF+aLP02Si39uUF4kovugLCwpds0m2636
         C2l3KL1KupreOQ733docRNA++fMjYq6UdCBTsmWPOJyEbnIQ+ado7as2DM+7YXawpEUp
         QTPCesFdUC5B6ukL8DMvZUePAF+aq4jVOq3MbXcWvcHg7DCdxBlGBuKQ/oqJI5pLFu3w
         hZ0w==
X-Gm-Message-State: AJIora+0swbTnxs4MrZhQ3MBUpyC/qGN56WHoGCLyaKhJCFGxrhpZEfa
        qU2lVvuU3UepRIHEk26c54M=
X-Google-Smtp-Source: AGRyM1tDuMZ/TxmS99GwHLqWoIGNj8gY/1atwR6NaW2GyAHMDNQ4b7xwdsE5GONAeI6wjyMevwfALA==
X-Received: by 2002:a05:600c:35d2:b0:397:84c9:6fe8 with SMTP id r18-20020a05600c35d200b0039784c96fe8mr25294140wmq.206.1656846609395;
        Sun, 03 Jul 2022 04:10:09 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id d21-20020a1c7315000000b003a02cbf862esm15944082wmb.13.2022.07.03.04.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:10:08 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] gpio: regmap: Support combined GPIO and pin control drivers
Date:   Sun,  3 Jul 2022 12:10:56 +0100
Message-Id: <20220703111057.23246-3-aidanmacdonald.0x0@gmail.com>
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

Allow gpio-regmap to be used for the GPIO portion of a combined
pin control and GPIO driver by setting the has_pinctrl flag. This
flag will cause GPIO direction set ops to be implemented as calls
to pinctrl_gpio_direction_input/output() instead of updating the
direction set registers directly.

Note that reg_dir_out/in_base is still required for implementing
the GPIO chip's ->get_direction() callback.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/gpio/gpio-regmap.c  | 20 ++++++++++++++++++++
 include/linux/gpio/regmap.h |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 9256b922c654..4bc01329fb14 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -24,6 +24,8 @@ struct gpio_regmap {
 	unsigned int reg_dir_in_base;
 	unsigned int reg_dir_out_base;
 
+	unsigned int has_pinctrl:1;
+
 	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
 			      unsigned int offset, unsigned int *reg,
 			      unsigned int *mask);
@@ -170,14 +172,24 @@ static int gpio_regmap_set_direction(struct gpio_chip *chip,
 static int gpio_regmap_direction_input(struct gpio_chip *chip,
 				       unsigned int offset)
 {
+	struct gpio_regmap *gpio = gpiochip_get_data(chip);
+
+	if (gpio->has_pinctrl)
+		return pinctrl_gpio_direction_input(chip->base + offset);
+
 	return gpio_regmap_set_direction(chip, offset, false);
 }
 
 static int gpio_regmap_direction_output(struct gpio_chip *chip,
 					unsigned int offset, int value)
 {
+	struct gpio_regmap *gpio = gpiochip_get_data(chip);
+
 	gpio_regmap_set(chip, offset, value);
 
+	if (gpio->has_pinctrl)
+		return pinctrl_gpio_direction_output(chip->base + offset);
+
 	return gpio_regmap_set_direction(chip, offset, true);
 }
 
@@ -218,6 +230,14 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	if (config->reg_dir_out_base && config->reg_dir_in_base)
 		return ERR_PTR(-EINVAL);
 
+	/*
+	 * we need a direction register for implementing ->get_direction
+	 * even if ->direction_input/output is handled by pin control
+	 */
+	if (config->has_pinctrl && !(config->reg_dir_in_base ||
+				     config->reg_dir_out_base))
+		return ERR_PTR(-EINVAL);
+
 	/* only one of these should be provided */
 	if (config->reg_field_xlate && config->reg_mask_xlate)
 		return ERR_PTR(-EINVAL);
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index a673dbfe88a3..47acea8cca32 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -33,6 +33,10 @@ struct regmap;
  * @ngpio_per_reg:	Number of GPIOs per register
  * @irq_domain:		(Optional) IRQ domain if the controller is
  *			interrupt-capable
+ * @has_pinctrl:	If set, the GPIO chip is part of a combined pin control
+ *			and GPIO driver; use pinctrl_gpio_direction_input() and
+ *			pinctrl_gpio_direction_output() to implement direction
+ *			set operations.
  * @reg_mask_xlate:     (Optional) Translates base address and GPIO
  *			offset to a register/bitmask pair. If not
  *			given the default gpio_regmap_simple_xlate()
@@ -88,6 +92,8 @@ struct gpio_regmap_config {
 	int ngpio_per_reg;
 	struct irq_domain *irq_domain;
 
+	unsigned int has_pinctrl:1;
+
 	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
 			      unsigned int offset, unsigned int *reg,
 			      unsigned int *mask);
-- 
2.35.1


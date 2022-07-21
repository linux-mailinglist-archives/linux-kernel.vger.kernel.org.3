Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A9A57C7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiGUJbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiGUJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:30:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396087E82C;
        Thu, 21 Jul 2022 02:30:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y11so1849625lfs.6;
        Thu, 21 Jul 2022 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s151ffk1JIauk2lEB3TrZV+yG7gGvKpVixQvHLr+F1w=;
        b=nZvJDPK0EO6QY9MLTYOQ0LWUPTJZ5JUKK0SEj61HOjGzS4p4dNaOmtMk+ASvtvO0kx
         VvN0Jg0ed2dCQehW/9iVtgCAPxitukB6VZ29jQ9k4NV7Mz0gSPh5InWM/gTnb4DNn8Y4
         sQbFjRcLH33bYFC2t3Jyl+EyNzOFuNb4LGjth3GYI82qFrwTb0liiz+Uf1c6YQU7cdVY
         9DJi18H5P55gdWgJQcsPXkoo7YhU96Xwwu55mg7D0Qww43xwVMWuaboePe5HjAvPLwKy
         C5As6//osND0ELDE9TdlKYFu0Bthos9Il+0w9j/EuwSho/hJBVG3eO+AGN7DqG8Ob4NG
         wsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s151ffk1JIauk2lEB3TrZV+yG7gGvKpVixQvHLr+F1w=;
        b=oZDXFfPiHXcWB8/ICgUK8uNdifdyxXOv1OZt4x1OgjOZ2qvXFjgWZEEaowznwulf9Z
         djuxnpCo33LyIAG7NfQRXQHuoQolQB99cxsHPtojqrt9ACXV1aKVE6gTTQ1eL0Z05An2
         xI0YZupV4V9yCXv/Cdjyp4N3Ee+cR53q9wEzaBq9KDgnXtLmLkXw3+qTm8tQyrYbdCHN
         RadfbN8vzIu9M3XEJp9/xbjwFv4u6NpIr1dBdflK9ApalwuYdjobrqdC2IA3KnXviz59
         veYHcUVyYxU16ialqbXbUNRN1uMnUSfISGkuaMkUzakPAIpycCbJh3lkVIbZRaWY6Nx+
         dUrA==
X-Gm-Message-State: AJIora8vXL3VMQJXTSfXbruUy73D7/e/I84/JgvgP258ECX2OgOf+sm6
        4fI2mxfDss9AFf5c/CXf/ycxk3fJ6fk=
X-Google-Smtp-Source: AGRyM1uLU45d6nitV/svzhHqvt6/3qKj2nNBMf/FZIrIQ/ktIuvkN7xNwI/GV3FyTP60CY71VLOBnA==
X-Received: by 2002:a05:6512:33c5:b0:48a:1c38:e43 with SMTP id d5-20020a05651233c500b0048a1c380e43mr18876341lfg.671.1658395854412;
        Thu, 21 Jul 2022 02:30:54 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id y30-20020a19915e000000b0047f6b4f82d1sm323055lfj.250.2022.07.21.02.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 02:30:53 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH 1/2] gpio: gpio-74x164: add support for CDx4HC4094
Date:   Thu, 21 Jul 2022 11:34:21 +0200
Message-Id: <20220721093422.2173982-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

74hc4094 and 75hc4094 works similar to 74x164 but has an additional
storage latch associated with each stage for strobing data from the
serial input to parallell buffer tri-state output.

Add support for an optional strobe pin.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpio/gpio-74x164.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index e00c33310517..4a1c4de358e4 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -21,6 +21,7 @@ struct gen_74x164_chip {
 	struct gpio_chip	gpio_chip;
 	struct mutex		lock;
 	struct gpio_desc	*gpiod_oe;
+	struct gpio_desc	*gpiod_strobe;
 	u32			registers;
 	/*
 	 * Since the registers are chained, every byte sent will make
@@ -66,6 +67,10 @@ static void gen_74x164_set_value(struct gpio_chip *gc,
 		chip->buffer[bank] &= ~(1 << pin);
 
 	__gen_74x164_write_config(chip);
+
+	/*  Latch data to output pins*/
+	gpiod_set_value_cansleep(chip->gpiod_strobe, 1);
+	gpiod_set_value_cansleep(chip->gpiod_strobe, 0);
 	mutex_unlock(&chip->lock);
 }
 
@@ -87,6 +92,10 @@ static void gen_74x164_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 		chip->buffer[bank] |= bitmask;
 	}
 	__gen_74x164_write_config(chip);
+
+	/*  Latch data to output pins*/
+	gpiod_set_value_cansleep(chip->gpiod_strobe, 1);
+	gpiod_set_value_cansleep(chip->gpiod_strobe, 0);
 	mutex_unlock(&chip->lock);
 }
 
@@ -129,6 +138,12 @@ static int gen_74x164_probe(struct spi_device *spi)
 
 	gpiod_set_value_cansleep(chip->gpiod_oe, 1);
 
+	chip->gpiod_strobe = devm_gpiod_get_optional(&spi->dev, "strobe",
+			GPIOD_OUT_LOW);
+	if (IS_ERR(chip->gpiod_strobe))
+		return PTR_ERR(chip->gpiod_strobe);
+
+
 	spi_set_drvdata(spi, chip);
 
 	chip->gpio_chip.label = spi->modalias;
@@ -153,6 +168,10 @@ static int gen_74x164_probe(struct spi_device *spi)
 		goto exit_destroy;
 	}
 
+	/*  Latch data to output pins*/
+	gpiod_set_value_cansleep(chip->gpiod_strobe, 1);
+	gpiod_set_value_cansleep(chip->gpiod_strobe, 0);
+
 	ret = gpiochip_add_data(&chip->gpio_chip, chip);
 	if (!ret)
 		return 0;
@@ -182,6 +201,8 @@ MODULE_DEVICE_TABLE(spi, gen_74x164_spi_ids);
 static const struct of_device_id gen_74x164_dt_ids[] = {
 	{ .compatible = "fairchild,74hc595" },
 	{ .compatible = "nxp,74lvc594" },
+	{ .compatible = "ti,cd54hc4094" },
+	{ .compatible = "ti,cd74hc4094" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, gen_74x164_dt_ids);
-- 
2.36.1


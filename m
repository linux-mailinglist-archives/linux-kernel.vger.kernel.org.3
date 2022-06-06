Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC1A53E79D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbiFFOgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239829AbiFFOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:36:21 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7E31339D1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:36:13 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id r3-20020a9d5cc3000000b0060ae1789875so10856542oti.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7G/D0jrlvNgMc+Tde0XVhDy5Wvyd9twlgo7j0TICrRc=;
        b=niXsWsKtWaVclpeC3TuRqVL1gv/xiSdzbpfZBGPvo0JeRr1OVIO82F5WbhdFjcB//4
         8By7sa2TDe1Bo0i1L7FUiFEurXjSReM/UKd30yUHG0AQNZd4wI8t/A9W78T04H4R1gbi
         VTgAvArN4LOqQO2k87PUZAiIyo9w98XM7MWQlvWNVno9wmPq6VaBtcMpBq7AOIuiw9nh
         Oyzh35dF666yIYgUnbeovalOS396uhlPO05sF+HMm55Zd+g+tMiungG0sGyVo5Itd/gL
         nidcFegF3kbBDl106IchsNJuUp+rfBXcHRQNxNn4KPGkO4yLipEd6Ottt09Jy2WclR4H
         o/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7G/D0jrlvNgMc+Tde0XVhDy5Wvyd9twlgo7j0TICrRc=;
        b=3lzLFHBUbKwun8DkOPqbas9HKZ/Se8YIgVgKQn6vkFOJnN0bgXTo87drKUfcakUB17
         E9gkSVz0JpskXX5JeHPuGr25tInFs5siK2fXwf17/UDzv6vNN8q/UdmEZ+xMndn0JZ/M
         HftOqkelB+acm6woxxRSQPesaTJBDhCd6uNlStTLGsoiTS+u+YqEgpyRJqyTEMqzvX22
         /g3R4i4DSOet/GRW/Wzv/wMK2mK5MSwUmi6aFST3S3pCLLH/C3I7M3EalcuNKpAN3pxl
         kofpdzyPJRGzcMH2D8co8yGg4PgkON0g0Yedg69kn3BJ9gIHNOxH13TBgGKJjP3sWo82
         DBJw==
X-Gm-Message-State: AOAM533H7O2PP7OCkPBwupVe9M6g/I2/i7+OAj5pia5YOmA/j5LvG/Vf
        gSod4SFqeCgHZZ3MvdTRb7v0+A==
X-Google-Smtp-Source: ABdhPJzkR5XFlreMYTBXKawn5WYoiJ7aAGM+h9awXDBuTc024Dti6K+voL1nOEzn8EhccycZHf8H6Q==
X-Received: by 2002:a9d:4c6:0:b0:60b:537c:f4c1 with SMTP id 64-20020a9d04c6000000b0060b537cf4c1mr10492707otm.16.1654526172844;
        Mon, 06 Jun 2022 07:36:12 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id u13-20020a056871008d00b000f5d4e5b9a0sm6942791oaa.2.2022.06.06.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:36:12 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 4/5] gpio: gpio-mm: Implement and utilize register structures
Date:   Mon,  6 Jun 2022 10:33:19 -0400
Message-Id: <b808434414689097e524aea9c31627dc1591603a.1654525394.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654525394.git.william.gray@linaro.org>
References: <cover.1654525394.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce magic numbers and improve code readability by implementing and
utilizing named register data structures.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-gpio-mm.c | 116 ++++++++++++++++++++++--------------
 1 file changed, 72 insertions(+), 44 deletions(-)

diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index 097a06463d01..8f67442b8715 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -27,6 +27,16 @@ static unsigned int num_gpiomm;
 module_param_hw_array(base, uint, ioport, &num_gpiomm, 0);
 MODULE_PARM_DESC(base, "Diamond Systems GPIO-MM base addresses");
 
+/**
+ * struct i8255_reg - Intel 8255 register structure
+ * @port:	Port A, B, and C
+ * @control:	Control register
+ */
+struct i8255_reg {
+	u8 port[3];
+	u8 control;
+};
+
 /**
  * struct gpiomm_gpio - GPIO device private data structure
  * @chip:	instance of the gpio_chip
@@ -34,7 +44,7 @@ MODULE_PARM_DESC(base, "Diamond Systems GPIO-MM base addresses");
  * @out_state:	output bits state
  * @control:	Control registers state
  * @lock:	synchronization lock to prevent I/O race conditions
- * @base:	base port address of the GPIO device
+ * @dio:	Digital I/O register groups
  */
 struct gpiomm_gpio {
 	struct gpio_chip chip;
@@ -42,7 +52,7 @@ struct gpiomm_gpio {
 	unsigned char out_state[6];
 	unsigned char control[2];
 	spinlock_t lock;
-	void __iomem *base;
+	struct i8255_reg __iomem *dio;
 };
 
 static int gpiomm_gpio_get_direction(struct gpio_chip *chip,
@@ -63,32 +73,33 @@ static int gpiomm_gpio_direction_input(struct gpio_chip *chip,
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
 	const unsigned int io_port = offset / 8;
-	const unsigned int control_port = io_port / 3;
+	const unsigned long group = io_port / 3;
+	const unsigned long port = io_port - (group * 3);
 	unsigned long flags;
 	unsigned int control;
 
 	spin_lock_irqsave(&gpiommgpio->lock, flags);
 
 	/* Check if configuring Port C */
-	if (io_port == 2 || io_port == 5) {
+	if (port == 2) {
 		/* Port C can be configured by nibble */
 		if (offset % 8 > 3) {
 			gpiommgpio->io_state[io_port] |= 0xF0;
-			gpiommgpio->control[control_port] |= BIT(3);
+			gpiommgpio->control[group] |= BIT(3);
 		} else {
 			gpiommgpio->io_state[io_port] |= 0x0F;
-			gpiommgpio->control[control_port] |= BIT(0);
+			gpiommgpio->control[group] |= BIT(0);
 		}
 	} else {
 		gpiommgpio->io_state[io_port] |= 0xFF;
-		if (io_port == 0 || io_port == 3)
-			gpiommgpio->control[control_port] |= BIT(4);
+		if (port == 0)
+			gpiommgpio->control[group] |= BIT(4);
 		else
-			gpiommgpio->control[control_port] |= BIT(1);
+			gpiommgpio->control[group] |= BIT(1);
 	}
 
-	control = BIT(7) | gpiommgpio->control[control_port];
-	iowrite8(control, gpiommgpio->base + 3 + control_port*4);
+	control = BIT(7) | gpiommgpio->control[group];
+	iowrite8(control, &gpiommgpio->dio[group].control);
 
 	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
 
@@ -100,30 +111,31 @@ static int gpiomm_gpio_direction_output(struct gpio_chip *chip,
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
 	const unsigned int io_port = offset / 8;
-	const unsigned int control_port = io_port / 3;
+	const unsigned long group = io_port / 3;
+	const unsigned long port = io_port - (group * 3);
 	const unsigned int mask = BIT(offset % 8);
-	const unsigned int out_port = (io_port > 2) ? io_port + 1 : io_port;
+	struct i8255_reg __iomem *const dio = gpiommgpio->dio + group;
 	unsigned long flags;
 	unsigned int control;
 
 	spin_lock_irqsave(&gpiommgpio->lock, flags);
 
 	/* Check if configuring Port C */
-	if (io_port == 2 || io_port == 5) {
+	if (port == 2) {
 		/* Port C can be configured by nibble */
 		if (offset % 8 > 3) {
 			gpiommgpio->io_state[io_port] &= 0x0F;
-			gpiommgpio->control[control_port] &= ~BIT(3);
+			gpiommgpio->control[group] &= ~BIT(3);
 		} else {
 			gpiommgpio->io_state[io_port] &= 0xF0;
-			gpiommgpio->control[control_port] &= ~BIT(0);
+			gpiommgpio->control[group] &= ~BIT(0);
 		}
 	} else {
 		gpiommgpio->io_state[io_port] &= 0x00;
-		if (io_port == 0 || io_port == 3)
-			gpiommgpio->control[control_port] &= ~BIT(4);
+		if (port == 0)
+			gpiommgpio->control[group] &= ~BIT(4);
 		else
-			gpiommgpio->control[control_port] &= ~BIT(1);
+			gpiommgpio->control[group] &= ~BIT(1);
 	}
 
 	if (value)
@@ -131,10 +143,10 @@ static int gpiomm_gpio_direction_output(struct gpio_chip *chip,
 	else
 		gpiommgpio->out_state[io_port] &= ~mask;
 
-	control = BIT(7) | gpiommgpio->control[control_port];
-	iowrite8(control, gpiommgpio->base + 3 + control_port*4);
+	control = BIT(7) | gpiommgpio->control[group];
+	iowrite8(control, &dio->control);
 
-	iowrite8(gpiommgpio->out_state[io_port], gpiommgpio->base + out_port);
+	iowrite8(gpiommgpio->out_state[io_port], dio->port + port);
 
 	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
 
@@ -146,7 +158,8 @@ static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
 	const unsigned int port = offset / 8;
 	const unsigned int mask = BIT(offset % 8);
-	const unsigned int in_port = (port > 2) ? port + 1 : port;
+	const unsigned long group = port / 3;
+	const unsigned long in_port = port - (group * 3);
 	unsigned long flags;
 	unsigned int port_state;
 
@@ -158,29 +171,33 @@ static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
 		return -EINVAL;
 	}
 
-	port_state = ioread8(gpiommgpio->base + in_port);
+	port_state = ioread8(gpiommgpio->dio[group].port + in_port);
 
 	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
 
 	return !!(port_state & mask);
 }
 
-static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-
 static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
 	unsigned long offset;
 	unsigned long gpio_mask;
-	void __iomem *port_addr;
+	unsigned long port;
+	unsigned long group;
+	unsigned long in_port;
+	u8 __iomem *port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		port_addr = gpiommgpio->base + ports[offset / 8];
+	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
+		port = offset / 8;
+		group = port / 3;
+		in_port = port - (group * 3);
+		port_addr = gpiommgpio->dio[group].port + in_port;
 		port_state = ioread8(port_addr) & gpio_mask;
 
 		bitmap_set_value8(bits, port_state, offset);
@@ -195,7 +212,8 @@ static void gpiomm_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
 	const unsigned int port = offset / 8;
 	const unsigned int mask = BIT(offset % 8);
-	const unsigned int out_port = (port > 2) ? port + 1 : port;
+	const unsigned long group = port / 3;
+	const unsigned long out_port = port - (group * 3);
 	unsigned long flags;
 
 	spin_lock_irqsave(&gpiommgpio->lock, flags);
@@ -205,7 +223,8 @@ static void gpiomm_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	else
 		gpiommgpio->out_state[port] &= ~mask;
 
-	iowrite8(gpiommgpio->out_state[port], gpiommgpio->base + out_port);
+	iowrite8(gpiommgpio->out_state[port],
+		 gpiommgpio->dio[group].port + out_port);
 
 	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
 }
@@ -217,13 +236,17 @@ static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long offset;
 	unsigned long gpio_mask;
 	size_t index;
-	void __iomem *port_addr;
+	size_t group;
+	size_t out_port;
+	u8 __iomem *port_addr;
 	unsigned long bitmask;
 	unsigned long flags;
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
 		index = offset / 8;
-		port_addr = gpiommgpio->base + ports[index];
+		group = index / 3;
+		out_port = index - (group * 3);
+		port_addr = gpiommgpio->dio[group].port + out_port;
 
 		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
 
@@ -250,6 +273,17 @@ static const char *gpiomm_names[GPIOMM_NGPIO] = {
 	"Port 2C2", "Port 2C3", "Port 2C4", "Port 2C5", "Port 2C6", "Port 2C7",
 };
 
+static void gpiomm_init_dio(struct i8255_reg __iomem *const dio)
+{
+	/* Activate Mode Set; set Mode 0 output mode for Port A, B, and C */
+	iowrite8(0x80, &dio->control);
+
+	/* Initialize all GPIO to 0 */
+	iowrite8(0x00, &dio->port[0]);
+	iowrite8(0x00, &dio->port[1]);
+	iowrite8(0x00, &dio->port[2]);
+}
+
 static int gpiomm_probe(struct device *dev, unsigned int id)
 {
 	struct gpiomm_gpio *gpiommgpio;
@@ -266,8 +300,8 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	gpiommgpio->base = devm_ioport_map(dev, base[id], GPIOMM_EXTENT);
-	if (!gpiommgpio->base)
+	gpiommgpio->dio = devm_ioport_map(dev, base[id], GPIOMM_EXTENT);
+	if (!gpiommgpio->dio)
 		return -ENOMEM;
 
 	gpiommgpio->chip.label = name;
@@ -293,14 +327,8 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
 	}
 
 	/* initialize all GPIO as output */
-	iowrite8(0x80, gpiommgpio->base + 3);
-	iowrite8(0x00, gpiommgpio->base);
-	iowrite8(0x00, gpiommgpio->base + 1);
-	iowrite8(0x00, gpiommgpio->base + 2);
-	iowrite8(0x80, gpiommgpio->base + 7);
-	iowrite8(0x00, gpiommgpio->base + 4);
-	iowrite8(0x00, gpiommgpio->base + 5);
-	iowrite8(0x00, gpiommgpio->base + 6);
+	gpiomm_init_dio(&gpiommgpio->dio[0]);
+	gpiomm_init_dio(&gpiommgpio->dio[1]);
 
 	return 0;
 }
-- 
2.36.1


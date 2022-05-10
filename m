Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409FA5222D7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348603AbiEJRhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348268AbiEJRfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:35:32 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D6447AD2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:31:24 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id bs17so4154430qkb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H2AK5sECXXWOxpJaFbUfWcwhgtP35mSHuJJkQivb894=;
        b=VcKW5OAEtI9CIIGbpJVturNwnTEXXxGHV15anSA7hIHQNL8i+uXg1rRWq5C3e94fZ0
         P+9fP2H/Jy+DHF5Nk/I9YsLyWm9PRGMXopfp6qAucu6aoDwMtNTGJFyNBRowGI3dJvAP
         JHKNdUYERax1iYceZ1cTZzfn5qR4Bzs6VPuY4ZLtvfPNncpu1R5DJsklss8fdztFoPg0
         7Cribio15rvAGrbr8TXCBubM4A24nK1EnQx8XxHN5tlzrPGan24EVzUp4BoxQfav2xE0
         R2W4xUzZWygvNbcZEeTOlkFxDkjetJEGog2gcoJyCRda2+0e4fe4l9sFnWBquTaHzmot
         54VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2AK5sECXXWOxpJaFbUfWcwhgtP35mSHuJJkQivb894=;
        b=uvj+Jou2ixIHPz49vlpMM6QIJBrdfsDXJ7HLO20dEdRdQi03rEtkjI1gsvyJ43B/Vx
         DMsvSdJWVJkXV2JsC/wUjlXbaq6pOs4F0jzMHM5AmuXG2oBhxwZ2cyXraC3VWjLuI14w
         st64pj42p6n0i9nB1buJXs1eWoEDR/zvYfxTJf7ieNqA67S2QoNLhFhWse7KYXl/LbEm
         mOPnRtj5ayiqACW/nfcY5pohaT/6p24ykoO9AedrfGWBVhDrBqkGjGi21ZwScV9muXz6
         Q55E2UXeNUYCa4ZaBH9oLW9r23FISb9Mc6BVl1+iWPXYW+F9X616s5XIr9J4HOk3rhI3
         wjVA==
X-Gm-Message-State: AOAM532W+TS6MHbRHngVqnII/E6A+Eor/GiHT17t1mw+O2x7gcpEmgtb
        6pxl4OTxeOtAnGInaEJ9il/BccuQvtnM4g==
X-Google-Smtp-Source: ABdhPJx9VrK2hOiDY6jNzkQ/GWTB+b92TOrNM9oe99NIxVJ138UceIhQn9xggxOFs+XzKDFvrIfirg==
X-Received: by 2002:a37:bbc4:0:b0:69b:db2c:c962 with SMTP id l187-20020a37bbc4000000b0069bdb2cc962mr16165564qkf.565.1652203883755;
        Tue, 10 May 2022 10:31:23 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a150600b0069ff8ebec64sm8490411qkk.103.2022.05.10.10.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:31:23 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, macro@orcam.me.uk,
        William Breathitt Gray <william.gray@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 5/8] gpio: gpio-mm: Utilize iomap interface
Date:   Tue, 10 May 2022 13:30:57 -0400
Message-Id: <1b274435871047e85fc8bbbf15840424632c47d0.1652201921.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1652201921.git.william.gray@linaro.org>
References: <cover.1652201921.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver doesn't need to access I/O ports directly via inb()/outb()
and friends. This patch abstracts such access by calling ioport_map()
to enable the use of more typical ioread8()/iowrite8() I/O memory
accessor calls.

Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-gpio-mm.c | 43 +++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index b89b8c5ff1f5..097a06463d01 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -42,7 +42,7 @@ struct gpiomm_gpio {
 	unsigned char out_state[6];
 	unsigned char control[2];
 	spinlock_t lock;
-	unsigned int base;
+	void __iomem *base;
 };
 
 static int gpiomm_gpio_get_direction(struct gpio_chip *chip,
@@ -64,7 +64,6 @@ static int gpiomm_gpio_direction_input(struct gpio_chip *chip,
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
 	const unsigned int io_port = offset / 8;
 	const unsigned int control_port = io_port / 3;
-	const unsigned int control_addr = gpiommgpio->base + 3 + control_port*4;
 	unsigned long flags;
 	unsigned int control;
 
@@ -89,7 +88,7 @@ static int gpiomm_gpio_direction_input(struct gpio_chip *chip,
 	}
 
 	control = BIT(7) | gpiommgpio->control[control_port];
-	outb(control, control_addr);
+	iowrite8(control, gpiommgpio->base + 3 + control_port*4);
 
 	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
 
@@ -103,7 +102,6 @@ static int gpiomm_gpio_direction_output(struct gpio_chip *chip,
 	const unsigned int io_port = offset / 8;
 	const unsigned int control_port = io_port / 3;
 	const unsigned int mask = BIT(offset % 8);
-	const unsigned int control_addr = gpiommgpio->base + 3 + control_port*4;
 	const unsigned int out_port = (io_port > 2) ? io_port + 1 : io_port;
 	unsigned long flags;
 	unsigned int control;
@@ -134,9 +132,9 @@ static int gpiomm_gpio_direction_output(struct gpio_chip *chip,
 		gpiommgpio->out_state[io_port] &= ~mask;
 
 	control = BIT(7) | gpiommgpio->control[control_port];
-	outb(control, control_addr);
+	iowrite8(control, gpiommgpio->base + 3 + control_port*4);
 
-	outb(gpiommgpio->out_state[io_port], gpiommgpio->base + out_port);
+	iowrite8(gpiommgpio->out_state[io_port], gpiommgpio->base + out_port);
 
 	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
 
@@ -160,7 +158,7 @@ static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
 		return -EINVAL;
 	}
 
-	port_state = inb(gpiommgpio->base + in_port);
+	port_state = ioread8(gpiommgpio->base + in_port);
 
 	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
 
@@ -175,7 +173,7 @@ static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
 	unsigned long offset;
 	unsigned long gpio_mask;
-	unsigned int port_addr;
+	void __iomem *port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
@@ -183,7 +181,7 @@ static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 
 	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
 		port_addr = gpiommgpio->base + ports[offset / 8];
-		port_state = inb(port_addr) & gpio_mask;
+		port_state = ioread8(port_addr) & gpio_mask;
 
 		bitmap_set_value8(bits, port_state, offset);
 	}
@@ -207,7 +205,7 @@ static void gpiomm_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	else
 		gpiommgpio->out_state[port] &= ~mask;
 
-	outb(gpiommgpio->out_state[port], gpiommgpio->base + out_port);
+	iowrite8(gpiommgpio->out_state[port], gpiommgpio->base + out_port);
 
 	spin_unlock_irqrestore(&gpiommgpio->lock, flags);
 }
@@ -219,7 +217,7 @@ static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long offset;
 	unsigned long gpio_mask;
 	size_t index;
-	unsigned int port_addr;
+	void __iomem *port_addr;
 	unsigned long bitmask;
 	unsigned long flags;
 
@@ -234,7 +232,7 @@ static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
 		/* update output state data and set device gpio register */
 		gpiommgpio->out_state[index] &= ~gpio_mask;
 		gpiommgpio->out_state[index] |= bitmask;
-		outb(gpiommgpio->out_state[index], port_addr);
+		iowrite8(gpiommgpio->out_state[index], port_addr);
 
 		spin_unlock_irqrestore(&gpiommgpio->lock, flags);
 	}
@@ -268,6 +266,10 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
+	gpiommgpio->base = devm_ioport_map(dev, base[id], GPIOMM_EXTENT);
+	if (!gpiommgpio->base)
+		return -ENOMEM;
+
 	gpiommgpio->chip.label = name;
 	gpiommgpio->chip.parent = dev;
 	gpiommgpio->chip.owner = THIS_MODULE;
@@ -281,7 +283,6 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
 	gpiommgpio->chip.get_multiple = gpiomm_gpio_get_multiple;
 	gpiommgpio->chip.set = gpiomm_gpio_set;
 	gpiommgpio->chip.set_multiple = gpiomm_gpio_set_multiple;
-	gpiommgpio->base = base[id];
 
 	spin_lock_init(&gpiommgpio->lock);
 
@@ -292,14 +293,14 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
 	}
 
 	/* initialize all GPIO as output */
-	outb(0x80, base[id] + 3);
-	outb(0x00, base[id]);
-	outb(0x00, base[id] + 1);
-	outb(0x00, base[id] + 2);
-	outb(0x80, base[id] + 7);
-	outb(0x00, base[id] + 4);
-	outb(0x00, base[id] + 5);
-	outb(0x00, base[id] + 6);
+	iowrite8(0x80, gpiommgpio->base + 3);
+	iowrite8(0x00, gpiommgpio->base);
+	iowrite8(0x00, gpiommgpio->base + 1);
+	iowrite8(0x00, gpiommgpio->base + 2);
+	iowrite8(0x80, gpiommgpio->base + 7);
+	iowrite8(0x00, gpiommgpio->base + 4);
+	iowrite8(0x00, gpiommgpio->base + 5);
+	iowrite8(0x00, gpiommgpio->base + 6);
 
 	return 0;
 }
-- 
2.35.3


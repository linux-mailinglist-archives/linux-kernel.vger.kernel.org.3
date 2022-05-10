Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F60F5222DA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348643AbiEJRhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348247AbiEJRfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:35:31 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868BD3BBC0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:31:22 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id o18so14055159qtk.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bGocoAF4XnDshiIFwV2UZS9TD3DaSuUYN+zlu0xXJbk=;
        b=F9CRF4WkRUCxKWi+OaY2dPbGEQmUQz6J7M77VupTCPKmE79pxzAfkFGa0h+w0iHlwi
         v4LnIT9iNqOMIvTWQcXpV/J9Kgd6aDkX/wJz+pekpBWDH3jatuMqzhhOpxGBuzvk9/eW
         bRKoic0IHtRa0L2QqY9NFqkhbyFufoV/I1FRNJnDhjGy8eHtxZ5y+9nnYoeSYT4n/dfV
         BnHXGZ7EIJdhLe10cd3XjTqqgh4aFd4n5C3SA/JwDG0qgfge2JViqCgsaFKgtiMTbHta
         dvEomHDGJMwfsHe0VVo0I24iPpsNwp2dOv3RocpQzPMGGfSBCFSxwtOD8RzymP7j1FAS
         3sYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bGocoAF4XnDshiIFwV2UZS9TD3DaSuUYN+zlu0xXJbk=;
        b=kKYNlANr93qNOEOE1cH4nrWrfG6SxWAXBoFYpwyHTF2KJbqMkayYt6xf0XRkYR/UhK
         V+eXB8F96SOlvB7fkiqP2ICAJvJ8xtTTLFivJ/coE2spioZkAg1zl36/7uOGojoJkiZq
         PTzKBs/AVCA6o9KU20628FVzieAG0FSjiFmbY6aSsF6M+DCrNcOAJKlx4BMxFx5WjQE7
         nll79TI/T59AMjQS7/pRW17tQ1+OkGojFBdpzmnHMKbXioMEsoziw7k/tpo6rJws9i84
         5khyzBwqEYIEu6rDu9bCUZQ+p2lxqauigOaaheMnT/tRaICcCjwPDaJKwkgmUn2W91H2
         yGfQ==
X-Gm-Message-State: AOAM532oK6xjmeA3I/OggfVJ80CrPrwZeE/BP9c4ZEGO2TWMUMpLugov
        3VVFqQ6JSpQ5wOCCQ+HKv7pBdA==
X-Google-Smtp-Source: ABdhPJy5RQkWywaRqfa0z64Zh9FS8XQyNqa+2kkzAzAadQ4ALqgkMC+5ABn4xV4HXIs+3d8d0qlibQ==
X-Received: by 2002:ac8:598a:0:b0:2f3:cbf4:7b4e with SMTP id e10-20020ac8598a000000b002f3cbf47b4emr18654814qte.449.1652203881569;
        Tue, 10 May 2022 10:31:21 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a150600b0069ff8ebec64sm8490411qkk.103.2022.05.10.10.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:31:21 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, macro@orcam.me.uk,
        William Breathitt Gray <william.gray@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 2/8] gpio: 104-dio-48e: Utilize iomap interface
Date:   Tue, 10 May 2022 13:30:54 -0400
Message-Id: <8bc6e7d2fef9f0c320580dd8266eb27da2670feb.1652201921.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1652201921.git.william.gray@linaro.org>
References: <cover.1652201921.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/gpio/gpio-104-dio-48e.c | 63 +++++++++++++++++----------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 6bf41040c41f..f118ad9bcd33 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -49,7 +49,7 @@ struct dio48e_gpio {
 	unsigned char out_state[6];
 	unsigned char control[2];
 	raw_spinlock_t lock;
-	unsigned int base;
+	void __iomem *base;
 	unsigned char irq_mask;
 };
 
@@ -70,7 +70,7 @@ static int dio48e_gpio_direction_input(struct gpio_chip *chip, unsigned int offs
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
 	const unsigned int io_port = offset / 8;
 	const unsigned int control_port = io_port / 3;
-	const unsigned int control_addr = dio48egpio->base + 3 + control_port * 4;
+	void __iomem *const control_addr = dio48egpio->base + 3 + control_port * 4;
 	unsigned long flags;
 	unsigned int control;
 
@@ -95,9 +95,9 @@ static int dio48e_gpio_direction_input(struct gpio_chip *chip, unsigned int offs
 	}
 
 	control = BIT(7) | dio48egpio->control[control_port];
-	outb(control, control_addr);
+	iowrite8(control, control_addr);
 	control &= ~BIT(7);
-	outb(control, control_addr);
+	iowrite8(control, control_addr);
 
 	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
 
@@ -111,7 +111,7 @@ static int dio48e_gpio_direction_output(struct gpio_chip *chip, unsigned int off
 	const unsigned int io_port = offset / 8;
 	const unsigned int control_port = io_port / 3;
 	const unsigned int mask = BIT(offset % 8);
-	const unsigned int control_addr = dio48egpio->base + 3 + control_port * 4;
+	void __iomem *const control_addr = dio48egpio->base + 3 + control_port * 4;
 	const unsigned int out_port = (io_port > 2) ? io_port + 1 : io_port;
 	unsigned long flags;
 	unsigned int control;
@@ -142,12 +142,12 @@ static int dio48e_gpio_direction_output(struct gpio_chip *chip, unsigned int off
 		dio48egpio->out_state[io_port] &= ~mask;
 
 	control = BIT(7) | dio48egpio->control[control_port];
-	outb(control, control_addr);
+	iowrite8(control, control_addr);
 
-	outb(dio48egpio->out_state[io_port], dio48egpio->base + out_port);
+	iowrite8(dio48egpio->out_state[io_port], dio48egpio->base + out_port);
 
 	control &= ~BIT(7);
-	outb(control, control_addr);
+	iowrite8(control, control_addr);
 
 	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
 
@@ -171,7 +171,7 @@ static int dio48e_gpio_get(struct gpio_chip *chip, unsigned int offset)
 		return -EINVAL;
 	}
 
-	port_state = inb(dio48egpio->base + in_port);
+	port_state = ioread8(dio48egpio->base + in_port);
 
 	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
 
@@ -186,7 +186,7 @@ static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
 	unsigned long offset;
 	unsigned long gpio_mask;
-	unsigned int port_addr;
+	void __iomem *port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
@@ -194,7 +194,7 @@ static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 
 	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
 		port_addr = dio48egpio->base + ports[offset / 8];
-		port_state = inb(port_addr) & gpio_mask;
+		port_state = ioread8(port_addr) & gpio_mask;
 
 		bitmap_set_value8(bits, port_state, offset);
 	}
@@ -217,7 +217,7 @@ static void dio48e_gpio_set(struct gpio_chip *chip, unsigned int offset, int val
 	else
 		dio48egpio->out_state[port] &= ~mask;
 
-	outb(dio48egpio->out_state[port], dio48egpio->base + out_port);
+	iowrite8(dio48egpio->out_state[port], dio48egpio->base + out_port);
 
 	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
 }
@@ -229,7 +229,7 @@ static void dio48e_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long offset;
 	unsigned long gpio_mask;
 	size_t index;
-	unsigned int port_addr;
+	void __iomem *port_addr;
 	unsigned long bitmask;
 	unsigned long flags;
 
@@ -244,7 +244,7 @@ static void dio48e_gpio_set_multiple(struct gpio_chip *chip,
 		/* update output state data and set device gpio register */
 		dio48egpio->out_state[index] &= ~gpio_mask;
 		dio48egpio->out_state[index] |= bitmask;
-		outb(dio48egpio->out_state[index], port_addr);
+		iowrite8(dio48egpio->out_state[index], port_addr);
 
 		raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
 	}
@@ -274,7 +274,7 @@ static void dio48e_irq_mask(struct irq_data *data)
 
 	if (!dio48egpio->irq_mask)
 		/* disable interrupts */
-		inb(dio48egpio->base + 0xB);
+		ioread8(dio48egpio->base + 0xB);
 
 	raw_spin_unlock_irqrestore(&dio48egpio->lock, flags);
 }
@@ -294,8 +294,8 @@ static void dio48e_irq_unmask(struct irq_data *data)
 
 	if (!dio48egpio->irq_mask) {
 		/* enable interrupts */
-		outb(0x00, dio48egpio->base + 0xF);
-		outb(0x00, dio48egpio->base + 0xB);
+		iowrite8(0x00, dio48egpio->base + 0xF);
+		iowrite8(0x00, dio48egpio->base + 0xB);
 	}
 
 	if (offset == 19)
@@ -341,7 +341,7 @@ static irqreturn_t dio48e_irq_handler(int irq, void *dev_id)
 
 	raw_spin_lock(&dio48egpio->lock);
 
-	outb(0x00, dio48egpio->base + 0xF);
+	iowrite8(0x00, dio48egpio->base + 0xF);
 
 	raw_spin_unlock(&dio48egpio->lock);
 
@@ -373,7 +373,7 @@ static int dio48e_irq_init_hw(struct gpio_chip *gc)
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(gc);
 
 	/* Disable IRQ by default */
-	inb(dio48egpio->base + 0xB);
+	ioread8(dio48egpio->base + 0xB);
 
 	return 0;
 }
@@ -395,6 +395,10 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
+	dio48egpio->base = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
+	if (!dio48egpio->base)
+		return -ENOMEM;
+
 	dio48egpio->chip.label = name;
 	dio48egpio->chip.parent = dev;
 	dio48egpio->chip.owner = THIS_MODULE;
@@ -408,7 +412,6 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	dio48egpio->chip.get_multiple = dio48e_gpio_get_multiple;
 	dio48egpio->chip.set = dio48e_gpio_set;
 	dio48egpio->chip.set_multiple = dio48e_gpio_set_multiple;
-	dio48egpio->base = base[id];
 
 	girq = &dio48egpio->chip.irq;
 	girq->chip = &dio48e_irqchip;
@@ -423,16 +426,16 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	raw_spin_lock_init(&dio48egpio->lock);
 
 	/* initialize all GPIO as output */
-	outb(0x80, base[id] + 3);
-	outb(0x00, base[id]);
-	outb(0x00, base[id] + 1);
-	outb(0x00, base[id] + 2);
-	outb(0x00, base[id] + 3);
-	outb(0x80, base[id] + 7);
-	outb(0x00, base[id] + 4);
-	outb(0x00, base[id] + 5);
-	outb(0x00, base[id] + 6);
-	outb(0x00, base[id] + 7);
+	iowrite8(0x80, dio48egpio->base + 3);
+	iowrite8(0x00, dio48egpio->base);
+	iowrite8(0x00, dio48egpio->base + 1);
+	iowrite8(0x00, dio48egpio->base + 2);
+	iowrite8(0x00, dio48egpio->base + 3);
+	iowrite8(0x80, dio48egpio->base + 7);
+	iowrite8(0x00, dio48egpio->base + 4);
+	iowrite8(0x00, dio48egpio->base + 5);
+	iowrite8(0x00, dio48egpio->base + 6);
+	iowrite8(0x00, dio48egpio->base + 7);
 
 	err = devm_gpiochip_add_data(dev, &dio48egpio->chip, dio48egpio);
 	if (err) {
-- 
2.35.3


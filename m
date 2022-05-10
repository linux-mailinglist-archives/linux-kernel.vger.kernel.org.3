Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F2D5222D2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348260AbiEJRfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348250AbiEJRfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:35:32 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C590496BA
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:31:25 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t11so14056166qto.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=69H/OSOuPn7SmYjJsCkxqhmQsUZwmRmjFUMtoE7YesE=;
        b=UT+BIGsLrpFrpGwMeYdjS97ZGaREc9gwyhtxzyet08ZimzRKyOOa0e+1CNB67SAGbU
         w1IVgmYhZ5Ignn3dFihVaNdxfa898WyL87Y1HBgKBnDXNuek4lPWXk/oBEXskF1veNub
         gRBA62IXTJM2T7SdXZVgoV9rLAm6eOTAYFsJNUE5DDISL2BN60BjO8ZIQhR8zcoWl+fB
         bGfxS8V9P7LulhcGYOkoC5tt1il0S3W0jrVjIT0Ushl1xUcIOvlYxI9kyH4wxet2pOaC
         gX6U4wwCP/x3rJkW4j6X83iPpkObOVm7HRhksWRbH2subi2D2XnoNiZm53IrpVT6ICWN
         AGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=69H/OSOuPn7SmYjJsCkxqhmQsUZwmRmjFUMtoE7YesE=;
        b=Gf1eJYm/OrpCVccM8MDuYJ9p259LTcg8Ysk7Hl820EyATKBLqVMlMpZHp2/Z1wlOVq
         w6ofCuRsr7qNo3jB+xB7LYcW/uQW84rBf6r4xjAibAOeSbpUmy2TFR4nv0dBgwrsF9E1
         M8YmZAN14E8uKeNCrwPaTYUXbdu+8Ivn7XOqUL6L1xD1vU3B+SyHAl7eqUmRuURP7hq4
         o3sY4L82k7sINayKyn5o+Gpw2qALVHdPr/SPwL0JOOerlk27jHPsc0Q79nlU4W0O2LfK
         1VPjoBPEMhJiIelCc9a66Kwnt1NDoEz2C7OCIgj1x/s2dZDOdVzdU3oK8Hx0MBaMbd6U
         q6yw==
X-Gm-Message-State: AOAM533qu0PWU5P/tBlUH/pmCWkl9qtVbZuRt09BCfHiZLg2kDJiYVfm
        1auUvudzwXSA42NFDEhriNsf9A==
X-Google-Smtp-Source: ABdhPJww3LD3FhZdBaUtwi6pBZUOxCPehLydw6w/Tx9Ck8N1/994c9xJszrkobMjbAMq8ml43XWqmQ==
X-Received: by 2002:a05:622a:54d:b0:2f3:ce29:234a with SMTP id m13-20020a05622a054d00b002f3ce29234amr15998280qtx.559.1652203884456;
        Tue, 10 May 2022 10:31:24 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a150600b0069ff8ebec64sm8490411qkk.103.2022.05.10.10.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:31:24 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, macro@orcam.me.uk,
        William Breathitt Gray <william.gray@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 6/8] gpio: ws16c48: Utilize iomap interface
Date:   Tue, 10 May 2022 13:30:58 -0400
Message-Id: <817800777df540e6d92b4b8aec832e68488a4eaf.1652201921.git.william.gray@linaro.org>
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
 drivers/gpio/gpio-ws16c48.c | 65 +++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index bb02a82e22f4..5078631d8014 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -47,7 +47,7 @@ struct ws16c48_gpio {
 	raw_spinlock_t lock;
 	unsigned long irq_mask;
 	unsigned long flow_mask;
-	unsigned base;
+	void __iomem *base;
 };
 
 static int ws16c48_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
@@ -73,7 +73,7 @@ static int ws16c48_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 
 	ws16c48gpio->io_state[port] |= mask;
 	ws16c48gpio->out_state[port] &= ~mask;
-	outb(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
+	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 
@@ -95,7 +95,7 @@ static int ws16c48_gpio_direction_output(struct gpio_chip *chip,
 		ws16c48gpio->out_state[port] |= mask;
 	else
 		ws16c48gpio->out_state[port] &= ~mask;
-	outb(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
+	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 
@@ -118,7 +118,7 @@ static int ws16c48_gpio_get(struct gpio_chip *chip, unsigned offset)
 		return -EINVAL;
 	}
 
-	port_state = inb(ws16c48gpio->base + port);
+	port_state = ioread8(ws16c48gpio->base + port);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 
@@ -131,7 +131,7 @@ static int ws16c48_gpio_get_multiple(struct gpio_chip *chip,
 	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(chip);
 	unsigned long offset;
 	unsigned long gpio_mask;
-	unsigned int port_addr;
+	void __iomem *port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
@@ -139,7 +139,7 @@ static int ws16c48_gpio_get_multiple(struct gpio_chip *chip,
 
 	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
 		port_addr = ws16c48gpio->base + offset / 8;
-		port_state = inb(port_addr) & gpio_mask;
+		port_state = ioread8(port_addr) & gpio_mask;
 
 		bitmap_set_value8(bits, port_state, offset);
 	}
@@ -166,7 +166,7 @@ static void ws16c48_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 		ws16c48gpio->out_state[port] |= mask;
 	else
 		ws16c48gpio->out_state[port] &= ~mask;
-	outb(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
+	iowrite8(ws16c48gpio->out_state[port], ws16c48gpio->base + port);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 }
@@ -178,7 +178,7 @@ static void ws16c48_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long offset;
 	unsigned long gpio_mask;
 	size_t index;
-	unsigned int port_addr;
+	void __iomem *port_addr;
 	unsigned long bitmask;
 	unsigned long flags;
 
@@ -195,7 +195,7 @@ static void ws16c48_gpio_set_multiple(struct gpio_chip *chip,
 		/* update output state data and set device gpio register */
 		ws16c48gpio->out_state[index] &= ~gpio_mask;
 		ws16c48gpio->out_state[index] |= bitmask;
-		outb(ws16c48gpio->out_state[index], port_addr);
+		iowrite8(ws16c48gpio->out_state[index], port_addr);
 
 		raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 	}
@@ -219,10 +219,10 @@ static void ws16c48_irq_ack(struct irq_data *data)
 
 	port_state = ws16c48gpio->irq_mask >> (8*port);
 
-	outb(0x80, ws16c48gpio->base + 7);
-	outb(port_state & ~mask, ws16c48gpio->base + 8 + port);
-	outb(port_state | mask, ws16c48gpio->base + 8 + port);
-	outb(0xC0, ws16c48gpio->base + 7);
+	iowrite8(0x80, ws16c48gpio->base + 7);
+	iowrite8(port_state & ~mask, ws16c48gpio->base + 8 + port);
+	iowrite8(port_state | mask, ws16c48gpio->base + 8 + port);
+	iowrite8(0xC0, ws16c48gpio->base + 7);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 }
@@ -244,9 +244,9 @@ static void ws16c48_irq_mask(struct irq_data *data)
 
 	ws16c48gpio->irq_mask &= ~mask;
 
-	outb(0x80, ws16c48gpio->base + 7);
-	outb(ws16c48gpio->irq_mask >> (8*port), ws16c48gpio->base + 8 + port);
-	outb(0xC0, ws16c48gpio->base + 7);
+	iowrite8(0x80, ws16c48gpio->base + 7);
+	iowrite8(ws16c48gpio->irq_mask >> (8*port), ws16c48gpio->base + 8 + port);
+	iowrite8(0xC0, ws16c48gpio->base + 7);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 }
@@ -268,9 +268,9 @@ static void ws16c48_irq_unmask(struct irq_data *data)
 
 	ws16c48gpio->irq_mask |= mask;
 
-	outb(0x80, ws16c48gpio->base + 7);
-	outb(ws16c48gpio->irq_mask >> (8*port), ws16c48gpio->base + 8 + port);
-	outb(0xC0, ws16c48gpio->base + 7);
+	iowrite8(0x80, ws16c48gpio->base + 7);
+	iowrite8(ws16c48gpio->irq_mask >> (8*port), ws16c48gpio->base + 8 + port);
+	iowrite8(0xC0, ws16c48gpio->base + 7);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 }
@@ -304,9 +304,9 @@ static int ws16c48_irq_set_type(struct irq_data *data, unsigned flow_type)
 		return -EINVAL;
 	}
 
-	outb(0x40, ws16c48gpio->base + 7);
-	outb(ws16c48gpio->flow_mask >> (8*port), ws16c48gpio->base + 8 + port);
-	outb(0xC0, ws16c48gpio->base + 7);
+	iowrite8(0x40, ws16c48gpio->base + 7);
+	iowrite8(ws16c48gpio->flow_mask >> (8*port), ws16c48gpio->base + 8 + port);
+	iowrite8(0xC0, ws16c48gpio->base + 7);
 
 	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);
 
@@ -330,20 +330,20 @@ static irqreturn_t ws16c48_irq_handler(int irq, void *dev_id)
 	unsigned long int_id;
 	unsigned long gpio;
 
-	int_pending = inb(ws16c48gpio->base + 6) & 0x7;
+	int_pending = ioread8(ws16c48gpio->base + 6) & 0x7;
 	if (!int_pending)
 		return IRQ_NONE;
 
 	/* loop until all pending interrupts are handled */
 	do {
 		for_each_set_bit(port, &int_pending, 3) {
-			int_id = inb(ws16c48gpio->base + 8 + port);
+			int_id = ioread8(ws16c48gpio->base + 8 + port);
 			for_each_set_bit(gpio, &int_id, 8)
 				generic_handle_domain_irq(chip->irq.domain,
 							  gpio + 8*port);
 		}
 
-		int_pending = inb(ws16c48gpio->base + 6) & 0x7;
+		int_pending = ioread8(ws16c48gpio->base + 6) & 0x7;
 	} while (int_pending);
 
 	return IRQ_HANDLED;
@@ -370,11 +370,11 @@ static int ws16c48_irq_init_hw(struct gpio_chip *gc)
 	struct ws16c48_gpio *const ws16c48gpio = gpiochip_get_data(gc);
 
 	/* Disable IRQ by default */
-	outb(0x80, ws16c48gpio->base + 7);
-	outb(0, ws16c48gpio->base + 8);
-	outb(0, ws16c48gpio->base + 9);
-	outb(0, ws16c48gpio->base + 10);
-	outb(0xC0, ws16c48gpio->base + 7);
+	iowrite8(0x80, ws16c48gpio->base + 7);
+	iowrite8(0, ws16c48gpio->base + 8);
+	iowrite8(0, ws16c48gpio->base + 9);
+	iowrite8(0, ws16c48gpio->base + 10);
+	iowrite8(0xC0, ws16c48gpio->base + 7);
 
 	return 0;
 }
@@ -396,6 +396,10 @@ static int ws16c48_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
+	ws16c48gpio->base = devm_ioport_map(dev, base[id], WS16C48_EXTENT);
+	if (!ws16c48gpio->base)
+		return -ENOMEM;
+
 	ws16c48gpio->chip.label = name;
 	ws16c48gpio->chip.parent = dev;
 	ws16c48gpio->chip.owner = THIS_MODULE;
@@ -409,7 +413,6 @@ static int ws16c48_probe(struct device *dev, unsigned int id)
 	ws16c48gpio->chip.get_multiple = ws16c48_gpio_get_multiple;
 	ws16c48gpio->chip.set = ws16c48_gpio_set;
 	ws16c48gpio->chip.set_multiple = ws16c48_gpio_set_multiple;
-	ws16c48gpio->base = base[id];
 
 	girq = &ws16c48gpio->chip.irq;
 	girq->chip = &ws16c48_irqchip;
-- 
2.35.3


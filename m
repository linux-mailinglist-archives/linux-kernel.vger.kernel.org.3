Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7155222D8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348616AbiEJRhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245083AbiEJRfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:35:31 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E26F45AF4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:31:23 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id x9so14067297qts.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dp773USXqVyyiKXPdjKnqOpvmUov/JtSiRinsH2S0Gc=;
        b=R1u5ol4k8XrpPnnPuo8fgHEHhOQIWJTbJCzfSzG45TXL4G1RQLas3JH2euBe5CZkyB
         ZHy0AphUsiVk4j6mgMP0ddccQCbrY4NXtt6R/pY1tOhIkZ54HDNIhUlSeM7LH/lNjea/
         SVY8Cyp4fN8EAvET5tk2Mpzsq9J/mPnI6cg8VFwN/WMpqWIRvJWWdtE6CFcvPPM5cBkE
         C+6oEfjnD0P1Dg4Dfe6BNWLjAJFvrgfPUi3gSAFiuYzY3Ab3gyk3omFdNo321KdizCsK
         7LBgyiQ7/df4nA1AmNuGHBF8ks2PH5DNANi5p6Cd/3n9UkXlfWkpsnZIADBOMScA8oqX
         Vbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dp773USXqVyyiKXPdjKnqOpvmUov/JtSiRinsH2S0Gc=;
        b=Psdn43opwm4H+pM1zZWhZooX7x0Kqdxy2pYdZeyKcVySmLcr7y3vCH1Sd2SKcRdXRn
         Unb9lWI+JRVJYtkCupF39TzKQI4RmZrEtHnZMY6iVAgp1jWPPy2wtaNdp+3/E03AU0J8
         /s/2v3vae0a9+Jmn0ftGGhCC1d2es0rO1F+zavYcb2AOt775eCmw6GitIy/Aip9Tc5xT
         lCJor+U0EHRE2zhrmP7MjietTgWgxKC409aFobddf8DXDolwup/QZWp3bvjU4IOz8HHc
         vcw28FxsESSEE5VpovQNf2DXmrlNgCbv8KDazLdfQ5NBqzJJjP3J3hRVtYUWjS6zXrc5
         mMTg==
X-Gm-Message-State: AOAM530V/Liv8BJlPXBljAYRd88ZMr5MdEwuuNeT7b10Tzm/GD3r2+j/
        vMmCTCO4Y5bgoZ+nUGzpP7aFYA==
X-Google-Smtp-Source: ABdhPJyaOMPUXrLX4jwVkNgym0/oA/GePiD78bI0k2HI9pkktZLs0mGazb5+MEuzhiCAFYnxt4HMyA==
X-Received: by 2002:ac8:5f88:0:b0:2f3:b80c:a7a4 with SMTP id j8-20020ac85f88000000b002f3b80ca7a4mr20932274qta.38.1652203882313;
        Tue, 10 May 2022 10:31:22 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a150600b0069ff8ebec64sm8490411qkk.103.2022.05.10.10.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:31:22 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, macro@orcam.me.uk,
        William Breathitt Gray <william.gray@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 3/8] gpio: 104-idi-48: Utilize iomap interface
Date:   Tue, 10 May 2022 13:30:55 -0400
Message-Id: <09e2418d2dcf93c45a70c3a0a1fe7fdd8104a689.1652201921.git.william.gray@linaro.org>
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
 drivers/gpio/gpio-104-idi-48.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 34be7dd9f5b9..9521ece3ebef 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -47,7 +47,7 @@ struct idi_48_gpio {
 	raw_spinlock_t lock;
 	spinlock_t ack_lock;
 	unsigned char irq_mask[6];
-	unsigned base;
+	void __iomem *base;
 	unsigned char cos_enb;
 };
 
@@ -66,15 +66,15 @@ static int idi_48_gpio_get(struct gpio_chip *chip, unsigned offset)
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
 	unsigned i;
 	static const unsigned int register_offset[6] = { 0, 1, 2, 4, 5, 6 };
-	unsigned base_offset;
+	void __iomem *port_addr;
 	unsigned mask;
 
 	for (i = 0; i < 48; i += 8)
 		if (offset < i + 8) {
-			base_offset = register_offset[i / 8];
+			port_addr = idi48gpio->base + register_offset[i / 8];
 			mask = BIT(offset - i);
 
-			return !!(inb(idi48gpio->base + base_offset) & mask);
+			return !!(ioread8(port_addr) & mask);
 		}
 
 	/* The following line should never execute since offset < 48 */
@@ -88,7 +88,7 @@ static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long offset;
 	unsigned long gpio_mask;
 	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	unsigned int port_addr;
+	void __iomem *port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
@@ -96,7 +96,7 @@ static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 
 	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
 		port_addr = idi48gpio->base + ports[offset / 8];
-		port_state = inb(port_addr) & gpio_mask;
+		port_state = ioread8(port_addr) & gpio_mask;
 
 		bitmap_set_value8(bits, port_state, offset);
 	}
@@ -130,7 +130,7 @@ static void idi_48_irq_mask(struct irq_data *data)
 
 				raw_spin_lock_irqsave(&idi48gpio->lock, flags);
 
-				outb(idi48gpio->cos_enb, idi48gpio->base + 7);
+				iowrite8(idi48gpio->cos_enb, idi48gpio->base + 7);
 
 				raw_spin_unlock_irqrestore(&idi48gpio->lock, flags);
 			}
@@ -163,7 +163,7 @@ static void idi_48_irq_unmask(struct irq_data *data)
 
 				raw_spin_lock_irqsave(&idi48gpio->lock, flags);
 
-				outb(idi48gpio->cos_enb, idi48gpio->base + 7);
+				iowrite8(idi48gpio->cos_enb, idi48gpio->base + 7);
 
 				raw_spin_unlock_irqrestore(&idi48gpio->lock, flags);
 			}
@@ -204,7 +204,7 @@ static irqreturn_t idi_48_irq_handler(int irq, void *dev_id)
 
 	raw_spin_lock(&idi48gpio->lock);
 
-	cos_status = inb(idi48gpio->base + 7);
+	cos_status = ioread8(idi48gpio->base + 7);
 
 	raw_spin_unlock(&idi48gpio->lock);
 
@@ -250,8 +250,8 @@ static int idi_48_irq_init_hw(struct gpio_chip *gc)
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(gc);
 
 	/* Disable IRQ by default */
-	outb(0, idi48gpio->base + 7);
-	inb(idi48gpio->base + 7);
+	iowrite8(0, idi48gpio->base + 7);
+	ioread8(idi48gpio->base + 7);
 
 	return 0;
 }
@@ -273,6 +273,10 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
+	idi48gpio->base = devm_ioport_map(dev, base[id], IDI_48_EXTENT);
+	if (!idi48gpio->base)
+		return -ENOMEM;
+
 	idi48gpio->chip.label = name;
 	idi48gpio->chip.parent = dev;
 	idi48gpio->chip.owner = THIS_MODULE;
@@ -283,7 +287,6 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 	idi48gpio->chip.direction_input = idi_48_gpio_direction_input;
 	idi48gpio->chip.get = idi_48_gpio_get;
 	idi48gpio->chip.get_multiple = idi_48_gpio_get_multiple;
-	idi48gpio->base = base[id];
 
 	girq = &idi48gpio->chip.irq;
 	girq->chip = &idi_48_irqchip;
-- 
2.35.3


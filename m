Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F605222D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348629AbiEJRhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348264AbiEJRfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:35:31 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2AA3EAA7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:31:23 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id jt15so13091170qvb.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAiResiSDR0UVkYFGpWdpsHXqinI6QYsvByx1jrEmYs=;
        b=SmmF/FWHV+dCZpxlqQIcq5MpAYpbVHs5XeWkXs50nvqsMsfMPAe20HNuw3lb9DmnCz
         nhR6Oh9i33Nnl+dkQGXcQy1UsSS+1JCKWlv71waan9SGO3QIc6qUv1hYJ4faRLFUOzgO
         Vrd9i7LcUnn2HaSymBKkBrRTjtwFyAZxwiByr11d554bO+pxIwEnsEXucjXiL9t+JV+m
         oD2vsa5ZTVWEJqOow2LE9V7Oq9vl46IDGqW/Mw1BOa0+pLIo/VXC/XbedDb0PJlW0Ev+
         am3BzMDXimMibkr9AqJSkGnpBtX14wbczsUEnUwe+l5Y8AkYK46iauj3sC+bLWBYZrQX
         M4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAiResiSDR0UVkYFGpWdpsHXqinI6QYsvByx1jrEmYs=;
        b=CKny4p6XevjJw6KWT2QR/nzrx0yLcNfmVMr4IiWac/x2YnrXpiDC6mAvrFXcvJPgaN
         6iESxMQCph/kRoIP4/FZDoPt3swaAUr8f+8fkCNtuIczNFeCWtKwb+NQ7FtOMfzZw3AE
         uXdZPJPiqHlDUEzcUeFuO/k+Ewv6OBtT8lYymiXJy9aUqct7akM8Ph4cRlgRrvKUxT9N
         xwS0wy+ZvzgsI/r0bFJOvEpWw07qthS5cFgr4eS3eU4aDLlqAkT1Sm5oq595d0N/MhzC
         OTIjoUQJSl6+ZWlIciS5xq9CS/FUlQmEHtnEdngiiMMGsHNgHK/89AyUoj8hFPocqUIh
         HKuA==
X-Gm-Message-State: AOAM530zKIXzscwRkZOSS2xm/H9xakTvdZLQTUMDAaLnBDkRtyfLIQye
        OBHjw2+pjahDFAYsQARihhAoQA==
X-Google-Smtp-Source: ABdhPJza0jR2kpJcC/r1piienpe1i5hTVSk12hHR973c1jA2x/FkiKwoSb4zCs2oaY70NW9rwOk6Ig==
X-Received: by 2002:a05:6214:21e1:b0:440:fa7a:493e with SMTP id p1-20020a05621421e100b00440fa7a493emr18645248qvj.55.1652203883031;
        Tue, 10 May 2022 10:31:23 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a150600b0069ff8ebec64sm8490411qkk.103.2022.05.10.10.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:31:22 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, macro@orcam.me.uk,
        William Breathitt Gray <william.gray@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 4/8] gpio: 104-idio-16: Utilize iomap interface
Date:   Tue, 10 May 2022 13:30:56 -0400
Message-Id: <1aed489e67526819d9f5c5a11f4bb3a172acd1f1.1652201921.git.william.gray@linaro.org>
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
 drivers/gpio/gpio-104-idio-16.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
index c68ed1a135fa..45f7ad8573e1 100644
--- a/drivers/gpio/gpio-104-idio-16.c
+++ b/drivers/gpio/gpio-104-idio-16.c
@@ -44,7 +44,7 @@ struct idio_16_gpio {
 	struct gpio_chip chip;
 	raw_spinlock_t lock;
 	unsigned long irq_mask;
-	unsigned int base;
+	void __iomem *base;
 	unsigned int out_state;
 };
 
@@ -79,9 +79,9 @@ static int idio_16_gpio_get(struct gpio_chip *chip, unsigned int offset)
 		return -EINVAL;
 
 	if (offset < 24)
-		return !!(inb(idio16gpio->base + 1) & mask);
+		return !!(ioread8(idio16gpio->base + 1) & mask);
 
-	return !!(inb(idio16gpio->base + 5) & (mask>>8));
+	return !!(ioread8(idio16gpio->base + 5) & (mask>>8));
 }
 
 static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
@@ -91,9 +91,9 @@ static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
 
 	*bits = 0;
 	if (*mask & GENMASK(23, 16))
-		*bits |= (unsigned long)inb(idio16gpio->base + 1) << 16;
+		*bits |= (unsigned long)ioread8(idio16gpio->base + 1) << 16;
 	if (*mask & GENMASK(31, 24))
-		*bits |= (unsigned long)inb(idio16gpio->base + 5) << 24;
+		*bits |= (unsigned long)ioread8(idio16gpio->base + 5) << 24;
 
 	return 0;
 }
@@ -116,9 +116,9 @@ static void idio_16_gpio_set(struct gpio_chip *chip, unsigned int offset,
 		idio16gpio->out_state &= ~mask;
 
 	if (offset > 7)
-		outb(idio16gpio->out_state >> 8, idio16gpio->base + 4);
+		iowrite8(idio16gpio->out_state >> 8, idio16gpio->base + 4);
 	else
-		outb(idio16gpio->out_state, idio16gpio->base);
+		iowrite8(idio16gpio->out_state, idio16gpio->base);
 
 	raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 }
@@ -135,9 +135,9 @@ static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
 	idio16gpio->out_state |= *mask & *bits;
 
 	if (*mask & 0xFF)
-		outb(idio16gpio->out_state, idio16gpio->base);
+		iowrite8(idio16gpio->out_state, idio16gpio->base);
 	if ((*mask >> 8) & 0xFF)
-		outb(idio16gpio->out_state >> 8, idio16gpio->base + 4);
+		iowrite8(idio16gpio->out_state >> 8, idio16gpio->base + 4);
 
 	raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 }
@@ -158,7 +158,7 @@ static void idio_16_irq_mask(struct irq_data *data)
 	if (!idio16gpio->irq_mask) {
 		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
 
-		outb(0, idio16gpio->base + 2);
+		iowrite8(0, idio16gpio->base + 2);
 
 		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 	}
@@ -177,7 +177,7 @@ static void idio_16_irq_unmask(struct irq_data *data)
 	if (!prev_irq_mask) {
 		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
 
-		inb(idio16gpio->base + 2);
+		ioread8(idio16gpio->base + 2);
 
 		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 	}
@@ -212,7 +212,7 @@ static irqreturn_t idio_16_irq_handler(int irq, void *dev_id)
 
 	raw_spin_lock(&idio16gpio->lock);
 
-	outb(0, idio16gpio->base + 1);
+	iowrite8(0, idio16gpio->base + 1);
 
 	raw_spin_unlock(&idio16gpio->lock);
 
@@ -232,8 +232,8 @@ static int idio_16_irq_init_hw(struct gpio_chip *gc)
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(gc);
 
 	/* Disable IRQ by default */
-	outb(0, idio16gpio->base + 2);
-	outb(0, idio16gpio->base + 1);
+	iowrite8(0, idio16gpio->base + 2);
+	iowrite8(0, idio16gpio->base + 1);
 
 	return 0;
 }
@@ -255,6 +255,10 @@ static int idio_16_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
+	idio16gpio->base = devm_ioport_map(dev, base[id], IDIO_16_EXTENT);
+	if (!idio16gpio->base)
+		return -ENOMEM;
+
 	idio16gpio->chip.label = name;
 	idio16gpio->chip.parent = dev;
 	idio16gpio->chip.owner = THIS_MODULE;
@@ -268,7 +272,6 @@ static int idio_16_probe(struct device *dev, unsigned int id)
 	idio16gpio->chip.get_multiple = idio_16_gpio_get_multiple;
 	idio16gpio->chip.set = idio_16_gpio_set;
 	idio16gpio->chip.set_multiple = idio_16_gpio_set_multiple;
-	idio16gpio->base = base[id];
 	idio16gpio->out_state = 0xFFFF;
 
 	girq = &idio16gpio->chip.irq;
-- 
2.35.3


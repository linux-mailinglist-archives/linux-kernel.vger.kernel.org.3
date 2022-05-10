Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5FF5222D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348593AbiEJRhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348254AbiEJRfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:35:32 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4FC4968B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:31:25 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id l1so10715711qvh.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=seOjmihEBRKsZp4b34pJA/ndUMIaVSf7C6FlpVBGPxk=;
        b=wmwYtqg29pKeFXBRyIVmMMB5jXw+g9NzFNeJb3vvTmD7qXtMYZRgrQrL8PieMDygNo
         h+dqTmyo22/puKrfK8c21hUSNlBFmGBhZYngefgcyRMWYm+Gucxwz4IYLFZ/CnvXKN+A
         5ebu2EVI9eBbBge4y0/Q1JE1Z7GLGJRKjEY6MBuzTRELfaotpjuYYx5y/yjXtJYyfR+B
         RVA6ARVZQtRAn7WpXSOHv7w23TWVU498vBwfJBj4S9nRIkcSwTwarukhZV8Zg5RSlqjT
         dw/Rq015C1K4/5bSG7oYv2QGMtSe2S0iMBJjDNSfcIvFFBwOay4mpQKyxe5xIH59HvjJ
         bZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=seOjmihEBRKsZp4b34pJA/ndUMIaVSf7C6FlpVBGPxk=;
        b=Rsjyr2uEIu1AN6wiM8dHX33JT60viqrzhEGcCZsFCPsjayj8gIgsr1nXxqRLrjJsNt
         4E7DrEH0d5LxtAM04WF4pVHtFNzW8zL32zmgRTg6haI7opcCg3mU8RP/b/n+poeiIuOg
         U4KvczgGLUuGGJsrrYTQunrf2Q/Z58dVxDTWL7ftqeWpW43ljdb9V7Lza7afPIX6cba6
         F+wNHzNVqoNoJIg5aJU0OipVm6ibddKOC9oBRe88Rc10CUvOOuV13NcX9ZiZFfIEN5xw
         hNa+Aa7frTcsRbZbrgvRQ5xpSTb1KFRYgc/M9de5T1SAIJH/Bv1PpWovoK/KHUtxbzJj
         MyPg==
X-Gm-Message-State: AOAM531NYLVvL9PKX1aOogM6Ki3rVJzRsIdgGDBi4/z2OKgCocPmpwRf
        3sOES66q6WkD2AdaZxkwno+fAg==
X-Google-Smtp-Source: ABdhPJzZQJHFV8UJ1NPGzpYgeWXgn4ciBhy6e9TckMU1/L3vVDqbAWahmnq8VC8unCEvQMTOrR0teQ==
X-Received: by 2002:a05:6214:c6f:b0:45a:a2f2:6d23 with SMTP id t15-20020a0562140c6f00b0045aa2f26d23mr19357429qvj.55.1652203885151;
        Tue, 10 May 2022 10:31:25 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a150600b0069ff8ebec64sm8490411qkk.103.2022.05.10.10.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:31:24 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, macro@orcam.me.uk,
        William Breathitt Gray <william.gray@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/8] iio: adc: stx104: Utilize iomap interface
Date:   Tue, 10 May 2022 13:30:59 -0400
Message-Id: <64673797df382c52fc32fce24348b25a0b05e73a.1652201921.git.william.gray@linaro.org>
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
 drivers/iio/adc/stx104.c | 56 +++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index 55bd2dc514e9..7552351bfed9 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -51,7 +51,7 @@ MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
  */
 struct stx104_iio {
 	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
-	unsigned int base;
+	void __iomem *base;
 };
 
 /**
@@ -64,7 +64,7 @@ struct stx104_iio {
 struct stx104_gpio {
 	struct gpio_chip chip;
 	spinlock_t lock;
-	unsigned int base;
+	void __iomem *base;
 	unsigned int out_state;
 };
 
@@ -79,7 +79,7 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		/* get gain configuration */
-		adc_config = inb(priv->base + 11);
+		adc_config = ioread8(priv->base + 11);
 		gain = adc_config & 0x3;
 
 		*val = 1 << gain;
@@ -91,24 +91,24 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 		}
 
 		/* select ADC channel */
-		outb(chan->channel | (chan->channel << 4), priv->base + 2);
+		iowrite8(chan->channel | (chan->channel << 4), priv->base + 2);
 
 		/* trigger ADC sample capture and wait for completion */
-		outb(0, priv->base);
-		while (inb(priv->base + 8) & BIT(7));
+		iowrite8(0, priv->base);
+		while (ioread8(priv->base + 8) & BIT(7));
 
-		*val = inw(priv->base);
+		*val = ioread16(priv->base);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		/* get ADC bipolar/unipolar configuration */
-		adc_config = inb(priv->base + 11);
+		adc_config = ioread8(priv->base + 11);
 		adbu = !(adc_config & BIT(2));
 
 		*val = -32768 * adbu;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/* get ADC bipolar/unipolar and gain configuration */
-		adc_config = inb(priv->base + 11);
+		adc_config = ioread8(priv->base + 11);
 		adbu = !(adc_config & BIT(2));
 		gain = adc_config & 0x3;
 
@@ -130,16 +130,16 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 		/* Only four gain states (x1, x2, x4, x8) */
 		switch (val) {
 		case 1:
-			outb(0, priv->base + 11);
+			iowrite8(0, priv->base + 11);
 			break;
 		case 2:
-			outb(1, priv->base + 11);
+			iowrite8(1, priv->base + 11);
 			break;
 		case 4:
-			outb(2, priv->base + 11);
+			iowrite8(2, priv->base + 11);
 			break;
 		case 8:
-			outb(3, priv->base + 11);
+			iowrite8(3, priv->base + 11);
 			break;
 		default:
 			return -EINVAL;
@@ -153,7 +153,7 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 				return -EINVAL;
 
 			priv->chan_out_states[chan->channel] = val;
-			outw(val, priv->base + 4 + 2 * chan->channel);
+			iowrite16(val, priv->base + 4 + 2 * chan->channel);
 
 			return 0;
 		}
@@ -222,7 +222,7 @@ static int stx104_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	if (offset >= 4)
 		return -EINVAL;
 
-	return !!(inb(stx104gpio->base) & BIT(offset));
+	return !!(ioread8(stx104gpio->base) & BIT(offset));
 }
 
 static int stx104_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
@@ -230,7 +230,7 @@ static int stx104_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 {
 	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
 
-	*bits = inb(stx104gpio->base);
+	*bits = ioread8(stx104gpio->base);
 
 	return 0;
 }
@@ -252,7 +252,7 @@ static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	else
 		stx104gpio->out_state &= ~mask;
 
-	outb(stx104gpio->out_state, stx104gpio->base);
+	iowrite8(stx104gpio->out_state, stx104gpio->base);
 
 	spin_unlock_irqrestore(&stx104gpio->lock, flags);
 }
@@ -279,7 +279,7 @@ static void stx104_gpio_set_multiple(struct gpio_chip *chip,
 
 	stx104gpio->out_state &= ~*mask;
 	stx104gpio->out_state |= *mask & *bits;
-	outb(stx104gpio->out_state, stx104gpio->base);
+	iowrite8(stx104gpio->out_state, stx104gpio->base);
 
 	spin_unlock_irqrestore(&stx104gpio->lock, flags);
 }
@@ -306,11 +306,16 @@ static int stx104_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
+	priv = iio_priv(indio_dev);
+	priv->base = devm_ioport_map(dev, base[id], STX104_EXTENT);
+	if (!priv->base)
+		return -ENOMEM;
+
 	indio_dev->info = &stx104_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* determine if differential inputs */
-	if (inb(base[id] + 8) & BIT(5)) {
+	if (ioread8(priv->base + 8) & BIT(5)) {
 		indio_dev->num_channels = ARRAY_SIZE(stx104_channels_diff);
 		indio_dev->channels = stx104_channels_diff;
 	} else {
@@ -320,18 +325,15 @@ static int stx104_probe(struct device *dev, unsigned int id)
 
 	indio_dev->name = dev_name(dev);
 
-	priv = iio_priv(indio_dev);
-	priv->base = base[id];
-
 	/* configure device for software trigger operation */
-	outb(0, base[id] + 9);
+	iowrite8(0, priv->base + 9);
 
 	/* initialize gain setting to x1 */
-	outb(0, base[id] + 11);
+	iowrite8(0, priv->base + 11);
 
 	/* initialize DAC output to 0V */
-	outw(0, base[id] + 4);
-	outw(0, base[id] + 6);
+	iowrite16(0, priv->base + 4);
+	iowrite16(0, priv->base + 6);
 
 	stx104gpio->chip.label = dev_name(dev);
 	stx104gpio->chip.parent = dev;
@@ -346,7 +348,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	stx104gpio->chip.get_multiple = stx104_gpio_get_multiple;
 	stx104gpio->chip.set = stx104_gpio_set;
 	stx104gpio->chip.set_multiple = stx104_gpio_set_multiple;
-	stx104gpio->base = base[id] + 3;
+	stx104gpio->base = priv->base + 3;
 	stx104gpio->out_state = 0x0;
 
 	spin_lock_init(&stx104gpio->lock);
-- 
2.35.3


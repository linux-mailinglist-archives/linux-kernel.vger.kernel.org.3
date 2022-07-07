Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73AE56AEEF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 01:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbiGGXQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 19:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbiGGXQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 19:16:21 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C8E6B257
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 16:16:20 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10bffc214ffso16548057fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 16:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gucdXtUT30blOlPna+akHLKgmTi4R2YhWK3Bmyso2+M=;
        b=qFODspyZ2RgF5y5eeKbqD6V2YSybgyiIjWiWJigjUi4vfDP3PuhA7lUygnTCMVbiwK
         Ybi3JhVu+6nVvU5hOhVEIpaK5eRcQ8HAHUnQTJte7mo0hNhcjUIq+y4V+Qe6vN+H6Ov0
         xy8MKngZ1QgdbUiF21ETbntWmz/za+2nYScArulXoZN/QIT4Hfb0hLaBNEzrwFEKatOC
         FKGpVmvBvTTbej3DTzRiuwt6vkcVKHR6/czTb61FUVdD/vWf1L/J1hj8PHQIC4B94QpL
         AZY3IY8cJ+35hELpyiVJfE2C6TpWZtB473lRlj/fVxJtanmud6cdUQ1w0du8ezDtWCLQ
         ZLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gucdXtUT30blOlPna+akHLKgmTi4R2YhWK3Bmyso2+M=;
        b=uaHVtpqjnfwbcFp3b4YAkfNFY+OIZ030PanVc8afffx7vHPEkdf0CBYX5FECmpvAq4
         HEBE7WHsjJSUmZWKUvU4BxAikikTTKyorxkGnGHDng9mZM3vFbMpxG/LRCs7zVMzpS6a
         sWZqlhxqqcwrdKYwx7qk19Os951RnpS2LHaQSJClNL3gY+XBB1CQc65MzPIrvLI0c63S
         6mHe81boS8leZvJOka/9smXvexJu4YpBDdx70YySec7qGJVkcBMhCVD0NzL2Ic46DreS
         G83XfkwVp0QrhPQGQcBZnqirXY+qta1rz8KU7JNNHBY+/qIKFfqZQ3HpvO6CA/pbUEhu
         BRjQ==
X-Gm-Message-State: AJIora9u/sNOG6FUcio4W+5epER6gX4AYWOdsP6vEu7KldiddieL7bUC
        YkYUWZZf9Ncyn7Cc/700qI6chA==
X-Google-Smtp-Source: AGRyM1uHNyPzTalMNMcPVsh8LU9hrR0XjW/u1+3I9feblmJfAakbAAm8g+UzL8J2P4Frx1d4aa8bSQ==
X-Received: by 2002:a05:6870:41c3:b0:10c:529c:3844 with SMTP id z3-20020a05687041c300b0010c529c3844mr231725oac.0.1657235779435;
        Thu, 07 Jul 2022 16:16:19 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id cg10-20020a056830630a00b006190efaf118sm2177606otb.66.2022.07.07.16.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:16:19 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Fred Eckert <Frede@cmslaser.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v2 5/6] gpio: 104-idio-16: Implement and utilize register structures
Date:   Thu,  7 Jul 2022 14:10:07 -0400
Message-Id: <542a96e3c808c43efc2c4daade0008d4373f55af.1657216200.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657216200.git.william.gray@linaro.org>
References: <cover.1657216200.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce magic numbers and improve code readability by implementing and
utilizing named register data structures.

Tested-by: Fred Eckert <Frede@cmslaser.com>
Cc: John Hentges <jhentges@accesio.com>
Cc: Jay Dolan <jay.dolan@accesio.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-104-idio-16.c | 58 +++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
index 45f7ad8573e1..2f8e295f5541 100644
--- a/drivers/gpio/gpio-104-idio-16.c
+++ b/drivers/gpio/gpio-104-idio-16.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
 #define IDIO_16_EXTENT 8
 #define MAX_NUM_IDIO_16 max_num_isa_dev(IDIO_16_EXTENT)
@@ -32,19 +33,42 @@ static unsigned int irq[MAX_NUM_IDIO_16];
 module_param_hw_array(irq, uint, irq, NULL, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-IDIO-16 interrupt line numbers");
 
+/**
+ * struct idio_16_reg - device registers structure
+ * @out0_7:	Read: N/A
+ *		Write: FET Drive Outputs 0-7
+ * @in0_7:	Read: Isolated Inputs 0-7
+ *		Write: Clear Interrupt
+ * @irq_ctl:	Read: Enable IRQ
+ *		Write: Disable IRQ
+ * @unused:	N/A
+ * @out8_15:	Read: N/A
+ *		Write: FET Drive Outputs 8-15
+ * @in8_15:	Read: Isolated Inputs 8-15
+ *		Write: N/A
+ */
+struct idio_16_reg {
+	u8 out0_7;
+	u8 in0_7;
+	u8 irq_ctl;
+	u8 unused;
+	u8 out8_15;
+	u8 in8_15;
+};
+
 /**
  * struct idio_16_gpio - GPIO device private data structure
  * @chip:	instance of the gpio_chip
  * @lock:	synchronization lock to prevent I/O race conditions
  * @irq_mask:	I/O bits affected by interrupts
- * @base:	base port address of the GPIO device
+ * @reg:	I/O address offset for the device registers
  * @out_state:	output bits state
  */
 struct idio_16_gpio {
 	struct gpio_chip chip;
 	raw_spinlock_t lock;
 	unsigned long irq_mask;
-	void __iomem *base;
+	struct idio_16_reg __iomem *reg;
 	unsigned int out_state;
 };
 
@@ -79,9 +103,9 @@ static int idio_16_gpio_get(struct gpio_chip *chip, unsigned int offset)
 		return -EINVAL;
 
 	if (offset < 24)
-		return !!(ioread8(idio16gpio->base + 1) & mask);
+		return !!(ioread8(&idio16gpio->reg->in0_7) & mask);
 
-	return !!(ioread8(idio16gpio->base + 5) & (mask>>8));
+	return !!(ioread8(&idio16gpio->reg->in8_15) & (mask>>8));
 }
 
 static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
@@ -91,9 +115,9 @@ static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
 
 	*bits = 0;
 	if (*mask & GENMASK(23, 16))
-		*bits |= (unsigned long)ioread8(idio16gpio->base + 1) << 16;
+		*bits |= (unsigned long)ioread8(&idio16gpio->reg->in0_7) << 16;
 	if (*mask & GENMASK(31, 24))
-		*bits |= (unsigned long)ioread8(idio16gpio->base + 5) << 24;
+		*bits |= (unsigned long)ioread8(&idio16gpio->reg->in8_15) << 24;
 
 	return 0;
 }
@@ -116,9 +140,9 @@ static void idio_16_gpio_set(struct gpio_chip *chip, unsigned int offset,
 		idio16gpio->out_state &= ~mask;
 
 	if (offset > 7)
-		iowrite8(idio16gpio->out_state >> 8, idio16gpio->base + 4);
+		iowrite8(idio16gpio->out_state >> 8, &idio16gpio->reg->out8_15);
 	else
-		iowrite8(idio16gpio->out_state, idio16gpio->base);
+		iowrite8(idio16gpio->out_state, &idio16gpio->reg->out0_7);
 
 	raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 }
@@ -135,9 +159,9 @@ static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
 	idio16gpio->out_state |= *mask & *bits;
 
 	if (*mask & 0xFF)
-		iowrite8(idio16gpio->out_state, idio16gpio->base);
+		iowrite8(idio16gpio->out_state, &idio16gpio->reg->out0_7);
 	if ((*mask >> 8) & 0xFF)
-		iowrite8(idio16gpio->out_state >> 8, idio16gpio->base + 4);
+		iowrite8(idio16gpio->out_state >> 8, &idio16gpio->reg->out8_15);
 
 	raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 }
@@ -158,7 +182,7 @@ static void idio_16_irq_mask(struct irq_data *data)
 	if (!idio16gpio->irq_mask) {
 		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
 
-		iowrite8(0, idio16gpio->base + 2);
+		iowrite8(0, &idio16gpio->reg->irq_ctl);
 
 		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 	}
@@ -177,7 +201,7 @@ static void idio_16_irq_unmask(struct irq_data *data)
 	if (!prev_irq_mask) {
 		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
 
-		ioread8(idio16gpio->base + 2);
+		ioread8(&idio16gpio->reg->irq_ctl);
 
 		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 	}
@@ -212,7 +236,7 @@ static irqreturn_t idio_16_irq_handler(int irq, void *dev_id)
 
 	raw_spin_lock(&idio16gpio->lock);
 
-	iowrite8(0, idio16gpio->base + 1);
+	iowrite8(0, &idio16gpio->reg->in0_7);
 
 	raw_spin_unlock(&idio16gpio->lock);
 
@@ -232,8 +256,8 @@ static int idio_16_irq_init_hw(struct gpio_chip *gc)
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(gc);
 
 	/* Disable IRQ by default */
-	iowrite8(0, idio16gpio->base + 2);
-	iowrite8(0, idio16gpio->base + 1);
+	iowrite8(0, &idio16gpio->reg->irq_ctl);
+	iowrite8(0, &idio16gpio->reg->in0_7);
 
 	return 0;
 }
@@ -255,8 +279,8 @@ static int idio_16_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	idio16gpio->base = devm_ioport_map(dev, base[id], IDIO_16_EXTENT);
-	if (!idio16gpio->base)
+	idio16gpio->reg = devm_ioport_map(dev, base[id], IDIO_16_EXTENT);
+	if (!idio16gpio->reg)
 		return -ENOMEM;
 
 	idio16gpio->chip.label = name;
-- 
2.36.1


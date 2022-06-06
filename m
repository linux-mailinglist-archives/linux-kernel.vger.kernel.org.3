Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D199253E7EA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239931AbiFFOgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbiFFOgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:36:18 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E9112E32A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:36:11 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g13-20020a9d6b0d000000b0060b13026e0dso10886467otp.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D9soskDv6KXVPHCaTa4CNNvs92+O4+arQnAcZVRZbT0=;
        b=qBquZDqP7VN6yh7Mp0E/g0yyjt5kNSP8AK3EnE54P/q3yE3LlMoH2/TEmIg2UJQnWU
         /Fqmnmsrc3D+Ljh2XgbU8/RjSZg+lG58HAstpsi6q6hW4k8kqkq4Bc4LetEO5flXiTZ1
         bV8to5CFT3LbggX0tH+FgaWAzs+KPxVsO29F7lwhHtUKEtmkJkcVtINQyAp67s9UuN2n
         45cS26ygVyD9OZGNrb65rdSchWZxmSvBZEdHQ3uphO3uoYuq2sRzVJ9sINYPnT5KGvtr
         T0uYdpVF+UUK9X069Wmm2ynwH7Vmtx0vExFcopTEg9+8Pz8y5YkV2ihO32DMv9KJKoqb
         xPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D9soskDv6KXVPHCaTa4CNNvs92+O4+arQnAcZVRZbT0=;
        b=lGLXr+stBnuKyrKZILvMUjgbm5tj/2fafmhL1GptuuPuoX1AvJHbQ4TvTLbTBVTESO
         IJ0hGx7KZQo+wkb3vhPoiA5dRLIqYKp+ExxnXv9lIX01oUj4sg9lgBMCuZxgHLJ08XG2
         S9NaHZtxHcC4eGotj4FRN9pSk2sC771i825/wim8d7K9sNHiT+xDEEH9bcI/mE0pY0po
         pj586fbve6KbvdqVq2qlh6XD+R8kxBhytGvd7AnFHhEqBMvkiFY3/NrBMLUXbw7UpM5u
         lZX6f7g8dIqADavRfqqzqDdqgaqAQhcQtSZeCxP9+wJ9SChH1/8CQGwGKRmRLK9lrjYs
         MU1Q==
X-Gm-Message-State: AOAM530nAQcCTWJSBO/JABYxVJ4gFRY97o+Gy5Cz9ET4WrF2g5gPOX/T
        FCXYCSi+ZoFNEO52rtjOAPpxow==
X-Google-Smtp-Source: ABdhPJz6P2zs40Kr7rXerX3QlSpEo4I+NPEWZJBS7kHMKTpI2K63060Uy3lUZZaayRlZWc6OnQM0og==
X-Received: by 2002:a9d:129:0:b0:60b:23b5:1659 with SMTP id 38-20020a9d0129000000b0060b23b51659mr9942070otu.26.1654526170952;
        Mon, 06 Jun 2022 07:36:10 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id u13-20020a056871008d00b000f5d4e5b9a0sm6942791oaa.2.2022.06.06.07.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:36:10 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 2/5] gpio: 104-idi-48: Implement and utilize register structures
Date:   Mon,  6 Jun 2022 10:33:17 -0400
Message-Id: <0a893282333f195a208aa8c9fa3f38e447452abd.1654525394.git.william.gray@linaro.org>
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
 drivers/gpio/gpio-104-idi-48.c | 128 ++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 65 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 9521ece3ebef..1f8c556d9013 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
 #define IDI_48_EXTENT 8
 #define MAX_NUM_IDI_48 max_num_isa_dev(IDI_48_EXTENT)
@@ -33,13 +34,28 @@ static unsigned int irq[MAX_NUM_IDI_48];
 module_param_hw_array(irq, uint, irq, NULL, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-IDI-48 interrupt line numbers");
 
+/**
+ * struct idi_48_reg - device register structure
+ * @port0:	Port 0 Inputs
+ * @unused:	Unused
+ * @port1:	Port 1 Inputs
+ * @irq:	Read: IRQ Status Register/IRQ Clear
+ *		Write: IRQ Enable/Disable
+ */
+struct idi_48_reg {
+	u8 port0[3];
+	u8 unused;
+	u8 port1[3];
+	u8 irq;
+};
+
 /**
  * struct idi_48_gpio - GPIO device private data structure
  * @chip:	instance of the gpio_chip
  * @lock:	synchronization lock to prevent I/O race conditions
  * @ack_lock:	synchronization lock to prevent IRQ handler race conditions
  * @irq_mask:	input bits affected by interrupts
- * @base:	base port address of the GPIO device
+ * @reg:	I/O address offset for the device registers
  * @cos_enb:	Change-Of-State IRQ enable boundaries mask
  */
 struct idi_48_gpio {
@@ -47,7 +63,7 @@ struct idi_48_gpio {
 	raw_spinlock_t lock;
 	spinlock_t ack_lock;
 	unsigned char irq_mask[6];
-	void __iomem *base;
+	struct idi_48_reg __iomem *reg;
 	unsigned char cos_enb;
 };
 
@@ -64,39 +80,38 @@ static int idi_48_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 static int idi_48_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	unsigned i;
-	static const unsigned int register_offset[6] = { 0, 1, 2, 4, 5, 6 };
-	void __iomem *port_addr;
-	unsigned mask;
-
-	for (i = 0; i < 48; i += 8)
-		if (offset < i + 8) {
-			port_addr = idi48gpio->base + register_offset[i / 8];
-			mask = BIT(offset - i);
-
-			return !!(ioread8(port_addr) & mask);
-		}
-
-	/* The following line should never execute since offset < 48 */
-	return 0;
+	struct idi_48_reg __iomem *const reg = idi48gpio->reg;
+	const unsigned long boundary = offset / 8;
+	const unsigned long group = boundary / 3;
+	u8 __iomem *const port_addr = group ? reg->port1 : reg->port0;
+	const unsigned long in_port = boundary - (group * 3);
+	const unsigned long mask = BIT(offset % 8);
+
+	return !!(ioread8(port_addr + in_port) & mask);
 }
 
 static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
+	struct idi_48_reg __iomem *const reg = idi48gpio->reg;
 	unsigned long offset;
 	unsigned long gpio_mask;
-	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	void __iomem *port_addr;
+	unsigned long boundary;
+	unsigned long group;
+	unsigned long in_port;
+	u8 __iomem *port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		port_addr = idi48gpio->base + ports[offset / 8];
-		port_state = ioread8(port_addr) & gpio_mask;
+	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
+		boundary = offset / 8;
+		group = boundary / 3;
+		port_addr = group ? reg->port1 : reg->port0;
+		in_port = boundary - (group * 3);
+		port_state = ioread8(port_addr + in_port) & gpio_mask;
 
 		bitmap_set_value8(bits, port_state, offset);
 	}
@@ -113,30 +128,21 @@ static void idi_48_irq_mask(struct irq_data *data)
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
 	const unsigned offset = irqd_to_hwirq(data);
-	unsigned i;
-	unsigned mask;
-	unsigned boundary;
+	const unsigned long boundary = offset / 8;
+	const unsigned long mask = BIT(offset % 8);
 	unsigned long flags;
 
-	for (i = 0; i < 48; i += 8)
-		if (offset < i + 8) {
-			mask = BIT(offset - i);
-			boundary = i / 8;
-
-			idi48gpio->irq_mask[boundary] &= ~mask;
-
-			if (!idi48gpio->irq_mask[boundary]) {
-				idi48gpio->cos_enb &= ~BIT(boundary);
-
-				raw_spin_lock_irqsave(&idi48gpio->lock, flags);
+	idi48gpio->irq_mask[boundary] &= ~mask;
 
-				iowrite8(idi48gpio->cos_enb, idi48gpio->base + 7);
+	/* Exit early if there are still input lines with IRQ unmasked */
+	if (idi48gpio->irq_mask[boundary])
+		return;
 
-				raw_spin_unlock_irqrestore(&idi48gpio->lock, flags);
-			}
+	idi48gpio->cos_enb &= ~BIT(boundary);
 
-			return;
-		}
+	raw_spin_lock_irqsave(&idi48gpio->lock, flags);
+	iowrite8(idi48gpio->cos_enb, &idi48gpio->reg->irq);
+	raw_spin_unlock_irqrestore(&idi48gpio->lock, flags);
 }
 
 static void idi_48_irq_unmask(struct irq_data *data)
@@ -144,32 +150,24 @@ static void idi_48_irq_unmask(struct irq_data *data)
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
 	const unsigned offset = irqd_to_hwirq(data);
-	unsigned i;
-	unsigned mask;
-	unsigned boundary;
+	const unsigned long boundary = offset / 8;
+	const unsigned long mask = BIT(offset % 8);
 	unsigned prev_irq_mask;
 	unsigned long flags;
 
-	for (i = 0; i < 48; i += 8)
-		if (offset < i + 8) {
-			mask = BIT(offset - i);
-			boundary = i / 8;
-			prev_irq_mask = idi48gpio->irq_mask[boundary];
-
-			idi48gpio->irq_mask[boundary] |= mask;
+	prev_irq_mask = idi48gpio->irq_mask[boundary];
 
-			if (!prev_irq_mask) {
-				idi48gpio->cos_enb |= BIT(boundary);
+	idi48gpio->irq_mask[boundary] |= mask;
 
-				raw_spin_lock_irqsave(&idi48gpio->lock, flags);
+	/* Exit early if IRQ was already unmasked for this boundary */
+	if (prev_irq_mask)
+		return;
 
-				iowrite8(idi48gpio->cos_enb, idi48gpio->base + 7);
+	idi48gpio->cos_enb |= BIT(boundary);
 
-				raw_spin_unlock_irqrestore(&idi48gpio->lock, flags);
-			}
-
-			return;
-		}
+	raw_spin_lock_irqsave(&idi48gpio->lock, flags);
+	iowrite8(idi48gpio->cos_enb, &idi48gpio->reg->irq);
+	raw_spin_unlock_irqrestore(&idi48gpio->lock, flags);
 }
 
 static int idi_48_irq_set_type(struct irq_data *data, unsigned flow_type)
@@ -204,7 +202,7 @@ static irqreturn_t idi_48_irq_handler(int irq, void *dev_id)
 
 	raw_spin_lock(&idi48gpio->lock);
 
-	cos_status = ioread8(idi48gpio->base + 7);
+	cos_status = ioread8(&idi48gpio->reg->irq);
 
 	raw_spin_unlock(&idi48gpio->lock);
 
@@ -250,8 +248,8 @@ static int idi_48_irq_init_hw(struct gpio_chip *gc)
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(gc);
 
 	/* Disable IRQ by default */
-	iowrite8(0, idi48gpio->base + 7);
-	ioread8(idi48gpio->base + 7);
+	iowrite8(0, &idi48gpio->reg->irq);
+	ioread8(&idi48gpio->reg->irq);
 
 	return 0;
 }
@@ -273,8 +271,8 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	idi48gpio->base = devm_ioport_map(dev, base[id], IDI_48_EXTENT);
-	if (!idi48gpio->base)
+	idi48gpio->reg = devm_ioport_map(dev, base[id], IDI_48_EXTENT);
+	if (!idi48gpio->reg)
 		return -ENOMEM;
 
 	idi48gpio->chip.label = name;
-- 
2.36.1


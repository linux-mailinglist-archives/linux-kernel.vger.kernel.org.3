Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF86B4FAA9B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiDIUHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiDIUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:07:07 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24842DD6D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 13:04:58 -0700 (PDT)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eaf9:8401:9d41:ea18:e395:a08d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 277172C4654;
        Sat,  9 Apr 2022 21:55:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1649534160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uRGo5vYh4KWsfFxzH88QOPhI+uf6Yg6jZrVcj/clFBU=;
        b=8W9kwhRrYgwwuuUK1PT2+L4fu52pQ89W85oReU8nv53sYrP7eODvVf8p1BPkTTol0tyQ+b
        UEZehX9TAeULharZ498D6I/dvpl9Q/b0s3Q0IRofbeXCoJR2CQpIps2SoEHfz47Tb/ALUx
        14cXn42Tm2z3wJjQhhSBOFrJs/FgPTQxD87jyNRQWVh+dbQTaFdpDH2+C9MeG8zAgWbaTk
        Svr8epFEgV6u8YHrZBT19woAvHCCuru7HGofYCbFnJ7a+3tyiidywFe4Uzbp5EREXcoBYq
        1alWOLHTOfdXlOJYW6TRy1gznuVqDH35F7fr5ioVqZ0GM3rSs5Kar7iVYLSvyw==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Bert Vermeulen <bert@biot.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/6] gpio: realtek-otto: Support reversed port layouts
Date:   Sat,  9 Apr 2022 21:55:47 +0200
Message-Id: <7105ae382d7b328102f66b39ffd7c94998e85265.1649533972.git.sander@svanheule.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649533972.git.sander@svanheule.net>
References: <cover.1649533972.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO port layout on the RTL930x SoC series is reversed compared to
the RTL838x and RTL839x SoC series. Add new port offset calculator
functions to ensure the correct order is used when reading port IRQ
data, and ensure bgpio uses the right byte ordering.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/gpio/gpio-realtek-otto.c | 55 +++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-realtek-otto.c b/drivers/gpio/gpio-realtek-otto.c
index bd75401b549d..c838ad8ce55f 100644
--- a/drivers/gpio/gpio-realtek-otto.c
+++ b/drivers/gpio/gpio-realtek-otto.c
@@ -58,6 +58,8 @@ struct realtek_gpio_ctrl {
 	raw_spinlock_t lock;
 	u16 intr_mask[REALTEK_GPIO_PORTS_PER_BANK];
 	u16 intr_type[REALTEK_GPIO_PORTS_PER_BANK];
+	unsigned int (*port_offset_u8)(unsigned int port);
+	unsigned int (*port_offset_u16)(unsigned int port);
 };
 
 /* Expand with more flags as devices with other quirks are added */
@@ -69,6 +71,11 @@ enum realtek_gpio_flags {
 	 * line the IRQ handler was assigned to, causing uncaught interrupts.
 	 */
 	GPIO_INTERRUPTS_DISABLED = BIT(0),
+	/*
+	 * Port order is reversed, meaning DCBA register layout for 1-bit
+	 * fields, and [BA, DC] for 2-bit fields.
+	 */
+	GPIO_PORTS_REVERSED = BIT(1),
 };
 
 static struct realtek_gpio_ctrl *irq_data_to_ctrl(struct irq_data *data)
@@ -86,21 +93,50 @@ static struct realtek_gpio_ctrl *irq_data_to_ctrl(struct irq_data *data)
  * port. The two interrupt mask registers store two bits per GPIO, so use u16
  * values.
  */
+static unsigned int realtek_gpio_port_offset_u8(unsigned int port)
+{
+	return port;
+}
+
+static unsigned int realtek_gpio_port_offset_u16(unsigned int port)
+{
+	return 2 * port;
+}
+
+/*
+ * Reversed port order register access
+ *
+ * For registers with one bit per GPIO, all ports are stored as u8-s in one
+ * register in reversed order. The two interrupt mask registers store two bits
+ * per GPIO, so use u16 values. The first register contains ports 1 and 0, the
+ * second ports 3 and 2.
+ */
+static unsigned int realtek_gpio_port_offset_u8_rev(unsigned int port)
+{
+	return 3 - port;
+}
+
+static unsigned int realtek_gpio_port_offset_u16_rev(unsigned int port)
+{
+	return 2 * (port ^ 1);
+}
+
 static void realtek_gpio_write_imr(struct realtek_gpio_ctrl *ctrl,
 	unsigned int port, u16 irq_type, u16 irq_mask)
 {
-	iowrite16(irq_type & irq_mask, ctrl->base + REALTEK_GPIO_REG_IMR + 2 * port);
+	iowrite16(irq_type & irq_mask,
+		ctrl->base + REALTEK_GPIO_REG_IMR + ctrl->port_offset_u16(port));
 }
 
 static void realtek_gpio_clear_isr(struct realtek_gpio_ctrl *ctrl,
 	unsigned int port, u8 mask)
 {
-	iowrite8(mask, ctrl->base + REALTEK_GPIO_REG_ISR + port);
+	iowrite8(mask, ctrl->base + REALTEK_GPIO_REG_ISR + ctrl->port_offset_u8(port));
 }
 
 static u8 realtek_gpio_read_isr(struct realtek_gpio_ctrl *ctrl, unsigned int port)
 {
-	return ioread8(ctrl->base + REALTEK_GPIO_REG_ISR + port);
+	return ioread8(ctrl->base + REALTEK_GPIO_REG_ISR + ctrl->port_offset_u8(port));
 }
 
 /* Set the rising and falling edge mask bits for a GPIO port pin */
@@ -250,6 +286,7 @@ MODULE_DEVICE_TABLE(of, realtek_gpio_of_match);
 static int realtek_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	unsigned long bgpio_flags;
 	unsigned int dev_flags;
 	struct gpio_irq_chip *girq;
 	struct realtek_gpio_ctrl *ctrl;
@@ -277,10 +314,20 @@ static int realtek_gpio_probe(struct platform_device *pdev)
 
 	raw_spin_lock_init(&ctrl->lock);
 
+	if (dev_flags & GPIO_PORTS_REVERSED) {
+		bgpio_flags = 0;
+		ctrl->port_offset_u8 = realtek_gpio_port_offset_u8_rev;
+		ctrl->port_offset_u16 = realtek_gpio_port_offset_u16_rev;
+	} else {
+		bgpio_flags = BGPIOF_BIG_ENDIAN_BYTE_ORDER;
+		ctrl->port_offset_u8 = realtek_gpio_port_offset_u8;
+		ctrl->port_offset_u16 = realtek_gpio_port_offset_u16;
+	}
+
 	err = bgpio_init(&ctrl->gc, dev, 4,
 		ctrl->base + REALTEK_GPIO_REG_DATA, NULL, NULL,
 		ctrl->base + REALTEK_GPIO_REG_DIR, NULL,
-		BGPIOF_BIG_ENDIAN_BYTE_ORDER);
+		bgpio_flags);
 	if (err) {
 		dev_err(dev, "unable to init generic GPIO");
 		return err;
-- 
2.35.1


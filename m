Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58624FAA9C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiDIUHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiDIUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:07:07 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6148448E41
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 13:04:58 -0700 (PDT)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eaf9:8401:9d41:ea18:e395:a08d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id B7EDD2C4655;
        Sat,  9 Apr 2022 21:56:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1649534161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADyb9IacFCFsKePa1Pnrn2WIbPbzJAembwxCqsyNT6Y=;
        b=hv3nAX3IG4jyqCSOo/JHSAnXRto7ZgEvsHoITR2mYA6mTHEF+3J2P6yDdKC8oItL10F6l0
        Hx2gWzNrPdOAiZ6k9toMU/Kwx8iLYe4u88rFwBLPgxbOyFiukVeeB+IMWXbvSj5dIHp4Wj
        +4Oh4s99kOfn5wzC2Dpm4W9Jjs8/gPoHDscXSLTH1GscjXIYLuTt8gj8i+28v/RdKZ081K
        Adv7/G2YCUd9McmlhthWtviY7RSBw/E3TLoAOWJJ/oM8rQUQxm6ERhLYCRHyG0eucY+v1l
        WurKnKvT6ay20OST7NEY/EkzezMj+uc18olSixhLcdfh4cuVneRWXXm8OqXI3Q==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Bert Vermeulen <bert@biot.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/6] gpio: realtek-otto: Support per-cpu interrupts
Date:   Sat,  9 Apr 2022 21:55:48 +0200
Message-Id: <8d4e0848f233c2c1b98aa141741c61d95cd3843f.1649533972.git.sander@svanheule.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649533972.git.sander@svanheule.net>
References: <cover.1649533972.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SoCs with multiple cores, it is possible that the GPIO interrupt
controller supports assigning specific pins to one or more cores.

IRQ balancing can be performed on a line-by-line basis if the parent
interrupt is routed to all available cores, which is the default upon
initialisation.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/gpio/gpio-realtek-otto.c | 75 +++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-realtek-otto.c b/drivers/gpio/gpio-realtek-otto.c
index c838ad8ce55f..dd1b7656d23a 100644
--- a/drivers/gpio/gpio-realtek-otto.c
+++ b/drivers/gpio/gpio-realtek-otto.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/gpio/driver.h>
+#include <linux/cpumask.h>
 #include <linux/irq.h>
 #include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
@@ -55,6 +56,8 @@
 struct realtek_gpio_ctrl {
 	struct gpio_chip gc;
 	void __iomem *base;
+	void __iomem *cpumask_base;
+	struct cpumask cpu_irq_maskable;
 	raw_spinlock_t lock;
 	u16 intr_mask[REALTEK_GPIO_PORTS_PER_BANK];
 	u16 intr_type[REALTEK_GPIO_PORTS_PER_BANK];
@@ -76,6 +79,11 @@ enum realtek_gpio_flags {
 	 * fields, and [BA, DC] for 2-bit fields.
 	 */
 	GPIO_PORTS_REVERSED = BIT(1),
+	/*
+	 * Interrupts can be enabled per cpu. This requires a secondary IO
+	 * range, where the per-cpu enable masks are located.
+	 */
+	GPIO_INTERRUPTS_PER_CPU = BIT(2),
 };
 
 static struct realtek_gpio_ctrl *irq_data_to_ctrl(struct irq_data *data)
@@ -247,14 +255,61 @@ static void realtek_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(irq_chip, desc);
 }
 
+static inline void __iomem *realtek_gpio_irq_cpu_mask(struct realtek_gpio_ctrl *ctrl,
+	unsigned int port, int cpu)
+{
+	return ctrl->cpumask_base + ctrl->port_offset_u8(port) +
+		REALTEK_GPIO_PORTS_PER_BANK * cpu;
+}
+
+static int realtek_gpio_irq_set_affinity(struct irq_data *data,
+	const struct cpumask *dest, bool force)
+{
+	struct realtek_gpio_ctrl *ctrl = irq_data_to_ctrl(data);
+	unsigned int line = irqd_to_hwirq(data);
+	unsigned int port = line / 8;
+	unsigned int port_pin = line % 8;
+	void __iomem *irq_cpu_mask;
+	unsigned long flags;
+	int cpu;
+	u8 v;
+
+	if (!ctrl->cpumask_base)
+		return -ENXIO;
+
+	raw_spin_lock_irqsave(&ctrl->lock, flags);
+
+	for_each_cpu(cpu, &ctrl->cpu_irq_maskable) {
+		irq_cpu_mask = realtek_gpio_irq_cpu_mask(ctrl, port, cpu);
+		v = ioread8(irq_cpu_mask);
+
+		if (cpumask_test_cpu(cpu, dest))
+			v |= BIT(port_pin);
+		else
+			v &= ~BIT(port_pin);
+
+		iowrite8(v, irq_cpu_mask);
+	}
+
+	raw_spin_unlock_irqrestore(&ctrl->lock, flags);
+
+	irq_data_update_effective_affinity(data, dest);
+
+	return 0;
+}
+
 static int realtek_gpio_irq_init(struct gpio_chip *gc)
 {
 	struct realtek_gpio_ctrl *ctrl = gpiochip_get_data(gc);
 	unsigned int port;
+	int cpu;
 
 	for (port = 0; (port * 8) < gc->ngpio; port++) {
 		realtek_gpio_write_imr(ctrl, port, 0, 0);
 		realtek_gpio_clear_isr(ctrl, port, GENMASK(7, 0));
+
+		for_each_cpu(cpu, &ctrl->cpu_irq_maskable)
+			iowrite8(GENMASK(7, 0), realtek_gpio_irq_cpu_mask(ctrl, port, cpu));
 	}
 
 	return 0;
@@ -266,6 +321,7 @@ static struct irq_chip realtek_gpio_irq_chip = {
 	.irq_mask = realtek_gpio_irq_mask,
 	.irq_unmask = realtek_gpio_irq_unmask,
 	.irq_set_type = realtek_gpio_irq_set_type,
+	.irq_set_affinity = realtek_gpio_irq_set_affinity,
 };
 
 static const struct of_device_id realtek_gpio_of_match[] = {
@@ -290,8 +346,10 @@ static int realtek_gpio_probe(struct platform_device *pdev)
 	unsigned int dev_flags;
 	struct gpio_irq_chip *girq;
 	struct realtek_gpio_ctrl *ctrl;
+	struct resource *res;
 	u32 ngpios;
-	int err, irq;
+	unsigned int nr_cpus;
+	int cpu, err, irq;
 
 	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
@@ -352,6 +410,21 @@ static int realtek_gpio_probe(struct platform_device *pdev)
 		girq->init_hw = realtek_gpio_irq_init;
 	}
 
+	cpumask_clear(&ctrl->cpu_irq_maskable);
+
+	if ((dev_flags & GPIO_INTERRUPTS_PER_CPU) && irq > 0) {
+		ctrl->cpumask_base = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
+		if (IS_ERR(ctrl->cpumask_base))
+			return dev_err_probe(dev, PTR_ERR(ctrl->cpumask_base),
+				"missing CPU IRQ mask registers");
+
+		nr_cpus = resource_size(res) / REALTEK_GPIO_PORTS_PER_BANK;
+		nr_cpus = min(nr_cpus, num_present_cpus());
+
+		for (cpu = 0; cpu < nr_cpus; cpu++)
+			cpumask_set_cpu(cpu, &ctrl->cpu_irq_maskable);
+	}
+
 	return devm_gpiochip_add_data(dev, &ctrl->gc, ctrl);
 }
 
-- 
2.35.1


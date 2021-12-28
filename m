Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D86B480C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhL1RXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 12:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbhL1RXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:23:21 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF44AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 09:23:20 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bq20so42747091lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 09:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sad6wBaofbMcE43B0klX9Ezag5R7oGFQoIF5dWam0JE=;
        b=i4tJzY4aPuIdxvL/auttUTRvWXvxVVPVmVwFeYprvob3BhEKAuO8e1muY/El/Z3me3
         m96rbpEg83sfILha6UwhcrZd8kdHGlS/mVROcGJmiI3mJHdDNLbL5Qdja+wjKfl3V34V
         EX9RyMU7cp3npSUIw2b2tuAeqh+Ms9zdbXXfS+cn7mT/bjzQjSwFXwZeeQKcrG7IkJhK
         ZhYibQn6+07vs6JMwJkg2ZRCIG28dyt7HebBhObR62x7FhnPno20jTQiw1Q5FNxGBNez
         0C9tp9epFIVWelAidbBubmylvsRifhO2WEdG2FT5XBpJiJpeSac4htwfJ+naTYNkK9CV
         IH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sad6wBaofbMcE43B0klX9Ezag5R7oGFQoIF5dWam0JE=;
        b=FOUROzAkct/t68+/YovzJr6a8MZUei7mOiVa5y4nHKhi04fciFUhiSDyN67pRYBbM2
         VTh3AYe56L+gpIWX1EOxnxXmE/b49z7nWryKNzqv8mqrOh6exzLuTHSNeHvVdXDpIg3z
         F2U4vjeoMzB2TRHepCOwhs6pQkxXvJsRsnZfHj2ktImhFdAMQLktyPzq/rzZ7KAJifmN
         63w7kR2iRFWPANhtP7Jh5ehLaGL1nQhjDvXAEoDYtYzvbH0KQbqBnrMJbHnDR9Q79OTF
         FOVfxycVRK8aCjF8c4GMTaSvbK5YkxYM83cuachgzuvZwdnkg8/W5SQj/BqYO8qn1TVr
         xb2Q==
X-Gm-Message-State: AOAM532cEen/Ardjuy/SRERhsPaWEM2ErrCNcYJVGmZ5dAMOs0NKsJ0U
        RxDGlYaR1s3O/fVeq44aFsqm0dolxKHSyEBS
X-Google-Smtp-Source: ABdhPJwckiG06DrdaWZfYMsN4S5wUdpz9C7x+xoKKRDTzw3nwbojzdr9eswasjIuPOpuyCOpcyhiQQ==
X-Received: by 2002:a05:6512:33c9:: with SMTP id d9mr14426735lfg.516.1640712199072;
        Tue, 28 Dec 2021 09:23:19 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id g11sm1976571lfr.249.2021.12.28.09.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 09:23:18 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH/RFC] drivers/irqchip: add irq-inverter
Date:   Tue, 28 Dec 2021 19:56:43 +0300
Message-Id: <20211228165642.2514766-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt trigger type is typically used to configure interrupt
controller to properly interpret interrupt signal sent from a device.

However, some devices have configureable interrupt outputs, and drivers
tend to use interrupt trigger type also to configure device interrupt
output.

This works well when device interrupt output is connected directly to
interrupt controller input. However, this is not always the case.
Sometimes the interrupt signal gets inverted between the device
producing it and the controller consuming it. Combined with both sides
using the same interrupt trigger type to configure the signal, this
results into non-working setup regardless of what interrupt trigger type
is configured.

Irq-inverer is a solution for this case. It is a virtual irqchip that
provides additional virq number that behaves exactly as existing one,
but with inverted trigger type reported via irq_get_trigger_type() API.

Usage example, for Kingfisher extension board for Renesas Gen-3 Soc,
that has WiFi interrupt delivered over inverting level-shifter:

/ {
	wlcore_interrupt: inverter {
		compatible = "linux,irq-inverter";
		interrupts-extended = <&gpio1 25 IRQ_TYPE_EDGE_RISING>;
		interrupt-controller;
		#interrupt-cells = <0>;
	};
};

&wlcore {
	interrupts-extended = <&wlcore_interrupt>;
};

Then, wl18xx driver gets IRQ_TYPE_EDGE_FALLING return from
irq_get_trigger_type() call, and configures interrupt output for that.
Then the signal is delivered inverted to the GPIO module, and handled
correctly, because GPIO is configured for IRQ_TYPE_EDGE_RISING.

Implementation notes:

- why platform_driver and not IRQCHIP_DECLARE()?
- because IRQCHIP_DECLARE() does not process EPROBE_DEFER properly

- why not using hierarchial irq_domain?
- because with hierarchial irq_domain, same interrupt gets the same virq
  number at all levels, and trigger type is tied to virq number, so need
  different virq numbers for reporting different trigger types

- why using request_irq() for parent irq, instead of setting up chained
  interrupt in irqchips?
- because this way code is much simpler, and shall work for all cases
  (such as normal/threaded parent irq, normal/threaded child irq,
  different parent interrupt chips, etc)

- why just not introducing separate API for consumer-side and
  produced-side trigger type?
- because with the chosen approach, no changes are needed to any cases
  that don't suffer from inverted interrupt routing

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/irqchip/Kconfig        |  10 +++
 drivers/irqchip/Makefile       |   1 +
 drivers/irqchip/irq-inverter.c | 159 +++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 drivers/irqchip/irq-inverter.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7038957f4a77..02040024b4da 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -617,4 +617,14 @@ config MCHP_EIC
 	help
 	  Support for Microchip External Interrupt Controller.
 
+config IRQ_INVERTER
+	bool "IRQ inverter support"
+	select IRQ_DOMAIN
+	help
+	  Support for virtual interrupt line that represent inverted signal
+	  of other interrupt line.
+
+	  This is intended for cases when both interrupt source and interrupt
+	  consumer use interrupt's trigger type to configure interrupt signal
+	  polarity, but the interrupt signal is negated by hardware in between.
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c1f611cbfbf8..8e7d27b0c13d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -117,3 +117,4 @@ obj-$(CONFIG_WPCM450_AIC)		+= irq-wpcm450-aic.o
 obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
 obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
 obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
+obj-$(CONFIG_IRQ_INVERTER)		+= irq-inverter.o
diff --git a/drivers/irqchip/irq-inverter.c b/drivers/irqchip/irq-inverter.c
new file mode 100644
index 000000000000..ef48a26aee96
--- /dev/null
+++ b/drivers/irqchip/irq-inverter.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+struct irq_inverter {
+	int parent_irq;
+	int child_irq;
+	unsigned int inverted_type;
+};
+
+static irqreturn_t irq_inverter_parent_irq(int irq, void *data)
+{
+	struct irq_inverter *inv = data;
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	generic_handle_irq(inv->child_irq);
+	raw_local_irq_restore(flags);
+
+	return IRQ_HANDLED;
+}
+
+static void irq_inverter_enable(struct irq_data *data)
+{
+	struct irq_inverter *inv = data->chip_data;
+
+	enable_irq(inv->parent_irq);
+}
+
+static void irq_inverter_disable(struct irq_data *data)
+{
+	struct irq_inverter *inv = data->chip_data;
+
+	disable_irq_nosync(inv->parent_irq);
+}
+
+static int irq_inverter_set_type(struct irq_data *data, unsigned int type)
+{
+	struct irq_inverter *inv = data->chip_data;
+
+	return type == inv->inverted_type ? 0 : -EINVAL;
+}
+
+static struct irq_chip irq_inverter_chip = {
+	.name = KBUILD_MODNAME,
+	.irq_enable = irq_inverter_enable,
+	.irq_disable = irq_inverter_disable,
+	.irq_set_type = irq_inverter_set_type,
+};
+
+static int irq_inverter_xlate(struct irq_domain *d, struct device_node *node,
+		const u32 *intspec, unsigned int intsize,
+		unsigned long *out_hwirq, unsigned int *out_type)
+{
+	struct irq_inverter *inv = d->host_data;
+
+	if (intsize != 0)
+		return -EINVAL;
+
+	*out_hwirq = 0;
+	*out_type = inv->inverted_type;
+	return 0;
+}
+
+static int irq_inverter_map(struct irq_domain *d, unsigned int virq,
+		irq_hw_number_t hw)
+{
+	struct irq_inverter *inv = d->host_data;
+
+	inv->child_irq = virq;
+	irq_set_chip_and_handler(virq, &irq_inverter_chip, handle_simple_irq);
+	irq_set_chip_data(virq, inv);
+	return 0;
+}
+
+static const struct irq_domain_ops irq_inverter_domain_ops = {
+	.xlate = irq_inverter_xlate,
+	.map = irq_inverter_map,
+};
+
+static int irq_inverter_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct irq_inverter *inv;
+	struct irq_domain *domain;
+	unsigned int parent_type;
+	int ret;
+
+	inv = kzalloc(sizeof(*inv), GFP_KERNEL);
+	if (!inv)
+		return -ENOMEM;
+
+	ret = of_irq_get(node, 0);
+	if (ret < 0) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "could not get parent irq\n");
+		goto err_free_inv;
+	}
+	inv->parent_irq = ret;
+
+	parent_type = irq_get_trigger_type(inv->parent_irq);
+	if (!parent_type) {
+		dev_err(&pdev->dev, "parent irq trigger type is not defined\n");
+		ret = -EINVAL;
+		goto err_free_inv;
+	}
+	if (parent_type & IRQ_TYPE_EDGE_RISING)
+		inv->inverted_type |= IRQ_TYPE_EDGE_FALLING;
+	if (parent_type & IRQ_TYPE_EDGE_FALLING)
+		inv->inverted_type |= IRQ_TYPE_EDGE_RISING;
+	if (parent_type & IRQ_TYPE_LEVEL_HIGH)
+		inv->inverted_type |= IRQ_TYPE_LEVEL_LOW;
+	if (parent_type & IRQ_TYPE_LEVEL_LOW)
+		inv->inverted_type |= IRQ_TYPE_LEVEL_HIGH;
+
+	ret = request_irq(inv->parent_irq, irq_inverter_parent_irq,
+			parent_type | IRQF_NO_AUTOEN, KBUILD_MODNAME, inv);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not request parent irq\n");
+		goto err_free_inv;
+	}
+
+	domain = irq_domain_add_linear(node, 1, &irq_inverter_domain_ops, inv);
+	if (!domain) {
+		ret = -ENOMEM;
+		goto err_free_irq;
+	}
+
+	return 0;
+
+err_free_irq:
+	free_irq(inv->parent_irq, inv);
+err_free_inv:
+	kfree(inv);
+	return ret;
+}
+
+static const struct of_device_id irq_inverter_match[] = {
+	{ .compatible = "linux,irq-inverter" },
+	{}
+};
+
+static struct platform_driver irq_inverter_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = irq_inverter_match,
+	},
+	.probe = irq_inverter_probe,
+};
+
+static int __init irq_inverter_init(void)
+{
+	return platform_driver_register(&irq_inverter_driver);
+}
+
+subsys_initcall(irq_inverter_init);
-- 
2.30.2


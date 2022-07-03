Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA448564995
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 21:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiGCTlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 15:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiGCTlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 15:41:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DB060FD;
        Sun,  3 Jul 2022 12:41:42 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z1so1056950plb.1;
        Sun, 03 Jul 2022 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CEOh1MxU9c1aKZbSqjLUHoMSMkISw+NEmnMGAQ+BJnY=;
        b=Q6J6qYhRWfuKFpgyfUjVEO/w6u+CjlAuDi1ga0ZQqMEnL+d4ovwKfrsydTYutMCIv0
         /WLO9I0e/76DnTtuhy130Z2OghDLx3ZNmEDE4bI6dibZ0ohlRDQqt5N/E/kU2CgKFqud
         YMqtJrKB8bnbw9vpsyiMOvg7VP6EK54vbzO67gBlBw0sd8QuK4GDb7mx50i9Oz5o5hhZ
         syVFC5NJbGH4R9h3UIPw/CtcC+Im1u0HCR91JAlX0xnjZRaf3KDmbsbUOkHMi9sRrUtD
         hyXCo1xIF75tkbMPzZpNLEkykgizXQFxbUqXF6aup3I9VP/dOlZ8NK0fbbkhEAG0ShkH
         YESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CEOh1MxU9c1aKZbSqjLUHoMSMkISw+NEmnMGAQ+BJnY=;
        b=xhveqSWYNgENFcLEsDxKyCGXuJtKgGnbxIwckDX4gL0dJOsdoOeMKy6yZygLQuYFsn
         WMMGhKPj6QW2qVhwnoabYCWCWyQc5yANGppDxqFBldzqRT4BSII/ZfxDcmqL7W9ruCt3
         Oe5xxeMzQzA/eGcgjd3XvWtl9WzGXLWxRz+IjW/PJnZdaUEm75efYONGsXReJ+hcc2pp
         8DJUCXD5XFeyC34oajcno5ox1DtQztytdPIJQpM+IYzocij5u5uGN80ZbkRDR0PGbEAQ
         8Bq/hdodX+KJ+nfYn+BpcwZAfV6tsEvm1ooQhh+WH4UkamqZZPSigXCO7YQAq7Qo+BzQ
         cYbA==
X-Gm-Message-State: AJIora/yWVQj9Zo5ZUWAkSJ/oC3h13XBu3djKkwN//2yEqLYFtlh0AG2
        YkyOgi1/KDPtf0CAYkjWlqU=
X-Google-Smtp-Source: AGRyM1shQxVzazN5H/wKRucgfhiSGr+4dF5GjkE5TOOqus8acwgmqRU3juo4/6smQDcNH85z0LdCdQ==
X-Received: by 2002:a17:902:7104:b0:16b:e1fa:eac7 with SMTP id a4-20020a170902710400b0016be1faeac7mr2092852pll.128.1656877301912;
        Sun, 03 Jul 2022 12:41:41 -0700 (PDT)
Received: from prasmi.domain.name ([103.219.60.86])
        by smtp.gmail.com with ESMTPSA id y19-20020a17090aca9300b001e0c5da6a51sm10656104pjt.50.2022.07.03.12.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 12:41:41 -0700 (PDT)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v7 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller driver
Date:   Sun,  3 Jul 2022 20:40:17 +0100
Message-Id: <20220703194020.78701-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703194020.78701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220703194020.78701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the Renesas RZ/G2L Interrupt Controller.

This supports external pins being used as interrupts. It supports
one line for NMI, 8 external pins and 32 GPIO pins (out of 123)
to be used as IRQ lines.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/irqchip/Kconfig             |   8 +
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/irq-renesas-rzg2l.c | 393 ++++++++++++++++++++++++++++
 3 files changed, 402 insertions(+)
 create mode 100644 drivers/irqchip/irq-renesas-rzg2l.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 1f23a6be7d88..b1ab85171a3a 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -242,6 +242,14 @@ config RENESAS_RZA1_IRQC
 	  Enable support for the Renesas RZ/A1 Interrupt Controller, to use up
 	  to 8 external interrupts with configurable sense select.
 
+config RENESAS_RZG2L_IRQC
+	bool "Renesas RZ/G2L (and alike SoC) IRQC support" if COMPILE_TEST
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Enable support for the Renesas RZ/G2L (and alike SoC) Interrupt Controller
+	  for external devices.
+
 config SL28CPLD_INTC
 	bool "Kontron sl28cpld IRQ controller"
 	depends on MFD_SL28CPLD=y || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 5b67450a9538..04cb15b647c5 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_RDA_INTC)			+= irq-rda-intc.o
 obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
 obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
 obj-$(CONFIG_RENESAS_RZA1_IRQC)		+= irq-renesas-rza1.o
+obj-$(CONFIG_RENESAS_RZG2L_IRQC)	+= irq-renesas-rzg2l.o
 obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= irq-zevio.o
 obj-$(CONFIG_ARCH_VT8500)		+= irq-vt8500.o
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
new file mode 100644
index 000000000000..4e977fa04bbe
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L IRQC Driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation.
+ *
+ * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+
+#define IRQC_IRQ_START			1
+#define IRQC_IRQ_COUNT			8
+#define IRQC_TINT_START			(IRQC_IRQ_START + IRQC_IRQ_COUNT)
+#define IRQC_TINT_COUNT			32
+#define IRQC_NUM_IRQ			(IRQC_TINT_START + IRQC_TINT_COUNT)
+
+#define ISCR				0x10
+#define IITSR				0x14
+#define TSCR				0x20
+#define TITSR0				0x24
+#define TITSR1				0x28
+#define TITSR0_MAX_INT			16
+#define TITSEL_WIDTH			0x2
+#define TSSR(n)				(0x30 + ((n) * 4))
+#define TIEN				BIT(7)
+#define TSSEL_SHIFT(n)			(8 * (n))
+#define TSSEL_MASK			GENMASK(7, 0)
+#define IRQ_MASK			0x3
+
+#define TSSR_OFFSET(n)			((n) % 4)
+#define TSSR_INDEX(n)			((n) / 4)
+
+#define TITSR_TITSEL_EDGE_RISING	0
+#define TITSR_TITSEL_EDGE_FALLING	1
+#define TITSR_TITSEL_LEVEL_HIGH		2
+#define TITSR_TITSEL_LEVEL_LOW		3
+
+#define IITSR_IITSEL(n, sense)		((sense) << ((n) * 2))
+#define IITSR_IITSEL_LEVEL_LOW		0
+#define IITSR_IITSEL_EDGE_FALLING	1
+#define IITSR_IITSEL_EDGE_RISING	2
+#define IITSR_IITSEL_EDGE_BOTH		3
+#define IITSR_IITSEL_MASK(n)		IITSR_IITSEL((n), 3)
+
+#define TINT_EXTRACT_HWIRQ(x)           FIELD_GET(GENMASK(15, 0), (x))
+#define TINT_EXTRACT_GPIOINT(x)         FIELD_GET(GENMASK(31, 16), (x))
+
+struct rzg2l_irqc_priv {
+	void __iomem *base;
+	struct irq_fwspec fwspec[IRQC_NUM_IRQ];
+	raw_spinlock_t lock;
+};
+
+static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
+{
+	return data->domain->host_data;
+}
+
+static void rzg2l_irq_eoi(struct irq_data *d)
+{
+	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	u32 bit = BIT(hw_irq);
+	u32 reg;
+
+	reg = readl_relaxed(priv->base + ISCR);
+	if (reg & bit)
+		writel_relaxed(reg & ~bit, priv->base + ISCR);
+}
+
+static void rzg2l_tint_eoi(struct irq_data *d)
+{
+	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_TINT_START;
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	u32 bit = BIT(hw_irq);
+	u32 reg;
+
+	reg = readl_relaxed(priv->base + TSCR);
+	if (reg & bit)
+		writel_relaxed(reg & ~bit, priv->base + TSCR);
+}
+
+static void rzg2l_irqc_eoi(struct irq_data *d)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hw_irq = irqd_to_hwirq(d);
+
+	raw_spin_lock(&priv->lock);
+	if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
+		rzg2l_irq_eoi(d);
+	else if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
+		rzg2l_tint_eoi(d);
+	raw_spin_unlock(&priv->lock);
+	irq_chip_eoi_parent(d);
+}
+
+static void rzg2l_irqc_irq_disable(struct irq_data *d)
+{
+	unsigned int hw_irq = irqd_to_hwirq(d);
+
+	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
+		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+		u32 offset = hw_irq - IRQC_TINT_START;
+		u32 tssr_offset = TSSR_OFFSET(offset);
+		u8 tssr_index = TSSR_INDEX(offset);
+		u32 reg;
+
+		raw_spin_lock(&priv->lock);
+		reg = readl_relaxed(priv->base + TSSR(tssr_index));
+		reg &= ~(TSSEL_MASK << tssr_offset);
+		writel_relaxed(reg, priv->base + TSSR(tssr_index));
+		raw_spin_unlock(&priv->lock);
+	}
+	irq_chip_disable_parent(d);
+}
+
+static void rzg2l_irqc_irq_enable(struct irq_data *d)
+{
+	unsigned int hw_irq = irqd_to_hwirq(d);
+
+	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
+		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+		unsigned long tint = (uintptr_t)d->chip_data;
+		u32 offset = hw_irq - IRQC_TINT_START;
+		u32 tssr_offset = TSSR_OFFSET(offset);
+		u8 tssr_index = TSSR_INDEX(offset);
+		u32 reg;
+
+		raw_spin_lock(&priv->lock);
+		reg = readl_relaxed(priv->base + TSSR(tssr_index));
+		reg |= (TIEN | tint) << TSSEL_SHIFT(tssr_offset);
+		writel_relaxed(reg, priv->base + TSSR(tssr_index));
+		raw_spin_unlock(&priv->lock);
+	}
+	irq_chip_enable_parent(d);
+}
+
+static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	u16 sense, tmp;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_LEVEL_LOW:
+		sense = IITSR_IITSEL_LEVEL_LOW;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		sense = IITSR_IITSEL_EDGE_FALLING;
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		sense = IITSR_IITSEL_EDGE_RISING;
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		sense = IITSR_IITSEL_EDGE_BOTH;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	raw_spin_lock(&priv->lock);
+	tmp = readl_relaxed(priv->base + IITSR);
+	tmp &= ~IITSR_IITSEL_MASK(hw_irq);
+	tmp |= IITSR_IITSEL(hw_irq, sense);
+	writel_relaxed(tmp, priv->base + IITSR);
+	raw_spin_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+	u32 titseln = hwirq - IRQC_TINT_START;
+	u32 offset;
+	u8 sense;
+	u32 reg;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_RISING:
+		sense = TITSR_TITSEL_EDGE_RISING;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		sense = TITSR_TITSEL_EDGE_FALLING;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	offset = TITSR0;
+	if (titseln >= TITSR0_MAX_INT) {
+		titseln -= TITSR0_MAX_INT;
+		offset = TITSR1;
+	}
+
+	raw_spin_lock(&priv->lock);
+	reg = readl_relaxed(priv->base + offset);
+	reg &= ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
+	reg |= sense << (titseln * TITSEL_WIDTH);
+	writel_relaxed(reg, priv->base + offset);
+	raw_spin_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int rzg2l_irqc_set_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int hw_irq = irqd_to_hwirq(d);
+	int ret = -EINVAL;
+
+	if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
+		ret = rzg2l_irq_set_type(d, type);
+	else if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
+		ret = rzg2l_tint_set_edge(d, type);
+	if (ret)
+		return ret;
+
+	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
+}
+
+static const struct irq_chip irqc_chip = {
+	.name			= "rzg2l-irqc",
+	.irq_eoi		= rzg2l_irqc_eoi,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_disable		= rzg2l_irqc_irq_disable,
+	.irq_enable		= rzg2l_irqc_irq_enable,
+	.irq_get_irqchip_state	= irq_chip_get_parent_state,
+	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= rzg2l_irqc_set_type,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
+};
+
+static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
+			    unsigned int nr_irqs, void *arg)
+{
+	struct rzg2l_irqc_priv *priv = domain->host_data;
+	unsigned long tint = 0;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	ret = irq_domain_translate_twocell(domain, arg, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	/*
+	 * For TINT interrupts ie where pinctrl driver is child of irqc domain
+	 * the hwirq and TINT are encoded in fwspec->param[0].
+	 * hwirq for TINT range from 9-40, hwirq is embedded 0-15 bits and TINT
+	 * from 16-31 bits. TINT from the pinctrl driver needs to be programmed
+	 * in IRQC registers to enable a given gpio pin as interrupt.
+	 */
+	if (hwirq > IRQC_IRQ_COUNT) {
+		tint = TINT_EXTRACT_GPIOINT(hwirq);
+		hwirq = TINT_EXTRACT_HWIRQ(hwirq);
+
+		if (hwirq < IRQC_TINT_START)
+			return -EINVAL;
+	}
+
+	if (hwirq > (IRQC_NUM_IRQ - 1))
+		return -EINVAL;
+
+	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &irqc_chip,
+					    (void *)(uintptr_t)tint);
+	if (ret)
+		return ret;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &priv->fwspec[hwirq]);
+}
+
+static const struct irq_domain_ops rzg2l_irqc_domain_ops = {
+	.alloc = rzg2l_irqc_alloc,
+	.free = irq_domain_free_irqs_common,
+	.translate = irq_domain_translate_twocell,
+};
+
+static int rzg2l_irqc_parse_interrupts(struct rzg2l_irqc_priv *priv,
+				       struct device_node *np)
+{
+	struct of_phandle_args map;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < IRQC_NUM_IRQ; i++) {
+		ret = of_irq_parse_one(np, i, &map);
+		if (ret)
+			return ret;
+		of_phandle_args_to_fwspec(np, map.args, map.args_count,
+					  &priv->fwspec[i]);
+	}
+
+	return 0;
+}
+
+static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
+{
+	struct irq_domain *irq_domain, *parent_domain;
+	struct platform_device *pdev;
+	struct reset_control *resetn;
+	struct rzg2l_irqc_priv *priv;
+	int ret;
+
+	pdev = of_find_device_by_node(node);
+	if (!pdev)
+		return -ENODEV;
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		dev_err(&pdev->dev, "cannot find parent domain\n");
+		return -ENODEV;
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	ret = rzg2l_irqc_parse_interrupts(priv, node);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
+		return ret;
+	}
+
+	resetn = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(resetn))
+		return IS_ERR(resetn);
+
+	ret = reset_control_deassert(resetn);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n", ret);
+		return ret;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed: %d\n", ret);
+		goto pm_disable;
+	}
+
+	raw_spin_lock_init(&priv->lock);
+
+	irq_domain = irq_domain_add_hierarchy(parent_domain, 0, IRQC_NUM_IRQ,
+					      node, &rzg2l_irqc_domain_ops,
+					      priv);
+	if (!irq_domain) {
+		dev_err(&pdev->dev, "failed to add irq domain\n");
+		ret = -ENOMEM;
+		goto pm_put;
+	}
+
+	return 0;
+
+pm_put:
+	pm_runtime_put(&pdev->dev);
+pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(resetn);
+	return ret;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
+IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
+IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
+MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


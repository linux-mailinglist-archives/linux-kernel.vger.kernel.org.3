Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76CB4C83EC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiCAGZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiCAGZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:25:16 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD89F6FA0B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:24:31 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t14so10682905pgr.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mwTwmzuX0saKyxNlvchue0KLgxgf6JKD5r8htXPV4x4=;
        b=YFXMQ4K+tzknxwt8VM77SCs5nP0q79KdL2VTYuk3woQwxvjLTsPpiYfePfDzAFrZAf
         Xr3cpETvWWNmn1zf0O+vQ6Y50nD8Pu36HNuQTvhoN/CXFQzdMcOuTpmO7gmweTN5peps
         i5lZzXbpxjcJCm6S0/Y46qftAd8Yt+DS8K/hWk1XdBgHGHvvBROYh2+gLVMwFbQjm9Vx
         lXzBqSiP+EEHi8hz90JLSk4/RzANLe7+B9TMhWCSWj7KfB+RTjFprs807lzZkrepHSDq
         O6yDvXV5SHh1RClAjiRr5yXj3sCLVax0wMIHY26KgUAiQpcam9ji4BOQR0Q6DZIVJ2qY
         5aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mwTwmzuX0saKyxNlvchue0KLgxgf6JKD5r8htXPV4x4=;
        b=o4zffa5BTYFZ+ULWW+njZqaiaL/ylqv7AxcdwNfmMxkphSNiqfHm7bf5cRlovJMPjn
         exskMpF6sY37laNFMxkbkomHaIdlwvdQEr9pkLffJw8OKq9QwCyVXC6PxNeQQVbddILA
         MRdihIkljB43jfJ47E/bUCmDaYUV3ffYgfH4xLgClEbb+zGO8fix3YGgjRH9qdRYKaZ+
         VLOSZ99/3ku6Ekx6FiTLzXySp1VZ+3jdTbvPrsWKwiyEjEg3YTMOTiDQW1/ESaqeVisN
         xvr3o7PZyvR4k/NuX4z6R3jmj8FTGtynZiO/CExVUis9Xj1iGkzpgL1bgBD+Ji7CJIn2
         FqmA==
X-Gm-Message-State: AOAM532RYesq3lYFhhZlRQ76UQw/hl0L3yLGCt+8hyffdQR/vLjtKhlE
        sKXMgMOjMWPiaovXdS4JZ2pEIg==
X-Google-Smtp-Source: ABdhPJzERd6h2f5ozXlUx/49OJyASL0EuWwpKA/ZNOiPzrjjRjjUIVtN7al2utfY9RN1fzB0d+KWMA==
X-Received: by 2002:a63:c24:0:b0:375:9840:6a97 with SMTP id b36-20020a630c24000000b0037598406a97mr19045672pgl.77.1646115871117;
        Mon, 28 Feb 2022 22:24:31 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id q22-20020a056a00085600b004f397d1f3b5sm16461364pfk.171.2022.02.28.22.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 22:24:30 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v7 2/2] irqchip: Add Qualcomm MPM controller driver
Date:   Tue,  1 Mar 2022 14:24:14 +0800
Message-Id: <20220301062414.2987591-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301062414.2987591-1-shawn.guo@linaro.org>
References: <20220301062414.2987591-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm SoCs based on the RPM architecture have a MSM Power Manager (MPM)
in always-on domain. In addition to managing resources during sleep, the
hardware also has an interrupt controller that monitors the interrupts
when the system is asleep, wakes up the APSS when one of these interrupts
occur and replays it to GIC after it becomes operational.

It adds an irqchip driver for this interrupt controller, and here are
some notes about it.

- For given SoC, a fixed number of MPM pins are supported, e.g. 96 pins
  on QCM2290.  Each of these MPM pins can be either a MPM_GIC pin or
  a MPM_GPIO pin. The mapping between MPM_GIC pin and GIC interrupt
  is defined by SoC, as well as the mapping between MPM_GPIO pin and
  GPIO number.  The former mapping is retrieved from device tree, while
  the latter is defined in TLMM pinctrl driver.

- qcom_mpm_enter_sleep() is called from power domain (PD) .power_off
  hook to notify RPM that APSS is about to power collapse.  This
  requires MPM PD be the parent PD of CPU cluster.

- When SoC gets awake from sleep mode, the driver will receive an
  interrupt from RPM, so that it can replay interrupt for particular
  polarity.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/irqchip/Kconfig        |   8 +
 drivers/irqchip/Makefile       |   1 +
 drivers/irqchip/irq-qcom-mpm.c | 448 +++++++++++++++++++++++++++++++++
 3 files changed, 457 insertions(+)
 create mode 100644 drivers/irqchip/irq-qcom-mpm.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7038957f4a77..680d2fcf2686 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -430,6 +430,14 @@ config QCOM_PDC
 	  Power Domain Controller driver to manage and configure wakeup
 	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
 
+config QCOM_MPM
+	tristate "QCOM MPM"
+	depends on ARCH_QCOM
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  MSM Power Manager driver to manage and configure wakeup
+	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
+
 config CSKY_MPINTC
 	bool
 	depends on CSKY
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c1f611cbfbf8..1f8990f812f1 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
 obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
 obj-$(CONFIG_NDS32)			+= irq-ativic32.o
 obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
+obj-$(CONFIG_QCOM_MPM)			+= irq-qcom-mpm.o
 obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
new file mode 100644
index 000000000000..f4409c169a3a
--- /dev/null
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, Linaro Limited
+ * Copyright (c) 2010-2020, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic-v3.h>
+#include <linux/irqdomain.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/irq.h>
+#include <linux/spinlock.h>
+
+/*
+ * This is the driver for Qualcomm MPM (MSM Power Manager) interrupt controller,
+ * which is commonly found on Qualcomm SoCs built on the RPM architecture.
+ * Sitting in always-on domain, MPM monitors the wakeup interrupts when SoC is
+ * asleep, and wakes up the AP when one of those interrupts occurs.  This driver
+ * doesn't directly access physical MPM registers though.  Instead, the access
+ * is bridged via a piece of internal memory (SRAM) that is accessible to both
+ * AP and RPM.  This piece of memory is called 'vMPM' in the driver.
+ *
+ * When SoC is awake, the vMPM is owned by AP and the register setup by this
+ * driver all happens on vMPM.  When AP is about to get power collapsed, the
+ * driver sends a mailbox notification to RPM, which will take over the vMPM
+ * ownership and dump vMPM into physical MPM registers.  On wakeup, AP is woken
+ * up by a MPM pin/interrupt, and RPM will copy STATUS registers into vMPM.
+ * Then AP start owning vMPM again.
+ *
+ * vMPM register map:
+ *
+ *    31                              0
+ *    +--------------------------------+
+ *    |            TIMER0              | 0x00
+ *    +--------------------------------+
+ *    |            TIMER1              | 0x04
+ *    +--------------------------------+
+ *    |            ENABLE0             | 0x08
+ *    +--------------------------------+
+ *    |              ...               | ...
+ *    +--------------------------------+
+ *    |            ENABLEn             |
+ *    +--------------------------------+
+ *    |          FALLING_EDGE0         |
+ *    +--------------------------------+
+ *    |              ...               |
+ *    +--------------------------------+
+ *    |            STATUSn             |
+ *    +--------------------------------+
+ *
+ *    n = DIV_ROUND_UP(pin_cnt, 32)
+ *
+ */
+
+#define MPM_REG_ENABLE		0
+#define MPM_REG_FALLING_EDGE	1
+#define MPM_REG_RISING_EDGE	2
+#define MPM_REG_POLARITY	3
+#define MPM_REG_STATUS		4
+
+/* MPM pin map to GIC hwirq */
+struct mpm_gic_map {
+	int pin;
+	irq_hw_number_t hwirq;
+};
+
+struct qcom_mpm_priv {
+	void __iomem *base;
+	raw_spinlock_t lock;
+	struct mbox_client mbox_client;
+	struct mbox_chan *mbox_chan;
+	struct mpm_gic_map *maps;
+	unsigned int map_cnt;
+	unsigned int reg_stride;
+	struct irq_domain *domain;
+	struct generic_pm_domain genpd;
+};
+
+static u32 qcom_mpm_read(struct qcom_mpm_priv *priv, unsigned int reg,
+			 unsigned int index)
+{
+	unsigned int offset = (reg * priv->reg_stride + index + 2) * 4;
+
+	return readl_relaxed(priv->base + offset);
+}
+
+static void qcom_mpm_write(struct qcom_mpm_priv *priv, unsigned int reg,
+			   unsigned int index, u32 val)
+{
+	unsigned int offset = (reg * priv->reg_stride + index + 2) * 4;
+
+	writel_relaxed(val, priv->base + offset);
+
+	/* Ensure the write is completed */
+	wmb();
+}
+
+static void qcom_mpm_enable_irq(struct irq_data *d, bool en)
+{
+	struct qcom_mpm_priv *priv = d->chip_data;
+	int pin = d->hwirq;
+	unsigned int index = pin / 32;
+	unsigned int shift = pin % 32;
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&priv->lock, flags);
+
+	val = qcom_mpm_read(priv, MPM_REG_ENABLE, index);
+	if (en)
+		val |= BIT(shift);
+	else
+		val &= ~BIT(shift);
+	qcom_mpm_write(priv, MPM_REG_ENABLE, index, val);
+
+	raw_spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static void qcom_mpm_mask(struct irq_data *d)
+{
+	qcom_mpm_enable_irq(d, false);
+
+	if (d->parent_data)
+		irq_chip_mask_parent(d);
+}
+
+static void qcom_mpm_unmask(struct irq_data *d)
+{
+	qcom_mpm_enable_irq(d, true);
+
+	if (d->parent_data)
+		irq_chip_unmask_parent(d);
+}
+
+static void mpm_set_type(struct qcom_mpm_priv *priv, bool set, unsigned int reg,
+			 unsigned int index, unsigned int shift)
+{
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&priv->lock, flags);
+
+	val = qcom_mpm_read(priv, reg, index);
+	if (set)
+		val |= BIT(shift);
+	else
+		val &= ~BIT(shift);
+	qcom_mpm_write(priv, reg, index, val);
+
+	raw_spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static int qcom_mpm_set_type(struct irq_data *d, unsigned int type)
+{
+	struct qcom_mpm_priv *priv = d->chip_data;
+	int pin = d->hwirq;
+	unsigned int index = pin / 32;
+	unsigned int shift = pin % 32;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_RISING:
+		mpm_set_type(priv, !!(type & IRQ_TYPE_EDGE_RISING),
+			     MPM_REG_RISING_EDGE, index, shift);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		mpm_set_type(priv, !!(type & IRQ_TYPE_EDGE_FALLING),
+			     MPM_REG_FALLING_EDGE, index, shift);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		mpm_set_type(priv, !!(type & IRQ_TYPE_LEVEL_HIGH),
+			     MPM_REG_POLARITY, index, shift);
+		break;
+	}
+
+	if (!d->parent_data)
+		return 0;
+
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		type = IRQ_TYPE_EDGE_RISING;
+
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		type = IRQ_TYPE_LEVEL_HIGH;
+
+	return irq_chip_set_type_parent(d, type);
+}
+
+static struct irq_chip qcom_mpm_chip = {
+	.name			= "mpm",
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_mask		= qcom_mpm_mask,
+	.irq_unmask		= qcom_mpm_unmask,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= qcom_mpm_set_type,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SKIP_SET_WAKE,
+};
+
+static struct mpm_gic_map *get_mpm_gic_map(struct qcom_mpm_priv *priv, int pin)
+{
+	struct mpm_gic_map *maps = priv->maps;
+	int i;
+
+	for (i = 0; i < priv->map_cnt; i++) {
+		if (maps[i].pin == pin)
+			return &maps[i];
+	}
+
+	return NULL;
+}
+
+static int qcom_mpm_alloc(struct irq_domain *domain, unsigned int virq,
+			  unsigned int nr_irqs, void *data)
+{
+	struct qcom_mpm_priv *priv = domain->host_data;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	struct mpm_gic_map *map;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int  ret;
+
+	ret = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+					    &qcom_mpm_chip, priv);
+	if (ret)
+		return ret;
+
+	map = get_mpm_gic_map(priv, hwirq);
+	if (map == NULL)
+		return irq_domain_disconnect_hierarchy(domain->parent, virq);
+
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		type = IRQ_TYPE_EDGE_RISING;
+
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		type = IRQ_TYPE_LEVEL_HIGH;
+
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param_count = 3;
+	parent_fwspec.param[0] = 0;
+	parent_fwspec.param[1] = map->hwirq;
+	parent_fwspec.param[2] = type;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
+}
+
+static const struct irq_domain_ops qcom_mpm_ops = {
+	.alloc		= qcom_mpm_alloc,
+	.free		= irq_domain_free_irqs_common,
+	.translate	= irq_domain_translate_twocell,
+};
+
+/* Triggered by RPM when system resumes from deep sleep */
+static irqreturn_t qcom_mpm_handler(int irq, void *dev_id)
+{
+	struct qcom_mpm_priv *priv = dev_id;
+	unsigned long enable, pending;
+	irqreturn_t ret = IRQ_NONE;
+	unsigned long flags;
+	int i, j;
+
+	for (i = 0; i < priv->reg_stride; i++) {
+		raw_spin_lock_irqsave(&priv->lock, flags);
+		enable = qcom_mpm_read(priv, MPM_REG_ENABLE, i);
+		pending = qcom_mpm_read(priv, MPM_REG_STATUS, i);
+		pending &= enable;
+		raw_spin_unlock_irqrestore(&priv->lock, flags);
+
+		for_each_set_bit(j, &pending, 32) {
+			unsigned int pin = 32 * i + j;
+			struct irq_desc *desc = irq_resolve_mapping(priv->domain, pin);
+			struct irq_data *d = &desc->irq_data;
+
+			if (!irqd_is_level_type(d))
+				irq_set_irqchip_state(d->irq,
+						IRQCHIP_STATE_PENDING, true);
+			ret = IRQ_HANDLED;
+		}
+	}
+
+	return ret;
+}
+
+static int qcom_mpm_enter_sleep(struct qcom_mpm_priv *priv)
+{
+	int i, ret;
+
+	for (i = 0; i < priv->reg_stride; i++)
+		qcom_mpm_write(priv, MPM_REG_STATUS, i, 0);
+
+	/* Notify RPM to write vMPM into HW */
+	ret = mbox_send_message(priv->mbox_chan, NULL);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int mpm_pd_power_off(struct generic_pm_domain *genpd)
+{
+	struct qcom_mpm_priv *priv = container_of(genpd, struct qcom_mpm_priv,
+						  genpd);
+
+	return qcom_mpm_enter_sleep(priv);
+}
+
+static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
+{
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
+	struct irq_domain *parent_domain;
+	struct generic_pm_domain *genpd;
+	struct qcom_mpm_priv *priv;
+	unsigned int pin_cnt;
+	int i, irq;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(np, "qcom,mpm-pin-count", &pin_cnt);
+	if (ret) {
+		dev_err(dev, "failed to read qcom,mpm-pin-count: %d\n", ret);
+		return ret;
+	}
+
+	priv->reg_stride = DIV_ROUND_UP(pin_cnt, 32);
+
+	ret = of_property_count_u32_elems(np, "qcom,mpm-pin-map");
+	if (ret < 0) {
+		dev_err(dev, "failed to read qcom,mpm-pin-map: %d\n", ret);
+		return ret;
+	}
+
+	if (ret % 2) {
+		dev_err(dev, "invalid qcom,mpm-pin-map\n");
+		return -EINVAL;
+	}
+
+	priv->map_cnt = ret / 2;
+	priv->maps = devm_kcalloc(dev, priv->map_cnt, sizeof(*priv->maps),
+				  GFP_KERNEL);
+	if (!priv->maps)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->map_cnt; i++) {
+		of_property_read_u32_index(np, "qcom,mpm-pin-map", i * 2,
+					   &priv->maps[i].pin);
+		of_property_read_u32_index(np, "qcom,mpm-pin-map", i * 2 + 1,
+					   (u32 *) &priv->maps[i].hwirq);
+	}
+
+	raw_spin_lock_init(&priv->lock);
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (!priv->base)
+		return PTR_ERR(priv->base);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	genpd = &priv->genpd;
+	genpd->flags = GENPD_FLAG_IRQ_SAFE;
+	genpd->power_off = mpm_pd_power_off;
+
+	genpd->name = devm_kasprintf(dev, GFP_KERNEL, "%s", dev_name(dev));
+	if (!genpd->name)
+		return -ENOMEM;
+
+	ret = pm_genpd_init(genpd, NULL, false);
+	if (ret) {
+		dev_err(dev, "failed to init genpd: %d\n", ret);
+		return ret;
+	}
+
+	ret = of_genpd_add_provider_simple(np, genpd);
+	if (ret) {
+		dev_err(dev, "failed to add genpd provider: %d\n", ret);
+		goto remove_genpd;
+	}
+
+	priv->mbox_client.dev = dev;
+	priv->mbox_chan = mbox_request_channel(&priv->mbox_client, 0);
+	if (IS_ERR(priv->mbox_chan)) {
+		ret = PTR_ERR(priv->mbox_chan);
+		dev_err(dev, "failed to acquire IPC channel: %d\n", ret);
+		return ret;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		dev_err(dev, "failed to find MPM parent domain\n");
+		ret = -ENXIO;
+		goto free_mbox;
+	}
+
+	priv->domain = irq_domain_create_hierarchy(parent_domain,
+				IRQ_DOMAIN_FLAG_QCOM_MPM_WAKEUP, pin_cnt,
+				of_node_to_fwnode(np), &qcom_mpm_ops, priv);
+	if (!priv->domain) {
+		dev_err(dev, "failed to create MPM domain\n");
+		ret = -ENOMEM;
+		goto free_mbox;
+	}
+
+	irq_domain_update_bus_token(priv->domain, DOMAIN_BUS_WAKEUP);
+
+	ret = devm_request_irq(dev, irq, qcom_mpm_handler, IRQF_NO_SUSPEND,
+			       "qcom_mpm", priv);
+	if (ret) {
+		dev_err(dev, "failed to request irq: %d\n", ret);
+		goto remove_domain;
+	}
+
+	return 0;
+
+remove_domain:
+	irq_domain_remove(priv->domain);
+free_mbox:
+	mbox_free_channel(priv->mbox_chan);
+remove_genpd:
+	pm_genpd_remove(genpd);
+	return ret;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(qcom_mpm)
+IRQCHIP_MATCH("qcom,mpm", qcom_mpm_init)
+IRQCHIP_PLATFORM_DRIVER_END(qcom_mpm)
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. MSM Power Manager");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1


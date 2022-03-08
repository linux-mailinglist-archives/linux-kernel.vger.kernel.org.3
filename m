Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966434D1191
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244851AbiCHIHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344756AbiCHIHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:07:01 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6FF3EAA4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:06:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 9so16359920pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OM+KJBsH9Nk9/dP7AdpY3xriXov/Uf2R66yHm1Z0a18=;
        b=G0ah3v0m2DwYcnRWo25ULH2EoPS0SAc2/vkZ4NTwJJowjoay/zRH7C7UoYn7rDQAxH
         qIpxu7p9gowrIR9qzx7j1JOyEUzfMedJHqL4AJJaSTrgHsSC9RubslRd2QUfm6ugaJvW
         Nnh+1hkx9x90q2j4tgkkFlYVCnW/S/Y7ExqlOpznRlNDHxjI+TwS1Zaf1f/S2DtFZYXx
         ZDaA4EhPnNq0gY/Y6/+19qoxcQXxuQpv/cWJv9I1NwPSCIo3fRruOi/xF97I1fKhFrqM
         m1Hhywje61dgEG3Inm4qp99NuMdzae3Hde/sdG40M+bT0FPSTXwtDU8wsuXJPZbhepfu
         WG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OM+KJBsH9Nk9/dP7AdpY3xriXov/Uf2R66yHm1Z0a18=;
        b=xAfzSTAAgWrAnGkdRjPiFs41cQ18LWisEw9a5V11WsHiftFQJsDwXuzXtNAIwqu69x
         uTxGlyBgsa8sZ0ZeQ2zWetWezHifOIoG+Bfm873zndG9O9ER8QQsGn7UKpB2D38BSlmZ
         lbUEloZ8oVZ5ARZtGPPxOMlRa3nVN6yvzK8/3EkKgg8J7Or4rH0ANeQC9a+BZUUEmPlu
         OtCe/rRl/8sT1MBoqmvC5AfPsMnBhMw+VG1szRfJXlbtbgOYRLvO7cGUDAp+n7fjwOsJ
         rG3AnI6l9acgPiklTw7xZ3wX97fC9o9C6KLUFniJA2TdO9nGAmz12WnZNeXpa3pZJdpA
         ABrQ==
X-Gm-Message-State: AOAM533lZVjWZieTGxq5ezY+BGjg3c/B1gvGGsSaPPauzgbO63lMaSGo
        o1rpemoUa7OavyMXgKtdFAziRA==
X-Google-Smtp-Source: ABdhPJwSjYl+1ktEIH+hfPnLGLHdKLQIzUTfEym0kgwQ5LxvFfbsJ9C+SfZz4MFKLis2524j6EaViA==
X-Received: by 2002:a17:902:7b8d:b0:14b:8884:b4ad with SMTP id w13-20020a1709027b8d00b0014b8884b4admr16411438pll.120.1646726760119;
        Tue, 08 Mar 2022 00:06:00 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id om17-20020a17090b3a9100b001bf0fffee9bsm1944212pjb.52.2022.03.08.00.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:05:59 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v8 2/2] irqchip: Add Qualcomm MPM controller driver
Date:   Tue,  8 Mar 2022 16:05:34 +0800
Message-Id: <20220308080534.3384532-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308080534.3384532-1-shawn.guo@linaro.org>
References: <20220308080534.3384532-1-shawn.guo@linaro.org>
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

- The power domain (PD) .power_off hook is used to notify RPM that APSS
  is about to power collapse.  This requires MPM PD be the parent PD of
  CPU cluster.

- When SoC gets awake from sleep mode, the driver will receive an
  interrupt from RPM, so that it can replay interrupt for particular
  polarity.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/irqchip/Kconfig        |   8 +
 drivers/irqchip/Makefile       |   1 +
 drivers/irqchip/irq-qcom-mpm.c | 461 +++++++++++++++++++++++++++++++++
 3 files changed, 470 insertions(+)
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
index 000000000000..eea5a753618c
--- /dev/null
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -0,0 +1,461 @@
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
+	unsigned long flags, val;
+
+	raw_spin_lock_irqsave(&priv->lock, flags);
+
+	val = qcom_mpm_read(priv, MPM_REG_ENABLE, index);
+	__assign_bit(shift, &val, en);
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
+	unsigned long flags, val;
+
+	raw_spin_lock_irqsave(&priv->lock, flags);
+
+	val = qcom_mpm_read(priv, reg, index);
+	__assign_bit(shift, &val, set);
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
+	if (type & IRQ_TYPE_EDGE_RISING)
+		mpm_set_type(priv, true, MPM_REG_RISING_EDGE, index, shift);
+	else
+		mpm_set_type(priv, false, MPM_REG_RISING_EDGE, index, shift);
+
+	if (type & IRQ_TYPE_EDGE_FALLING)
+		mpm_set_type(priv, true, MPM_REG_FALLING_EDGE, index, shift);
+	else
+		mpm_set_type(priv, false, MPM_REG_FALLING_EDGE, index, shift);
+
+	if (type & IRQ_TYPE_LEVEL_HIGH)
+		mpm_set_type(priv, true, MPM_REG_POLARITY, index, shift);
+	else
+		mpm_set_type(priv, false, MPM_REG_POLARITY, index, shift);
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
+	irq_hw_number_t pin;
+	unsigned int type;
+	int  ret;
+
+	ret = irq_domain_translate_twocell(domain, fwspec, &pin, &type);
+	if (ret)
+		return ret;
+
+	ret = irq_domain_set_hwirq_and_chip(domain, virq, pin,
+					    &qcom_mpm_chip, priv);
+	if (ret)
+		return ret;
+
+	map = get_mpm_gic_map(priv, pin);
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
+static int mpm_pd_power_off(struct generic_pm_domain *genpd)
+{
+	struct qcom_mpm_priv *priv = container_of(genpd, struct qcom_mpm_priv,
+						  genpd);
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
+static bool gic_hwirq_is_mapped(struct mpm_gic_map *maps, int cnt, u32 hwirq)
+{
+	int i;
+
+	for (i = 0; i < cnt; i++)
+		if (maps[i].hwirq == hwirq)
+			return true;
+
+	return false;
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
+		u32 pin, hwirq;
+
+		of_property_read_u32_index(np, "qcom,mpm-pin-map", i * 2, &pin);
+		of_property_read_u32_index(np, "qcom,mpm-pin-map", i * 2 + 1, &hwirq);
+
+		if (gic_hwirq_is_mapped(priv->maps, i, hwirq)) {
+			dev_warn(dev, "failed to map pin %d as GIC hwirq %d is already mapped\n",
+				 pin, hwirq);
+			continue;
+		}
+
+		priv->maps[i].pin = pin;
+		priv->maps[i].hwirq = hwirq;
+	}
+
+	raw_spin_lock_init(&priv->lock);
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (!priv->base)
+		return PTR_ERR(priv->base);
+
+	for (i = 0; i < priv->reg_stride; i++) {
+		qcom_mpm_write(priv, MPM_REG_ENABLE, i, 0);
+		qcom_mpm_write(priv, MPM_REG_FALLING_EDGE, i, 0);
+		qcom_mpm_write(priv, MPM_REG_RISING_EDGE, i, 0);
+		qcom_mpm_write(priv, MPM_REG_POLARITY, i, 0);
+		qcom_mpm_write(priv, MPM_REG_STATUS, i, 0);
+	}
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


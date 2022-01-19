Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A2149419D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244703AbiASURx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243988AbiASURw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:17:52 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC58BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:17:51 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x7so12790492lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqt6LQ66TrGZQm4F5wFtHEjp2CT6lZEJotuIEXo7Xmk=;
        b=NheSLU6qVvnKiZhL2diaJtdKiGjgEvRcfYDDK/lGz/pxeD+i8YarEdNRIfr1OuPipL
         J10dcymZIWpmVebbkGlG1zo4wQm83huyFMgH5gba6bnJR1pWFfZmgSUxGlEbkh8SEpuw
         2qYfz8MBON/6dlo/EiF+CuBhVwh9CQwFzcQ1NdICle1WpqYj5DnJWGOnsXvqrOIfC5ae
         eYDP7cDqX70MXyrQAUQvQBoWwWOhIV6AGGOvck1m+zF3S1bx88DG+f16y4OBkhC9nbum
         V0EdMNLXhEM4V66nDCEJiDbUEMwcysAuyESdTxXoGnRqV4Yarjh+BWlaiQJzJ3oFmk3E
         nppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqt6LQ66TrGZQm4F5wFtHEjp2CT6lZEJotuIEXo7Xmk=;
        b=Gbe2IrqfFkML5PS0Hai2ASyGRLU05I+xrxVDHPKmd7KIiYmJOughvmvCp613K0prlO
         xxRYL1O4MyLXx1gsHGAnyicFallBGkc/4o8CkxYk5BMSL6RoGO10zpfV1XiZbdPzCpnL
         04/FU0Wr+grmbk7vc5XpJy0/zjKX9j13ZWjFXNOOyeyyhIquWAJ5DgiguSF8chyMW97D
         N5ls1gFpiN3BhsddzMzayBsXwnT9WcF8uTaCpxYBuGm0tgLfoAZ+2UYcUhmMpm/OC2QL
         wmCENb8qfcJNUbC924/xhAeZ4Qq5+75aI5tjM9RgPeKeUm8juM2rHPzkpLjtVyOMBNWm
         NfuA==
X-Gm-Message-State: AOAM531W8TXDebHlKIZ88+Kuz9Pi/W2ucTfP/NnVJSDKJqzUSlsVm4Vq
        +8zg9fqQyLkwlZ9pwLVVaSEFt9/qyf095Vuw
X-Google-Smtp-Source: ABdhPJy1wCzoh6WS5dwttSVaFgGofR3+EC/tSkzTbTB/fA+CQeUBQ3NlNDrjBKzmnRL8wtFKleHdnQ==
X-Received: by 2002:a2e:99d8:: with SMTP id l24mr26333588ljj.211.1642623469973;
        Wed, 19 Jan 2022 12:17:49 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id f19sm78226lfh.63.2022.01.19.12.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 12:17:49 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] drivers: irqchip: add irq-type-changer
Date:   Wed, 19 Jan 2022 23:17:41 +0300
Message-Id: <20220119201741.717770-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Irq type changer is a virtual irqchip useful to support boards that
change (e.g. invert) interrupt signal between producer and consumer.

Usage example, for Kingfisher extension board for Renesas Gen-3 Soc,
that has WiFi interrupt delivered over inverting level-shifter:

/ {
	gpio1_25_inverted: inverter {
		compatible = "linux,irq-type-changer";
		interrupt-controller;
		#interrupt-cells = <2>;
		interrupt-parent = <&gpio1>;
		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
	};
};

&wlcore {
        interrupt-parent = <&gpio1_25_inverted>;
	interrupts = <0 IRQ_TYPE_EDGE_RISING>;
};

Then, wlcore driver observes IRQ_TYPE_EDGE_RISING trigger type and
configures interrupt output as such. At the same time, gpio-rcar driver
gets interrupt configured for IRQ_TYPE_EDGE_FALLING.

This version uses hierarchical irq_domain API, and works only with
parent interrupt domains compatible with that API.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
My previous attempt to solve the issue:
  https://lore.kernel.org/lkml/20211228165642.2514766-1-nikita.yoush@cogentembedded.com/

Additional patches required for this to work with gpio-rcar:
  https://lore.kernel.org/lkml/20220119160715.650535-1-nikita.yoush@cogentembedded.com/
  https://lore.kernel.org/lkml/20220119143211.633399-1-nikita.yoush@cogentembedded.com/

 drivers/irqchip/Kconfig            |  18 ++++
 drivers/irqchip/Makefile           |   1 +
 drivers/irqchip/irq-type-changer.c | 162 +++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+)
 create mode 100644 drivers/irqchip/irq-type-changer.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7038957f4a77..7f348016e82c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -617,4 +617,22 @@ config MCHP_EIC
 	help
 	  Support for Microchip External Interrupt Controller.
 
+config IRQ_TYPE_CHANGER
+	bool "Interrupt trigger type changer"
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Interrupt trigger type changer is designed to support boards that
+	  modify (e.g. invert) signal between interrupt source and interrupt
+	  controller input. So trigger type configured by a driver for some
+	  interrupt output pin does not match trigger type that shall be used
+	  to configure interrupt controller's input where that pin is connected.
+
+	  In this case, board device tree shall add an interrupt trigger
+	  type changer node and use it as the interrupt parent for the node
+	  representing interrupt source. Then, interrupt trigger type defined
+	  in the interrupt source node will be visible for the interrupt source
+	  driver, and (different) trigger type defined inside the changer node
+	  will be used to configure the interrupt controller.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c1f611cbfbf8..57a664837857 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -117,3 +117,4 @@ obj-$(CONFIG_WPCM450_AIC)		+= irq-wpcm450-aic.o
 obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
 obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
 obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
+obj-$(CONFIG_IRQ_TYPE_CHANGER)		+= irq-type-changer.o
diff --git a/drivers/irqchip/irq-type-changer.c b/drivers/irqchip/irq-type-changer.c
new file mode 100644
index 000000000000..731ea61e7fcc
--- /dev/null
+++ b/drivers/irqchip/irq-type-changer.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
+
+struct changer {
+	unsigned long count;
+	struct {
+		struct irq_fwspec fwspec;
+		unsigned int type;
+	} out[0];
+};
+
+static int changer_set_type(struct irq_data *data, unsigned int type)
+{
+	struct changer *ch = data->domain->host_data;
+	struct irq_data *parent_data = data->parent_data;
+
+	return parent_data->chip->irq_set_type(parent_data,
+					       ch->out[data->hwirq].type);
+}
+
+static struct irq_chip changer_chip = {
+	.name			= "type-changer",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_type		= changer_set_type,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_wake		= irq_chip_set_wake_parent,
+};
+
+static int changer_domain_translate(struct irq_domain *domain,
+				    struct irq_fwspec *fwspec,
+				    unsigned long *hwirq,
+				    unsigned int *type)
+{
+	struct changer *ch = domain->host_data;
+
+	if (fwspec->param_count != 2)
+		return -EINVAL;
+	if (fwspec->param[0] >= ch->count)
+		return -ENXIO;
+
+	*hwirq = fwspec->param[0];
+	*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+	return 0;
+}
+
+static int changer_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	struct changer *ch = domain->host_data;
+	struct irq_fwspec *fwspec = arg;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	if (WARN_ON(nr_irqs != 1))
+		return -EINVAL;
+
+	ret = changer_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &changer_chip, ch);
+
+	return irq_domain_alloc_irqs_parent(domain, virq, 1,
+					    &ch->out[hwirq].fwspec);
+}
+
+static const struct irq_domain_ops changer_domain_ops = {
+	.translate	= changer_domain_translate,
+	.alloc		= changer_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+static int __init changer_of_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	struct irq_domain *domain, *parent_domain;
+	int count, i, ret;
+	struct changer *ch;
+	struct of_phandle_args pargs;
+	irq_hw_number_t unused;
+
+	if (!parent) {
+		pr_err("%pOF: no parent node\n", node);
+		return -EINVAL;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%pOF: no parent domain\n", node);
+		return -EINVAL;
+	}
+
+	if (WARN_ON(!parent_domain->ops->translate))
+		return -EINVAL;
+
+	count = of_irq_count(node);
+	if (count < 1) {
+		pr_err("%pOF: no interrupts defined\n", node);
+		return -EINVAL;
+	}
+
+	ch = kzalloc(GFP_KERNEL, sizeof(*ch) + count * sizeof(ch->out[0]));
+	if (!ch)
+		return -ENOMEM;
+	ch->count = count;
+
+	for (i = 0; i < count; i++) {
+		ret = of_irq_parse_one(node, i, &pargs);
+		if (ret) {
+			pr_err("%pOF: interrupt %d: error %d parsing\n",
+			       node, i, ret);
+			goto out_free;
+		}
+		of_phandle_args_to_fwspec(pargs.np, pargs.args,
+					  pargs.args_count,
+					  &ch->out[i].fwspec);
+		ret = parent_domain->ops->translate(parent_domain,
+						    &ch->out[i].fwspec,
+						    &unused,
+						    &ch->out[i].type);
+		if (ret) {
+			pr_err("%pOF: interrupt %d: error %d extracting type\n",
+			       node, i, ret);
+			goto out_free;
+		}
+		if (ch->out[i].type == IRQ_TYPE_NONE) {
+			pr_err("%pOF: interrupt %d: no type\n", node, i);
+			ret = -ENXIO;
+			goto out_free;
+		}
+	}
+
+	domain = irq_domain_create_hierarchy(parent_domain, 0, count,
+					     of_node_to_fwnode(node),
+					     &changer_domain_ops, ch);
+	if (!domain) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	return 0;
+
+out_free:
+	kfree(ch);
+	return ret;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(changer)
+IRQCHIP_MATCH("linux,irq-type-changer", changer_of_init)
+IRQCHIP_PLATFORM_DRIVER_END(changer)
+MODULE_AUTHOR("Nikita Yushchenko <nikita.yoush.cogentembedded.com>");
+MODULE_DESCRIPTION("Virtual irqchip to support trigger type change in route");
+MODULE_LICENSE("GPL v2");
-- 
2.30.2


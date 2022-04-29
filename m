Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0668851512A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379337AbiD2Q4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242283AbiD2Q4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:56:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BC9DA6C4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:53:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e24so11524937wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y88LxLAo1nli95Xm48q+VVmonwLpJPWWjtF+CYOqhhg=;
        b=kS0rLjIyQx4LL9BzaS8ekgzOXMz5x7UtOlmNj8ZPfhfk6Vac1b5tVtEPfTOw0NGIXU
         fCCCfb/tKTQUy3u1/0En3ZMcASkSEF8O3X/lcqEYhqBouaDdu3bE94L/w92RCp46nRpm
         1mie0gAthvPqIUPCYOWv+NQ5vYgmGAu5cRTWxUvtq8bPlM8MIoxR/NDHE54stJgXBCS/
         i6pCixktzJtRZOXajWExqFNgHpYrEQrkf5jnEItlbqoeLB590JZWBtlRmmHeMd/RpuCI
         QKlyIncNJsN+x82rDKsJY4juduOHt/PWHClkpFN5DXUczOKM34JHTqf82+9GDXFY5anL
         NJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y88LxLAo1nli95Xm48q+VVmonwLpJPWWjtF+CYOqhhg=;
        b=agfZRmM5Pu1ZkgFtNsmCQm27DLUp/Ec2dvbpJxJbHZuGBjw2/lbzeoU9Vur68CtEnx
         JyGQcKN8CeWZ2W/Gbz819mG1dakVUz0p6C8lk0hqz/IXnqOynbPdBFK3zeODcwXUUIiX
         IUxjqPOub7VRY0VGn9FDj/gDoSPZ3rKnA/2X/gW2d4WujoTgXIDkUkv9CbYchIEHIZpL
         ewDIb2yzQeF7LCJq0W9jq0zkONyZ4mQ7m3lu3hS9CCNhSapFKDe2FWK7/ecuIDswRZtI
         urA/kwnwgfYdDnTaFY2ABGqLPXMRRitEPe81TkDzWAWEUoOJkrKsBPae2giPeHob8Onv
         aL6A==
X-Gm-Message-State: AOAM5306AeN4huFT2m+0s/s42IEtOSq4F4yeh67H68fu97GSvLLcb4Ba
        KWTchsjmuyiu7zKXKsTX7BmTfz2+/bO7k6zH
X-Google-Smtp-Source: ABdhPJzwer+SFr6WMGhlQdZX7bXuKXtmeQyttshlEfVpyCWfe1WLLeyjMlbv0DmRBMCU+MECobo61Q==
X-Received: by 2002:a05:6000:1810:b0:20a:d512:96b9 with SMTP id m16-20020a056000181000b0020ad51296b9mr5762wrh.611.1651251198660;
        Fri, 29 Apr 2022 09:53:18 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id l5-20020adfa385000000b0020adb3ae75dsm2913406wrb.3.2022.04.29.09.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:53:17 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] irqchip/exiu: Fix acknowledgment of edge triggered interrupts
Date:   Fri, 29 Apr 2022 17:53:14 +0100
Message-Id: <20220429165314.2343705-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the EXIU uses the fasteoi interrupt flow that is configured by
it's parent (irq-gic-v3.c). With this flow the only chance to clear the
interrupt request happens during .irq_eoi() and (obviously) this happens
after the interrupt handler has run. EXIU requires edge triggered
interrupts to be acked prior to interrupt handling. Without this we
risk incorrect interrupt dismissal when a new interrupt is delivered
after the handler reads and acknowledges the peripheral but before the
irq_eoi() takes place.

Fix this by clearing the interrupt request from .irq_ack() if we are
configured for edge triggered interrupts. This requires adopting the
fasteoi-ack flow instead of the fasteoi to ensure the ack gets called.

These changes have been tested using the power button on a
Developerbox/SC2A11 combined with some hackery in gpio-keys so I can
play with the different trigger mode (and an mdelay(500) so I can
can check what happens on a double click in both modes.

Fixes: 706cffc1b912 ("irqchip/exiu: Add support for Socionext Synquacer EXIU controller")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    Changes in v2:
    
     * Switch to dynamic selection of handle_fasteoi_irq and
       handle_fasteoi_ack_irq and reintroduce exiu_irq_eoi() since we need
       that for level triggered interrupts (Ard B).
     * Above changes mean we are no longer using sun6i NMI code as a
       template to tidy up the description accordingly.

 arch/arm64/Kconfig.platforms   |  1 +
 drivers/irqchip/irq-sni-exiu.c | 33 +++++++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 30b123cde02c..aaeaf57c8222 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -253,6 +253,7 @@ config ARCH_INTEL_SOCFPGA

 config ARCH_SYNQUACER
 	bool "Socionext SynQuacer SoC Family"
+	select IRQ_FASTEOI_HIERARCHY_HANDLERS

 config ARCH_TEGRA
 	bool "NVIDIA Tegra SoC Family"
diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
index abd011fcecf4..651a82dead01 100644
--- a/drivers/irqchip/irq-sni-exiu.c
+++ b/drivers/irqchip/irq-sni-exiu.c
@@ -37,11 +37,20 @@ struct exiu_irq_data {
 	u32		spi_base;
 };

-static void exiu_irq_eoi(struct irq_data *d)
+static void exiu_irq_ack(struct irq_data *d)
 {
 	struct exiu_irq_data *data = irq_data_get_irq_chip_data(d);

 	writel(BIT(d->hwirq), data->base + EIREQCLR);
+}
+
+static void exiu_irq_eoi(struct irq_data *d)
+{
+	struct exiu_irq_data *data = irq_data_get_irq_chip_data(d);
+	u32 edge_triggered = readl_relaxed(data->base + EIEDG);
+
+	if (!(edge_triggered & BIT(d->hwirq)))
+		writel(BIT(d->hwirq), data->base + EIREQCLR);
 	irq_chip_eoi_parent(d);
 }

@@ -91,10 +100,13 @@ static int exiu_irq_set_type(struct irq_data *d, unsigned int type)
 	writel_relaxed(val, data->base + EILVL);

 	val = readl_relaxed(data->base + EIEDG);
-	if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_LEVEL_HIGH)
+	if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_LEVEL_HIGH) {
 		val &= ~BIT(d->hwirq);
-	else
+		irq_set_handler_locked(d, handle_fasteoi_irq);
+	} else {
 		val |= BIT(d->hwirq);
+		irq_set_handler_locked(d, handle_fasteoi_ack_irq);
+	}
 	writel_relaxed(val, data->base + EIEDG);

 	writel_relaxed(BIT(d->hwirq), data->base + EIREQCLR);
@@ -104,6 +116,7 @@ static int exiu_irq_set_type(struct irq_data *d, unsigned int type)

 static struct irq_chip exiu_irq_chip = {
 	.name			= "EXIU",
+	.irq_ack		= exiu_irq_ack,
 	.irq_eoi		= exiu_irq_eoi,
 	.irq_enable		= exiu_irq_enable,
 	.irq_mask		= exiu_irq_mask,
@@ -148,6 +161,8 @@ static int exiu_domain_alloc(struct irq_domain *dom, unsigned int virq,
 	struct irq_fwspec parent_fwspec;
 	struct exiu_irq_data *info = dom->host_data;
 	irq_hw_number_t hwirq;
+	int i, ret;
+	u32 edge_triggered;

 	parent_fwspec = *fwspec;
 	if (is_of_node(dom->parent->fwnode)) {
@@ -165,7 +180,17 @@ static int exiu_domain_alloc(struct irq_domain *dom, unsigned int virq,
 	irq_domain_set_hwirq_and_chip(dom, virq, hwirq, &exiu_irq_chip, info);

 	parent_fwspec.fwnode = dom->parent->fwnode;
-	return irq_domain_alloc_irqs_parent(dom, virq, nr_irqs, &parent_fwspec);
+	ret = irq_domain_alloc_irqs_parent(dom, virq, nr_irqs, &parent_fwspec);
+	if (ret)
+		return ret;
+
+	edge_triggered = readl_relaxed(info->base + EIEDG);
+	for (i = 0; i < nr_irqs; i++)
+		irq_set_handler(virq + i, edge_triggered & BIT(i) ?
+						  handle_fasteoi_ack_irq :
+							handle_fasteoi_irq);
+
+	return 0;
 }

 static const struct irq_domain_ops exiu_domain_ops = {

base-commit: b2d229d4ddb17db541098b83524d901257e93845
--
2.35.1


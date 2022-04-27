Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C40511B70
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbiD0OaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237877AbiD0OaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:30:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCAA267E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:27:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e24so2739602wrc.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+0Y3UZzjydu4NpcC032FWbuvT2IKfw1ynn6+T4z3Rak=;
        b=qesdKqvWMKkZp7h2+S4c4+ljp+vpa/xbHm3SBYfsyUxCpJbTSegv0c4wohE1FJu1rf
         MMFullsbdRlbSd7QFs9xlc3+RMCl+i1eB+c/rPt63aTsoTmauEVYWwzJh6rlf85220AL
         vyxil+gyyaZDx+6O9xMhZE8aTtaXhATfFiFbShU61mtnm9/X0zPJbpF+DnWY8VsvLoTi
         IJH2nvZHF5HsZ5mfrjlfvLEDxAgIOnN1I7+1hKpLn1gbA5ahuq+L1oEIvoNMNmMLBair
         VHh8ihKK0D4H8y/FtQf8ALYxqxjygQwxlXq+PiJ2/8WAnf4ySbKN1JnrBaw3+OL7wEn3
         LpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+0Y3UZzjydu4NpcC032FWbuvT2IKfw1ynn6+T4z3Rak=;
        b=u0DovyKu0BwsMmHZZCds91Oa/0v6TU1tk+ivsOMn165KSXExiiol8tSL0RVach0LBX
         /WoU8N2a8qtfu1t3iW+KPP1ZL7dHag5Mv67cU9c+pHPVOvbkomIj4KFWnEaFR1rYcCWA
         GszaTMKZ8A8sIOsy8KzpJoiNWljE6njZU2UJhLtvrlhY8My8skAecQffSSWzyUdjUFPm
         3SJI2JXbKKt6/EInol800kS7Czhxwzpn9aspgkOuQQFXzHVDJVOn14gxfXfO0xXNfXzD
         NdO3d5rraV5gbtPLCWcwEZI9RjqQv67eD3KDJCJJqtLx/hM3gu9sj64fnC7o/6SDcTGT
         EDWQ==
X-Gm-Message-State: AOAM531YMksSjTQBDLBK0a1rmymyYvj6ug+ikS+TqeXUs78Me5ZYmogZ
        tDKZKI0ApTR4V4Q62sewZBrjsw==
X-Google-Smtp-Source: ABdhPJyONL+kObdLMQ23Bb+FyzJiOyieAiW8Z4Y75USV7F6nnILpzHi8IIBw3S0+NNIEL6cfForftQ==
X-Received: by 2002:a5d:45c5:0:b0:20a:be8f:aca6 with SMTP id b5-20020a5d45c5000000b0020abe8faca6mr23084338wrs.493.1651069625435;
        Wed, 27 Apr 2022 07:27:05 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b0038eca3cdbb3sm1646899wmr.13.2022.04.27.07.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:27:04 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/exiu: Fix acknowledgment of edge triggered interrupts
Date:   Wed, 27 Apr 2022 15:26:47 +0100
Message-Id: <20220427142647.1736658-1-daniel.thompson@linaro.org>
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

Fix this by clearing the interrupt request from .irq_ack() instead. This
requires switching to the fasteoi-ack flow instead of the fasteoi flow.
This approach is inspired by the nmi code found in irq-sun6i-r.c .

Note: It *is* intentional not to call irq_chip_ack_parent() from
      exiu_irq_ack(). Parents that implement the fasteoi-ack flow don't
      want us to do that (and we'd crash if we tried).

This problem was discovered through code review rather then reproducing
missed interrupts in a real platform. Nevertheless the change has been
tested for regression on a Developerbox/SC2A11 using the power button
(which is edge triggered and is the only thing connected to the EXIU on
this platform).

Fixes: 706cffc1b912 ("irqchip/exiu: Add support for Socionext Synquacer EXIU controller")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/Kconfig.platforms   |  1 +
 drivers/irqchip/irq-sni-exiu.c | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

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
index abd011fcecf4..1cc2ec272ebd 100644
--- a/drivers/irqchip/irq-sni-exiu.c
+++ b/drivers/irqchip/irq-sni-exiu.c
@@ -37,12 +37,11 @@ struct exiu_irq_data {
 	u32		spi_base;
 };

-static void exiu_irq_eoi(struct irq_data *d)
+static void exiu_irq_ack(struct irq_data *d)
 {
 	struct exiu_irq_data *data = irq_data_get_irq_chip_data(d);

 	writel(BIT(d->hwirq), data->base + EIREQCLR);
-	irq_chip_eoi_parent(d);
 }

 static void exiu_irq_mask(struct irq_data *d)
@@ -104,7 +103,8 @@ static int exiu_irq_set_type(struct irq_data *d, unsigned int type)

 static struct irq_chip exiu_irq_chip = {
 	.name			= "EXIU",
-	.irq_eoi		= exiu_irq_eoi,
+	.irq_ack		= exiu_irq_ack,
+	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_enable		= exiu_irq_enable,
 	.irq_mask		= exiu_irq_mask,
 	.irq_unmask		= exiu_irq_unmask,
@@ -148,6 +148,7 @@ static int exiu_domain_alloc(struct irq_domain *dom, unsigned int virq,
 	struct irq_fwspec parent_fwspec;
 	struct exiu_irq_data *info = dom->host_data;
 	irq_hw_number_t hwirq;
+	int i, ret;

 	parent_fwspec = *fwspec;
 	if (is_of_node(dom->parent->fwnode)) {
@@ -165,7 +166,14 @@ static int exiu_domain_alloc(struct irq_domain *dom, unsigned int virq,
 	irq_domain_set_hwirq_and_chip(dom, virq, hwirq, &exiu_irq_chip, info);

 	parent_fwspec.fwnode = dom->parent->fwnode;
-	return irq_domain_alloc_irqs_parent(dom, virq, nr_irqs, &parent_fwspec);
+	ret = irq_domain_alloc_irqs_parent(dom, virq, nr_irqs, &parent_fwspec);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_set_handler(virq+i, handle_fasteoi_ack_irq);
+
+	return 0;
 }

 static const struct irq_domain_ops exiu_domain_ops = {

base-commit: b2d229d4ddb17db541098b83524d901257e93845
--
2.35.1


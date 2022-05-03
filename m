Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA925185DB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbiECNt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiECNtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:49:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9D41D0D0
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 06:45:46 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k2so23456768wrd.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2l7FO86j4xB2KtqQIq0q0SW9gMxybtUx7HgngsHixTs=;
        b=cEyeZvvw2Tu39/c04bJbtDNch9vMteVk9LRrmDt5DchuMGpQycd4xtq0jsKjwfiAvn
         rVO/veX+tk6jdbbAGbwrok006OxQxy0UwYG3lTuPowlbvBV09y7zOwN0+r6v0L+BjahT
         bz9HFxeWV7uV9QD8wjSPsvskVdFExQfn4PWGSo4+9mscWQZsOLOsWR/8J/xNqZVkPV+c
         f3OHnlDfIhYgVe2pgExDHfpuyip7Qqzt5KvU8M8vmrwRIVcsfcpLBhS+79vDyvdheN3O
         FAB0L3kZ6k4MIgk6/2ci1EkmaRsGbv3k8VJHB0cU7cRqyCbL33insklCnZH5AFnUySlh
         uU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2l7FO86j4xB2KtqQIq0q0SW9gMxybtUx7HgngsHixTs=;
        b=gh5p5XRQxS/hymwvCgjNjprZKous4qft8SCFs16CbCa3QkhmJqRVJzHRLXIUilKSMu
         0htCyXwPbD/7gRNg2xNnoSiWxmVr6ngAhtiun066fSDFOgYmDuutHnbWplrsqLBoBp5f
         ZCjQ1P43QlgYdS9KTSsr78btgyPrnRRymi6FslLxLuubG7Qp0W6OvmyjnsyQwyO+qXGF
         WhqnJB6XrZsNMveBx5Xn+A+wUxdPG2vwEJc6XoABjB0hPBu1bL15TuaJ1Osvm8KWU0Wx
         kbDkykLJtccPWrqNYb+N6IHmZu/9Bu/acfpLCvir9HuHn2M+lwK6WoEvP9hc2OSmQGmv
         fLzw==
X-Gm-Message-State: AOAM531MsOHd4WXFAK2PCgrJFUuR8hjAOf4XLdrtgXp5hm2vHGlWAZ+4
        /sGvkPbFYp6zJZivDu1o8wmw8w==
X-Google-Smtp-Source: ABdhPJyKo1xSFFzC3jNvl/uaHEsRxkT5UAeworwoEISx5eWwOXlATfDD3f4Ba+8moyg9ujjASNlKsw==
X-Received: by 2002:a5d:4882:0:b0:207:97dd:111c with SMTP id g2-20020a5d4882000000b0020797dd111cmr13663218wrq.115.1651585544975;
        Tue, 03 May 2022 06:45:44 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id e11-20020a05600c4e4b00b003942a244f36sm1766544wmq.15.2022.05.03.06.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 06:45:44 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] irqchip/exiu: Fix acknowledgment of edge triggered interrupts
Date:   Tue,  3 May 2022 14:45:41 +0100
Message-Id: <20220503134541.2566457-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.35.1
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
play with the different trigger mode [and an mdelay(500) so I can
can check what happens on a double click in both modes].

Fixes: 706cffc1b912 ("irqchip/exiu: Add support for Socionext Synquacer EXIU controller")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    Changes in v3:
     * Optimize exiu_irq_eoi() to avoid unnecessary register read (Marc Z)
     * Add comment to exiu_irq_eoi() so future adventurers can better
       understand how the EXIU on SC2A11 behaves (Marc Z)
     * Remove redundant trigger mode management from exiu_domain_alloc()
       (Marc Z)
    
    Changes in v2:
    
     * Switch to dynamic selection of handle_fasteoi_irq and
       handle_fasteoi_ack_irq and reintroduce exiu_irq_eoi() since we need
       that for level triggered interrupts (Ard B).
     * Above changes mean we are no longer using sun6i NMI code as a
       template to tidy up the description accordingly.

 arch/arm64/Kconfig.platforms   |  1 +
 drivers/irqchip/irq-sni-exiu.c | 25 ++++++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

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
index abd011fcecf4..c7db617e1a2f 100644
--- a/drivers/irqchip/irq-sni-exiu.c
+++ b/drivers/irqchip/irq-sni-exiu.c
@@ -37,11 +37,26 @@ struct exiu_irq_data {
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
+
+	/*
+	 * Level triggered interrupts are latched and must be cleared during
+	 * EOI or the interrupt will be jammed on. Of course if a level
+	 * triggered interrupt is still asserted then the write will not clear
+	 * the interrupt.
+	 */
+	if (irqd_is_level_type(d))
+		writel(BIT(d->hwirq), data->base + EIREQCLR);
+
 	irq_chip_eoi_parent(d);
 }

@@ -91,10 +106,13 @@ static int exiu_irq_set_type(struct irq_data *d, unsigned int type)
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
@@ -104,6 +122,7 @@ static int exiu_irq_set_type(struct irq_data *d, unsigned int type)

 static struct irq_chip exiu_irq_chip = {
 	.name			= "EXIU",
+	.irq_ack		= exiu_irq_ack,
 	.irq_eoi		= exiu_irq_eoi,
 	.irq_enable		= exiu_irq_enable,
 	.irq_mask		= exiu_irq_mask,

base-commit: b2d229d4ddb17db541098b83524d901257e93845
--
2.35.1


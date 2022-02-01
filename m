Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1534A5BCC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbiBAMEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:04:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52694 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237690AbiBAMEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:04:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC4946151F;
        Tue,  1 Feb 2022 12:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DD8C340ED;
        Tue,  1 Feb 2022 12:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643717012;
        bh=QTDSEgjqP7luf2gRYl6YaKV1lykiDQuMO/rtSnXfIBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pzn11U8lQ1sbaHCow3r6eDwYc2MZzV4EVDyNLziribjv2My7HV33Ol7cUiYEezoK0
         2CwmjT7tFW6lvCgaKsavTR0fs+5RY0crIroGHo/FDBzKkWXb2Tk5VFCFoH0ePPX8bU
         Zmt4UXLJLHgRJOzqN9u6iI6ZpOvyGY5lvVo9RchKWPmCRfauEVTEbJvZjP03x3nuFj
         zLmqMuok3fZDYAyg8RCGklZihz4kNBbGOTtU+cFWM2vODOtlz5QiIS2kvAuUitjffx
         /1AisSz+WYe9g/h2+aV/0WQ0aFWVshkLJRhrzoulJ6YemrwLQlyxODBXrNeHYv3QIr
         lhBCCz5/kyx9g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nErsg-004d46-CE; Tue, 01 Feb 2022 12:03:30 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [PATCH 04/12] irqchip/renesas-irqc: Move PM device over to irq domain
Date:   Tue,  1 Feb 2022 12:03:02 +0000
Message-Id: <20220201120310.878267-5-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220201120310.878267-1-maz@kernel.org>
References: <20220201120310.878267-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, tglx@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, kernel@esmil.dk
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the reference to the device over to the irq domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-renesas-irqc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 909325f88239..1ee5e9941f67 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -188,13 +188,14 @@ static int irqc_probe(struct platform_device *pdev)
 	p->gc->reg_base = p->cpu_int_base;
 	p->gc->chip_types[0].regs.enable = IRQC_EN_SET;
 	p->gc->chip_types[0].regs.disable = IRQC_EN_STS;
-	p->gc->chip_types[0].chip.parent_device = dev;
 	p->gc->chip_types[0].chip.irq_mask = irq_gc_mask_disable_reg;
 	p->gc->chip_types[0].chip.irq_unmask = irq_gc_unmask_enable_reg;
 	p->gc->chip_types[0].chip.irq_set_type	= irqc_irq_set_type;
 	p->gc->chip_types[0].chip.irq_set_wake	= irqc_irq_set_wake;
 	p->gc->chip_types[0].chip.flags	= IRQCHIP_MASK_ON_SUSPEND;
 
+	irq_domain_set_pm_device(p->irq_domain, dev);
+
 	/* request interrupts one by one */
 	for (k = 0; k < p->number_of_irqs; k++) {
 		if (devm_request_irq(dev, p->irq[k].requested_irq,
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FE14AF690
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbiBIQ0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbiBIQ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:26:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4033C061355;
        Wed,  9 Feb 2022 08:26:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76EDF6184A;
        Wed,  9 Feb 2022 16:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA65DC340EF;
        Wed,  9 Feb 2022 16:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644423978;
        bh=cs00MVgpXDQgdlwEEoboPGvlbWWnFiL2BYOY+lnD89Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G0IrH+7AYPbkmnL7ei33L1Wk1Kv/4QwD6z0Vk+wIetaIo96RqYxz97A8X56+dXdoI
         t4vx6Z96LAd3XMFi8PcZsKAAELhVnByjTSDjoH3yx5Y/s5una8Pb5yFLXIwaD1J2Ew
         LE6jVKyoR+EDZak4I1Tr/5LFBNCOUxuYRrnAnQmCWIdWFjKF5y0btyA+CtFmcEVI55
         ejd0yp1KCse0OZNeMWCXznG8Te5ODWiPlv7xTHl/XzuvKKjfPhYlE5AjUpo77guc+V
         gguCJFV/DUqW9MfH2GTpmhRIy+NwKBzhs/TVcc4SOwSZIUKb4WYbKejv/c+CEm3Aes
         BxgtuxhwPH0PQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHpnN-006fgT-1b; Wed, 09 Feb 2022 16:26:17 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        kernel-team@android.com
Subject: [PATCH 04/10] irqchip/lpc32xx: Switch to dynamic chip name output
Date:   Wed,  9 Feb 2022 16:26:01 +0000
Message-Id: <20220209162607.1118325-5-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209162607.1118325-1-maz@kernel.org>
References: <20220209162607.1118325-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, tony@atomide.com, tglx@linutronix.de, vz@mleia.com, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, kernel@esmil.dk, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of overriding the name field with the device name, use
the relevant callback. This allows us to make the irq_chip structure
const.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-lpc32xx.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-lpc32xx.c b/drivers/irqchip/irq-lpc32xx.c
index a29357f39450..4d70a857133f 100644
--- a/drivers/irqchip/irq-lpc32xx.c
+++ b/drivers/irqchip/irq-lpc32xx.c
@@ -11,6 +11,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <asm/exception.h>
 
@@ -25,8 +26,8 @@
 
 struct lpc32xx_irq_chip {
 	void __iomem *base;
+	phys_addr_t addr;
 	struct irq_domain *domain;
-	struct irq_chip chip;
 };
 
 static struct lpc32xx_irq_chip *lpc32xx_mic_irqc;
@@ -118,6 +119,24 @@ static int lpc32xx_irq_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
+static void lpc32xx_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct lpc32xx_irq_chip *ic = irq_data_get_irq_chip_data(d);
+
+	if (ic == lpc32xx_mic_irqc)
+		seq_printf(p, "%08x.mic", ic->addr);
+	else
+		seq_printf(p, "%08x.sic", ic->addr);
+}
+
+static const struct irq_chip lpc32xx_chip = {
+	.irq_ack	= lpc32xx_irq_ack,
+	.irq_mask	= lpc32xx_irq_mask,
+	.irq_unmask	= lpc32xx_irq_unmask,
+	.irq_set_type	= lpc32xx_irq_set_type,
+	.irq_print_chip	= lpc32xx_irq_print_chip,
+};
+
 static void __exception_irq_entry lpc32xx_handle_irq(struct pt_regs *regs)
 {
 	struct lpc32xx_irq_chip *ic = lpc32xx_mic_irqc;
@@ -153,7 +172,7 @@ static int lpc32xx_irq_domain_map(struct irq_domain *id, unsigned int virq,
 	struct lpc32xx_irq_chip *ic = id->host_data;
 
 	irq_set_chip_data(virq, ic);
-	irq_set_chip_and_handler(virq, &ic->chip, handle_level_irq);
+	irq_set_chip_and_handler(virq, &lpc32xx_chip, handle_level_irq);
 	irq_set_status_flags(virq, IRQ_LEVEL);
 	irq_set_noprobe(virq);
 
@@ -183,6 +202,7 @@ static int __init lpc32xx_of_ic_init(struct device_node *node,
 	if (!irqc)
 		return -ENOMEM;
 
+	irqc->addr = addr;
 	irqc->base = of_iomap(node, 0);
 	if (!irqc->base) {
 		pr_err("%pOF: unable to map registers\n", node);
@@ -190,21 +210,11 @@ static int __init lpc32xx_of_ic_init(struct device_node *node,
 		return -EINVAL;
 	}
 
-	irqc->chip.irq_ack = lpc32xx_irq_ack;
-	irqc->chip.irq_mask = lpc32xx_irq_mask;
-	irqc->chip.irq_unmask = lpc32xx_irq_unmask;
-	irqc->chip.irq_set_type = lpc32xx_irq_set_type;
-	if (is_mic)
-		irqc->chip.name = kasprintf(GFP_KERNEL, "%08x.mic", addr);
-	else
-		irqc->chip.name = kasprintf(GFP_KERNEL, "%08x.sic", addr);
-
 	irqc->domain = irq_domain_add_linear(node, NR_LPC32XX_IC_IRQS,
 					     &lpc32xx_irq_domain_ops, irqc);
 	if (!irqc->domain) {
 		pr_err("unable to add irq domain\n");
 		iounmap(irqc->base);
-		kfree(irqc->chip.name);
 		kfree(irqc);
 		return -ENODEV;
 	}
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7AD4AF69F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbiBIQ0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbiBIQ01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:26:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEC0C05CB95;
        Wed,  9 Feb 2022 08:26:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 289E3B82326;
        Wed,  9 Feb 2022 16:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F58C340F6;
        Wed,  9 Feb 2022 16:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644423978;
        bh=35gaKu66nZ20WZyH7/jSaUXaFmUE0rTSstpzSIRxwTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aKaNyBx0o7jK3XoQTrSI6y0lWl9wA+EfzdvJ7sm/jt0aDmodPYQkZnNeTBd1e/bZ9
         0DTdcbCfQFL+u/MFuql48ZyHIBx89NWHO22YNST707N8rClBJuXpPI1fB4QOTxON1f
         +HGFuh0RpnTyy7kq+nmqfMPhcUHp1/4n+crPtQ8zV4vYJHVq6C89T+k9fkDI9/rncT
         N2Ot+I3kSzWw2Y1bjvk6ePKpyPk4S/w8TL+15XttL5DFDX6wmSByHcJbT/7J4pMs5+
         zFUtz+ZwZ2W4pK1bF6Laya48nDMAlB5tceTBkXeHVMkIQs03/8F9AYM80smUHFX5BM
         MrGApbxOywZUg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHpnM-006fgT-Ot; Wed, 09 Feb 2022 16:26:16 +0000
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
Subject: [PATCH 03/10] irqchip/gic: Switch to dynamic chip name output
Date:   Wed,  9 Feb 2022 16:26:00 +0000
Message-Id: <20220209162607.1118325-4-maz@kernel.org>
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

The last dynamic aspect of the GIC's irq_chip structure is the
name that is associated to it.

Move the output of that name to the relevant callback, which
allows us to do a bit of cleanup and mark the structures const.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic.c | 102 ++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 48 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index fb741b42ca2d..58ba835bee1f 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -34,6 +34,7 @@
 #include <linux/irqdomain.h>
 #include <linux/interrupt.h>
 #include <linux/percpu.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
@@ -66,7 +67,6 @@ union gic_base {
 };
 
 struct gic_chip_data {
-	struct irq_chip chip;
 	union gic_base dist_base;
 	union gic_base cpu_base;
 	void __iomem *raw_dist_base;
@@ -397,18 +397,15 @@ static void gic_handle_cascade_irq(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static const struct irq_chip gic_chip = {
-	.irq_mask		= gic_mask_irq,
-	.irq_unmask		= gic_unmask_irq,
-	.irq_eoi		= gic_eoi_irq,
-	.irq_set_type		= gic_set_type,
-	.irq_retrigger          = gic_retrigger,
-	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
-	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
-	.flags			= IRQCHIP_SET_TYPE_MASKED |
-				  IRQCHIP_SKIP_SET_WAKE |
-				  IRQCHIP_MASK_ON_SUSPEND,
-};
+static void gic_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct gic_chip_data *gic = irq_data_get_irq_chip_data(d);
+
+	if (gic->domain->dev)
+		seq_printf(p, gic->domain->dev->of_node->name);
+	else
+		seq_printf(p, "GIC-%d", (int)(gic - &gic_data[0]));
+}
 
 void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 {
@@ -799,8 +796,12 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
 	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + gic_irq(d);
+	struct gic_chip_data *gic = irq_data_get_irq_chip_data(d);
 	unsigned int cpu;
 
+	if (unlikely(gic != &gic_data[0]))
+		return -EINVAL;
+
 	if (!force)
 		cpu = cpumask_any_and(mask_val, cpu_online_mask);
 	else
@@ -880,6 +881,39 @@ static __init void gic_smp_init(void)
 #define gic_ipi_send_mask	NULL
 #endif
 
+static const struct irq_chip gic_chip = {
+	.irq_mask		= gic_mask_irq,
+	.irq_unmask		= gic_unmask_irq,
+	.irq_eoi		= gic_eoi_irq,
+	.irq_set_type		= gic_set_type,
+	.irq_retrigger          = gic_retrigger,
+	.irq_set_affinity	= gic_set_affinity,
+	.ipi_send_mask		= gic_ipi_send_mask,
+	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
+	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
+	.irq_print_chip		= gic_irq_print_chip,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static const struct irq_chip gic_chip_mode1 = {
+	.name			= "GICv2",
+	.irq_mask		= gic_eoimode1_mask_irq,
+	.irq_unmask		= gic_unmask_irq,
+	.irq_eoi		= gic_eoimode1_eoi_irq,
+	.irq_set_type		= gic_set_type,
+	.irq_retrigger          = gic_retrigger,
+	.irq_set_affinity	= gic_set_affinity,
+	.ipi_send_mask		= gic_ipi_send_mask,
+	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
+	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
+	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
 #ifdef CONFIG_BL_SWITCHER
 /*
  * gic_send_sgi - send a SGI directly to given CPU interface number
@@ -1024,15 +1058,19 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 {
 	struct gic_chip_data *gic = d->host_data;
 	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
+	const struct irq_chip *chip;
+
+	chip = (static_branch_likely(&supports_deactivate_key) &&
+		gic == &gic_data[0]) ? &gic_chip_mode1 : &gic_chip;
 
 	switch (hw) {
 	case 0 ... 31:
 		irq_set_percpu_devid(irq);
-		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
+		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
 		break;
 	default:
-		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
+		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
 		irqd_set_single_target(irqd);
@@ -1127,25 +1165,6 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.unmap = gic_irq_domain_unmap,
 };
 
-static void gic_init_chip(struct gic_chip_data *gic, const char *name,
-			  bool use_eoimode1)
-{
-	/* Initialize irq_chip */
-	gic->chip = gic_chip;
-	gic->chip.name = name;
-
-	if (use_eoimode1) {
-		gic->chip.irq_mask = gic_eoimode1_mask_irq;
-		gic->chip.irq_eoi = gic_eoimode1_eoi_irq;
-		gic->chip.irq_set_vcpu_affinity = gic_irq_set_vcpu_affinity;
-	}
-
-	if (gic == &gic_data[0]) {
-		gic->chip.irq_set_affinity = gic_set_affinity;
-		gic->chip.ipi_send_mask = gic_ipi_send_mask;
-	}
-}
-
 static int gic_init_bases(struct gic_chip_data *gic,
 			  struct fwnode_handle *handle)
 {
@@ -1245,7 +1264,6 @@ static int gic_init_bases(struct gic_chip_data *gic,
 static int __init __gic_init_bases(struct gic_chip_data *gic,
 				   struct fwnode_handle *handle)
 {
-	char *name;
 	int i, ret;
 
 	if (WARN_ON(!gic || gic->domain))
@@ -1265,18 +1283,8 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
 			pr_info("GIC: Using split EOI/Deactivate mode\n");
 	}
 
-	if (static_branch_likely(&supports_deactivate_key) && gic == &gic_data[0]) {
-		name = kasprintf(GFP_KERNEL, "GICv2");
-		gic_init_chip(gic, name, true);
-	} else {
-		name = kasprintf(GFP_KERNEL, "GIC-%d", (int)(gic-&gic_data[0]));
-		gic_init_chip(gic, name, false);
-	}
-
 	ret = gic_init_bases(gic, handle);
-	if (ret)
-		kfree(name);
-	else if (gic == &gic_data[0])
+	if (gic == &gic_data[0])
 		gic_smp_init();
 
 	return ret;
@@ -1459,8 +1467,6 @@ int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq)
 	if (!*gic)
 		return -ENOMEM;
 
-	gic_init_chip(*gic, dev->of_node->name, false);
-
 	ret = gic_of_setup(*gic, dev->of_node);
 	if (ret)
 		return ret;
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600BD4B6BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiBOMUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:20:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbiBOMUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:20:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF10F1074EC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:20:01 -0800 (PST)
Date:   Tue, 15 Feb 2022 12:19:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644927600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5KN2WgRqabHnBry6yKtQu/wg2M9bVAeziReXi9ghr0=;
        b=Q00c4YF5Aj2jxnRaD9J7RFVIloblb0djgyBZ/9XPnaZR2mXjbH5xz67kR2aMkVmyVW08Yh
        RQTNIt4IeTwAiQRozanTvo4N/a7+Jl8/+yiEygLAG2Ghw0PvP63R2oDR6TJfvTXLJWFOkh
        0atOzN825q0y81lTLRtolJqZ3+Qg3cQtXTogFqQUAdLjqFA+mwrrCkAiZdfUDrQToE9Fxl
        LmVDlqAeWSf63H2VQmromudl+WlcWdyY2NGwOl0BsTgmYshNCYV+TQRiELRiuo3fxOkQJ0
        sWcXH4dsU7M3phiZhy/i4u9j4ROVVmIL557YICuzSTuiM3sslUVVO5LMfL1iZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644927600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5KN2WgRqabHnBry6yKtQu/wg2M9bVAeziReXi9ghr0=;
        b=ahhP440cPOx5qZAu/YkW4jlriqQTNJ1aRXre8Pxdtvn/Z8+h/ysIoK/QXBP/LTsNv55aXF
        Xe4xR+dxbsNh8GCA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic: Switch to dynamic chip name output
Cc:     Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>, tglx@linutronix.de
In-Reply-To: <20220209162607.1118325-4-maz@kernel.org>
References: <20220209162607.1118325-4-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164492759940.16921.16241947520075059720.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     745f1fb91fe51b4a36bc1c3dbccdbbbb978f93d2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/745f1fb91fe51b4a36bc1c3dbccdbbbb978f93d2
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 09 Feb 2022 16:26:00 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 15 Feb 2022 11:25:46 

irqchip/gic: Switch to dynamic chip name output

The last dynamic aspect of the GIC's irq_chip structure is the
name that is associated to it.

Move the output of that name to the relevant callback, which
allows us to do a bit of cleanup and mark the structures const.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20220209162607.1118325-4-maz@kernel.org
---
 drivers/irqchip/irq-gic.c | 102 +++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 48 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index fb741b4..58ba835 100644
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
@@ -1245,7 +1264,6 @@ error:
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

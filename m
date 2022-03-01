Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA5A4C8909
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiCAKM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiCAKMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:12:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0FD723D9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:11:38 -0800 (PST)
Date:   Tue, 01 Mar 2022 10:11:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646129497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qeGJX0SIhs4mI90650UsQtcYjPLhiqoCG3lN7p4yBo=;
        b=IozzukERP/AcvXUVMUriqBbAzSS04JvhSQxYa/BAHHMppU4DNVD8oLEN6v0t3heVo+dKa3
        FgC3nIZIq56EGuB/IxZc/wcgj4v2HT6Q4q+W3520UOk9hTo584aMlzvht2TlXUizNVInI1
        YJQhsuBEOK1SAClKR3Fzhkdx8y05rhXPeGziiQf7cPDea4VFnbfF4eimVPkjIJN4Eau4Fi
        kuGZCqqKg1UiIPmt13Jh75iN4HCrrgyTWhrSP/HQ2/HCj83Ypo4VKZ5QnpDpj/vblNFRnT
        QtsYuCT2aY5+S7EjE3RMr55m2htknGOwvNlg9Z+QXdBU8/8VGa/2h4xRAXMlQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646129497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qeGJX0SIhs4mI90650UsQtcYjPLhiqoCG3lN7p4yBo=;
        b=sWOvcGRjtoqAVGm7qtYJXePTx+tjawu0sLqtURhprLcliUVbCut50zOpdMs7yEu7mnAKkH
        SFo2wkHx8hA+mxDw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/qcom-pdc: Kill non-wakeup irqdomain
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220224101226.88373-3-maz@kernel.org>
References: <20220224101226.88373-3-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164612949655.16921.380901203198635513.tip-bot2@tip-bot2>
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

Commit-ID:     4dc70713dc24dceeea7f106828674744a6294860
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4dc70713dc24dceeea7f106828674744a6294860
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 24 Feb 2022 10:12:23 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 01 Mar 2022 10:06:24 

irqchip/qcom-pdc: Kill non-wakeup irqdomain

A careful look at the way the PDC driver works shows that:

- all interrupts are in the same space
- all interrupts are treated the same

And yet the driver creates two domains based on whether
the interrupt gets mapped directly or from the pinctrl code,
which is obviously a waste of resources.

Kill the non-wakeup domain and unify all the interrupt handling.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220224101226.88373-3-maz@kernel.org
---
 drivers/irqchip/qcom-pdc.c | 84 ++++---------------------------------
 1 file changed, 10 insertions(+), 74 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 3b214c4..5be5314 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
-#define PDC_MAX_IRQS		168
 #define PDC_MAX_GPIO_IRQS	256
 
 #define CLEAR_INTR(reg, intr)	(reg & ~(1 << intr))
@@ -228,51 +227,6 @@ static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
 	if (ret)
 		return ret;
 
-	ret  = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-					     &qcom_pdc_gic_chip, NULL);
-	if (ret)
-		return ret;
-
-	region = get_pin_region(hwirq);
-	if (!region)
-		return irq_domain_disconnect_hierarchy(domain->parent, virq);
-
-	if (type & IRQ_TYPE_EDGE_BOTH)
-		type = IRQ_TYPE_EDGE_RISING;
-
-	if (type & IRQ_TYPE_LEVEL_MASK)
-		type = IRQ_TYPE_LEVEL_HIGH;
-
-	parent_fwspec.fwnode      = domain->parent->fwnode;
-	parent_fwspec.param_count = 3;
-	parent_fwspec.param[0]    = 0;
-	parent_fwspec.param[1]    = pin_to_hwirq(region, hwirq);
-	parent_fwspec.param[2]    = type;
-
-	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
-					    &parent_fwspec);
-}
-
-static const struct irq_domain_ops qcom_pdc_ops = {
-	.translate	= qcom_pdc_translate,
-	.alloc		= qcom_pdc_alloc,
-	.free		= irq_domain_free_irqs_common,
-};
-
-static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int virq,
-			       unsigned int nr_irqs, void *data)
-{
-	struct irq_fwspec *fwspec = data;
-	struct irq_fwspec parent_fwspec;
-	struct pdc_pin_region *region;
-	irq_hw_number_t hwirq;
-	unsigned int type;
-	int ret;
-
-	ret = qcom_pdc_translate(domain, fwspec, &hwirq, &type);
-	if (ret)
-		return ret;
-
 	if (hwirq == GPIO_NO_WAKE_IRQ)
 		return irq_domain_disconnect_hierarchy(domain, virq);
 
@@ -301,16 +255,9 @@ static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int virq,
 					    &parent_fwspec);
 }
 
-static int qcom_pdc_gpio_domain_select(struct irq_domain *d,
-				       struct irq_fwspec *fwspec,
-				       enum irq_domain_bus_token bus_token)
-{
-	return bus_token == DOMAIN_BUS_WAKEUP;
-}
-
-static const struct irq_domain_ops qcom_pdc_gpio_ops = {
-	.select		= qcom_pdc_gpio_domain_select,
-	.alloc		= qcom_pdc_gpio_alloc,
+static const struct irq_domain_ops qcom_pdc_ops = {
+	.translate	= qcom_pdc_translate,
+	.alloc		= qcom_pdc_alloc,
 	.free		= irq_domain_free_irqs_common,
 };
 
@@ -361,7 +308,7 @@ static int pdc_setup_pin_mapping(struct device_node *np)
 
 static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 {
-	struct irq_domain *parent_domain, *pdc_domain, *pdc_gpio_domain;
+	struct irq_domain *parent_domain, *pdc_domain;
 	int ret;
 
 	pdc_base = of_iomap(node, 0);
@@ -383,32 +330,21 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 		goto fail;
 	}
 
-	pdc_domain = irq_domain_create_hierarchy(parent_domain, 0, PDC_MAX_IRQS,
-						 of_fwnode_handle(node),
-						 &qcom_pdc_ops, NULL);
-	if (!pdc_domain) {
-		pr_err("%pOF: GIC domain add failed\n", node);
-		ret = -ENOMEM;
-		goto fail;
-	}
-
-	pdc_gpio_domain = irq_domain_create_hierarchy(parent_domain,
+	pdc_domain = irq_domain_create_hierarchy(parent_domain,
 					IRQ_DOMAIN_FLAG_QCOM_PDC_WAKEUP,
 					PDC_MAX_GPIO_IRQS,
 					of_fwnode_handle(node),
-					&qcom_pdc_gpio_ops, NULL);
-	if (!pdc_gpio_domain) {
-		pr_err("%pOF: PDC domain add failed for GPIO domain\n", node);
+					&qcom_pdc_ops, NULL);
+	if (!pdc_domain) {
+		pr_err("%pOF: PDC domain add failed\n", node);
 		ret = -ENOMEM;
-		goto remove;
+		goto fail;
 	}
 
-	irq_domain_update_bus_token(pdc_gpio_domain, DOMAIN_BUS_WAKEUP);
+	irq_domain_update_bus_token(pdc_domain, DOMAIN_BUS_WAKEUP);
 
 	return 0;
 
-remove:
-	irq_domain_remove(pdc_domain);
 fail:
 	kfree(pdc_region);
 	iounmap(pdc_base);

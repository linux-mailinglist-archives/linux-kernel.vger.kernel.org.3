Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8393C4C290D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiBXKNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiBXKNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:13:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A682BB16EC;
        Thu, 24 Feb 2022 02:12:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0827BB824F1;
        Thu, 24 Feb 2022 10:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9625EC340F1;
        Thu, 24 Feb 2022 10:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645697551;
        bh=SOALSyIfSfzTlnbuP+RGhp+c3awflGDjDp8CanYUKFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLWS8JSXLRoHlwK1klGXqhDwvI9lD0bZGLfWACCgOgFIXWw1rnTG+8217PWkihFew
         FmcTNzbcYShkLuYbBmsyPlzUqxqGdWAdzoFD83Uy5B3Kb96iUgVRj37BbZW9bTkRXW
         foyhc+56kZaG4fNHWIleyEXbh8kBPpKvl6oCzPh74b260Ilt0sZX6q1cvidGLSH59I
         k3Zoz4YkdwX74B9jlfAF4P+b/9rYHngMShzXXD2gg14wuNxk5+2+Y9oje1RINTwW8L
         xX3MuwWaIf7HGdogqSYwg+bKMS5IsZxBq3fb8WfwSu9uyElJLcTaNmoU0rabS9fltK
         hrubePVHiCFTA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nNB6r-00A979-Gs; Thu, 24 Feb 2022 10:12:29 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/5] irqchip/qcom-pdc: Kill non-wakeup irqdomain
Date:   Thu, 24 Feb 2022 10:12:23 +0000
Message-Id: <20220224101226.88373-3-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220224101226.88373-1-maz@kernel.org>
References: <20220224101226.88373-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, agross@kernel.org, bjorn.andersson@linaro.org, tglx@linutronix.de, linux-arm-msm@vger.kernel.org
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

A careful look at the way the PDC driver works shows that:

- all interrupts are in the same space
- all interrupts are treated the same

And yet the driver creates two domains based on whether
the interrupt gets mapped directly or from the pinctrl code,
which is obviously a waste of resources.

Kill the non-wakeup domain and unify all the interrupt handling.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/qcom-pdc.c | 84 +++++---------------------------------
 1 file changed, 10 insertions(+), 74 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 3b214c4e6755..5be531403f50 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
-#define PDC_MAX_IRQS		168
 #define PDC_MAX_GPIO_IRQS	256
 
 #define CLEAR_INTR(reg, intr)	(reg & ~(1 << intr))
@@ -224,51 +223,6 @@ static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
 	unsigned int type;
 	int ret;
 
-	ret = qcom_pdc_translate(domain, fwspec, &hwirq, &type);
-	if (ret)
-		return ret;
-
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
 	ret = qcom_pdc_translate(domain, fwspec, &hwirq, &type);
 	if (ret)
 		return ret;
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
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBA34C28FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiBXKNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiBXKNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:13:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6B7B16EC;
        Thu, 24 Feb 2022 02:12:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B905615C3;
        Thu, 24 Feb 2022 10:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB62C340E9;
        Thu, 24 Feb 2022 10:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645697551;
        bh=oYoXFxFVA983d45Heq72rIXdWdudjES3kjIEKjsuh9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SyreEJXTXj6Eqer63SAAyt7DMdA/cuNndPmCB15J7DUlokHjWv6LdjBVtk9j+sb7P
         iK+IJE/LqFZPz+/0BL+n4Flr1aaEP7npVEg/A5igDgVujl1uaaJF7hoL7rweycbl9f
         xVsz21lIS/j7wEbFp8jYQbVMdp5aoHeB6gTnLjYc2sM+8Y93/iuzAotzGvUGbmJ73r
         8wK7y1Iyy3cMk61dVpBEYKRK+M80oLSHTS8gOTSk3u/MxsL4IStcrh7uyyjj1aW2xN
         RPNP/ZEEKB4ESnFSrsvzDMTj1f3OqcY4//hla3OmbI5uMa6mHI9CI1lB7ne8/WV11X
         UBb0hM2b4zBMw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nNB6r-00A979-BE; Thu, 24 Feb 2022 10:12:29 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/5] irqchip/qcom-pdc: Kill PDC_NO_PARENT_IRQ
Date:   Thu, 24 Feb 2022 10:12:22 +0000
Message-Id: <20220224101226.88373-2-maz@kernel.org>
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

PDC_NO_PARENT_IRQ is pretty pointless, as all it indicates is
that the PDC terminates the interrupt hierarchy. Which is
exactly the same as not having a mapping in the GIC space.
This is also bad practice to treat the absence of a hwirq
as a hwirq itself.

Just explicitly use the region mapping pointer, and drop
the definition.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/qcom-pdc.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 173e6520e06e..3b214c4e6755 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -30,14 +30,14 @@
 #define IRQ_ENABLE_BANK		0x10
 #define IRQ_i_CFG		0x110
 
-#define PDC_NO_PARENT_IRQ	~0UL
-
 struct pdc_pin_region {
 	u32 pin_base;
 	u32 parent_base;
 	u32 cnt;
 };
 
+#define pin_to_hwirq(r, p)	((r)->parent_base + (p) - (r)->pin_base)
+
 static DEFINE_RAW_SPINLOCK(pdc_lock);
 static void __iomem *pdc_base;
 static struct pdc_pin_region *pdc_region;
@@ -186,19 +186,17 @@ static struct irq_chip qcom_pdc_gic_chip = {
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 };
 
-static irq_hw_number_t get_parent_hwirq(int pin)
+static struct pdc_pin_region *get_pin_region(int pin)
 {
 	int i;
-	struct pdc_pin_region *region;
 
 	for (i = 0; i < pdc_region_cnt; i++) {
-		region = &pdc_region[i];
-		if (pin >= region->pin_base &&
-		    pin < region->pin_base + region->cnt)
-			return (region->parent_base + pin - region->pin_base);
+		if (pin >= pdc_region[i].pin_base &&
+		    pin < pdc_region[i].pin_base + pdc_region[i].cnt)
+			return &pdc_region[i];
 	}
 
-	return PDC_NO_PARENT_IRQ;
+	return NULL;
 }
 
 static int qcom_pdc_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
@@ -221,7 +219,8 @@ static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
 {
 	struct irq_fwspec *fwspec = data;
 	struct irq_fwspec parent_fwspec;
-	irq_hw_number_t hwirq, parent_hwirq;
+	struct pdc_pin_region *region;
+	irq_hw_number_t hwirq;
 	unsigned int type;
 	int ret;
 
@@ -234,8 +233,8 @@ static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
 	if (ret)
 		return ret;
 
-	parent_hwirq = get_parent_hwirq(hwirq);
-	if (parent_hwirq == PDC_NO_PARENT_IRQ)
+	region = get_pin_region(hwirq);
+	if (!region)
 		return irq_domain_disconnect_hierarchy(domain->parent, virq);
 
 	if (type & IRQ_TYPE_EDGE_BOTH)
@@ -247,7 +246,7 @@ static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
 	parent_fwspec.fwnode      = domain->parent->fwnode;
 	parent_fwspec.param_count = 3;
 	parent_fwspec.param[0]    = 0;
-	parent_fwspec.param[1]    = parent_hwirq;
+	parent_fwspec.param[1]    = pin_to_hwirq(region, hwirq);
 	parent_fwspec.param[2]    = type;
 
 	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
@@ -265,7 +264,8 @@ static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int virq,
 {
 	struct irq_fwspec *fwspec = data;
 	struct irq_fwspec parent_fwspec;
-	irq_hw_number_t hwirq, parent_hwirq;
+	struct pdc_pin_region *region;
+	irq_hw_number_t hwirq;
 	unsigned int type;
 	int ret;
 
@@ -281,8 +281,8 @@ static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int virq,
 	if (ret)
 		return ret;
 
-	parent_hwirq = get_parent_hwirq(hwirq);
-	if (parent_hwirq == PDC_NO_PARENT_IRQ)
+	region = get_pin_region(hwirq);
+	if (!region)
 		return irq_domain_disconnect_hierarchy(domain->parent, virq);
 
 	if (type & IRQ_TYPE_EDGE_BOTH)
@@ -294,7 +294,7 @@ static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int virq,
 	parent_fwspec.fwnode      = domain->parent->fwnode;
 	parent_fwspec.param_count = 3;
 	parent_fwspec.param[0]    = 0;
-	parent_fwspec.param[1]    = parent_hwirq;
+	parent_fwspec.param[1]    = pin_to_hwirq(region, hwirq);
 	parent_fwspec.param[2]    = type;
 
 	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
-- 
2.30.2


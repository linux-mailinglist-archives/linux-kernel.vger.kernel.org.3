Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87C54C75D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbiB1R4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239662AbiB1RxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:53:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F61AA2C8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:40:45 -0800 (PST)
Date:   Mon, 28 Feb 2022 17:40:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646070041;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kaqm2eWHBXcJPmdxh+r33qa7kCgMGlNm6QHSXbUMdi4=;
        b=ECPVP2fqMGrU3d0J/rccnwOdQrANuJx/NySspOZtXLK7CiQms0HxNP2zAWvNC/Z3HE4IZM
        cxO47gPRupXAeO1T0apSsgeX4CB2ALFYqcm8AXlEGffTlYiLRCVFwSWiMrHeWh07j6OxUi
        LtWn+2VbTXFRq7+I1c5NOHufBc7h/zYxm3L0ccRJy6bSos/kql7p7tXLVC6IPIjhb7Sx5T
        WDhfSZXWYM9ecjwg4xnA1GMvVrG9rI/q+Y59H8JAhR8A/2MyNK+lbYJnUpetRA9lxajz4k
        uEdSeUpyz9i/9CwEBmtsNrCDr/ElR0iR1p/fYfb+Uqv/5kYp/NoiB/c1PRTkig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646070041;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kaqm2eWHBXcJPmdxh+r33qa7kCgMGlNm6QHSXbUMdi4=;
        b=yW3ZadbZGVK2XvwIHmodriTAagc6bujzLd6jbgmR5xm9LtC6fTXJW3peJDiGOheppmrnSz
        T7x2slkPQ0Alr1Bg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/qcom-pdc: Kill qcom_pdc_translate helper
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220224101226.88373-4-maz@kernel.org>
References: <20220224101226.88373-4-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164607004064.16921.9532685853753758205.tip-bot2@tip-bot2>
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

Commit-ID:     af5d5d1d9f2a4a81ae26cdf3eba30248a95f3c89
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/af5d5d1d9f2a4a81ae26cdf3eba30248a95f3c89
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 24 Feb 2022 10:12:24 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 28 Feb 2022 17:32:26 

irqchip/qcom-pdc: Kill qcom_pdc_translate helper

qcom_pdc_translate() really is nothing but an open coded version
of irq_domain_translate_twocell(). Get rid of it and use the common
version instead.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220224101226.88373-4-maz@kernel.org
---
 drivers/irqchip/qcom-pdc.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 5be5314..837ca69 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -198,21 +198,6 @@ static struct pdc_pin_region *get_pin_region(int pin)
 	return NULL;
 }
 
-static int qcom_pdc_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
-			      unsigned long *hwirq, unsigned int *type)
-{
-	if (is_of_node(fwspec->fwnode)) {
-		if (fwspec->param_count != 2)
-			return -EINVAL;
-
-		*hwirq = fwspec->param[0];
-		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
 			  unsigned int nr_irqs, void *data)
 {
@@ -223,7 +208,7 @@ static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
 	unsigned int type;
 	int ret;
 
-	ret = qcom_pdc_translate(domain, fwspec, &hwirq, &type);
+	ret = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
 	if (ret)
 		return ret;
 
@@ -256,7 +241,7 @@ static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops qcom_pdc_ops = {
-	.translate	= qcom_pdc_translate,
+	.translate	= irq_domain_translate_twocell,
 	.alloc		= qcom_pdc_alloc,
 	.free		= irq_domain_free_irqs_common,
 };

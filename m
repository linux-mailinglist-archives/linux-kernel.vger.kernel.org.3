Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10144C8906
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiCAKMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiCAKMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:12:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BF48C7FD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:11:38 -0800 (PST)
Date:   Tue, 01 Mar 2022 10:11:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646129496;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bBW85SkoKW8LZQ3Vt6Qb3JNy5V2ECTgSRgGhhsQSvYY=;
        b=h7FoI1cxUuw7kB5OvX0nQ3t4clx2LpISlmJdaBAS9MfsxKjLyDuyCZL0404ZxumspueBbs
        dTOmlm6RPkFvV/jOqib5oeqYDdkRJMTpFZ1rR8KujkOvur1turl9Hi45abDKRbtCOogaXL
        Tw9jwZ7BH3QgH/EVyJNjQefwOUrtRZLOUlBn1Ag2TTfFmz/uPjqjmThATuCXIRBhedHcNw
        kEG26TknHKEECxe9UejIy8Ib/h+i1Mli3x0kzUIr6XHSQyocriw1EimTzqrHw7KwAG4K4m
        UlRX9xm90INTbHbwwV7zNzbnjSAOmBwsall9f9tk1DTRj8QP8p3FRYSK7gLn4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646129496;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bBW85SkoKW8LZQ3Vt6Qb3JNy5V2ECTgSRgGhhsQSvYY=;
        b=hTe4ovJyjsVVy71IXzxy+ndqnd1GFEUGs+YAmPPtL9n/LwIt3aTK33jUSAMjq7fCpYefFF
        Ml46aTjvdShSAWBw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/qcom-pdc: Kill qcom_pdc_translate helper
Cc:     Marc Zyngier <maz@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>, tglx@linutronix.de
In-Reply-To: <20220224101226.88373-4-maz@kernel.org>
References: <20220224101226.88373-4-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164612949579.16921.6842959382902482473.tip-bot2@tip-bot2>
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

Commit-ID:     d494d088ac44b9cf561362a7856fa20b656be64f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d494d088ac44b9cf561362a7856fa20b656be64f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 24 Feb 2022 10:12:24 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 01 Mar 2022 10:06:24 

irqchip/qcom-pdc: Kill qcom_pdc_translate helper

qcom_pdc_translate() really is nothing but an open coded version
of irq_domain_translate_twocell(). Get rid of it and use the common
version instead.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Maulik Shah <quic_mkshah@quicinc.com>
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

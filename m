Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252AD46ECB4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbhLIQLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:11:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40094 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhLIQKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:41 -0500
Date:   Thu, 09 Dec 2021 16:07:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GT8SToI6db+nOOVHVPsGM+Gf5D2HgVmhnLomWJa+9g=;
        b=C4q3wb9x3ElCZppQaZPfefoY+baaiaxw4xWVi8H7G/0+bj2eVvsJkmSSZZdwh/72GF94Ho
        DmR+aUd8rZCU2GHNHxisv7qXe09S0bfRoXChHXdhTdRXbBQotEd0X6cRDXtZOPRYnvYFST
        is1DwOXO0ErMXSDc9qyZphgEbaeIexqLjSxrP27lq5+rHfti9M+z8bzwe/0wI1YaI/i2Cc
        02EIC1t+Khrk3gYkNzTkOOqS5M6oKDtKGRLcrvNT8GAP6flcV5v5mtp2D9BUNSscX3A02D
        i05o2Cs5dBDi1vPLvQbUPuzlAuiIKZLZ0pLJ4B313Cyj2zo8TLiz7baaJnCcgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GT8SToI6db+nOOVHVPsGM+Gf5D2HgVmhnLomWJa+9g=;
        b=Jr+gNckcHTpBX/4EsckfUHs9/2c6IyTNLiixtw8F7dSRqre2NOhW3vOcfCiduhmH+KgVPp
        /iVv2bmK9x9BUsDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] x86/hyperv: Refactor hv_msi_domain_free_irqs()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>, Wei Liu <wei.liu@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211206210224.429625690@linutronix.de>
References: <20211206210224.429625690@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906602627.11128.7459864705573232443.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     1982afd6c0582c523970f5426cc1f11ef8ead7bd
Gitweb:        https://git.kernel.org/tip/1982afd6c0582c523970f5426cc1f11ef8ead7bd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:21 +01:00

x86/hyperv: Refactor hv_msi_domain_free_irqs()

No point in looking up things over and over. Just look up the associated
irq data and work from there.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Link: https://lore.kernel.org/r/20211206210224.429625690@linutronix.de

---
 arch/x86/hyperv/irqdomain.c | 55 +++++++++++-------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 514fc64..7e0f6be 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -253,64 +253,43 @@ static int hv_unmap_msi_interrupt(struct pci_dev *dev, struct hv_interrupt_entry
 	return hv_unmap_interrupt(hv_build_pci_dev_id(dev).as_uint64, old_entry);
 }
 
-static void hv_teardown_msi_irq_common(struct pci_dev *dev, struct msi_desc *msidesc, int irq)
+static void hv_teardown_msi_irq(struct pci_dev *dev, struct irq_data *irqd)
 {
-	u64 status;
 	struct hv_interrupt_entry old_entry;
-	struct irq_desc *desc;
-	struct irq_data *data;
 	struct msi_msg msg;
+	u64 status;
 
-	desc = irq_to_desc(irq);
-	if (!desc) {
-		pr_debug("%s: no irq desc\n", __func__);
-		return;
-	}
-
-	data = &desc->irq_data;
-	if (!data) {
-		pr_debug("%s: no irq data\n", __func__);
-		return;
-	}
-
-	if (!data->chip_data) {
+	if (!irqd->chip_data) {
 		pr_debug("%s: no chip data\n!", __func__);
 		return;
 	}
 
-	old_entry = *(struct hv_interrupt_entry *)data->chip_data;
+	old_entry = *(struct hv_interrupt_entry *)irqd->chip_data;
 	entry_to_msi_msg(&old_entry, &msg);
 
-	kfree(data->chip_data);
-	data->chip_data = NULL;
+	kfree(irqd->chip_data);
+	irqd->chip_data = NULL;
 
 	status = hv_unmap_msi_interrupt(dev, &old_entry);
 
-	if (status != HV_STATUS_SUCCESS) {
+	if (status != HV_STATUS_SUCCESS)
 		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
-		return;
-	}
 }
 
-static void hv_msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+static void hv_msi_free_irq(struct irq_domain *domain,
+			    struct msi_domain_info *info, unsigned int virq)
 {
-	int i;
-	struct msi_desc *entry;
-	struct pci_dev *pdev;
+	struct irq_data *irqd = irq_get_irq_data(virq);
+	struct msi_desc *desc;
 
-	if (WARN_ON_ONCE(!dev_is_pci(dev)))
+	if (!irqd)
 		return;
 
-	pdev = to_pci_dev(dev);
+	desc = irq_data_get_msi_desc(irqd);
+	if (!desc || !desc->irq || WARN_ON_ONCE(!dev_is_pci(desc->dev)))
+		return;
 
-	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->irq) {
-			for (i = 0; i < entry->nvec_used; i++) {
-				hv_teardown_msi_irq_common(pdev, entry, entry->irq + i);
-				irq_domain_free_irqs(entry->irq + i, 1);
-			}
-		}
-	}
+	hv_teardown_msi_irq(to_pci_dev(desc->dev), irqd);
 }
 
 /*
@@ -329,7 +308,7 @@ static struct irq_chip hv_pci_msi_controller = {
 };
 
 static struct msi_domain_ops pci_msi_domain_ops = {
-	.domain_free_irqs	= hv_msi_domain_free_irqs,
+	.msi_free		= hv_msi_free_irq,
 	.msi_prepare		= pci_msi_prepare,
 };
 

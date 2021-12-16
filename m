Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26D2477F52
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242659AbhLPVmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242004AbhLPVlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F827C06175B;
        Thu, 16 Dec 2021 13:40:42 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:40:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WYWHQGKiQOFIDQ6lnL4KVWs3PxSo9uzYPRtrz25eAeo=;
        b=RHY1CdV84K54/wgm0kSD9Vqq8GSmI2Q6cZ5AybXJyN/lWSsyXCRymIoz5keQfr3p6SevYJ
        qe+BuSDOlUgAnb9AL5M3XJMbePEfW3MpCLu0k2BRCVuwCSP9O1OkRsOU09TE4drw/LvBO/
        HNFb3wOOHQEwcFrlZsYL7v00nl/22Mc8HbWwaKP8odz+L4bUOEgOOmLdwP1YRZ8wmV6+Rg
        7CWreWTOjHuXVuy0XS+gb2EKO48kFnrKgpNGFzL69Fw4+Xi7GDxZd1Qrsd160LWTtwJMt0
        VgoKSI+5EUJ68MLLLS4iE47mh4anGwSnHUrPNxLU/SrgJAdCDybfIDwilF1LNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WYWHQGKiQOFIDQ6lnL4KVWs3PxSo9uzYPRtrz25eAeo=;
        b=7UurfSTs7r/4tFMxFRvWD8VXLz/F30CnIga5TzKPmXUPEbU220ASX6G44fAreWJLNa25d/
        yDFkqKpgVIhb//DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Protect MSI operations
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210747.982292705@linutronix.de>
References: <20211206210747.982292705@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969083980.23020.1709707505861502651.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     5512c5eaf533a98d33a8dc0dcf415e72773184c8
Gitweb:        https://git.kernel.org/tip/5512c5eaf533a98d33a8dc0dcf415e72773184c8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:17 +01:00

PCI/MSI: Protect MSI operations

To prepare for dynamic extension of MSI-X vectors, protect the MSI
operations for MSI and MSI-X. This requires to move the invocation of
irq_create_affinity_masks() out of the descriptor lock section to avoid
reverse lock ordering vs. CPU hotplug lock as some callers of the PCI/MSI
allocation interfaces already hold it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211206210747.982292705@linutronix.de

---
 drivers/pci/msi/irqdomain.c |   4 +-
 drivers/pci/msi/msi.c       | 100 +++++++++++++++++++++--------------
 2 files changed, 63 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 180b2a1..c81793a 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -14,7 +14,7 @@ int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 	domain = dev_get_msi_domain(&dev->dev);
 	if (domain && irq_domain_is_hierarchy(domain))
-		return msi_domain_alloc_irqs(domain, &dev->dev, nvec);
+		return msi_domain_alloc_irqs_descs_locked(domain, &dev->dev, nvec);
 
 	return pci_msi_legacy_setup_msi_irqs(dev, nvec, type);
 }
@@ -25,7 +25,7 @@ void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 
 	domain = dev_get_msi_domain(&dev->dev);
 	if (domain && irq_domain_is_hierarchy(domain))
-		msi_domain_free_irqs(domain, &dev->dev);
+		msi_domain_free_irqs_descs_locked(domain, &dev->dev);
 	else
 		pci_msi_legacy_teardown_msi_irqs(dev);
 }
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 0909b27..c9a03f9 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -320,11 +320,13 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 
 	write_msg = arch_restore_msi_irqs(dev);
 
+	msi_lock_descs(&dev->dev);
 	for_each_pci_msi_entry(entry, dev) {
 		if (write_msg)
 			__pci_write_msi_msg(entry, &entry->msg);
 		pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
 	}
+	msi_unlock_descs(&dev->dev);
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
@@ -375,19 +377,15 @@ static int pci_setup_msi_context(struct pci_dev *dev)
 }
 
 static struct msi_desc *
-msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
+msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity_desc *masks)
 {
-	struct irq_affinity_desc *masks = NULL;
 	struct msi_desc *entry;
 	u16 control;
 
-	if (affd)
-		masks = irq_create_affinity_masks(nvec, affd);
-
 	/* MSI Entry Initialization */
 	entry = alloc_msi_entry(&dev->dev, nvec, masks);
 	if (!entry)
-		goto out;
+		return NULL;
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
 	/* Lies, damned lies, and MSIs */
@@ -410,8 +408,7 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 	if (entry->pci.msi_attrib.can_mask)
 		pci_read_config_dword(dev, entry->pci.mask_pos, &entry->pci.msi_mask);
 
-out:
-	kfree(masks);
+
 	return entry;
 }
 
@@ -447,6 +444,7 @@ static int msi_verify_entries(struct pci_dev *dev)
 static int msi_capability_init(struct pci_dev *dev, int nvec,
 			       struct irq_affinity *affd)
 {
+	struct irq_affinity_desc *masks = NULL;
 	struct msi_desc *entry;
 	int ret;
 
@@ -457,7 +455,11 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	pci_msi_set_enable(dev, 0);
 	dev->msi_enabled = 1;
 
-	entry = msi_setup_entry(dev, nvec, affd);
+	if (affd)
+		masks = irq_create_affinity_masks(nvec, affd);
+
+	msi_lock_descs(&dev->dev);
+	entry = msi_setup_entry(dev, nvec, masks);
 	if (!entry) {
 		ret = -ENOMEM;
 		goto fail;
@@ -483,13 +485,16 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 
 	pcibios_free_irq(dev);
 	dev->irq = entry->irq;
-	return 0;
+	goto unlock;
 
 err:
 	pci_msi_unmask(entry, msi_multi_mask(entry));
 	free_msi_irqs(dev);
 fail:
 	dev->msi_enabled = 0;
+unlock:
+	msi_unlock_descs(&dev->dev);
+	kfree(masks);
 	return ret;
 }
 
@@ -516,23 +521,18 @@ static void __iomem *msix_map_region(struct pci_dev *dev,
 
 static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			      struct msix_entry *entries, int nvec,
-			      struct irq_affinity *affd)
+			      struct irq_affinity_desc *masks)
 {
-	struct irq_affinity_desc *curmsk, *masks = NULL;
+	int i, vec_count = pci_msix_vec_count(dev);
+	struct irq_affinity_desc *curmsk;
 	struct msi_desc *entry;
 	void __iomem *addr;
-	int ret, i;
-	int vec_count = pci_msix_vec_count(dev);
-
-	if (affd)
-		masks = irq_create_affinity_masks(nvec, affd);
 
 	for (i = 0, curmsk = masks; i < nvec; i++) {
 		entry = alloc_msi_entry(&dev->dev, 1, curmsk);
 		if (!entry) {
 			/* No enough memory. Don't try again */
-			ret = -ENOMEM;
-			goto out;
+			return -ENOMEM;
 		}
 
 		entry->pci.msi_attrib.is_msix	= 1;
@@ -560,10 +560,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 		if (masks)
 			curmsk++;
 	}
-	ret = 0;
-out:
-	kfree(masks);
-	return ret;
+	return 0;
 }
 
 static void msix_update_entries(struct pci_dev *dev, struct msix_entry *entries)
@@ -590,6 +587,41 @@ static void msix_mask_all(void __iomem *base, int tsize)
 		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
 
+static int msix_setup_interrupts(struct pci_dev *dev, void __iomem *base,
+				 struct msix_entry *entries, int nvec,
+				 struct irq_affinity *affd)
+{
+	struct irq_affinity_desc *masks = NULL;
+	int ret;
+
+	if (affd)
+		masks = irq_create_affinity_masks(nvec, affd);
+
+	msi_lock_descs(&dev->dev);
+	ret = msix_setup_entries(dev, base, entries, nvec, masks);
+	if (ret)
+		goto out_free;
+
+	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
+	if (ret)
+		goto out_free;
+
+	/* Check if all MSI entries honor device restrictions */
+	ret = msi_verify_entries(dev);
+	if (ret)
+		goto out_free;
+
+	msix_update_entries(dev, entries);
+	goto out_unlock;
+
+out_free:
+	free_msi_irqs(dev);
+out_unlock:
+	msi_unlock_descs(&dev->dev);
+	kfree(masks);
+	return ret;
+}
+
 /**
  * msix_capability_init - configure device's MSI-X capability
  * @dev: pointer to the pci_dev data structure of MSI-X device function
@@ -630,20 +662,9 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 
 	dev->msix_base = base;
 
-	ret = msix_setup_entries(dev, base, entries, nvec, affd);
+	ret = msix_setup_interrupts(dev, base, entries, nvec, affd);
 	if (ret)
-		goto out_free;
-
-	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
-	if (ret)
-		goto out_free;
-
-	/* Check if all MSI entries honor device restrictions */
-	ret = msi_verify_entries(dev);
-	if (ret)
-		goto out_free;
-
-	msix_update_entries(dev, entries);
+		goto out_disable;
 
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
@@ -662,9 +683,6 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	pcibios_free_irq(dev);
 	return 0;
 
-out_free:
-	free_msi_irqs(dev);
-
 out_disable:
 	dev->msix_enabled = 0;
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE, 0);
@@ -773,8 +791,10 @@ void pci_disable_msi(struct pci_dev *dev)
 	if (!pci_msi_enable || !dev || !dev->msi_enabled)
 		return;
 
+	msi_lock_descs(&dev->dev);
 	pci_msi_shutdown(dev);
 	free_msi_irqs(dev);
+	msi_unlock_descs(&dev->dev);
 }
 EXPORT_SYMBOL(pci_disable_msi);
 
@@ -860,8 +880,10 @@ void pci_disable_msix(struct pci_dev *dev)
 	if (!pci_msi_enable || !dev || !dev->msix_enabled)
 		return;
 
+	msi_lock_descs(&dev->dev);
 	pci_msix_shutdown(dev);
 	free_msi_irqs(dev);
+	msi_unlock_descs(&dev->dev);
 }
 EXPORT_SYMBOL(pci_disable_msix);
 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA48477F32
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242301AbhLPVlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbhLPVkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE07C061751;
        Thu, 16 Dec 2021 13:40:41 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:40:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYGsgTJC9nArnHdMfGmXATyZJNDFiY8SNNDV76l2NDk=;
        b=0O0b5TKeLTJudxeQfXilsnCf/j/jqxEmima4K5GsMeqa11nrRmPyzzMGXPA0w0S+R79HKe
        B2KrvK1sJhAScD/Mj5hMQafE79yg7Avm9/gZ0695jrcrV85QHR1GVFpoZt82pmPw/yFThB
        +zgUTp18bA/dnv8QkG1LbGd0TfTvSa+1FwcxQKbXfHhUpGKppdNrfcymDIZA8DAPgoXvvy
        7dVAQYUnavSUa45hhm5TySmbKtbfUn34iuZzgPCm8hh5R6wLlIQi7kvydT/ojcTUf/1qjz
        cypu6QMl/kknGDyfUBKze/57ZCYgHGan1IPZfucadRbvrTX/GFztju70I+MSrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYGsgTJC9nArnHdMfGmXATyZJNDFiY8SNNDV76l2NDk=;
        b=UFENEms/LDGGso0LzaPsN0aSiEPTVZweBsyiBmVDEzuzzmIX1kaLBzXe17k3hznvK+OeF3
        NdiGeQrHXrdaB6Dw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Use msi_add_msi_desc()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210748.035348646@linutronix.de>
References: <20211206210748.035348646@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969083904.23020.17702666548705646068.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     71020a3c0dff4a00d96922a4a95a067f524a7dcb
Gitweb:        https://git.kernel.org/tip/71020a3c0dff4a00d96922a4a95a067f524a7dcb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:17 +01:00

PCI/MSI: Use msi_add_msi_desc()

Simplify the allocation of MSI descriptors by using msi_add_msi_desc()
which moves the storage handling to core code and prepares for dynamic
extension of the MSI-X vector space.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211206210748.035348646@linutronix.de

---
 drivers/pci/msi/msi.c | 104 ++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 57 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index c9a03f9..4ee47ee 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -376,40 +376,41 @@ static int pci_setup_msi_context(struct pci_dev *dev)
 	return ret;
 }
 
-static struct msi_desc *
-msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity_desc *masks)
+static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
+			      struct irq_affinity_desc *masks)
 {
-	struct msi_desc *entry;
+	struct msi_desc desc;
 	u16 control;
 
 	/* MSI Entry Initialization */
-	entry = alloc_msi_entry(&dev->dev, nvec, masks);
-	if (!entry)
-		return NULL;
+	memset(&desc, 0, sizeof(desc));
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
 	/* Lies, damned lies, and MSIs */
 	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
 		control |= PCI_MSI_FLAGS_MASKBIT;
+	/* Respect XEN's mask disabling */
+	if (pci_msi_ignore_mask)
+		control &= ~PCI_MSI_FLAGS_MASKBIT;
 
-	entry->pci.msi_attrib.is_64	= !!(control & PCI_MSI_FLAGS_64BIT);
-	entry->pci.msi_attrib.can_mask	= !pci_msi_ignore_mask &&
-					  !!(control & PCI_MSI_FLAGS_MASKBIT);
-	entry->pci.msi_attrib.default_irq = dev->irq;
-	entry->pci.msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
-	entry->pci.msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
+	desc.nvec_used			= nvec;
+	desc.pci.msi_attrib.is_64	= !!(control & PCI_MSI_FLAGS_64BIT);
+	desc.pci.msi_attrib.can_mask	= !!(control & PCI_MSI_FLAGS_MASKBIT);
+	desc.pci.msi_attrib.default_irq	= dev->irq;
+	desc.pci.msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
+	desc.pci.msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
+	desc.affinity			= masks;
 
 	if (control & PCI_MSI_FLAGS_64BIT)
-		entry->pci.mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
+		desc.pci.mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
 	else
-		entry->pci.mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
+		desc.pci.mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
 
 	/* Save the initial mask status */
-	if (entry->pci.msi_attrib.can_mask)
-		pci_read_config_dword(dev, entry->pci.mask_pos, &entry->pci.msi_mask);
-
+	if (desc.pci.msi_attrib.can_mask)
+		pci_read_config_dword(dev, desc.pci.mask_pos, &desc.pci.msi_mask);
 
-	return entry;
+	return msi_add_msi_desc(&dev->dev, &desc);
 }
 
 static int msi_verify_entries(struct pci_dev *dev)
@@ -459,17 +460,14 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 		masks = irq_create_affinity_masks(nvec, affd);
 
 	msi_lock_descs(&dev->dev);
-	entry = msi_setup_entry(dev, nvec, masks);
-	if (!entry) {
-		ret = -ENOMEM;
+	ret = msi_setup_msi_desc(dev, nvec, masks);
+	if (ret)
 		goto fail;
-	}
 
 	/* All MSIs are unmasked by default; mask them all */
+	entry = first_pci_msi_entry(dev);
 	pci_msi_mask(entry, msi_multi_mask(entry));
 
-	list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
-
 	/* Configure MSI capability structure */
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
 	if (ret)
@@ -519,48 +517,40 @@ static void __iomem *msix_map_region(struct pci_dev *dev,
 	return ioremap(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
 }
 
-static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
-			      struct msix_entry *entries, int nvec,
-			      struct irq_affinity_desc *masks)
+static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
+				struct msix_entry *entries, int nvec,
+				struct irq_affinity_desc *masks)
 {
-	int i, vec_count = pci_msix_vec_count(dev);
+	int ret = 0, i, vec_count = pci_msix_vec_count(dev);
 	struct irq_affinity_desc *curmsk;
-	struct msi_desc *entry;
+	struct msi_desc desc;
 	void __iomem *addr;
 
-	for (i = 0, curmsk = masks; i < nvec; i++) {
-		entry = alloc_msi_entry(&dev->dev, 1, curmsk);
-		if (!entry) {
-			/* No enough memory. Don't try again */
-			return -ENOMEM;
-		}
-
-		entry->pci.msi_attrib.is_msix	= 1;
-		entry->pci.msi_attrib.is_64	= 1;
+	memset(&desc, 0, sizeof(desc));
 
-		if (entries)
-			entry->msi_index = entries[i].entry;
-		else
-			entry->msi_index = i;
+	desc.nvec_used			= 1;
+	desc.pci.msi_attrib.is_msix	= 1;
+	desc.pci.msi_attrib.is_64	= 1;
+	desc.pci.msi_attrib.default_irq	= dev->irq;
+	desc.pci.mask_base		= base;
 
-		entry->pci.msi_attrib.is_virtual = entry->msi_index >= vec_count;
+	for (i = 0, curmsk = masks; i < nvec; i++, curmsk++) {
+		desc.msi_index = entries ? entries[i].entry : i;
+		desc.affinity = masks ? curmsk : NULL;
+		desc.pci.msi_attrib.is_virtual = desc.msi_index >= vec_count;
+		desc.pci.msi_attrib.can_mask = !pci_msi_ignore_mask &&
+					       !desc.pci.msi_attrib.is_virtual;
 
-		entry->pci.msi_attrib.can_mask	= !pci_msi_ignore_mask &&
-						  !entry->pci.msi_attrib.is_virtual;
-
-		entry->pci.msi_attrib.default_irq	= dev->irq;
-		entry->pci.mask_base			= base;
-
-		if (entry->pci.msi_attrib.can_mask) {
-			addr = pci_msix_desc_addr(entry);
-			entry->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+		if (!desc.pci.msi_attrib.can_mask) {
+			addr = pci_msix_desc_addr(&desc);
+			desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 		}
 
-		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
-		if (masks)
-			curmsk++;
+		ret = msi_add_msi_desc(&dev->dev, &desc);
+		if (ret)
+			break;
 	}
-	return 0;
+	return ret;
 }
 
 static void msix_update_entries(struct pci_dev *dev, struct msix_entry *entries)
@@ -598,7 +588,7 @@ static int msix_setup_interrupts(struct pci_dev *dev, void __iomem *base,
 		masks = irq_create_affinity_masks(nvec, affd);
 
 	msi_lock_descs(&dev->dev);
-	ret = msix_setup_entries(dev, base, entries, nvec, masks);
+	ret = msix_setup_msi_descs(dev, base, entries, nvec, masks);
 	if (ret)
 		goto out_free;
 

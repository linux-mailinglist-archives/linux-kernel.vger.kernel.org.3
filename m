Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAF0477F71
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242447AbhLPVnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242216AbhLPVlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372EFC0613A1;
        Thu, 16 Dec 2021 13:40:58 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:40:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XLJSRdxs+2mKCOLV4cOiDhJsbEfjvf5dNRV7zbQ1THk=;
        b=JH7T8aP/pWQqbjpuDhjYy1HjCn+Uw2NA+hAL3w2AlFPuP2Y7vCrbL/Dmrum2VkGBco3MTY
        LbyyC0EglOBZ8D5v+JXsHPjAxlJxgEEXmsEVjxfrW4MtaKGqhcbEgHY20ql8VzhZG4WsXb
        id91Rn/Vg1bLftFVdZp7zdIlaoqoc9urSy1zVuFiZ/pPZmGEvv0ziBnsyfeWId2eH/+w8F
        PvJw3/Fg//RqwBLbs/YeqiCw8TtJ2QTNpImvHv64FZBA0uXxuKP6J6zj2kBgHqYdPYUD6x
        P7pg1EjzvZPa3aSIdiTndOy1lcei9sQP08TEUNOmFBgES4/BUgZwAwBoADBTMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XLJSRdxs+2mKCOLV4cOiDhJsbEfjvf5dNRV7zbQ1THk=;
        b=z6HiHGKLqx3i8dQnFZjfTxvpip9JajjlyHTb75BGTzAtOoBQkhZeFXmpmqLWCH1HfTeacQ
        w+S9/8G8t+1sJsBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Use msi_desc::msi_index
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221814.602911509@linutronix.de>
References: <20211210221814.602911509@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969085573.23020.1373209940188584221.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     173ffad79d177d9a91fbf3be6bf67ca81e0f765a
Gitweb:        https://git.kernel.org/tip/173ffad79d177d9a91fbf3be6bf67ca81e0f765a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:40 +01:00

PCI/MSI: Use msi_desc::msi_index

The usage of msi_desc::pci::entry_nr is confusing at best. It's the index
into the MSI[X] descriptor table.

Use msi_desc::msi_index which is shared between all MSI incarnations
instead of having a PCI specific storage for no value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211210221814.602911509@linutronix.de


---
 arch/powerpc/platforms/pseries/msi.c |  4 ++--
 arch/x86/pci/xen.c                   |  2 +-
 drivers/pci/msi/irqdomain.c          |  2 +-
 drivers/pci/msi/msi.c                | 20 ++++++++------------
 drivers/pci/xen-pcifront.c           |  2 +-
 include/linux/msi.h                  |  2 --
 6 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index dc8cf36..27cd1fb 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -332,7 +332,7 @@ static int check_msix_entries(struct pci_dev *pdev)
 
 	expected = 0;
 	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->pci.msi_attrib.entry_nr != expected) {
+		if (entry->msi_index != expected) {
 			pr_debug("rtas_msi: bad MSI-X entries.\n");
 			return -EINVAL;
 		}
@@ -579,7 +579,7 @@ static int pseries_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 	int hwirq;
 	int i, ret;
 
-	hwirq = rtas_query_irq_number(pci_get_pdn(pdev), desc->pci.msi_attrib.entry_nr);
+	hwirq = rtas_query_irq_number(pci_get_pdn(pdev), desc->msi_index);
 	if (hwirq < 0) {
 		dev_err(&pdev->dev, "Failed to query HW IRQ: %d\n", hwirq);
 		return hwirq;
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index bfd87b4..ded0320 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -306,7 +306,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 				return -EINVAL;
 
 			map_irq.table_base = pci_resource_start(dev, bir);
-			map_irq.entry_nr = msidesc->pci.msi_attrib.entry_nr;
+			map_irq.entry_nr = msidesc->msi_index;
 		}
 
 		ret = -EINVAL;
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 26b23a1..4224202 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -57,7 +57,7 @@ static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(desc);
 
-	return (irq_hw_number_t)desc->pci.msi_attrib.entry_nr |
+	return (irq_hw_number_t)desc->msi_index |
 		pci_dev_id(dev) << 11 |
 		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
 }
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 76c15be..8fb4dd2 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -44,7 +44,7 @@ static inline void pci_msi_unmask(struct msi_desc *desc, u32 mask)
 
 static inline void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
 {
-	return desc->pci.mask_base + desc->pci.msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
+	return desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE;
 }
 
 /*
@@ -394,13 +394,10 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
 		control |= PCI_MSI_FLAGS_MASKBIT;
 
-	entry->pci.msi_attrib.is_msix	= 0;
-	entry->pci.msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
-	entry->pci.msi_attrib.is_virtual    = 0;
-	entry->pci.msi_attrib.entry_nr	= 0;
+	entry->pci.msi_attrib.is_64	= !!(control & PCI_MSI_FLAGS_64BIT);
 	entry->pci.msi_attrib.can_mask	= !pci_msi_ignore_mask &&
 					  !!(control & PCI_MSI_FLAGS_MASKBIT);
-	entry->pci.msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
+	entry->pci.msi_attrib.default_irq = dev->irq;
 	entry->pci.msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
 	entry->pci.msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
 
@@ -542,12 +539,11 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 		entry->pci.msi_attrib.is_64	= 1;
 
 		if (entries)
-			entry->pci.msi_attrib.entry_nr = entries[i].entry;
+			entry->msi_index = entries[i].entry;
 		else
-			entry->pci.msi_attrib.entry_nr = i;
+			entry->msi_index = i;
 
-		entry->pci.msi_attrib.is_virtual =
-			entry->pci.msi_attrib.entry_nr >= vec_count;
+		entry->pci.msi_attrib.is_virtual = entry->msi_index >= vec_count;
 
 		entry->pci.msi_attrib.can_mask	= !pci_msi_ignore_mask &&
 						  !entry->pci.msi_attrib.is_virtual;
@@ -1088,7 +1084,7 @@ int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 		struct msi_desc *entry;
 
 		for_each_pci_msi_entry(entry, dev) {
-			if (entry->pci.msi_attrib.entry_nr == nr)
+			if (entry->msi_index == nr)
 				return entry->irq;
 		}
 		WARN_ON_ONCE(1);
@@ -1127,7 +1123,7 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 		struct msi_desc *entry;
 
 		for_each_pci_msi_entry(entry, dev) {
-			if (entry->pci.msi_attrib.entry_nr == nr)
+			if (entry->msi_index == nr)
 				return &entry->affinity->mask;
 		}
 		WARN_ON_ONCE(1);
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 699cc95..bacf511 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -263,7 +263,7 @@ static int pci_frontend_enable_msix(struct pci_dev *dev,
 
 	i = 0;
 	for_each_pci_msi_entry(entry, dev) {
-		op.msix_entries[i].entry = entry->pci.msi_attrib.entry_nr;
+		op.msix_entries[i].entry = entry->msi_index;
 		/* Vector is useless at this point. */
 		op.msix_entries[i].vector = -1;
 		i++;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 45ec5d0..b3d3b0b 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -80,7 +80,6 @@ typedef void (*irq_write_msi_msg_t)(struct msi_desc *desc,
  * @multi_cap:	[PCI MSI/X] log2 num of messages supported
  * @can_mask:	[PCI MSI/X] Masking supported?
  * @is_64:	[PCI MSI/X] Address size: 0=32bit 1=64bit
- * @entry_nr:	[PCI MSI/X] Entry which is described by this descriptor
  * @default_irq:[PCI MSI/X] The default pre-assigned non-MSI irq
  * @mask_pos:	[PCI MSI]   Mask register position
  * @mask_base:	[PCI MSI-X] Mask register base address
@@ -97,7 +96,6 @@ struct pci_msi_desc {
 		u8	can_mask	: 1;
 		u8	is_64		: 1;
 		u8	is_virtual	: 1;
-		u16	entry_nr;
 		unsigned default_irq;
 	} msi_attrib;
 	union {

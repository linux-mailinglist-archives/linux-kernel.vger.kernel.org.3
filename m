Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FAF46ECB2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbhLIQLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:11:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40098 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240873AbhLIQKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:42 -0500
Date:   Thu, 09 Dec 2021 16:07:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6RMa+eY9wIc0wufrHGbhWvVOV3sSOCCf4kZVrFi2SUI=;
        b=EvqRt3Fv2s8oSZyW10ux/8FXZpgF+ms7aj7mHV3F73RDonM2MPYYIxA5ULqFhId9bH06SA
        qr/vu4XA5EAdCap/3O47efGyIKPNglKtYDkx9jmkxUlWaACbFSFI0zBng8FAJeTQ/VGfvs
        I/AhrvyAl+p9p4e/J+tkAMx3BgAttdffu/Sg7fmN9NNsUQgDISnbx7dbcN4SlyqzYvhwN1
        +qributm82+I/eMDaNWihV5C0Os96ri/ZtXpclMyQYdDTNaKnkXpOoIMpC/vUStrnl+9V6
        kRzx6mEdRErlOdfkvUdD8Hlmj+JmT6H8m/H976arm6snB6k9NQuEVCSJIxQutw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6RMa+eY9wIc0wufrHGbhWvVOV3sSOCCf4kZVrFi2SUI=;
        b=8D8vV01YkYz//kkFXo8vWQnrowG5t745gyfyvDorJkOWGRwv7WDCsfN3TFPYZwJ5F8evBT
        9/bAr03ggnYkPBBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi, treewide: Use a named struct for PCI/MSI
 attributes
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210224.374863119@linutronix.de>
References: <20211206210224.374863119@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906602698.11128.12478760807533350248.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     e58f2259b91c02974c20db7b28d39d810a21249b
Gitweb:        https://git.kernel.org/tip/e58f2259b91c02974c20db7b28d39d810a21249b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:21 +01:00

genirq/msi, treewide: Use a named struct for PCI/MSI attributes

The unnamed struct sucks and is in the way of further cleanups. Stick the
PCI related MSI data into a real data structure and cleanup all users.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20211206210224.374863119@linutronix.de

---
 arch/powerpc/platforms/cell/axon_msi.c    |   2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |   4 +-
 arch/powerpc/platforms/pseries/msi.c      |   6 +-
 arch/sparc/kernel/pci_msi.c               |   4 +-
 arch/x86/kernel/apic/msi.c                |   2 +-
 arch/x86/pci/xen.c                        |   6 +-
 drivers/net/wireless/ath/ath11k/pci.c     |   2 +-
 drivers/pci/msi.c                         | 116 ++++++++++-----------
 drivers/pci/xen-pcifront.c                |   2 +-
 include/linux/msi.h                       |  84 +++++++--------
 kernel/irq/msi.c                          |   4 +-
 11 files changed, 115 insertions(+), 117 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 82335e3..79e2112 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -212,7 +212,7 @@ static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
 	entry = first_pci_msi_entry(dev);
 
 	for (; dn; dn = of_get_next_parent(dn)) {
-		if (entry->msi_attrib.is_64) {
+		if (entry->pci.msi_attrib.is_64) {
 			prop = of_get_property(dn, "msi-address-64", &len);
 			if (prop)
 				break;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 004cd6a..8913c86 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2154,10 +2154,10 @@ static void pnv_msi_compose_msg(struct irq_data *d, struct msi_msg *msg)
 	int rc;
 
 	rc = __pnv_pci_ioda_msi_setup(phb, pdev, d->hwirq,
-				      entry->msi_attrib.is_64, msg);
+				      entry->pci.msi_attrib.is_64, msg);
 	if (rc)
 		dev_err(&pdev->dev, "Failed to setup %s-bit MSI #%ld : %d\n",
-			entry->msi_attrib.is_64 ? "64" : "32", d->hwirq, rc);
+			entry->pci.msi_attrib.is_64 ? "64" : "32", d->hwirq, rc);
 }
 
 /*
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 8627362..8e28720 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -332,7 +332,7 @@ static int check_msix_entries(struct pci_dev *pdev)
 
 	expected = 0;
 	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->msi_attrib.entry_nr != expected) {
+		if (entry->pci.msi_attrib.entry_nr != expected) {
 			pr_debug("rtas_msi: bad MSI-X entries.\n");
 			return -EINVAL;
 		}
@@ -449,7 +449,7 @@ static int pseries_msi_ops_prepare(struct irq_domain *domain, struct device *dev
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct msi_desc *desc = first_pci_msi_entry(pdev);
-	int type = desc->msi_attrib.is_msix ? PCI_CAP_ID_MSIX : PCI_CAP_ID_MSI;
+	int type = desc->pci.msi_attrib.is_msix ? PCI_CAP_ID_MSIX : PCI_CAP_ID_MSI;
 
 	return rtas_prepare_msi_irqs(pdev, nvec, type, arg);
 }
@@ -580,7 +580,7 @@ static int pseries_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 	int hwirq;
 	int i, ret;
 
-	hwirq = rtas_query_irq_number(pci_get_pdn(pdev), desc->msi_attrib.entry_nr);
+	hwirq = rtas_query_irq_number(pci_get_pdn(pdev), desc->pci.msi_attrib.entry_nr);
 	if (hwirq < 0) {
 		dev_err(&pdev->dev, "Failed to query HW IRQ: %d\n", hwirq);
 		return hwirq;
diff --git a/arch/sparc/kernel/pci_msi.c b/arch/sparc/kernel/pci_msi.c
index fb5899c..9ed1198 100644
--- a/arch/sparc/kernel/pci_msi.c
+++ b/arch/sparc/kernel/pci_msi.c
@@ -146,13 +146,13 @@ static int sparc64_setup_msi_irq(unsigned int *irq_p,
 	msiqid = pick_msiq(pbm);
 
 	err = ops->msi_setup(pbm, msiqid, msi,
-			     (entry->msi_attrib.is_64 ? 1 : 0));
+			     (entry->pci.msi_attrib.is_64 ? 1 : 0));
 	if (err)
 		goto out_msi_free;
 
 	pbm->msi_irq_table[msi - pbm->msi_first] = *irq_p;
 
-	if (entry->msi_attrib.is_64) {
+	if (entry->pci.msi_attrib.is_64) {
 		msg.address_hi = pbm->msi64_start >> 32;
 		msg.address_lo = pbm->msi64_start & 0xffffffff;
 	} else {
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index dbacb9e..1656477 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -163,7 +163,7 @@ int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 	struct msi_desc *desc = first_pci_msi_entry(pdev);
 
 	init_irq_alloc_info(arg, NULL);
-	if (desc->msi_attrib.is_msix) {
+	if (desc->pci.msi_attrib.is_msix) {
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
 	} else {
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 12da005..2dace88 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -306,7 +306,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 				return -EINVAL;
 
 			map_irq.table_base = pci_resource_start(dev, bir);
-			map_irq.entry_nr = msidesc->msi_attrib.entry_nr;
+			map_irq.entry_nr = msidesc->pci.msi_attrib.entry_nr;
 		}
 
 		ret = -EINVAL;
@@ -398,7 +398,7 @@ static void xen_pv_teardown_msi_irqs(struct pci_dev *dev)
 {
 	struct msi_desc *msidesc = first_pci_msi_entry(dev);
 
-	if (msidesc->msi_attrib.is_msix)
+	if (msidesc->pci.msi_attrib.is_msix)
 		xen_pci_frontend_disable_msix(dev);
 	else
 		xen_pci_frontend_disable_msi(dev);
@@ -414,7 +414,7 @@ static int xen_msi_domain_alloc_irqs(struct irq_domain *domain,
 	if (WARN_ON_ONCE(!dev_is_pci(dev)))
 		return -EINVAL;
 
-	if (first_msi_entry(dev)->msi_attrib.is_msix)
+	if (first_msi_entry(dev)->pci.msi_attrib.is_msix)
 		type = PCI_CAP_ID_MSIX;
 	else
 		type = PCI_CAP_ID_MSI;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 3d353e7..d9d00e4 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -911,7 +911,7 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
 	}
 
 	ab_pci->msi_ep_base_data = msi_desc->msg.data;
-	if (msi_desc->msi_attrib.is_64)
+	if (msi_desc->pci.msi_attrib.is_64)
 		set_bit(ATH11K_PCI_FLAG_IS_MSI_64, &ab_pci->flags);
 
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", ab_pci->msi_ep_base_data);
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index e1aecd9..b6cd8b3 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -138,9 +138,9 @@ void __weak arch_restore_msi_irqs(struct pci_dev *dev)
 static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
 {
 	/* Don't shift by >= width of type */
-	if (desc->msi_attrib.multi_cap >= 5)
+	if (desc->pci.msi_attrib.multi_cap >= 5)
 		return 0xffffffff;
-	return (1 << (1 << desc->msi_attrib.multi_cap)) - 1;
+	return (1 << (1 << desc->pci.msi_attrib.multi_cap)) - 1;
 }
 
 static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
@@ -148,14 +148,14 @@ static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 s
 	raw_spinlock_t *lock = &desc->dev->msi_lock;
 	unsigned long flags;
 
-	if (!desc->msi_attrib.can_mask)
+	if (!desc->pci.msi_attrib.can_mask)
 		return;
 
 	raw_spin_lock_irqsave(lock, flags);
-	desc->msi_mask &= ~clear;
-	desc->msi_mask |= set;
-	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->mask_pos,
-			       desc->msi_mask);
+	desc->pci.msi_mask &= ~clear;
+	desc->pci.msi_mask |= set;
+	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->pci.mask_pos,
+			       desc->pci.msi_mask);
 	raw_spin_unlock_irqrestore(lock, flags);
 }
 
@@ -171,7 +171,7 @@ static inline void pci_msi_unmask(struct msi_desc *desc, u32 mask)
 
 static inline void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
 {
-	return desc->mask_base + desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
+	return desc->pci.mask_base + desc->pci.msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
 }
 
 /*
@@ -184,27 +184,27 @@ static void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
 {
 	void __iomem *desc_addr = pci_msix_desc_addr(desc);
 
-	if (desc->msi_attrib.can_mask)
+	if (desc->pci.msi_attrib.can_mask)
 		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
 
 static inline void pci_msix_mask(struct msi_desc *desc)
 {
-	desc->msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
-	pci_msix_write_vector_ctrl(desc, desc->msix_ctrl);
+	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
 	/* Flush write to device */
-	readl(desc->mask_base);
+	readl(desc->pci.mask_base);
 }
 
 static inline void pci_msix_unmask(struct msi_desc *desc)
 {
-	desc->msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
-	pci_msix_write_vector_ctrl(desc, desc->msix_ctrl);
+	desc->pci.msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
 }
 
 static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
 {
-	if (desc->msi_attrib.is_msix)
+	if (desc->pci.msi_attrib.is_msix)
 		pci_msix_mask(desc);
 	else
 		pci_msi_mask(desc, mask);
@@ -212,7 +212,7 @@ static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
 
 static void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
 {
-	if (desc->msi_attrib.is_msix)
+	if (desc->pci.msi_attrib.is_msix)
 		pci_msix_unmask(desc);
 	else
 		pci_msi_unmask(desc, mask);
@@ -256,10 +256,10 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 
 	BUG_ON(dev->current_state != PCI_D0);
 
-	if (entry->msi_attrib.is_msix) {
+	if (entry->pci.msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
 
-		if (WARN_ON_ONCE(entry->msi_attrib.is_virtual))
+		if (WARN_ON_ONCE(entry->pci.msi_attrib.is_virtual))
 			return;
 
 		msg->address_lo = readl(base + PCI_MSIX_ENTRY_LOWER_ADDR);
@@ -271,7 +271,7 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 
 		pci_read_config_dword(dev, pos + PCI_MSI_ADDRESS_LO,
 				      &msg->address_lo);
-		if (entry->msi_attrib.is_64) {
+		if (entry->pci.msi_attrib.is_64) {
 			pci_read_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,
 					      &msg->address_hi);
 			pci_read_config_word(dev, pos + PCI_MSI_DATA_64, &data);
@@ -289,12 +289,12 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 
 	if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
 		/* Don't touch the hardware now */
-	} else if (entry->msi_attrib.is_msix) {
+	} else if (entry->pci.msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
-		u32 ctrl = entry->msix_ctrl;
+		u32 ctrl = entry->pci.msix_ctrl;
 		bool unmasked = !(ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
 
-		if (entry->msi_attrib.is_virtual)
+		if (entry->pci.msi_attrib.is_virtual)
 			goto skip;
 
 		/*
@@ -323,12 +323,12 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 
 		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
 		msgctl &= ~PCI_MSI_FLAGS_QSIZE;
-		msgctl |= entry->msi_attrib.multiple << 4;
+		msgctl |= entry->pci.msi_attrib.multiple << 4;
 		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
 
 		pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO,
 				       msg->address_lo);
-		if (entry->msi_attrib.is_64) {
+		if (entry->pci.msi_attrib.is_64) {
 			pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,
 					       msg->address_hi);
 			pci_write_config_word(dev, pos + PCI_MSI_DATA_64,
@@ -376,9 +376,9 @@ static void free_msi_irqs(struct pci_dev *dev)
 	pci_msi_teardown_msi_irqs(dev);
 
 	list_for_each_entry_safe(entry, tmp, msi_list, list) {
-		if (entry->msi_attrib.is_msix) {
+		if (entry->pci.msi_attrib.is_msix) {
 			if (list_is_last(&entry->list, msi_list))
-				iounmap(entry->mask_base);
+				iounmap(entry->pci.mask_base);
 		}
 
 		list_del(&entry->list);
@@ -420,7 +420,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
 	pci_msi_update_mask(entry, 0, 0);
 	control &= ~PCI_MSI_FLAGS_QSIZE;
-	control |= (entry->msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
+	control |= (entry->pci.msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
 }
 
@@ -449,7 +449,7 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 
 	arch_restore_msi_irqs(dev);
 	for_each_pci_msi_entry(entry, dev)
-		pci_msix_write_vector_ctrl(entry, entry->msix_ctrl);
+		pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
@@ -481,24 +481,24 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
 		control |= PCI_MSI_FLAGS_MASKBIT;
 
-	entry->msi_attrib.is_msix	= 0;
-	entry->msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
-	entry->msi_attrib.is_virtual    = 0;
-	entry->msi_attrib.entry_nr	= 0;
-	entry->msi_attrib.can_mask	= !pci_msi_ignore_mask &&
+	entry->pci.msi_attrib.is_msix	= 0;
+	entry->pci.msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
+	entry->pci.msi_attrib.is_virtual    = 0;
+	entry->pci.msi_attrib.entry_nr	= 0;
+	entry->pci.msi_attrib.can_mask	= !pci_msi_ignore_mask &&
 					  !!(control & PCI_MSI_FLAGS_MASKBIT);
-	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
-	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
-	entry->msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
+	entry->pci.msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
+	entry->pci.msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
+	entry->pci.msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
 
 	if (control & PCI_MSI_FLAGS_64BIT)
-		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
+		entry->pci.mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
 	else
-		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
+		entry->pci.mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
 
 	/* Save the initial mask status */
-	if (entry->msi_attrib.can_mask)
-		pci_read_config_dword(dev, entry->mask_pos, &entry->msi_mask);
+	if (entry->pci.msi_attrib.can_mask)
+		pci_read_config_dword(dev, entry->pci.mask_pos, &entry->pci.msi_mask);
 
 out:
 	kfree(masks);
@@ -630,26 +630,26 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			goto out;
 		}
 
-		entry->msi_attrib.is_msix	= 1;
-		entry->msi_attrib.is_64		= 1;
+		entry->pci.msi_attrib.is_msix	= 1;
+		entry->pci.msi_attrib.is_64	= 1;
 
 		if (entries)
-			entry->msi_attrib.entry_nr = entries[i].entry;
+			entry->pci.msi_attrib.entry_nr = entries[i].entry;
 		else
-			entry->msi_attrib.entry_nr = i;
+			entry->pci.msi_attrib.entry_nr = i;
 
-		entry->msi_attrib.is_virtual =
-			entry->msi_attrib.entry_nr >= vec_count;
+		entry->pci.msi_attrib.is_virtual =
+			entry->pci.msi_attrib.entry_nr >= vec_count;
 
-		entry->msi_attrib.can_mask	= !pci_msi_ignore_mask &&
-						  !entry->msi_attrib.is_virtual;
+		entry->pci.msi_attrib.can_mask	= !pci_msi_ignore_mask &&
+						  !entry->pci.msi_attrib.is_virtual;
 
-		entry->msi_attrib.default_irq	= dev->irq;
-		entry->mask_base		= base;
+		entry->pci.msi_attrib.default_irq	= dev->irq;
+		entry->pci.mask_base			= base;
 
-		if (entry->msi_attrib.can_mask) {
+		if (entry->pci.msi_attrib.can_mask) {
 			addr = pci_msix_desc_addr(entry);
-			entry->msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+			entry->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 		}
 
 		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
@@ -874,7 +874,7 @@ static void pci_msi_shutdown(struct pci_dev *dev)
 	pci_msi_unmask(desc, msi_multi_mask(desc));
 
 	/* Restore dev->irq to its default pin-assertion IRQ */
-	dev->irq = desc->msi_attrib.default_irq;
+	dev->irq = desc->pci.msi_attrib.default_irq;
 	pcibios_alloc_irq(dev);
 }
 
@@ -1203,7 +1203,7 @@ int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 		struct msi_desc *entry;
 
 		for_each_pci_msi_entry(entry, dev) {
-			if (entry->msi_attrib.entry_nr == nr)
+			if (entry->pci.msi_attrib.entry_nr == nr)
 				return entry->irq;
 		}
 		WARN_ON_ONCE(1);
@@ -1242,7 +1242,7 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 		struct msi_desc *entry;
 
 		for_each_pci_msi_entry(entry, dev) {
-			if (entry->msi_attrib.entry_nr == nr)
+			if (entry->pci.msi_attrib.entry_nr == nr)
 				return &entry->affinity->mask;
 		}
 		WARN_ON_ONCE(1);
@@ -1295,14 +1295,14 @@ static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(desc);
 
-	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
+	return (irq_hw_number_t)desc->pci.msi_attrib.entry_nr |
 		pci_dev_id(dev) << 11 |
 		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
 }
 
 static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
 {
-	return !desc->msi_attrib.is_msix && desc->nvec_used > 1;
+	return !desc->pci.msi_attrib.is_msix && desc->nvec_used > 1;
 }
 
 /**
@@ -1326,7 +1326,7 @@ int pci_msi_domain_check_cap(struct irq_domain *domain,
 	if (pci_msi_desc_is_multi_msi(desc) &&
 	    !(info->flags & MSI_FLAG_MULTI_PCI_MSI))
 		return 1;
-	else if (desc->msi_attrib.is_msix && !(info->flags & MSI_FLAG_PCI_MSIX))
+	else if (desc->pci.msi_attrib.is_msix && !(info->flags & MSI_FLAG_PCI_MSIX))
 		return -ENOTSUPP;
 
 	return 0;
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index d858d25..699cc95 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -263,7 +263,7 @@ static int pci_frontend_enable_msix(struct pci_dev *dev,
 
 	i = 0;
 	for_each_pci_msi_entry(entry, dev) {
-		op.msix_entries[i].entry = entry->msi_attrib.entry_nr;
+		op.msix_entries[i].entry = entry->pci.msi_attrib.entry_nr;
 		/* Vector is useless at this point. */
 		op.msix_entries[i].vector = -1;
 		i++;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index ac6fec1..7e5c13f 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -69,6 +69,42 @@ typedef void (*irq_write_msi_msg_t)(struct msi_desc *desc,
 				    struct msi_msg *msg);
 
 /**
+ * pci_msi_desc - PCI/MSI specific MSI descriptor data
+ *
+ * @msi_mask:	[PCI MSI]   MSI cached mask bits
+ * @msix_ctrl:	[PCI MSI-X] MSI-X cached per vector control bits
+ * @is_msix:	[PCI MSI/X] True if MSI-X
+ * @multiple:	[PCI MSI/X] log2 num of messages allocated
+ * @multi_cap:	[PCI MSI/X] log2 num of messages supported
+ * @can_mask:	[PCI MSI/X] Masking supported?
+ * @is_64:	[PCI MSI/X] Address size: 0=32bit 1=64bit
+ * @entry_nr:	[PCI MSI/X] Entry which is described by this descriptor
+ * @default_irq:[PCI MSI/X] The default pre-assigned non-MSI irq
+ * @mask_pos:	[PCI MSI]   Mask register position
+ * @mask_base:	[PCI MSI-X] Mask register base address
+ */
+struct pci_msi_desc {
+	union {
+		u32 msi_mask;
+		u32 msix_ctrl;
+	};
+	struct {
+		u8	is_msix		: 1;
+		u8	multiple	: 3;
+		u8	multi_cap	: 3;
+		u8	can_mask	: 1;
+		u8	is_64		: 1;
+		u8	is_virtual	: 1;
+		u16	entry_nr;
+		unsigned default_irq;
+	} msi_attrib;
+	union {
+		u8	mask_pos;
+		void __iomem *mask_base;
+	};
+};
+
+/**
  * platform_msi_desc - Platform device specific msi descriptor data
  * @msi_priv_data:	Pointer to platform private data
  * @msi_index:		The index of the MSI descriptor for multi MSI
@@ -107,17 +143,7 @@ struct ti_sci_inta_msi_desc {
  *			address or data changes
  * @write_msi_msg_data:	Data parameter for the callback.
  *
- * @msi_mask:	[PCI MSI]   MSI cached mask bits
- * @msix_ctrl:	[PCI MSI-X] MSI-X cached per vector control bits
- * @is_msix:	[PCI MSI/X] True if MSI-X
- * @multiple:	[PCI MSI/X] log2 num of messages allocated
- * @multi_cap:	[PCI MSI/X] log2 num of messages supported
- * @maskbit:	[PCI MSI/X] Mask-Pending bit supported?
- * @is_64:	[PCI MSI/X] Address size: 0=32bit 1=64bit
- * @entry_nr:	[PCI MSI/X] Entry which is described by this descriptor
- * @default_irq:[PCI MSI/X] The default pre-assigned non-MSI irq
- * @mask_pos:	[PCI MSI]   Mask register position
- * @mask_base:	[PCI MSI-X] Mask register base address
+ * @pci:	[PCI]	    PCI speficic msi descriptor data
  * @platform:	[platform]  Platform device specific msi descriptor data
  * @fsl_mc:	[fsl-mc]    FSL MC device specific msi descriptor data
  * @inta:	[INTA]	    TISCI based INTA specific msi descriptor data
@@ -138,38 +164,10 @@ struct msi_desc {
 	void *write_msi_msg_data;
 
 	union {
-		/* PCI MSI/X specific data */
-		struct {
-			union {
-				u32 msi_mask;
-				u32 msix_ctrl;
-			};
-			struct {
-				u8	is_msix		: 1;
-				u8	multiple	: 3;
-				u8	multi_cap	: 3;
-				u8	can_mask	: 1;
-				u8	is_64		: 1;
-				u8	is_virtual	: 1;
-				u16	entry_nr;
-				unsigned default_irq;
-			} msi_attrib;
-			union {
-				u8	mask_pos;
-				void __iomem *mask_base;
-			};
-		};
-
-		/*
-		 * Non PCI variants add their data structure here. New
-		 * entries need to use a named structure. We want
-		 * proper name spaces for this. The PCI part is
-		 * anonymous for now as it would require an immediate
-		 * tree wide cleanup.
-		 */
-		struct platform_msi_desc platform;
-		struct fsl_mc_msi_desc fsl_mc;
-		struct ti_sci_inta_msi_desc inta;
+		struct pci_msi_desc		pci;
+		struct platform_msi_desc	platform;
+		struct fsl_mc_msi_desc		fsl_mc;
+		struct ti_sci_inta_msi_desc	inta;
 	};
 };
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 6718bab..7d78d8a 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -91,7 +91,7 @@ static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 		return -ENODEV;
 
 	if (dev_is_pci(dev))
-		is_msix = entry->msi_attrib.is_msix;
+		is_msix = entry->pci.msi_attrib.is_msix;
 
 	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
 }
@@ -535,7 +535,7 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
 	 * masking and MSI does so when the can_mask attribute is set.
 	 */
 	desc = first_msi_entry(dev);
-	return desc->msi_attrib.is_msix || desc->msi_attrib.can_mask;
+	return desc->pci.msi_attrib.is_msix || desc->pci.msi_attrib.can_mask;
 }
 
 int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B4E477F64
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242702AbhLPVmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57088 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241792AbhLPVlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:05 -0500
Date:   Thu, 16 Dec 2021 21:41:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=laeDUp6ULIbwtEO/TcddrqRLEJKftYmbGLXbSpNIqUU=;
        b=28AB3JqKs+cNll9z09EaDC5kVC8sTUg9UbrOyUzYbbS15oUIfLHKqQHEo/LxCwLyVCdxCR
        AVY0lq/XI3FpCu64yNlsqwpvL0MdL6MtxgGDOT+7/Sp798H5lJif8t4TKODqTJl9SnkzwB
        qmjP2NiZS2alwGDFl4Cs9soGcCiKdpPzAgloFzENQ+tbF32Kwr7+xVCTMyTIuXtBIXSOKV
        N0DT1nrQ693kRU1XL07QnlaGuza0gLnfRGhF8+HR76T41Ptz/PS9EKlhBYrAAMG+u0naJM
        r0RgxtyD+9/LzUJl7rv5q8+JTngBivXEJKtEo8NUYXRf5DXm1yPoWx6qqewR3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=laeDUp6ULIbwtEO/TcddrqRLEJKftYmbGLXbSpNIqUU=;
        b=MVDQKZwn9HzFfgjWsIcZG1XqLuKgJed0XM5Rfv66oeaxZJkOVMbicwx5784iSdC8L7rSUW
        KHiD6mThS7uNexCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Let the irq code handle sysfs groups
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221814.048612053@linutronix.de>
References: <20211210221814.048612053@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969086316.23020.5798765956546581612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     ffd84485e6beb9cad3e5a133d88201b995298c33
Gitweb:        https://git.kernel.org/tip/ffd84485e6beb9cad3e5a133d88201b995298c33
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:39 +01:00

PCI/MSI: Let the irq code handle sysfs groups

Set the domain info flag which makes the core code handle sysfs groups and
put an explicit invocation into the legacy code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211210221814.048612053@linutronix.de

---
 drivers/pci/msi/irqdomain.c |  2 +-
 drivers/pci/msi/legacy.c    |  6 +++++-
 drivers/pci/msi/msi.c       | 23 -----------------------
 include/linux/pci.h         |  1 -
 4 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index a554690..26b23a1 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -159,7 +159,7 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		pci_msi_domain_update_chip_ops(info);
 
-	info->flags |= MSI_FLAG_ACTIVATE_EARLY;
+	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
 		info->flags |= MSI_FLAG_MUST_REACTIVATE;
 
diff --git a/drivers/pci/msi/legacy.c b/drivers/pci/msi/legacy.c
index d52cff1..773f351 100644
--- a/drivers/pci/msi/legacy.c
+++ b/drivers/pci/msi/legacy.c
@@ -70,10 +70,14 @@ int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	int ret = arch_setup_msi_irqs(dev, nvec, type);
 
-	return pci_msi_setup_check_result(dev, type, ret);
+	ret = pci_msi_setup_check_result(dev, type, ret);
+	if (!ret)
+		ret = msi_device_populate_sysfs(&dev->dev);
+	return ret;
 }
 
 void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
 {
+	msi_device_destroy_sysfs(&dev->dev);
 	arch_teardown_msi_irqs(dev);
 }
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 369e3c5..76c15be 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -233,11 +233,6 @@ static void free_msi_irqs(struct pci_dev *dev)
 			for (i = 0; i < entry->nvec_used; i++)
 				BUG_ON(irq_has_action(entry->irq + i));
 
-	if (dev->msi_irq_groups) {
-		msi_destroy_sysfs(&dev->dev, dev->msi_irq_groups);
-		dev->msi_irq_groups = NULL;
-	}
-
 	pci_msi_teardown_msi_irqs(dev);
 
 	list_for_each_entry_safe(entry, tmp, msi_list, list) {
@@ -455,7 +450,6 @@ static int msi_verify_entries(struct pci_dev *dev)
 static int msi_capability_init(struct pci_dev *dev, int nvec,
 			       struct irq_affinity *affd)
 {
-	const struct attribute_group **groups;
 	struct msi_desc *entry;
 	int ret;
 
@@ -486,14 +480,6 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	if (ret)
 		goto err;
 
-	groups = msi_populate_sysfs(&dev->dev);
-	if (IS_ERR(groups)) {
-		ret = PTR_ERR(groups);
-		goto err;
-	}
-
-	dev->msi_irq_groups = groups;
-
 	/* Set MSI enabled bits	*/
 	pci_intx_for_msi(dev, 0);
 	pci_msi_set_enable(dev, 1);
@@ -622,7 +608,6 @@ static void msix_mask_all(void __iomem *base, int tsize)
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 				int nvec, struct irq_affinity *affd)
 {
-	const struct attribute_group **groups;
 	void __iomem *base;
 	int ret, tsize;
 	u16 control;
@@ -664,14 +649,6 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 
 	msix_update_entries(dev, entries);
 
-	groups = msi_populate_sysfs(&dev->dev);
-	if (IS_ERR(groups)) {
-		ret = PTR_ERR(groups);
-		goto out_free;
-	}
-
-	dev->msi_irq_groups = groups;
-
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a09736d..0a7b6b2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -476,7 +476,6 @@ struct pci_dev {
 #ifdef CONFIG_PCI_MSI
 	void __iomem	*msix_base;
 	raw_spinlock_t	msi_lock;
-	const struct attribute_group **msi_irq_groups;
 #endif
 	struct pci_vpd	vpd;
 #ifdef CONFIG_PCIE_DPC

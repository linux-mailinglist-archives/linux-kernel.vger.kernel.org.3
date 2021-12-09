Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46DE46ECA0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbhLIQKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:10:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40094 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240796AbhLIQKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:36 -0500
Date:   Thu, 09 Dec 2021 16:07:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBd3UK+zEQVlOuzp4QKCaqNUZxKqudpgoqk560kQq60=;
        b=iAhyFFb1ayMe7316qfsjFtEcT+EOWUbiiczFonBzPYasg9kNZ7NR/xBBUZeH2gUik0fOvt
        7Pu263fRenwRDHCsuXM/MWBBQkTP8N/d6/2EqYXjFlA8siczLKgSsvCWDouiV6KnYmDOFp
        pQE2Vxy7/Ew1KYIrELQGtXLkS2AY6CpzA8WYVgPBrU5IKXDZDKet8ZpkqA4V003VTFHAY9
        Ahs59Hznr1LF5+isXrI9zG7NVgECGWZyvNljIXtQjca0ZjCLluHdTes/h4gsGv4A4QixO3
        J1QjIQMgRh9zSlebIAcLdP2Xy0+fk+wZILYoKJVXe6j+xEX3n2ixuju+0xg4ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBd3UK+zEQVlOuzp4QKCaqNUZxKqudpgoqk560kQq60=;
        b=XPDcnql20/iVYTpWBJsEVLH8IU76oVvx3gu9JtnkV+PfdWWwJwgYLCxOkWMjlMzHNATSbl
        Ltt1cy7U5xWcDzBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Split out irqdomain code
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210224.817754783@linutronix.de>
References: <20211206210224.817754783@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906602100.11128.16685109025173654334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     aa423ac4221abdfb8588751e7838ca5f42f56db3
Gitweb:        https://git.kernel.org/tip/aa423ac4221abdfb8588751e7838ca5f42f56db3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:22 +01:00

PCI/MSI: Split out irqdomain code

Move the irqdomain specific code into its own file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211206210224.817754783@linutronix.de

---
 drivers/pci/msi/Makefile    |   1 +-
 drivers/pci/msi/irqdomain.c | 279 +++++++++++++++++++++++++++++++-
 drivers/pci/msi/legacy.c    |  13 +-
 drivers/pci/msi/msi.c       | 319 +----------------------------------
 drivers/pci/msi/msi.h       |  39 ++++-
 include/linux/msi.h         |  11 +-
 6 files changed, 340 insertions(+), 322 deletions(-)
 create mode 100644 drivers/pci/msi/irqdomain.c
 create mode 100644 drivers/pci/msi/msi.h

diff --git a/drivers/pci/msi/Makefile b/drivers/pci/msi/Makefile
index 64bf147..93ef7b9 100644
--- a/drivers/pci/msi/Makefile
+++ b/drivers/pci/msi/Makefile
@@ -3,4 +3,5 @@
 # Makefile for the PCI/MSI
 obj-$(CONFIG_PCI)			+= pcidev_msi.o
 obj-$(CONFIG_PCI_MSI)			+= msi.o
+obj-$(CONFIG_PCI_MSI_IRQ_DOMAIN)	+= irqdomain.o
 obj-$(CONFIG_PCI_MSI_ARCH_FALLBACKS)	+= legacy.o
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
new file mode 100644
index 0000000..123450e
--- /dev/null
+++ b/drivers/pci/msi/irqdomain.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Message Signaled Interrupt (MSI) - irqdomain support
+ */
+#include <linux/acpi_iort.h>
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
+
+#include "msi.h"
+
+int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	struct irq_domain *domain;
+
+	domain = dev_get_msi_domain(&dev->dev);
+	if (domain && irq_domain_is_hierarchy(domain))
+		return msi_domain_alloc_irqs(domain, &dev->dev, nvec);
+
+	return pci_msi_legacy_setup_msi_irqs(dev, nvec, type);
+}
+
+void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
+{
+	struct irq_domain *domain;
+
+	domain = dev_get_msi_domain(&dev->dev);
+	if (domain && irq_domain_is_hierarchy(domain))
+		msi_domain_free_irqs(domain, &dev->dev);
+	else
+		pci_msi_legacy_teardown_msi_irqs(dev);
+}
+
+/**
+ * pci_msi_domain_write_msg - Helper to write MSI message to PCI config space
+ * @irq_data:	Pointer to interrupt data of the MSI interrupt
+ * @msg:	Pointer to the message
+ */
+static void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(irq_data);
+
+	/*
+	 * For MSI-X desc->irq is always equal to irq_data->irq. For
+	 * MSI only the first interrupt of MULTI MSI passes the test.
+	 */
+	if (desc->irq == irq_data->irq)
+		__pci_write_msi_msg(desc, msg);
+}
+
+/**
+ * pci_msi_domain_calc_hwirq - Generate a unique ID for an MSI source
+ * @desc:	Pointer to the MSI descriptor
+ *
+ * The ID number is only used within the irqdomain.
+ */
+static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
+{
+	struct pci_dev *dev = msi_desc_to_pci_dev(desc);
+
+	return (irq_hw_number_t)desc->pci.msi_attrib.entry_nr |
+		pci_dev_id(dev) << 11 |
+		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
+}
+
+static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
+{
+	return !desc->pci.msi_attrib.is_msix && desc->nvec_used > 1;
+}
+
+/**
+ * pci_msi_domain_check_cap - Verify that @domain supports the capabilities
+ *			      for @dev
+ * @domain:	The interrupt domain to check
+ * @info:	The domain info for verification
+ * @dev:	The device to check
+ *
+ * Returns:
+ *  0 if the functionality is supported
+ *  1 if Multi MSI is requested, but the domain does not support it
+ *  -ENOTSUPP otherwise
+ */
+int pci_msi_domain_check_cap(struct irq_domain *domain,
+			     struct msi_domain_info *info, struct device *dev)
+{
+	struct msi_desc *desc = first_pci_msi_entry(to_pci_dev(dev));
+
+	/* Special handling to support __pci_enable_msi_range() */
+	if (pci_msi_desc_is_multi_msi(desc) &&
+	    !(info->flags & MSI_FLAG_MULTI_PCI_MSI))
+		return 1;
+	else if (desc->pci.msi_attrib.is_msix && !(info->flags & MSI_FLAG_PCI_MSIX))
+		return -ENOTSUPP;
+
+	return 0;
+}
+
+static int pci_msi_domain_handle_error(struct irq_domain *domain,
+				       struct msi_desc *desc, int error)
+{
+	/* Special handling to support __pci_enable_msi_range() */
+	if (pci_msi_desc_is_multi_msi(desc) && error == -ENOSPC)
+		return 1;
+
+	return error;
+}
+
+static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
+				    struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
+}
+
+static struct msi_domain_ops pci_msi_domain_ops_default = {
+	.set_desc	= pci_msi_domain_set_desc,
+	.msi_check	= pci_msi_domain_check_cap,
+	.handle_error	= pci_msi_domain_handle_error,
+};
+
+static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
+{
+	struct msi_domain_ops *ops = info->ops;
+
+	if (ops == NULL) {
+		info->ops = &pci_msi_domain_ops_default;
+	} else {
+		if (ops->set_desc == NULL)
+			ops->set_desc = pci_msi_domain_set_desc;
+		if (ops->msi_check == NULL)
+			ops->msi_check = pci_msi_domain_check_cap;
+		if (ops->handle_error == NULL)
+			ops->handle_error = pci_msi_domain_handle_error;
+	}
+}
+
+static void pci_msi_domain_update_chip_ops(struct msi_domain_info *info)
+{
+	struct irq_chip *chip = info->chip;
+
+	BUG_ON(!chip);
+	if (!chip->irq_write_msi_msg)
+		chip->irq_write_msi_msg = pci_msi_domain_write_msg;
+	if (!chip->irq_mask)
+		chip->irq_mask = pci_msi_mask_irq;
+	if (!chip->irq_unmask)
+		chip->irq_unmask = pci_msi_unmask_irq;
+}
+
+/**
+ * pci_msi_create_irq_domain - Create a MSI interrupt domain
+ * @fwnode:	Optional fwnode of the interrupt controller
+ * @info:	MSI domain info
+ * @parent:	Parent irq domain
+ *
+ * Updates the domain and chip ops and creates a MSI interrupt domain.
+ *
+ * Returns:
+ * A domain pointer or NULL in case of failure.
+ */
+struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
+					     struct msi_domain_info *info,
+					     struct irq_domain *parent)
+{
+	struct irq_domain *domain;
+
+	if (WARN_ON(info->flags & MSI_FLAG_LEVEL_CAPABLE))
+		info->flags &= ~MSI_FLAG_LEVEL_CAPABLE;
+
+	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
+		pci_msi_domain_update_dom_ops(info);
+	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
+		pci_msi_domain_update_chip_ops(info);
+
+	info->flags |= MSI_FLAG_ACTIVATE_EARLY;
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
+		info->flags |= MSI_FLAG_MUST_REACTIVATE;
+
+	/* PCI-MSI is oneshot-safe */
+	info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
+
+	domain = msi_create_irq_domain(fwnode, info, parent);
+	if (!domain)
+		return NULL;
+
+	irq_domain_update_bus_token(domain, DOMAIN_BUS_PCI_MSI);
+	return domain;
+}
+EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
+
+/*
+ * Users of the generic MSI infrastructure expect a device to have a single ID,
+ * so with DMA aliases we have to pick the least-worst compromise. Devices with
+ * DMA phantom functions tend to still emit MSIs from the real function number,
+ * so we ignore those and only consider topological aliases where either the
+ * alias device or RID appears on a different bus number. We also make the
+ * reasonable assumption that bridges are walked in an upstream direction (so
+ * the last one seen wins), and the much braver assumption that the most likely
+ * case is that of PCI->PCIe so we should always use the alias RID. This echoes
+ * the logic from intel_irq_remapping's set_msi_sid(), which presumably works
+ * well enough in practice; in the face of the horrible PCIe<->PCI-X conditions
+ * for taking ownership all we can really do is close our eyes and hope...
+ */
+static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
+{
+	u32 *pa = data;
+	u8 bus = PCI_BUS_NUM(*pa);
+
+	if (pdev->bus->number != bus || PCI_BUS_NUM(alias) != bus)
+		*pa = alias;
+
+	return 0;
+}
+
+/**
+ * pci_msi_domain_get_msi_rid - Get the MSI requester id (RID)
+ * @domain:	The interrupt domain
+ * @pdev:	The PCI device.
+ *
+ * The RID for a device is formed from the alias, with a firmware
+ * supplied mapping applied
+ *
+ * Returns: The RID.
+ */
+u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
+{
+	struct device_node *of_node;
+	u32 rid = pci_dev_id(pdev);
+
+	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
+
+	of_node = irq_domain_get_of_node(domain);
+	rid = of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
+			iort_msi_map_id(&pdev->dev, rid);
+
+	return rid;
+}
+
+/**
+ * pci_msi_get_device_domain - Get the MSI domain for a given PCI device
+ * @pdev:	The PCI device
+ *
+ * Use the firmware data to find a device-specific MSI domain
+ * (i.e. not one that is set as a default).
+ *
+ * Returns: The corresponding MSI domain or NULL if none has been found.
+ */
+struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
+{
+	struct irq_domain *dom;
+	u32 rid = pci_dev_id(pdev);
+
+	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
+	dom = of_msi_map_get_device_domain(&pdev->dev, rid, DOMAIN_BUS_PCI_MSI);
+	if (!dom)
+		dom = iort_get_device_domain(&pdev->dev, rid,
+					     DOMAIN_BUS_PCI_MSI);
+	return dom;
+}
+
+/**
+ * pci_dev_has_special_msi_domain - Check whether the device is handled by
+ *				    a non-standard PCI-MSI domain
+ * @pdev:	The PCI device to check.
+ *
+ * Returns: True if the device irqdomain or the bus irqdomain is
+ * non-standard PCI/MSI.
+ */
+bool pci_dev_has_special_msi_domain(struct pci_dev *pdev)
+{
+	struct irq_domain *dom = dev_get_msi_domain(&pdev->dev);
+
+	if (!dom)
+		dom = dev_get_msi_domain(&pdev->bus->dev);
+
+	if (!dom)
+		return true;
+
+	return dom->bus_token != DOMAIN_BUS_PCI_MSI;
+}
diff --git a/drivers/pci/msi/legacy.c b/drivers/pci/msi/legacy.c
index 4c76c59..023de20 100644
--- a/drivers/pci/msi/legacy.c
+++ b/drivers/pci/msi/legacy.c
@@ -4,8 +4,7 @@
  *
  * Legacy architecture specific setup and teardown mechanism.
  */
-#include <linux/msi.h>
-#include <linux/pci.h>
+#include "msi.h"
 
 /* Arch hooks */
 int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
@@ -50,3 +49,13 @@ void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
 		}
 	}
 }
+
+int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	return arch_setup_msi_irqs(dev, nvec, type);
+}
+
+void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
+{
+	arch_teardown_msi_irqs(dev);
+}
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 78f10ce..8926a6c 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -6,64 +6,16 @@
  * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
  * Copyright (C) 2016 Christoph Hellwig.
  */
-
-#include <linux/acpi_iort.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/irq.h>
-#include <linux/irqdomain.h>
-#include <linux/msi.h>
-#include <linux/of_irq.h>
-#include <linux/pci.h>
 
 #include "../pci.h"
+#include "msi.h"
 
 static int pci_msi_enable = 1;
 int pci_msi_ignore_mask;
 
-#define msix_table_size(flags)	((flags & PCI_MSIX_FLAGS_QSIZE) + 1)
-
-#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
-static int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	struct irq_domain *domain;
-
-	domain = dev_get_msi_domain(&dev->dev);
-	if (domain && irq_domain_is_hierarchy(domain))
-		return msi_domain_alloc_irqs(domain, &dev->dev, nvec);
-
-	return arch_setup_msi_irqs(dev, nvec, type);
-}
-
-static void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
-{
-	struct irq_domain *domain;
-
-	domain = dev_get_msi_domain(&dev->dev);
-	if (domain && irq_domain_is_hierarchy(domain))
-		msi_domain_free_irqs(domain, &dev->dev);
-	else
-		arch_teardown_msi_irqs(dev);
-}
-#else
-#define pci_msi_setup_msi_irqs		arch_setup_msi_irqs
-#define pci_msi_teardown_msi_irqs	arch_teardown_msi_irqs
-#endif
-
-/*
- * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
- * mask all MSI interrupts by clearing the MSI enable bit does not work
- * reliably as devices without an INTx disable bit will then generate a
- * level IRQ which will never be cleared.
- */
-static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
-{
-	/* Don't shift by >= width of type */
-	if (desc->pci.msi_attrib.multi_cap >= 5)
-		return 0xffffffff;
-	return (1 << (1 << desc->pci.msi_attrib.multi_cap)) - 1;
-}
-
 static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
 {
 	raw_spinlock_t *lock = &desc->dev->msi_lock;
@@ -903,23 +855,6 @@ void pci_disable_msix(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_disable_msix);
 
-void pci_no_msi(void)
-{
-	pci_msi_enable = 0;
-}
-
-/**
- * pci_msi_enabled - is MSI enabled?
- *
- * Returns true if MSI has not been disabled by the command-line option
- * pci=nomsi.
- **/
-int pci_msi_enabled(void)
-{
-	return pci_msi_enable;
-}
-EXPORT_SYMBOL(pci_msi_enabled);
-
 static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 				  struct irq_affinity *affd)
 {
@@ -1195,253 +1130,19 @@ struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 }
 EXPORT_SYMBOL(msi_desc_to_pci_dev);
 
-#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
-/**
- * pci_msi_domain_write_msg - Helper to write MSI message to PCI config space
- * @irq_data:	Pointer to interrupt data of the MSI interrupt
- * @msg:	Pointer to the message
- */
-static void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
-{
-	struct msi_desc *desc = irq_data_get_msi_desc(irq_data);
-
-	/*
-	 * For MSI-X desc->irq is always equal to irq_data->irq. For
-	 * MSI only the first interrupt of MULTI MSI passes the test.
-	 */
-	if (desc->irq == irq_data->irq)
-		__pci_write_msi_msg(desc, msg);
-}
-
-/**
- * pci_msi_domain_calc_hwirq - Generate a unique ID for an MSI source
- * @desc:	Pointer to the MSI descriptor
- *
- * The ID number is only used within the irqdomain.
- */
-static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
-{
-	struct pci_dev *dev = msi_desc_to_pci_dev(desc);
-
-	return (irq_hw_number_t)desc->pci.msi_attrib.entry_nr |
-		pci_dev_id(dev) << 11 |
-		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
-}
-
-static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
-{
-	return !desc->pci.msi_attrib.is_msix && desc->nvec_used > 1;
-}
-
-/**
- * pci_msi_domain_check_cap - Verify that @domain supports the capabilities
- * 			      for @dev
- * @domain:	The interrupt domain to check
- * @info:	The domain info for verification
- * @dev:	The device to check
- *
- * Returns:
- *  0 if the functionality is supported
- *  1 if Multi MSI is requested, but the domain does not support it
- *  -ENOTSUPP otherwise
- */
-int pci_msi_domain_check_cap(struct irq_domain *domain,
-			     struct msi_domain_info *info, struct device *dev)
-{
-	struct msi_desc *desc = first_pci_msi_entry(to_pci_dev(dev));
-
-	/* Special handling to support __pci_enable_msi_range() */
-	if (pci_msi_desc_is_multi_msi(desc) &&
-	    !(info->flags & MSI_FLAG_MULTI_PCI_MSI))
-		return 1;
-	else if (desc->pci.msi_attrib.is_msix && !(info->flags & MSI_FLAG_PCI_MSIX))
-		return -ENOTSUPP;
-
-	return 0;
-}
-
-static int pci_msi_domain_handle_error(struct irq_domain *domain,
-				       struct msi_desc *desc, int error)
-{
-	/* Special handling to support __pci_enable_msi_range() */
-	if (pci_msi_desc_is_multi_msi(desc) && error == -ENOSPC)
-		return 1;
-
-	return error;
-}
-
-static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
-				    struct msi_desc *desc)
-{
-	arg->desc = desc;
-	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
-}
-
-static struct msi_domain_ops pci_msi_domain_ops_default = {
-	.set_desc	= pci_msi_domain_set_desc,
-	.msi_check	= pci_msi_domain_check_cap,
-	.handle_error	= pci_msi_domain_handle_error,
-};
-
-static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
-{
-	struct msi_domain_ops *ops = info->ops;
-
-	if (ops == NULL) {
-		info->ops = &pci_msi_domain_ops_default;
-	} else {
-		if (ops->set_desc == NULL)
-			ops->set_desc = pci_msi_domain_set_desc;
-		if (ops->msi_check == NULL)
-			ops->msi_check = pci_msi_domain_check_cap;
-		if (ops->handle_error == NULL)
-			ops->handle_error = pci_msi_domain_handle_error;
-	}
-}
-
-static void pci_msi_domain_update_chip_ops(struct msi_domain_info *info)
-{
-	struct irq_chip *chip = info->chip;
-
-	BUG_ON(!chip);
-	if (!chip->irq_write_msi_msg)
-		chip->irq_write_msi_msg = pci_msi_domain_write_msg;
-	if (!chip->irq_mask)
-		chip->irq_mask = pci_msi_mask_irq;
-	if (!chip->irq_unmask)
-		chip->irq_unmask = pci_msi_unmask_irq;
-}
-
-/**
- * pci_msi_create_irq_domain - Create a MSI interrupt domain
- * @fwnode:	Optional fwnode of the interrupt controller
- * @info:	MSI domain info
- * @parent:	Parent irq domain
- *
- * Updates the domain and chip ops and creates a MSI interrupt domain.
- *
- * Returns:
- * A domain pointer or NULL in case of failure.
- */
-struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
-					     struct msi_domain_info *info,
-					     struct irq_domain *parent)
-{
-	struct irq_domain *domain;
-
-	if (WARN_ON(info->flags & MSI_FLAG_LEVEL_CAPABLE))
-		info->flags &= ~MSI_FLAG_LEVEL_CAPABLE;
-
-	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
-		pci_msi_domain_update_dom_ops(info);
-	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
-		pci_msi_domain_update_chip_ops(info);
-
-	info->flags |= MSI_FLAG_ACTIVATE_EARLY;
-	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
-		info->flags |= MSI_FLAG_MUST_REACTIVATE;
-
-	/* PCI-MSI is oneshot-safe */
-	info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
-
-	domain = msi_create_irq_domain(fwnode, info, parent);
-	if (!domain)
-		return NULL;
-
-	irq_domain_update_bus_token(domain, DOMAIN_BUS_PCI_MSI);
-	return domain;
-}
-EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
-
-/*
- * Users of the generic MSI infrastructure expect a device to have a single ID,
- * so with DMA aliases we have to pick the least-worst compromise. Devices with
- * DMA phantom functions tend to still emit MSIs from the real function number,
- * so we ignore those and only consider topological aliases where either the
- * alias device or RID appears on a different bus number. We also make the
- * reasonable assumption that bridges are walked in an upstream direction (so
- * the last one seen wins), and the much braver assumption that the most likely
- * case is that of PCI->PCIe so we should always use the alias RID. This echoes
- * the logic from intel_irq_remapping's set_msi_sid(), which presumably works
- * well enough in practice; in the face of the horrible PCIe<->PCI-X conditions
- * for taking ownership all we can really do is close our eyes and hope...
- */
-static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
-{
-	u32 *pa = data;
-	u8 bus = PCI_BUS_NUM(*pa);
-
-	if (pdev->bus->number != bus || PCI_BUS_NUM(alias) != bus)
-		*pa = alias;
-
-	return 0;
-}
-
-/**
- * pci_msi_domain_get_msi_rid - Get the MSI requester id (RID)
- * @domain:	The interrupt domain
- * @pdev:	The PCI device.
- *
- * The RID for a device is formed from the alias, with a firmware
- * supplied mapping applied
- *
- * Returns: The RID.
- */
-u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
-{
-	struct device_node *of_node;
-	u32 rid = pci_dev_id(pdev);
-
-	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
-
-	of_node = irq_domain_get_of_node(domain);
-	rid = of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
-			iort_msi_map_id(&pdev->dev, rid);
-
-	return rid;
-}
-
-/**
- * pci_msi_get_device_domain - Get the MSI domain for a given PCI device
- * @pdev:	The PCI device
- *
- * Use the firmware data to find a device-specific MSI domain
- * (i.e. not one that is set as a default).
- *
- * Returns: The corresponding MSI domain or NULL if none has been found.
- */
-struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
+void pci_no_msi(void)
 {
-	struct irq_domain *dom;
-	u32 rid = pci_dev_id(pdev);
-
-	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
-	dom = of_msi_map_get_device_domain(&pdev->dev, rid, DOMAIN_BUS_PCI_MSI);
-	if (!dom)
-		dom = iort_get_device_domain(&pdev->dev, rid,
-					     DOMAIN_BUS_PCI_MSI);
-	return dom;
+	pci_msi_enable = 0;
 }
 
 /**
- * pci_dev_has_special_msi_domain - Check whether the device is handled by
- *				    a non-standard PCI-MSI domain
- * @pdev:	The PCI device to check.
+ * pci_msi_enabled - is MSI enabled?
  *
- * Returns: True if the device irqdomain or the bus irqdomain is
- * non-standard PCI/MSI.
- */
-bool pci_dev_has_special_msi_domain(struct pci_dev *pdev)
+ * Returns true if MSI has not been disabled by the command-line option
+ * pci=nomsi.
+ **/
+int pci_msi_enabled(void)
 {
-	struct irq_domain *dom = dev_get_msi_domain(&pdev->dev);
-
-	if (!dom)
-		dom = dev_get_msi_domain(&pdev->bus->dev);
-
-	if (!dom)
-		return true;
-
-	return dom->bus_token != DOMAIN_BUS_PCI_MSI;
+	return pci_msi_enable;
 }
-
-#endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
+EXPORT_SYMBOL(pci_msi_enabled);
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
new file mode 100644
index 0000000..dbeff06
--- /dev/null
+++ b/drivers/pci/msi/msi.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/pci.h>
+#include <linux/msi.h>
+
+#define msix_table_size(flags)	((flags & PCI_MSIX_FLAGS_QSIZE) + 1)
+
+extern int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
+extern void pci_msi_teardown_msi_irqs(struct pci_dev *dev);
+
+#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
+extern int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
+extern void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);
+#else
+static inline int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	WARN_ON_ONCE(1);
+	return -ENODEV;
+}
+
+static inline void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
+{
+	WARN_ON_ONCE(1);
+}
+#endif
+
+/*
+ * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
+ * mask all MSI interrupts by clearing the MSI enable bit does not work
+ * reliably as devices without an INTx disable bit will then generate a
+ * level IRQ which will never be cleared.
+ */
+static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
+{
+	/* Don't shift by >= width of type */
+	if (desc->pci.msi_attrib.multi_cap >= 5)
+		return 0xffffffff;
+	return (1 << (1 << desc->pci.msi_attrib.multi_cap)) - 1;
+}
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 673899f..7ff7cf2 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -259,17 +259,6 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
 void arch_teardown_msi_irq(unsigned int irq);
 int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void arch_teardown_msi_irqs(struct pci_dev *dev);
-#else
-static inline int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	WARN_ON_ONCE(1);
-	return -ENODEV;
-}
-
-static inline void arch_teardown_msi_irqs(struct pci_dev *dev)
-{
-	WARN_ON_ONCE(1);
-}
 #endif
 
 /*

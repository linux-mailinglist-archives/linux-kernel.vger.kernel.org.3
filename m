Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEC8477F27
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbhLPVl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57126 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241665AbhLPVkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:40 -0500
Date:   Thu, 16 Dec 2021 21:40:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690839;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=be6ctVg8AEDZ96z82fGMrS7t0k/POhNFN2p7wo1kKD4=;
        b=Za3QfO3L4k8O/ideTwK9Gg9IzwzIbNtZFtJHw2iDpHm7xjLR61MGyVO6u6ofDp0gN1yzKj
        zYUPQxTRGVCn+Tp2LHHBiytlqkOVImHghPtp9UnUd4t8iA3DRFW/qzmeL04P5h+HRQHII0
        OCDkv4FgjVoFBnBIjiofvszetevIoL/lZl6NYhB3i7e4lRcqrTw3kc2byKyI6FNQSc41uP
        9aFU5T6qxGkqmD81ZNoMFFVM2ePLJ8yJEIJvfUs5AiAjT4i+AhaxLxQ4LRC38Ud9j09WP4
        RBFqtm1ZJ1/h9/PVHOxxb7ueNCw4PdOxDqyRjE/sSDkXBr11lgda5o+6eMibJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690839;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=be6ctVg8AEDZ96z82fGMrS7t0k/POhNFN2p7wo1kKD4=;
        b=9be5MQ1QgTPprhckOglo3WKyPJtgU/VPQ1VW1GK8rErcCW7euOETUWYSP/w3P8chQUBDSl
        +Y6YhB4Pl1SOv/Dw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Let core code free MSI descriptors
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210748.089085131@linutronix.de>
References: <20211206210748.089085131@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969083831.23020.2399935873964483697.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     9fb9eb4b59acc607e978288c96ac7efa917153d4
Gitweb:        https://git.kernel.org/tip/9fb9eb4b59acc607e978288c96ac7efa917153d4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:17 +01:00

PCI/MSI: Let core code free MSI descriptors

Set the domain info flag which tells the core code to free the MSI
descriptors from msi_domain_free_irqs() and add an explicit call to the
core function into the legacy code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211206210748.089085131@linutronix.de

---
 drivers/pci/msi/irqdomain.c |  3 ++-
 drivers/pci/msi/legacy.c    |  1 +
 drivers/pci/msi/msi.c       | 14 --------------
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index c81793a..3aab617 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -171,7 +171,8 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		pci_msi_domain_update_chip_ops(info);
 
-	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
+	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS |
+		       MSI_FLAG_FREE_MSI_DESCS;
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
 		info->flags |= MSI_FLAG_MUST_REACTIVATE;
 
diff --git a/drivers/pci/msi/legacy.c b/drivers/pci/msi/legacy.c
index 773f351..91c20a3 100644
--- a/drivers/pci/msi/legacy.c
+++ b/drivers/pci/msi/legacy.c
@@ -80,4 +80,5 @@ void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
 {
 	msi_device_destroy_sysfs(&dev->dev);
 	arch_teardown_msi_irqs(dev);
+	msi_free_msi_descs(&dev->dev);
 }
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 4ee47ee..95db9c3 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -224,22 +224,8 @@ EXPORT_SYMBOL_GPL(pci_write_msi_msg);
 
 static void free_msi_irqs(struct pci_dev *dev)
 {
-	struct list_head *msi_list = dev_to_msi_list(&dev->dev);
-	struct msi_desc *entry, *tmp;
-	int i;
-
-	for_each_pci_msi_entry(entry, dev)
-		if (entry->irq)
-			for (i = 0; i < entry->nvec_used; i++)
-				BUG_ON(irq_has_action(entry->irq + i));
-
 	pci_msi_teardown_msi_irqs(dev);
 
-	list_for_each_entry_safe(entry, tmp, msi_list, list) {
-		list_del(&entry->list);
-		free_msi_entry(entry);
-	}
-
 	if (dev->msix_base) {
 		iounmap(dev->msix_base);
 		dev->msix_base = NULL;

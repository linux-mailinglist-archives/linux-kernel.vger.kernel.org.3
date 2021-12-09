Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A63B46EC98
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbhLIQKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240784AbhLIQKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F9EC061353;
        Thu,  9 Dec 2021 08:07:01 -0800 (PST)
Date:   Thu, 09 Dec 2021 16:06:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gNZslH21GNKn29MI/1xlVV+YkUth1+N/vTwDUsEHbCs=;
        b=fSgcvO6tV2IRFcVN6myPD0tM6ZVqYlE+40j8OJ3wsX5GdAEC2OyD18juYrtsETk6PbkV2s
        q7PThVBD/AT/Pgb+1g+QKhBYcYLufOCHWMPcySokhM7sTX5cj9by9dPOT6yg7uhJbghXgy
        SCwEJK+hMAqOB30pbeJw/jT6kCkXj158aKfL23w2f6QzWR86GG4ogx/EgGcJm0+anPZUGu
        ndAcfV6bgtuIEXfuaf+Ar22RtQbDbJSzTgnvHcbinbkWxVHZNWkVZRd3tnr39wGXEixTMm
        f+70oI7o0GGPywq55wJrvSoS+VPcqQTUYu8Z6Cp3AC566BWqbM+omc7oDjYtrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gNZslH21GNKn29MI/1xlVV+YkUth1+N/vTwDUsEHbCs=;
        b=BXxc3QToWPB3MWXRUrIgaLP51QYMo5hUOnY3tp+jgD+idHLY3tWMqZLsJot37BIAqDOBjS
        jM6u1RIFPdi8ScBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Move msi_lock to struct pci_dev
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210224.925241961@linutronix.de>
References: <20211206210224.925241961@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906601949.11128.5546155304919293462.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     cd119b09a87d8beb50356d8c5c6aa42d89c44eb7
Gitweb:        https://git.kernel.org/tip/cd119b09a87d8beb50356d8c5c6aa42d89c44eb7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:22 +01:00

PCI/MSI: Move msi_lock to struct pci_dev

It's only required for PCI/MSI. So no point in having it in every struct
device.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211206210224.925241961@linutronix.de

---
 drivers/base/core.c    | 1 -
 drivers/pci/msi/msi.c  | 2 +-
 drivers/pci/probe.c    | 4 +++-
 include/linux/device.h | 2 --
 include/linux/pci.h    | 1 +
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index fd034d7..f26c668 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2875,7 +2875,6 @@ void device_initialize(struct device *dev)
 	device_pm_init(dev);
 	set_dev_node(dev, NUMA_NO_NODE);
 #ifdef CONFIG_GENERIC_MSI_IRQ
-	raw_spin_lock_init(&dev->msi_lock);
 	INIT_LIST_HEAD(&dev->msi_list);
 #endif
 	INIT_LIST_HEAD(&dev->links.consumers);
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 465fe9e..443a16c 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -18,7 +18,7 @@ int pci_msi_ignore_mask;
 
 static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
 {
-	raw_spinlock_t *lock = &desc->dev->msi_lock;
+	raw_spinlock_t *lock = &to_pci_dev(desc->dev)->msi_lock;
 	unsigned long flags;
 
 	if (!desc->pci.msi_attrib.can_mask)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 087d365..443efb0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2311,7 +2311,9 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	INIT_LIST_HEAD(&dev->bus_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
-
+#ifdef CONFIG_PCI_MSI
+	raw_spin_lock_init(&dev->msi_lock);
+#endif
 	return dev;
 }
 EXPORT_SYMBOL(pci_alloc_dev);
diff --git a/include/linux/device.h b/include/linux/device.h
index e270cb7..2a22875 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -407,7 +407,6 @@ struct dev_links_info {
  * @em_pd:	device's energy model performance domain
  * @pins:	For device pin management.
  *		See Documentation/driver-api/pin-control.rst for details.
- * @msi_lock:	Lock to protect MSI mask cache and mask register
  * @msi_list:	Hosts MSI descriptors
  * @msi_domain: The generic MSI domain this device is using.
  * @numa_node:	NUMA node this device is close to.
@@ -508,7 +507,6 @@ struct device {
 	struct dev_pin_info	*pins;
 #endif
 #ifdef CONFIG_GENERIC_MSI_IRQ
-	raw_spinlock_t		msi_lock;
 	struct list_head	msi_list;
 #endif
 #ifdef CONFIG_DMA_OPS
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8cb1036..5cc46ba 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -474,6 +474,7 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_MSI
 	void __iomem	*msix_base;
+	raw_spinlock_t	msi_lock;
 	const struct attribute_group **msi_irq_groups;
 #endif
 	struct pci_vpd	vpd;

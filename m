Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11069477F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242617AbhLPVmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56996 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242032AbhLPVlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:03 -0500
Date:   Thu, 16 Dec 2021 21:41:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7tx9p8ELHOIOHx8ZndPltekmebzeN5i7U1i72uAKkis=;
        b=jzHf+qbGccGjU2Rnaua60byoySXIQsrBd/rvE04EHIHh/656PDNFk4iS2i9Or00x2sMUPh
        JknmXT3oY2FBUjG24bEK/NBnK8mRI5EcPoFDqt+MkPOn7/vueuANfoo/N3eMSuKlPeNytv
        pjm4YhpQzbAvs6zO9IOw9HUCtiIqZydXFVzvOW7kFfQ5lKhUfpdyodI+TGz8tbTncctPoX
        P3ArbavHPo4dagRSNoaHeFTOX5I0LodAIZC4OSfa4X7jOFDNMEQM/+5sZLwHm1q2IWq3kB
        Up4gIfnTyDWd7ppoWuwSkTFT5jLecxPDVS0GlS6zNyvyeEiQn+EmaaW7uHN+yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7tx9p8ELHOIOHx8ZndPltekmebzeN5i7U1i72uAKkis=;
        b=QoVKSx0z8QaqcexyNcvMsb2m7+yfP7xdr13SQDx/d5gNXY1PGLBdFR9snGojzv6rggRDg6
        7x3HCZV6aikIZ2Aw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Remove the original sysfs interfaces
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221814.168362229@linutronix.de>
References: <20211210221814.168362229@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969086150.23020.18022055704624850768.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     24cff375fdb663c2238f06693a067b9219596fdc
Gitweb:        https://git.kernel.org/tip/24cff375fdb663c2238f06693a067b9219596fdc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:39 +01:00

genirq/msi: Remove the original sysfs interfaces

No more users. Refactor the core code accordingly and move the global
interface under CONFIG_PCI_MSI_ARCH_FALLBACKS.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221814.168362229@linutronix.de

---
 include/linux/msi.h | 18 ++-------------
 kernel/irq/msi.c    | 53 ++++++++++++++++----------------------------
 2 files changed, 23 insertions(+), 48 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 1b96dc4..634a129 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -249,22 +249,10 @@ void pci_msi_unmask_irq(struct irq_data *data);
 #ifdef CONFIG_SYSFS
 int msi_device_populate_sysfs(struct device *dev);
 void msi_device_destroy_sysfs(struct device *dev);
-
-const struct attribute_group **msi_populate_sysfs(struct device *dev);
-void msi_destroy_sysfs(struct device *dev,
-		       const struct attribute_group **msi_irq_groups);
-#else
+#else /* CONFIG_SYSFS */
 static inline int msi_device_populate_sysfs(struct device *dev) { return 0; }
 static inline void msi_device_destroy_sysfs(struct device *dev) { }
-
-static inline const struct attribute_group **msi_populate_sysfs(struct device *dev)
-{
-	return NULL;
-}
-static inline void msi_destroy_sysfs(struct device *dev, const struct attribute_group **msi_irq_groups)
-{
-}
-#endif
+#endif /* !CONFIG_SYSFS */
 
 /*
  * The arch hooks to setup up msi irqs. Default functions are implemented
@@ -279,7 +267,7 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
 void arch_teardown_msi_irq(unsigned int irq);
 int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void arch_teardown_msi_irqs(struct pci_dev *dev);
-#endif
+#endif /* CONFIG_PCI_MSI_ARCH_FALLBACKS */
 
 /*
  * The restore hook is still available even for fully irq domain based
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index dd65e67..8e433f1 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -118,12 +118,8 @@ static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 /**
  * msi_populate_sysfs - Populate msi_irqs sysfs entries for devices
  * @dev:	The device(PCI, platform etc) who will get sysfs entries
- *
- * Return attribute_group ** so that specific bus MSI can save it to
- * somewhere during initilizing msi irqs. If devices has no MSI irq,
- * return NULL; if it fails to populate sysfs, return ERR_PTR
  */
-const struct attribute_group **msi_populate_sysfs(struct device *dev)
+static const struct attribute_group **msi_populate_sysfs(struct device *dev)
 {
 	const struct attribute_group **msi_irq_groups;
 	struct attribute **msi_attrs, *msi_attr;
@@ -214,41 +210,32 @@ int msi_device_populate_sysfs(struct device *dev)
 }
 
 /**
- * msi_destroy_sysfs - Destroy msi_irqs sysfs entries for devices
- * @dev:		The device(PCI, platform etc) who will remove sysfs entries
- * @msi_irq_groups:	attribute_group for device msi_irqs entries
- */
-void msi_destroy_sysfs(struct device *dev, const struct attribute_group **msi_irq_groups)
-{
-	struct device_attribute *dev_attr;
-	struct attribute **msi_attrs;
-	int count = 0;
-
-	if (msi_irq_groups) {
-		sysfs_remove_groups(&dev->kobj, msi_irq_groups);
-		msi_attrs = msi_irq_groups[0]->attrs;
-		while (msi_attrs[count]) {
-			dev_attr = container_of(msi_attrs[count],
-					struct device_attribute, attr);
-			kfree(dev_attr->attr.name);
-			kfree(dev_attr);
-			++count;
-		}
-		kfree(msi_attrs);
-		kfree(msi_irq_groups[0]);
-		kfree(msi_irq_groups);
-	}
-}
-
-/**
  * msi_device_destroy_sysfs - Destroy msi_irqs sysfs entries for a device
  * @dev:		The device (PCI, platform etc) for which to remove
  *			sysfs entries
  */
 void msi_device_destroy_sysfs(struct device *dev)
 {
-	msi_destroy_sysfs(dev, dev->msi.data->attrs);
+	const struct attribute_group **msi_irq_groups = dev->msi.data->attrs;
+	struct device_attribute *dev_attr;
+	struct attribute **msi_attrs;
+	int count = 0;
+
 	dev->msi.data->attrs = NULL;
+	if (!msi_irq_groups)
+		return;
+
+	sysfs_remove_groups(&dev->kobj, msi_irq_groups);
+	msi_attrs = msi_irq_groups[0]->attrs;
+	while (msi_attrs[count]) {
+		dev_attr = container_of(msi_attrs[count], struct device_attribute, attr);
+		kfree(dev_attr->attr.name);
+		kfree(dev_attr);
+		++count;
+	}
+	kfree(msi_attrs);
+	kfree(msi_irq_groups[0]);
+	kfree(msi_irq_groups);
 }
 #endif
 

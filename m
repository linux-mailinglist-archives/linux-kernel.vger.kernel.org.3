Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE401477EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241729AbhLPVkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241674AbhLPVkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783FCC06173E;
        Thu, 16 Dec 2021 13:40:23 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:40:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690822;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CShIeozoA+ZwTx5++9ATLZZr/tfBVnfW222lqNBroLU=;
        b=yVmCcpEgwDXKkGpc7RJuxlSxk8cRSJmqfcThXGd0oBa5XxA80yJLpLMIEeW/lgCAU584Yw
        RFU6cMgIH+yPYyHpZSi45OpSMoJvKa+daNPIff+0eOIdp100B88F+8Av1xqadz/EcgXVRS
        Ru/KDG6gdBtN1bRQjpaYWuzRSnCprobkvjgWRbN1iir5Qwne92TYw9WA895RCRZIOl2RXb
        WG1YzYayj43uA9r7qrccHs1BwKz8VI8nT5aQiJAUpxPYXZ12pjy7Gx1NAfTqGZtlwkNsEG
        ZRoR1csQaQQhs8134LG/H9QSoowBLvT+k57s/+HiilUzEnBCKoYvXNq5ZD5BeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690822;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CShIeozoA+ZwTx5++9ATLZZr/tfBVnfW222lqNBroLU=;
        b=VwW2qlVU0qh1EuJY+/ou027QrVDPhgK82tta52X0oevbuMsbMnP4tsKqg2w03Nr9gRfOLq
        evZWTkjx8UKXaOCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Mop up old interfaces
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>, Jason Gunthorpe <jgg@nvidia.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211206210749.117395027@linutronix.de>
References: <20211206210749.117395027@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969082113.23020.11341834257245995885.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     cc9a246dbf6bdef56d9eee296a1db52dd0607976
Gitweb:        https://git.kernel.org/tip/cc9a246dbf6bdef56d9eee296a1db52dd0607976
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:20 +01:00

genirq/msi: Mop up old interfaces

Get rid of the old iterators, alloc/free functions and adjust the core code
accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210749.117395027@linutronix.de

---
 include/linux/msi.h | 15 ---------------
 kernel/irq/msi.c    | 31 +++++++++++++++----------------
 2 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index e8dd0be..b54010b 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -197,15 +197,7 @@ struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filter);
 	for ((desc) = msi_first_desc((dev), (filter)); (desc);	\
 	     (desc) = msi_next_desc((dev), (filter)))
 
-/* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
-#define dev_to_msi_list(dev)		(&(dev)->msi.data->list)
-#define first_msi_entry(dev)		\
-	list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
-#define for_each_msi_entry(desc, dev)	\
-	list_for_each_entry((desc), dev_to_msi_list((dev)), list)
-#define for_each_msi_entry_safe(desc, tmp, dev)	\
-	list_for_each_entry_safe((desc), (tmp), dev_to_msi_list((dev)), list)
 
 #ifdef CONFIG_IRQ_MSI_IOMMU
 static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
@@ -231,10 +223,6 @@ static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
 #endif
 
 #ifdef CONFIG_PCI_MSI
-#define first_pci_msi_entry(pdev)	first_msi_entry(&(pdev)->dev)
-#define for_each_pci_msi_entry(desc, pdev)	\
-	for_each_msi_entry((desc), &(pdev)->dev)
-
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc);
 void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
 #else /* CONFIG_PCI_MSI */
@@ -256,9 +244,6 @@ static inline void msi_free_msi_descs(struct device *dev)
 	msi_free_msi_descs_range(dev, MSI_DESC_ALL, 0, MSI_MAX_INDEX);
 }
 
-struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
-				 const struct irq_affinity_desc *affinity);
-void free_msi_entry(struct msi_desc *entry);
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 745434e..e8c1974 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -19,8 +19,10 @@
 
 #include "internals.h"
 
+#define dev_to_msi_list(dev)	(&(dev)->msi.data->list)
+
 /**
- * alloc_msi_entry - Allocate an initialized msi_desc
+ * msi_alloc_desc - Allocate an initialized msi_desc
  * @dev:	Pointer to the device for which this is allocated
  * @nvec:	The number of vectors used in this entry
  * @affinity:	Optional pointer to an affinity mask array size of @nvec
@@ -30,12 +32,11 @@
  *
  * Return: pointer to allocated &msi_desc on success or %NULL on failure
  */
-struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
-				 const struct irq_affinity_desc *affinity)
+static struct msi_desc *msi_alloc_desc(struct device *dev, int nvec,
+					const struct irq_affinity_desc *affinity)
 {
-	struct msi_desc *desc;
+	struct msi_desc *desc = kzalloc(sizeof(*desc), GFP_KERNEL);
 
-	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
 	if (!desc)
 		return NULL;
 
@@ -43,21 +44,19 @@ struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
 	desc->dev = dev;
 	desc->nvec_used = nvec;
 	if (affinity) {
-		desc->affinity = kmemdup(affinity,
-			nvec * sizeof(*desc->affinity), GFP_KERNEL);
+		desc->affinity = kmemdup(affinity, nvec * sizeof(*desc->affinity), GFP_KERNEL);
 		if (!desc->affinity) {
 			kfree(desc);
 			return NULL;
 		}
 	}
-
 	return desc;
 }
 
-void free_msi_entry(struct msi_desc *entry)
+static void msi_free_desc(struct msi_desc *desc)
 {
-	kfree(entry->affinity);
-	kfree(entry);
+	kfree(desc->affinity);
+	kfree(desc);
 }
 
 /**
@@ -73,7 +72,7 @@ int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc)
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
-	desc = alloc_msi_entry(dev, init_desc->nvec_used, init_desc->affinity);
+	desc = msi_alloc_desc(dev, init_desc->nvec_used, init_desc->affinity);
 	if (!desc)
 		return -ENOMEM;
 
@@ -102,7 +101,7 @@ static int msi_add_simple_msi_descs(struct device *dev, unsigned int index, unsi
 	lockdep_assert_held(&dev->msi.data->mutex);
 
 	for (i = 0; i < ndesc; i++) {
-		desc = alloc_msi_entry(dev, 1, NULL);
+		desc = msi_alloc_desc(dev, 1, NULL);
 		if (!desc)
 			goto fail;
 		desc->msi_index = index + i;
@@ -114,7 +113,7 @@ static int msi_add_simple_msi_descs(struct device *dev, unsigned int index, unsi
 fail:
 	list_for_each_entry_safe(desc, tmp, &list, list) {
 		list_del(&desc->list);
-		free_msi_entry(desc);
+		msi_free_desc(desc);
 	}
 	return -ENOMEM;
 }
@@ -141,7 +140,7 @@ void msi_free_msi_descs_range(struct device *dev, enum msi_desc_filter filter,
 		if (desc->msi_index < first_index || desc->msi_index > last_index)
 			continue;
 		list_del(&desc->list);
-		free_msi_entry(desc);
+		msi_free_desc(desc);
 	}
 }
 
@@ -745,7 +744,7 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 
 	msi_lock_descs(dev);
 	for (virq = virq_base; virq < virq_base + nvec; virq++) {
-		desc = alloc_msi_entry(dev, 1, NULL);
+		desc = msi_alloc_desc(dev, 1, NULL);
 		if (!desc) {
 			ret = -ENOMEM;
 			goto fail;

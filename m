Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA72477F35
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242322AbhLPVli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57174 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbhLPVko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:44 -0500
Date:   Thu, 16 Dec 2021 21:40:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/np0uiVuZr18Ur/eyv8ofzT64UItJrBsaKe3Qc91asg=;
        b=AS8dHRpZCnmLltQOuPHzC4jcFWAxZo1siivTp/eVFS2u8AECOmwQULeHtue+GjYAOEc/zn
        rPxcn2WPt0p8hq/NsYRgQ93pbejtz3JPVWUmCp52LhKu4jEjOvws7pyhk+Gr2haP2jDzup
        T+h6DmdAzwsl0RiWdHi1WZfry+o+RSPSVIM0e0+YHRhP6CEeo59NPbXbrFsBXA0ZkpU+MN
        1+XvNYqfkbVk4ToCfpmPnfITz0bYVZrzYTTwdRkjksYTLfYk9eS05Lic1CcK5OnrDro3Va
        iHnaB4S/Zw+hq+MWF6WfTia2xVIr49NnWHucwjPdO2EyV4/5dRnCE4fhtmLyjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/np0uiVuZr18Ur/eyv8ofzT64UItJrBsaKe3Qc91asg=;
        b=mdmqhmm0AXzc9TdN/Nl8VuLUsfnLfcgx9jr38Wtaz3FV1fv1GUNmuNPU/e4VVgxSt4rdc1
        DJyHwggnzDpF9cBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Provide a set of advanced MSI accessors
 and iterators
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>, Jason Gunthorpe <jgg@nvidia.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211206210747.818635078@linutronix.de>
References: <20211206210747.818635078@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969084205.23020.1722805465428923562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     1046f71d7268b1680d7b044dea83c664403f6302
Gitweb:        https://git.kernel.org/tip/1046f71d7268b1680d7b044dea83c664403f6302
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:17 +01:00

genirq/msi: Provide a set of advanced MSI accessors and iterators

In preparation for dynamic handling of MSI-X interrupts provide a new set
of MSI descriptor accessor functions and iterators. They are benefitial per
se as they allow to cleanup quite some code in various MSI domain
implementations.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210747.818635078@linutronix.de

---
 include/linux/msi.h | 33 +++++++++++++++-
 kernel/irq/msi.c    | 96 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 129 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 69c588e..703221f 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -140,6 +140,18 @@ struct msi_desc {
 	struct pci_msi_desc		pci;
 };
 
+/*
+ * Filter values for the MSI descriptor iterators and accessor functions.
+ */
+enum msi_desc_filter {
+	/* All descriptors */
+	MSI_DESC_ALL,
+	/* Descriptors which have no interrupt associated */
+	MSI_DESC_NOTASSOCIATED,
+	/* Descriptors which have an interrupt associated */
+	MSI_DESC_ASSOCIATED,
+};
+
 /**
  * msi_device_data - MSI per device data
  * @properties:		MSI properties which are interesting to drivers
@@ -147,6 +159,7 @@ struct msi_desc {
  * @platform_data:	Platform-MSI specific data
  * @list:		List of MSI descriptors associated to the device
  * @mutex:		Mutex protecting the MSI list
+ * @__next:		Cached pointer to the next entry for iterators
  */
 struct msi_device_data {
 	unsigned long			properties;
@@ -154,6 +167,7 @@ struct msi_device_data {
 	struct platform_msi_priv_data	*platform_data;
 	struct list_head		list;
 	struct mutex			mutex;
+	struct msi_desc			*__next;
 };
 
 int msi_setup_device_data(struct device *dev);
@@ -162,6 +176,25 @@ unsigned int msi_get_virq(struct device *dev, unsigned int index);
 void msi_lock_descs(struct device *dev);
 void msi_unlock_descs(struct device *dev);
 
+struct msi_desc *msi_first_desc(struct device *dev, enum msi_desc_filter filter);
+struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filter);
+
+/**
+ * msi_for_each_desc - Iterate the MSI descriptors
+ *
+ * @desc:	struct msi_desc pointer used as iterator
+ * @dev:	struct device pointer - device to iterate
+ * @filter:	Filter for descriptor selection
+ *
+ * Notes:
+ *  - The loop must be protected with a msi_lock_descs()/msi_unlock_descs()
+ *    pair.
+ *  - It is safe to remove a retrieved MSI descriptor in the loop.
+ */
+#define msi_for_each_desc(desc, dev, filter)			\
+	for ((desc) = msi_first_desc((dev), (filter)); (desc);	\
+	     (desc) = msi_next_desc((dev), (filter)))
+
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
 #define dev_to_msi_list(dev)		(&(dev)->msi.data->list)
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 3b21e99..bc67b2c 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -125,10 +125,106 @@ EXPORT_SYMBOL_GPL(msi_lock_descs);
  */
 void msi_unlock_descs(struct device *dev)
 {
+	/* Clear the next pointer which was cached by the iterator */
+	dev->msi.data->__next = NULL;
 	mutex_unlock(&dev->msi.data->mutex);
 }
 EXPORT_SYMBOL_GPL(msi_unlock_descs);
 
+static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filter)
+{
+	switch (filter) {
+	case MSI_DESC_ALL:
+		return true;
+	case MSI_DESC_NOTASSOCIATED:
+		return !desc->irq;
+	case MSI_DESC_ASSOCIATED:
+		return !!desc->irq;
+	}
+	WARN_ON_ONCE(1);
+	return false;
+}
+
+static struct msi_desc *msi_find_first_desc(struct device *dev, enum msi_desc_filter filter)
+{
+	struct msi_desc *desc;
+
+	list_for_each_entry(desc, dev_to_msi_list(dev), list) {
+		if (msi_desc_match(desc, filter))
+			return desc;
+	}
+	return NULL;
+}
+
+/**
+ * msi_first_desc - Get the first MSI descriptor of a device
+ * @dev:	Device to operate on
+ * @filter:	Descriptor state filter
+ *
+ * Must be called with the MSI descriptor mutex held, i.e. msi_lock_descs()
+ * must be invoked before the call.
+ *
+ * Return: Pointer to the first MSI descriptor matching the search
+ *	   criteria, NULL if none found.
+ */
+struct msi_desc *msi_first_desc(struct device *dev, enum msi_desc_filter filter)
+{
+	struct msi_desc *desc;
+
+	if (WARN_ON_ONCE(!dev->msi.data))
+		return NULL;
+
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	desc = msi_find_first_desc(dev, filter);
+	dev->msi.data->__next = desc ? list_next_entry(desc, list) : NULL;
+	return desc;
+}
+EXPORT_SYMBOL_GPL(msi_first_desc);
+
+static struct msi_desc *__msi_next_desc(struct device *dev, enum msi_desc_filter filter,
+					struct msi_desc *from)
+{
+	struct msi_desc *desc = from;
+
+	list_for_each_entry_from(desc, dev_to_msi_list(dev), list) {
+		if (msi_desc_match(desc, filter))
+			return desc;
+	}
+	return NULL;
+}
+
+/**
+ * msi_next_desc - Get the next MSI descriptor of a device
+ * @dev:	Device to operate on
+ *
+ * The first invocation of msi_next_desc() has to be preceeded by a
+ * successful incovation of __msi_first_desc(). Consecutive invocations are
+ * only valid if the previous one was successful. All these operations have
+ * to be done within the same MSI mutex held region.
+ *
+ * Return: Pointer to the next MSI descriptor matching the search
+ *	   criteria, NULL if none found.
+ */
+struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filter)
+{
+	struct msi_device_data *data = dev->msi.data;
+	struct msi_desc *desc;
+
+	if (WARN_ON_ONCE(!data))
+		return NULL;
+
+	lockdep_assert_held(&data->mutex);
+
+	if (!data->__next)
+		return NULL;
+
+	desc = __msi_next_desc(dev, filter, data->__next);
+	dev->msi.data->__next = desc ? list_next_entry(desc, list) : NULL;
+	return desc;
+}
+EXPORT_SYMBOL_GPL(msi_next_desc);
+
 /**
  * msi_get_virq - Return Linux interrupt number of a MSI interrupt
  * @dev:	Device to operate on

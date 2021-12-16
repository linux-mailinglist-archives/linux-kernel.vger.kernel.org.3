Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314AD477F00
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbhLPVke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:40:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56996 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241637AbhLPVkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:24 -0500
Date:   Thu, 16 Dec 2021 21:40:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690823;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLFKrvyFkHvS9qzq56m9tAPIWGMGUqpJTVcB8Vno7l4=;
        b=yt188pQdTGeUCBtCBVPLZUT2NFAKUSKfQ6b8WCccsMqfOflnjIJktugYoBk5tCYBSgeTbT
        Ru/Qd1CcRVWKuADl3pm/tg7yLw1hW5dHXHJykMFY9P9ozEZ9VbhEVAk8y0X9LHp5n6rkwV
        J8RoXOKgcvbQdpX19iak3YWXSIT41kepQQgqg0cz9xB5OSjvCm90xiv3d1onb4e4IcQaEi
        pfK2PLPW06T4z/Qu7J3vlEohb1jVNppfouuYooA2Ms45lJONvGbecs8Q4dKHMGufq90Tmr
        YVm5qCyKHsi0kBKMhrlin3z1F7kj0kd7fdCdNnFaS6GR6FPJnrNZEVusqNpy/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690823;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLFKrvyFkHvS9qzq56m9tAPIWGMGUqpJTVcB8Vno7l4=;
        b=LW+7ZfL7XmR3v0EQg+1mqDLYC3Jil3honmXgcTPbqXoOYKnwrzh7N1My9Qpd69qhwou0o9
        YPR5t5UCY/5ZLjCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Convert to new functions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>, Jason Gunthorpe <jgg@nvidia.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211206210749.063705667@linutronix.de>
References: <20211206210749.063705667@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969082200.23020.8024498417506384180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     495c66aca3da704e063fa373fdbe371e71d3f4ee
Gitweb:        https://git.kernel.org/tip/495c66aca3da704e063fa373fdbe371e71d3f4ee
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:20 +01:00

genirq/msi: Convert to new functions

Use the new iterator functions and add locking where required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210749.063705667@linutronix.de

---
 kernel/irq/msi.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index bbe36e2..745434e 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -320,6 +320,7 @@ EXPORT_SYMBOL_GPL(msi_next_desc);
 unsigned int msi_get_virq(struct device *dev, unsigned int index)
 {
 	struct msi_desc *desc;
+	unsigned int ret = 0;
 	bool pcimsi;
 
 	if (!dev->msi.data)
@@ -327,11 +328,12 @@ unsigned int msi_get_virq(struct device *dev, unsigned int index)
 
 	pcimsi = dev_is_pci(dev) ? to_pci_dev(dev)->msi_enabled : false;
 
-	for_each_msi_entry(desc, dev) {
+	msi_lock_descs(dev);
+	msi_for_each_desc(desc, dev, MSI_DESC_ASSOCIATED) {
 		/* PCI-MSI has only one descriptor for multiple interrupts. */
 		if (pcimsi) {
-			if (desc->irq && index < desc->nvec_used)
-				return desc->irq + index;
+			if (index < desc->nvec_used)
+				ret = desc->irq + index;
 			break;
 		}
 
@@ -339,10 +341,13 @@ unsigned int msi_get_virq(struct device *dev, unsigned int index)
 		 * PCI-MSIX and platform MSI use a descriptor per
 		 * interrupt.
 		 */
-		if (desc->msi_index == index)
-			return desc->irq;
+		if (desc->msi_index == index) {
+			ret = desc->irq;
+			break;
+		}
 	}
-	return 0;
+	msi_unlock_descs(dev);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(msi_get_virq);
 
@@ -373,7 +378,7 @@ static const struct attribute_group **msi_populate_sysfs(struct device *dev)
 	int i;
 
 	/* Determine how many msi entries we have */
-	for_each_msi_entry(entry, dev)
+	msi_for_each_desc(entry, dev, MSI_DESC_ALL)
 		num_msi += entry->nvec_used;
 	if (!num_msi)
 		return NULL;
@@ -383,7 +388,7 @@ static const struct attribute_group **msi_populate_sysfs(struct device *dev)
 	if (!msi_attrs)
 		return ERR_PTR(-ENOMEM);
 
-	for_each_msi_entry(entry, dev) {
+	msi_for_each_desc(entry, dev, MSI_DESC_ALL) {
 		for (i = 0; i < entry->nvec_used; i++) {
 			msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
 			if (!msi_dev_attr)
@@ -803,7 +808,7 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
 	 * Checking the first MSI descriptor is sufficient. MSIX supports
 	 * masking and MSI does so when the can_mask attribute is set.
 	 */
-	desc = first_msi_entry(dev);
+	desc = msi_first_desc(dev, MSI_DESC_ALL);
 	return desc->pci.msi_attrib.is_msix || desc->pci.msi_attrib.can_mask;
 }
 

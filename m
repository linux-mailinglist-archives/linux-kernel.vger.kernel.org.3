Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E1B46ECA2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbhLIQKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240808AbhLIQKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99238C061A72;
        Thu,  9 Dec 2021 08:07:02 -0800 (PST)
Date:   Thu, 09 Dec 2021 16:07:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bLbCdVGmdvyzrH0hfIyB++HNkUPCuMKKRBn9v7MX+o=;
        b=YUeVpvmh/R/njqRu1xE8tV+GUPxo6g7RwEbH62PqH/DEyrqEPO9Tz8CqhU2hMzg8Odxc90
        xHC5EASa6gk0wqciDf/phA38lsLmHBf9PbefsQJb+mWpRqw8UL9PQc37cmizzoCU/DPmTE
        8ObFsCCdR/JTvBYbKtljrmZDIOfCxf0YMV9j6kBYpbW2EZvO/f17p1iPyYENb0qJTtaQFM
        5npJAKIbfPs1K97Q8o9V7quxxK1yqBnd2ke5qc++MnLvAbkssDPnLDPtJsP2UK/uXzNSKC
        KotFxcrqI5M1/JU8Ek1TfTgHUkwy380O3KcHMyA4bt4R/zFHST8+XpdeYW2mqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bLbCdVGmdvyzrH0hfIyB++HNkUPCuMKKRBn9v7MX+o=;
        b=SWbsJym3WlnqAA7UYZB+gXx/lJzpGm5VKWSPuZ00ooxEJSgaUt8a0iGvqJo8Wduc6FbUqY
        WfkVOCJBhVXsoBAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Sanitize MSI-X table map handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210224.871651518@linutronix.de>
References: <20211206210224.871651518@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906602027.11128.17038944347143582595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     85aa607e79f8343f1ea028b29bdf8b6bc99c729a
Gitweb:        https://git.kernel.org/tip/85aa607e79f8343f1ea028b29bdf8b6bc99c729a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:22 +01:00

PCI/MSI: Sanitize MSI-X table map handling

Unmapping the MSI-X base mapping in the loops which allocate/free MSI
descriptors is daft and in the way of allowing runtime expansion of MSI-X
descriptors.

Store the mapping in struct pci_dev and free it after freeing the MSI-X
descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211206210224.871651518@linutronix.de

---
 drivers/pci/msi/msi.c | 18 ++++++++----------
 include/linux/pci.h   |  1 +
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 8926a6c..465fe9e 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -241,14 +241,14 @@ static void free_msi_irqs(struct pci_dev *dev)
 	pci_msi_teardown_msi_irqs(dev);
 
 	list_for_each_entry_safe(entry, tmp, msi_list, list) {
-		if (entry->pci.msi_attrib.is_msix) {
-			if (list_is_last(&entry->list, msi_list))
-				iounmap(entry->pci.mask_base);
-		}
-
 		list_del(&entry->list);
 		free_msi_entry(entry);
 	}
+
+	if (dev->msix_base) {
+		iounmap(dev->msix_base);
+		dev->msix_base = NULL;
+	}
 }
 
 static void pci_intx_for_msi(struct pci_dev *dev, int enable)
@@ -501,10 +501,6 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 	for (i = 0, curmsk = masks; i < nvec; i++) {
 		entry = alloc_msi_entry(&dev->dev, 1, curmsk);
 		if (!entry) {
-			if (!i)
-				iounmap(base);
-			else
-				free_msi_irqs(dev);
 			/* No enough memory. Don't try again */
 			ret = -ENOMEM;
 			goto out;
@@ -602,12 +598,14 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 		goto out_disable;
 	}
 
+	dev->msix_base = base;
+
 	/* Ensure that all table entries are masked. */
 	msix_mask_all(base, tsize);
 
 	ret = msix_setup_entries(dev, base, entries, nvec, affd);
 	if (ret)
-		goto out_disable;
+		goto out_free;
 
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
 	if (ret)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 18a75c8..8cb1036 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -473,6 +473,7 @@ struct pci_dev {
 	u8		ptm_granularity;
 #endif
 #ifdef CONFIG_PCI_MSI
+	void __iomem	*msix_base;
 	const struct attribute_group **msi_irq_groups;
 #endif
 	struct pci_vpd	vpd;

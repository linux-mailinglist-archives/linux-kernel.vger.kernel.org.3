Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEA1477F31
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242039AbhLPVle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241742AbhLPVkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31C6C061747;
        Thu, 16 Dec 2021 13:40:40 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:40:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690838;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o86yj3urjC1jTGwF2v/r3Z85d0CnJ5GgjPhkDf6vCo0=;
        b=dO84T1I9WM4VrR5nHD6V+WMOxGbyZOyMK2Y6LLTok5kkKUPs4D217+UVi+GP2siEcpmctq
        AqgKN9Lx5LSXKIlICmLVN1PETS6VOzAy4/242qkH0f7h7/IJaXGDnLPnO0nylTVyjRNsd4
        cbMxqQXd6N5m8UNG4XVhC+AAYLjq7ATbBCsfuBjRYLHdj7xT5r0H9wfx7qnH2KvRJ5v1l3
        YDF4YFH57dbcLSJsxmOVZySFB9yyCBffEm18XyoHT66V7UfDSN92C9eJmhyMziRC81ZGYL
        tea9cmGo0PK99QOy7jMBjd3b6gXp/CQeAC+Tj8Mcqywr41TjWoF1QWs2JL1ldQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690838;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o86yj3urjC1jTGwF2v/r3Z85d0CnJ5GgjPhkDf6vCo0=;
        b=Nu2zBN5tkb//HKEVhgXQjpT7q9QqblS3eSX/yrq+8kfuot4jdxbUQgFKLK85EX/SE3pymG
        PDW1D47mE0J7ySDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Use msi_on_each_desc()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210748.142603657@linutronix.de>
References: <20211206210748.142603657@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969083730.23020.14306105823073910744.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     ae24e28fef14687a26f98050e64153b8e4fee7c7
Gitweb:        https://git.kernel.org/tip/ae24e28fef14687a26f98050e64153b8e4fee7c7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:18 +01:00

PCI/MSI: Use msi_on_each_desc()

Use the new iterator functions which pave the way for dynamically extending
MSI-X vectors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211206210748.142603657@linutronix.de

---
 drivers/pci/msi/irqdomain.c |  4 ++--
 drivers/pci/msi/legacy.c    | 19 ++++++++-----------
 drivers/pci/msi/msi.c       | 30 ++++++++++++++----------------
 3 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 3aab617..0d63541 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -83,7 +83,7 @@ static int pci_msi_domain_check_cap(struct irq_domain *domain,
 				    struct msi_domain_info *info,
 				    struct device *dev)
 {
-	struct msi_desc *desc = first_pci_msi_entry(to_pci_dev(dev));
+	struct msi_desc *desc = msi_first_desc(dev, MSI_DESC_ALL);
 
 	/* Special handling to support __pci_enable_msi_range() */
 	if (pci_msi_desc_is_multi_msi(desc) &&
@@ -98,7 +98,7 @@ static int pci_msi_domain_check_cap(struct irq_domain *domain,
 			unsigned int idx = 0;
 
 			/* Check for gaps in the entry indices */
-			for_each_msi_entry(desc, dev) {
+			msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
 				if (desc->msi_index != idx++)
 					return -ENOTSUPP;
 			}
diff --git a/drivers/pci/msi/legacy.c b/drivers/pci/msi/legacy.c
index 91c20a3..cdbb468 100644
--- a/drivers/pci/msi/legacy.c
+++ b/drivers/pci/msi/legacy.c
@@ -28,7 +28,7 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (type == PCI_CAP_ID_MSI && nvec > 1)
 		return 1;
 
-	for_each_pci_msi_entry(desc, dev) {
+	msi_for_each_desc(desc, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		ret = arch_setup_msi_irq(dev, desc);
 		if (ret)
 			return ret < 0 ? ret : -ENOSPC;
@@ -42,27 +42,24 @@ void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
 	struct msi_desc *desc;
 	int i;
 
-	for_each_pci_msi_entry(desc, dev) {
-		if (desc->irq) {
-			for (i = 0; i < desc->nvec_used; i++)
-				arch_teardown_msi_irq(desc->irq + i);
-		}
+	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ASSOCIATED) {
+		for (i = 0; i < desc->nvec_used; i++)
+			arch_teardown_msi_irq(desc->irq + i);
 	}
 }
 
 static int pci_msi_setup_check_result(struct pci_dev *dev, int type, int ret)
 {
-	struct msi_desc *entry;
+	struct msi_desc *desc;
 	int avail = 0;
 
 	if (type != PCI_CAP_ID_MSIX || ret >= 0)
 		return ret;
 
 	/* Scan the MSI descriptors for successfully allocated ones. */
-	for_each_pci_msi_entry(entry, dev) {
-		if (entry->irq != 0)
-			avail++;
-	}
+	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ASSOCIATED)
+		avail++;
+
 	return avail ? avail : ret;
 }
 
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 95db9c3..7180241 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -297,7 +297,6 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 
 	if (!dev->msix_enabled)
 		return;
-	BUG_ON(list_empty(dev_to_msi_list(&dev->dev)));
 
 	/* route the table */
 	pci_intx_for_msi(dev, 0);
@@ -307,7 +306,7 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 	write_msg = arch_restore_msi_irqs(dev);
 
 	msi_lock_descs(&dev->dev);
-	for_each_pci_msi_entry(entry, dev) {
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
 		if (write_msg)
 			__pci_write_msi_msg(entry, &entry->msg);
 		pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
@@ -406,14 +405,14 @@ static int msi_verify_entries(struct pci_dev *dev)
 	if (!dev->no_64bit_msi)
 		return 0;
 
-	for_each_pci_msi_entry(entry, dev) {
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
 		if (entry->msg.address_hi) {
 			pci_err(dev, "arch assigned 64-bit MSI address %#x%08x but device only supports 32 bits\n",
 				entry->msg.address_hi, entry->msg.address_lo);
-			return -EIO;
+			break;
 		}
 	}
-	return 0;
+	return !entry ? 0 : -EIO;
 }
 
 /**
@@ -451,7 +450,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 		goto fail;
 
 	/* All MSIs are unmasked by default; mask them all */
-	entry = first_pci_msi_entry(dev);
+	entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
 	pci_msi_mask(entry, msi_multi_mask(entry));
 
 	/* Configure MSI capability structure */
@@ -541,11 +540,11 @@ static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
 
 static void msix_update_entries(struct pci_dev *dev, struct msix_entry *entries)
 {
-	struct msi_desc *entry;
+	struct msi_desc *desc;
 
 	if (entries) {
-		for_each_pci_msi_entry(entry, dev) {
-			entries->vector = entry->irq;
+		msi_for_each_desc(desc, &dev->dev, MSI_DESC_ALL) {
+			entries->vector = desc->irq;
 			entries++;
 		}
 	}
@@ -747,15 +746,14 @@ static void pci_msi_shutdown(struct pci_dev *dev)
 	if (!pci_msi_enable || !dev || !dev->msi_enabled)
 		return;
 
-	BUG_ON(list_empty(dev_to_msi_list(&dev->dev)));
-	desc = first_pci_msi_entry(dev);
-
 	pci_msi_set_enable(dev, 0);
 	pci_intx_for_msi(dev, 1);
 	dev->msi_enabled = 0;
 
 	/* Return the device with MSI unmasked as initial states */
-	pci_msi_unmask(desc, msi_multi_mask(desc));
+	desc = msi_first_desc(&dev->dev, MSI_DESC_ALL);
+	if (!WARN_ON_ONCE(!desc))
+		pci_msi_unmask(desc, msi_multi_mask(desc));
 
 	/* Restore dev->irq to its default pin-assertion IRQ */
 	dev->irq = desc->pci.msi_attrib.default_irq;
@@ -831,7 +829,7 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
 
 static void pci_msix_shutdown(struct pci_dev *dev)
 {
-	struct msi_desc *entry;
+	struct msi_desc *desc;
 
 	if (!pci_msi_enable || !dev || !dev->msix_enabled)
 		return;
@@ -842,8 +840,8 @@ static void pci_msix_shutdown(struct pci_dev *dev)
 	}
 
 	/* Return the device with MSI-X masked as initial states */
-	for_each_pci_msi_entry(entry, dev)
-		pci_msix_mask(entry);
+	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ALL)
+		pci_msix_mask(desc);
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 	pci_intx_for_msi(dev, 1);

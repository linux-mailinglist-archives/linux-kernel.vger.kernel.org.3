Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC324477F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbhLPVnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:43:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57558 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241941AbhLPVlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:17 -0500
Date:   Thu, 16 Dec 2021 21:41:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ehjucClV0RZ8wwaHaSh0N8JcgLZ8rROkpZNSYCo1SI0=;
        b=tHNL2nf7vcPU0/JCUqL3Z85vwBTWvZVFn0RZWqNyhc0yBMHmk7l3FZNjhn6xNR32GZgMLO
        nzJlPGcNo2n6kpv73s877LUg2DlSMqc29v/Bhz1Yt6GHv3etZhdC0CoLEjSrjwlN+kgAVK
        r6Ec3NTZEWNO9vUjeyRn9SP8UOGz+pAz0qCKVxYD0zUP8f0CpUE1mY0VWKgHh0QBH6aVo0
        PnrQuesX5mTiwhgil29ezdDdwXMG2CxogxoqzyFSq7wmRtPNCtEaKdfhNlK44csxVYHR0S
        OHfpLsMKV3gKDj8Eo/ZdYMyfhLPZ0uXKu9/1BPiM41ct2833v1kmDUpYbyCeLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ehjucClV0RZ8wwaHaSh0N8JcgLZ8rROkpZNSYCo1SI0=;
        b=EGCCEI+nf5qqcbPj7ROSwklzv39qNFxlPLKMTUko5zBI48uwr2RbKPNdZ+Ff5WYUooCkOn
        MG+nmIrTJZO7QJAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Set pci_dev::msi[x]_enabled early
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>, Jason Gunthorpe <jgg@nvidia.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211210221813.250049810@linutronix.de>
References: <20211210221813.250049810@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969087559.23020.12079408218134390263.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     c7ecb95ca6a80b29af0f41cc28c58e542637fbc6
Gitweb:        https://git.kernel.org/tip/c7ecb95ca6a80b29af0f41cc28c58e542637fbc6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:18:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:37 +01:00

PCI/MSI: Set pci_dev::msi[x]_enabled early

There are quite some places which retrieve the first MSI descriptor to
evaluate whether the setup is for MSI or MSI-X. That's required because
pci_dev::msi[x]_enabled is only set when the setup completed successfully.

There is no real reason why msi[x]_enabled can't be set at the beginning of
the setup sequence and cleared in case of a failure.

Implement that so the MSI descriptor evaluations can be converted to simple
property queries.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221813.250049810@linutronix.de

---
 drivers/pci/msi/msi.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index eb917fe..5af8d9b 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -421,11 +421,18 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	struct msi_desc *entry;
 	int ret;
 
-	pci_msi_set_enable(dev, 0);	/* Disable MSI during set up */
+	/*
+	 * Disable MSI during setup in the hardware, but mark it enabled
+	 * so that setup code can evaluate it.
+	 */
+	pci_msi_set_enable(dev, 0);
+	dev->msi_enabled = 1;
 
 	entry = msi_setup_entry(dev, nvec, affd);
-	if (!entry)
-		return -ENOMEM;
+	if (!entry) {
+		ret = -ENOMEM;
+		goto fail;
+	}
 
 	/* All MSIs are unmasked by default; mask them all */
 	pci_msi_mask(entry, msi_multi_mask(entry));
@@ -452,7 +459,6 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	/* Set MSI enabled bits	*/
 	pci_intx_for_msi(dev, 0);
 	pci_msi_set_enable(dev, 1);
-	dev->msi_enabled = 1;
 
 	pcibios_free_irq(dev);
 	dev->irq = entry->irq;
@@ -461,6 +467,8 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 err:
 	pci_msi_unmask(entry, msi_multi_mask(entry));
 	free_msi_irqs(dev);
+fail:
+	dev->msi_enabled = 0;
 	return ret;
 }
 
@@ -589,6 +597,9 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	pci_msix_clear_and_set_ctrl(dev, 0, PCI_MSIX_FLAGS_MASKALL |
 				    PCI_MSIX_FLAGS_ENABLE);
 
+	/* Mark it enabled so setup functions can query it */
+	dev->msix_enabled = 1;
+
 	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
 	/* Request & Map MSI-X table region */
 	tsize = msix_table_size(control);
@@ -623,9 +634,8 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 
 	dev->msi_irq_groups = groups;
 
-	/* Set MSI-X enabled bits and unmask the function */
+	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
-	dev->msix_enabled = 1;
 
 	/*
 	 * Ensure that all table entries are masked to prevent
@@ -645,6 +655,7 @@ out_free:
 	free_msi_irqs(dev);
 
 out_disable:
+	dev->msix_enabled = 0;
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE, 0);
 
 	return ret;

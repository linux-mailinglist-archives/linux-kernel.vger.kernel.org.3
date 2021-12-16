Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1AF477F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242493AbhLPVmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57376 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbhLPVlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:00 -0500
Date:   Thu, 16 Dec 2021 21:40:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ct10nt8Ns9ag2mXolFIFHfKBOp2VRzG+6KPR2fBTYXk=;
        b=oJtNAE7l1cuY4sHVLPs7XYFWrvOs/+0TlwrbMaLLkV1ydQDl/kguhVlzFkGxuU2aQytdzv
        NxJKAHohP0mj2QKanp2LUssh/BjhJGaeRg4gHr3jFmBqAicR8hgduIwi9acSl3xUM7IjJk
        FACiAGrcGXYohSkUsKr/zk+x1Hz0FoOGi+Kxz3H493xlhbQpxOYn21R/vKJ/9xk1zEYXqQ
        BB3BX+Qst3M3vXIr2+4Mq4p6XiPZl65dhkn4qCK05dtQKzrMuP0W8uoRHe2wYcBV5GmSQ0
        YoL/Chsj5hfcBYdloPNoxKw6gEyQQGvlOJtk4I7FjIXrXKBu3oFZ7BWomW4Siw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ct10nt8Ns9ag2mXolFIFHfKBOp2VRzG+6KPR2fBTYXk=;
        b=9cpWoIRkwx2VZEs0Himnf2J6P+Sb2iu+0LVzFhhh496/DfX1h1NdHzkpwgzXscyhPsk8hR
        UtSBH728HsqpBPCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] platform-msi: Use msi_desc::msi_index
Cc:     Thomas Gleixner <tglx@linutronix.de>, Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221814.413638645@linutronix.de>
References: <20211210221814.413638645@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969085808.23020.15018299228145670846.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     dba27c7fa36f468e7eb29b216879f8c33bf0955d
Gitweb:        https://git.kernel.org/tip/dba27c7fa36f468e7eb29b216879f8c33bf0955d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:40 +01:00

platform-msi: Use msi_desc::msi_index

Use the common msi_index member and get rid of the pointless wrapper struct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221814.413638645@linutronix.de

---
 drivers/base/platform-msi.c                 | 10 +++++-----
 drivers/dma/qcom/hidma.c                    |  4 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  4 ++--
 drivers/mailbox/bcm-flexrm-mailbox.c        |  4 ++--
 include/linux/msi.h                         | 10 ----------
 5 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 1487906..88bdc4b 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -40,7 +40,7 @@ static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
 {
 	u32 devid = desc->dev->msi.data->platform_data->devid;
 
-	return (devid << (32 - DEV_ID_SHIFT)) | desc->platform.msi_index;
+	return (devid << (32 - DEV_ID_SHIFT)) | desc->msi_index;
 }
 
 static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
@@ -112,8 +112,8 @@ static void platform_msi_free_descs(struct device *dev, int base, int nvec)
 	struct msi_desc *desc, *tmp;
 
 	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
-		if (desc->platform.msi_index >= base &&
-		    desc->platform.msi_index < (base + nvec)) {
+		if (desc->msi_index >= base &&
+		    desc->msi_index < (base + nvec)) {
 			list_del(&desc->list);
 			free_msi_entry(desc);
 		}
@@ -129,7 +129,7 @@ static int platform_msi_alloc_descs_with_irq(struct device *dev, int virq,
 	if (!list_empty(dev_to_msi_list(dev))) {
 		desc = list_last_entry(dev_to_msi_list(dev),
 				       struct msi_desc, list);
-		base = desc->platform.msi_index + 1;
+		base = desc->msi_index + 1;
 	}
 
 	for (i = 0; i < nvec; i++) {
@@ -137,7 +137,7 @@ static int platform_msi_alloc_descs_with_irq(struct device *dev, int virq,
 		if (!desc)
 			break;
 
-		desc->platform.msi_index = base + i;
+		desc->msi_index = base + i;
 		desc->irq = virq ? virq + i : 0;
 
 		list_add_tail(&desc->list, dev_to_msi_list(dev));
diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 23d6448..db8241b 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -666,7 +666,7 @@ static void hidma_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	struct device *dev = msi_desc_to_dev(desc);
 	struct hidma_dev *dmadev = dev_get_drvdata(dev);
 
-	if (!desc->platform.msi_index) {
+	if (!desc->msi_index) {
 		writel(msg->address_lo, dmadev->dev_evca + 0x118);
 		writel(msg->address_hi, dmadev->dev_evca + 0x11C);
 		writel(msg->data, dmadev->dev_evca + 0x120);
@@ -702,7 +702,7 @@ static int hidma_request_msi(struct hidma_dev *dmadev,
 		return rc;
 
 	for_each_msi_entry(desc, &pdev->dev) {
-		if (!desc->platform.msi_index)
+		if (!desc->msi_index)
 			dmadev->msi_virqbase = desc->irq;
 
 		rc = devm_request_irq(&pdev->dev, desc->irq,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5ba9006..beaf91b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3142,7 +3142,7 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	phys_addr_t doorbell;
 	struct device *dev = msi_desc_to_dev(desc);
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
-	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->platform.msi_index];
+	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
 
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &= MSI_CFG0_ADDR_MASK;
@@ -3183,7 +3183,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	}
 
 	for_each_msi_entry(desc, dev) {
-		switch (desc->platform.msi_index) {
+		switch (desc->msi_index) {
 		case EVTQ_MSI_INDEX:
 			smmu->evtq.q.irq = desc->irq;
 			break;
diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index 78073ad..53a8473 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1484,7 +1484,7 @@ static void flexrm_mbox_msi_write(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct device *dev = msi_desc_to_dev(desc);
 	struct flexrm_mbox *mbox = dev_get_drvdata(dev);
-	struct flexrm_ring *ring = &mbox->rings[desc->platform.msi_index];
+	struct flexrm_ring *ring = &mbox->rings[desc->msi_index];
 
 	/* Configure per-Ring MSI registers */
 	writel_relaxed(msg->address_lo, ring->regs + RING_MSI_ADDR_LS);
@@ -1609,7 +1609,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 
 	/* Save alloced IRQ numbers for each ring */
 	for_each_msi_entry(desc, dev) {
-		ring = &mbox->rings[desc->platform.msi_index];
+		ring = &mbox->rings[desc->msi_index];
 		ring->irq = desc->irq;
 	}
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index ee8fe49..1d85e95 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -107,14 +107,6 @@ struct pci_msi_desc {
 };
 
 /**
- * platform_msi_desc - Platform device specific msi descriptor data
- * @msi_index:		The index of the MSI descriptor for multi MSI
- */
-struct platform_msi_desc {
-	u16				msi_index;
-};
-
-/**
  * fsl_mc_msi_desc - FSL-MC device specific msi descriptor data
  * @msi_index:		The index of the MSI descriptor
  */
@@ -145,7 +137,6 @@ struct ti_sci_inta_msi_desc {
  *
  * @msi_index:	Index of the msi descriptor
  * @pci:	[PCI]	    PCI speficic msi descriptor data
- * @platform:	[platform]  Platform device specific msi descriptor data
  * @fsl_mc:	[fsl-mc]    FSL MC device specific msi descriptor data
  * @inta:	[INTA]	    TISCI based INTA specific msi descriptor data
  */
@@ -167,7 +158,6 @@ struct msi_desc {
 	u16				msi_index;
 	union {
 		struct pci_msi_desc		pci;
-		struct platform_msi_desc	platform;
 		struct fsl_mc_msi_desc		fsl_mc;
 		struct ti_sci_inta_msi_desc	inta;
 	};

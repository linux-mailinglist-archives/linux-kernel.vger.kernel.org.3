Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2B7477F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241845AbhLPVlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57254 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241929AbhLPVkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:51 -0500
Date:   Thu, 16 Dec 2021 21:40:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vx9q/OKEAuARzOipKbXx2UL4MaQW/A6Jfok4RpEYqhY=;
        b=CJHWXxKA7HxH8d4q2YNnnSn6yaR1JUJNVT6zQpYV5hCOZUYcP0eMPldxuqZsebA5eji18x
        igDg5z8wMEk156t1+HYnrKE0PgiQajiBfglEOLzV/vFVBfyjb0h17nz2Vv8x1mqW5cAkxa
        DxJDJoPes1bx6ZM0o5avc3sxJ6c5nNGUIg8dGngLLkcPcloBv64Jrk8jvUFeEdh2N9Y2+T
        XRVlcxSFKry57y6ZV8on7tqkrtrRRHWzB6BnZlPpclKW2t/kMPqsaZz4NnoXcoqdSY+WNo
        HRzbaW25RUPIxUqXfbK21MKANyirzM6NEPKK9dgVIlejDUPyOUor/J8fT1CRLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vx9q/OKEAuARzOipKbXx2UL4MaQW/A6Jfok4RpEYqhY=;
        b=xcurUA5jpFT6LFS8uJf9I4eZQob5/ustI+n/vIBG1aHQGu8dIFxvEheaP49Ji5/jgsBviS
        t7bmsdWHq5gRYQDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] iommu/arm-smmu-v3: Use msi_get_virq()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221815.089008198@linutronix.de>
References: <20211210221815.089008198@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969084862.23020.7966952286134267019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     065afdc9c521f05c53f226dabe5dda2d30294d65
Gitweb:        https://git.kernel.org/tip/065afdc9c521f05c53f226dabe5dda2d30294d65
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:41 +01:00

iommu/arm-smmu-v3: Use msi_get_virq()

Let the core code fiddle with the MSI descriptor retrieval.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221815.089008198@linutronix.de


---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index beaf91b..6dc6d8b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3154,7 +3154,6 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 
 static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 {
-	struct msi_desc *desc;
 	int ret, nvec = ARM_SMMU_MAX_MSIS;
 	struct device *dev = smmu->dev;
 
@@ -3182,21 +3181,9 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 		return;
 	}
 
-	for_each_msi_entry(desc, dev) {
-		switch (desc->msi_index) {
-		case EVTQ_MSI_INDEX:
-			smmu->evtq.q.irq = desc->irq;
-			break;
-		case GERROR_MSI_INDEX:
-			smmu->gerr_irq = desc->irq;
-			break;
-		case PRIQ_MSI_INDEX:
-			smmu->priq.q.irq = desc->irq;
-			break;
-		default:	/* Unknown */
-			continue;
-		}
-	}
+	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
+	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
+	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
 
 	/* Add callback to free MSIs on teardown */
 	devm_add_action(dev, arm_smmu_free_msis, dev);

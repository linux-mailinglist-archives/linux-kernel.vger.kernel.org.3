Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E398477F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbhLPVlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57270 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241700AbhLPVkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:52 -0500
Date:   Thu, 16 Dec 2021 21:40:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oc2t8QzXFyZaemdzOfmaVoNVhPn47PCmRDTIBSsTcK0=;
        b=fQjgIYfj3DpN3Aptdv3HS4mccAYQ291q/jUBNdlL0DyciLu1SWghwsHFXbhTzVs4d4DBxe
        uP2bezpWsbGV3rb1I01erc5ypgou9PYcjNIEwIm+NqRuDSerBdA/2K2tEQTuV1y6zYxUU0
        gwragh1QamD/VB9N1+odmv8d1IXpS2+PnqzVExLjMNTNN+HFWKYi8McOiCJIMoX5aCguOI
        L9ha1jKAGMlWRKdb4joQUZsCetPHNwPTwRak2vdHahcrF47RtkGbgNWAXtRRC8Y77xVmjA
        9OqSdHYHR/pkhPLnu4DstQ5qgfNOjL8ZZo/t3rfS1eP7wY1ZXpXyVEqXun+1+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oc2t8QzXFyZaemdzOfmaVoNVhPn47PCmRDTIBSsTcK0=;
        b=ygEAavy7/sypw1aO8ukqxi54bcipY3lRDXuuB+KAOTzS7ID5n/C3qXqfXLKN6lGNSfH8k0
        AOuqXJ3/RPm+dKAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] dmaengine: mv_xor_v2: Get rid of msi_desc abuse
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221814.970099984@linutronix.de>
References: <20211210221814.970099984@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969085050.23020.8932706347139168359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     f6632bb2c1454b857adcd131320379ec16fd8666
Gitweb:        https://git.kernel.org/tip/f6632bb2c1454b857adcd131320379ec16fd8666
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:41 +01:00

dmaengine: mv_xor_v2: Get rid of msi_desc abuse

Storing a pointer to the MSI descriptor just to keep track of the Linux
interrupt number is daft. Use msi_get_virq() instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20211210221814.970099984@linutronix.de

---
 drivers/dma/mv_xor_v2.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 9b0d463..9c8b408 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -149,7 +149,7 @@ struct mv_xor_v2_descriptor {
  * @desc_size: HW descriptor size
  * @npendings: number of pending descriptors (for which tx_submit has
  * @hw_queue_idx: HW queue index
- * @msi_desc: local interrupt descriptor information
+ * @irq: The Linux interrupt number
  * been called, but not yet issue_pending)
  */
 struct mv_xor_v2_device {
@@ -168,7 +168,7 @@ struct mv_xor_v2_device {
 	int desc_size;
 	unsigned int npendings;
 	unsigned int hw_queue_idx;
-	struct msi_desc *msi_desc;
+	unsigned int irq;
 };
 
 /**
@@ -718,7 +718,6 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 	int i, ret = 0;
 	struct dma_device *dma_dev;
 	struct mv_xor_v2_sw_desc *sw_desc;
-	struct msi_desc *msi_desc;
 
 	BUILD_BUG_ON(sizeof(struct mv_xor_v2_descriptor) !=
 		     MV_XOR_V2_EXT_DESC_SIZE);
@@ -770,14 +769,9 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_clk;
 
-	msi_desc = first_msi_entry(&pdev->dev);
-	if (!msi_desc) {
-		ret = -ENODEV;
-		goto free_msi_irqs;
-	}
-	xor_dev->msi_desc = msi_desc;
+	xor_dev->irq = msi_get_virq(&pdev->dev, 0);
 
-	ret = devm_request_irq(&pdev->dev, msi_desc->irq,
+	ret = devm_request_irq(&pdev->dev, xor_dev->irq,
 			       mv_xor_v2_interrupt_handler, 0,
 			       dev_name(&pdev->dev), xor_dev);
 	if (ret)
@@ -892,7 +886,7 @@ static int mv_xor_v2_remove(struct platform_device *pdev)
 			  xor_dev->desc_size * MV_XOR_V2_DESC_NUM,
 			  xor_dev->hw_desq_virt, xor_dev->hw_desq);
 
-	devm_free_irq(&pdev->dev, xor_dev->msi_desc->irq, xor_dev);
+	devm_free_irq(&pdev->dev, xor_dev->irq, xor_dev);
 
 	platform_msi_domain_free_irqs(&pdev->dev);
 

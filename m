Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED05477F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbhLPVmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242046AbhLPVlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A8CC061785;
        Thu, 16 Dec 2021 13:40:47 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:40:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PDMVcI0ALoAL2bZp03niToUbpaPHtm8qD96IAb+ePAE=;
        b=N0HVCCFlF/eINc802zGURdZwioMMFErtZhL7q3NNv0Ekv2EolFZmzMXQ7IKNWTQp22KG+9
        Qg2YGrI+i0OOlyMe+pHwHlrHxwDwU/cNO2Jo6CMdqIjQCndgF5Ku0lDVjC3nhos5rDEVG8
        sNlIjF4Fn1Mzi8aIkNLrgNQV4Z1wK854SeJBLRzOkfLem5u+5WUP6gaOsyoed+3PH+oW1v
        a9zEwEujQxexyErugzMhfKmJpWxqrsRPD8MlA9Yw33jfwW81vm6UPEnJH7jnzTtEruOamo
        7eYEggZl/vRKNawDsHHDwa1i2tUXksNrK5VCSVuTJvXNHfGNkoeU1S5zMMMBFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PDMVcI0ALoAL2bZp03niToUbpaPHtm8qD96IAb+ePAE=;
        b=nitnjTGDjj5WMW2cxfRtloRFwgEJ8nHW19Z3fUVVGuDz0rmhUqNb5iKj+2r3BCz5JgBpQe
        HIG1M1MivxhpBfDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] dmaengine: qcom_hidma: Cleanup MSI handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211210221815.329792721@linutronix.de>
References: <20211210221815.329792721@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969084549.23020.434956319338660207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     1900c962e2dcfacec894558eb34971bdc9c67443
Gitweb:        https://git.kernel.org/tip/1900c962e2dcfacec894558eb34971bdc9c67443
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:42 +01:00

dmaengine: qcom_hidma: Cleanup MSI handling

There is no reason to walk the MSI descriptors to retrieve the interrupt
number for a device. Use msi_get_virq() instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Sinan Kaya <okaya@kernel.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20211210221815.329792721@linutronix.de

---
 drivers/dma/qcom/hidma.c | 42 ++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index db8241b..65d054b 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -678,11 +678,13 @@ static void hidma_free_msis(struct hidma_dev *dmadev)
 {
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 	struct device *dev = dmadev->ddev.dev;
-	struct msi_desc *desc;
+	int i, virq;
 
-	/* free allocated MSI interrupts above */
-	for_each_msi_entry(desc, dev)
-		devm_free_irq(dev, desc->irq, &dmadev->lldev);
+	for (i = 0; i < HIDMA_MSI_INTS; i++) {
+		virq = msi_get_virq(dev, i);
+		if (virq)
+			devm_free_irq(dev, virq, &dmadev->lldev);
+	}
 
 	platform_msi_domain_free_irqs(dev);
 #endif
@@ -692,45 +694,37 @@ static int hidma_request_msi(struct hidma_dev *dmadev,
 			     struct platform_device *pdev)
 {
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
-	int rc;
-	struct msi_desc *desc;
-	struct msi_desc *failed_desc = NULL;
+	int rc, i, virq;
 
 	rc = platform_msi_domain_alloc_irqs(&pdev->dev, HIDMA_MSI_INTS,
 					    hidma_write_msi_msg);
 	if (rc)
 		return rc;
 
-	for_each_msi_entry(desc, &pdev->dev) {
-		if (!desc->msi_index)
-			dmadev->msi_virqbase = desc->irq;
-
-		rc = devm_request_irq(&pdev->dev, desc->irq,
+	for (i = 0; i < HIDMA_MSI_INTS; i++) {
+		virq = msi_get_virq(&pdev->dev, i);
+		rc = devm_request_irq(&pdev->dev, virq,
 				       hidma_chirq_handler_msi,
 				       0, "qcom-hidma-msi",
 				       &dmadev->lldev);
-		if (rc) {
-			failed_desc = desc;
+		if (rc)
 			break;
-		}
+		if (!i)
+			dmadev->msi_virqbase = virq;
 	}
 
 	if (rc) {
 		/* free allocated MSI interrupts above */
-		for_each_msi_entry(desc, &pdev->dev) {
-			if (desc == failed_desc)
-				break;
-			devm_free_irq(&pdev->dev, desc->irq,
-				      &dmadev->lldev);
+		for (--i; i >= 0; i--) {
+			virq = msi_get_virq(&pdev->dev, i);
+			devm_free_irq(&pdev->dev, virq, &dmadev->lldev);
 		}
+		dev_warn(&pdev->dev,
+			 "failed to request MSI irq, falling back to wired IRQ\n");
 	} else {
 		/* Add callback to free MSIs on teardown */
 		hidma_ll_setup_irq(dmadev->lldev, true);
-
 	}
-	if (rc)
-		dev_warn(&pdev->dev,
-			 "failed to request MSI irq, falling back to wired IRQ\n");
 	return rc;
 #else
 	return -EINVAL;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D57477F26
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242196AbhLPVlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57088 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbhLPVkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:37 -0500
Date:   Thu, 16 Dec 2021 21:40:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690835;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eYyMpkEIDe2+ctgRgNJ9cRRAZ1ABsgBY8um3aUdhmHo=;
        b=y5zLbTfyog6MCYmSFMVl2cxlYuVf/zNPBXrKahHCesNok7r/fK9DlYSDPHIHSRFHXxk6Fq
        kFvQkbvK7iay1X6s0Y7mAougS12WZQ6SC5vqIGcvOqKfT3B68yaRXhNGc+S+cR0weZ/JNF
        BMSHjIm4NfT2AqAQOxE5ShGlG7sbu6Jz1yHdH0iPYPfc7+dy1dkKendZOfviNCGAgh45ZY
        Iu+nFPC9Nvyb+FXh1oTw88J7dCE3dVJlb5ufJ/YxwC31vC1NuAfXMfTaw2bEHA1nQYgwCP
        03nQ9BH5kH3HU2PXJxtrIy+VezbV03CRhlrlPc+ZkSE+baUQB2iv6OuFfsmnPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690835;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eYyMpkEIDe2+ctgRgNJ9cRRAZ1ABsgBY8um3aUdhmHo=;
        b=Yp3eoeWbdF1opmKCKs7eb2GpSYDUFdfomKhlWGf7au+Zy4iNa/EcXYIwgWPpHfziJmn1dX
        vhdtRBxu/0nmK2Dw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] s390/pci: Rework MSI descriptor walk
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210748.305656158@linutronix.de>
References: <20211206210748.305656158@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969083456.23020.12131963221718612050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     2ca5e908d0f4cde61d9d3595e8314adca5d914a1
Gitweb:        https://git.kernel.org/tip/2ca5e908d0f4cde61d9d3595e8314adca5d914a1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:18 +01:00

s390/pci: Rework MSI descriptor walk

Replace the about to vanish iterators and make use of the filtering.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
Link: https://lore.kernel.org/r/20211206210748.305656158@linutronix.de

---
 arch/s390/pci/pci_irq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 2beb8a0..0975ff3 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -303,7 +303,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 
 	/* Request MSI interrupts */
 	hwirq = bit;
-	for_each_pci_msi_entry(msi, pdev) {
+	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
 		rc = -EIO;
 		if (hwirq - bit >= msi_vecs)
 			break;
@@ -362,9 +362,7 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 		return;
 
 	/* Release MSI interrupts */
-	for_each_pci_msi_entry(msi, pdev) {
-		if (!msi->irq)
-			continue;
+	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		irq_set_msi_desc(msi->irq, NULL);
 		irq_free_desc(msi->irq);
 		msi->msg.address_lo = 0;

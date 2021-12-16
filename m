Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3503F477F14
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242099AbhLPVlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241769AbhLPVkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAB5C061401;
        Thu, 16 Dec 2021 13:40:32 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:40:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690831;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjlbTERZhvfcw6i35tIMr6aTG9Itn1xp4AgKMTrqGrM=;
        b=fCMnkZsbFhLQDGwfwRXD0Te8Ml95OE9fwqmarAkXMJWPR0UGLULGa2marpPCTE0wSmrPsj
        rWs91bu4ZHhjPgM58yH2ogVu6NxikUNhLzA6kAIUp9S78iLSe3CeuXK6quwyepmWe+L6Q4
        Sf07bOwrPVLC8iHp/Bif/Wf0rlKwboyVvAajN+bak+7CfXOjtSTgjylrLDYD5pP14xm6jN
        0wj4SGljHRAFR/wTGDGTJlce466le1vL2goaU1dChmWUeVwxMNMivLDzcYFJPPGvpY3nUI
        EFS1t6YbIXB+JvGAk0aO3v0yN3s5KeqNDwNod4Xy5PQgLlHIX8KHbshsG8Y+pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690831;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjlbTERZhvfcw6i35tIMr6aTG9Itn1xp4AgKMTrqGrM=;
        b=Shk3ZhFJmWPuRwIdYzH9om4os7/h80wQneSgX6Vij1zkNwTYXp7K/SMexk4g+kGt5b7NV3
        yoKD7SyS5XnhegDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] powerpc/mpic_u3msi: Use msi_for_each-desc()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210748.576162169@linutronix.de>
References: <20211206210748.576162169@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969083006.23020.12966734312702593646.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     706b585a1b9554cb1ede5108c733593b94a7e1c4
Gitweb:        https://git.kernel.org/tip/706b585a1b9554cb1ede5108c733593b94a7e1c4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:19 +01:00

powerpc/mpic_u3msi: Use msi_for_each-desc()

Replace the about to vanish iterators and make use of the filtering.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210748.576162169@linutronix.de

---
 arch/powerpc/sysdev/mpic_u3msi.c |  9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
index 3861023..fa53b6d 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -104,17 +104,12 @@ static void u3msi_teardown_msi_irqs(struct pci_dev *pdev)
 	struct msi_desc *entry;
 	irq_hw_number_t hwirq;
 
-	for_each_pci_msi_entry(entry, pdev) {
-		if (!entry->irq)
-			continue;
-
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		hwirq = virq_to_hw(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
 		irq_dispose_mapping(entry->irq);
 		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq, 1);
 	}
-
-	return;
 }
 
 static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
@@ -136,7 +131,7 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		return -ENXIO;
 	}
 
-	for_each_pci_msi_entry(entry, pdev) {
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
 		hwirq = msi_bitmap_alloc_hwirqs(&msi_mpic->msi_bitmap, 1);
 		if (hwirq < 0) {
 			pr_debug("u3msi: failed allocating hwirq\n");

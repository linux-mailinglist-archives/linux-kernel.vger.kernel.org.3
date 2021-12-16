Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1014E477F16
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242113AbhLPVlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56996 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241786AbhLPVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:31 -0500
Date:   Thu, 16 Dec 2021 21:40:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690830;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0mE7/8/GjbgPhEDVlCMkfFO4dan/TZEA3ARXtIYTrj0=;
        b=pSwXgS3fyP2pFiFzhKAOWS9rdFF+kbxFoKHsjYzH8MfD0Hqr8bkb+lJlvYv4yspyxghHop
        dzhzPcuuKAxFqODHxxkIBGnbqA8b+QbrN2g8DDsZDAtcdX5ebRsePW6m8HmLXEWGbo0mXA
        qYOtf8P0hZFYPQXCdM231LYhaMv/oy3nE1UxgJ2TZ0vf6DU956aRcLAA77nVBPdN03px93
        WBOPBb1w4kuyUtvOxzgzLXSyUYEFR99+qBGr2/2jJCcUOfCioRNG6dx5SR9CwPtB6ZPCuO
        k9Jz7F6KeGO+doFmJ2ZfiplazxRBtAFk7RAvL0dL7eAOqAsPxw1DzBirnD6ZkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690830;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0mE7/8/GjbgPhEDVlCMkfFO4dan/TZEA3ARXtIYTrj0=;
        b=3YyY+89XK2IiRR8zOi3f00rQg7HLW5N3gGUkGuKLooq/7/nslnA00fWWACi6gra9qfzfF2
        S/u0DKmqPsLgZaBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI: hv: Rework MSI handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210748.629363944@linutronix.de>
References: <20211206210748.629363944@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969082914.23020.17844916634086326034.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     dc2b453290c471266a2d56d7ead981e3c5cea05e
Gitweb:        https://git.kernel.org/tip/dc2b453290c471266a2d56d7ead981e3c5cea05e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:19 +01:00

PCI: hv: Rework MSI handling

Replace the about to vanish iterators and make use of the filtering. Take
the descriptor lock around the iterators.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211206210748.629363944@linutronix.de

---
 drivers/pci/controller/pci-hyperv.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 6733cb1..45b6ff8 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3445,18 +3445,23 @@ static int hv_pci_suspend(struct hv_device *hdev)
 
 static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
 {
-	struct msi_desc *entry;
 	struct irq_data *irq_data;
+	struct msi_desc *entry;
+	int ret = 0;
 
-	for_each_pci_msi_entry(entry, pdev) {
+	msi_lock_descs(&pdev->dev);
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		irq_data = irq_get_irq_data(entry->irq);
-		if (WARN_ON_ONCE(!irq_data))
-			return -EINVAL;
+		if (WARN_ON_ONCE(!irq_data)) {
+			ret = -EINVAL;
+			break;
+		}
 
 		hv_compose_msi_msg(irq_data, &entry->msg);
 	}
+	msi_unlock_descs(&pdev->dev);
 
-	return 0;
+	return ret;
 }
 
 /*

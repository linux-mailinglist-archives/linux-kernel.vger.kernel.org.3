Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581D3477F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241861AbhLPVlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57042 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241770AbhLPVka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:30 -0500
Date:   Thu, 16 Dec 2021 21:40:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690829;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NGT7LjpPSqQ0PV8vru5wZTtHWmie/2fhg3X7BCTZe7o=;
        b=uvh9fcK74Hk48bVE9efiS/2opRnZgTyGWFG/L+/MVDNvsJi8wwS0ekujvhKkQQe4YVRSEj
        37fkTBdOOuvi8Uz258aPzdy1ePoyy+CTkgfbtWIVUmC/AqfPeKwbRiWL4WH+Nw5WPE12vk
        aLLgjsqEQm6WOaGHouz47HGt3iCuJCwf74P9LTRUcO+aVccP5oYTcY1thXtOdthPFfJNPF
        ispm1ILwYmtj0Mh0nvaJg99Z3mVB3p6r+8JG8h0e6aK+fO4gKClUYbpdmXqYoy5BunqJsc
        fYwIh3o+VdRoa1mgS1CcmXg3tLCGwPoGHoj49eTPvyB6TCgap0C0SSq6C72oPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690829;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NGT7LjpPSqQ0PV8vru5wZTtHWmie/2fhg3X7BCTZe7o=;
        b=m1HTcMOiZkIw9HJgkJjoOs+S+/JoHZ8rFbeTAnRFG5lBJPk/pb/ylTdK2cHIxWSkHNA8Xf
        Fq8B8++2R27/izBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] NTB/msi: Convert to msi_on_each_desc()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210748.683004012@linutronix.de>
References: <20211206210748.683004012@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969082826.23020.74771321356733256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     68e3183580bea59e764d33283875e5f0adc753f3
Gitweb:        https://git.kernel.org/tip/68e3183580bea59e764d33283875e5f0adc753f3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:19 +01:00

NTB/msi: Convert to msi_on_each_desc()

Replace the about to vanish iterators, make use of the filtering and take
the descriptor lock around the iteration.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210748.683004012@linutronix.de

---
 drivers/ntb/msi.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 3f05cfb..2818bfc 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -108,8 +108,10 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
 	if (!ntb->msi)
 		return -EINVAL;
 
-	desc = first_msi_entry(&ntb->pdev->dev);
+	msi_lock_descs(&ntb->pdev->dev);
+	desc = msi_first_desc(&ntb->pdev->dev, MSI_DESC_ASSOCIATED);
 	addr = desc->msg.address_lo + ((uint64_t)desc->msg.address_hi << 32);
+	msi_unlock_descs(&ntb->pdev->dev);
 
 	for (peer = 0; peer < ntb_peer_port_count(ntb); peer++) {
 		peer_widx = ntb_peer_highest_mw_idx(ntb, peer);
@@ -281,13 +283,15 @@ int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, irq_handler_t handler,
 				  const char *name, void *dev_id,
 				  struct ntb_msi_desc *msi_desc)
 {
+	struct device *dev = &ntb->pdev->dev;
 	struct msi_desc *entry;
 	int ret;
 
 	if (!ntb->msi)
 		return -EINVAL;
 
-	for_each_pci_msi_entry(entry, ntb->pdev) {
+	msi_lock_descs(dev);
+	msi_for_each_desc(entry, dev, MSI_DESC_ASSOCIATED) {
 		if (irq_has_action(entry->irq))
 			continue;
 
@@ -304,14 +308,17 @@ int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, irq_handler_t handler,
 		ret = ntbm_msi_setup_callback(ntb, entry, msi_desc);
 		if (ret) {
 			devm_free_irq(&ntb->dev, entry->irq, dev_id);
-			return ret;
+			goto unlock;
 		}
 
-
-		return entry->irq;
+		ret = entry->irq;
+		goto unlock;
 	}
+	ret = -ENODEV;
 
-	return -ENODEV;
+unlock:
+	msi_unlock_descs(dev);
+	return ret;
 }
 EXPORT_SYMBOL(ntbm_msi_request_threaded_irq);
 

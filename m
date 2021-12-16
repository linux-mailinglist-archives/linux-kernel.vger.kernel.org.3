Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539BD477F06
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbhLPVkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241740AbhLPVk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA7DC06173E;
        Thu, 16 Dec 2021 13:40:27 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:40:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690826;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GJUs8N2lCbwA44n/pmFlUhqjL6PgKnoju5cqVkNQ4AY=;
        b=E6dkcsfi8ViT6612pm61BUR1vW17O9NLwm2OOblow6mI9SYbJQOqe4d9/X6GC3aNyWrMVY
        rXbait45WQei/qSPARZ3yST+I9IaMHY/WeFSownxHis5DxoKYmzgCWgRgrRsInhSoGdVeo
        2g4tg+GICp8Uq7SJO8TloboBxJJhar2JYIdYOoLB2YGRrdTOiQbS4v8aDiK+Mlbf3/Z4G2
        HAr69sj3TQc/JSGLH7Rg+QLkd4kIcfbOZIBzIss930tDyyG3KDDSfP0kf8pII0gX9nVgrT
        ZbPoniKAcE+SGVw2/qd9Q0lJnVqKfSpRCj9Ze9GJUkxnBV698GtPOtWrgrDEuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690826;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GJUs8N2lCbwA44n/pmFlUhqjL6PgKnoju5cqVkNQ4AY=;
        b=KTaHMACh6oP/4jfgmZji253bBBzP1JWOndZcEV2GTjWXbDleLNDhksWRGmZT6ABTIZLYF+
        wpLllUnDluJmvNCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] bus: fsl-mc-msi: Simplify MSI descriptor handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210748.847219474@linutronix.de>
References: <20211206210748.847219474@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969082559.23020.3944046336169427078.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     e8604b1447b4a0c178019bdf809a4d52e1c235b6
Gitweb:        https://git.kernel.org/tip/e8604b1447b4a0c178019bdf809a4d52e1c235b6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:19 +01:00

bus: fsl-mc-msi: Simplify MSI descriptor handling

Let the MSI irq domain code handle descriptor allocation and free.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210748.847219474@linutronix.de

---
 drivers/bus/fsl-mc/fsl-mc-msi.c | 61 ++------------------------------
 1 file changed, 4 insertions(+), 57 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 4823947..5e0e439 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -170,6 +170,7 @@ struct irq_domain *fsl_mc_msi_create_irq_domain(struct fwnode_handle *fwnode,
 		fsl_mc_msi_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		fsl_mc_msi_update_chip_ops(info);
+	info->flags |= MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
 
 	domain = msi_create_irq_domain(fwnode, info, parent);
 	if (domain)
@@ -210,45 +211,7 @@ struct irq_domain *fsl_mc_find_msi_domain(struct device *dev)
 	return msi_domain;
 }
 
-static void fsl_mc_msi_free_descs(struct device *dev)
-{
-	struct msi_desc *desc, *tmp;
-
-	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
-		list_del(&desc->list);
-		free_msi_entry(desc);
-	}
-}
-
-static int fsl_mc_msi_alloc_descs(struct device *dev, unsigned int irq_count)
-
-{
-	unsigned int i;
-	int error;
-	struct msi_desc *msi_desc;
-
-	for (i = 0; i < irq_count; i++) {
-		msi_desc = alloc_msi_entry(dev, 1, NULL);
-		if (!msi_desc) {
-			dev_err(dev, "Failed to allocate msi entry\n");
-			error = -ENOMEM;
-			goto cleanup_msi_descs;
-		}
-
-		msi_desc->msi_index = i;
-		INIT_LIST_HEAD(&msi_desc->list);
-		list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
-	}
-
-	return 0;
-
-cleanup_msi_descs:
-	fsl_mc_msi_free_descs(dev);
-	return error;
-}
-
-int fsl_mc_msi_domain_alloc_irqs(struct device *dev,
-				 unsigned int irq_count)
+int fsl_mc_msi_domain_alloc_irqs(struct device *dev,  unsigned int irq_count)
 {
 	struct irq_domain *msi_domain;
 	int error;
@@ -261,28 +224,17 @@ int fsl_mc_msi_domain_alloc_irqs(struct device *dev,
 	if (error)
 		return error;
 
-	if (!list_empty(dev_to_msi_list(dev)))
+	if (msi_first_desc(dev, MSI_DESC_ALL))
 		return -EINVAL;
 
-	error = fsl_mc_msi_alloc_descs(dev, irq_count);
-	if (error < 0)
-		return error;
-
 	/*
 	 * NOTE: Calling this function will trigger the invocation of the
 	 * its_fsl_mc_msi_prepare() callback
 	 */
 	error = msi_domain_alloc_irqs(msi_domain, dev, irq_count);
 
-	if (error) {
+	if (error)
 		dev_err(dev, "Failed to allocate IRQs\n");
-		goto cleanup_msi_descs;
-	}
-
-	return 0;
-
-cleanup_msi_descs:
-	fsl_mc_msi_free_descs(dev);
 	return error;
 }
 
@@ -295,9 +247,4 @@ void fsl_mc_msi_domain_free_irqs(struct device *dev)
 		return;
 
 	msi_domain_free_irqs(msi_domain, dev);
-
-	if (list_empty(dev_to_msi_list(dev)))
-		return;
-
-	fsl_mc_msi_free_descs(dev);
 }

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EC9477F20
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241979AbhLPVlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57082 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241835AbhLPVkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:35 -0500
Date:   Thu, 16 Dec 2021 21:40:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690834;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GZLyKE0FfX9aLv0WitD4olNtIgzyAHzJRFMpGfNRrTo=;
        b=doNnQcSdjyfDSeN3d7b86B3Dvs4onf0xHkXWjD/scjCq6HOTNn7PvTE0glN5IrdWAfCLsd
        kzzWbd2iJ8N80sYiPB91ST3RiWcOdghzxN2//2BKWusdYAr/VXKFTq3Tw2+1h8qUkKUmRa
        jaLZTC6VMAFtqQ82P44voq36KPhlfsXPmiIke3sgtAGQTCKwqQPsdbIvRCT3H8LjbPDbvT
        O3o8DmQnUQWG5zf3tH/8E+LmfyD6COqR89lcfgmK2fXZ4IoXGgXaMIQBOOsnxjFnzt4NwE
        w3VQLFU3HODhak5Cbpv/NLUkn/ltE31RBH/sfCVLNKdo4gMIvKp43RrHXzvexA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690834;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GZLyKE0FfX9aLv0WitD4olNtIgzyAHzJRFMpGfNRrTo=;
        b=ig84dqRimuAw+evs3zkFuyVzmxuy4Y2OvS2Ysp9sSMhshaKF9AwsHin7q3BDdX9pcb48Q+
        TqKIUQZ8gCmlo0DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] powerpc/4xx/hsta: Rework MSI handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210748.359766435@linutronix.de>
References: <20211206210748.359766435@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969083365.23020.10894305121701316976.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     85dabc2f72b65d1aa52ac8214b1112f141d17b91
Gitweb:        https://git.kernel.org/tip/85dabc2f72b65d1aa52ac8214b1112f141d17b91
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:18 +01:00

powerpc/4xx/hsta: Rework MSI handling

Replace the about to vanish iterators and make use of the filtering.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210748.359766435@linutronix.de

---
 arch/powerpc/platforms/4xx/hsta_msi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/hsta_msi.c b/arch/powerpc/platforms/4xx/hsta_msi.c
index c950fed..fee430e 100644
--- a/arch/powerpc/platforms/4xx/hsta_msi.c
+++ b/arch/powerpc/platforms/4xx/hsta_msi.c
@@ -47,7 +47,7 @@ static int hsta_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		return -EINVAL;
 	}
 
-	for_each_pci_msi_entry(entry, dev) {
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		irq = msi_bitmap_alloc_hwirqs(&ppc4xx_hsta_msi.bmp, 1);
 		if (irq < 0) {
 			pr_debug("%s: Failed to allocate msi interrupt\n",
@@ -105,10 +105,7 @@ static void hsta_teardown_msi_irqs(struct pci_dev *dev)
 	struct msi_desc *entry;
 	int irq;
 
-	for_each_pci_msi_entry(entry, dev) {
-		if (!entry->irq)
-			continue;
-
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ASSOCIATED) {
 		irq = hsta_find_hwirq_offset(entry->irq);
 
 		/* entry->irq should always be in irq_map */

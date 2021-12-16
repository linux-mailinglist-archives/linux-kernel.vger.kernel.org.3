Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883E3477F23
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbhLPVlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57092 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241854AbhLPVkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:37 -0500
Date:   Thu, 16 Dec 2021 21:40:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690836;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R45C5Oa2oE6RvYKauLv9BzOpyPrMnp/kM02JT3mXhbc=;
        b=VVe0k8IKjwP5+uxnMyIh3L0YSq6g0iuTo1ufxHPavCuZ1T5Nt7plX52pVu//a01zGcSjLx
        eNjIwlzi79p3cbYcd8vsHlYYeft3q0Dvy50XW50B59NTjf1gTY21JDyVaLokcJk88Tuxff
        brok9v865bOFDGzNjzntTKH33FM3qMACbq5rpTQOlwqZfDi6biq55WoU3t9At+W0l3zD0I
        w6N+JTBFKbC5yIke/c7FkM/VzrWEsrLvD4rHnJfBroyhcAxT/eElKbmuVBd0NYzER9mJYm
        IQMZc8A0dJ1j5ZhdHAGunbsEA2C3gmTRSFBF+UIx32aKXQTXVu2rDe9b/72ytA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690836;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R45C5Oa2oE6RvYKauLv9BzOpyPrMnp/kM02JT3mXhbc=;
        b=4tm+u2zkvGkILflf4KTz2W8TFUIjBZ08awuxw4vEna0h0fbia3/yt+NoErZR9PPztvVqdI
        aBs5/hpRcEoNmvBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] xen/pcifront: Rework MSI handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210748.251752714@linutronix.de>
References: <20211206210748.251752714@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969083546.23020.14543072738697106683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     3d31bbd39aa5c7467a34e8202a983e81b696a883
Gitweb:        https://git.kernel.org/tip/3d31bbd39aa5c7467a34e8202a983e81b696a883
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:18 +01:00

xen/pcifront: Rework MSI handling

Replace the about to vanish iterators.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210748.251752714@linutronix.de

---
 drivers/pci/xen-pcifront.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index bacf511..d2a7b9f 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -262,7 +262,7 @@ static int pci_frontend_enable_msix(struct pci_dev *dev,
 	}
 
 	i = 0;
-	for_each_pci_msi_entry(entry, dev) {
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		op.msix_entries[i].entry = entry->msi_index;
 		/* Vector is useless at this point. */
 		op.msix_entries[i].vector = -1;

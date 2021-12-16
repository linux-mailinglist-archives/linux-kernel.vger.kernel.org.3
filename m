Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CE4477F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242438AbhLPVmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57304 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241964AbhLPVky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:54 -0500
Date:   Thu, 16 Dec 2021 21:40:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q59E8VYoYsoKxHR79+YMNGXEenQ+VYott+XKOz91hqg=;
        b=wX/6rRkBHslC7Gt2MB9yNZk46kedLtbVdbR3MiHbp6z6xxIq7+SZ96r00vKalYsLXd4H51
        mA4Yy3Xrh9jGzpqAVOIG0ysmyeXYroag/jWYKq9GqAFBS3i8jE2daFP4KgeV6NDG8ghngt
        oG7r42W6Mmb6krCpwCQTyGEJeI04S5d2WLN9/d8BtWKB5UYX4P1sH1GH8QiVfSYIzbMQaI
        NB+HZ8KQuIXncO3SnZzBK5Ik3x4aRz3mmiTOilrZ3lxP8REFQFE4xWNuSSTCHXoCbhKy2m
        0zgCnLCeExO/XC7xN99h/1FXIHEIzHNuWfvmtWVKORclBJYJXqXQonyxGbDmVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q59E8VYoYsoKxHR79+YMNGXEenQ+VYott+XKOz91hqg=;
        b=JZDKD2js7i4M2L50HHQhzkIeu3a1GPBx4MRGsaHnUOLf2lT/r0eudAkkJaVYx/TTGOY+66
        A7aOx7GYhkSFy1AQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Use msi_get_virq() in pci_get_vector()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221814.841243231@linutronix.de>
References: <20211210221814.841243231@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969085198.23020.10252960007734458445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     82ff8e6b78fc4587a4255301f0a283506daf11b6
Gitweb:        https://git.kernel.org/tip/82ff8e6b78fc4587a4255301f0a283506daf11b6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:41 +01:00

PCI/MSI: Use msi_get_virq() in pci_get_vector()

Use msi_get_vector() and handle the return value to be compatible.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221814.841243231@linutronix.de

---
 drivers/pci/msi/msi.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 8fb4dd2..fad3873 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -1080,28 +1080,13 @@ EXPORT_SYMBOL(pci_free_irq_vectors);
  */
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 {
-	if (dev->msix_enabled) {
-		struct msi_desc *entry;
-
-		for_each_pci_msi_entry(entry, dev) {
-			if (entry->msi_index == nr)
-				return entry->irq;
-		}
-		WARN_ON_ONCE(1);
-		return -EINVAL;
-	}
+	unsigned int irq;
 
-	if (dev->msi_enabled) {
-		struct msi_desc *entry = first_pci_msi_entry(dev);
-
-		if (WARN_ON_ONCE(nr >= entry->nvec_used))
-			return -EINVAL;
-	} else {
-		if (WARN_ON_ONCE(nr > 0))
-			return -EINVAL;
-	}
+	if (!dev->msi_enabled && !dev->msix_enabled)
+		return !nr ? dev->irq : -EINVAL;
 
-	return dev->irq + nr;
+	irq = msi_get_virq(&dev->dev, nr);
+	return irq ? irq : -EINVAL;
 }
 EXPORT_SYMBOL(pci_irq_vector);
 

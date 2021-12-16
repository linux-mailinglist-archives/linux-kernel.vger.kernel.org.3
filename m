Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C5D477F07
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241994AbhLPVlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56996 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241733AbhLPVk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:28 -0500
Date:   Thu, 16 Dec 2021 21:40:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690827;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJD8piY4azqgRPi03hp10BzntzYzzzYvUNiwR6YZCHQ=;
        b=dyfl/Dh9tShEkzj1TJ6kHj6tPuWGzJn90owWkoayUSEQ45GNyz1VAtPO9ejZWqR2LkuSE5
        S+PZYpYcRyPibBag69qQtbzLy0H4ZwqGt6NsapJB4jVKucIO0RxBJandoZ/kpfu/6IJ9VI
        8AcWv8mO+qS2eoJ9WIYsJ2alB1D+i013Zd1tTjknuAjNFIWF9p3OwUMMXwRigUa3L8fHV3
        3aUkW7x7ORoL7YZF58C7n6lddL2BJojdNBrzekqt7k/pk4zHwrFv0kmwZQFjV2R4lUUwMe
        P0lEpnjh95nJh189gVhkD8c5WdF68LlnImw6twG6PDeITmnfueXFUK7kQoio4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690827;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJD8piY4azqgRPi03hp10BzntzYzzzYvUNiwR6YZCHQ=;
        b=0J8jSJeO9PkBE8+OANW/m7oyz4u+PhxRotM19FKDOlSV7VOlMu7c93iNPNNlqO1UBofDGF
        WaabkfND3u8EOJDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] soc: ti: ti_sci_inta_msi: Remove
 ti_sci_inta_msi_domain_free_irqs()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Nishanth Menon <nm@ti.com>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210748.793119155@linutronix.de>
References: <20211206210748.793119155@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969082644.23020.17438999235756320428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     7ad321a5eadb52b4af1c577dda51783e08235ea7
Gitweb:        https://git.kernel.org/tip/7ad321a5eadb52b4af1c577dda51783e08235ea7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:19 +01:00

soc: ti: ti_sci_inta_msi: Remove ti_sci_inta_msi_domain_free_irqs()

The function has no users and is pointless now that the core frees the MSI
descriptors, which means potential users can just use msi_domain_free_irqs().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210748.793119155@linutronix.de

---
 drivers/soc/ti/ti_sci_inta_msi.c       | 6 ------
 include/linux/soc/ti/ti_sci_inta_msi.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
index 3139911..991c78b 100644
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -122,9 +122,3 @@ unlock:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);
-
-void ti_sci_inta_msi_domain_free_irqs(struct device *dev)
-{
-	msi_domain_free_irqs(dev->msi.domain, dev);
-}
-EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_free_irqs);
diff --git a/include/linux/soc/ti/ti_sci_inta_msi.h b/include/linux/soc/ti/ti_sci_inta_msi.h
index 25ea78a..4dba2f2 100644
--- a/include/linux/soc/ti/ti_sci_inta_msi.h
+++ b/include/linux/soc/ti/ti_sci_inta_msi.h
@@ -18,5 +18,4 @@ struct irq_domain
 				   struct irq_domain *parent);
 int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
 				      struct ti_sci_resource *res);
-void ti_sci_inta_msi_domain_free_irqs(struct device *dev);
 #endif /* __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H */

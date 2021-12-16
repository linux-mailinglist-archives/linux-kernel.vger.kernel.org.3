Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8C9477F49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbhLPVl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57328 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241984AbhLPVk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:57 -0500
Date:   Thu, 16 Dec 2021 21:40:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bytgaVHNoDM5XSH4F4G+uJDApnLoJ4nmZ6QQt7pKJQo=;
        b=M15FVkV9vypK5LOiyQEq5lw4S5lv4eoX+lAg2rhEECk8W187AgSAji36izZcx3JtX4duFH
        YneXR+wSxv9J7JcoqP4WTaDCr7u7x8MR46zFuW7tGR2r2wzJvsNMXbgKt5PKSCvdAKgZ2U
        CjVyjBFIcH8V005U3sz1fhpL0EQ9zuD6M9n/g2FvdFs8qFoU/ECUL+md3gdczoJUspqxbT
        so/PjouNOKJxjTDbuewf2zZcWcT2oKNsGqFcLbinIesepyEIjAx4dqsSCYi4+1exSgT/AZ
        9SrXXqHF7rzwFh16mnluBqw/l9VQPuDTtjjIbsGvwHxXQoAddsJQq5DjOoEQNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bytgaVHNoDM5XSH4F4G+uJDApnLoJ4nmZ6QQt7pKJQo=;
        b=KUpfzmDj2XGA8A5s+xkXpCRHa04+OKW75drp/HO1L/s/Xs671mesRmsYR88/7wt9CQPt6C
        /dUo7SbgvCchgvAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Provide MSI_FLAG_MSIX_CONTIGUOUS
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221814.662401116@linutronix.de>
References: <20211210221814.662401116@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969085489.23020.9583037290111962346.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     7a823443e9b4ed1ff4a3026d184f09d23fd6d9c9
Gitweb:        https://git.kernel.org/tip/7a823443e9b4ed1ff4a3026d184f09d23fd6d9c9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:40 +01:00

PCI/MSI: Provide MSI_FLAG_MSIX_CONTIGUOUS

Provide a domain info flag which makes the core code check for a contiguous
MSI-X index on allocation. That's simpler than checking it at some other
domain callback in architecture code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211210221814.662401116@linutronix.de


---
 drivers/pci/msi/irqdomain.c | 16 ++++++++++++++--
 include/linux/msi.h         |  2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 4224202..180b2a1 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -89,9 +89,21 @@ static int pci_msi_domain_check_cap(struct irq_domain *domain,
 	if (pci_msi_desc_is_multi_msi(desc) &&
 	    !(info->flags & MSI_FLAG_MULTI_PCI_MSI))
 		return 1;
-	else if (desc->pci.msi_attrib.is_msix && !(info->flags & MSI_FLAG_PCI_MSIX))
-		return -ENOTSUPP;
 
+	if (desc->pci.msi_attrib.is_msix) {
+		if (!(info->flags & MSI_FLAG_PCI_MSIX))
+			return -ENOTSUPP;
+
+		if (info->flags & MSI_FLAG_MSIX_CONTIGUOUS) {
+			unsigned int idx = 0;
+
+			/* Check for gaps in the entry indices */
+			for_each_msi_entry(desc, dev) {
+				if (desc->msi_index != idx++)
+					return -ENOTSUPP;
+			}
+		}
+	}
 	return 0;
 }
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index b3d3b0b..d206239 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -362,6 +362,8 @@ enum {
 	MSI_FLAG_LEVEL_CAPABLE		= (1 << 6),
 	/* Populate sysfs on alloc() and destroy it on free() */
 	MSI_FLAG_DEV_SYSFS		= (1 << 7),
+	/* MSI-X entries must be contiguous */
+	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 8),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,

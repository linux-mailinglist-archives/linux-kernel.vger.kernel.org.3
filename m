Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7B9477F74
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242853AbhLPVnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242335AbhLPVlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D6FC061190;
        Thu, 16 Dec 2021 13:41:17 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:41:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690875;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FeP7FGh9hdIsqrdi0n3oxHXjUNz9Ry7Y0Xf30VyL2Rk=;
        b=ty9jv6MSW9Dhd2kpbzCmMABFAO9cDSwhSeB1B9FfwbHajfwnqpqYom56S9RnsfT2p4zVhr
        DW/NYampS3386wssjLzpYYAzJtRKfv0TpOOyAsjPT5dS7duDj+S9TbRjgMGP9FMuAjxxyR
        EjObZDNTLTOJ101MuiQg9oQ97z/9XQFI1OnmHnX/Y6OGFp/2CWWvsrag34YvcK0IBlNrfV
        l6lnOpLGLRI9SS4BKVvuifSc9T1U87gtvtZyZ/3v5PVa2J1e/7zweYfEwe6obafUFGNnoe
        fsaCw42UnMxKmK27lz4zht5qy/CyDiAXTApBluABm1NyYnryRa2fAL9CB16Zhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690875;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FeP7FGh9hdIsqrdi0n3oxHXjUNz9Ry7Y0Xf30VyL2Rk=;
        b=ucrRUUCt8gKayo6vwx1Hv4W20MPp360bURcCifsPGBrqbJxRYT0vOpP3VCXvtWWWRwTmdh
        APQtZfEZ9kEoVHDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] x86/pci/XEN: Use PCI device property
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221813.311410967@linutronix.de>
References: <20211210221813.311410967@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969087485.23020.2986020963049503586.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     0bcfade920804d597888e4181bc315a3c500280d
Gitweb:        https://git.kernel.org/tip/0bcfade920804d597888e4181bc315a3c500280d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:18:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:37 +01:00

x86/pci/XEN: Use PCI device property

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221813.311410967@linutronix.de

---
 arch/x86/pci/xen.c |  9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index a63d30a..bfd87b4 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -399,9 +399,7 @@ static void xen_teardown_msi_irqs(struct pci_dev *dev)
 
 static void xen_pv_teardown_msi_irqs(struct pci_dev *dev)
 {
-	struct msi_desc *msidesc = first_pci_msi_entry(dev);
-
-	if (msidesc->pci.msi_attrib.is_msix)
+	if (dev->msix_enabled)
 		xen_pci_frontend_disable_msix(dev);
 	else
 		xen_pci_frontend_disable_msi(dev);
@@ -417,10 +415,7 @@ static int xen_msi_domain_alloc_irqs(struct irq_domain *domain,
 	if (WARN_ON_ONCE(!dev_is_pci(dev)))
 		return -EINVAL;
 
-	if (first_msi_entry(dev)->pci.msi_attrib.is_msix)
-		type = PCI_CAP_ID_MSIX;
-	else
-		type = PCI_CAP_ID_MSI;
+	type = to_pci_dev(dev)->msix_enabled ? PCI_CAP_ID_MSIX : PCI_CAP_ID_MSI;
 
 	return xen_msi_ops.setup_msi_irqs(to_pci_dev(dev), nvec, type);
 }

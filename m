Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C678A4957A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbiAUBTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:19:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52782 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiAUBTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:19:00 -0500
Date:   Fri, 21 Jan 2022 01:18:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642727938;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63eM+6UYuulfg+6WfwmqCNiumtTO6pPuHF2o3o8YG7o=;
        b=r+kPgYH6ASn2GjJz3cXSdDsJUyoY4m1TAAaFtbnQGnnFECaYKtCngAzfbDx1p35XQ/drPd
        bcwaIJ2/vW0vcRUUZmExQ8XVvV2XFcBR+9zGiLYke6VDhMnKdjmqQJseJY8EPwC6QLVs+M
        dRDj31U/UDuye5jJ7MUyWMubwfCVBCxdH20252EyESKj/emK1YYdLIJu2Ns81Q/HMi4N5Y
        cqIUuC5vBOACCNS8uYtwjoOXI6dVAZqv2C4EX9Oc4KUDR1apgfLUA4sExDw53aKHOP447M
        qr5J6GckbGFMc1IN1DRKYQ1a9GVXJYTlNLZcHy1Vi7OITJwbJ2EASX1UmOKyTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642727938;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63eM+6UYuulfg+6WfwmqCNiumtTO6pPuHF2o3o8YG7o=;
        b=Sbncv9byds/c2MR++Jcrd4QRKpO6SlfXrqmXBjK7hav6gZCoVC+kF+//R59efSFzRK+1PN
        JdSHNh6/IhOS7IAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] PCI/MSI: Prevent UAF in error path
Cc:     Tong Zhang <ztong0001@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <87r1938vbn.ffs@tglx>
References: <87r1938vbn.ffs@tglx>
MIME-Version: 1.0
Message-ID: <164272793734.16921.6900414168494720740.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     a0af3d1104f752b6d0dba71788e3fddd67c857a7
Gitweb:        https://git.kernel.org/tip/a0af3d1104f752b6d0dba71788e3fddd67c857a7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Jan 2022 18:54:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Jan 2022 02:14:46 +01:00

PCI/MSI: Prevent UAF in error path

When the core MSI allocation fails, then the PCI/MSI code uses an already
freed MSI descriptor to unmask the MSI mask register in order to bring it back
into reset state.

Remove MSI_FLAG_FREE_MSI_DESCS from the PCI/MSI irqdomain flags and let the
PCI/MSI code free the MSI descriptors after usage.

Fixes: 0f62d941acf9 ("genirq/msi: Provide msi_domain_alloc/free_irqs_descs_locked()")
Reported-by: Tong Zhang <ztong0001@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tong Zhang <ztong0001@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/87r1938vbn.ffs@tglx
---
 drivers/pci/msi/irqdomain.c | 4 ++--
 drivers/pci/msi/legacy.c    | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 0d63541..e9cf318 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -28,6 +28,7 @@ void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 		msi_domain_free_irqs_descs_locked(domain, &dev->dev);
 	else
 		pci_msi_legacy_teardown_msi_irqs(dev);
+	msi_free_msi_descs(&dev->dev);
 }
 
 /**
@@ -171,8 +172,7 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		pci_msi_domain_update_chip_ops(info);
 
-	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS |
-		       MSI_FLAG_FREE_MSI_DESCS;
+	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
 		info->flags |= MSI_FLAG_MUST_REACTIVATE;
 
diff --git a/drivers/pci/msi/legacy.c b/drivers/pci/msi/legacy.c
index cdbb468..db761ad 100644
--- a/drivers/pci/msi/legacy.c
+++ b/drivers/pci/msi/legacy.c
@@ -77,5 +77,4 @@ void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
 {
 	msi_device_destroy_sysfs(&dev->dev);
 	arch_teardown_msi_irqs(dev);
-	msi_free_msi_descs(&dev->dev);
 }

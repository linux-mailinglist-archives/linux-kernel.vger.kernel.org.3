Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AE6493F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356556AbiASRyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:54:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43894 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356555AbiASRyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:54:53 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642614892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j48OiqF+488LZi7JMqvf6TLaBjphB/X2lw2UnP1NtLs=;
        b=gMNQkdLIP+ueySCXhg9+mdfW04oO7G4An7Ushr7CNP4JXe9ktx9OVAEQr3w2fn4+rXPiks
        cxrMcpVcZBQ4hhLCBwKZV+BnaImv4XNkCiD6Tda7cs6wmY0zYQ3c8KXKei3SVDpF/lV3Wk
        EEkO7FZJLufaZnwbiN1srN7azbvwcByYqLZIPOVgEtZgqhLUtWBuGygLTk+6uWrCPMS1th
        +n+ulXfRjG8Tu/tvslo5aN66mHF24vqJWKNND08wOF0FmqLH6Ox/3jVX1/LxJALe0YJqyW
        TbkJ0F/oGFPPnlTWL2lJeuds9Un+bQ2H2QTQsRHq+/E+uqJXUkBYibzVAU0MNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642614892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j48OiqF+488LZi7JMqvf6TLaBjphB/X2lw2UnP1NtLs=;
        b=Bo4bekqkZys9RFVKp1/vmPTAijbgczqGlxknOpuiRYRAddJ6OXQvM6EQUa4H/f3S3MDO6U
        NnfAj2jVvK4atkBQ==
To:     Marc Zyngier <maz@kernel.org>, Tong Zhang <ztong0001@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH] PCI/MSI: Prevent UAF in error path
In-Reply-To: <877dawa70b.ffs@tglx>
References: <20220117092759.1619771-1-ztong0001@gmail.com>
 <87ilui8yxt.wl-maz@kernel.org>
 <CAA5qM4CfExWdg=Gp8OshKgYsi0A82nzTA1Uqu6nc_MQmdBfWzg@mail.gmail.com>
 <87h7a28uhj.wl-maz@kernel.org> <87iluh9kgx.ffs@tglx> <877dawa70b.ffs@tglx>
Date:   Wed, 19 Jan 2022 18:54:52 +0100
Message-ID: <87r1938vbn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the core MSI allocation fails, then the PCI/MSI code uses an already
freed MSI descriptor to unmask the MSI mask register in order to bring it back
into reset state.

Remove MSI_FLAG_FREE_MSI_DESCS from the PCI/MSI irqdomain flags and let the
PCI/MSI code free the MSI descriptors after usage.

Fixes: 0f62d941acf9 ("genirq/msi: Provide msi_domain_alloc/free_irqs_descs_locked()")
Reported-by: Tong Zhang <ztong0001@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/irqdomain.c |    4 ++--
 drivers/pci/msi/legacy.c    |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -28,6 +28,7 @@ void pci_msi_teardown_msi_irqs(struct pc
 		msi_domain_free_irqs_descs_locked(domain, &dev->dev);
 	else
 		pci_msi_legacy_teardown_msi_irqs(dev);
+	msi_free_msi_descs(&dev->dev);
 }
 
 /**
@@ -171,8 +172,7 @@ struct irq_domain *pci_msi_create_irq_do
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		pci_msi_domain_update_chip_ops(info);
 
-	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS |
-		       MSI_FLAG_FREE_MSI_DESCS;
+	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
 		info->flags |= MSI_FLAG_MUST_REACTIVATE;
 
--- a/drivers/pci/msi/legacy.c
+++ b/drivers/pci/msi/legacy.c
@@ -77,5 +77,4 @@ void pci_msi_legacy_teardown_msi_irqs(st
 {
 	msi_device_destroy_sysfs(&dev->dev);
 	arch_teardown_msi_irqs(dev);
-	msi_free_msi_descs(&dev->dev);
 }

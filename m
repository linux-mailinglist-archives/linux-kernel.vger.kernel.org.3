Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48250477F70
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242811AbhLPVnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:43:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57550 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242161AbhLPVlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:16 -0500
Date:   Thu, 16 Dec 2021 21:41:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690875;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTHLVnVNyxC3vAKl9mVWNy0jC97ohV0HRqRYHTFMce4=;
        b=qGLjJfX6gNJsUJGlQReXgrM7PfcRJWNRTR0AXZvJrPfL15GlGSf5vAtR9gz0G3SbXWrTkI
        S3qV/7sjuwj80rbt/DNzLrN03S9S+NszBqD5+CL2vQN2Q4Or03n41wwHnL9cTu1b1a8BFN
        sy4LPDR/P2ts9El5Z01b80Je3qaUjrHukXKmCNdE1dLv+sNkSS/9WP9hMktXq9BJfjvsRo
        IK2ytcC2uTN6aHvwf4UDuy2I+zKwcWiNewsuxikADsoQBmpcuG0KGMloWDlbwvzZZ1IXIQ
        k1v39W5XuENyyl5zXORfjjNECjQ1l8+CF2IAdZdfBlyL2RjlS85amyDjhALAMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690875;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTHLVnVNyxC3vAKl9mVWNy0jC97ohV0HRqRYHTFMce4=;
        b=38NwxVSMQJ+OiPlD38Ifqu1QbW3c6U/ZISqte04tYBkXSK+kRSGNJXdFykCpbv+B2RUCwS
        /oe2Gy3fsTb/L3CQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] x86/apic/msi: Use PCI device MSI property
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221813.372357371@linutronix.de>
References: <20211210221813.372357371@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969087411.23020.4064430322902380887.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     b3f82364117a0b7f666ce023195b636c4803c46c
Gitweb:        https://git.kernel.org/tip/b3f82364117a0b7f666ce023195b636c4803c46c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:18:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:37 +01:00

x86/apic/msi: Use PCI device MSI property

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221813.372357371@linutronix.de

---
 arch/x86/kernel/apic/msi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index b270b70..7517eb0 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -160,11 +160,8 @@ static struct irq_chip pci_msi_controller = {
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct msi_desc *desc = first_pci_msi_entry(pdev);
-
 	init_irq_alloc_info(arg, NULL);
-	if (desc->pci.msi_attrib.is_msix) {
+	if (to_pci_dev(dev)->msix_enabled) {
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
 	} else {
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;

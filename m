Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFBB46ECB8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241053AbhLIQLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:11:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40208 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240864AbhLIQKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:45 -0500
Date:   Thu, 09 Dec 2021 16:07:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SFWFOWbFemN8XJTLkndsJvx/N8i+2dKo53mY5kG0aQU=;
        b=b2jkqUKd89W9foVAPOyWIaISs9jTXgc7cfxWsNjGjC/33xdak2Pm7oCeXz2oL+q8HWoJUX
        xdEjdjupeCrBfii6b9OKewwfKw4LiaYvhRveDoDA5gGb+0sZq5wpy/YZicN6e1W6dK0OnJ
        pvXgUt352BE/lpwCrvv48oOIwTPrm32RZJTxmIPDLw6Cfh68rzZ+YHJDjunx87qLdDHx++
        3P5olS7csZJWAf4hcoNu+yObJ93ELCVbDxyBN/TTCoP6AfRH9tgiIjbtMqJ4Pue71xFloz
        ZJGAPdvoPOsdWi5i7GG4KaU/m+F2Z6IAWt/idmbrK9TbH5o8b+6fJDw6lueUsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SFWFOWbFemN8XJTLkndsJvx/N8i+2dKo53mY5kG0aQU=;
        b=IaVsVfC1M9E/RpuoNgGPFDLdKFgwU1srlQdj2e74csMY2tWi9t3j6JH+1DA+Ybhj9M8YG4
        9FxaBgwePttsnxDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Make pci_msi_domain_write_msg() static
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210224.157070464@linutronix.de>
References: <20211206210224.157070464@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906603000.11128.7815741930460435159.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     9e8688c5f2990dadcf83728cd00a7e8497fc6aa9
Gitweb:        https://git.kernel.org/tip/9e8688c5f2990dadcf83728cd00a7e8497fc6aa9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:20 +01:00

PCI/MSI: Make pci_msi_domain_write_msg() static

There is no point to have this function public as it is set by the PCI core
anyway when a PCI/MSI irqdomain is created.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# PCI
Link: https://lore.kernel.org/r/20211206210224.157070464@linutronix.de

---
 drivers/irqchip/irq-gic-v2m.c            | 1 -
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 1 -
 drivers/irqchip/irq-gic-v3-mbi.c         | 1 -
 drivers/pci/msi.c                        | 2 +-
 include/linux/msi.h                      | 1 -
 5 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 9349fc6..62cc78e 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -88,7 +88,6 @@ static struct irq_chip gicv2m_msi_irq_chip = {
 	.irq_mask		= gicv2m_mask_msi_irq,
 	.irq_unmask		= gicv2m_unmask_msi_irq,
 	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_write_msi_msg	= pci_msi_domain_write_msg,
 };
 
 static struct msi_domain_info gicv2m_msi_domain_info = {
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index ad2810c..93f77a8 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -28,7 +28,6 @@ static struct irq_chip its_msi_irq_chip = {
 	.irq_unmask		= its_unmask_msi_irq,
 	.irq_mask		= its_mask_msi_irq,
 	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_write_msi_msg	= pci_msi_domain_write_msg,
 };
 
 static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index b84c9c2..a2163d3 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -171,7 +171,6 @@ static struct irq_chip mbi_msi_irq_chip = {
 	.irq_unmask		= mbi_unmask_msi_irq,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_compose_msi_msg	= mbi_compose_msi_msg,
-	.irq_write_msi_msg	= pci_msi_domain_write_msg,
 };
 
 static struct msi_domain_info mbi_msi_domain_info = {
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 00ed45f..afa8ba2 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1281,7 +1281,7 @@ EXPORT_SYMBOL_GPL(msi_desc_to_pci_sysdata);
  * @irq_data:	Pointer to interrupt data of the MSI interrupt
  * @msg:	Pointer to the message
  */
-void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
+static void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(irq_data);
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 5c62775..d7b143a 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -455,7 +455,6 @@ void *platform_msi_get_host_data(struct irq_domain *domain);
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
-void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg);
 struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);

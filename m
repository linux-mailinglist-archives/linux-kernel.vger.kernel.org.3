Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171E7477F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbhLPVlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57100 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241637AbhLPVki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:38 -0500
Date:   Thu, 16 Dec 2021 21:40:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690837;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nWhlVhStloy+n2unbImVYZ0v0CUPhieAtxxPMf9Kgdc=;
        b=Adm7IAZogA0ir5ZrHc8cZpZLSIcfTmDVvT+MGW8JlDJaKoX0ZQqwUsmKSBHqFQ/uVdo9eN
        R47n4V2qvMmEqplr5XPnv/DJSMFnLnm87Fn9ZtAr404e/ytUu/jVwpLU5NtZwKzW+6KW2s
        4SiA4wOxllv+bJstjhiJHWCD1qLgJlRc7gMepDqnIyu1mnAPVwlwihY8GXO9yeAhewT1CT
        Ph5edLcvmZcv2rirW//Wog9gQV7tJCatakeDS4PkHqk04pVQ6T6+J2xthWCPlxBYtk5zOL
        CYgjNnycAsDEeveH5e2KDpK5CpdZAmXMdCuvkMbpqpC4ZSYfg0YjoK2ALEIUZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690837;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nWhlVhStloy+n2unbImVYZ0v0CUPhieAtxxPMf9Kgdc=;
        b=cVYTokPNc7WF8hQ4v8CezN5YbEnVNUVLdaiQ4zKi17mgDW62dLvyFu0XP0h2YNk8GErTj0
        TwwN4tNS7FxqqcBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] x86/pci/xen: Use msi_for_each_desc()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210748.198359105@linutronix.de>
References: <20211206210748.198359105@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969083649.23020.10645736229062640796.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     f2948df5f87a722591499da60ab91c611422f755
Gitweb:        https://git.kernel.org/tip/f2948df5f87a722591499da60ab91c611422f755
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:18 +01:00

x86/pci/xen: Use msi_for_each_desc()

Replace the about to vanish iterators.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210748.198359105@linutronix.de

---
 arch/x86/pci/xen.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index ded0320..9bb1e29 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -184,7 +184,7 @@ static int xen_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (ret)
 		goto error;
 	i = 0;
-	for_each_pci_msi_entry(msidesc, dev) {
+	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		irq = xen_bind_pirq_msi_to_irq(dev, msidesc, v[i],
 					       (type == PCI_CAP_ID_MSI) ? nvec : 1,
 					       (type == PCI_CAP_ID_MSIX) ?
@@ -235,7 +235,7 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (type == PCI_CAP_ID_MSI && nvec > 1)
 		return 1;
 
-	for_each_pci_msi_entry(msidesc, dev) {
+	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		pirq = xen_allocate_pirq_msi(dev, msidesc);
 		if (pirq < 0) {
 			irq = -ENODEV;
@@ -270,7 +270,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	int ret = 0;
 	struct msi_desc *msidesc;
 
-	for_each_pci_msi_entry(msidesc, dev) {
+	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		struct physdev_map_pirq map_irq;
 		domid_t domid;
 
@@ -389,11 +389,9 @@ static void xen_teardown_msi_irqs(struct pci_dev *dev)
 	struct msi_desc *msidesc;
 	int i;
 
-	for_each_pci_msi_entry(msidesc, dev) {
-		if (msidesc->irq) {
-			for (i = 0; i < msidesc->nvec_used; i++)
-				xen_destroy_irq(msidesc->irq + i);
-		}
+	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_ASSOCIATED) {
+		for (i = 0; i < msidesc->nvec_used; i++)
+			xen_destroy_irq(msidesc->irq + i);
 	}
 }
 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707C1477F78
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242884AbhLPVn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242192AbhLPVlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79047C06139A;
        Thu, 16 Dec 2021 13:40:56 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:40:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4mBZzOKtj5z6Kz2SF8Dr3KS2c5w0Ji2obm41l12ciSs=;
        b=byViaRYlQacC/gM+i1/pCo9QPLBq4nqr4LtRxr9OBIXUxROniHFeovMcazeBx8Wl310UX6
        dAtECooBtkxd3Z1IUEkcUXzaHl6Im/y8pT3QrjY3tVe8M1v7NfxwiBhkv1GNjoYtVN1VOo
        HW8wrSU+e9XE1UEaY3n2CIh6tuW/bCACLLVMWbpu7c2Tcfm6lMpby3Ixm5BP+A8o6FJY/w
        We7FOX+vvtmumHVYFmmhea46l7Hpwc+/6wXmLXCG6XpUFghdpYgYGUq0Yk7Qqi7Tuy5xL2
        WhnHhc+RH5YZzI9W79ED5RZ5UUgT8WWVHG073FmpJ8zspiDv9Y4P2imjInUMmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4mBZzOKtj5z6Kz2SF8Dr3KS2c5w0Ji2obm41l12ciSs=;
        b=APuyRlcwgpGhN5ZI8BdhaEliDaMbUQxC0vFXZqOPKFtxQumacyJ/Lnla/WmLmOWx1kZGbn
        CmEs6P5hJFpArlBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] powerpc/pseries/msi: Let core code check for
 contiguous entries
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221814.720998720@linutronix.de>
References: <20211210221814.720998720@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969085402.23020.1746302325426674592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     651b39c48813acac2b77850014390f4062a4835d
Gitweb:        https://git.kernel.org/tip/651b39c48813acac2b77850014390f4062a4835d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:40 +01:00

powerpc/pseries/msi: Let core code check for contiguous entries

Set the domain info flag and remove the check.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221814.720998720@linutronix.de


---
 arch/powerpc/platforms/pseries/msi.c | 33 ++++++---------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 27cd1fb..fb2919f 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -321,27 +321,6 @@ out:
 	return request;
 }
 
-static int check_msix_entries(struct pci_dev *pdev)
-{
-	struct msi_desc *entry;
-	int expected;
-
-	/* There's no way for us to express to firmware that we want
-	 * a discontiguous, or non-zero based, range of MSI-X entries.
-	 * So we must reject such requests. */
-
-	expected = 0;
-	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->msi_index != expected) {
-			pr_debug("rtas_msi: bad MSI-X entries.\n");
-			return -EINVAL;
-		}
-		expected++;
-	}
-
-	return 0;
-}
-
 static void rtas_hack_32bit_msi_gen2(struct pci_dev *pdev)
 {
 	u32 addr_hi, addr_lo;
@@ -380,9 +359,6 @@ static int rtas_prepare_msi_irqs(struct pci_dev *pdev, int nvec_in, int type,
 	if (quota && quota < nvec)
 		return quota;
 
-	if (type == PCI_CAP_ID_MSIX && check_msix_entries(pdev))
-		return -EINVAL;
-
 	/*
 	 * Firmware currently refuse any non power of two allocation
 	 * so we round up if the quota will allow it.
@@ -529,9 +505,16 @@ static struct irq_chip pseries_pci_msi_irq_chip = {
 	.irq_write_msi_msg	= pseries_msi_write_msg,
 };
 
+
+/*
+ * Set MSI_FLAG_MSIX_CONTIGUOUS as there is no way to express to
+ * firmware to request a discontiguous or non-zero based range of
+ * MSI-X entries. Core code will reject such setup attempts.
+ */
 static struct msi_domain_info pseries_msi_domain_info = {
 	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_MULTI_PCI_MSI  | MSI_FLAG_PCI_MSIX),
+		  MSI_FLAG_MULTI_PCI_MSI  | MSI_FLAG_PCI_MSIX |
+		  MSI_FLAG_MSIX_CONTIGUOUS),
 	.ops   = &pseries_pci_msi_domain_ops,
 	.chip  = &pseries_pci_msi_irq_chip,
 };

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CB5479C58
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 20:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhLRTja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 14:39:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40070 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhLRTj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 14:39:29 -0500
Date:   Sat, 18 Dec 2021 19:39:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639856368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ildVUdGHtkDCq6TzbTw3Bge/LUgZu9LlUiguTv9Ha5c=;
        b=FWtUjUPZIR+QsPkNjLhGnvF3/7ZY/cBGfWONbIb5csByMwKGKi5qKhcMwTVNepFEr2KKMh
        p+MXLG3RZdHsW7Ix7eG+n2azODS6vPiXa/TfvvQFT+w9QylsFHWhiOs7KM4unhFDY2wHw2
        C2ND1OJOSKMPqmtgZckALDiDnJ4ff3u8Pc9HIBVgfOTN8g1TbkyB1dy4dNynBr8Z7hQCEN
        ccqkCsYSz/SrF5n1oeBpTWrIfI2vCATpeXXBNCwEoby6VfOl+LznP3R1c+3q3DviZBjVPz
        j8hYMaxyLNRzKf1VFEdUTrVL36ulli1eq6kOBHRup8qzYjJx60ElmFTXZDrRPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639856368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ildVUdGHtkDCq6TzbTw3Bge/LUgZu9LlUiguTv9Ha5c=;
        b=9ylNR5bl43pLfVz/c66HZ/jVLLTm43iicZ7i/Yr5SvBzFj0pfL9xbyfn3sUPQRC8qVJwzH
        2sSvqu8lLaL3UtCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Unbreak pci_irq_get_affinity()
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87v8zm9pmd.ffs@tglx>
References: <87v8zm9pmd.ffs@tglx>
MIME-Version: 1.0
Message-ID: <163985636689.23020.17674623774839628047.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     d558285413ea2f934ab90223ba908c30c5113aee
Gitweb:        https://git.kernel.org/tip/d558285413ea2f934ab90223ba908c30c5113aee
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 18 Dec 2021 11:25:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 18 Dec 2021 20:33:21 +01:00

PCI/MSI: Unbreak pci_irq_get_affinity()

The recent cleanup of pci_irq_get_affinity() broke the function for
PCI/MSI-X and indices > 0. Only the MSI descriptor for PCI/MSI has more
than one affinity mask which can be retrieved via the MSI index.

PCI/MSI-X has one descriptor per vector and each has a single affinity
mask.

Use index 0 when accessing the affinity mask in the MSI descriptor when
MSI-X is enabled.

Fixes: f48235900182 ("PCI/MSI: Simplify pci_irq_get_affinity()")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/87v8zm9pmd.ffs@tglx


---
 drivers/pci/msi/msi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 7180241..c19c7ca 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -1100,7 +1100,7 @@ EXPORT_SYMBOL(pci_irq_vector);
  */
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 {
-	int irq = pci_irq_vector(dev, nr);
+	int idx, irq = pci_irq_vector(dev, nr);
 	struct msi_desc *desc;
 
 	if (WARN_ON_ONCE(irq <= 0))
@@ -1113,7 +1113,13 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 
 	if (WARN_ON_ONCE(!desc->affinity))
 		return NULL;
-	return &desc->affinity[nr].mask;
+
+	/*
+	 * MSI has a mask array in the descriptor.
+	 * MSI-X has a single mask.
+	 */
+	idx = dev->msi_enabled ? nr : 0;
+	return &desc->affinity[idx].mask;
 }
 EXPORT_SYMBOL(pci_irq_get_affinity);
 

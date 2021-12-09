Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6958446ECBA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbhLIQLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:11:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40094 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240887AbhLIQKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:43 -0500
Date:   Thu, 09 Dec 2021 16:07:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=027+Jg90PtMMnu3BxbxQ3HZOZsR3izxJDSk11JbDpp4=;
        b=mLiByutjQZjukFS9cQhTrQfYKbHA49k83WQezAekLiLt8llxqTuEhN3ll1VSqi1AYr3rbd
        J7i6G13A+jDtMWAliSxYE9ooREb6NXcKubalF7VSRtCA+YDtwP5WAfoMhuSerFsbKs53RN
        gCBRsFmvLDlk7c6J5Ly4kdVk4ASF9trxq1F1oJtvnlL3em0wGPgT6tQm9UuVeoP/a7vfbC
        2WjSlz64rFE/sRBUaEtUnS6AK1uG/lo6+YaZxoMlGH9uPMhn7Z7ut8sqB+VB5RpBJ8gdCM
        RG6Xtu9vDGm2U5IhDJtN6Oc+m9vxkSQPuH/0eTOmKhyo9MC5ZmCrZVj2vR4s8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=027+Jg90PtMMnu3BxbxQ3HZOZsR3izxJDSk11JbDpp4=;
        b=DIkuHvQS8ZQnOaSX2u+zbnKVQB3ILeCNBVRuE+w2PwlPMwUBahnqgpQxBWphydY/xn7WwB
        AEtAQ0oNun439BBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] MIPS: Octeon: Use arch_setup_msi_irq()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211206210224.319201379@linutronix.de>
References: <20211206210224.319201379@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906602778.11128.297787168075793928.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     bec61847cdc7ff22d6d85e6e6436d4b7416c1f9b
Gitweb:        https://git.kernel.org/tip/bec61847cdc7ff22d6d85e6e6436d4b7416c1f9b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:21 +01:00

MIPS: Octeon: Use arch_setup_msi_irq()

The core code provides the same loop code except for the MSI-X reject. Move
that to arch_setup_msi_irq() and remove the duplicated code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Link: https://lore.kernel.org/r/20211206210224.319201379@linutronix.de

---
 arch/mips/pci/msi-octeon.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
index 288b58b..c2860eb 100644
--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -68,6 +68,9 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 	u64 search_mask;
 	int index;
 
+	if (desc->pci.msi_attrib.is_msix)
+		return -EINVAL;
+
 	/*
 	 * Read the MSI config to figure out how many IRQs this device
 	 * wants.  Most devices only want 1, which will give
@@ -182,35 +185,6 @@ msi_irq_allocated:
 	return 0;
 }
 
-int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	struct msi_desc *entry;
-	int ret;
-
-	/*
-	 * MSI-X is not supported.
-	 */
-	if (type == PCI_CAP_ID_MSIX)
-		return -EINVAL;
-
-	/*
-	 * If an architecture wants to support multiple MSI, it needs to
-	 * override arch_setup_msi_irqs()
-	 */
-	if (type == PCI_CAP_ID_MSI && nvec > 1)
-		return 1;
-
-	for_each_pci_msi_entry(entry, dev) {
-		ret = arch_setup_msi_irq(dev, entry);
-		if (ret < 0)
-			return ret;
-		if (ret > 0)
-			return -ENOSPC;
-	}
-
-	return 0;
-}
-
 /**
  * Called when a device no longer needs its MSI interrupts. All
  * MSI interrupts for the device are freed.

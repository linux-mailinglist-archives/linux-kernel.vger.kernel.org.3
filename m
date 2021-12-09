Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A2446EC8C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbhLIQKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:10:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40026 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbhLIQKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:32 -0500
Date:   Thu, 09 Dec 2021 16:06:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066018;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xmvk0aKvcBguPkMWpUCWxNUDlvgz/NGfxn9XQd9DMJo=;
        b=25dQZSWa9lfmbO/4RZ++TZA8GukREVZQKc+wD2stwlw9o/V2qePOeS21w+tDpGPo3qsifI
        YTrw/sxWycgPu9qr4Lpqn3ZACm5frcsM9uJ448SmBckbWgoOjwXQ26I4lU6eLbNUNWk7w4
        b54v8+KLgkcDcJBUpXtqP54D6YcTe+lQZrPv+t0tuVycRw2iDKc0tQ0xqrQ4ns2LpW4d68
        tle9xBlaoObHd4rBw3647TC/v05EXxjBl2YAPRm8RO75P/3SEMo163sIQcK3uVjP0DW91X
        FmhE2lS6wQnyIaCIWbgrb9XGDRDU5WwXZ0Ds1L4BgEEcaM9qZ0XGV7zzr2mUtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066018;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xmvk0aKvcBguPkMWpUCWxNUDlvgz/NGfxn9XQd9DMJo=;
        b=QIxMXFKb4+roK6fnL40/8d2ViN6qvA2Ki1yEypSFO4bd1/t1xM0d2LdUUWs5Hhg2eHSC1d
        jW9CZHAM6NAJ4zBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Move descriptor counting on allocation fail
 to the legacy code
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210225.101336873@linutronix.de>
References: <20211206210225.101336873@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906601682.11128.14029351838341914597.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     60bf9b33c82c0e040a98272d7ff4f5a52e7469d6
Gitweb:        https://git.kernel.org/tip/60bf9b33c82c0e040a98272d7ff4f5a52e7469d6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:28:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:23 +01:00

PCI/MSI: Move descriptor counting on allocation fail to the legacy code

The irqdomain code already returns the information. Move the loop to the
legacy code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20211206210225.101336873@linutronix.de

---
 drivers/pci/msi/legacy.c | 20 +++++++++++++++++++-
 drivers/pci/msi/msi.c    | 19 +------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/msi/legacy.c b/drivers/pci/msi/legacy.c
index 023de20..d52cff1 100644
--- a/drivers/pci/msi/legacy.c
+++ b/drivers/pci/msi/legacy.c
@@ -50,9 +50,27 @@ void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
 	}
 }
 
+static int pci_msi_setup_check_result(struct pci_dev *dev, int type, int ret)
+{
+	struct msi_desc *entry;
+	int avail = 0;
+
+	if (type != PCI_CAP_ID_MSIX || ret >= 0)
+		return ret;
+
+	/* Scan the MSI descriptors for successfully allocated ones. */
+	for_each_pci_msi_entry(entry, dev) {
+		if (entry->irq != 0)
+			avail++;
+	}
+	return avail ? avail : ret;
+}
+
 int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
-	return arch_setup_msi_irqs(dev, nvec, type);
+	int ret = arch_setup_msi_irqs(dev, nvec, type);
+
+	return pci_msi_setup_check_result(dev, type, ret);
 }
 
 void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 443a16c..8b4d529 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -609,7 +609,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
 	if (ret)
-		goto out_avail;
+		goto out_free;
 
 	/* Check if all MSI entries honor device restrictions */
 	ret = msi_verify_entries(dev);
@@ -634,23 +634,6 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	pcibios_free_irq(dev);
 	return 0;
 
-out_avail:
-	if (ret < 0) {
-		/*
-		 * If we had some success, report the number of IRQs
-		 * we succeeded in setting up.
-		 */
-		struct msi_desc *entry;
-		int avail = 0;
-
-		for_each_pci_msi_entry(entry, dev) {
-			if (entry->irq != 0)
-				avail++;
-		}
-		if (avail != 0)
-			ret = avail;
-	}
-
 out_free:
 	free_msi_irqs(dev);
 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE40477F62
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbhLPVmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57484 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242103AbhLPVlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:09 -0500
Date:   Thu, 16 Dec 2021 21:41:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=akk4ktlq3Oo5h9EmIlFCWuTrQIw5AjagfsSgxxsfB8U=;
        b=DiiA/tBOskDfkXyUsUHn9AqpoWGpzR+cfsxGoQphXycUiS93lOe72cn4PAH5UbPCbI0PT5
        vfSwZEpWK4CWIxpl6Z2A2ZnKX7+OkDtdlYkswjTaYEyRsMiDvuG1tx7GR5/7cr/TqHqZkM
        tYV3YdbMEXxAqg/Iu3fiZ0m4Z+LSOd4wUxD/IFDzgFBXDhcGfcpD6DAu9OjSblQ4jUyV/c
        ms1hdqxDhCuwphER2p1ZTMrQVdButsqmADMuRJglU3BTVgOyV16DdeXYycWEP9d68mC3P+
        dNZ7pKuuhmvu5ZWbWGvEZs2o4fHIeniEibSx5h7iWgIsV5JTzmvwsGfVGidBFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=akk4ktlq3Oo5h9EmIlFCWuTrQIw5AjagfsSgxxsfB8U=;
        b=bwbrL4Unuvok8xldORZSH35b+4FFWZmnu5WgTCE4I/ISMIKd4JBsDcFyEfxvKrvHfpiv6S
        hxgPhSQzK892T0DQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Allocate MSI device data on first use
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87r1adrdje.ffs@tglx>
References: <87r1adrdje.ffs@tglx>
MIME-Version: 1.0
Message-ID: <163969086699.23020.8679575401296088362.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     93296cd1325d1d9afede60202d8833011c9001f2
Gitweb:        https://git.kernel.org/tip/93296cd1325d1d9afede60202d8833011c9001f2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 15 Dec 2021 18:19:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:38 +01:00

PCI/MSI: Allocate MSI device data on first use

Allocate MSI device data on first use, i.e. when a PCI driver invokes one
of the PCI/MSI enablement functions.

Add a wrapper function to ensure that the ordering vs. pcim_msi_release()
is correct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/87r1adrdje.ffs@tglx

---
 drivers/pci/msi/msi.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 358b63e..369e3c5 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -366,6 +366,19 @@ static int pcim_setup_msi_release(struct pci_dev *dev)
 	return ret;
 }
 
+/*
+ * Ordering vs. devres: msi device data has to be installed first so that
+ * pcim_msi_release() is invoked before it on device release.
+ */
+static int pci_setup_msi_context(struct pci_dev *dev)
+{
+	int ret = msi_setup_device_data(&dev->dev);
+
+	if (!ret)
+		ret = pcim_setup_msi_release(dev);
+	return ret;
+}
+
 static struct msi_desc *
 msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 {
@@ -909,7 +922,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (nvec > maxvec)
 		nvec = maxvec;
 
-	rc = pcim_setup_msi_release(dev);
+	rc = pci_setup_msi_context(dev);
 	if (rc)
 		return rc;
 
@@ -956,7 +969,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
-	rc = pcim_setup_msi_release(dev);
+	rc = pci_setup_msi_context(dev);
 	if (rc)
 		return rc;
 

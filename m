Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E92477F61
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242504AbhLPVmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57496 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242104AbhLPVlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:09 -0500
Date:   Thu, 16 Dec 2021 21:41:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pT9c8jW1tMYDhqT5vyE/X0QUoRLExIwGh26EU6ab/MU=;
        b=DDsb8X5R4wkiGUe36QEsIaBlzb96jdhYYBsdzXMWUsZT8/64B2CgYaw8tTgOIAx7yYCDnQ
        QbsVfX9oDwrtKzL6bRysZTOn2EK2+6dmT1UVA4R7G2n5sDmMeavDA6y+iihNa7FlTwymj/
        O3UuQctazKT+XCGsgLuXPxMQCCEq1YH+eigVp1oubQ4WRrUJiUZX5qCCezSfRfx6Ek9jPT
        FAQOAoZYfpxpHmSrQiS3SOZFN8waazxb9oziYcC0Fyhf5ByjeqnFSMqS2W6AK/aCzC9N2H
        5axaOJySYA/67/X2zE1CB+GB+XLxHCJaMcm9ob3Us6EWu7QWb5qT2cwr13h3DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pT9c8jW1tMYDhqT5vyE/X0QUoRLExIwGh26EU6ab/MU=;
        b=NhcbMzDxYAUFv+jNvB+I4N+vcRO0ETbfUpubeP+VOACsvB3qDF+JWQ1xdYFYsdZBj3uVoz
        TCB4lYGX3cKmEQAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Decouple MSI[-X] disable from pcim_release()
Cc:     Nishanth Menon <nm@ti.com>, Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87tuf9rdoj.ffs@tglx>
References: <87tuf9rdoj.ffs@tglx>
MIME-Version: 1.0
Message-ID: <163969086774.23020.7266150403763141657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     3f35d2cf9fbc656db82579d849cc69c373b1ad0d
Gitweb:        https://git.kernel.org/tip/3f35d2cf9fbc656db82579d849cc69c373b1ad0d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 15 Dec 2021 18:16:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:38 +01:00

PCI/MSI: Decouple MSI[-X] disable from pcim_release()

The MSI core will introduce runtime allocation of MSI related data. This
data will be devres managed and has to be set up before enabling
PCI/MSI[-X]. This would introduce an ordering issue vs. pcim_release().

The setup order is:

   pcim_enable_device()
	devres_alloc(pcim_release...);
	...
	pci_irq_alloc()
	  msi_setup_device_data()
	     devres_alloc(msi_device_data_release, ...)

and once the device is released these release functions are invoked in the
opposite order:

    msi_device_data_release()
    ...
    pcim_release()
       pci_disable_msi[x]()

which is obviously wrong, because pci_disable_msi[x]() requires the MSI
data to be available to tear down the MSI[-X] interrupts.

Remove the MSI[-X] teardown from pcim_release() and add an explicit action
to be installed on the attempt of enabling PCI/MSI[-X].

This allows the MSI core data allocation to be ordered correctly in a
subsequent step.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/87tuf9rdoj.ffs@tglx

---
 drivers/pci/msi/msi.c | 33 +++++++++++++++++++++++++++++++++
 drivers/pci/pci.c     |  5 -----
 include/linux/pci.h   |  3 ++-
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 5af8d9b..358b63e 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -341,6 +341,31 @@ void pci_restore_msi_state(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_restore_msi_state);
 
+static void pcim_msi_release(void *pcidev)
+{
+	struct pci_dev *dev = pcidev;
+
+	dev->is_msi_managed = false;
+	pci_free_irq_vectors(dev);
+}
+
+/*
+ * Needs to be separate from pcim_release to prevent an ordering problem
+ * vs. msi_device_data_release() in the MSI core code.
+ */
+static int pcim_setup_msi_release(struct pci_dev *dev)
+{
+	int ret;
+
+	if (!pci_is_managed(dev) || dev->is_msi_managed)
+		return 0;
+
+	ret = devm_add_action(&dev->dev, pcim_msi_release, dev);
+	if (!ret)
+		dev->is_msi_managed = true;
+	return ret;
+}
+
 static struct msi_desc *
 msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 {
@@ -884,6 +909,10 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (nvec > maxvec)
 		nvec = maxvec;
 
+	rc = pcim_setup_msi_release(dev);
+	if (rc)
+		return rc;
+
 	for (;;) {
 		if (affd) {
 			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
@@ -927,6 +956,10 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
+	rc = pcim_setup_msi_release(dev);
+	if (rc)
+		return rc;
+
 	for (;;) {
 		if (affd) {
 			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3d2fb39..f3f606c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2024,11 +2024,6 @@ static void pcim_release(struct device *gendev, void *res)
 	struct pci_devres *this = res;
 	int i;
 
-	if (dev->msi_enabled)
-		pci_disable_msi(dev);
-	if (dev->msix_enabled)
-		pci_disable_msix(dev);
-
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
 		if (this->region_mask & (1 << i))
 			pci_release_region(dev, i);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5cc46ba..a09736d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -425,7 +425,8 @@ struct pci_dev {
 	unsigned int	ats_enabled:1;		/* Address Translation Svc */
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
-	unsigned int	is_managed:1;
+	unsigned int	is_managed:1;		/* Managed via devres */
+	unsigned int	is_msi_managed:1;	/* MSI release via devres installed */
 	unsigned int	needs_freset:1;		/* Requires fundamental reset */
 	unsigned int	state_saved:1;
 	unsigned int	is_physfn:1;

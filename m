Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F97446ECA9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240936AbhLIQKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240837AbhLIQKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F316C0617A1;
        Thu,  9 Dec 2021 08:07:05 -0800 (PST)
Date:   Thu, 09 Dec 2021 16:07:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066023;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rH8qqG340nECVV+FsfxhPzB4WKR55jqGEE/QtRiBeI8=;
        b=EbTfx56pgZ/9OGNukAe3ddjAVk80NAqQLwVJBhnjKostg03zIdwSShkhKnjbWNTCUaOSA+
        E4/NmLgH8varE/7rD9WgP1j36u4C/uHWSYICsyOqAFj3PlxZxOcgb/EETKBbSHgakPeY8l
        B5wnfSjSKO1zBkn15rY9k9+tsp87lO59AoNxb7wro5VaXJK6FuSnpzt1okRt6dE9XjdD+B
        yw7Vi7YKr0FQSaafetBe0IuaRc6/fA/Ul2PT2fNjYGr3YZOQwbFYEhMDVdws6Lv+mf2VnT
        FM9nWTX48T1DfUULGweehpCqNUDfe/BtDGcLD9kKb+B3SOQB3fkuU9nm7/P5Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066023;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rH8qqG340nECVV+FsfxhPzB4WKR55jqGEE/QtRiBeI8=;
        b=Z1uvNNTqtjUj+JyVfVfdnyJEEF7WsSYVzq6f6qFXBCQBd30OoMncYFRYOrX6o2XV6JlY0a
        QY1QFPeUaemCnnAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Split out CONFIG_PCI_MSI independent part
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210224.710137730@linutronix.de>
References: <20211206210224.710137730@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906602245.11128.822420113161590627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     54324c2f3d728f451d9053fcc7859b26fc9cecb4
Gitweb:        https://git.kernel.org/tip/54324c2f3d728f451d9053fcc7859b26fc9cecb4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:22 +01:00

PCI/MSI: Split out CONFIG_PCI_MSI independent part

These functions are required even when CONFIG_PCI_MSI is not set. Move them
to their own file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211206210224.710137730@linutronix.de

---
 drivers/pci/msi/Makefile     |  3 +-
 drivers/pci/msi/msi.c        | 39 +--------------------------------
 drivers/pci/msi/pcidev_msi.c | 43 +++++++++++++++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 40 deletions(-)
 create mode 100644 drivers/pci/msi/pcidev_msi.c

diff --git a/drivers/pci/msi/Makefile b/drivers/pci/msi/Makefile
index 79a6013..8ed69b3 100644
--- a/drivers/pci/msi/Makefile
+++ b/drivers/pci/msi/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the PCI/MSI
-obj-$(CONFIG_PCI)		+= msi.o
+obj-$(CONFIG_PCI)		+= pcidev_msi.o
+obj-$(CONFIG_PCI_MSI)		+= msi.o
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 00233b0..a32345d 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -18,8 +18,6 @@
 
 #include "../pci.h"
 
-#ifdef CONFIG_PCI_MSI
-
 static int pci_msi_enable = 1;
 int pci_msi_ignore_mask;
 
@@ -1493,40 +1491,3 @@ bool pci_dev_has_special_msi_domain(struct pci_dev *pdev)
 }
 
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
-#endif /* CONFIG_PCI_MSI */
-
-void pci_msi_init(struct pci_dev *dev)
-{
-	u16 ctrl;
-
-	/*
-	 * Disable the MSI hardware to avoid screaming interrupts
-	 * during boot.  This is the power on reset default so
-	 * usually this should be a noop.
-	 */
-	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (!dev->msi_cap)
-		return;
-
-	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &ctrl);
-	if (ctrl & PCI_MSI_FLAGS_ENABLE)
-		pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS,
-				      ctrl & ~PCI_MSI_FLAGS_ENABLE);
-
-	if (!(ctrl & PCI_MSI_FLAGS_64BIT))
-		dev->no_64bit_msi = 1;
-}
-
-void pci_msix_init(struct pci_dev *dev)
-{
-	u16 ctrl;
-
-	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (!dev->msix_cap)
-		return;
-
-	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
-	if (ctrl & PCI_MSIX_FLAGS_ENABLE)
-		pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
-				      ctrl & ~PCI_MSIX_FLAGS_ENABLE);
-}
diff --git a/drivers/pci/msi/pcidev_msi.c b/drivers/pci/msi/pcidev_msi.c
new file mode 100644
index 0000000..5520aff
--- /dev/null
+++ b/drivers/pci/msi/pcidev_msi.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MSI[X} related functions which are available unconditionally.
+ */
+#include "../pci.h"
+
+/*
+ * Disable the MSI[X] hardware to avoid screaming interrupts during boot.
+ * This is the power on reset default so usually this should be a noop.
+ */
+
+void pci_msi_init(struct pci_dev *dev)
+{
+	u16 ctrl;
+
+	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	if (!dev->msi_cap)
+		return;
+
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &ctrl);
+	if (ctrl & PCI_MSI_FLAGS_ENABLE) {
+		pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS,
+				      ctrl & ~PCI_MSI_FLAGS_ENABLE);
+	}
+
+	if (!(ctrl & PCI_MSI_FLAGS_64BIT))
+		dev->no_64bit_msi = 1;
+}
+
+void pci_msix_init(struct pci_dev *dev)
+{
+	u16 ctrl;
+
+	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	if (!dev->msix_cap)
+		return;
+
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	if (ctrl & PCI_MSIX_FLAGS_ENABLE) {
+		pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
+				      ctrl & ~PCI_MSIX_FLAGS_ENABLE);
+	}
+}

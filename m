Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CC146ECA5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbhLIQKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:10:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40098 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240809AbhLIQKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:37 -0500
Date:   Thu, 09 Dec 2021 16:07:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvWWSKyUAU6RiRFcW73BLGik6DU+UhkHXp/MiLM01JE=;
        b=JtE/qZiWgYm+CmxxDFFXc8D9bJwmpa+CliIZT/aiBB6s8T+1eFKA5cdEmkXE6oD0tohct+
        d1qCKARcxnLeBRnBYOQimerwDfSdkaJXHpuU5u/f7JAkHwOtehPwt2fNGm//rCASKFlMKj
        4rd+kjNDdLFlrSsUlAHxBlhUubUjY1nUBEgec6VW3EFDgvddVyLUcOvfzbambI2QlfCkov
        yWF5nKmQUpKl57hXGna8JyAJpComE1FV2b9/9udQjDonFQ+7DckOo10MlgRe3g2ByZFnes
        Uua7XZRZ1naApLv3+s8Pp99mHKKXnKIC/3txWLL3EI7HLtTx0ftVehqI/0rXxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvWWSKyUAU6RiRFcW73BLGik6DU+UhkHXp/MiLM01JE=;
        b=5m1LyQXbw0nqGKIJoYMZlEjWUy4/wUfCqyt6HA6snEger8zHzOKQypJbD5STzt1jWr1HgC
        zQR8yifsFNcYPpBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Split out !IRQDOMAIN code
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210224.763574089@linutronix.de>
References: <20211206210224.763574089@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906602170.11128.6339482653349984862.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     a01e09ef123789aa2e23e6b0238ed420791dd4ea
Gitweb:        https://git.kernel.org/tip/a01e09ef123789aa2e23e6b0238ed420791dd4ea
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:22 +01:00

PCI/MSI: Split out !IRQDOMAIN code

Split out the non irqdomain code into its own file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211206210224.763574089@linutronix.de

---
 drivers/pci/msi/Makefile |  5 ++--
 drivers/pci/msi/legacy.c | 52 +++++++++++++++++++++++++++++++++++++++-
 drivers/pci/msi/msi.c    | 46 +-----------------------------------
 3 files changed, 55 insertions(+), 48 deletions(-)
 create mode 100644 drivers/pci/msi/legacy.c

diff --git a/drivers/pci/msi/Makefile b/drivers/pci/msi/Makefile
index 8ed69b3..64bf147 100644
--- a/drivers/pci/msi/Makefile
+++ b/drivers/pci/msi/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the PCI/MSI
-obj-$(CONFIG_PCI)		+= pcidev_msi.o
-obj-$(CONFIG_PCI_MSI)		+= msi.o
+obj-$(CONFIG_PCI)			+= pcidev_msi.o
+obj-$(CONFIG_PCI_MSI)			+= msi.o
+obj-$(CONFIG_PCI_MSI_ARCH_FALLBACKS)	+= legacy.o
diff --git a/drivers/pci/msi/legacy.c b/drivers/pci/msi/legacy.c
new file mode 100644
index 0000000..4c76c59
--- /dev/null
+++ b/drivers/pci/msi/legacy.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Message Signaled Interrupt (MSI).
+ *
+ * Legacy architecture specific setup and teardown mechanism.
+ */
+#include <linux/msi.h>
+#include <linux/pci.h>
+
+/* Arch hooks */
+int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
+{
+	return -EINVAL;
+}
+
+void __weak arch_teardown_msi_irq(unsigned int irq)
+{
+}
+
+int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	struct msi_desc *desc;
+	int ret;
+
+	/*
+	 * If an architecture wants to support multiple MSI, it needs to
+	 * override arch_setup_msi_irqs()
+	 */
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
+
+	for_each_pci_msi_entry(desc, dev) {
+		ret = arch_setup_msi_irq(dev, desc);
+		if (ret)
+			return ret < 0 ? ret : -ENOSPC;
+	}
+
+	return 0;
+}
+
+void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
+{
+	struct msi_desc *desc;
+	int i;
+
+	for_each_pci_msi_entry(desc, dev) {
+		if (desc->irq) {
+			for (i = 0; i < desc->nvec_used; i++)
+				arch_teardown_msi_irq(desc->irq + i);
+		}
+	}
+}
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index a32345d..78f10ce 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -50,52 +50,6 @@ static void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 #define pci_msi_teardown_msi_irqs	arch_teardown_msi_irqs
 #endif
 
-#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
-/* Arch hooks */
-int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
-{
-	return -EINVAL;
-}
-
-void __weak arch_teardown_msi_irq(unsigned int irq)
-{
-}
-
-int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	struct msi_desc *entry;
-	int ret;
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
-void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
-{
-	int i;
-	struct msi_desc *entry;
-
-	for_each_pci_msi_entry(entry, dev)
-		if (entry->irq)
-			for (i = 0; i < entry->nvec_used; i++)
-				arch_teardown_msi_irq(entry->irq + i);
-}
-#endif /* CONFIG_PCI_MSI_ARCH_FALLBACKS */
-
 /*
  * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
  * mask all MSI interrupts by clearing the MSI enable bit does not work

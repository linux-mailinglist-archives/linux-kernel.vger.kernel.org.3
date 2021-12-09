Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3BC46ECB1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbhLIQLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:11:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40098 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbhLIQKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:40 -0500
Date:   Thu, 09 Dec 2021 16:07:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066026;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XPakcFBvPJyvD1yW+ck0VbM2DjXgR8qQI76i/XruG0g=;
        b=liV4ZtvLU6tmQxBSwZPJ/oUiolFVZX9yJvPTztFzriauQK+VucRCxL9jlu7wsSMDAx4Wxx
        jVAvewcYj6omSNLI/Vm+fAlNT41diBzzhz5QkJUrDdiCWyTMN8xEfmbC4fSu877bwGKUxB
        lyhxQ/W7ody2vvJM0C+3qP1duG/dsOnIhhpbfrkyvhw7UQ4ynfirTzQpi5lo3nPP4VkjUw
        eY4THICjuN69rvq6+CvC6iZz1YGNiRguob25Mya+XTrMaHmRc/RiAFg3mB6mZabLChUtwJ
        SsedtiDM6s68hcEuOpwIfSBg5Ca9ue8GJi2bKOr+ohXNZ33/3aE48g73krPIYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066026;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XPakcFBvPJyvD1yW+ck0VbM2DjXgR8qQI76i/XruG0g=;
        b=Kf0SQatWB6RIn+U+gjdsETSmjfWvdfuaLonyepTXZNis225NY+2dGjdAcxYt0ePK4FvCVC
        c3VlqMZ9R8SkauCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Make arch_restore_msi_irqs() less horrible.
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210224.485668098@linutronix.de>
References: <20211206210224.485668098@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906602557.11128.7547534529139367017.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     ae72f3156729541581f526b85883ca53a20df2fa
Gitweb:        https://git.kernel.org/tip/ae72f3156729541581f526b85883ca53a20df2fa
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:21 +01:00

PCI/MSI: Make arch_restore_msi_irqs() less horrible.

Make arch_restore_msi_irqs() return a boolean which indicates whether the
core code should restore the MSI message or not. Get rid of the indirection
in x86.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# PCI
Link: https://lore.kernel.org/r/20211206210224.485668098@linutronix.de

---
 arch/s390/pci/pci_irq.c               |  4 +-
 arch/x86/include/asm/x86_init.h       |  6 +---
 arch/x86/include/asm/xen/hypervisor.h |  8 ++++-
 arch/x86/kernel/apic/msi.c            |  6 +++-
 arch/x86/kernel/x86_init.c            | 12 +------
 arch/x86/pci/xen.c                    | 13 +++---
 drivers/pci/msi.c                     | 54 +++++++++-----------------
 include/linux/msi.h                   |  7 +--
 8 files changed, 45 insertions(+), 65 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 954bb7a..2beb8a0 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -387,13 +387,13 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 		airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
 }
 
-void arch_restore_msi_irqs(struct pci_dev *pdev)
+bool arch_restore_msi_irqs(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
 	if (!zdev->irqs_registered)
 		zpci_set_irq(zdev);
-	default_restore_msi_irqs(pdev);
+	return true;
 }
 
 static struct airq_struct zpci_airq = {
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 5c69f7e..22b7412 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -289,12 +289,6 @@ struct x86_platform_ops {
 	struct x86_hyper_runtime hyper;
 };
 
-struct pci_dev;
-
-struct x86_msi_ops {
-	void (*restore_msi_irqs)(struct pci_dev *dev);
-};
-
 struct x86_apic_ops {
 	unsigned int	(*io_apic_read)   (unsigned int apic, unsigned int reg);
 	void		(*restore)(void);
diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 5adab89..677f84d 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -57,6 +57,14 @@ static inline bool __init xen_x2apic_para_available(void)
 }
 #endif
 
+struct pci_dev;
+
+#ifdef CONFIG_XEN_DOM0
+bool xen_initdom_restore_msi(struct pci_dev *dev);
+#else
+static inline bool xen_initdom_restore_msi(struct pci_dev *dev) { return true; }
+#endif
+
 #ifdef CONFIG_HOTPLUG_CPU
 void xen_arch_register_cpu(int num);
 void xen_arch_unregister_cpu(int num);
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 1656477..b270b70 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -19,6 +19,7 @@
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
+#include <asm/xen/hypervisor.h>
 
 struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
 
@@ -345,3 +346,8 @@ void dmar_free_hwirq(int irq)
 	irq_domain_free_irqs(irq, 1);
 }
 #endif
+
+bool arch_restore_msi_irqs(struct pci_dev *dev)
+{
+	return xen_initdom_restore_msi(dev);
+}
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 8b39582..7d20c1d 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -145,18 +145,6 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 
 EXPORT_SYMBOL_GPL(x86_platform);
 
-#if defined(CONFIG_PCI_MSI)
-struct x86_msi_ops x86_msi __ro_after_init = {
-	.restore_msi_irqs	= default_restore_msi_irqs,
-};
-
-/* MSI arch specific hooks */
-void arch_restore_msi_irqs(struct pci_dev *dev)
-{
-	x86_msi.restore_msi_irqs(dev);
-}
-#endif
-
 struct x86_apic_ops x86_apic_ops __ro_after_init = {
 	.io_apic_read	= native_io_apic_read,
 	.restore	= native_restore_boot_irq_mode,
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 2dace88..a63d30a 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -351,10 +351,13 @@ out:
 	return ret;
 }
 
-static void xen_initdom_restore_msi_irqs(struct pci_dev *dev)
+bool xen_initdom_restore_msi(struct pci_dev *dev)
 {
 	int ret = 0;
 
+	if (!xen_initial_domain())
+		return true;
+
 	if (pci_seg_supported) {
 		struct physdev_pci_device restore_ext;
 
@@ -375,10 +378,10 @@ static void xen_initdom_restore_msi_irqs(struct pci_dev *dev)
 		ret = HYPERVISOR_physdev_op(PHYSDEVOP_restore_msi, &restore);
 		WARN(ret && ret != -ENOSYS, "restore_msi -> %d\n", ret);
 	}
+	return false;
 }
 #else /* CONFIG_XEN_PV_DOM0 */
 #define xen_initdom_setup_msi_irqs	NULL
-#define xen_initdom_restore_msi_irqs	NULL
 #endif /* !CONFIG_XEN_PV_DOM0 */
 
 static void xen_teardown_msi_irqs(struct pci_dev *dev)
@@ -466,12 +469,10 @@ static __init struct irq_domain *xen_create_pci_msi_domain(void)
 static __init void xen_setup_pci_msi(void)
 {
 	if (xen_pv_domain()) {
-		if (xen_initial_domain()) {
+		if (xen_initial_domain())
 			xen_msi_ops.setup_msi_irqs = xen_initdom_setup_msi_irqs;
-			x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
-		} else {
+		else
 			xen_msi_ops.setup_msi_irqs = xen_setup_msi_irqs;
-		}
 		xen_msi_ops.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
 		pci_msi_ignore_mask = 1;
 	} else if (xen_hvm_domain()) {
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index b6cd8b3..8260b06 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -106,29 +106,6 @@ void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
 }
 #endif /* CONFIG_PCI_MSI_ARCH_FALLBACKS */
 
-static void default_restore_msi_irq(struct pci_dev *dev, int irq)
-{
-	struct msi_desc *entry;
-
-	entry = NULL;
-	if (dev->msix_enabled) {
-		for_each_pci_msi_entry(entry, dev) {
-			if (irq == entry->irq)
-				break;
-		}
-	} else if (dev->msi_enabled)  {
-		entry = irq_get_msi_desc(irq);
-	}
-
-	if (entry)
-		__pci_write_msi_msg(entry, &entry->msg);
-}
-
-void __weak arch_restore_msi_irqs(struct pci_dev *dev)
-{
-	return default_restore_msi_irqs(dev);
-}
-
 /*
  * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
  * mask all MSI interrupts by clearing the MSI enable bit does not work
@@ -242,14 +219,6 @@ void pci_msi_unmask_irq(struct irq_data *data)
 }
 EXPORT_SYMBOL_GPL(pci_msi_unmask_irq);
 
-void default_restore_msi_irqs(struct pci_dev *dev)
-{
-	struct msi_desc *entry;
-
-	for_each_pci_msi_entry(entry, dev)
-		default_restore_msi_irq(dev, entry->irq);
-}
-
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
@@ -403,10 +372,19 @@ static void pci_msi_set_enable(struct pci_dev *dev, int enable)
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
 }
 
+/*
+ * Architecture override returns true when the PCI MSI message should be
+ * written by the generic restore function.
+ */
+bool __weak arch_restore_msi_irqs(struct pci_dev *dev)
+{
+	return true;
+}
+
 static void __pci_restore_msi_state(struct pci_dev *dev)
 {
-	u16 control;
 	struct msi_desc *entry;
+	u16 control;
 
 	if (!dev->msi_enabled)
 		return;
@@ -415,7 +393,8 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 
 	pci_intx_for_msi(dev, 0);
 	pci_msi_set_enable(dev, 0);
-	arch_restore_msi_irqs(dev);
+	if (arch_restore_msi_irqs(dev))
+		__pci_write_msi_msg(entry, &entry->msg);
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
 	pci_msi_update_mask(entry, 0, 0);
@@ -437,6 +416,7 @@ static void pci_msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 set)
 static void __pci_restore_msix_state(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
+	bool write_msg;
 
 	if (!dev->msix_enabled)
 		return;
@@ -447,9 +427,13 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 	pci_msix_clear_and_set_ctrl(dev, 0,
 				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
 
-	arch_restore_msi_irqs(dev);
-	for_each_pci_msi_entry(entry, dev)
+	write_msg = arch_restore_msi_irqs(dev);
+
+	for_each_pci_msi_entry(entry, dev) {
+		if (write_msg)
+			__pci_write_msi_msg(entry, &entry->msg);
 		pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
+	}
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 7e5c13f..673899f 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -273,11 +273,10 @@ static inline void arch_teardown_msi_irqs(struct pci_dev *dev)
 #endif
 
 /*
- * The restore hooks are still available as they are useful even
- * for fully irq domain based setups. Courtesy to XEN/X86.
+ * The restore hook is still available even for fully irq domain based
+ * setups. Courtesy to XEN/X86.
  */
-void arch_restore_msi_irqs(struct pci_dev *dev);
-void default_restore_msi_irqs(struct pci_dev *dev);
+bool arch_restore_msi_irqs(struct pci_dev *dev);
 
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 

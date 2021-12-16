Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8D3477F5E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242581AbhLPVmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57042 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242027AbhLPVlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:02 -0500
Date:   Thu, 16 Dec 2021 21:41:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEnf1SjGlulhGlu06UemGCk0ICc20ArpQ9i4s4pBPYc=;
        b=lXBNhHDkpNlIQZV6oxLUPpZiraqgq57d0pIRsUadzkKS14j24/y0voW/mNVpysZk0Cs0xO
        Jv5GTw5+D2n9Y+QImUChnhSrbFUQ7plErMG7Hh7xowGFRxzUsakrXwVmhJblDKgTd0/P34
        sBhIBx2iJoWgi5tgUoY1ZtKWVf5vX5GckUPO/yrosrCLfzTyuabIeRXo+DhsZVBz/YWdCq
        WExaEZVjeyaFwutas1RL2uC2bVoOgFKKSVkFFTRXKNaE3xqIHrHhm7CT2DVQBIULg3gQs4
        bjez0OWO2/WscQbXIqsJgR4TdeGiNB4EkK1f1l5x/9F3rkiSJe1+41l/P0Eu/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEnf1SjGlulhGlu06UemGCk0ICc20ArpQ9i4s4pBPYc=;
        b=kvCXFp0nU/U+wCUgHr3LSMdGwiTSplSCzelefVQ4fMgrlv0WPwEkmzACOpanGvcXQERSf5
        7i0QJLqr3N38LjBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] platform-msi: Rename functions and clarify comments
Cc:     Thomas Gleixner <tglx@linutronix.de>, Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221814.228706214@linutronix.de>
References: <20211210221814.228706214@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969086078.23020.11034016030284334087.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     9835cec6d557b0bff3d48bd91cd0484aba59386c
Gitweb:        https://git.kernel.org/tip/9835cec6d557b0bff3d48bd91cd0484aba59386c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:39 +01:00

platform-msi: Rename functions and clarify comments

It's hard to distinguish what platform_msi_domain_alloc() and
platform_msi_domain_alloc_irqs() are about. Make the distinction more
explicit and add comments which explain the use cases properly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221814.228706214@linutronix.de

---
 drivers/base/platform-msi.c     | 36 ++++++++++++++++++--------------
 drivers/irqchip/irq-mbigen.c    |  4 ++--
 drivers/irqchip/irq-mvebu-icu.c |  6 ++---
 include/linux/msi.h             |  8 +++----
 4 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 5d50793..46ee955 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -313,17 +313,18 @@ EXPORT_SYMBOL_GPL(platform_msi_domain_free_irqs);
  *                              a platform-msi domain
  * @domain:	The platform-msi domain
  *
- * Returns the private data provided when calling
- * platform_msi_create_device_domain.
+ * Return: The private data provided when calling
+ * platform_msi_create_device_domain().
  */
 void *platform_msi_get_host_data(struct irq_domain *domain)
 {
 	struct platform_msi_priv_data *data = domain->host_data;
+
 	return data->host_data;
 }
 
 /**
- * __platform_msi_create_device_domain - Create a platform-msi domain
+ * __platform_msi_create_device_domain - Create a platform-msi device domain
  *
  * @dev:		The device generating the MSIs
  * @nvec:		The number of MSIs that need to be allocated
@@ -332,7 +333,11 @@ void *platform_msi_get_host_data(struct irq_domain *domain)
  * @ops:		The hierarchy domain operations to use
  * @host_data:		Private data associated to this domain
  *
- * Returns an irqdomain for @nvec interrupts
+ * Return: An irqdomain for @nvec interrupts on success, NULL in case of error.
+ *
+ * This is for interrupt domains which stack on a platform-msi domain
+ * created by platform_msi_create_irq_domain(). @dev->msi.domain points to
+ * that platform-msi domain which is the parent for the new domain.
  */
 struct irq_domain *
 __platform_msi_create_device_domain(struct device *dev,
@@ -372,18 +377,19 @@ free_priv:
 }
 
 /**
- * platform_msi_domain_free - Free interrupts associated with a platform-msi
- *                            domain
+ * platform_msi_device_domain_free - Free interrupts associated with a platform-msi
+ *				     device domain
  *
- * @domain:	The platform-msi domain
+ * @domain:	The platform-msi device domain
  * @virq:	The base irq from which to perform the free operation
  * @nvec:	How many interrupts to free from @virq
  */
-void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
-			      unsigned int nvec)
+void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nvec)
 {
 	struct platform_msi_priv_data *data = domain->host_data;
 	struct msi_desc *desc, *tmp;
+
 	for_each_msi_entry_safe(desc, tmp, data->dev) {
 		if (WARN_ON(!desc->irq || desc->nvec_used != 1))
 			return;
@@ -397,10 +403,10 @@ void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
 }
 
 /**
- * platform_msi_domain_alloc - Allocate interrupts associated with
- *			       a platform-msi domain
+ * platform_msi_device_domain_alloc - Allocate interrupts associated with
+ *				      a platform-msi device domain
  *
- * @domain:	The platform-msi domain
+ * @domain:	The platform-msi device domain
  * @virq:	The base irq from which to perform the allocate operation
  * @nr_irqs:	How many interrupts to free from @virq
  *
@@ -408,8 +414,8 @@ void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
  * with irq_domain_mutex held (which can only be done as part of a
  * top-level interrupt allocation).
  */
-int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
-			      unsigned int nr_irqs)
+int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nr_irqs)
 {
 	struct platform_msi_priv_data *data = domain->host_data;
 	int err;
@@ -421,7 +427,7 @@ int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	err = msi_domain_populate_irqs(domain->parent, data->dev,
 				       virq, nr_irqs, &data->arg);
 	if (err)
-		platform_msi_domain_free(domain, virq, nr_irqs);
+		platform_msi_device_domain_free(domain, virq, nr_irqs);
 
 	return err;
 }
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 12df216..f3faf5c 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -207,7 +207,7 @@ static int mbigen_irq_domain_alloc(struct irq_domain *domain,
 	if (err)
 		return err;
 
-	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
+	err = platform_msi_device_domain_alloc(domain, virq, nr_irqs);
 	if (err)
 		return err;
 
@@ -223,7 +223,7 @@ static int mbigen_irq_domain_alloc(struct irq_domain *domain,
 static void mbigen_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs)
 {
-	platform_msi_domain_free(domain, virq, nr_irqs);
+	platform_msi_device_domain_free(domain, virq, nr_irqs);
 }
 
 static const struct irq_domain_ops mbigen_domain_ops = {
diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 4a4a65a..497da34 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -221,7 +221,7 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		icu_irqd->icu_group = msi_data->subset_data->icu_group;
 	icu_irqd->icu = icu;
 
-	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
+	err = platform_msi_device_domain_alloc(domain, virq, nr_irqs);
 	if (err) {
 		dev_err(icu->dev, "failed to allocate ICU interrupt in parent domain\n");
 		goto free_irqd;
@@ -245,7 +245,7 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	return 0;
 
 free_msi:
-	platform_msi_domain_free(domain, virq, nr_irqs);
+	platform_msi_device_domain_free(domain, virq, nr_irqs);
 free_irqd:
 	kfree(icu_irqd);
 	return err;
@@ -260,7 +260,7 @@ mvebu_icu_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 
 	kfree(icu_irqd);
 
-	platform_msi_domain_free(domain, virq, nr_irqs);
+	platform_msi_device_domain_free(domain, virq, nr_irqs);
 }
 
 static const struct irq_domain_ops mvebu_icu_domain_ops = {
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 634a129..12dd286 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -435,10 +435,10 @@ __platform_msi_create_device_domain(struct device *dev,
 #define platform_msi_create_device_tree_domain(dev, nvec, write, ops, data) \
 	__platform_msi_create_device_domain(dev, nvec, true, write, ops, data)
 
-int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
-			      unsigned int nr_irqs);
-void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
-			      unsigned int nvec);
+int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nr_irqs);
+void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nvec);
 void *platform_msi_get_host_data(struct irq_domain *domain);
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 

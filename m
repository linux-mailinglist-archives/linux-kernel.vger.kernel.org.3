Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EB4477F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbhLPVmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57100 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241866AbhLPVlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:06 -0500
Date:   Thu, 16 Dec 2021 21:41:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690865;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IfpouTZ5uNZJuWBVkyTJCJnnP+TtyHcXjApBri0DXXg=;
        b=r3BaeUKu8X5s4O5THmi+mZ69tccgiBZDGpgYezWOTL1Ou3iSwmS/msmwe6a66mw0KplSW6
        dY+VbKVHLDpv3teHOAKUQvXu17A2qWKbu7onkiSYvQZF7GA6KDTDt7ISFa5vJ7v2ZrnlOb
        dC5Og4V/eMddi7IZ0FUbY8gb6kgLfYqXz0UcB8Zk8AnVA6HPCoTwRBLYr1AOzngW4M9vEz
        b+LXa8bRL0PIGxFJX7YDZEFZCkJnZSzo0bxMh+6OZ4B/o70J32htYiJJEghmSqid8iQaSq
        jTuTlS28iwrD20mV8aOF48AK8DBHeot9G4a89uQ4ZO/QhO8I3BGyzG+SuAwKrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690865;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IfpouTZ5uNZJuWBVkyTJCJnnP+TtyHcXjApBri0DXXg=;
        b=qj6b5HpZ9SgGCWOXYDvW4aeLrrT56ET6Gr//WWHY2+kMxCVNMnimvVDrITX1+Vjp7X9dOO
        ylNoWid12rTskWCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Provide msi_device_populate/destroy_sysfs()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221813.988659194@linutronix.de>
References: <20211210221813.988659194@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969086400.23020.12194266729832138041.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     bf6e054e0e3fbc9614355b760e18c8a14f952a4e
Gitweb:        https://git.kernel.org/tip/bf6e054e0e3fbc9614355b760e18c8a14f952a4e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:39 +01:00

genirq/msi: Provide msi_device_populate/destroy_sysfs()

Add new allocation functions which can be activated by domain info
flags. They store the groups pointer in struct msi_device_data.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221813.988659194@linutronix.de

---
 include/linux/msi.h |  4 ++++
 kernel/irq/msi.c    | 42 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 7e4c8fd..1b96dc4 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -56,6 +56,8 @@ struct irq_data;
 struct msi_desc;
 struct pci_dev;
 struct platform_msi_priv_data;
+struct attribute_group;
+
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 #ifdef CONFIG_GENERIC_MSI_IRQ
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
@@ -174,9 +176,11 @@ struct msi_desc {
 /**
  * msi_device_data - MSI per device data
  * @properties:		MSI properties which are interesting to drivers
+ * @attrs:		Pointer to the sysfs attribute group
  */
 struct msi_device_data {
 	unsigned long			properties;
+	const struct attribute_group    **attrs;
 };
 
 int msi_setup_device_data(struct device *dev);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 6bca6ad..dd65e67 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -200,6 +200,20 @@ error_attrs:
 }
 
 /**
+ * msi_device_populate_sysfs - Populate msi_irqs sysfs entries for a device
+ * @dev:	The device (PCI, platform etc) which will get sysfs entries
+ */
+int msi_device_populate_sysfs(struct device *dev)
+{
+	const struct attribute_group **group = msi_populate_sysfs(dev);
+
+	if (IS_ERR(group))
+		return PTR_ERR(group);
+	dev->msi.data->attrs = group;
+	return 0;
+}
+
+/**
  * msi_destroy_sysfs - Destroy msi_irqs sysfs entries for devices
  * @dev:		The device(PCI, platform etc) who will remove sysfs entries
  * @msi_irq_groups:	attribute_group for device msi_irqs entries
@@ -225,6 +239,17 @@ void msi_destroy_sysfs(struct device *dev, const struct attribute_group **msi_ir
 		kfree(msi_irq_groups);
 	}
 }
+
+/**
+ * msi_device_destroy_sysfs - Destroy msi_irqs sysfs entries for a device
+ * @dev:		The device (PCI, platform etc) for which to remove
+ *			sysfs entries
+ */
+void msi_device_destroy_sysfs(struct device *dev)
+{
+	msi_destroy_sysfs(dev, dev->msi.data->attrs);
+	dev->msi.data->attrs = NULL;
+}
 #endif
 
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
@@ -672,8 +697,19 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
+	int ret;
+
+	ret = ops->domain_alloc_irqs(domain, dev, nvec);
+	if (ret)
+		return ret;
+
+	if (!(info->flags & MSI_FLAG_DEV_SYSFS))
+		return 0;
 
-	return ops->domain_alloc_irqs(domain, dev, nvec);
+	ret = msi_device_populate_sysfs(dev);
+	if (ret)
+		msi_domain_free_irqs(domain, dev);
+	return ret;
 }
 
 void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
@@ -712,7 +748,9 @@ void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
 
-	return ops->domain_free_irqs(domain, dev);
+	if (info->flags & MSI_FLAG_DEV_SYSFS)
+		msi_device_destroy_sysfs(dev);
+	ops->domain_free_irqs(domain, dev);
 }
 
 /**

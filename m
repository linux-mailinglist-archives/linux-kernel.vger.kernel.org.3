Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E982477F73
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242841AbhLPVnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbhLPVlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7EDC061399;
        Thu, 16 Dec 2021 13:40:55 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:40:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFg+3q9lRM05hipiDAu8mCDaKfAFEJSpxgkEVZ2dC0E=;
        b=OZ7c+a9QRyB2vCfcltF86/CdXu6ma/RpoID6lzS48tQNDShm8UMNPXIdwJA8oNEPeyDbi7
        84JSasqL2C3vpOzcAeysux2kSXzJUppsiCK8mQFCxKbtZeiWchqBstnikfoWOVbSLl/Ay/
        b09HaSybe29lZm5JGM5rotNkoUYvkw1brWYwisrJhX6T9ePxuoJmhs6Uz3/8OfpF9pZlvB
        dugtuIeRFQGaHpvtH0RQb4ekl4oaLH9j9FXgdxqwCxfiyjCiWZEtY69Osg1Y+L+TJQeI6d
        80zwqg9B9ZxYK41h7xFhIQXJ3kX0ZrNjkrRRi9gFKsZUY3wZ/3XFm8zwe5XpsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFg+3q9lRM05hipiDAu8mCDaKfAFEJSpxgkEVZ2dC0E=;
        b=Za+gOToS2nyzjGPI+z+DQJqs86xxCAbsT4eKhUq3tjuz6FZ6xiZO6hLHIkA7ZpnEg6lLWr
        2p/6ThFW1Qj/gaAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Provide interface to retrieve Linux
 interrupt number
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221814.780824745@linutronix.de>
References: <20211210221814.780824745@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969085282.23020.8815870939650114358.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     cf15f43acaad31dabb2646cef170a506a1d663eb
Gitweb:        https://git.kernel.org/tip/cf15f43acaad31dabb2646cef170a506a1d663eb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:40 +01:00

genirq/msi: Provide interface to retrieve Linux interrupt number

This allows drivers to retrieve the Linux interrupt number instead of
fiddling with MSI descriptors.

msi_get_virq() returns the Linux interrupt number or 0 in case that there
is no entry for the given MSI index.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221814.780824745@linutronix.de

---
 include/linux/msi.h |  2 ++
 kernel/irq/msi.c    | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index d206239..7593fc3 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -153,6 +153,8 @@ struct msi_device_data {
 
 int msi_setup_device_data(struct device *dev);
 
+unsigned int msi_get_virq(struct device *dev, unsigned int index);
+
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
 #define dev_to_msi_list(dev)		(&(dev)->msi_list)
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 8e433f1..ab5e83f 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -105,6 +105,42 @@ int msi_setup_device_data(struct device *dev)
 	return 0;
 }
 
+/**
+ * msi_get_virq - Return Linux interrupt number of a MSI interrupt
+ * @dev:	Device to operate on
+ * @index:	MSI interrupt index to look for (0-based)
+ *
+ * Return: The Linux interrupt number on success (> 0), 0 if not found
+ */
+unsigned int msi_get_virq(struct device *dev, unsigned int index)
+{
+	struct msi_desc *desc;
+	bool pcimsi;
+
+	if (!dev->msi.data)
+		return 0;
+
+	pcimsi = dev_is_pci(dev) ? to_pci_dev(dev)->msi_enabled : false;
+
+	for_each_msi_entry(desc, dev) {
+		/* PCI-MSI has only one descriptor for multiple interrupts. */
+		if (pcimsi) {
+			if (desc->irq && index < desc->nvec_used)
+				return desc->irq + index;
+			break;
+		}
+
+		/*
+		 * PCI-MSIX and platform MSI use a descriptor per
+		 * interrupt.
+		 */
+		if (desc->msi_index == index)
+			return desc->irq;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(msi_get_virq);
+
 #ifdef CONFIG_SYSFS
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)

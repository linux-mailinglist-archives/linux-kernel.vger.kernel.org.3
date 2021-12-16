Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CB9477F45
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242140AbhLPVly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57202 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241892AbhLPVkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:46 -0500
Date:   Thu, 16 Dec 2021 21:40:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awyRjiNQJLr50vKC8nDD3caVgAOHQOVPNRO3MmfUmxw=;
        b=jM8cJWOmEwodimTXHHc2yWzfJBaVyfJEzCZAOofEuAP0zd6V29WzJfWLXutyvU2KCsJ9Z2
        V5prG+qPqruqti/DCl7tC940rOeZ6zdyK4tlGhDARmBNX+iaiA8GXbfqIQMXV6kDdIE3gL
        elHIOFfL+1Bc/L7PUr+4nexNTz4t8uwIyIaqv471B85CdW0LNcCLXfhcFa+WcyVgfNso9D
        ezzt8WqFfSHBpTYJXraZFK2dPSW05zybX41HAEQUAxAVaHYhY979YuvSO46scvoAppY2ZZ
        FOC0xGkS1E9IfnTuUiKThlBXU3Tr003hIlFgIha4NIiLDCVZBTrZxg8nwvq7/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awyRjiNQJLr50vKC8nDD3caVgAOHQOVPNRO3MmfUmxw=;
        b=LLycbAFtRL4n6/+S624cqLxwMPBrMkA+c1akH0+T7zvgKZLr9cI9N8oMhfRPuwWPkqFJO2
        lg1dg30unWes+6BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Move descriptor list to struct msi_device_data
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210747.650487479@linutronix.de>
References: <20211206210747.650487479@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969084459.23020.4713051114932735681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     125282cd4f33ecd53a24ae4807409da0e5e90fd4
Gitweb:        https://git.kernel.org/tip/125282cd4f33ecd53a24ae4807409da0e5e90fd4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:16 +01:00

genirq/msi: Move descriptor list to struct msi_device_data

It's only required when MSI is in use.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210747.650487479@linutronix.de

---
 drivers/base/core.c    | 3 ---
 include/linux/device.h | 4 ----
 include/linux/msi.h    | 4 +++-
 kernel/irq/msi.c       | 5 ++++-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f26c668..f898786 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2874,9 +2874,6 @@ void device_initialize(struct device *dev)
 	INIT_LIST_HEAD(&dev->devres_head);
 	device_pm_init(dev);
 	set_dev_node(dev, NUMA_NO_NODE);
-#ifdef CONFIG_GENERIC_MSI_IRQ
-	INIT_LIST_HEAD(&dev->msi_list);
-#endif
 	INIT_LIST_HEAD(&dev->links.consumers);
 	INIT_LIST_HEAD(&dev->links.suppliers);
 	INIT_LIST_HEAD(&dev->links.defer_sync);
diff --git a/include/linux/device.h b/include/linux/device.h
index f0033cd..9345972 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -423,7 +423,6 @@ struct dev_msi_info {
  * @pins:	For device pin management.
  *		See Documentation/driver-api/pin-control.rst for details.
  * @msi:	MSI related data
- * @msi_list:	Hosts MSI descriptors
  * @numa_node:	NUMA node this device is close to.
  * @dma_ops:    DMA mapping operations for this device.
  * @dma_mask:	Dma mask (if dma'ble device).
@@ -519,9 +518,6 @@ struct device {
 	struct dev_pin_info	*pins;
 #endif
 	struct dev_msi_info	msi;
-#ifdef CONFIG_GENERIC_MSI_IRQ
-	struct list_head	msi_list;
-#endif
 #ifdef CONFIG_DMA_OPS
 	const struct dma_map_ops *dma_ops;
 #endif
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 7593fc3..4223e47 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -144,11 +144,13 @@ struct msi_desc {
  * @properties:		MSI properties which are interesting to drivers
  * @attrs:		Pointer to the sysfs attribute group
  * @platform_data:	Platform-MSI specific data
+ * @list:		List of MSI descriptors associated to the device
  */
 struct msi_device_data {
 	unsigned long			properties;
 	const struct attribute_group    **attrs;
 	struct platform_msi_priv_data	*platform_data;
+	struct list_head		list;
 };
 
 int msi_setup_device_data(struct device *dev);
@@ -157,7 +159,7 @@ unsigned int msi_get_virq(struct device *dev, unsigned int index);
 
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
-#define dev_to_msi_list(dev)		(&(dev)->msi_list)
+#define dev_to_msi_list(dev)		(&(dev)->msi.data->list)
 #define first_msi_entry(dev)		\
 	list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
 #define for_each_msi_entry(desc, dev)	\
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index ab5e83f..c66787d 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -75,7 +75,9 @@ EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 
 static void msi_device_data_release(struct device *dev, void *res)
 {
-	WARN_ON_ONCE(!list_empty(&dev->msi_list));
+	struct msi_device_data *md = res;
+
+	WARN_ON_ONCE(!list_empty(&md->list));
 	dev->msi.data = NULL;
 }
 
@@ -100,6 +102,7 @@ int msi_setup_device_data(struct device *dev)
 	if (!md)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&md->list);
 	dev->msi.data = md;
 	devres_add(dev, md);
 	return 0;

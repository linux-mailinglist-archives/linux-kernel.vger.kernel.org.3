Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F72D477F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242582AbhLPVnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242030AbhLPVla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ADFC06173E;
        Thu, 16 Dec 2021 13:41:02 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:41:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=555GjndMx96HIkTVlbqocBObCAPMuEaOJ39EZuwsvDQ=;
        b=Oij60d7bavnB7YvV+BGOSl8gJp4FliO7ycfm/LwDMG+oM2iutRydOunwpDki2wh//A523S
        saUa5j/l6G+JpM6LvjRmEuW7cXKX22NFHVr1PKZTg+sRWYM4QvIDfYgPCjZTG8dr9lPBg+
        REwRz05ZNZC9pg/6SEXA9+b7qFzi4D7Vjtoi3f+j15NWry19VQNR4Chu/BfYDQOz/oHi/8
        Vjll+8WFAHN5E23Asct/CiQetxFXLzfshTywpBU/ZIiVmc4g3WeMTFPLSQbNOWRB7QEBGK
        VTMFv0W3T1PGjRV+etzJTNHYhlbdhVvPmEib1ILIHa+GgzuQyfe156JCGpyitw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=555GjndMx96HIkTVlbqocBObCAPMuEaOJ39EZuwsvDQ=;
        b=ALAdZeHhTEV4R8KOGPpTVPqSPZxisMKyKa1l3I3qzfjlUciN+Rdc4f9bcAf9Q7F0h6bbLL
        9It76Am8WSVEqdCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] platform-msi: Store platform private data pointer in
 msi_device_data
Cc:     Thomas Gleixner <tglx@linutronix.de>, Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221814.287680528@linutronix.de>
References: <20211210221814.287680528@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969086004.23020.9700567714542031048.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     fc22e7dbcdb3e06a3d3ce05fc91c6a2345411f9b
Gitweb:        https://git.kernel.org/tip/fc22e7dbcdb3e06a3d3ce05fc91c6a2345411f9b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:39 +01:00

platform-msi: Store platform private data pointer in msi_device_data

Storing the platform private data in a MSI descriptor is sloppy at
best. The data belongs to the device and not to the descriptor.
Add a pointer to struct msi_device_data and store the pointer there.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221814.287680528@linutronix.de

---
 drivers/base/platform-msi.c | 79 ++++++++++++++----------------------
 include/linux/msi.h         |  4 +-
 2 files changed, 34 insertions(+), 49 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 46ee955..1487906 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -38,9 +38,7 @@ static DEFINE_IDA(platform_msi_devid_ida);
  */
 static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
 {
-	u32 devid;
-
-	devid = desc->platform.msi_priv_data->devid;
+	u32 devid = desc->dev->msi.data->platform_data->devid;
 
 	return (devid << (32 - DEV_ID_SHIFT)) | desc->platform.msi_index;
 }
@@ -85,11 +83,8 @@ static void platform_msi_update_dom_ops(struct msi_domain_info *info)
 static void platform_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
-	struct platform_msi_priv_data *priv_data;
-
-	priv_data = desc->platform.msi_priv_data;
 
-	priv_data->write_msg(desc, msg);
+	desc->dev->msi.data->platform_data->write_msg(desc, msg);
 }
 
 static void platform_msi_update_chip_ops(struct msi_domain_info *info)
@@ -126,9 +121,7 @@ static void platform_msi_free_descs(struct device *dev, int base, int nvec)
 }
 
 static int platform_msi_alloc_descs_with_irq(struct device *dev, int virq,
-					     int nvec,
-					     struct platform_msi_priv_data *data)
-
+					     int nvec)
 {
 	struct msi_desc *desc;
 	int i, base = 0;
@@ -144,7 +137,6 @@ static int platform_msi_alloc_descs_with_irq(struct device *dev, int virq,
 		if (!desc)
 			break;
 
-		desc->platform.msi_priv_data = data;
 		desc->platform.msi_index = base + i;
 		desc->irq = virq ? virq + i : 0;
 
@@ -161,11 +153,9 @@ static int platform_msi_alloc_descs_with_irq(struct device *dev, int virq,
 	return 0;
 }
 
-static int platform_msi_alloc_descs(struct device *dev, int nvec,
-				    struct platform_msi_priv_data *data)
-
+static int platform_msi_alloc_descs(struct device *dev, int nvec)
 {
-	return platform_msi_alloc_descs_with_irq(dev, 0, nvec, data);
+	return platform_msi_alloc_descs_with_irq(dev, 0, nvec);
 }
 
 /**
@@ -199,9 +189,8 @@ struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
 	return domain;
 }
 
-static struct platform_msi_priv_data *
-platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
-			     irq_write_msi_msg_t write_msi_msg)
+static int platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
+					irq_write_msi_msg_t write_msi_msg)
 {
 	struct platform_msi_priv_data *datap;
 	int err;
@@ -213,41 +202,44 @@ platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
 	 * capable devices).
 	 */
 	if (!dev->msi.domain || !write_msi_msg || !nvec || nvec > MAX_DEV_MSIS)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (dev->msi.domain->bus_token != DOMAIN_BUS_PLATFORM_MSI) {
 		dev_err(dev, "Incompatible msi_domain, giving up\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	err = msi_setup_device_data(dev);
 	if (err)
-		return ERR_PTR(err);
+		return err;
 
-	/* Already had a helping of MSI? Greed... */
-	if (!list_empty(dev_to_msi_list(dev)))
-		return ERR_PTR(-EBUSY);
+	/* Already initialized? */
+	if (dev->msi.data->platform_data)
+		return -EBUSY;
 
 	datap = kzalloc(sizeof(*datap), GFP_KERNEL);
 	if (!datap)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	datap->devid = ida_simple_get(&platform_msi_devid_ida,
 				      0, 1 << DEV_ID_SHIFT, GFP_KERNEL);
 	if (datap->devid < 0) {
 		err = datap->devid;
 		kfree(datap);
-		return ERR_PTR(err);
+		return err;
 	}
 
 	datap->write_msg = write_msi_msg;
 	datap->dev = dev;
-
-	return datap;
+	dev->msi.data->platform_data = datap;
+	return 0;
 }
 
-static void platform_msi_free_priv_data(struct platform_msi_priv_data *data)
+static void platform_msi_free_priv_data(struct device *dev)
 {
+	struct platform_msi_priv_data *data = dev->msi.data->platform_data;
+
+	dev->msi.data->platform_data = NULL;
 	ida_simple_remove(&platform_msi_devid_ida, data->devid);
 	kfree(data);
 }
@@ -264,14 +256,13 @@ static void platform_msi_free_priv_data(struct platform_msi_priv_data *data)
 int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 				   irq_write_msi_msg_t write_msi_msg)
 {
-	struct platform_msi_priv_data *priv_data;
 	int err;
 
-	priv_data = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
-	if (IS_ERR(priv_data))
-		return PTR_ERR(priv_data);
+	err = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
+	if (err)
+		return err;
 
-	err = platform_msi_alloc_descs(dev, nvec, priv_data);
+	err = platform_msi_alloc_descs(dev, nvec);
 	if (err)
 		goto out_free_priv_data;
 
@@ -284,8 +275,7 @@ int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 out_free_desc:
 	platform_msi_free_descs(dev, 0, nvec);
 out_free_priv_data:
-	platform_msi_free_priv_data(priv_data);
-
+	platform_msi_free_priv_data(dev);
 	return err;
 }
 EXPORT_SYMBOL_GPL(platform_msi_domain_alloc_irqs);
@@ -296,15 +286,9 @@ EXPORT_SYMBOL_GPL(platform_msi_domain_alloc_irqs);
  */
 void platform_msi_domain_free_irqs(struct device *dev)
 {
-	if (!list_empty(dev_to_msi_list(dev))) {
-		struct msi_desc *desc;
-
-		desc = first_msi_entry(dev);
-		platform_msi_free_priv_data(desc->platform.msi_priv_data);
-	}
-
 	msi_domain_free_irqs(dev->msi.domain, dev);
 	platform_msi_free_descs(dev, 0, MAX_DEV_MSIS);
+	platform_msi_free_priv_data(dev);
 }
 EXPORT_SYMBOL_GPL(platform_msi_domain_free_irqs);
 
@@ -351,10 +335,11 @@ __platform_msi_create_device_domain(struct device *dev,
 	struct irq_domain *domain;
 	int err;
 
-	data = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
-	if (IS_ERR(data))
+	err = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
+	if (err)
 		return NULL;
 
+	data = dev->msi.data->platform_data;
 	data->host_data = host_data;
 	domain = irq_domain_create_hierarchy(dev->msi.domain, 0,
 					     is_tree ? 0 : nvec,
@@ -372,7 +357,7 @@ __platform_msi_create_device_domain(struct device *dev,
 free_domain:
 	irq_domain_remove(domain);
 free_priv:
-	platform_msi_free_priv_data(data);
+	platform_msi_free_priv_data(dev);
 	return NULL;
 }
 
@@ -420,7 +405,7 @@ int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int vir
 	struct platform_msi_priv_data *data = domain->host_data;
 	int err;
 
-	err = platform_msi_alloc_descs_with_irq(data->dev, virq, nr_irqs, data);
+	err = platform_msi_alloc_descs_with_irq(data->dev, virq, nr_irqs);
 	if (err)
 		return err;
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 12dd286..cdf0d09 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -108,11 +108,9 @@ struct pci_msi_desc {
 
 /**
  * platform_msi_desc - Platform device specific msi descriptor data
- * @msi_priv_data:	Pointer to platform private data
  * @msi_index:		The index of the MSI descriptor for multi MSI
  */
 struct platform_msi_desc {
-	struct platform_msi_priv_data	*msi_priv_data;
 	u16				msi_index;
 };
 
@@ -177,10 +175,12 @@ struct msi_desc {
  * msi_device_data - MSI per device data
  * @properties:		MSI properties which are interesting to drivers
  * @attrs:		Pointer to the sysfs attribute group
+ * @platform_data:	Platform-MSI specific data
  */
 struct msi_device_data {
 	unsigned long			properties;
 	const struct attribute_group    **attrs;
+	struct platform_msi_priv_data	*platform_data;
 };
 
 int msi_setup_device_data(struct device *dev);

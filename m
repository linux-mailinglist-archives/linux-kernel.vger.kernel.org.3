Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3C6477F55
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242276AbhLPVmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242038AbhLPVlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17552C061784;
        Thu, 16 Dec 2021 13:40:46 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:40:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=meoLzoK4WXrv/3nWab7SMN3ydNlXAQaDndy6kUP00rs=;
        b=sor5ghSjMex8+pHGwmZ3nfcKp5qfEzprWVVfaqDFpx28HmV664rL1IjahmHRQV9gO9/Q0n
        DLbiBqYfB1btrq/8HEBSx5N550C4fl1vbvqnvIj4Pskb4Rjoi45NHyQXfcouPYEipUtANy
        HPNqHqL7DM+yM2PUZg46XadOEtrPbVN78WdCVpjvt8hmW3YYrHndA35SYiFJ6ueDf6fcIn
        wJJmPReSF0XnrPzTWDyvTSoW4lWtX2VP7xOHP2Pxw3Axgfzjih1rpTsr4VFdnetQilrdcj
        Uubnb1K+SIp2XO9o6tsLTYDFBjiJukFpt72m1iphWFvxVIPuuCH7BKXK3WZHtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=meoLzoK4WXrv/3nWab7SMN3ydNlXAQaDndy6kUP00rs=;
        b=6k+pcIFuxeHd3LI/5nYNnkxQbxTy4DZACHFh0L2U4w8iAq8LK866roSAa80NuZYimPX7z5
        QI9p7CbTYUvB46BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Add mutex for MSI list protection
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>, Jason Gunthorpe <jgg@nvidia.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211206210747.708877269@linutronix.de>
References: <20211206210747.708877269@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969084377.23020.16547898685316963450.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     b5f687f97d1e112493fe0447a1fb09fbd93c334b
Gitweb:        https://git.kernel.org/tip/b5f687f97d1e112493fe0447a1fb09fbd93c334b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:17 +01:00

genirq/msi: Add mutex for MSI list protection

For upcoming runtime extensions of MSI-X interrupts it's required to
protect the MSI descriptor list. Add a mutex to struct msi_device_data and
provide lock/unlock functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210747.708877269@linutronix.de

---
 include/linux/msi.h |  5 +++++
 kernel/irq/msi.c    | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 4223e47..2cf6c53 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -3,6 +3,7 @@
 #define LINUX_MSI_H
 
 #include <linux/cpumask.h>
+#include <linux/mutex.h>
 #include <linux/list.h>
 #include <asm/msi.h>
 
@@ -145,17 +146,21 @@ struct msi_desc {
  * @attrs:		Pointer to the sysfs attribute group
  * @platform_data:	Platform-MSI specific data
  * @list:		List of MSI descriptors associated to the device
+ * @mutex:		Mutex protecting the MSI list
  */
 struct msi_device_data {
 	unsigned long			properties;
 	const struct attribute_group    **attrs;
 	struct platform_msi_priv_data	*platform_data;
 	struct list_head		list;
+	struct mutex			mutex;
 };
 
 int msi_setup_device_data(struct device *dev);
 
 unsigned int msi_get_virq(struct device *dev, unsigned int index);
+void msi_lock_descs(struct device *dev);
+void msi_unlock_descs(struct device *dev);
 
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c66787d..97ec245 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -103,12 +103,33 @@ int msi_setup_device_data(struct device *dev)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&md->list);
+	mutex_init(&md->mutex);
 	dev->msi.data = md;
 	devres_add(dev, md);
 	return 0;
 }
 
 /**
+ * msi_lock_descs - Lock the MSI descriptor storage of a device
+ * @dev:	Device to operate on
+ */
+void msi_lock_descs(struct device *dev)
+{
+	mutex_lock(&dev->msi.data->mutex);
+}
+EXPORT_SYMBOL_GPL(msi_lock_descs);
+
+/**
+ * msi_unlock_descs - Unlock the MSI descriptor storage of a device
+ * @dev:	Device to operate on
+ */
+void msi_unlock_descs(struct device *dev)
+{
+	mutex_unlock(&dev->msi.data->mutex);
+}
+EXPORT_SYMBOL_GPL(msi_unlock_descs);
+
+/**
  * msi_get_virq - Return Linux interrupt number of a MSI interrupt
  * @dev:	Device to operate on
  * @index:	MSI interrupt index to look for (0-based)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE3C477F75
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242474AbhLPVnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242333AbhLPVlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55C0C06137F;
        Thu, 16 Dec 2021 13:41:15 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:41:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tUEgL4fn1xU21cC1S+MnXGlxeMDcKKcE/lguXAiHQRg=;
        b=Fc/7O7wazzeLIJw7W3zLgpVrdtz1nERQHGud7+T+Vi+RvUN4Va3yyknaTmALSCuUGH7MqR
        FtFfK38vLKxH5FXJQJo0FTSqQ/+ZU41xyYub9wuJoL5f6m5vYeIqXj/XUsGvcPsxKy0RYN
        KBipcLHfTFOgJYnmFOuxAxIlTHKwcjZPyIxcSRA3a4y4RMBLzAd1C+rLrplZ3Z4b4QvPrc
        Q5Xy63pnbXyb2whJ4U38mXxtpstvQry4zi3xz+1c5v8XhyOxN0iwoplJ/dgGh3d/XwzY4P
        tnK8OZYTFkjU1EDqiLscceub1TTqV+OLw7OKxK3CGON8YHWW3XiEMbipL4/Nww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tUEgL4fn1xU21cC1S+MnXGlxeMDcKKcE/lguXAiHQRg=;
        b=UvWQN//t/odvi4JsfGu85ETy7jtXR2gSHF9pVg49zdOWgKgitYpppum9k25BxlfwoMS8cl
        A/PyatGikCzLeOCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Use PCI device property
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>, Jason Gunthorpe <jgg@nvidia.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211210221813.434156196@linutronix.de>
References: <20211210221813.434156196@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969087336.23020.12641508664636515105.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     6ef7f771de0182141ef1a0863f27b12963e1d184
Gitweb:        https://git.kernel.org/tip/6ef7f771de0182141ef1a0863f27b12963e1d184
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:18:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:37 +01:00

genirq/msi: Use PCI device property

to determine whether this is MSI or MSIX instead of consulting MSI
descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221813.434156196@linutronix.de

---
 kernel/irq/msi.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 4a7a7f0..b3f73ef 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -77,21 +77,8 @@ EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
-	struct msi_desc *entry;
-	bool is_msix = false;
-	unsigned long irq;
-	int retval;
-
-	retval = kstrtoul(attr->attr.name, 10, &irq);
-	if (retval)
-		return retval;
-
-	entry = irq_get_msi_desc(irq);
-	if (!entry)
-		return -ENODEV;
-
-	if (dev_is_pci(dev))
-		is_msix = entry->pci.msi_attrib.is_msix;
+	/* MSI vs. MSIX is per device not per interrupt */
+	bool is_msix = dev_is_pci(dev) ? to_pci_dev(dev)->msix_enabled : false;
 
 	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
 }

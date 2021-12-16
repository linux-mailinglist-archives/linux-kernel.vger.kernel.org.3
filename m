Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18250477F56
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbhLPVm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57420 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242049AbhLPVlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:04 -0500
Date:   Thu, 16 Dec 2021 21:41:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BnNnRcT9HU0r/y87BuC2XUNFP8Obg/os7qUKw+yl2tY=;
        b=jN/7f+P4FbyM7ZZapAlCTuT+YAUoLHeiXZezTBZmrq13eIgzv5mQuejFP9SC5t0wU4KknM
        Sj2GhSmaRAcjfuwetuGIYVviPTRM68KPpcmP+PTdcGeKTNKOdJZocS91kDO3XNE3JV3nVX
        GHQgFaLrU1cM/S2rT6ubfPw9ECAPDXl6rLedo+TOIdjNKbrjKAk572TJXx2bcBQR9vJlcd
        dWsggpf1dJ8ivfSXfVbk5dhRoCMVzmHQ2Xer563IEnReIpFlvAy51K1uFKvIpFiyvqh1Hy
        hJyWdTIH3MHoEBYsWusU9/wj++QckoBf37+GfmMjegMfba9yPFZkSK+BDnFHDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BnNnRcT9HU0r/y87BuC2XUNFP8Obg/os7qUKw+yl2tY=;
        b=fI1JZCX/WQFP09dc/CUk0Cjt+fmaHYt/XekfgNGndzqejp+mPDMqnXoYQBfCMyc6VDBP/a
        a43W5en6qAYj27AQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] platform-msi: Let the core code handle sysfs groups
Cc:     Thomas Gleixner <tglx@linutronix.de>, Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221814.109408832@linutronix.de>
References: <20211210221814.109408832@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969086234.23020.12382739826073115671.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     25ce693ef7ea766c10d2f3e5da373ca25af09196
Gitweb:        https://git.kernel.org/tip/25ce693ef7ea766c10d2f3e5da373ca25af09196
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:39 +01:00

platform-msi: Let the core code handle sysfs groups

Set the domain info flag and remove the local sysfs code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221814.109408832@linutronix.de

---
 drivers/base/platform-msi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 3da2688..5d50793 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -23,7 +23,6 @@
 struct platform_msi_priv_data {
 	struct device			*dev;
 	void				*host_data;
-	const struct attribute_group    **msi_irq_groups;
 	msi_alloc_info_t		arg;
 	irq_write_msi_msg_t		write_msg;
 	int				devid;
@@ -191,6 +190,7 @@ struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
 		platform_msi_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		platform_msi_update_chip_ops(info);
+	info->flags |= MSI_FLAG_DEV_SYSFS;
 
 	domain = msi_create_irq_domain(fwnode, info, parent);
 	if (domain)
@@ -279,16 +279,8 @@ int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 	if (err)
 		goto out_free_desc;
 
-	priv_data->msi_irq_groups = msi_populate_sysfs(dev);
-	if (IS_ERR(priv_data->msi_irq_groups)) {
-		err = PTR_ERR(priv_data->msi_irq_groups);
-		goto out_free_irqs;
-	}
-
 	return 0;
 
-out_free_irqs:
-	msi_domain_free_irqs(dev->msi.domain, dev);
 out_free_desc:
 	platform_msi_free_descs(dev, 0, nvec);
 out_free_priv_data:
@@ -308,7 +300,6 @@ void platform_msi_domain_free_irqs(struct device *dev)
 		struct msi_desc *desc;
 
 		desc = first_msi_entry(dev);
-		msi_destroy_sysfs(dev, desc->platform.msi_priv_data->msi_irq_groups);
 		platform_msi_free_priv_data(desc->platform.msi_priv_data);
 	}
 

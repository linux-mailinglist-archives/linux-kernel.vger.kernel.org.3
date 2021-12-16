Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A05E477F60
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbhLPVmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57474 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbhLPVlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:08 -0500
Date:   Thu, 16 Dec 2021 21:41:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690867;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFcVPcErM0ZUHO4WQQvoNYtC0k69suDJ05QJVRKasSk=;
        b=2GHu8ux7QoYRqRJ19QuGC5juLVsAnOo3ZC0JxE1kh5Mk1ayDGowBudIE8EuqnjDBVot2W4
        QUL5b/9m0roq+/a00GWPRYNGYm7JsO4PlJCTlf11s7+zzWCBV+xPfCUWo6F+PsHle1OQVR
        86xCCkMEbA868QrPgSwklZfgCeYMhi9GGDYMcX3Sa73sMJpj6rbTJZYXBmsjjRiY46y6By
        9uPXJ7L2heosUGNlLN86ATiTIgDER2VTUCAihg1y/Hl3Mj6E9i6Y1ldcJzfeBYDtCjns+Y
        U54rVGRswfkaembeB1Ok7mogF8FsZ6IF8O87aLE3lZl/O/WXFF1ohGo8xMixqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690867;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFcVPcErM0ZUHO4WQQvoNYtC0k69suDJ05QJVRKasSk=;
        b=iATfuJpfY5jvNkeAAUOflzu8ZBJeZ6KguLec/1AkRVGc0E8LY7mDAKEjJ48Cm2Z4k5k7q7
        2x0FIGZ/srkSYwBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] platform-msi: Allocate MSI device data on first use
Cc:     Thomas Gleixner <tglx@linutronix.de>, Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221813.805529729@linutronix.de>
References: <20211210221813.805529729@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969086627.23020.5725184276498629388.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     077aeadb6cacdee79acff3deb1b31581584fdb9c
Gitweb:        https://git.kernel.org/tip/077aeadb6cacdee79acff3deb1b31581584fdb9c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:18:58 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:38 +01:00

platform-msi: Allocate MSI device data on first use

Allocate the MSI device data on first invocation of the allocation function
for platform MSI private data.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221813.805529729@linutronix.de

---
 drivers/base/platform-msi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index f1f0876..3da2688 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -204,6 +204,8 @@ platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
 			     irq_write_msi_msg_t write_msi_msg)
 {
 	struct platform_msi_priv_data *datap;
+	int err;
+
 	/*
 	 * Limit the number of interrupts to 2048 per device. Should we
 	 * need to bump this up, DEV_ID_SHIFT should be adjusted
@@ -218,6 +220,10 @@ platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
 		return ERR_PTR(-EINVAL);
 	}
 
+	err = msi_setup_device_data(dev);
+	if (err)
+		return ERR_PTR(err);
+
 	/* Already had a helping of MSI? Greed... */
 	if (!list_empty(dev_to_msi_list(dev)))
 		return ERR_PTR(-EBUSY);
@@ -229,7 +235,7 @@ platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
 	datap->devid = ida_simple_get(&platform_msi_devid_ida,
 				      0, 1 << DEV_ID_SHIFT, GFP_KERNEL);
 	if (datap->devid < 0) {
-		int err = datap->devid;
+		err = datap->devid;
 		kfree(datap);
 		return ERR_PTR(err);
 	}

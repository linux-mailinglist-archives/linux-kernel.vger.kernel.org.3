Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EC5477F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242512AbhLPVmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241992AbhLPVk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:59 -0500
Date:   Thu, 16 Dec 2021 21:40:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Blsr8oNylrOxjRXrsLo0P635Qr0vhTf6SDoW/mGMoQ=;
        b=mwLxIz2E2FbXLfQYWf1vsJ3P1QaGYjKnY73uvOAvKokDam9OtsJGcz5tYu4ZcUhdf366k4
        9Mf50EwUknBqFGKYiebtI9G2C0ce8rkbqm2QhY1tCNwshZK+Z+S0OBS8r3FrSRfRAKFpVV
        Cf7+Lryfn0wJ+aTqxsR27EaFVM8lYnUqt+2bFTGcfXcttpMO0lT/nYX9Oum7zPKPmjRR4O
        Gf/rlOzkOh3CRWTqrIMK2bAHsBgbkfyCvnjVfOQssoLdHVCFCkn/zM6RwnUfUkF/8VvDIc
        Gm1qgk2x6jbAOS+VN9/KLySbh5Sa0jUs8deAQ3oa0iX5t3wwLXL8YFPr3z7xPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Blsr8oNylrOxjRXrsLo0P635Qr0vhTf6SDoW/mGMoQ=;
        b=FGxI+UzENFqqwj9HZlEVZZ2LGUY1azionRd7w9W1ToFvggKaybTetcEjDOe8Qa6eDcraij
        +DnFk7JNtR0n2wBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] bus: fsl-mc-msi: Use msi_desc::msi_index
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221814.477386185@linutronix.de>
References: <20211210221814.477386185@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969085733.23020.1293815371535178756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     78ee9fb4b8b126ed84a819a6e1732fd3039b525a
Gitweb:        https://git.kernel.org/tip/78ee9fb4b8b126ed84a819a6e1732fd3039b525a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:40 +01:00

bus: fsl-mc-msi: Use msi_desc::msi_index

Use the common msi_index member and get rid of the pointless wrapper struct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221814.477386185@linutronix.de

---
 drivers/bus/fsl-mc/fsl-mc-allocator.c |  2 +-
 drivers/bus/fsl-mc/fsl-mc-msi.c       |  6 +++---
 include/linux/msi.h                   | 10 ----------
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index 6c51355..3370b63 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -393,7 +393,7 @@ int fsl_mc_populate_irq_pool(struct fsl_mc_device *mc_bus_dev,
 	}
 
 	for_each_msi_entry(msi_desc, &mc_bus_dev->dev) {
-		mc_dev_irq = &irq_resources[msi_desc->fsl_mc.msi_index];
+		mc_dev_irq = &irq_resources[msi_desc->msi_index];
 		mc_dev_irq->msi_desc = msi_desc;
 		mc_dev_irq->resource.id = msi_desc->irq;
 	}
diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index c6215b7..2ffb705 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -29,7 +29,7 @@ static irq_hw_number_t fsl_mc_domain_calc_hwirq(struct fsl_mc_device *dev,
 	 * Make the base hwirq value for ICID*10000 so it is readable
 	 * as a decimal value in /proc/interrupts.
 	 */
-	return (irq_hw_number_t)(desc->fsl_mc.msi_index + (dev->icid * 10000));
+	return (irq_hw_number_t)(desc->msi_index + (dev->icid * 10000));
 }
 
 static void fsl_mc_msi_set_desc(msi_alloc_info_t *arg,
@@ -122,7 +122,7 @@ static void fsl_mc_msi_write_msg(struct irq_data *irq_data,
 	struct fsl_mc_device *mc_bus_dev = to_fsl_mc_device(msi_desc->dev);
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
 	struct fsl_mc_device_irq *mc_dev_irq =
-		&mc_bus->irq_resources[msi_desc->fsl_mc.msi_index];
+		&mc_bus->irq_resources[msi_desc->msi_index];
 
 	msi_desc->msg = *msg;
 
@@ -235,7 +235,7 @@ static int fsl_mc_msi_alloc_descs(struct device *dev, unsigned int irq_count)
 			goto cleanup_msi_descs;
 		}
 
-		msi_desc->fsl_mc.msi_index = i;
+		msi_desc->msi_index = i;
 		INIT_LIST_HEAD(&msi_desc->list);
 		list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
 	}
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 1d85e95..25edf83 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -107,14 +107,6 @@ struct pci_msi_desc {
 };
 
 /**
- * fsl_mc_msi_desc - FSL-MC device specific msi descriptor data
- * @msi_index:		The index of the MSI descriptor
- */
-struct fsl_mc_msi_desc {
-	u16				msi_index;
-};
-
-/**
  * ti_sci_inta_msi_desc - TISCI based INTA specific msi descriptor data
  * @dev_index: TISCI device index
  */
@@ -137,7 +129,6 @@ struct ti_sci_inta_msi_desc {
  *
  * @msi_index:	Index of the msi descriptor
  * @pci:	[PCI]	    PCI speficic msi descriptor data
- * @fsl_mc:	[fsl-mc]    FSL MC device specific msi descriptor data
  * @inta:	[INTA]	    TISCI based INTA specific msi descriptor data
  */
 struct msi_desc {
@@ -158,7 +149,6 @@ struct msi_desc {
 	u16				msi_index;
 	union {
 		struct pci_msi_desc		pci;
-		struct fsl_mc_msi_desc		fsl_mc;
 		struct ti_sci_inta_msi_desc	inta;
 	};
 };

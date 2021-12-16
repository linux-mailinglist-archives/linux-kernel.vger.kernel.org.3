Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A5D477EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241690AbhLPVkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:40:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56976 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241649AbhLPVkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:22 -0500
Date:   Thu, 16 Dec 2021 21:40:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690821;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F4OTFpyT9XbCJI2sf4Kxod+7chHducgwjdh4nwn7b5Q=;
        b=NUWv73ArfuBhlx4uT8GsP4UBEk7qhPtAYPdNW48tnAURiHFZsNxlj1iHIjLTHm5EHQE7y0
        2yLr7P3wGw6a+Vy9lsdvyZ3fu0uZm3QOr6ZdyvjW4gSVunZaIi3T3UCyXYmP88loR5W4iM
        ZEY7XQ36lv8Ye2jPu4LRAtrVjpzerV4i8iN+teaNQRGKcfwIW8PXXofSOQ0JQqwXbO8LpT
        lxTuXASWMiJ5qhKl6jRYBJmz8PNWqfViFsTAPGwHeRFGrjvLz9kYczKhouN3SJpuGKoiUZ
        qVehGjZ5Pdd32E50PcZicqoPn1yH23N8txGYEwq884lCUBoDDMex7gNN3Y6vrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690821;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F4OTFpyT9XbCJI2sf4Kxod+7chHducgwjdh4nwn7b5Q=;
        b=kTOShD7sMTlQLr4LZYxFplapYzL2PvOLyrb/MMq2u4EeqqTj7KEX/3yCARLkoH7sCvj/xz
        +ShhsyL7hJ62uhDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Add abuse prevention comment to msi header
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210749.170847844@linutronix.de>
References: <20211206210749.170847844@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969082027.23020.18090487106897709961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     ef3350c53d2aac65cf1c4ecc968bbb1de5f421ea
Gitweb:        https://git.kernel.org/tip/ef3350c53d2aac65cf1c4ecc968bbb1de5f421ea
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:20 +01:00

genirq/msi: Add abuse prevention comment to msi header

Hope dies last.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210749.170847844@linutronix.de

---
 include/linux/msi.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index b54010b..70cc6a5 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -2,6 +2,20 @@
 #ifndef LINUX_MSI_H
 #define LINUX_MSI_H
 
+/*
+ * This header file contains MSI data structures and functions which are
+ * only relevant for:
+ *	- Interrupt core code
+ *	- PCI/MSI core code
+ *	- MSI interrupt domain implementations
+ *	- IOMMU, low level VFIO, NTB and other justified exceptions
+ *	  dealing with low level MSI details.
+ *
+ * Regular device drivers have no business with any of these functions and
+ * especially storing MSI descriptor pointers in random code is considered
+ * abuse. The only function which is relevant for drivers is msi_get_virq().
+ */
+
 #include <linux/cpumask.h>
 #include <linux/mutex.h>
 #include <linux/list.h>

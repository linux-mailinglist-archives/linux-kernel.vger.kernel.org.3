Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA03D477F79
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbhLPVnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242247AbhLPVla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9ABC0613B3;
        Thu, 16 Dec 2021 13:41:01 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:40:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdv7B9sHTQAJDa0EQftMTE6NbrV6CyO+rNItYb8tOdk=;
        b=EBYzQnsTf5Yjdj8JSFRQxhzNgKQrbaFtKH8gvDZX1sTHgXNmB2XpfkTueUaxuYrBGtCpwi
        DqdNOCCD6ZmPIqnQoWIVyCj1BHL7AhuoSj7icywVFgTX9ZlKpDY9646tOHBykKJrFO9biP
        lF7JhrqbEBLj3DC52y2mWQui5RyVOAreYfLynni4T9qu85aLRUzU5MYxZJQwuINC61yORl
        s8cOczwwVzM2N5mbul6KBQVN4jIfv2wFvxc3d5WOjJEQBP0ScuqKL6Ju9NUUjTr+SY5jqs
        hYZQ79XsIyxZ4TBSOkij1lxu+0Wgy/mOa+SgpMBuC0TZzAlskmrV/oSv3Z4peQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdv7B9sHTQAJDa0EQftMTE6NbrV6CyO+rNItYb8tOdk=;
        b=j2pVENuQ4bDGduk7GAO5BCk4yPCDBL1X6NKxwFBFIO49zeXfRlk2hG0p6l8GzdxYhLJCrm
        9C8OYpeJBIJ2lGDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Consolidate MSI descriptor data
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221814.350967317@linutronix.de>
References: <20211210221814.350967317@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969085896.23020.12505772848658293634.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     20c6d424cfe641659c9a025db8a8608701b27246
Gitweb:        https://git.kernel.org/tip/20c6d424cfe641659c9a025db8a8608701b27246
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:40 +01:00

genirq/msi: Consolidate MSI descriptor data

All non PCI/MSI usage variants have data structures in struct msi_desc with
only one member: xxx_index. PCI/MSI has a entry_nr member.

Add a common msi_index member to struct msi_desc so all implementations can
share it which allows further consolidation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221814.350967317@linutronix.de

---
 include/linux/msi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index cdf0d09..ee8fe49 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -143,6 +143,7 @@ struct ti_sci_inta_msi_desc {
  *			address or data changes
  * @write_msi_msg_data:	Data parameter for the callback.
  *
+ * @msi_index:	Index of the msi descriptor
  * @pci:	[PCI]	    PCI speficic msi descriptor data
  * @platform:	[platform]  Platform device specific msi descriptor data
  * @fsl_mc:	[fsl-mc]    FSL MC device specific msi descriptor data
@@ -163,6 +164,7 @@ struct msi_desc {
 	void (*write_msi_msg)(struct msi_desc *entry, void *data);
 	void *write_msi_msg_data;
 
+	u16				msi_index;
 	union {
 		struct pci_msi_desc		pci;
 		struct platform_msi_desc	platform;

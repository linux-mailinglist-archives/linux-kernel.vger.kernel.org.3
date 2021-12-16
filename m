Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCE1477F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbhLPVlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:41:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56996 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241831AbhLPVke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:34 -0500
Date:   Thu, 16 Dec 2021 21:40:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWSrKEq8UCFvkZbbE5iW+gr30YSdLhngjALj0DEEjHs=;
        b=hr8otbRw4XdE7UBdZAMTbWXoXGpy1sGT/5Dw86o9QI0ZyBSDj5ekFhUP/SOPaW8lXqC5SH
        kdZj9PuuL6DimaEqLiFeS6cdHTGC4e97R28kkhvjbNTSy5UF+kIzGDoEfuittDkzvSV7Re
        FtbsPip65DqCaVroF14cjlsAanyP7pb7Tx4j8LOCP+pVSu8PGdSAxAFF7hK/gPY1/YwmTB
        nTdiiyH36/lYwbO2NrpyDiguxjWF/AbLH8QxOzRGd54G9y2XnLpEkpiEoTp8ALSt0Km6L1
        6ctN73UL2KfTSad9WuVXxKKzTIiwrym7TbEEIcqxjd+NeYtjLnvou0Pywk2XXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWSrKEq8UCFvkZbbE5iW+gr30YSdLhngjALj0DEEjHs=;
        b=ij+eR0JJ6FMiuV6wXvGhtQBH+RgYAi/m64X7/rcTUobFB1rPLHq4gqEm+nDpTnZEaIUmj1
        Q76OVf3jtaZtpbAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] powerpc/cell/axon_msi: Convert to msi_on_each_desc()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210748.414712173@linutronix.de>
References: <20211206210748.414712173@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969083281.23020.7097133628467017200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     3c46658bd70389bf6a7410960905415df50350d2
Gitweb:        https://git.kernel.org/tip/3c46658bd70389bf6a7410960905415df50350d2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:18 +01:00

powerpc/cell/axon_msi: Convert to msi_on_each_desc()

Replace the about to vanish iterators and make use of the filtering.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210748.414712173@linutronix.de

---
 arch/powerpc/platforms/cell/axon_msi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index ac59aee..354a58c 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -262,7 +262,7 @@ static int axon_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (rc)
 		return rc;
 
-	for_each_pci_msi_entry(entry, dev) {
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		virq = irq_create_direct_mapping(msic->irq_domain);
 		if (!virq) {
 			dev_warn(&dev->dev,
@@ -285,10 +285,7 @@ static void axon_msi_teardown_msi_irqs(struct pci_dev *dev)
 
 	dev_dbg(&dev->dev, "axon_msi: tearing down msi irqs\n");
 
-	for_each_pci_msi_entry(entry, dev) {
-		if (!entry->irq)
-			continue;
-
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ASSOCIATED) {
 		irq_set_msi_desc(entry->irq, NULL);
 		irq_dispose_mapping(entry->irq);
 	}

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FFB477F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242773AbhLPVnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:43:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57528 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241950AbhLPVlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:15 -0500
Date:   Thu, 16 Dec 2021 21:41:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+JrwvYjI18I1ZMMV8XSJc2NVPr7XEwPzOT4rbkpv3V4=;
        b=Si0hFoshZe00WHVN4B3ktGOFVZY3tsHuw5rwfvm9J2I/fef33eS2VH9yx9w5HtD0pRYn0H
        al7iq5aMzFLzS1dhDYOmMOa6XJYRxiz0O17ChNUzJN3ubQhu2JNmqgdc8W0xGtaC9SdnQj
        rSBuUrbtjy+AC08rG21/PfSfnGCVv6tGAnFP56axch3+bfbwEJRiDLQqfntQEZMPB5D1eo
        eVv9r98t7P4vnFXVJjMGbcdbUqx9yvYLmKfQZlAokDhTFviY6OmY/h76ffguklW12paDV1
        5raFxVIBiGCmUtkJ8U0EMk586EGyxiNhlJZfBxeDUuUaJDzGHgDS5bz4l1h3/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+JrwvYjI18I1ZMMV8XSJc2NVPr7XEwPzOT4rbkpv3V4=;
        b=dT2uPvG+Q9jK42Q6ctsk1fEhM+8Oz8pThsMHZp7VB9ORLCBDRJI18ve3WYR9ZW0V3lyhdQ
        IpKUq+/tH671RMAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] powerpc/cell/axon_msi: Use PCI device property
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221813.493922179@linutronix.de>
References: <20211210221813.493922179@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969087264.23020.13042521329796834752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     d8a530578b166f3ec55d453b8b4b49599bd39884
Gitweb:        https://git.kernel.org/tip/d8a530578b166f3ec55d453b8b4b49599bd39884
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:18:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:38 +01:00

powerpc/cell/axon_msi: Use PCI device property

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20211210221813.493922179@linutronix.de

---
 arch/powerpc/platforms/cell/axon_msi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 79e2112..ac59aee 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -199,7 +199,6 @@ out_error:
 static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
 {
 	struct device_node *dn;
-	struct msi_desc *entry;
 	int len;
 	const u32 *prop;
 
@@ -209,10 +208,8 @@ static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
 		return -ENODEV;
 	}
 
-	entry = first_pci_msi_entry(dev);
-
 	for (; dn; dn = of_get_next_parent(dn)) {
-		if (entry->pci.msi_attrib.is_64) {
+		if (!dev->no_64bit_msi) {
 			prop = of_get_property(dn, "msi-address-64", &len);
 			if (prop)
 				break;

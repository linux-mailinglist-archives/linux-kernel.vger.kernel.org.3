Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0082A4FAD90
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbiDJK5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbiDJK4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:56:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003491BE9F;
        Sun, 10 Apr 2022 03:54:31 -0700 (PDT)
Date:   Sun, 10 Apr 2022 10:54:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649588070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jbSm1MHt39I7ELXl4PzbMeWOWrLGSVaBwZFiPCX5kO4=;
        b=BaCxajrw8f2BiofPEJ3mdMWGs/i78dZ71SL2R11aH3amcYqitK36vZL0uSC6Aqcwbkit0f
        UfbGRsBvTdo+HN5BwJVlfL3DfhviiIYvga2X79+8GKr7uhZDooGMpclwkO+2CWCihVqsNz
        2ATMEyj6G9XFWTAh8YGe5uIBuZkwopGaLJWUhWJFDy5B0NyVbb6owJTByxUujlJICKxBfk
        wMsg1OWheffEP/yMeV9pORe2ZD0skgAhfhvT38EMX9WOqqjL0EHE0NVFRk3v1IrtKRGgsD
        GBwuCXKbGOJpaoYkHI2f8e/LDbfjKIlaQOOYoYkAgB8dOhghs1PPGTYBqinwcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649588070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jbSm1MHt39I7ELXl4PzbMeWOWrLGSVaBwZFiPCX5kO4=;
        b=osdppoDdbDvW01RGyeM4n5I2ydJujFNqJZoB9hBK9Via9nHPaLCSC7rHjNrmH7ziCjC8mm
        ybP2CgjnFD9DpIBQ==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Add PIRQ routing table range checks
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2203301735510.22465@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203301735510.22465@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164958806957.4207.7929063021391145772.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     5d64089aa4a5bd3d7e00e3d6ddf4943dd34627b3
Gitweb:        https://git.kernel.org/tip/5d64089aa4a5bd3d7e00e3d6ddf4943dd34627b3
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Thu, 31 Mar 2022 08:10:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 12:48:14 +02:00

x86/PCI: Add PIRQ routing table range checks

Verify that the PCI IRQ Routing Table header as well as individual slot 
entries are all wholly contained within the BIOS memory area.  Do not 
even call the checksum calculator if the header would overrun the area 
and then bail out early if any slot would.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2203301735510.22465@angie.orcam.me.uk

---
 arch/x86/pci/irq.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 4b0e008..ef97b26 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -68,7 +68,8 @@ void (*pcibios_disable_irq)(struct pci_dev *dev) = pirq_disable_irq;
  *  and perform checksum verification.
  */
 
-static inline struct irq_routing_table *pirq_check_routing_table(u8 *addr)
+static inline struct irq_routing_table *pirq_check_routing_table(u8 *addr,
+								 u8 *limit)
 {
 	struct irq_routing_table *rt;
 	int i;
@@ -78,7 +79,8 @@ static inline struct irq_routing_table *pirq_check_routing_table(u8 *addr)
 	if (rt->signature != PIRQ_SIGNATURE ||
 	    rt->version != PIRQ_VERSION ||
 	    rt->size % 16 ||
-	    rt->size < sizeof(struct irq_routing_table))
+	    rt->size < sizeof(struct irq_routing_table) ||
+	    (limit && rt->size > limit - addr))
 		return NULL;
 	sum = 0;
 	for (i = 0; i < rt->size; i++)
@@ -99,17 +101,22 @@ static inline struct irq_routing_table *pirq_check_routing_table(u8 *addr)
 
 static struct irq_routing_table * __init pirq_find_routing_table(void)
 {
+	u8 * const bios_start = (u8 *)__va(0xf0000);
+	u8 * const bios_end = (u8 *)__va(0x100000);
 	u8 *addr;
 	struct irq_routing_table *rt;
 
 	if (pirq_table_addr) {
-		rt = pirq_check_routing_table((u8 *) __va(pirq_table_addr));
+		rt = pirq_check_routing_table((u8 *)__va(pirq_table_addr),
+					      NULL);
 		if (rt)
 			return rt;
 		printk(KERN_WARNING "PCI: PIRQ table NOT found at pirqaddr\n");
 	}
-	for (addr = (u8 *) __va(0xf0000); addr < (u8 *) __va(0x100000); addr += 16) {
-		rt = pirq_check_routing_table(addr);
+	for (addr = bios_start;
+	     addr < bios_end - sizeof(struct irq_routing_table);
+	     addr += 16) {
+		rt = pirq_check_routing_table(addr, bios_end);
 		if (rt)
 			return rt;
 	}

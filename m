Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EF14A7972
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347130AbiBBUat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347107AbiBBUan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:30:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B3AC061714;
        Wed,  2 Feb 2022 12:30:43 -0800 (PST)
Date:   Wed, 02 Feb 2022 20:30:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643833842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z0lMQ2E1ex2l9fna4M2GKB3BWXUSSPZ9p48oL8DuDBg=;
        b=DjK2YQSnAeb8rfARV9Gq5HR2WzNri1cHUtw9chb/zqUmL5fvQcLEb3O1gUIidOhBFyKR+k
        tbgrttjA8ac9cv3cVaeWylIkfShsmeUmomCXBUcZD1Z6j4QCjIQJkZQxJ2xWqjVwHDfot3
        l4gC0889aOyRSMgSk0MHLBu7jfCJ9zFffRAUrv6KEOifsyLrKCkgxU8Eg+Xwwi1P5ahiGt
        ZWdCdJEkcLeTEjcE90hY+O+D8pcYio3wd5nm1YZA1h9NUIMUgKBensPzJ97JpUQQGA1JSs
        XFJcfMicUbGX0axfdXUAoxLr/OhQiTvJRC2rBF63EviXOTOVLSJ/JG5VA5NdaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643833842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z0lMQ2E1ex2l9fna4M2GKB3BWXUSSPZ9p48oL8DuDBg=;
        b=uLgP7co0LiivC3eCEAk0DVCEZtgDh1JIbXLrjh0o646sLQFbU1KwwVFvjbA8aqqCXy/R7+
        Gwce1N8PIC38fxDA==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Add $IRT PIRQ routing table support
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2201022058050.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201022058050.56863@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164383384095.16921.8293739918583226276.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     d1ba93f1f1844e969051e144b4c3b30780fc4812
Gitweb:        https://git.kernel.org/tip/d1ba93f1f1844e969051e144b4c3b30780fc4812
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Thu, 06 Jan 2022 11:24:11 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Feb 2022 21:27:55 +01:00

x86/PCI: Add $IRT PIRQ routing table support

Handle the $IRT PCI IRQ Routing Table format used by AMI for its BCP 
(BIOS Configuration Program) external tool meant for tweaking BIOS 
structures without the need to rebuild it from sources[1].

The $IRT format has been invented by AMI before Microsoft has come up 
with its $PIR format and a $IRT table is therefore there in some systems 
that lack a $PIR table, such as the DataExpert EXP8449 mainboard based 
on the ALi FinALi 486 chipset (M1489/M1487), which predates DMI 2.0 and 
cannot therefore be easily identified at run time.

Unlike with the $PIR format there is no alignment guarantee as to the 
placement of the $IRT table, so scan the whole BIOS area bytewise.

Credit to Michal Necasek for helping to chase documentation for the 
format.

References:

[1] "What is BCP? - AMI", <https://www.ami.com/what-is-bcp/>

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2201022058050.56863@angie.orcam.me.uk

---
 arch/x86/include/asm/pci_x86.h |  8 ++++-
 arch/x86/pci/irq.c             | 70 +++++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 490411d..7be45da 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -90,6 +90,14 @@ struct irq_routing_table {
 	struct irq_info slots[0];
 } __attribute__((packed));
 
+struct irt_routing_table {
+	u32 signature;			/* IRT_SIGNATURE should be here */
+	u8 size;			/* Number of entries provided */
+	u8 used;			/* Number of entries actually used */
+	u16 exclusive_irqs;		/* IRQs devoted exclusively to PCI usage */
+	struct irq_info slots[0];
+} __packed;
+
 extern unsigned int pcibios_irq_mask;
 
 extern raw_spinlock_t pci_config_lock;
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 7113688..486ba58 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -25,6 +25,8 @@
 #define PIRQ_SIGNATURE	(('$' << 0) + ('P' << 8) + ('I' << 16) + ('R' << 24))
 #define PIRQ_VERSION 0x0100
 
+#define IRT_SIGNATURE	(('$' << 0) + ('I' << 8) + ('R' << 16) + ('T' << 24))
+
 static int broken_hp_bios_irq9;
 static int acer_tm360_irqrouting;
 
@@ -91,7 +93,69 @@ static inline struct irq_routing_table *pirq_check_routing_table(u8 *addr)
 	return NULL;
 }
 
+/*
+ * Handle the $IRT PCI IRQ Routing Table format used by AMI for its BCP
+ * (BIOS Configuration Program) external tool meant for tweaking BIOS
+ * structures without the need to rebuild it from sources.  The $IRT
+ * format has been invented by AMI before Microsoft has come up with its
+ * $PIR format and a $IRT table is therefore there in some systems that
+ * lack a $PIR table.
+ *
+ * It uses the same PCI BIOS 2.1 format for interrupt routing entries
+ * themselves but has a different simpler header prepended instead,
+ * occupying 8 bytes, where a `$IRT' signature is followed by one byte
+ * specifying the total number of interrupt routing entries allocated in
+ * the table, then one byte specifying the actual number of entries used
+ * (which the BCP tool can take advantage of when modifying the table),
+ * and finally a 16-bit word giving the IRQs devoted exclusively to PCI.
+ * Unlike with the $PIR table there is no alignment guarantee.
+ *
+ * Given the similarity of the two formats the $IRT one is trivial to
+ * convert to the $PIR one, which we do here, except that obviously we
+ * have no information as to the router device to use, but we can handle
+ * it by matching PCI device IDs actually seen on the bus against ones
+ * that our individual routers recognise.
+ *
+ * Reportedly there is another $IRT table format where a 16-bit word
+ * follows the header instead that points to interrupt routing entries
+ * in a $PIR table provided elsewhere.  In that case this code will not
+ * be reached though as the $PIR table will have been chosen instead.
+ */
+static inline struct irq_routing_table *pirq_convert_irt_table(u8 *addr)
+{
+	struct irt_routing_table *ir;
+	struct irq_routing_table *rt;
+	u16 size;
+	u8 sum;
+	int i;
+
+	ir = (struct irt_routing_table *)addr;
+	if (ir->signature != IRT_SIGNATURE || !ir->used || ir->size < ir->used)
+		return NULL;
+
+	DBG(KERN_DEBUG "PCI: $IRT Interrupt Routing Table found at 0x%lx\n",
+	    __pa(ir));
+
+	size = sizeof(*rt) + ir->used * sizeof(rt->slots[0]);
+	rt = kzalloc(size, GFP_KERNEL);
+	if (!rt)
+		return NULL;
+
+	rt->signature = PIRQ_SIGNATURE;
+	rt->version = PIRQ_VERSION;
+	rt->size = size;
+	rt->exclusive_irqs = ir->exclusive_irqs;
+	for (i = 0; i < ir->used; i++)
+		rt->slots[i] = ir->slots[i];
+
+	addr = (u8 *)rt;
+	sum = 0;
+	for (i = 0; i < size; i++)
+		sum += addr[i];
+	rt->checksum = -sum;
 
+	return rt;
+}
 
 /*
  *  Search 0xf0000 -- 0xfffff for the PCI IRQ Routing Table.
@@ -113,6 +177,12 @@ static struct irq_routing_table * __init pirq_find_routing_table(void)
 		if (rt)
 			return rt;
 	}
+
+	for (addr = (u8 *)__va(0xf0000); addr < (u8 *)__va(0x100000); addr++) {
+		rt = pirq_convert_irt_table(addr);
+		if (rt)
+			return rt;
+	}
 	return NULL;
 }
 

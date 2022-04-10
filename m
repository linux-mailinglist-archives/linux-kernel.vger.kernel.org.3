Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2144FAD84
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiDJK4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237695AbiDJK4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:56:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104621B7AC;
        Sun, 10 Apr 2022 03:54:30 -0700 (PDT)
Date:   Sun, 10 Apr 2022 10:54:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649588068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQAvyZXu2LVBkGKqV2BT+PBZ+o6VTOnkWSPrOSmXPDo=;
        b=moGURUIG97njT8KU9sKmmAhJTPwwjsWMaeFNdEKMKsyOfQc176z3XfHUR7wsrSAAoB9kAz
        j6/ZXRgG8r+ZLsTGxhcu0x+5hF3xIV+poKlYKMigsfasroG8Ndq9YL6d5Fzv6g/XPFqdLF
        ZLXgCOROkRTqL1F/njIDFvC6HFNG2GphHky1EPesdzJePYUrDm+IZN4f9AeLlmvFNtVcTK
        /LZ4iFGZw7ZMP5Fylhf/9dPCRUs2+yMzcZzxoubQUm/5gF/+vf4tX8hh0aakK9cH9eYpgl
        8auKHI3xdlz4g9rAAGuQ+hL6n9sG2slH3zTwfsqn3aYDF1zYVyk51FoCENRyaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649588068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQAvyZXu2LVBkGKqV2BT+PBZ+o6VTOnkWSPrOSmXPDo=;
        b=IYNIEE1pUbSyE/J6NilR2JbegG+UwaFYWWwcNQd68zm/uhMOD1Jyn4K5sjMb4caYsysCT0
        tb9cSvVlu6G1/pAg==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Add $IRT PIRQ routing table support
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2203302228410.9038@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203302228410.9038@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164958806764.4207.17912629832376316392.tip-bot2@tip-bot2>
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

Commit-ID:     b584db0c84db5ed9230356d5fa6610de55d297e6
Gitweb:        https://git.kernel.org/tip/b584db0c84db5ed9230356d5fa6610de55d297e6
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Thu, 31 Mar 2022 08:11:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 12:48:14 +02:00

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

Credit to Michal Necasek for helping me chase documentation for the 
format.

References:

[1] "What is BCP? - AMI", <https://www.ami.com/what-is-bcp/>

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com> # crosvm
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2203302228410.9038@angie.orcam.me.uk

---
 arch/x86/include/asm/pci_x86.h |  9 ++++-
 arch/x86/pci/irq.c             | 76 +++++++++++++++++++++++++++++++++-
 2 files changed, 85 insertions(+)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index a0627df..1307cd6 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -93,6 +93,15 @@ struct irq_routing_table {
 	struct irq_info slots[];
 } __attribute__((packed));
 
+struct irt_routing_table {
+	u32 signature;			/* IRT_SIGNATURE should be here */
+	u8 size;			/* Number of entries provided */
+	u8 used;			/* Number of entries actually used */
+	u16 exclusive_irqs;		/* IRQs devoted exclusively to
+					   PCI usage */
+	struct irq_info slots[];
+} __attribute__((packed));
+
 extern unsigned int pcibios_irq_mask;
 
 extern raw_spinlock_t pci_config_lock;
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index d4ecf88..4a5e80f 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -25,6 +25,8 @@
 #define PIRQ_SIGNATURE	(('$' << 0) + ('P' << 8) + ('I' << 16) + ('R' << 24))
 #define PIRQ_VERSION 0x0100
 
+#define IRT_SIGNATURE	(('$' << 0) + ('I' << 8) + ('R' << 16) + ('T' << 24))
+
 static int broken_hp_bios_irq9;
 static int acer_tm360_irqrouting;
 
@@ -93,7 +95,74 @@ static inline struct irq_routing_table *pirq_check_routing_table(u8 *addr,
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
+static inline struct irq_routing_table *pirq_convert_irt_table(u8 *addr,
+							       u8 *limit)
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
+	size = sizeof(*ir) + ir->used * sizeof(ir->slots[0]);
+	if (size > limit - addr)
+		return NULL;
+
+	DBG(KERN_DEBUG "PCI: $IRT Interrupt Routing Table found at 0x%lx\n",
+	    __pa(ir));
+
+	size = sizeof(*rt) + ir->used * sizeof(rt->slots[0]);
+	rt = kzalloc(size, GFP_KERNEL);
+	if (!rt)
+		return NULL;
 
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
+
+	return rt;
+}
 
 /*
  *  Search 0xf0000 -- 0xfffff for the PCI IRQ Routing Table.
@@ -120,6 +189,13 @@ static struct irq_routing_table * __init pirq_find_routing_table(void)
 		if (rt)
 			return rt;
 	}
+	for (addr = bios_start;
+	     addr < bios_end - sizeof(struct irt_routing_table);
+	     addr++) {
+		rt = pirq_convert_irt_table(addr, bios_end);
+		if (rt)
+			return rt;
+	}
 	return NULL;
 }
 

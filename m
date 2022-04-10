Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2890B4FAD96
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbiDJK5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238122AbiDJK4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:56:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550581CFC5;
        Sun, 10 Apr 2022 03:54:37 -0700 (PDT)
Date:   Sun, 10 Apr 2022 10:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649588075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3feepCBik2siLpXZRQr+PqPXUxyNX/7dgKxne5Xirk=;
        b=q9JgaODsNPAGvf2HSSgi0haqskMfj0oiP4vr3DOXRtBCSVktaBXw6mE6PdIpDajpUZ2nn9
        dGTqhwyQGN6J6uPMSvPxk6xIfOG2kPoO34ts/vT9NScQhAOtJisWp4jJqxdknLrlPq+PkX
        rxgfZIZIycWtnxyOr8NQvEwS4d3SRsJI1DW2tAAs7v9HNNEC8/oacrNYqghCki2jWmySTR
        8KWzuvnACKqwAVtNq8pdmte1ojFYBkX+kUQmwatrN2MZT2bVtwXAvkovR7Akk1YnwIxRNw
        dEx87lpaqgSUmlL9xl1JXi2sU4Ll4rKd7e5HAwTk4NZBYkZ4nlF98Uf7K65/gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649588075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3feepCBik2siLpXZRQr+PqPXUxyNX/7dgKxne5Xirk=;
        b=A3wXF9jVhbWq3/4wTaSAMMX2+cmtw97qL++ntvI3eJp1mfFnnieNCu96X5+dRVK9DyjDk2
        6ugpBs2b9lht54AQ==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Show the physical address of the $PIR table
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2203301532330.22465@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203301532330.22465@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164958807487.4207.16019759220155099068.tip-bot2@tip-bot2>
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

Commit-ID:     613fa6e217e1f216109da784d6f127cc708026c0
Gitweb:        https://git.kernel.org/tip/613fa6e217e1f216109da784d6f127cc708026c0
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Thu, 31 Mar 2022 08:10:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 12:48:14 +02:00

x86/PCI: Show the physical address of the $PIR table

It makes no sense to hide the address of the $PIR table in a debug dump:

PCI: Interrupt Routing Table found at 0x(ptrval)

let alone print its virtual address, given that this is a BIOS entity at 
a fixed location in the system's memory map.  Show the physical address 
instead then, e.g.:

PCI: Interrupt Routing Table found at 0xfde10

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2203301532330.22465@angie.orcam.me.uk

---
 arch/x86/pci/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 97b63e3..a33fe9c 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -84,8 +84,8 @@ static inline struct irq_routing_table *pirq_check_routing_table(u8 *addr)
 	for (i = 0; i < rt->size; i++)
 		sum += addr[i];
 	if (!sum) {
-		DBG(KERN_DEBUG "PCI: Interrupt Routing Table found at 0x%p\n",
-			rt);
+		DBG(KERN_DEBUG "PCI: Interrupt Routing Table found at 0x%lx\n",
+		    __pa(rt));
 		return rt;
 	}
 	return NULL;

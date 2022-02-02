Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382594A797E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347232AbiBBUbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347148AbiBBUax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:30:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2C8C06173D;
        Wed,  2 Feb 2022 12:30:52 -0800 (PST)
Date:   Wed, 02 Feb 2022 20:30:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643833850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05IXDmsz590Qt5Iy6Gh3L/QY5R4OhEuU6v550Gi7aRo=;
        b=2w/ZhfBOL4NeJZ/d5w+0m97pAf0vPNiI9ziaKvNkIi71PvwmWTawwjUVRFmwmDYW7Xjejo
        zv9QuTKF8CjV1WU0kQcXbzSiZeFMEpccoiI7VCPCZGJTtWQz5dY2ulPDhLqO5Whtz25cbA
        VGrLBfbB0lU5BSjMX4fMFWpPwDkFWAzYLl+StYpNIqlQMqeO0j2VrA767bvzyb3FQy7QMk
        KKm5ceyG1IAwdacmV6vWLIfkPJmB4N/U2KM/DSVMT4b8kXC92O3TzVRSJOnNnOUY3DAwMr
        JF6UFRFVe/gWH5rdFcCzod43S/ZbpegQqISp9JoyJXfR5pacsfEu1GQKdoPwgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643833850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05IXDmsz590Qt5Iy6Gh3L/QY5R4OhEuU6v550Gi7aRo=;
        b=92iMbhDKZbUFBxVNSgKQCgU/hx34hluhPG6J1r9285DcV2Um+9T0diTdwFY52tn6kZl2zv
        WMA8ftu63JTaSQCw==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Show the physical address of the $PIR table
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2201020151450.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201020151450.56863@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164383384979.16921.61822794104913419.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     5c2830301a8784d0392aec617856f1b973bc5bea
Gitweb:        https://git.kernel.org/tip/5c2830301a8784d0392aec617856f1b973bc5bea
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Sun, 02 Jan 2022 23:24:23 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Feb 2022 21:27:54 +01:00

x86/PCI: Show the physical address of the $PIR table

It makes no sense to hide the address of the $PIR table in a debug dump:

PCI: Interrupt Routing Table found at 0x(ptrval)

let alone print its virtual address, given that this is a BIOS entity at 
a fixed location in the system's memory map.  Show the physical address 
instead then, e.g.:

PCI: Interrupt Routing Table found at 0xfde10

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2201020151450.56863@angie.orcam.me.uk

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

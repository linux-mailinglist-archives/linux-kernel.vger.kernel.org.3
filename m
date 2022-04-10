Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEAC4FAD94
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbiDJK5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbiDJK4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:56:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831AA1B7B6;
        Sun, 10 Apr 2022 03:54:36 -0700 (PDT)
Date:   Sun, 10 Apr 2022 10:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649588075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dVZimOGPhZ9XbPxXk8NkGwqh9ntSDqPjo83QjXqoQJU=;
        b=cgi4KtFa2/HikoO+g9axYvwRdeRujT9LFCFq+dAY0WHWAq1YRTCQtiHi+tzsX1f7mhpnIm
        72V2Tid5fxnbD4fjXGXtFTvrUUtXM85N0Hg47/2Hp/A2K+8YPsXKGeDlzXv452o6ommeUB
        jhNjEFEAC5YE5Wk+PRG39bIRXd4AhgpgtkBaRTwwlu9BKSQ5tQhQOsN9pPa/D1WHgoQztk
        XkqWe/fCybxKfNhRftw3iNZ0w6oIIg9GSxl4+5xDt6bm8MnDQxAmPAmz6NI6hkG6dzjLe7
        zKvm9cT5ojyWHizPiMjmjTqe6buMmLhhIj9CTK3h8i4isDtn7TReHdV4yBHLIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649588075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dVZimOGPhZ9XbPxXk8NkGwqh9ntSDqPjo83QjXqoQJU=;
        b=g+bdYzY6d1LQiPXEXdBD+8JHRGQeaZC1ZM0YKx/Hn0IAUKRlUIT3GUpx374FXEfggLYJrk
        lH04fsUJ8f07diDQ==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Include function number in $PIR table dump
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2203301534440.22465@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203301534440.22465@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164958807403.4207.9539001645356998793.tip-bot2@tip-bot2>
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

Commit-ID:     dc0e64087213768a6232af980076a517aaaa4adb
Gitweb:        https://git.kernel.org/tip/dc0e64087213768a6232af980076a517aaaa4adb
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Thu, 31 Mar 2022 08:10:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 12:48:14 +02:00

x86/PCI: Include function number in $PIR table dump

Contrary to the PCI BIOS specification[1] some systems include the PCI 
function number for motherboard devices in their $PIR table, e.g. this 
is what the Tyan Tomcat IV S1564D board reports:

00:14 slot=01
 0:60/deb8
 1:61/deb8
 2:62/deb8
 3:63/deb8

00:13 slot=02
 0:61/deb8
 1:62/deb8
 2:63/deb8
 3:60/deb8

00:12 slot=03
 0:62/deb8
 1:63/deb8
 2:60/deb8
 3:61/deb8

00:11 slot=04
 0:63/deb8
 1:60/deb8
 2:61/deb8
 3:62/deb8

00:07 slot=00
 0:00/deb8
 1:00/deb8
 2:00/deb8
 3:00/deb8

00:07 slot=00
 0:00/deb8
 1:00/deb8
 2:00/deb8
 3:63/deb8

Print the function number then in the debug $PIR table dump:

00:14.0 slot=01
 0:60/deb8
 1:61/deb8
 2:62/deb8
 3:63/deb8

00:13.0 slot=02
 0:61/deb8
 1:62/deb8
 2:63/deb8
 3:60/deb8

00:12.0 slot=03
 0:62/deb8
 1:63/deb8
 2:60/deb8
 3:61/deb8

00:11.0 slot=04
 0:63/deb8
 1:60/deb8
 2:61/deb8
 3:62/deb8

00:07.1 slot=00
 0:00/deb8
 1:00/deb8
 2:00/deb8
 3:00/deb8

00:07.2 slot=00
 0:00/deb8
 1:00/deb8
 2:00/deb8
 3:63/deb8

References:

[1] "PCI BIOS Specification", Revision 2.1, PCI Special Interest Group, 
    August 26, 1994, Table 4-1 "Layout of IRQ routing table entry.", p. 
    12

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2203301534440.22465@angie.orcam.me.uk

---
 arch/x86/pci/irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index a33fe9c..b6b9853 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -135,7 +135,8 @@ static void __init pirq_peer_trick(void)
 #ifdef DEBUG
 		{
 			int j;
-			DBG(KERN_DEBUG "%02x:%02x slot=%02x", e->bus, e->devfn/8, e->slot);
+			DBG(KERN_DEBUG "%02x:%02x.%x slot=%02x",
+			    e->bus, e->devfn / 8, e->devfn % 8, e->slot);
 			for (j = 0; j < 4; j++)
 				DBG(" %d:%02x/%04x", j, e->irq[j].link, e->irq[j].bitmap);
 			DBG("\n");

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE43A4A797D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347211AbiBBUbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:31:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48962 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347133AbiBBUav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:30:51 -0500
Date:   Wed, 02 Feb 2022 20:30:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643833849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=it/bd9GP8SweyuwYrMPemeUJ+iMlIc2pEixb7rQ3wUc=;
        b=OM5Ndl1uU33mwxrjKMvorI84dy1Z7ZV2gV562YWqYkX8+MnGcyTs2BGtuyO296k6pAXO8E
        VChKpUTEZ/TF4NoOxzH5mvqJ6ygfEw6vU32g7wWTdnXiLj625wiifP+NR49E2VabuhNR3+
        y6sXQfgvQwDsv/hP9HDTy23CivKouzIxMZoe158zlNjyoQNXDqqajZM4dHMun7UNzNVHTj
        8CYCfAcW5Yq8aX0XblH/bqMLMjmRUv4ipZWRz5hoTwE/2f6etKf/YycQKYL2OtnFaK7JYh
        VnY3PPoytIS+xp8916+jm6sLYtjTUGf6mMO3pSwcNsXn3tZcLFDHG4mmTJbJhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643833849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=it/bd9GP8SweyuwYrMPemeUJ+iMlIc2pEixb7rQ3wUc=;
        b=BvfoOJMIUiEqtxH/6C40VA3wEUzN8wMPgag+yH3wc6Tb+zkgaqXVPdAJhrV8y78asAPzLv
        KcvhONFs6lEoyfCQ==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Include function number in $PIR table dump
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2201020153230.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201020153230.56863@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164383384808.16921.16565325155265314016.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     9574931789945734fd8abcf99883b83a3b3b32ba
Gitweb:        https://git.kernel.org/tip/9574931789945734fd8abcf99883b83a3b3b32ba
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Sun, 02 Jan 2022 23:24:29 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Feb 2022 21:27:54 +01:00

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
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2201020153230.56863@angie.orcam.me.uk

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

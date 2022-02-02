Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5594F4A7979
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347149AbiBBUbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:31:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48968 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347119AbiBBUar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:30:47 -0500
Date:   Wed, 02 Feb 2022 20:30:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643833846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vzBTsakiUtVNgaRKNnkMP7IlY5oKGCueR/lUDMTegVs=;
        b=gC8pKrhqC0oC0xwFnJkzZ3aSm4ChN8o+4aO99reiG+xIaNxs3oj5qqcwbIcgSIxSChekgs
        RmQgtShR5XEOGb4K7ufSS5gc3KA1Kt8yzoX71WxDwc9J8Og+xy1CN7Pxi2yTbDcj4xPp3q
        sJ02soIgeVHB2ry4vNwxrc7SJzI6mbHfptATabdaSljkzZGQvf0W7IU0rMgi/jGHXjgLXb
        E2lTb8BOilkSeryYtRFZL4+Nox+QIaROml03N8ig8XMS3hJ1NVpkS8SnvVBtMDr5BTSz1j
        IA/JtDLgQYlhnrWaHnFi91DjWO9E+4Bzuv9wP0pHvvO2B0ib5CQENDqdwRNRKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643833846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vzBTsakiUtVNgaRKNnkMP7IlY5oKGCueR/lUDMTegVs=;
        b=mAPz5rLnPHuCCvqLvTcXtry93tsOYwVGrMypjjyYdJpfx4Dpbi+Q490ipREcFJBqqYoefL
        bI2GyobOIeH0AoAg==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Add support for the Intel 82378ZB/82379AB
 (SIO/SIO.A) PIRQ router
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2201022030220.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201022030220.56863@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164383384535.16921.6036492888772148605.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     dfcf39eff65f322d5fc92dda9e9db044c4dac5d5
Gitweb:        https://git.kernel.org/tip/dfcf39eff65f322d5fc92dda9e9db044c4dac5d5
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Sun, 02 Jan 2022 23:24:52 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Feb 2022 21:27:55 +01:00

x86/PCI: Add support for the Intel 82378ZB/82379AB (SIO/SIO.A) PIRQ router

The Intel 82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A) 
ISA bridges implement PCI interrupt steering with a PIRQ router[1][2] 
that is exactly the same as that of the PIIX and ICH southbridges (or 
actually the other way round, given that the SIO ASIC was there first).

An earlier version of the SIO, the 82378IB[3][4], does not implement PCI 
interrupt steering however, so we need to exclude it by checking the low 
nibble of the PCI Revision Identification Register[5][6] for being at 
least 3.

There is a note in the 82379AB specification update[7] saying that the 
device ID for that chip is 0x7, rather than 0x484 as stated in the 
datasheet[8].  It looks like a red herring however, for no report has 
been ever seen with that value quoted and it matches the documented 
default value of the PCI Command Register, which comes next after the 
PCI Device Identification Register, so it looks like a copy-&-paste 
editorial mistake.

NB the 82378ZB has been commonly used with smaller DEC Alpha systems 
with the contents of the Revision Identification Register reported as 
one of 0x3, 0x43, or 0x84, so the masking of the high nibble seems 
indeed right by empirical observation.  The value in the high nibble 
might be either random, or depend on the batch, or correspond to some 
other state such as reset straps.

References:

[1] "82378 System I/O (SIO)", Intel Corporation, Order Number: 
    290473-004, December 1994, Section 4.1.26 "PIRQ[3:0]#--PIRQ Route 
    Control Registers"

[2] "82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A)",
    Intel Corporation, Order Number: 290571-001, March 1996, Section 
    3.1.25. "PIRQ[3:0]#--PIRQ Route Control Registers", p. 48

[3] "82378IB System I/O (SIO)", Intel Corporation, Order Number:
    290473-002, April 1993, Section 5.8.7.7 "Edge and Level Triggered
    Modes"

[4] "82378IB to 82378ZB Errata Fix and Feature Enhancement Conversion
    FOL933002-01",
    https://web.archive.org/web/19990421045433/http://support.intel.com/support/chipsets/420/8511.htm

[5] "82378 System I/O (SIO)", Intel Corporation, Order Number: 
    290473-004, December 1994, Section 4.1.5. "RID--Revision 
    Identification Register"

[6] "82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A)",
    Intel Corporation, Order Number: 290571-001, March 1996, Section 
    3.1.5. "RID--Revision Identification Register", p. 34

[7] "Intel 82379AB (SIO.A) System I/O Component Specification Update", 
    Intel Corporation, Order Number: 297734-001, May, 1996, "Component 
    Identification via Programming Interface", p. 5

[8] "82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A)",
    Intel Corporation, Order Number: 290571-001, March 1996, Section 
    3.1.2. "DID--Device Identification Register", p. 33

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2201022030220.56863@angie.orcam.me.uk

---
 arch/x86/pci/irq.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index bd32e4b..23c69c4 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -801,11 +801,18 @@ static __init int intel_router_probe(struct irq_router *r, struct pci_dev *route
 		return 0;
 
 	switch (device) {
+		u8 rid;
 	case PCI_DEVICE_ID_INTEL_82375:
 		r->name = "PCEB/ESC";
 		r->get = pirq_esc_get;
 		r->set = pirq_esc_set;
 		return 1;
+	case PCI_DEVICE_ID_INTEL_82378:
+		pci_read_config_byte(router, PCI_REVISION_ID, &rid);
+		/* Tell 82378IB (rev < 3) and 82378ZB/82379AB apart.  */
+		if ((rid & 0xfu) < 3)
+			break;
+		fallthrough;
 	case PCI_DEVICE_ID_INTEL_82371FB_0:
 	case PCI_DEVICE_ID_INTEL_82371SB_0:
 	case PCI_DEVICE_ID_INTEL_82371AB_0:
@@ -847,7 +854,7 @@ static __init int intel_router_probe(struct irq_router *r, struct pci_dev *route
 	case PCI_DEVICE_ID_INTEL_ICH10_3:
 	case PCI_DEVICE_ID_INTEL_PATSBURG_LPC_0:
 	case PCI_DEVICE_ID_INTEL_PATSBURG_LPC_1:
-		r->name = "PIIX/ICH";
+		r->name = "SIO/PIIX/ICH";
 		r->get = pirq_piix_get;
 		r->set = pirq_piix_set;
 		return 1;
@@ -866,7 +873,7 @@ static __init int intel_router_probe(struct irq_router *r, struct pci_dev *route
 	     device <= PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MAX)
 	||  (device >= PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MIN &&
 	     device <= PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MAX)) {
-		r->name = "PIIX/ICH";
+		r->name = "SIO/PIIX/ICH";
 		r->get = pirq_piix_get;
 		r->set = pirq_piix_set;
 		return 1;

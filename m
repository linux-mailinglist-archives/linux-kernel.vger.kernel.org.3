Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE514A95A7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348290AbiBDI5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:57:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58768 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiBDI5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:57:47 -0500
Date:   Fri, 04 Feb 2022 08:57:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643965066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KprAP9nubAD43vVJ5MtB0V2n47pzKaQf304UqJmrUl8=;
        b=kzU6qZX+MFEnKhJ+SEHNzTlW8/jcBo5rlUucipWBuVtm2aIoIT4tbRwpsHMhLdxyb0LHLt
        qh0ygJvVgX05wuDAGtV0ostcfiQJltgZ/tBs0LNgvw1LwhlFJiuEURC+AixSQWnJ6zUuDF
        VXmrBn9yAz513apy/AAhL0LAYPBmMX0a/Jso9SlRsvN/Sdrv9dgEn62UtxmyiEMLZWYZwF
        lUHyi24rX8cUPU5xRglnLNSDvxCMUYdKxBGg4cavaXF4S7zMszQTAMWS+Cr7ROAjEfcHCj
        lbUz9aIBwyzc2x1JeApsOftq46mMwFFcbeFc0xTyxsP/o2/dlcZ280kxsS3LCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643965066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KprAP9nubAD43vVJ5MtB0V2n47pzKaQf304UqJmrUl8=;
        b=pAE8/EyZ6yYKYWLT71cFkGNSwf2MmesZcQeheiuwut8XtkO6pnm1oQkOVc53fUGLBH0WfV
        xsHu/C8tWBYK+CCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] PCI/MSI: Remove bogus warning in pci_irq_get_affinity()
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <87ee4n38sm.ffs@tglx>
References: <87ee4n38sm.ffs@tglx>
MIME-Version: 1.0
Message-ID: <164396506527.16921.1990922190197899743.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     dd7f5a11ac5a6f733f422dc22b4d145d3260304e
Gitweb:        https://git.kernel.org/tip/dd7f5a11ac5a6f733f422dc22b4d145d3260304e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 31 Jan 2022 22:02:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Feb 2022 09:54:20 +01:00

PCI/MSI: Remove bogus warning in pci_irq_get_affinity()

The recent overhaul of pci_irq_get_affinity() introduced a regression when
pci_irq_get_affinity() is called for an MSI-X interrupt which was not
allocated with affinity descriptor information.

The original code just returned a NULL pointer in that case, but the rework
added a WARN_ON() under the assumption that the corresponding WARN_ON() in
the MSI case can be applied to MSI-X as well.

In fact the MSI warning in the original code does not make sense either
because it's legitimate to invoke pci_irq_get_affinity() for a MSI
interrupt which was not allocated with affinity descriptor information.

Remove it and just return NULL as the original code did.

Fixes: f48235900182 ("PCI/MSI: Simplify pci_irq_get_affinity()")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/87ee4n38sm.ffs@tglx

---
 drivers/pci/msi/msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index c19c7ca..9037a78 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -1111,7 +1111,8 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 	if (!desc)
 		return cpu_possible_mask;
 
-	if (WARN_ON_ONCE(!desc->affinity))
+	/* MSI[X] interrupts can be allocated without affinity descriptor */
+	if (!desc->affinity)
 		return NULL;
 
 	/*

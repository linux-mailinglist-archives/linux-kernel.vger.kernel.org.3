Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589974FAD92
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbiDJK5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbiDJK4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:56:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AA71C90A;
        Sun, 10 Apr 2022 03:54:33 -0700 (PDT)
Date:   Sun, 10 Apr 2022 10:54:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649588072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1guhnHZzwrCZjyg166lm4hwq2SxmL4BgKNLB9lB4vxE=;
        b=2zIBUf7gmhtPq7kot62BA18baedOv9znbEd9CyUG76EpCLWaoaFmwRIsilxlfpPpkH2U/i
        Kc59SfB9fSilDIGOnIK8eWnTBJzGxdUiOA53Ek9Pe4ufwV9PZ8EYUqHG1quoMj+035CfZE
        ZZbzjvyx9oHkaj8Rm7UUb7otGqxg6NhBaX70ltJyeBhlFOQh3vL9ut/gD7f/NClcip8xPv
        Tl762w5ukWnPvphyR1Pt/YmcZI58g5d+050M9gQ0IsJO9ECrWwspbJNzj82lN6ocetDor9
        tIq8zhsDi8MzuK+Jsq2QbRR4ohv0XGcANpF/WqH7sFnt99o5f8gvN+6Vfp3LHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649588072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1guhnHZzwrCZjyg166lm4hwq2SxmL4BgKNLB9lB4vxE=;
        b=IZLlrJ6/lND26UKXN4nwTq9UmBrILB0kNbAIOoyzUBJie28xUqPK3OB9ys1xXRUeEytq3f
        bA2hDX7z1i1OLoAw==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Disambiguate SiS85C503 PIRQ router code entities
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2203301610000.22465@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203301610000.22465@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164958807141.4207.9726378089695079049.tip-bot2@tip-bot2>
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

Commit-ID:     5a0e5fa957db79177baa851d687b6f6aa5a0be96
Gitweb:        https://git.kernel.org/tip/5a0e5fa957db79177baa851d687b6f6aa5a0be96
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Thu, 31 Mar 2022 08:10:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 12:48:14 +02:00

x86/PCI: Disambiguate SiS85C503 PIRQ router code entities

In preparation to adding support for the SiS85C497 PIRQ router add `503' 
to the names of SiS85C503 PIRQ router code entities so that they clearly 
indicate which device they refer to.

Also restructure `sis_router_probe' such that new device IDs will be 
just new switch cases.

No functional change.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2203301610000.22465@angie.orcam.me.uk

---
 arch/x86/pci/irq.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index bd32e4b..e5bc9f7 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -641,11 +641,12 @@ static int pirq_cyrix_set(struct pci_dev *router, struct pci_dev *dev, int pirq,
  *				bit 6-4 are probably unused, not like 5595
  */
 
-#define PIRQ_SIS_IRQ_MASK	0x0f
-#define PIRQ_SIS_IRQ_DISABLE	0x80
-#define PIRQ_SIS_USB_ENABLE	0x40
+#define PIRQ_SIS503_IRQ_MASK	0x0f
+#define PIRQ_SIS503_IRQ_DISABLE	0x80
+#define PIRQ_SIS503_USB_ENABLE	0x40
 
-static int pirq_sis_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+static int pirq_sis503_get(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq)
 {
 	u8 x;
 	int reg;
@@ -654,10 +655,11 @@ static int pirq_sis_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 	if (reg >= 0x01 && reg <= 0x04)
 		reg += 0x40;
 	pci_read_config_byte(router, reg, &x);
-	return (x & PIRQ_SIS_IRQ_DISABLE) ? 0 : (x & PIRQ_SIS_IRQ_MASK);
+	return (x & PIRQ_SIS503_IRQ_DISABLE) ? 0 : (x & PIRQ_SIS503_IRQ_MASK);
 }
 
-static int pirq_sis_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
+static int pirq_sis503_set(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq, int irq)
 {
 	u8 x;
 	int reg;
@@ -666,8 +668,8 @@ static int pirq_sis_set(struct pci_dev *router, struct pci_dev *dev, int pirq, i
 	if (reg >= 0x01 && reg <= 0x04)
 		reg += 0x40;
 	pci_read_config_byte(router, reg, &x);
-	x &= ~(PIRQ_SIS_IRQ_MASK | PIRQ_SIS_IRQ_DISABLE);
-	x |= irq ? irq: PIRQ_SIS_IRQ_DISABLE;
+	x &= ~(PIRQ_SIS503_IRQ_MASK | PIRQ_SIS503_IRQ_DISABLE);
+	x |= irq ? irq : PIRQ_SIS503_IRQ_DISABLE;
 	pci_write_config_byte(router, reg, x);
 	return 1;
 }
@@ -959,13 +961,14 @@ static __init int serverworks_router_probe(struct irq_router *r,
 
 static __init int sis_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
 {
-	if (device != PCI_DEVICE_ID_SI_503)
-		return 0;
-
-	r->name = "SIS";
-	r->get = pirq_sis_get;
-	r->set = pirq_sis_set;
-	return 1;
+	switch (device) {
+	case PCI_DEVICE_ID_SI_503:
+		r->name = "SiS85C503";
+		r->get = pirq_sis503_get;
+		r->set = pirq_sis503_set;
+		return 1;
+	}
+	return 0;
 }
 
 static __init int cyrix_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)

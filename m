Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1289F568A00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiGFNs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiGFNsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:48:55 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34459167CC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:48:54 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id rpor270094C55Sk01porMm; Wed, 06 Jul 2022 15:48:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o95Oc-002LRD-Vl; Wed, 06 Jul 2022 15:48:50 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o95Oc-009fex-HB; Wed, 06 Jul 2022 15:48:50 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: mac: Remove forward declaration for mac_nmi_handler()
Date:   Wed,  6 Jul 2022 15:48:46 +0200
Message-Id: <fa48394ecba7c29a2da354d13c1017b37237f25b.1657114783.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move mac_nmi_handler() before its caller, so its forward declaration can
be dropped.  While at it, make the function static, and absorb the
variable in_nmi, which is only used inside the function.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued in the m68k tree for v5.20.

 arch/m68k/mac/macints.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/m68k/mac/macints.c b/arch/m68k/mac/macints.c
index e3575388cd05a8cc..883e48230f87a187 100644
--- a/arch/m68k/mac/macints.c
+++ b/arch/m68k/mac/macints.c
@@ -129,8 +129,6 @@
 
 extern void show_registers(struct pt_regs *);
 
-irqreturn_t mac_nmi_handler(int, void *);
-
 static unsigned int mac_irq_startup(struct irq_data *);
 static void mac_irq_shutdown(struct irq_data *);
 
@@ -142,6 +140,21 @@ static struct irq_chip mac_irq_chip = {
 	.irq_shutdown	= mac_irq_shutdown,
 };
 
+static irqreturn_t mac_nmi_handler(int irq, void *dev_id)
+{
+	static volatile int in_nmi;
+
+	if (in_nmi)
+		return IRQ_HANDLED;
+	in_nmi = 1;
+
+	pr_info("Non-Maskable Interrupt\n");
+	show_registers(get_irq_regs());
+
+	in_nmi = 0;
+	return IRQ_HANDLED;
+}
+
 void __init mac_init_IRQ(void)
 {
 	m68k_setup_irq_controller(&mac_irq_chip, handle_simple_irq, IRQ_USER,
@@ -254,18 +267,3 @@ static void mac_irq_shutdown(struct irq_data *data)
 	else
 		mac_irq_disable(data);
 }
-
-static volatile int in_nmi;
-
-irqreturn_t mac_nmi_handler(int irq, void *dev_id)
-{
-	if (in_nmi)
-		return IRQ_HANDLED;
-	in_nmi = 1;
-
-	pr_info("Non-Maskable Interrupt\n");
-	show_registers(get_irq_regs());
-
-	in_nmi = 0;
-	return IRQ_HANDLED;
-}
-- 
2.25.1


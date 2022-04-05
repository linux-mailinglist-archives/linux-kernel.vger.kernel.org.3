Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCBB4F4F1C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587503AbiDFAJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344821AbiDENKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:10:44 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839CA8FE44
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:12:24 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KXmjZ2LPmz9sT7;
        Tue,  5 Apr 2022 14:12:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gdQ4MYRGJgtj; Tue,  5 Apr 2022 14:12:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KXmjY2WCtz9sT9;
        Tue,  5 Apr 2022 14:12:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3CE778B77A;
        Tue,  5 Apr 2022 14:12:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2Ig34h1Zy_oY; Tue,  5 Apr 2022 14:12:17 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0EE148B776;
        Tue,  5 Apr 2022 14:12:17 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 235CCB1L352487
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 5 Apr 2022 14:12:11 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 235CCBZ4352486;
        Tue, 5 Apr 2022 14:12:11 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] powerpc/8xx: Convert CPM1 error interrupt handler to platform driver
Date:   Tue,  5 Apr 2022 14:12:01 +0200
Message-Id: <375a72df6e4a26c5959cc81a6c6d46152efa2306.1649160685.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <d3a7dc832d905bed14b35d83410cdb69a7ba20e8.1649160685.git.christophe.leroy@csgroup.eu>
References: <d3a7dc832d905bed14b35d83410cdb69a7ba20e8.1649160685.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1649160722; l=3256; s=20211009; h=from:subject:message-id; bh=iBfAM7j9zDFlEgqnwHTDh48Q3s/XSmi+wspQbzDZSEI=; b=Ofgaf1JdhrxOoLgHu6t1R08TjiE1ORUqWBGiAlfCCPyHbo4rxwMOfnJ2nvxTPyqlPtTEgtCiZuoa /i5ao+HlB6MKbQhuXzAV+XomDUHjAL9YoiRPmf69bSNbsew94Kq8
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPM error interrupt as a standalone platform driver,
to simplify the init of CPM interrupt handler.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/8xx/cpm1-ic.c | 73 +++++++++++++++++-----------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/cpm1-ic.c b/arch/powerpc/platforms/8xx/cpm1-ic.c
index d5cf0ee7c07d..d22b4fc2d4cf 100644
--- a/arch/powerpc/platforms/8xx/cpm1-ic.c
+++ b/arch/powerpc/platforms/8xx/cpm1-ic.c
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <asm/cpm1.h>
 
 static cpic8xx_t __iomem *cpic_reg;
@@ -67,17 +68,6 @@ static int cpm_pic_host_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-/*
- * The CPM can generate the error interrupt when there is a race condition
- * between generating and masking interrupts.  All we have to do is ACK it
- * and return.  This is a no-op function so we don't need any special
- * tests in the interrupt handler.
- */
-static irqreturn_t cpm_error_interrupt(int irq, void *dev)
-{
-	return IRQ_HANDLED;
-}
-
 static const struct irq_domain_ops cpm_pic_host_ops = {
 	.map = cpm_pic_host_map,
 };
@@ -86,7 +76,7 @@ unsigned int __init cpm_pic_init(void)
 {
 	struct device_node *np = NULL;
 	struct resource res;
-	unsigned int sirq = 0, hwirq, eirq;
+	unsigned int sirq = 0, hwirq;
 	int ret;
 
 	pr_debug("cpm_pic_init\n");
@@ -126,26 +116,51 @@ unsigned int __init cpm_pic_init(void)
 		goto end;
 	}
 
-	/* Install our own error handler. */
-	np = of_find_compatible_node(NULL, NULL, "fsl,cpm1");
-	if (np == NULL)
-		np = of_find_node_by_type(NULL, "cpm");
-	if (np == NULL) {
-		printk(KERN_ERR "CPM PIC init: can not find cpm node\n");
-		goto end;
-	}
-
-	eirq = irq_of_parse_and_map(np, 0);
-	if (!eirq)
-		goto end;
-
-	if (request_irq(eirq, cpm_error_interrupt, IRQF_NO_THREAD, "error",
-			NULL))
-		printk(KERN_ERR "Could not allocate CPM error IRQ!");
-
 	setbits32(&cpic_reg->cpic_cicr, CICR_IEN);
 
 end:
 	of_node_put(np);
 	return sirq;
 }
+
+/*
+ * The CPM can generate the error interrupt when there is a race condition
+ * between generating and masking interrupts.  All we have to do is ACK it
+ * and return.  This is a no-op function so we don't need any special
+ * tests in the interrupt handler.
+ */
+static irqreturn_t cpm_error_interrupt(int irq, void *dev)
+{
+	return IRQ_HANDLED;
+}
+
+static int cpm_error_probe(struct platform_device *pdev)
+{
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	return request_irq(irq, cpm_error_interrupt, IRQF_NO_THREAD, "error", NULL);
+}
+
+static const struct of_device_id cpm_error_ids[] = {
+	{ .compatible = "fsl,cpm1" },
+	{ .type = "cpm" },
+	{},
+};
+
+static struct platform_driver cpm_error_driver = {
+	.driver	= {
+		.name		= "cpm-error",
+		.of_match_table	= cpm_error_ids,
+	},
+	.probe	= cpm_error_probe,
+};
+
+static int __init cpm_error_init(void)
+{
+	return platform_driver_register(&cpm_error_driver);
+}
+subsys_initcall(cpm_error_init);
-- 
2.35.1


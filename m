Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503C94F5B21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiDFJxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbiDFJuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:50:39 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052424863A0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:24:00 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KYDwt4sB2z9sT7;
        Wed,  6 Apr 2022 08:23:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 50ACN8q_GpOR; Wed,  6 Apr 2022 08:23:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KYDwp5BVCz9sTC;
        Wed,  6 Apr 2022 08:23:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9BA4C8B776;
        Wed,  6 Apr 2022 08:23:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MdPgQrRTrO0q; Wed,  6 Apr 2022 08:23:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.200])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E0338B779;
        Wed,  6 Apr 2022 08:23:37 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2366NRgr390706
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 6 Apr 2022 08:23:27 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2366NRDH390705;
        Wed, 6 Apr 2022 08:23:27 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/5] powerpc/8xx: Use kmalloced data structure instead of global static
Date:   Wed,  6 Apr 2022 08:23:21 +0200
Message-Id: <c8f0866ee013113d5e28948943cf0586e49f5353.1649226186.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <d3a7dc832d905bed14b35d83410cdb69a7ba20e8.1649226186.git.christophe.leroy@csgroup.eu>
References: <d3a7dc832d905bed14b35d83410cdb69a7ba20e8.1649226186.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1649226200; l=4190; s=20211009; h=from:subject:message-id; bh=gbAm6QkVkPnZ9c9BYkFQVy/zbFCRmgtesziyGYwG0T8=; b=7tAnJYtkABQY90NQl2CUyeB25iRMMGXhQU4j2Vb31dr+qH1A1BcJP+hudSdZ0zuAr4bwIfT1eOqF FtupuI72CU1qN9gd+RN+PHTirbcXOlIWxLbYmSYB6aQhQ6OLgu8n
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

Use a kmalloced data structure to store interrupt controller internal
data instead of static global variables.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/8xx/cpm1-ic.c | 48 +++++++++++++++++-----------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/cpm1-ic.c b/arch/powerpc/platforms/8xx/cpm1-ic.c
index 6f9765597a6d..a18fc7c99f83 100644
--- a/arch/powerpc/platforms/8xx/cpm1-ic.c
+++ b/arch/powerpc/platforms/8xx/cpm1-ic.c
@@ -10,29 +10,33 @@
 #include <linux/platform_device.h>
 #include <asm/cpm1.h>
 
-static cpic8xx_t __iomem *cpic_reg;
-
-static struct irq_domain *cpm_pic_host;
+struct cpm_pic_data {
+	cpic8xx_t __iomem *reg;
+	struct irq_domain *host;
+};
 
 static void cpm_mask_irq(struct irq_data *d)
 {
+	struct cpm_pic_data *data = irq_data_get_irq_chip_data(d);
 	unsigned int cpm_vec = (unsigned int)irqd_to_hwirq(d);
 
-	clrbits32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
+	clrbits32(&data->reg->cpic_cimr, (1 << cpm_vec));
 }
 
 static void cpm_unmask_irq(struct irq_data *d)
 {
+	struct cpm_pic_data *data = irq_data_get_irq_chip_data(d);
 	unsigned int cpm_vec = (unsigned int)irqd_to_hwirq(d);
 
-	setbits32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
+	setbits32(&data->reg->cpic_cimr, (1 << cpm_vec));
 }
 
 static void cpm_end_irq(struct irq_data *d)
 {
+	struct cpm_pic_data *data = irq_data_get_irq_chip_data(d);
 	unsigned int cpm_vec = (unsigned int)irqd_to_hwirq(d);
 
-	out_be32(&cpic_reg->cpic_cisr, (1 << cpm_vec));
+	out_be32(&data->reg->cpic_cisr, (1 << cpm_vec));
 }
 
 static struct irq_chip cpm_pic = {
@@ -42,29 +46,31 @@ static struct irq_chip cpm_pic = {
 	.irq_eoi = cpm_end_irq,
 };
 
-static int cpm_get_irq(void)
+static int cpm_get_irq(struct irq_desc *desc)
 {
+	struct cpm_pic_data *data = irq_desc_get_handler_data(desc);
 	int cpm_vec;
 
 	/*
 	 * Get the vector by setting the ACK bit and then reading
 	 * the register.
 	 */
-	out_be16(&cpic_reg->cpic_civr, 1);
-	cpm_vec = in_be16(&cpic_reg->cpic_civr);
+	out_be16(&data->reg->cpic_civr, 1);
+	cpm_vec = in_be16(&data->reg->cpic_civr);
 	cpm_vec >>= 11;
 
-	return irq_linear_revmap(cpm_pic_host, cpm_vec);
+	return irq_linear_revmap(data->host, cpm_vec);
 }
 
 static void cpm_cascade(struct irq_desc *desc)
 {
-	generic_handle_irq(cpm_get_irq());
+	generic_handle_irq(cpm_get_irq(desc));
 }
 
 static int cpm_pic_host_map(struct irq_domain *h, unsigned int virq,
 			    irq_hw_number_t hw)
 {
+	irq_set_chip_data(virq, h->host_data);
 	irq_set_status_flags(virq, IRQ_LEVEL);
 	irq_set_chip_and_handler(virq, &cpm_pic, handle_fasteoi_irq);
 	return 0;
@@ -79,13 +85,18 @@ static int cpm_pic_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	int irq;
+	struct cpm_pic_data *data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
 
-	cpic_reg = devm_ioremap(dev, res->start, resource_size(res));
-	if (!cpic_reg)
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->reg = devm_ioremap(dev, res->start, resource_size(res));
+	if (!data->reg)
 		return -ENODEV;
 
 	irq = platform_get_irq(pdev, 0);
@@ -93,19 +104,20 @@ static int cpm_pic_probe(struct platform_device *pdev)
 		return irq;
 
 	/* Initialize the CPM interrupt controller. */
-	out_be32(&cpic_reg->cpic_cicr,
+	out_be32(&data->reg->cpic_cicr,
 		 (CICR_SCD_SCC4 | CICR_SCC_SCC3 | CICR_SCB_SCC2 | CICR_SCA_SCC1) |
 		 ((virq_to_hw(irq) / 2) << 13) | CICR_HP_MASK);
 
-	out_be32(&cpic_reg->cpic_cimr, 0);
+	out_be32(&data->reg->cpic_cimr, 0);
 
-	cpm_pic_host = irq_domain_add_linear(dev->of_node, 64, &cpm_pic_host_ops, NULL);
-	if (!cpm_pic_host)
+	data->host = irq_domain_add_linear(dev->of_node, 64, &cpm_pic_host_ops, data);
+	if (!data->host)
 		return -ENODEV;
 
+	irq_set_handler_data(irq, data);
 	irq_set_chained_handler(irq, cpm_cascade);
 
-	setbits32(&cpic_reg->cpic_cicr, CICR_IEN);
+	setbits32(&data->reg->cpic_cicr, CICR_IEN);
 
 	return 0;
 }
-- 
2.35.1


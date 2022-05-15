Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0284527539
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 05:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbiEODif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 23:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbiEODhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 23:37:31 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 471C163D7
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 20:37:28 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxYNppdYBiOpUWAA--.12697S8;
        Sun, 15 May 2022 11:37:23 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH RFC 06/10] irqchip/loongson-htvec: Add ACPI init support
Date:   Sun, 15 May 2022 11:37:09 +0800
Message-Id: <1652585833-22526-7-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1652585833-22526-1-git-send-email-lvjianmin@loongson.cn>
References: <1652585833-22526-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9BxYNppdYBiOpUWAA--.12697S8
X-Coremail-Antispam: 1UD129KBjvJXoW3AFWxCF47ZFWrCF4xZrWUJwb_yoW7XF1xpa
        y8CFWYqrWxJF17urn5Ca1DZryayryrGFW7Ja4fK3WSv3ZrJw1kGF18AF1jyF4fCFW8Za1Y
        gr4S9a15GF1UCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWx
        Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
        x0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
        JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUArcfUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are preparing to add new Loongson (based on LoongArch, not compatible
with old MIPS-based Loongson) support. LoongArch use ACPI other than DT
as its boot protocol, so add ACPI init support.

HTVECINTC stands for "HyperTransport Interrupts" that described in
Section 14.3 of "Loongson 3A5000 Processor Reference Manual". For more
information please refer Documentation/loongarch/irq-chip-model.rst.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/irqchip/irq-loongson-htvec.c | 121 +++++++++++++++++++++++++----------
 1 file changed, 87 insertions(+), 34 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 60a335d..354630b 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -16,11 +16,11 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include "irq-loongarch-pic-common.h"
 
 /* Registers */
 #define HTVEC_EN_OFF		0x20
 #define HTVEC_MAX_PARENT_IRQ	8
-
 #define VEC_COUNT_PER_REG	32
 #define VEC_REG_IDX(irq_id)	((irq_id) / VEC_COUNT_PER_REG)
 #define VEC_REG_BIT(irq_id)	((irq_id) % VEC_COUNT_PER_REG)
@@ -30,8 +30,11 @@ struct htvec {
 	void __iomem		*base;
 	struct irq_domain	*htvec_domain;
 	raw_spinlock_t		htvec_lock;
+	struct fwnode_handle	*domain_handle;
 };
 
+static struct htvec *htvec_priv;
+
 static void htvec_irq_dispatch(struct irq_desc *desc)
 {
 	int i;
@@ -155,64 +158,114 @@ static void htvec_reset(struct htvec *priv)
 	}
 }
 
-static int htvec_of_init(struct device_node *node,
-				struct device_node *parent)
+static int htvec_init(phys_addr_t addr, unsigned long size,
+		int num_parents, int parent_irq[], struct fwnode_handle *domain_handle)
 {
+	int i;
 	struct htvec *priv;
-	int err, parent_irq[8], i;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	priv->num_parents = num_parents;
+	priv->base = ioremap(addr, size);
+	priv->domain_handle = domain_handle;
 	raw_spin_lock_init(&priv->htvec_lock);
-	priv->base = of_iomap(node, 0);
-	if (!priv->base) {
-		err = -ENOMEM;
-		goto free_priv;
-	}
-
-	/* Interrupt may come from any of the 8 interrupt lines */
-	for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++) {
-		parent_irq[i] = irq_of_parse_and_map(node, i);
-		if (parent_irq[i] <= 0)
-			break;
-
-		priv->num_parents++;
-	}
 
-	if (!priv->num_parents) {
-		pr_err("Failed to get parent irqs\n");
-		err = -ENODEV;
-		goto iounmap_base;
-	}
-
-	priv->htvec_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+	/* Setup IRQ domain */
+	priv->htvec_domain = irq_domain_create_linear(priv->domain_handle,
 					(VEC_COUNT_PER_REG * priv->num_parents),
 					&htvec_domain_ops, priv);
 	if (!priv->htvec_domain) {
-		pr_err("Failed to create IRQ domain\n");
-		err = -ENOMEM;
-		goto irq_dispose;
+		pr_err("loongson-htvec: cannot add IRQ domain\n");
+		goto iounmap_base;
 	}
 
 	htvec_reset(priv);
 
-	for (i = 0; i < priv->num_parents; i++)
+	for (i = 0; i < priv->num_parents; i++) {
 		irq_set_chained_handler_and_data(parent_irq[i],
 						 htvec_irq_dispatch, priv);
+	}
+
+	htvec_priv = priv;
+
+	register_syscore_ops(&htvec_syscore_ops);
 
 	return 0;
 
-irq_dispose:
-	for (; i > 0; i--)
-		irq_dispose_mapping(parent_irq[i - 1]);
 iounmap_base:
 	iounmap(priv->base);
-free_priv:
+	priv->domain_handle = NULL;
 	kfree(priv);
 
-	return err;
+	return -EINVAL;
+}
+
+#ifdef CONFIG_OF
+
+static int htvec_of_init(struct device_node *node,
+				struct device_node *parent)
+{
+	int i, err;
+	int parent_irq[8];
+	int num_parents = 0;
+	struct resource res;
+
+	if (of_address_to_resource(node, 0, &res))
+		return -EINVAL;
+
+	/* Interrupt may come from any of the 8 interrupt lines */
+	for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++) {
+		parent_irq[i] = irq_of_parse_and_map(node, i);
+		if (parent_irq[i] <= 0)
+			break;
+
+		num_parents++;
+	}
+
+	err = htvec_init(res.start, resource_size(&res),
+			num_parents, parent_irq, of_node_to_fwnode(node));
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
 IRQCHIP_DECLARE(htvec, "loongson,htvec-1.0", htvec_of_init);
+
+#endif
+
+#ifdef CONFIG_ACPI
+int __init htvec_acpi_init(struct irq_domain *parent,
+				   struct acpi_madt_ht_pic *acpi_htvec)
+{
+	int i, ret;
+	int num_parents, parent_irq[8];
+	struct fwnode_handle *domain_handle;
+
+	if (!acpi_htvec)
+		return -EINVAL;
+
+	num_parents = HTVEC_MAX_PARENT_IRQ;
+
+	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_htvec);
+	if (!domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		return NULL;
+	}
+
+	/* Interrupt may come from any of the 8 interrupt lines */
+	for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++)
+		parent_irq[i] = irq_create_mapping(parent, acpi_htvec->cascade[i]);
+
+	ret = htvec_init(acpi_htvec->address, acpi_htvec->size,
+			num_parents, parent_irq, domain_handle);
+	if (ret == 0)
+		acpi_set_vector_parent(0, htvec_priv->htvec_domain);
+
+	return ret;
+}
+
+#endif
-- 
1.8.3.1


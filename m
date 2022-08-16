Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD6B595309
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiHPGvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiHPGvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:51:06 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78023107AF5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:01:40 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxReJ7+vpiKy8CAA--.12277S3;
        Tue, 16 Aug 2022 10:01:32 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V1 1/2] irqchip/loongson-pch-pic: Support to set irq type for ACPI path
Date:   Tue, 16 Aug 2022 10:01:30 +0800
Message-Id: <1660615291-35409-2-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1660615291-35409-1-git-send-email-lvjianmin@loongson.cn>
References: <1660615291-35409-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf8DxReJ7+vpiKy8CAA--.12277S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar47XF1xCF4UuF1xWrWDtwb_yoW8CrWxpF
        WYv3y3Aw4xJF17Cr95Cw48WFy3AwnxtFW7KF4Fy3W2grsrGrZYk3W7uFyrXrnrZF43AF42
        9rnYvFWUG3W7ZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkKb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAI
        w28IcVCjz48v1sIEY20_XrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU56c_D
        UUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ACPI path, the translate callback used IRQ_TYPE_NONE and ignored
the irq type in fwspec->param[1]. For supporting to set type for
irqs of the irqdomain, fwspec->param[1] should be used to get irq
type.

On Loongson platform, the irq trigger type of PCI devices is
high level, so high level triggered type is inputed to acpi_register_gsi
when create irq mapping for PCI devices.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/acpi/pci_irq.c                 |  3 ++-
 drivers/irqchip/irq-loongson-pch-pic.c | 10 ++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 08e1577..34483b3 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -393,7 +393,8 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 * controller and must therefore be considered active high
 	 * as default.
 	 */
-	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
+	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ||
+		       acpi_irq_model == ACPI_IRQ_MODEL_LPIC ?
 				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
 	char *link = NULL;
 	char link_desc[16];
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index b6f1392..5067010 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -177,13 +177,15 @@ static int pch_pic_domain_translate(struct irq_domain *d,
 	if (fwspec->param_count < 1)
 		return -EINVAL;
 
-	if (of_node) {
+	if (of_node)
 		*hwirq = fwspec->param[0] + priv->ht_vec_base;
-		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
-	} else {
+	else
 		*hwirq = fwspec->param[0] - priv->gsi_base;
+
+	if (fwspec->param_count > 1)
+		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+	else
 		*type = IRQ_TYPE_NONE;
-	}
 
 	return 0;
 }
-- 
1.8.3.1


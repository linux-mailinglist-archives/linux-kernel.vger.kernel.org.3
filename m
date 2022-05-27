Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2388535EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351199AbiE0LDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351185AbiE0LCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:02:51 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CAE1222BB
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:02:34 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Cxj+a3r5BiSRAEAA--.20871S6;
        Fri, 27 May 2022 19:02:30 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH RFC V2 04/10] irqchip/loongson-pch-pic: Add suspend/resume support
Date:   Fri, 27 May 2022 19:02:14 +0800
Message-Id: <1653649335-11998-5-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1653649335-11998-1-git-send-email-lvjianmin@loongson.cn>
References: <1653649335-11998-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9Cxj+a3r5BiSRAEAA--.20871S6
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1rCF4rKw47AFykJryUGFg_yoW5Ww15pa
        yUJwnxta1DGry7X3yruw4UZry3AFs7Z3yIga4Syr1furnrW3s2g3W8AF15tr48CanruFnr
        Xrs8Gr1j9a1UCaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUArcfUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend/resume support for PCH-PIC irqchip, which is needed for
suspend/hibernation.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/irqchip/irq-loongson-pch-pic.c | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index e3eb5c6..a88a40e 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/syscore_ops.h>
 #include "irq-loongarch-pic-common.h"
 
 /* Registers */
@@ -42,6 +43,9 @@ struct pch_pic {
 	struct fwnode_handle	*domain_handle;
 	u32			ht_vec_base;
 	raw_spinlock_t		pic_lock;
+	u32			saved_vec_en[PIC_REG_COUNT];
+	u32			saved_vec_pol[PIC_REG_COUNT];
+	u32			saved_vec_edge[PIC_REG_COUNT];
 	u32			gsi_end;
 	u32			gsi_base;
 };
@@ -145,6 +149,7 @@ static void pch_pic_ack_irq(struct irq_data *d)
 	.irq_ack		= pch_pic_ack_irq,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_set_type		= pch_pic_set_type,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
 static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
@@ -206,6 +211,46 @@ static void pch_pic_reset(struct pch_pic *priv)
 	}
 }
 
+static int pch_pic_suspend(void)
+{
+	int i, j;
+
+	for (i = 0; i < nr_pics; i++) {
+		for (j = 0; j < PIC_REG_COUNT; j++) {
+			pch_pic_priv[i]->saved_vec_pol[j] =
+				readl(pch_pic_priv[i]->base + PCH_PIC_POL + 4 * j);
+			pch_pic_priv[i]->saved_vec_edge[j] =
+				readl(pch_pic_priv[i]->base + PCH_PIC_EDGE + 4 * j);
+			pch_pic_priv[i]->saved_vec_en[j] =
+				readl(pch_pic_priv[i]->base + PCH_PIC_MASK + 4 * j);
+		}
+	}
+
+	return 0;
+}
+
+static void pch_pic_resume(void)
+{
+	int i, j;
+
+	for (i = 0; i < nr_pics; i++) {
+		pch_pic_reset(pch_pic_priv[i]);
+		for (j = 0; j < PIC_REG_COUNT; j++) {
+			writel(pch_pic_priv[i]->saved_vec_pol[j],
+					pch_pic_priv[i]->base + PCH_PIC_POL + 4 * j);
+			writel(pch_pic_priv[i]->saved_vec_edge[j],
+					pch_pic_priv[i]->base + PCH_PIC_EDGE + 4 * j);
+			writel(pch_pic_priv[i]->saved_vec_en[j],
+					pch_pic_priv[i]->base + PCH_PIC_MASK + 4 * j);
+		}
+	}
+}
+
+static struct syscore_ops pch_pic_syscore_ops = {
+	.suspend =  pch_pic_suspend,
+	.resume =  pch_pic_resume,
+};
+
 static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
 			struct irq_domain *parent_domain, struct fwnode_handle *domain_handle,
 			u32 gsi_base)
@@ -245,6 +290,8 @@ static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
 
 	register_syscore_ops(&pch_pic_syscore_ops);
 
+	register_syscore_ops(&pch_pic_syscore_ops);
+
 	return 0;
 
 iounmap_base:
-- 
1.8.3.1


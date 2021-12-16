Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3E747725C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhLPM5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:57:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56590 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbhLPM5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:57:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 198F2619DA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 12:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BE4C36AE3;
        Thu, 16 Dec 2021 12:57:41 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V8 03/10] irqchip/loongson-pch-pic: Add suspend/resume support
Date:   Thu, 16 Dec 2021 20:53:49 +0800
Message-Id: <20211216125356.632067-3-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211216125356.632067-1-chenhuacai@loongson.cn>
References: <20211216125157.631992-1-chenhuacai@loongson.cn>
 <20211216125356.632067-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend/resume support for PCH-PIC irqchip, which is needed for
suspend/hibernation.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-pch-pic.c | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index b0644d595789..5047ba96f7d7 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/syscore_ops.h>
 
 /* Registers */
 #define PCH_PIC_MASK		0x20
@@ -41,6 +42,9 @@ struct pch_pic {
 	struct fwnode_handle	*domain_handle;
 	u32			ht_vec_base;
 	raw_spinlock_t		pic_lock;
+	u32			saved_vec_en[PIC_REG_COUNT];
+	u32			saved_vec_pol[PIC_REG_COUNT];
+	u32			saved_vec_edge[PIC_REG_COUNT];
 };
 
 static struct pch_pic *pch_pic_priv[2];
@@ -142,6 +146,7 @@ static struct irq_chip pch_pic_irq_chip = {
 	.irq_ack		= pch_pic_ack_irq,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_set_type		= pch_pic_set_type,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
 static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
@@ -203,6 +208,46 @@ static void pch_pic_reset(struct pch_pic *priv)
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
 			struct irq_domain *parent_domain, struct fwnode_handle *domain_handle)
 {
@@ -235,6 +280,8 @@ static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
 	pch_pic_reset(priv);
 	pch_pic_priv[nr_pics++] = priv;
 
+	register_syscore_ops(&pch_pic_syscore_ops);
+
 	return 0;
 
 iounmap_base:
-- 
2.27.0


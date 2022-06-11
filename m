Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF39547415
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 13:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiFKLEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 07:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiFKLEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 07:04:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 465889E9E3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 04:04:06 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axz+aTdqRi5A85AA--.65423S7;
        Sat, 11 Jun 2022 19:04:00 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH RFC V3 05/11] irqchip: create library file for LoongArch irqchip driver
Date:   Sat, 11 Jun 2022 19:03:47 +0800
Message-Id: <1654945427-30763-6-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1654945427-30763-1-git-send-email-lvjianmin@loongson.cn>
References: <1654945427-30763-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9Axz+aTdqRi5A85AA--.65423S7
X-Coremail-Antispam: 1UD129KBjvJXoW3AFW7XrWUWFWUKF4xWw17Wrg_yoWxXryrpF
        W5Zw47tr48JrW2grn5Ca15ur1ayw1I9FWUtFWrG3WSqrs7GryvgF1vyasFvFyfJrWUWa47
        uFs8tF1Y93W5A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j
        6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
        IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
        xan2IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
        AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
        UjIFyTuYvjfUOBTYUUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The library file contains following content:
- Implement acpi_get_gsi_domain_id callback.
- Implement initialization of vector group entries and APIs
  for building hierachy irqdomains.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/irqchip/Makefile                   |   2 +-
 drivers/irqchip/irq-loongarch-pic-common.c | 122 +++++++++++++++++++++++++++++
 drivers/irqchip/irq-loongarch-pic-common.h |  39 +++++++++
 3 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100644 drivers/irqchip/irq-loongarch-pic-common.c
 create mode 100644 drivers/irqchip/irq-loongarch-pic-common.h

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 42724fc..433e91d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -105,7 +105,7 @@ obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
 obj-$(CONFIG_TI_PRUSS_INTC)		+= irq-pruss-intc.o
-obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o
+obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o irq-loongarch-pic-common.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
 obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
diff --git a/drivers/irqchip/irq-loongarch-pic-common.c b/drivers/irqchip/irq-loongarch-pic-common.c
new file mode 100644
index 0000000..2f75362
--- /dev/null
+++ b/drivers/irqchip/irq-loongarch-pic-common.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Loongson Limited, All Rights Reserved.
+ */
+
+#include <linux/irq.h>
+#include <linux/pci.h>
+#include <linux/acpi.h>
+#include "irq-loongarch-pic-common.h"
+
+static struct acpi_vector_group vector_group[MAX_IO_PICS];
+
+struct acpi_madt_bio_pic *acpi_pchpic[MAX_IO_PICS];
+
+struct fwnode_handle *liointc_handle;
+struct fwnode_handle *pch_lpc_handle;
+struct fwnode_handle *pch_msi_handle[MAX_IO_PICS];
+struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
+
+static int find_pch_pic(u32 gsi)
+{
+	int i, start, end;
+
+	/* Find the PCH_PIC that manages this GSI. */
+	for (i = 0; i < MAX_IO_PICS; i++) {
+		struct acpi_madt_bio_pic *irq_cfg = acpi_pchpic[i];
+
+		if (!irq_cfg)
+			return -1;
+
+		start = irq_cfg->gsi_base;
+		end   = irq_cfg->gsi_base + irq_cfg->size;
+		if (gsi >= start && gsi < end)
+			return i;
+	}
+
+	pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
+	return -1;
+}
+
+struct fwnode_handle *lpic_get_gsi_domain_id(u32 gsi)
+{
+	int id;
+	struct fwnode_handle *domain_handle = NULL;
+
+	switch (gsi) {
+	case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
+		if (liointc_handle)
+			domain_handle = liointc_handle;
+		break;
+
+	case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
+		if (pch_lpc_handle)
+			domain_handle = pch_lpc_handle;
+		break;
+
+	case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
+		id = find_pch_pic(gsi);
+		if (id >= 0 && pch_pic_handle[id])
+			domain_handle = pch_pic_handle[id];
+
+		break;
+	}
+
+	return domain_handle;
+}
+
+static int pci_mcfg_parse(struct acpi_table_header *header)
+{
+	struct acpi_table_mcfg *mcfg;
+	struct acpi_mcfg_allocation *mptr;
+	int i, n;
+
+	if (header->length < sizeof(struct acpi_table_mcfg))
+		return -EINVAL;
+
+	n = (header->length - sizeof(struct acpi_table_mcfg)) /
+					sizeof(struct acpi_mcfg_allocation);
+	mcfg = (struct acpi_table_mcfg *)header;
+	mptr = (struct acpi_mcfg_allocation *) &mcfg[1];
+
+	for (i = 0; i < n; i++, mptr++)
+		vector_group[mptr->pci_segment].node = (mptr->address >> 44) & 0xf;
+
+	return 0;
+}
+
+void __init init_vector_parent_group(void)
+{
+	acpi_table_parse(ACPI_SIG_MCFG, pci_mcfg_parse);
+}
+
+void acpi_set_vector_parent(int node, struct irq_domain *parent)
+{
+	int i;
+
+	if (cpu_has_flatmode)
+		node = cpu_to_node(node * CORES_PER_EIO_NODE);
+
+	for (i = 0; i < MAX_IO_PICS; i++) {
+		if (node == vector_group[i].node) {
+			vector_group[i].parent = parent;
+			return;
+		}
+	}
+}
+
+struct irq_domain *acpi_get_msi_parent(int index)
+{
+	return vector_group[index].parent;
+}
+
+struct irq_domain *acpi_get_pch_parent(int node)
+{
+	int i;
+
+	for (i = 0; i < MAX_IO_PICS; i++) {
+		if (node == vector_group[i].node)
+			return vector_group[i].parent;
+	}
+	return NULL;
+}
diff --git a/drivers/irqchip/irq-loongarch-pic-common.h b/drivers/irqchip/irq-loongarch-pic-common.h
new file mode 100644
index 0000000..3e068c3
--- /dev/null
+++ b/drivers/irqchip/irq-loongarch-pic-common.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022 Loongson Limited, All Rights Reserved.
+ */
+
+#ifndef _IRQ_LOONGARCH_PIC_COMMON_H
+#define _IRQ_LOONGARCH_PIC_COMMON_H
+
+#include <linux/of.h>
+#include <linux/irqdomain.h>
+
+struct acpi_vector_group {
+	int node;
+	struct irq_domain *parent;
+};
+
+/* IRQ number definitions */
+#define LOONGSON_LPC_IRQ_BASE		0
+#define LOONGSON_CPU_IRQ_BASE		16
+#define LOONGSON_PCH_IRQ_BASE		64
+
+#define GSI_MIN_LPC_IRQ		LOONGSON_LPC_IRQ_BASE
+#define GSI_MAX_LPC_IRQ		(LOONGSON_LPC_IRQ_BASE + 16 - 1)
+#define GSI_MIN_CPU_IRQ		LOONGSON_CPU_IRQ_BASE
+#define GSI_MAX_CPU_IRQ		(LOONGSON_CPU_IRQ_BASE + 48 - 1)
+#define GSI_MIN_PCH_IRQ		LOONGSON_PCH_IRQ_BASE
+#define GSI_MAX_PCH_IRQ		(LOONGSON_PCH_IRQ_BASE + 256 - 1)
+
+int liointc_acpi_init(struct irq_domain *parent, struct acpi_madt_lio_pic *acpi_liointc);
+int eiointc_acpi_init(struct irq_domain *parent, struct acpi_madt_eio_pic *acpi_eiointc);
+int htvec_acpi_init(struct irq_domain *parent, struct acpi_madt_ht_pic *acpi_htvec);
+int pch_lpc_acpi_init(struct irq_domain *parent, struct acpi_madt_lpc_pic *acpi_pchlpc);
+struct fwnode_handle *lpic_get_gsi_domain_id(u32 gsi);
+void init_vector_parent_group(void);
+void acpi_set_vector_parent(int node, struct irq_domain *parent);
+struct irq_domain *acpi_get_msi_parent(int index);
+struct irq_domain *acpi_get_pch_parent(int node);
+
+#endif /* _IRQ_LOONGARCH_PIC_COMMON_H */
-- 
1.8.3.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129DB578517
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiGROO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiGRON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:13:59 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 721BEE0F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:13:55 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_9GWatViBtEmAA--.33569S13;
        Mon, 18 Jul 2022 22:13:47 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V16 11/14] LoongArch: prepare to support multiple pch-pic and pch-msi irqdomain
Date:   Mon, 18 Jul 2022 22:13:38 +0800
Message-Id: <1658153621-40445-12-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn>
References: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9Dx_9GWatViBtEmAA--.33569S13
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4Duw18AF4fXr4rGw13CFg_yoW5ZF1rpF
        9xu3Z8tr45GryxWryfta15Wr4rGas7Ca12qa13ua43Kr1xWryvqF4vyr9ruFy5ta1rAa4I
        qa13tFW5ur4DA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF
        04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
        JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
        XdbUUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For systems with two chipsets, there are two related pch-pic and
pch-msi irqdomains, each of which has the same node id as its
parent irqdomain. So we use a structure to mantain the relation
of node and it's parent irqdomain as pch irqdomin, the 'pci_segment'
field is only used to match the pci segment of a pci device when
setting msi irqdomain for the device.

struct acpi_vector_group {
        int node;
        int pci_segment;
        struct irq_domain *parent;
};

The field 'pci_segment' and 'node' are initialized from MCFG, and
the parent irqdomain driver will set field 'parent' by matching same
'node'.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 arch/loongarch/include/asm/irq.h |  8 ++++++++
 arch/loongarch/kernel/irq.c      | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index de8af43..c847300 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -48,6 +48,14 @@ static inline bool on_irq_stack(int cpu, unsigned long sp)
 #define MAX_IO_PICS 2
 #define NR_IRQS	(64 + (256 * MAX_IO_PICS))
 
+struct acpi_vector_group {
+	int node;
+	int pci_segment;
+	struct irq_domain *parent;
+};
+extern struct acpi_vector_group pch_group[MAX_IO_PICS];
+extern struct acpi_vector_group msi_group[MAX_IO_PICS];
+
 #define CORES_PER_EIO_NODE	4
 
 #define LOONGSON_CPU_UART0_VEC		10 /* CPU UART0 */
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index b04201c..06f2a15 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -26,6 +26,8 @@
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
 struct irq_domain *cpu_domain;
+struct acpi_vector_group pch_group[MAX_IO_PICS];
+struct acpi_vector_group msi_group[MAX_IO_PICS];
 
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
@@ -52,6 +54,41 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	return 0;
 }
 
+static int __init early_pci_mcfg_parse(struct acpi_table_header *header)
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
+	for (i = 0; i < n; i++, mptr++) {
+		msi_group[i].pci_segment = mptr->pci_segment;
+		pch_group[i].node = msi_group[i].node = (mptr->address >> 44) & 0xf;
+	}
+
+	return 0;
+}
+
+static void __init init_vec_parent_group(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_IO_PICS; i++) {
+		msi_group[i].pci_segment = -1;
+		msi_group[i].node = -1;
+		pch_group[i].node = -1;
+	}
+
+	acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
+}
+
 void __init init_IRQ(void)
 {
 	int i;
@@ -65,6 +102,7 @@ void __init init_IRQ(void)
 	clear_csr_ecfg(ECFG0_IM);
 	clear_csr_estat(ESTATF_IP);
 
+	init_vec_parent_group();
 	irqchip_init();
 #ifdef CONFIG_SMP
 	ipi_irq = EXCCODE_IPI - EXCCODE_INT_START;
-- 
1.8.3.1


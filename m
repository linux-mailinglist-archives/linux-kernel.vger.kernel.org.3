Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A76B575C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiGOHHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiGOHGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:06:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B97DB73919
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:06:08 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxWeDQEdFiyyogAA--.1717S14;
        Fri, 15 Jul 2022 15:06:02 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V15 12/15] LoongArch: prepare to support multiple pch-pic and pch-msi irqdomain
Date:   Fri, 15 Jul 2022 15:05:48 +0800
Message-Id: <1657868751-30444-13-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
References: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9AxWeDQEdFiyyogAA--.1717S14
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4Duw18AF4fXr4rGw13CFg_yoW5ZF1rpF
        9xu3Z8tr45GryxWryfta15Wr4rGas7Ca12qa13Ca43Kr1xWryvqF4vyr9ruFy5ta1rAa4I
        qa13tFW5ur4DA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l
        42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
        6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
        fUoOJ5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index b4c7956..a07315a 100644
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


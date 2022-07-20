Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3938957B565
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbiGTL2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbiGTL1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:27:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212565465C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:27:38 -0700 (PDT)
Date:   Wed, 20 Jul 2022 11:27:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658316456;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7WY1EL4ELvdohD9t07PDZ7/O9iuNsa4U3p9mfl1wduI=;
        b=SvXqRFwUjWrpV4SMD33aKviTS/VfN+YQ04G/yQ4/KC813n4MFoOkh9KOfSD1TuUHiQ5MpE
        UJ26V4dM1CLtKTn3Vw9Zcg7gZBOsh0HDuADFU5BSqkYJuPmjuagq4HIBNJJDNkWLgjrUg6
        BKmjLq39mnQ629myQJhkTBYWkLpboOQdgN4nq8G8sj4VAs3O+r9WuT/+dMFaJgPI0T1ngK
        LaK+/IkUgtfKkk5vb0bOozFkJE/sA/GAhm6Jcm8IVFB0fBHm4g2WIX2dJfpEKeDpXba97P
        q8DjwotJBo2bvIbo2Ep1OwYy7h5YQWnGAy0d+YA+Z0mnm9iZ7UbJVKm0ygamAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658316456;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7WY1EL4ELvdohD9t07PDZ7/O9iuNsa4U3p9mfl1wduI=;
        b=yBFXTIQGIYsl0JtvlskrcU5uIIQf4wp1NxEBS8UTAzVHzjkKOCGM4ik4i8lyZ10OyfYg+Y
        asYG+BfTAJ46ZWCQ==
From:   "irqchip-bot for Jianmin Lv" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] LoongArch: Prepare to support multiple
 pch-pic and pch-msi irqdomain
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <1658314292-35346-7-git-send-email-lvjianmin@loongson.cn>
References: <1658314292-35346-7-git-send-email-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <165831645556.15455.15737204434612577341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     2dfded47da329a0dd619144a6bb43aefc13a77ba
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/2dfded47da329a0dd619144a6bb43aefc13a77ba
Author:        Jianmin Lv <lvjianmin@loongson.cn>
AuthorDate:    Wed, 20 Jul 2022 18:51:25 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Jul 2022 12:09:20 +01:00

LoongArch: Prepare to support multiple pch-pic and pch-msi irqdomain

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
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1658314292-35346-7-git-send-email-lvjianmin@loongson.cn
---
 arch/loongarch/include/asm/irq.h |  8 +++++++-
 arch/loongarch/kernel/irq.c      | 38 +++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+)

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index ace3ea6..a2540d7 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -48,6 +48,14 @@ void arch_trigger_cpumask_backtrace(const struct cpumask *mask, bool exclude_sel
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
index b34b8d7..37dd2dc 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -31,6 +31,8 @@ struct irq_domain *pch_lpc_domain;
 struct irq_domain *pch_msi_domain[MAX_IO_PICS];
 struct irq_domain *pch_pic_domain[MAX_IO_PICS];
 
+struct acpi_vector_group pch_group[MAX_IO_PICS];
+struct acpi_vector_group msi_group[MAX_IO_PICS];
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
  * each architecture has to answer this themselves.
@@ -56,6 +58,41 @@ int arch_show_interrupts(struct seq_file *p, int prec)
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
@@ -69,6 +106,7 @@ void __init init_IRQ(void)
 	clear_csr_ecfg(ECFG0_IM);
 	clear_csr_estat(ESTATF_IP);
 
+	init_vec_parent_group();
 	irqchip_init();
 #ifdef CONFIG_SMP
 	ipi_irq = EXCCODE_IPI - EXCCODE_INT_START;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6AB55C929
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbiF0MAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbiF0Lwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:52:51 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7ACB4DF20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:46:35 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx39kNl7liP_FfAA--.6156S9;
        Mon, 27 Jun 2022 19:40:03 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V13 07/13] irqchip/loongson-pch-msi: Add ACPI init support
Date:   Mon, 27 Jun 2022 19:39:51 +0800
Message-Id: <1656329997-20524-8-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656329997-20524-1-git-send-email-lvjianmin@loongson.cn>
References: <1656329997-20524-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9Dx39kNl7liP_FfAA--.6156S9
X-Coremail-Antispam: 1UD129KBjvJXoWfXr1rKw17KFyUAr1DJw1fJFb_yoWDZw4UpF
        W3Z39Fqr48J3yUWrWvka1DXrWayFySkF42qa1fG3WftrsFyr9YgF18JF129F1YyrWUGF13
        Zw4xta1UuF4DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF
        04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
        JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoO
        J5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

We are preparing to add new Loongson (based on LoongArch, not compatible
with old MIPS-based Loongson) support. LoongArch use ACPI other than DT
as its boot protocol, so add ACPI init support.

PCH-PIC/PCH-MSI stands for "Interrupt Controller" that described in
Section 5 of "Loongson 7A1000 Bridge User Manual". For more information
please refer Documentation/loongarch/irq-chip-model.rst.

For systems with two chipsets, there are two related msi irqdomains,
each of which has the same node id as its parent irqdomain. So we
use a structure to mantain the relation of node and it's parent
irqdomain as pch irqdomin, and add a pci_segment field to it for
matching the pci segment of a pci device when setting msi irqdomain
for the device.

struct acpi_vector_group {
        int node;
        int pci_segment;
        struct irq_domain *parent;
};

The field 'pci_segment' and 'node' are initialized from MCFG, and
the parent irqdomain will set field 'parent' by matching same
'node'.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/irq.h       |   7 +-
 arch/loongarch/kernel/irq.c            |  30 ++++++-
 drivers/irqchip/irq-loongson-pch-msi.c | 147 +++++++++++++++++++++++----------
 3 files changed, 138 insertions(+), 46 deletions(-)

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index a444dc6..367aa44 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -50,9 +50,11 @@ static inline bool on_irq_stack(int cpu, unsigned long sp)
 
 struct acpi_vector_group {
 	int node;
+	int pci_segment;
 	struct irq_domain *parent;
 };
 extern struct acpi_vector_group pch_group[MAX_IO_PICS];
+extern struct acpi_vector_group msi_group[MAX_IO_PICS];
 
 #define CORES_PER_EIO_NODE	4
 
@@ -112,9 +114,8 @@ struct irq_domain *htvec_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_ht_pic *acpi_htvec);
 int pch_lpc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lpc_pic *acpi_pchlpc);
-struct irq_domain *pch_msi_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_msi_pic *acpi_pchmsi);
 int find_pch_pic(u32 gsi);
+struct fwnode_handle *get_pch_msi_handle(int pci_segment);
 
 extern struct acpi_madt_lio_pic *acpi_liointc;
 extern struct acpi_madt_eio_pic *acpi_eiointc[MAX_IO_PICS];
@@ -127,7 +128,7 @@ struct irq_domain *pch_msi_acpi_init(struct irq_domain *parent,
 extern struct irq_domain *cpu_domain;
 extern struct irq_domain *liointc_domain;
 extern struct fwnode_handle *pch_lpc_handle;
-extern struct irq_domain *pch_msi_domain[MAX_IO_PICS];
+extern struct fwnode_handle *pch_msi_handle[MAX_IO_PICS];
 extern struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
 
 extern irqreturn_t loongson3_ipi_interrupt(int irq, void *dev);
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index f2115be..82bc6c7 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -27,8 +27,8 @@
 
 struct irq_domain *cpu_domain;
 struct irq_domain *liointc_domain;
-struct irq_domain *pch_msi_domain[MAX_IO_PICS];
 struct acpi_vector_group pch_group[MAX_IO_PICS];
+struct acpi_vector_group msi_group[MAX_IO_PICS];
 
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
@@ -55,6 +55,33 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	return 0;
 }
 
+static int early_pci_mcfg_parse(struct acpi_table_header *header)
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
+		msi_group[i].node = (mptr->address >> 44) & 0xf;
+	}
+
+	return 0;
+}
+
+void __init init_msi_parent_group(void)
+{
+	acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
+}
+
 void __init init_IRQ(void)
 {
 	int i;
@@ -68,6 +95,7 @@ void __init init_IRQ(void)
 	clear_csr_ecfg(ECFG0_IM);
 	clear_csr_estat(ESTATF_IP);
 
+	init_msi_parent_group();
 	irqchip_init();
 #ifdef CONFIG_SMP
 	ipi_irq = EXCCODE_IPI - EXCCODE_INT_START;
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index e3801c4..5db4a68 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -15,14 +15,30 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 
+static int nr_pics;
+
 struct pch_msi_data {
 	struct mutex	msi_map_lock;
 	phys_addr_t	doorbell;
 	u32		irq_first;	/* The vector number that MSIs starts */
 	u32		num_irqs;	/* The number of vectors for MSIs */
 	unsigned long	*msi_map;
+	struct fwnode_handle *domain_handle;
 };
 
+static struct pch_msi_data *pch_msi_priv[2];
+
+struct fwnode_handle *get_pch_msi_handle(int pci_segment)
+{
+	int i;
+
+	for (i = 0; i < MAX_IO_PICS; i++) {
+		if (msi_group[i].pci_segment == pci_segment)
+			return pch_msi_priv[i]->domain_handle;
+	}
+	return NULL;
+}
+
 static void pch_msi_mask_msi_irq(struct irq_data *d)
 {
 	pci_msi_mask_irq(d);
@@ -154,12 +170,14 @@ static void pch_msi_middle_domain_free(struct irq_domain *domain,
 };
 
 static int pch_msi_init_domains(struct pch_msi_data *priv,
-				struct device_node *node,
-				struct irq_domain *parent)
+				struct irq_domain *parent,
+				struct fwnode_handle *domain_handle)
 {
 	struct irq_domain *middle_domain, *msi_domain;
 
-	middle_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+	priv->domain_handle = domain_handle;
+
+	middle_domain = irq_domain_create_linear(priv->domain_handle,
 						priv->num_irqs,
 						&pch_msi_middle_domain_ops,
 						priv);
@@ -171,7 +189,7 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
 	middle_domain->parent = parent;
 	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
 
-	msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
+	msi_domain = pci_msi_create_irq_domain(priv->domain_handle,
 					       &pch_msi_domain_info,
 					       middle_domain);
 	if (!msi_domain) {
@@ -183,19 +201,11 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
 	return 0;
 }
 
-static int pch_msi_init(struct device_node *node,
-			    struct device_node *parent)
+static int pch_msi_init(phys_addr_t msg_address, int irq_base, int irq_count,
+			struct irq_domain *parent_domain, struct fwnode_handle *domain_handle)
 {
-	struct pch_msi_data *priv;
-	struct irq_domain *parent_domain;
-	struct resource res;
 	int ret;
-
-	parent_domain = irq_find_host(parent);
-	if (!parent_domain) {
-		pr_err("Failed to find the parent domain\n");
-		return -ENXIO;
-	}
+	struct pch_msi_data *priv;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -203,48 +213,101 @@ static int pch_msi_init(struct device_node *node,
 
 	mutex_init(&priv->msi_map_lock);
 
-	ret = of_address_to_resource(node, 0, &res);
-	if (ret) {
-		pr_err("Failed to allocate resource\n");
-		goto err_priv;
-	}
-
-	priv->doorbell = res.start;
-
-	if (of_property_read_u32(node, "loongson,msi-base-vec",
-				&priv->irq_first)) {
-		pr_err("Unable to parse MSI vec base\n");
-		ret = -EINVAL;
-		goto err_priv;
-	}
-
-	if (of_property_read_u32(node, "loongson,msi-num-vecs",
-				&priv->num_irqs)) {
-		pr_err("Unable to parse MSI vec number\n");
-		ret = -EINVAL;
-		goto err_priv;
-	}
+	priv->doorbell = msg_address;
+	priv->irq_first = irq_base;
+	priv->num_irqs = irq_count;
 
 	priv->msi_map = bitmap_zalloc(priv->num_irqs, GFP_KERNEL);
-	if (!priv->msi_map) {
-		ret = -ENOMEM;
+	if (!priv->msi_map)
 		goto err_priv;
-	}
 
 	pr_debug("Registering %d MSIs, starting at %d\n",
 		 priv->num_irqs, priv->irq_first);
 
-	ret = pch_msi_init_domains(priv, node, parent_domain);
+	ret = pch_msi_init_domains(priv, parent_domain, domain_handle);
 	if (ret)
 		goto err_map;
 
+	pch_msi_priv[nr_pics++] = priv;
 	return 0;
 
 err_map:
 	bitmap_free(priv->msi_map);
 err_priv:
 	kfree(priv);
-	return ret;
+
+	return -EINVAL;
 }
 
-IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_init);
+#ifdef CONFIG_OF
+
+static int pch_msi_of_init(struct device_node *node, struct device_node *parent)
+{
+	int err;
+	int irq_base, irq_count;
+	struct resource res;
+	struct irq_domain *parent_domain;
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("Failed to find the parent domain\n");
+		return -ENXIO;
+	}
+
+	if (of_address_to_resource(node, 0, &res)) {
+		pr_err("Failed to allocate resource\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "loongson,msi-base-vec", &irq_base)) {
+		pr_err("Unable to parse MSI vec base\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "loongson,msi-num-vecs", &irq_count)) {
+		pr_err("Unable to parse MSI vec number\n");
+		return -EINVAL;
+	}
+
+	err = pch_msi_init(res.start, irq_base, irq_count, parent_domain, of_node_to_fwnode(node));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_of_init);
+
+#endif
+
+#ifdef CONFIG_ACPI
+int __init pch_msi_init_irqdomain(struct irq_domain *parent,
+					struct acpi_madt_msi_pic *acpi_pchmsi)
+{
+	struct fwnode_handle *domain_handle;
+
+	if (!acpi_pchmsi)
+		return -EINVAL;
+
+	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchmsi);
+
+	return pch_msi_init(acpi_pchmsi->msg_address, acpi_pchmsi->start,
+				acpi_pchmsi->count, parent, domain_handle);
+}
+static int __init msiintc_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_msi_pic *pch_msi_entry = (struct acpi_madt_msi_pic *)header;
+
+	return pch_msi_init_irqdomain(msi_group[nr_pics].parent, pch_msi_entry);
+}
+
+static int __init pch_msi_acpi_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC,
+			      msiintc_parse_madt, 0);
+
+	return 0;
+}
+early_initcall(pch_msi_acpi_init);
+#endif
-- 
1.8.3.1


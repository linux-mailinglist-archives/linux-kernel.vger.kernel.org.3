Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9AF55CE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbiF0LvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbiF0LsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:48:11 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61F06F586
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:40:11 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx39kNl7liP_FfAA--.6156S3;
        Mon, 27 Jun 2022 19:40:01 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V13 01/13] APCI: irq: Add support for multiple GSI domains
Date:   Mon, 27 Jun 2022 19:39:45 +0800
Message-Id: <1656329997-20524-2-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656329997-20524-1-git-send-email-lvjianmin@loongson.cn>
References: <1656329997-20524-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9Dx39kNl7liP_FfAA--.6156S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4kJw48ZFW8WF1kXF4rGrg_yoWfCFWUpF
        W3try7ur47tF1jgFW8Ca15Za4akr10yw42qayrG3srKw4qgF9xKFn7Ca4akFy5AFW5Xa1U
        Zr1aqa18CF1DAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF
        04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

In an unfortunate departure from the ACPI spec, the LoongArch
architecture split its GSI space across multiple interrupt
controllers.

In order to be able to reuse sthe core code and prevent
architectures from reinventing an already square wheel, offer
the arch code the ability to register a dispatcher function
that will return the domain fwnode for a given GSI.

The ARM GIC drivers are updated to support this (with a single
domain, as intended).

Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/acpi/irq.c           | 40 +++++++++++++++++++++++++---------------
 drivers/irqchip/irq-gic-v3.c | 18 ++++++++++++------
 drivers/irqchip/irq-gic.c    | 18 ++++++++++++------
 include/linux/acpi.h         |  2 +-
 4 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index c68e694..f0de768 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -12,7 +12,7 @@
 
 enum acpi_irq_model_id acpi_irq_model;
 
-static struct fwnode_handle *acpi_gsi_domain_id;
+static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
 
 /**
  * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
@@ -26,9 +26,10 @@
  */
 int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 {
-	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
-							DOMAIN_BUS_ANY);
+	struct irq_domain *d;
 
+	d = irq_find_matching_fwnode(acpi_get_gsi_domain_id(gsi),
+					DOMAIN_BUS_ANY);
 	*irq = irq_find_mapping(d, gsi);
 	/*
 	 * *irq == 0 means no mapping, that should
@@ -53,12 +54,12 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 {
 	struct irq_fwspec fwspec;
 
-	if (WARN_ON(!acpi_gsi_domain_id)) {
+	fwspec.fwnode = acpi_get_gsi_domain_id(gsi);
+	if (WARN_ON(!fwspec.fwnode)) {
 		pr_warn("GSI: No registered irqchip, giving up\n");
 		return -EINVAL;
 	}
 
-	fwspec.fwnode = acpi_gsi_domain_id;
 	fwspec.param[0] = gsi;
 	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
 	fwspec.param_count = 2;
@@ -73,13 +74,14 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
  */
 void acpi_unregister_gsi(u32 gsi)
 {
-	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
-							DOMAIN_BUS_ANY);
+	struct irq_domain *d;
 	int irq;
 
 	if (WARN_ON(acpi_irq_model == ACPI_IRQ_MODEL_GIC && gsi < 16))
 		return;
 
+	d = irq_find_matching_fwnode(acpi_get_gsi_domain_id(gsi),
+				     DOMAIN_BUS_ANY);
 	irq = irq_find_mapping(d, gsi);
 	irq_dispose_mapping(irq);
 }
@@ -97,7 +99,8 @@ void acpi_unregister_gsi(u32 gsi)
  * The referenced device fwhandle or NULL on failure
  */
 static struct fwnode_handle *
-acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source)
+acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source,
+			     u32 gsi)
 {
 	struct fwnode_handle *result;
 	struct acpi_device *device;
@@ -105,7 +108,7 @@ void acpi_unregister_gsi(u32 gsi)
 	acpi_status status;
 
 	if (!source->string_length)
-		return acpi_gsi_domain_id;
+		return acpi_get_gsi_domain_id(gsi);
 
 	status = acpi_get_handle(NULL, source->string_ptr, &handle);
 	if (WARN_ON(ACPI_FAILURE(status)))
@@ -194,7 +197,7 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
 			ctx->index -= irq->interrupt_count;
 			return AE_OK;
 		}
-		fwnode = acpi_gsi_domain_id;
+		fwnode = acpi_get_gsi_domain_id(irq->interrupts[ctx->index]);
 		acpi_irq_parse_one_match(fwnode, irq->interrupts[ctx->index],
 					 irq->triggering, irq->polarity,
 					 irq->shareable, ctx);
@@ -207,7 +210,8 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
 			ctx->index -= eirq->interrupt_count;
 			return AE_OK;
 		}
-		fwnode = acpi_get_irq_source_fwhandle(&eirq->resource_source);
+		fwnode = acpi_get_irq_source_fwhandle(&eirq->resource_source,
+						      eirq->interrupts[ctx->index]);
 		acpi_irq_parse_one_match(fwnode, eirq->interrupts[ctx->index],
 					 eirq->triggering, eirq->polarity,
 					 eirq->shareable, ctx);
@@ -291,10 +295,10 @@ int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res)
  *          GSI interrupts
  */
 void __init acpi_set_irq_model(enum acpi_irq_model_id model,
-			       struct fwnode_handle *fwnode)
+			       struct fwnode_handle *(*fn)(u32))
 {
 	acpi_irq_model = model;
-	acpi_gsi_domain_id = fwnode;
+	acpi_get_gsi_domain_id = fn;
 }
 
 /**
@@ -312,8 +316,14 @@ struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
 					     const struct irq_domain_ops *ops,
 					     void *host_data)
 {
-	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
-							DOMAIN_BUS_ANY);
+	struct irq_domain *d;
+
+	/* This only works for the GIC model... */
+	if (acpi_irq_model != ACPI_IRQ_MODEL_GIC)
+		return NULL;
+
+	d = irq_find_matching_fwnode(acpi_get_gsi_domain_id(0),
+				     DOMAIN_BUS_ANY);
 
 	if (!d)
 		return NULL;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5c1cf90..c664703 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2360,11 +2360,17 @@ static void __init gic_acpi_setup_kvm_info(void)
 	vgic_set_kvm_info(&gic_v3_kvm_info);
 }
 
+static struct fwnode_handle *gsi_domain_handle;
+
+static struct fwnode_handle *gic_v3_get_gsi_domain_id(u32 gsi)
+{
+	return gsi_domain_handle;
+}
+
 static int __init
 gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
 {
 	struct acpi_madt_generic_distributor *dist;
-	struct fwnode_handle *domain_handle;
 	size_t size;
 	int i, err;
 
@@ -2396,18 +2402,18 @@ static void __init gic_acpi_setup_kvm_info(void)
 	if (err)
 		goto out_redist_unmap;
 
-	domain_handle = irq_domain_alloc_fwnode(&dist->base_address);
-	if (!domain_handle) {
+	gsi_domain_handle = irq_domain_alloc_fwnode(&dist->base_address);
+	if (!gsi_domain_handle) {
 		err = -ENOMEM;
 		goto out_redist_unmap;
 	}
 
 	err = gic_init_bases(acpi_data.dist_base, acpi_data.redist_regs,
-			     acpi_data.nr_redist_regions, 0, domain_handle);
+			     acpi_data.nr_redist_regions, 0, gsi_domain_handle);
 	if (err)
 		goto out_fwhandle_free;
 
-	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
+	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, gic_v3_get_gsi_domain_id);
 
 	if (static_branch_likely(&supports_deactivate_key))
 		gic_acpi_setup_kvm_info();
@@ -2415,7 +2421,7 @@ static void __init gic_acpi_setup_kvm_info(void)
 	return 0;
 
 out_fwhandle_free:
-	irq_domain_free_fwnode(domain_handle);
+	irq_domain_free_fwnode(gsi_domain_handle);
 out_redist_unmap:
 	for (i = 0; i < acpi_data.nr_redist_regions; i++)
 		if (acpi_data.redist_regs[i].redist_base)
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 820404c..4c7bae0 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1682,11 +1682,17 @@ static void __init gic_acpi_setup_kvm_info(void)
 	vgic_set_kvm_info(&gic_v2_kvm_info);
 }
 
+static struct fwnode_handle *gsi_domain_handle;
+
+static struct fwnode_handle *gic_v2_get_gsi_domain_id(u32 gsi)
+{
+	return gsi_domain_handle;
+}
+
 static int __init gic_v2_acpi_init(union acpi_subtable_headers *header,
 				   const unsigned long end)
 {
 	struct acpi_madt_generic_distributor *dist;
-	struct fwnode_handle *domain_handle;
 	struct gic_chip_data *gic = &gic_data[0];
 	int count, ret;
 
@@ -1724,22 +1730,22 @@ static int __init gic_v2_acpi_init(union acpi_subtable_headers *header,
 	/*
 	 * Initialize GIC instance zero (no multi-GIC support).
 	 */
-	domain_handle = irq_domain_alloc_fwnode(&dist->base_address);
-	if (!domain_handle) {
+	gsi_domain_handle = irq_domain_alloc_fwnode(&dist->base_address);
+	if (!gsi_domain_handle) {
 		pr_err("Unable to allocate domain handle\n");
 		gic_teardown(gic);
 		return -ENOMEM;
 	}
 
-	ret = __gic_init_bases(gic, domain_handle);
+	ret = __gic_init_bases(gic, gsi_domain_handle);
 	if (ret) {
 		pr_err("Failed to initialise GIC\n");
-		irq_domain_free_fwnode(domain_handle);
+		irq_domain_free_fwnode(gsi_domain_handle);
 		gic_teardown(gic);
 		return ret;
 	}
 
-	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
+	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, gic_v2_get_gsi_domain_id);
 
 	if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
 		gicv2m_init(NULL, gic_data[0].domain);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4f82a5b..957e23f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -356,7 +356,7 @@ static inline bool acpi_sci_irq_valid(void)
 int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
 
 void acpi_set_irq_model(enum acpi_irq_model_id model,
-			struct fwnode_handle *fwnode);
+			struct fwnode_handle *(*)(u32));
 
 struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
 					     unsigned int size,
-- 
1.8.3.1


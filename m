Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E87C54E257
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377236AbiFPNq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376829AbiFPNq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:46:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD4EE37A09
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:46:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84B2711FB;
        Thu, 16 Jun 2022 06:46:55 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A08C63F7F5;
        Thu, 16 Jun 2022 06:46:54 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     maz@kernel.org, tglx@linutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH] irqchip/gicv3: Handle resource request failure consistently
Date:   Thu, 16 Jun 2022 14:46:46 +0100
Message-Id: <5f2b57a0131f3082fae9d3002d360bf784ccb092.1655387206.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a silly oversight on my part, making the simple switch to
of_io_request_and_map() in the DT path inadvertently introduced
divergent behaviour, whereby failng to request an iomem region now
becomes fatal for DT, vs. being silently ignored for ACPI.

Refactor a bit harder, so that request errors are non-fatal in both
paths as intended, but also consistently reported as well.

Reported-by: Matt Ranostay <mranostay@ti.com>
Fixes: 2b2cd74a06c3 ("irqchip/gic-v3: Claim iomem resources")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 41 +++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 2be8dea6b6b0..8c51c559f095 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2039,15 +2039,40 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
 	vgic_set_kvm_info(&gic_v3_kvm_info);
 }
 
+static void gic_request_region(resource_size_t base, resource_size_t size,
+			       const char *name)
+{
+	if (!request_mem_region(base, size, name))
+		pr_warn_once(FW_BUG "%s region %pa has overlapping address\n",
+			     name, &base);
+}
+
+static void __iomem *gic_of_iomap(struct device_node *node, int idx,
+				  const char *name, struct resource *res)
+{
+	void __iomem *base;
+	int ret;
+
+	ret = of_address_to_resource(node, idx, res);
+	if (ret)
+		return IOMEM_ERR_PTR(ret);
+
+	gic_request_region(res->start, resource_size(res), name);
+	base = of_iomap(node, idx);
+
+	return base ?: IOMEM_ERR_PTR(-ENOMEM);
+}
+
 static int __init gic_of_init(struct device_node *node, struct device_node *parent)
 {
 	void __iomem *dist_base;
 	struct redist_region *rdist_regs;
+	struct resource res;
 	u64 redist_stride;
 	u32 nr_redist_regions;
 	int err, i;
 
-	dist_base = of_io_request_and_map(node, 0, "GICD");
+	dist_base = gic_of_iomap(node, 0, "GICD", &res);
 	if (IS_ERR(dist_base)) {
 		pr_err("%pOF: unable to map gic dist registers\n", node);
 		return PTR_ERR(dist_base);
@@ -2070,12 +2095,8 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	}
 
 	for (i = 0; i < nr_redist_regions; i++) {
-		struct resource res;
-		int ret;
-
-		ret = of_address_to_resource(node, 1 + i, &res);
-		rdist_regs[i].redist_base = of_io_request_and_map(node, 1 + i, "GICR");
-		if (ret || IS_ERR(rdist_regs[i].redist_base)) {
+		rdist_regs[i].redist_base = gic_of_iomap(node, 1 + i, "GICR", &res);
+		if (IS_ERR(rdist_regs[i].redist_base)) {
 			pr_err("%pOF: couldn't map region %d\n", node, i);
 			err = -ENODEV;
 			goto out_unmap_rdist;
@@ -2148,7 +2169,7 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers *header,
 		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
 		return -ENOMEM;
 	}
-	request_mem_region(redist->base_address, redist->length, "GICR");
+	gic_request_region(redist->base_address, redist->length, "GICR");
 
 	gic_acpi_register_redist(redist->base_address, redist_base);
 	return 0;
@@ -2171,7 +2192,7 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
 	redist_base = ioremap(gicc->gicr_base_address, size);
 	if (!redist_base)
 		return -ENOMEM;
-	request_mem_region(gicc->gicr_base_address, size, "GICR");
+	gic_request_region(gicc->gicr_base_address, size, "GICR");
 
 	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
 	return 0;
@@ -2373,7 +2394,7 @@ gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
 		pr_err("Unable to map GICD registers\n");
 		return -ENOMEM;
 	}
-	request_mem_region(dist->base_address, ACPI_GICV3_DIST_MEM_SIZE, "GICD");
+	gic_request_region(dist->base_address, ACPI_GICV3_DIST_MEM_SIZE, "GICD");
 
 	err = gic_validate_dist_version(acpi_data.dist_base);
 	if (err) {
-- 
2.36.1.dirty


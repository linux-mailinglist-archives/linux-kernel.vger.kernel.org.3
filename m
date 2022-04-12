Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396664FE4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357007AbiDLPak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiDLPai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:30:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E92FE1D307
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:28:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3B4713D5;
        Tue, 12 Apr 2022 08:28:19 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11A413F70D;
        Tue, 12 Apr 2022 08:28:18 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     maz@kernel.org, tglx@linutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] irqchip/gic-v3: Claim iomem resources
Date:   Tue, 12 Apr 2022 16:28:15 +0100
Message-Id: <c534c2a458a3bf94ccdae8abc6edc3d45a689c30.1649777295.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a simple quality-of-life tweak, claim our MMIO regions when mapping
them, such that the GIC shows up in /proc/iomem. No effort is spent on
trying to release them, since frankly if the GIC fails to probe then
it's never getting a second try anyway.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

I briefly looked at doing the same for GICv2, but quickly decided that
GICv2 isn't interesting enough to be worth the (greater) bother...

Lightly tested with ACPI.
---
 drivers/irqchip/irq-gic-v3.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b252d5534547..9815b692a47a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1980,10 +1980,10 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	u32 nr_redist_regions;
 	int err, i;
 
-	dist_base = of_iomap(node, 0);
-	if (!dist_base) {
+	dist_base = of_io_request_and_map(node, 0, "GICD");
+	if (IS_ERR(dist_base)) {
 		pr_err("%pOF: unable to map gic dist registers\n", node);
-		return -ENXIO;
+		return PTR_ERR(dist_base);
 	}
 
 	err = gic_validate_dist_version(dist_base);
@@ -2007,8 +2007,8 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 		int ret;
 
 		ret = of_address_to_resource(node, 1 + i, &res);
-		rdist_regs[i].redist_base = of_iomap(node, 1 + i);
-		if (ret || !rdist_regs[i].redist_base) {
+		rdist_regs[i].redist_base = of_io_request_and_map(node, 1 + i, "GICR");
+		if (ret || IS_ERR(rdist_regs[i].redist_base)) {
 			pr_err("%pOF: couldn't map region %d\n", node, i);
 			err = -ENODEV;
 			goto out_unmap_rdist;
@@ -2034,7 +2034,7 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 
 out_unmap_rdist:
 	for (i = 0; i < nr_redist_regions; i++)
-		if (rdist_regs[i].redist_base)
+		if (rdist_regs[i].redist_base && !IS_ERR(rdist_regs[i].redist_base))
 			iounmap(rdist_regs[i].redist_base);
 	kfree(rdist_regs);
 out_unmap_dist:
@@ -2081,6 +2081,7 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers *header,
 		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
 		return -ENOMEM;
 	}
+	request_mem_region(redist->base_address, redist->length, "GICR");
 
 	gic_acpi_register_redist(redist->base_address, redist_base);
 	return 0;
@@ -2103,6 +2104,7 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
 	redist_base = ioremap(gicc->gicr_base_address, size);
 	if (!redist_base)
 		return -ENOMEM;
+	request_mem_region(gicc->gicr_base_address, size, "GICR");
 
 	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
 	return 0;
@@ -2304,6 +2306,7 @@ gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
 		pr_err("Unable to map GICD registers\n");
 		return -ENOMEM;
 	}
+	request_mem_region(dist->base_address, ACPI_GICV3_DIST_MEM_SIZE, "GICD");
 
 	err = gic_validate_dist_version(acpi_data.dist_base);
 	if (err) {
-- 
2.28.0.dirty


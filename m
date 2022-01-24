Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44A949813F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243181AbiAXNiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243179AbiAXNiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:38:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A4FC061401
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 05:38:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0109061298
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DD6C340E1;
        Mon, 24 Jan 2022 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643031496;
        bh=6ULtvEmM53XpZVfgoAJQ9W/hCwEgO+guD2eYGiPzntw=;
        h=From:To:Cc:Subject:Date:From;
        b=qMlCTbq8gKKiIFbiZUj9e8mY67K+IcCYGh5bqxGVrjMT56Z9dT46e2CycMq5aPjeu
         1WIR/EOoivFVsd8FfImvQZPcBhlwz604N92W01oTpTX6ynb+HP6CY5qK5e9OMP9TIE
         hevuUQhFpOe79jhDnog+55NCwzluZlyEAFUnrSWqcEDvDvVpIG2IBy9RlOQIOiY+2q
         QnoiHK5t41//lDht/j84gBD5WlbPXREjol8LhBE3Q+s2WATyPFTRF2zdGJs0b+/56z
         BdIGSvxy+k/nomG6TFMzR5TckCxjGaPSvZWzCmYosZMTMQna9gBaAT3sBqKwQataZS
         c7OakqBA9IzDQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nBzXy-002OVB-ED; Mon, 24 Jan 2022 13:38:14 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jay Chen <jkchen@linux.alibaba.com>
Subject: [PATCH v3] irqchip/gic-v3-its: Reset each ITS's BASERn register before probe
Date:   Mon, 24 Jan 2022 13:38:09 +0000
Message-Id: <20220124133809.1291195-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, kernel-team@android.com, lorenzo.pieralisi@arm.com, jkchen@linux.alibaba.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent bug report outlined that the way GICv4.1 is handled across
kexec is pretty bad. We can end-up in a situation where ITSs share
memory (this is the case when SVPET==1) and reprogram the base
registers, creating a situation where ITSs that are part of a given
affinity group see different pointers. Which is illegal. Boo.

In order to restore some sanity, reset the BASERn registers to 0
*before* probing any ITS. Although this isn't optimised at all,
this is only a once-per-boot cost, which shouldn't show up on
anyone's radar.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jay Chen <jkchen@linux.alibaba.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211216190315.GA14220@lpieralisi
---
 drivers/irqchip/irq-gic-v3-its.c | 114 +++++++++++++++++++++++++------
 1 file changed, 93 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7b8f1ec0ff78..c09d99d5b637 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4856,6 +4856,38 @@ static struct syscore_ops its_syscore_ops = {
 	.resume = its_restore_enable,
 };
 
+static void __init __iomem *its_map_one(struct resource *res, int *err)
+{
+	void __iomem *its_base;
+	u32 val;
+
+	its_base = ioremap(res->start, SZ_64K);
+	if (!its_base) {
+		pr_warn("ITS@%pa: Unable to map ITS registers\n", &res->start);
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	val = readl_relaxed(its_base + GITS_PIDR2) & GIC_PIDR2_ARCH_MASK;
+	if (val != 0x30 && val != 0x40) {
+		pr_warn("ITS@%pa: No ITS detected, giving up\n", &res->start);
+		*err = -ENODEV;
+		goto out_unmap;
+	}
+
+	*err = its_force_quiescent(its_base);
+	if (*err) {
+		pr_warn("ITS@%pa: Failed to quiesce, giving up\n", &res->start);
+		goto out_unmap;
+	}
+
+	return its_base;
+
+out_unmap:
+	iounmap(its_base);
+	return NULL;
+}
+
 static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
 {
 	struct irq_domain *inner_domain;
@@ -4963,29 +4995,14 @@ static int __init its_probe_one(struct resource *res,
 {
 	struct its_node *its;
 	void __iomem *its_base;
-	u32 val, ctlr;
 	u64 baser, tmp, typer;
 	struct page *page;
+	u32 ctlr;
 	int err;
 
-	its_base = ioremap(res->start, SZ_64K);
-	if (!its_base) {
-		pr_warn("ITS@%pa: Unable to map ITS registers\n", &res->start);
-		return -ENOMEM;
-	}
-
-	val = readl_relaxed(its_base + GITS_PIDR2) & GIC_PIDR2_ARCH_MASK;
-	if (val != 0x30 && val != 0x40) {
-		pr_warn("ITS@%pa: No ITS detected, giving up\n", &res->start);
-		err = -ENODEV;
-		goto out_unmap;
-	}
-
-	err = its_force_quiescent(its_base);
-	if (err) {
-		pr_warn("ITS@%pa: Failed to quiesce, giving up\n", &res->start);
-		goto out_unmap;
-	}
+	its_base = its_map_one(res, &err);
+	if (!its_base)
+		return err;
 
 	pr_info("ITS %pR\n", res);
 
@@ -5249,6 +5266,23 @@ static int its_cpu_memreserve_lpi(unsigned int cpu)
 	return ret;
 }
 
+/* Mark all the BASER registers as invalid before they get reprogrammed */
+static int __init its_reset_one(struct resource *res)
+{
+	void __iomem *its_base;
+	int err, i;
+
+	its_base = its_map_one(res, &err);
+	if (!its_base)
+		return err;
+
+	for (i = 0; i < GITS_BASER_NR_REGS; i++)
+		gits_write_baser(0, its_base + GITS_BASER + (i << 3));
+
+	iounmap(its_base);
+	return 0;
+}
+
 static const struct of_device_id its_device_id[] = {
 	{	.compatible	= "arm,gic-v3-its",	},
 	{},
@@ -5259,6 +5293,26 @@ static int __init its_of_probe(struct device_node *node)
 	struct device_node *np;
 	struct resource res;
 
+	/*
+	 * Make sure *all* the ITS are reset before we probe any, as
+	 * they may be sharing memory. If any of the ITS fails to
+	 * reset, don't even try to go any further, as this could
+	 * result in something even worse.
+	 */
+	for (np = of_find_matching_node(node, its_device_id); np;
+	     np = of_find_matching_node(np, its_device_id)) {
+		int err;
+
+		if (!of_device_is_available(np) ||
+		    !of_property_read_bool(np, "msi-controller") ||
+		    of_address_to_resource(np, 0, &res))
+			continue;
+
+		err = its_reset_one(&res);
+		if (err)
+			return err;
+	}
+
 	for (np = of_find_matching_node(node, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
 		if (!of_device_is_available(np))
@@ -5421,11 +5475,29 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
 	return err;
 }
 
+static int __init its_acpi_reset(union acpi_subtable_headers *header,
+				 const unsigned long end)
+{
+	struct acpi_madt_generic_translator *its_entry;
+	struct resource res;
+
+	its_entry = (struct acpi_madt_generic_translator *)header;
+	res = (struct resource) {
+		.start	= its_entry->base_address,
+		.end	= its_entry->base_address + ACPI_GICV3_ITS_MEM_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	};
+
+	return its_reset_one(&res);
+}
+
 static void __init its_acpi_probe(void)
 {
 	acpi_table_parse_srat_its();
-	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
-			      gic_acpi_parse_madt_its, 0);
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
+				  its_acpi_reset, 0) > 0)
+		acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
+				      gic_acpi_parse_madt_its, 0);
 	acpi_its_srat_maps_free();
 }
 #else
-- 
2.34.1


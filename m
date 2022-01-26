Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737EC49C862
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240533AbiAZLOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:14:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56282 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240525AbiAZLOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:14:18 -0500
Date:   Wed, 26 Jan 2022 11:14:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643195657;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ZdlLcj9sWmbJpcY+N3Ou+ykKHDKbmtVcfgNgjEfH3o=;
        b=ZiDSA2bJ/FEHwjGCbmZPs414j+21Cwaf14+Uq+6dDtJbhwPwkpey1J7gSwcY2Aw9EuxX4o
        FrCDU2nxSry3YW6HX2CHr0iXyROWzOSJi5AwYI3/1Fur+VobXkMHbVVgNfuIqSlYJG475G
        FzhfVXPERXUXpUlFivQ0Z9wUyXWxfqf2tciJ4BtfQEUUR8gxHGSo8gaSF1CjHNssl6qSLu
        6Hj09cfzUYPrKRimBW5bGZqrxDMmPJkm2i5IIDK+ZagOuhiNIzZzBZnu5dX5EAhCWxMPY9
        B550mqZOK2/V5bMCKvNxyPCOWkC+ZCXY2fwjFnbiQ4s2fB+vr/Vjnf836n8wDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643195657;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ZdlLcj9sWmbJpcY+N3Ou+ykKHDKbmtVcfgNgjEfH3o=;
        b=YnJjl2xv/HRcZMSHUfqeMdcC5OQmk/Yp9IuIebg8TvgU1XIC+nccSyIjHEjCdJuwpeBoFu
        WF7yZdHbDCsXIjCA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic-v3-its: Reset each ITS's
 BASERn register before probe
Cc:     Jay Chen <jkchen@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        tglx@linutronix.de
In-Reply-To: <20211216190315.GA14220@lpieralisi>
References: <20211216190315.GA14220@lpieralisi>
MIME-Version: 1.0
Message-ID: <164319565639.16921.12836392145342825517.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     c733ebb7cb67dfb146a07c0ae329a0de9ec52f36
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c733ebb7cb67dfb146a07c0ae329a0de9ec52f36
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 24 Jan 2022 13:38:09 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 26 Jan 2022 11:10:28 

irqchip/gic-v3-its: Reset each ITS's BASERn register before probe

A recent bug report outlined that the way GICv4.1 is handled across
kexec is pretty bad. We can end-up in a situation where ITSs share
memory (this is the case when SVPET==1) and reprogram the base
registers, creating a situation where ITSs that are part of a given
affinity group see different pointers. Which is illegal. Boo.

In order to restore some sanity, reset the BASERn registers to 0
*before* probing any ITS. Although this isn't optimised at all,
this is only a once-per-boot cost, which shouldn't show up on
anyone's radar.

Cc: Jay Chen <jkchen@linux.alibaba.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Link: https://lore.kernel.org/r/20211216190315.GA14220@lpieralisi
Link: https://lore.kernel.org/r/20220124133809.1291195-1-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 120 ++++++++++++++++++++++++------
 1 file changed, 99 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7b8f1ec..220fa45 100644
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
 
@@ -5249,6 +5266,23 @@ out:
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
@@ -5421,11 +5475,35 @@ dom_err:
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
+	/*
+	 * Make sure *all* the ITS are reset before we probe any, as
+	 * they may be sharing memory. If any of the ITS fails to
+	 * reset, don't even try to go any further, as this could
+	 * result in something even worse.
+	 */
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
+				  its_acpi_reset, 0) > 0)
+		acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
+				      gic_acpi_parse_madt_its, 0);
 	acpi_its_srat_maps_free();
 }
 #else

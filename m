Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B11654E886
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378189AbiFPRRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378180AbiFPRRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:17:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAA2118
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:17:30 -0700 (PDT)
Date:   Thu, 16 Jun 2022 17:17:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655399848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Q/H60a9CSFQtQnC4ttXdw/eRLeDOSRP5F7HwY4HPUs=;
        b=TIvsttaFP9PqN20KPhJrmUsGvDSbM/dBQLPTpapQKUnnOB+paPddLe5p34fA9FR772dt4v
        ABxjakr42puTk6vLXIprri7Ka4Nzk5B3qd19VZTu+1BlWZJWvusT8+gS1Y3IcmpukRf4QW
        qydEVwPdN3E1V0D5jA1N//HluwJMKMSMHrazJYdLxMEIXxnYHgwzoOC7+iAFrqeftv5+DJ
        npmCmv0/RMuDUN5zjV7QFzT/nH5jf+mYwY9LcgoQXhLsT7zeNfmPABABWGNzkJdHrHwBiw
        KUMqvFI+izZd4Ag748R9fnX1esJExDFV7YU7EaZCC2h9bQjFM50K5BtYPaJvmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655399848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Q/H60a9CSFQtQnC4ttXdw/eRLeDOSRP5F7HwY4HPUs=;
        b=NpRC2r+p8REvY7APZ8YNTAGFPGdPYLZwitgMAFVHWPLMQnrmJJVh4WQsggsVoRl0X71BzJ
        RJ8fwmGiBdmJKyDg==
From:   "irqchip-bot for Robin Murphy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gicv3: Handle resource request
 failure consistently
Cc:     Matt Ranostay <mranostay@ti.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C5f2b57a0131f3082fae9d3002d360bf784ccb092=2E16553?=
 =?utf-8?q?87206=2Egit=2Erobin=2Emurphy=40arm=2Ecom=3E?=
References: =?utf-8?q?=3C5f2b57a0131f3082fae9d3002d360bf784ccb092=2E165538?=
 =?utf-8?q?7206=2Egit=2Erobin=2Emurphy=40arm=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165539984637.4207.2502885653588878897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     4deb96e35c5c3ebfeb9cf567f3ba80fa54e2cec1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4deb96e35c5c3ebfeb9cf567f3ba80fa54e2cec1
Author:        Robin Murphy <robin.murphy@arm.com>
AuthorDate:    Thu, 16 Jun 2022 14:46:46 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 16 Jun 2022 16:55:59 +01:00

irqchip/gicv3: Handle resource request failure consistently

Due to a silly oversight on my part, making the simple switch to
of_io_request_and_map() in the DT path inadvertently introduced
divergent behaviour, whereby failng to request an iomem region now
becomes fatal for DT, vs. being silently ignored for ACPI.

Refactor a bit harder, so that request errors are non-fatal in both
paths as intended, but also consistently reported as well.

Reported-by: Matt Ranostay <mranostay@ti.com>
Fixes: 2b2cd74a06c3 ("irqchip/gic-v3: Claim iomem resources")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/5f2b57a0131f3082fae9d3002d360bf784ccb092.1655387206.git.robin.murphy@arm.com
---
 drivers/irqchip/irq-gic-v3.c | 41 ++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5c1cf90..2d25bca 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2042,15 +2042,40 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
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
@@ -2073,12 +2098,8 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
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
@@ -2151,7 +2172,7 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers *header,
 		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
 		return -ENOMEM;
 	}
-	request_mem_region(redist->base_address, redist->length, "GICR");
+	gic_request_region(redist->base_address, redist->length, "GICR");
 
 	gic_acpi_register_redist(redist->base_address, redist_base);
 	return 0;
@@ -2174,7 +2195,7 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
 	redist_base = ioremap(gicc->gicr_base_address, size);
 	if (!redist_base)
 		return -ENOMEM;
-	request_mem_region(gicc->gicr_base_address, size, "GICR");
+	gic_request_region(gicc->gicr_base_address, size, "GICR");
 
 	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
 	return 0;
@@ -2376,7 +2397,7 @@ gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
 		pr_err("Unable to map GICD registers\n");
 		return -ENOMEM;
 	}
-	request_mem_region(dist->base_address, ACPI_GICV3_DIST_MEM_SIZE, "GICD");
+	gic_request_region(dist->base_address, ACPI_GICV3_DIST_MEM_SIZE, "GICD");
 
 	err = gic_validate_dist_version(acpi_data.dist_base);
 	if (err) {

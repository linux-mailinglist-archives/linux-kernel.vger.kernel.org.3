Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BDA51A37D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352068AbiEDPTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349604AbiEDPTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:19:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2B219C0E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:15:35 -0700 (PDT)
Date:   Wed, 04 May 2022 15:15:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651677334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fZqIEsKT9Zu6NO/pBulsbc3rEN8EU/Ulaw6RKaaHptA=;
        b=gWtI66eCe2vwHYggtSql36hPFeHO7cQDZs4QWfkTSgWgzqgAe0qWxHZjivxbrE8WwGZ4+k
        EZ9HDnQ4oyAtCVQ8mMcfUVCkUxfYaraQ4UsmszwV2XYVBq1rFua+QqRSC5sD16dZlyxYjQ
        mQWyXYockSkXVIBznt76X3vF0aH7nxPlFjTjw77qNYOMJEsQWZsvFz+qWFavOthY8Yd6uh
        TNVA5pycWRMbcBu6tHXEPrySloeQO99e6uxn17O8CV886S6QPv8qjNLQ1uaK85hBnFCYD0
        wTINhApHCJX1KtW5eEbQiHILeNdFZyZZfBpwJ5NBTfyUql6TdQY0g6qkil51HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651677334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fZqIEsKT9Zu6NO/pBulsbc3rEN8EU/Ulaw6RKaaHptA=;
        b=auiYGtS6t9heHVHy5HEcvoOHalQWSOkAVdNHoq5JEiTWqr1c/bq6h5M6FQci9oat27QkI5
        Or3Yi05+vCiwJNAQ==
From:   "irqchip-bot for Robin Murphy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Claim iomem resources
Cc:     Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3Cc534c2a458a3bf94ccdae8abc6edc3d45a689c30=2E16497?=
 =?utf-8?q?77295=2Egit=2Erobin=2Emurphy=40arm=2Ecom=3E?=
References: =?utf-8?q?=3Cc534c2a458a3bf94ccdae8abc6edc3d45a689c30=2E164977?=
 =?utf-8?q?7295=2Egit=2Erobin=2Emurphy=40arm=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165167733320.4207.764034784360525411.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     2b2cd74a06c38cc26b2a17854f5e42f7270438eb
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/2b2cd74a06c38cc26b2a17854f5e42f7270438eb
Author:        Robin Murphy <robin.murphy@arm.com>
AuthorDate:    Tue, 12 Apr 2022 16:28:15 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 04 May 2022 15:46:03 +01:00

irqchip/gic-v3: Claim iomem resources

As a simple quality-of-life tweak, claim our MMIO regions when mapping
them, such that the GIC shows up in /proc/iomem. No effort is spent on
trying to release them, since frankly if the GIC fails to probe then
it's never getting a second try anyway.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/c534c2a458a3bf94ccdae8abc6edc3d45a689c30.1649777295.git.robin.murphy@arm.com
---
 drivers/irqchip/irq-gic-v3.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b802684..9d220c6 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1990,10 +1990,10 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
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
@@ -2017,8 +2017,8 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 		int ret;
 
 		ret = of_address_to_resource(node, 1 + i, &res);
-		rdist_regs[i].redist_base = of_iomap(node, 1 + i);
-		if (ret || !rdist_regs[i].redist_base) {
+		rdist_regs[i].redist_base = of_io_request_and_map(node, 1 + i, "GICR");
+		if (ret || IS_ERR(rdist_regs[i].redist_base)) {
 			pr_err("%pOF: couldn't map region %d\n", node, i);
 			err = -ENODEV;
 			goto out_unmap_rdist;
@@ -2044,7 +2044,7 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 
 out_unmap_rdist:
 	for (i = 0; i < nr_redist_regions; i++)
-		if (rdist_regs[i].redist_base)
+		if (rdist_regs[i].redist_base && !IS_ERR(rdist_regs[i].redist_base))
 			iounmap(rdist_regs[i].redist_base);
 	kfree(rdist_regs);
 out_unmap_dist:
@@ -2091,6 +2091,7 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers *header,
 		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
 		return -ENOMEM;
 	}
+	request_mem_region(redist->base_address, redist->length, "GICR");
 
 	gic_acpi_register_redist(redist->base_address, redist_base);
 	return 0;
@@ -2113,6 +2114,7 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
 	redist_base = ioremap(gicc->gicr_base_address, size);
 	if (!redist_base)
 		return -ENOMEM;
+	request_mem_region(gicc->gicr_base_address, size, "GICR");
 
 	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
 	return 0;
@@ -2314,6 +2316,7 @@ gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
 		pr_err("Unable to map GICD registers\n");
 		return -ENOMEM;
 	}
+	request_mem_region(dist->base_address, ACPI_GICV3_DIST_MEM_SIZE, "GICD");
 
 	err = gic_validate_dist_version(acpi_data.dist_base);
 	if (err) {

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A8858C6F1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbiHHKuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242420AbiHHKu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:50:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE0213D07
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 03:50:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0131610F4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D15EC433C1;
        Mon,  8 Aug 2022 10:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659955826;
        bh=FccCvxXtZ+yAE71nJynlqsf59eFlnrxFEYz54LHwEH8=;
        h=From:To:Cc:Subject:Date:From;
        b=o0+tr9MCH9pNlOXFuCJuNXegJSnC6Kw2lVEpOryMarUhMT0geXNFvq9gX0JrmQrAE
         pdh6Gr+w5i4QfxBZ3PiLsUCIX2aEMxqLcCrtnpK9PXtRm7gCXGKZMGaUrLHU4YU1V8
         Q2SMgESXCwUk5kxNe5j1tCY//Qt+RsDvB5bYY24h3SLig1skKvL01akE9zscfM9HpP
         EApEm8MTiP6dH85WVi7QX+O0o2aUBGbhp84Pu/2aRqdgHyl6DxieClkPhTdfE6j3hI
         fv2inHYwltFC8HssqjjmaOqgWMMBB6MI7iMMgKI2LEoHKAo9qgF62+p518v3YG8ErU
         uFQv8W3y0dwnA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oL0L1-001dqt-OS;
        Mon, 08 Aug 2022 11:50:24 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     chenhuacai@loongson.cn, lvjianmin@loongson.cn,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] irqchip/loongarch: Fix irq_domain_alloc_fwnode() abuse
Date:   Mon,  8 Aug 2022 11:50:20 +0100
Message-Id: <20220808105020.2689757-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, chenhuacai@loongson.cn, lvjianmin@loongson.cn, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recently merged LoongArch drivers paper over the lack of
topology information by creating a bunch of fwnodes for the
irqchips. So far, so good.

However, irq_domain_alloc_fwnode() is supposed to take a PA, and
not a kernel VA blindly cast as a PA, potentially disclosing
kernel VAs to userspace. In some other cases, even NULL is used
as the PA, which is entertaining.

Fix this by using the actual PA of the block when available,
and switch to a named fwnode in the other cases.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-loongarch-cpu.c    | 2 +-
 drivers/irqchip/irq-loongson-eiointc.c | 3 ++-
 drivers/irqchip/irq-loongson-liointc.c | 2 +-
 drivers/irqchip/irq-loongson-pch-msi.c | 2 +-
 drivers/irqchip/irq-loongson-pch-pic.c | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 327f3ab62c03..741612ba6a52 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -129,7 +129,7 @@ static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
 	clear_csr_ecfg(ECFG0_IM);
 	clear_csr_estat(ESTATF_IP);
 
-	cpuintc_handle = irq_domain_alloc_fwnode(NULL);
+	cpuintc_handle = irq_domain_alloc_named_fwnode("CPUINTC");
 	irq_domain = irq_domain_create_linear(cpuintc_handle, EXCCODE_INT_NUM,
 					&loongarch_cpu_intc_irq_domain_ops, NULL);
 
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index bffb7b3128e8..16e9af8d8b1e 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -348,7 +348,8 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 	if (!priv)
 		return -ENOMEM;
 
-	priv->domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_eiointc);
+	priv->domain_handle = irq_domain_alloc_named_id_fwnode("EIOPIC",
+							       acpi_eiointc->node);
 	if (!priv->domain_handle) {
 		pr_err("Unable to allocate domain handle\n");
 		goto out_free_priv;
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index c4f3c886ad61..acd1a4b897df 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -360,7 +360,7 @@ int __init liointc_acpi_init(struct irq_domain *parent, struct acpi_madt_lio_pic
 	parent_irq[0] = irq_create_mapping(parent, acpi_liointc->cascade[0]);
 	parent_irq[1] = irq_create_mapping(parent, acpi_liointc->cascade[1]);
 
-	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_liointc);
+	domain_handle = irq_domain_alloc_fwnode(&acpi_liointc->address);
 	if (!domain_handle) {
 		pr_err("Unable to allocate domain handle\n");
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index d0e8551bebfa..a72ede90ffc6 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -282,7 +282,7 @@ int __init pch_msi_acpi_init(struct irq_domain *parent,
 	int ret;
 	struct fwnode_handle *domain_handle;
 
-	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchmsi);
+	domain_handle = irq_domain_alloc_fwnode(&acpi_pchmsi->msg_address);
 	ret = pch_msi_init(acpi_pchmsi->msg_address, acpi_pchmsi->start,
 				acpi_pchmsi->count, parent, domain_handle);
 	if (ret < 0)
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index b987b6517d59..c01b9c257005 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -349,7 +349,7 @@ int __init pch_pic_acpi_init(struct irq_domain *parent,
 
 	vec_base = acpi_pchpic->gsi_base - GSI_MIN_PCH_IRQ;
 
-	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchpic);
+	domain_handle = irq_domain_alloc_fwnode(&acpi_pchpic->address);
 	if (!domain_handle) {
 		pr_err("Unable to allocate domain handle\n");
 		return -ENOMEM;
-- 
2.34.1


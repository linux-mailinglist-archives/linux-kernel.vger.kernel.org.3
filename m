Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91DC58D363
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 07:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiHIF5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 01:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiHIF5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 01:57:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1B91D316
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 22:57:09 -0700 (PDT)
Date:   Tue, 09 Aug 2022 05:57:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660024627;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JkP8AlxDJrkpXzpdZEOq9CwgcUlkqtQ9BpKufDvw238=;
        b=CHY8dfb+hHsnYTjArl7VgH+5+TeyP7Y/bhYKsmQbVvYdTnIEpusKvs4Ea49yiepsVSCpOi
        KRcH2Gx2CUWTDgNljrJTS8B9+7cLbrBabGEneii2GOyxOC+dSWnrteV5OIqIOkeQj23hqW
        A6wYdLNns+CJTpGQlm1dCOlflDzvj81kgIxBQAIDyTB5MJwPqw50Nnk3WYRBDUrIl97Vua
        +NBf+U1x48Wtf+zdz897XBK8gvmr1a59HsRmJ49t04e2/dZ8o+7F7ds5rS52Fa/AVMGMBk
        OqmItgDnt2ZVEt/PKzlBSvV6OrThYmsKwpse0sMtImhYculXIrsuEhffZngrxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660024627;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JkP8AlxDJrkpXzpdZEOq9CwgcUlkqtQ9BpKufDvw238=;
        b=LpO9vL2akFbsu5rG0FSkmXHVKmsT0w01+jDTUgLmXuTDB2q7bQvsmIBSRkY61MAbEGktef
        lZ9kqm0/0wyK1MAw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/loongarch: Fix
 irq_domain_alloc_fwnode() abuse
Cc:     Marc Zyngier <maz@kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>,
        tglx@linutronix.de
In-Reply-To: <20220808105020.2689757-1-maz@kernel.org>
References: <20220808105020.2689757-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <166002462605.15455.973226025539944266.tip-bot2@tip-bot2>
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

Commit-ID:     7e4fd7a1a6fdf23d069eeb0ae0e8e46b9fb40723
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/7e4fd7a1a6fdf23d069eeb0ae0e8e46b9fb40723
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 08 Aug 2022 11:50:20 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 09 Aug 2022 06:54:05 +01:00

irqchip/loongarch: Fix irq_domain_alloc_fwnode() abuse

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
Reviewed-by: Jianmin Lv <lvjianmin@loongson.cn>
Link: https://lore.kernel.org/r/20220808105020.2689757-1-maz@kernel.org
---
 drivers/irqchip/irq-loongarch-cpu.c    | 2 +-
 drivers/irqchip/irq-loongson-eiointc.c | 3 ++-
 drivers/irqchip/irq-loongson-liointc.c | 2 +-
 drivers/irqchip/irq-loongson-pch-msi.c | 2 +-
 drivers/irqchip/irq-loongson-pch-pic.c | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 327f3ab..741612b 100644
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
index bffb7b3..16e9af8 100644
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
index c4f3c88..acd1a4b 100644
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
index d0e8551..a72ede9 100644
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
index b987b65..c01b9c2 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -349,7 +349,7 @@ int __init pch_pic_acpi_init(struct irq_domain *parent,
 
 	vec_base = acpi_pchpic->gsi_base - GSI_MIN_PCH_IRQ;
 
-	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchpic);
+	domain_handle = irq_domain_alloc_fwnode(&acpi_pchpic->address);
 	if (!domain_handle) {
 		pr_err("Unable to allocate domain handle\n");
 		return -ENOMEM;

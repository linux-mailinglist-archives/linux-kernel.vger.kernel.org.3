Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0357B566
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbiGTL2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbiGTL1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:27:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CF145066
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:27:38 -0700 (PDT)
Date:   Wed, 20 Jul 2022 11:27:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658316457;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rG2RuPtB8gt+rnCavTi1rFk6TKhGZh8beIMQwl5wVK4=;
        b=XBs0Xiz9KvEehMMj1hptz06fx5gxdqK77cum/N4ZP38b06m2byU6JduclRfuB2MfSM7iJ0
        NBrrunHUSyE2VBKKo1qZ8NNj/PCg1aSXCm7sWUNNG1FyR9+t1Gpl+IkN5hwYZyxUIr+LZ9
        Tw+KgaNgcVoC08Ac3DpX07lBzrHvyKw6tBFgFsNZmMk6ECwXSyRUzIm6XHKPpb+0T6/qha
        1QAzotbtxfxftPb3yeoFSWrskFaC3T9ZBVYT0OhSvOyaDzmsDpzSoiiNEy1R1vim8UlUke
        UmMNsLhcS8P/ev4y2TXJrh7cZim4Drs73vDs/PdElC3tEdnfXdSEEfRjs7cqvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658316457;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rG2RuPtB8gt+rnCavTi1rFk6TKhGZh8beIMQwl5wVK4=;
        b=IGmfxVrJqqopYPRkBO6El9JmSvIRbvmnpXpAUGopxeR4CgxuwAcy2nj/F1VFAVcO7JVD5v
        h9QgTa2+gBQP+YBA==
From:   "irqchip-bot for Jianmin Lv" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] LoongArch: Use ACPI_GENERIC_GSI for gsi handling
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <1658314292-35346-6-git-send-email-lvjianmin@loongson.cn>
References: <1658314292-35346-6-git-send-email-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <165831645648.15455.16441428331265427809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     cd057667585411fbecc0c140727177d7d707c63a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/cd057667585411fbecc0c140727177d7d707c63a
Author:        Jianmin Lv <lvjianmin@loongson.cn>
AuthorDate:    Wed, 20 Jul 2022 18:51:24 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Jul 2022 12:09:20 +01:00

LoongArch: Use ACPI_GENERIC_GSI for gsi handling

For LoongArch, generic gsi code(driver/acpi/irq.c) can be
reused after following patchs:

APCI: irq: Add support for multiple GSI domains
ACPI: irq: Allow acpi_gsi_to_irq() to have an arch-specific fallback

So, config ACPI_GENERIC_GSI for LoongArch with removing the gsi code
in arch directory.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1658314292-35346-6-git-send-email-lvjianmin@loongson.cn
---
 arch/loongarch/Kconfig       |  1 +-
 arch/loongarch/kernel/acpi.c | 65 +-----------------------------------
 2 files changed, 1 insertion(+), 65 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 1920d52..fb1e73a 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -2,6 +2,7 @@
 config LOONGARCH
 	bool
 	default y
+	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index bb729ee..03aa145 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -25,7 +25,6 @@ EXPORT_SYMBOL(acpi_pci_disabled);
 int acpi_strict = 1; /* We have no workarounds on LoongArch */
 int num_processors;
 int disabled_cpus;
-enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_PLATFORM;
 
 u64 acpi_saved_sp;
 
@@ -33,70 +32,6 @@ u64 acpi_saved_sp;
 
 #define PREFIX			"ACPI: "
 
-int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
-{
-	if (irqp != NULL)
-		*irqp = acpi_register_gsi(NULL, gsi, -1, -1);
-	return (*irqp >= 0) ? 0 : -EINVAL;
-}
-EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
-
-int acpi_isa_irq_to_gsi(unsigned int isa_irq, u32 *gsi)
-{
-	if (gsi)
-		*gsi = isa_irq;
-	return 0;
-}
-
-/*
- * success: return IRQ number (>=0)
- * failure: return < 0
- */
-int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
-{
-	struct irq_fwspec fwspec;
-
-	switch (gsi) {
-	case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
-		fwspec.fwnode = liointc_domain->fwnode;
-		fwspec.param[0] = gsi - GSI_MIN_CPU_IRQ;
-		fwspec.param_count = 1;
-
-		return irq_create_fwspec_mapping(&fwspec);
-
-	case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
-		if (!pch_lpc_domain)
-			return -EINVAL;
-
-		fwspec.fwnode = pch_lpc_domain->fwnode;
-		fwspec.param[0] = gsi - GSI_MIN_LPC_IRQ;
-		fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
-		fwspec.param_count = 2;
-
-		return irq_create_fwspec_mapping(&fwspec);
-
-	case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
-		if (!pch_pic_domain[0])
-			return -EINVAL;
-
-		fwspec.fwnode = pch_pic_domain[0]->fwnode;
-		fwspec.param[0] = gsi - GSI_MIN_PCH_IRQ;
-		fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
-		fwspec.param_count = 2;
-
-		return irq_create_fwspec_mapping(&fwspec);
-	}
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(acpi_register_gsi);
-
-void acpi_unregister_gsi(u32 gsi)
-{
-
-}
-EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
-
 void __init __iomem * __acpi_map_table(unsigned long phys, unsigned long size)
 {
 

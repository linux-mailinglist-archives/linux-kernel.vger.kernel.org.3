Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF22578515
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbiGROOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiGROOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:14:01 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DF775F92
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:13:55 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_9GWatViBtEmAA--.33569S7;
        Mon, 18 Jul 2022 22:13:45 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V16 05/14] LoongArch: Use ACPI_GENERIC_GSI for gsi handling
Date:   Mon, 18 Jul 2022 22:13:32 +0800
Message-Id: <1658153621-40445-6-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn>
References: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9Dx_9GWatViBtEmAA--.33569S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4DKry7tw1rZw47AFW8Zwb_yoW5AF48pr
        4S9FnrJr4SqF18ZrW8t3s5uayUXryxKayIqa15J348J3srur1YvFn5Ar97XFy5tayrXrW8
        Z3s5CFy5Jay3A3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAI
        w28IcVCjz48v1sIEY20_XrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
        Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For LoongArch, generic gsi code(driver/acpi/irq.c) can be
reused after following patchs:

APCI: irq: Add support for multiple GSI domains
ACPI: irq: Allow acpi_gsi_to_irq() to have an arch-specific fallback

So, config ACPI_GENERIC_GSI for LoongArch with removing the gsi code
in arch directory.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 arch/loongarch/Kconfig       |  1 +
 arch/loongarch/kernel/acpi.c | 65 --------------------------------------------
 2 files changed, 1 insertion(+), 65 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 1920d52..7f98fc0 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -112,6 +112,7 @@ config LOONGARCH
 	select TRACE_IRQFLAGS_SUPPORT
 	select USE_PERCPU_NUMA_NODE_ID
 	select ZONE_DMA32
+	select ACPI_GENERIC_GSI if ACPI
 
 config 32BIT
 	bool
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index bb729ee..03aa145 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -25,7 +25,6 @@
 int acpi_strict = 1; /* We have no workarounds on LoongArch */
 int num_processors;
 int disabled_cpus;
-enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_PLATFORM;
 
 u64 acpi_saved_sp;
 
@@ -33,70 +32,6 @@
 
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
 
-- 
1.8.3.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653BC575C27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiGOHHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiGOHGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:06:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7E727393B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:06:09 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxWeDQEdFiyyogAA--.1717S17;
        Fri, 15 Jul 2022 15:06:03 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V15 15/15] irqchip / ACPI: Introduce ACPI_IRQ_MODEL_LPIC for LoongArch
Date:   Fri, 15 Jul 2022 15:05:51 +0800
Message-Id: <1657868751-30444-16-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
References: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9AxWeDQEdFiyyogAA--.1717S17
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1rZryUXr1fJrW8tFWkZwb_yoW5AF1xpF
        WqgF15Ar48Kay7W3sxCa1Dury3uFyrGrW2qayfG347Cw4kGrykWF1kZF9FvFZ8A3y5Wa17
        uF1DXFs8W3WUZrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l
        42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
        6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
        fUoOJ5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For LoongArch, ACPI_IRQ_MODEL_LPIC is introduced, and then the
callback acpi_get_gsi_domain_id and acpi_gsi_to_irq_fallback are
implemented.

The acpi_get_gsi_domain_id callback returns related fwnode handle
of irqdomain for different GSI range.

The acpi_gsi_to_irq_fallback will create new mapping for gsi when
the mapping of it is not found.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/acpi/bus.c                  |  3 +++
 drivers/irqchip/irq-loongarch-cpu.c | 38 +++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h                |  1 +
 3 files changed, 42 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 86fa61a..63fbf00 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1145,6 +1145,9 @@ static int __init acpi_bus_init_irq(void)
 	case ACPI_IRQ_MODEL_PLATFORM:
 		message = "platform specific model";
 		break;
+	case ACPI_IRQ_MODEL_LPIC:
+		message = "LPIC";
+		break;
 	default:
 		pr_info("Unknown interrupt routing model\n");
 		return -ENODEV;
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 476f407..93a4b15 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -16,6 +16,42 @@
 static struct irq_domain *irq_domain;
 struct fwnode_handle *cpuintc_handle;
 
+static u32 lpic_gsi_to_irq(u32 gsi)
+{
+	/* Only pch irqdomain transferring is required for LoongArch. */
+	if (gsi >= GSI_MIN_PCH_IRQ && gsi <= GSI_MAX_PCH_IRQ)
+		return acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
+
+	return 0;
+}
+
+static struct fwnode_handle *lpic_get_gsi_domain_id(u32 gsi)
+{
+	int id;
+	struct fwnode_handle *domain_handle = NULL;
+
+	switch (gsi) {
+	case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
+		if (liointc_handle)
+			domain_handle = liointc_handle;
+		break;
+
+	case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
+		if (pch_lpc_handle)
+			domain_handle = pch_lpc_handle;
+		break;
+
+	case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
+		id = find_pch_pic(gsi);
+		if (id >= 0 && pch_pic_handle[id])
+			domain_handle = pch_pic_handle[id];
+
+		break;
+	}
+
+	return domain_handle;
+}
+
 static void mask_loongarch_irq(struct irq_data *d)
 {
 	clear_csr_ecfg(ECFGF(d->hwirq));
@@ -71,6 +107,8 @@ static int __init loongarch_cpu_irq_init(void)
 		panic("Failed to add irqdomain for LoongArch CPU");
 
 	set_handle_irq(&handle_cpu_irq);
+	acpi_set_irq_model(ACPI_IRQ_MODEL_LPIC, lpic_get_gsi_domain_id);
+	acpi_set_gsi_to_irq_fallback(lpic_gsi_to_irq);
 
 	return 0;
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e2b60d5..76520f3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -105,6 +105,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_IOSAPIC,
 	ACPI_IRQ_MODEL_PLATFORM,
 	ACPI_IRQ_MODEL_GIC,
+	ACPI_IRQ_MODEL_LPIC,
 	ACPI_IRQ_MODEL_COUNT
 };
 
-- 
1.8.3.1


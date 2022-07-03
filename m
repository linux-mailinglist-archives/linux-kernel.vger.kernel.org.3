Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8385645F7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 10:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiGCIq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 04:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiGCIpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 04:45:55 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D30E21130
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 01:45:49 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT+MtV8FigMQFAA--.17307S16;
        Sun, 03 Jul 2022 16:45:44 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V14 14/15] irqchip / ACPI: Introduce ACPI_IRQ_MODEL_LPIC for LoongArch
Date:   Sun,  3 Jul 2022 16:45:31 +0800
Message-Id: <1656837932-18257-15-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
References: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9DxT+MtV8FigMQFAA--.17307S16
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1rZryUXr13Kw17Jw1fJFb_yoW5Ar4UpF
        WDuF15Ar40q3y7W3sxCa1Dury3uFyrKrWjqFWfGwnrCw1DGrykWFykZF9FvFZ8A3y5ua17
        uF1DXFs0g3WUZwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcx
        kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
        6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
        Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxG
        rwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
        wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
        9x0JUdHUDUUUUU=
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
 drivers/irqchip/irq-loongarch-cpu.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h                |  1 +
 3 files changed, 41 insertions(+)

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
index c2f7411..1b241d7 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -15,6 +15,41 @@
 
 static struct irq_domain *irq_domain;
 
+static int lpic_gsi_to_irq(u32 gsi)
+{
+	/* Only pch irqdomain transferring is required for LoongArch. */
+	if (gsi >= GSI_MIN_PCH_IRQ && gsi <= GSI_MAX_PCH_IRQ)
+		return acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
+	return -1;
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
@@ -87,6 +122,8 @@ static int __init loongarch_cpu_irq_init(void)
 		panic("Failed to add irqdomain for LoongArch CPU");
 
 	set_handle_irq(&handle_cpu_irq);
+	acpi_set_irq_model(ACPI_IRQ_MODEL_LPIC, lpic_get_gsi_domain_id);
+	acpi_set_gsi_to_irq_fallback(lpic_gsi_to_irq);
 
 	return 0;
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 71d3719..1bec0a3 100644
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


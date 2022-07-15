Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03887575C14
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiGOHG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiGOHGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:06:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5CBC3DBF3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:06:06 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxWeDQEdFiyyogAA--.1717S5;
        Fri, 15 Jul 2022 15:05:58 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V15 03/15] ACPI: irq: Allow acpi_gsi_to_irq() to have an arch-specific fallback
Date:   Fri, 15 Jul 2022 15:05:39 +0800
Message-Id: <1657868751-30444-4-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
References: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9AxWeDQEdFiyyogAA--.1717S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1DKF18Jr43Xw4xAr4ruFg_yoW5WF4kpF
        Wxuw1xJrWIqr17ZrZ7C3yfuF13W3Z5JFWxXrW2k347CayDKF1agrnFgry2gryDAF4fCFWj
        v3ZIkFW8GF1DCa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF
        04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

It appears that the generic version of acpi_gsi_to_irq() doesn't
fallback to establishing a mapping if there is no pre-existing
one while the x86 version does.

While arm64 seems unaffected by it, LoongArch is relying on the x86
behaviour. In an effort to prevent new architectures from reinventing
the proverbial wheel, provide an optional callback that the arch code
can set to restore the x86 behaviour.

Hopefully we can eventually get rid of this in the future once
the expected behaviour has been clarified.

Reported-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/irq.c   | 18 ++++++++++++++++--
 include/linux/acpi.h |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index f0de768..dabe45e 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -13,6 +13,7 @@
 enum acpi_irq_model_id acpi_irq_model;
 
 static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
+static u32 (*acpi_gsi_to_irq_fallback)(u32 gsi);
 
 /**
  * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
@@ -32,9 +33,12 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 					DOMAIN_BUS_ANY);
 	*irq = irq_find_mapping(d, gsi);
 	/*
-	 * *irq == 0 means no mapping, that should
-	 * be reported as a failure
+	 * *irq == 0 means no mapping, that should be reported as a
+	 * failure, unless there is an arch-specific fallback handler.
 	 */
+	if (!*irq && acpi_gsi_to_irq_fallback)
+		*irq = acpi_gsi_to_irq_fallback(gsi);
+
 	return (*irq > 0) ? 0 : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
@@ -302,6 +306,16 @@ void __init acpi_set_irq_model(enum acpi_irq_model_id model,
 }
 
 /**
+ * acpi_set_gsi_to_irq_fallback - Register a GSI transfer
+ * callback to fallback to arch specified implementation.
+ * @fn: arch-specific fallback handler
+ */
+void __init acpi_set_gsi_to_irq_fallback(u32 (*fn)(u32))
+{
+	acpi_gsi_to_irq_fallback = fn;
+}
+
+/**
  * acpi_irq_create_hierarchy - Create a hierarchical IRQ domain with the default
  *                             GSI domain as its parent.
  * @flags:      Irq domain flags associated with the domain
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 957e23f..e2b60d5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -357,6 +357,7 @@ static inline bool acpi_sci_irq_valid(void)
 
 void acpi_set_irq_model(enum acpi_irq_model_id model,
 			struct fwnode_handle *(*)(u32));
+void acpi_set_gsi_to_irq_fallback(u32 (*)(u32));
 
 struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
 					     unsigned int size,
-- 
1.8.3.1


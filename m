Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7BD564600
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 10:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiGCIqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 04:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiGCIpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 04:45:50 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E33E1143
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 01:45:47 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT+MtV8FigMQFAA--.17307S5;
        Sun, 03 Jul 2022 16:45:40 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V14 03/15] ACPI: irq: Allow acpi_gsi_to_irq() to have an arch-specific fallback
Date:   Sun,  3 Jul 2022 16:45:20 +0800
Message-Id: <1656837932-18257-4-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
References: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9DxT+MtV8FigMQFAA--.17307S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1DKF18Jr43Xw4xZF1kXwb_yoW5XFWxpF
        WI9r1fJrWIqr17ZrZ7Cw4fWF13W3Z5JFWxXFWIg3W7A3yDCF1a9rnFgry7KrWUAF43CFWj
        vwnxKFW8GF1DCa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l
        42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoO
        J5UUUUU
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
---
 drivers/acpi/irq.c   | 18 ++++++++++++++++--
 include/linux/acpi.h |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index f0de768..cd87e0b 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -13,6 +13,7 @@
 enum acpi_irq_model_id acpi_irq_model;
 
 static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
+static int (*acpi_gsi_to_irq_fallback)(u32 gsi);
 
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
+void __init acpi_set_gsi_to_irq_fallback(int (*fn)(u32))
+{
+	acpi_gsi_to_irq_fallback = fn;
+}
+
+/**
  * acpi_irq_create_hierarchy - Create a hierarchical IRQ domain with the default
  *                             GSI domain as its parent.
  * @flags:      Irq domain flags associated with the domain
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 957e23f..71d3719 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -357,6 +357,7 @@ static inline bool acpi_sci_irq_valid(void)
 
 void acpi_set_irq_model(enum acpi_irq_model_id model,
 			struct fwnode_handle *(*)(u32));
+void acpi_set_gsi_to_irq_fallback(int (*)(u32));
 
 struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
 					     unsigned int size,
-- 
1.8.3.1


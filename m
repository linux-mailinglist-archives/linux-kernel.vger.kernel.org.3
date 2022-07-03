Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FB35645FA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 10:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiGCIqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 04:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiGCIpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 04:45:50 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2D0E1177
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 01:45:48 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT+MtV8FigMQFAA--.17307S6;
        Sun, 03 Jul 2022 16:45:41 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V14 04/15] genirq/generic_chip: export irq_unmap_generic_chip
Date:   Sun,  3 Jul 2022 16:45:21 +0800
Message-Id: <1656837932-18257-5-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
References: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9DxT+MtV8FigMQFAA--.17307S6
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy8uFy5JrWrKFy7CFykZrb_yoW8Xw18pa
        yrWa47WrWkGr18ZFWUGF1kuryavrs7GFW2ya1SvF92yr18Jws2gFykWrnavF40934xuFWY
        yFs7tFy8ur1UWFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Some irq controllers have to re-implement a private version for
irq_generic_chip_ops, because they have a different xlate to translate
hwirq. Export irq_unmap_generic_chip for reusing in user defined
ops.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 include/linux/irq.h       | 1 +
 kernel/irq/generic-chip.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 5053082..83a4574 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1121,6 +1121,7 @@ struct irq_domain_chip_generic {
 /* Setup functions for irq_chip_generic */
 int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
 			 irq_hw_number_t hw_irq);
+void irq_unmap_generic_chip(struct irq_domain *d, unsigned int virq);
 struct irq_chip_generic *
 irq_alloc_generic_chip(const char *name, int nr_ct, unsigned int irq_base,
 		       void __iomem *reg_base, irq_flow_handler_t handler);
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index f0862eb..c653cd3 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -431,7 +431,7 @@ int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
 	return 0;
 }
 
-static void irq_unmap_generic_chip(struct irq_domain *d, unsigned int virq)
+void irq_unmap_generic_chip(struct irq_domain *d, unsigned int virq)
 {
 	struct irq_data *data = irq_domain_get_irq_data(d, virq);
 	struct irq_domain_chip_generic *dgc = d->gc;
-- 
1.8.3.1


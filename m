Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F75B58EA78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 12:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiHJKb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 06:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHJKb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:31:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FBF753AD
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 03:31:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8800DB81B57
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A9CC433D7;
        Wed, 10 Aug 2022 10:31:49 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Fix the !CONFIG_SMP build for irqchip drivers
Date:   Wed, 10 Aug 2022 18:31:56 +0800
Message-Id: <20220810103156.1214996-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1, Guard get_ipi_irq() in CONFIG_SMP;
2, Define cpu_logical_map() for the EIOINTC driver;
3, Make eiointc_set_irq_affinity() return early for !CONFIG_SMP.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/smp.h       | 8 ++++++++
 arch/loongarch/kernel/irq.c            | 2 ++
 drivers/irqchip/irq-loongson-eiointc.c | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index 71189b28bfb2..9ee5a309df5b 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -12,6 +12,8 @@
 #include <linux/threads.h>
 #include <linux/cpumask.h>
 
+#ifdef CONFIG_SMP
+
 extern int smp_num_siblings;
 extern int num_processors;
 extern int disabled_cpus;
@@ -112,4 +114,10 @@ static inline void __cpu_die(unsigned int cpu)
 extern void play_dead(void);
 #endif
 
+#else /* !CONFIG_SMP */
+
+#define cpu_logical_map(cpu)  0
+
+#endif
+
 #endif /* __ASM_SMP_H */
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index 1ba19c76563e..d83623bc59fa 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -87,6 +87,7 @@ static void __init init_vec_parent_group(void)
 	acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
 }
 
+#ifdef CONFIG_SMP
 static int __init get_ipi_irq(void)
 {
 	struct irq_domain *d = irq_find_matching_fwnode(cpuintc_handle, DOMAIN_BUS_ANY);
@@ -96,6 +97,7 @@ static int __init get_ipi_irq(void)
 
 	return -EINVAL;
 }
+#endif
 
 void __init init_IRQ(void)
 {
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 80d8ca6f2d46..17f94f3c11af 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -18,6 +18,8 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
+#include <asm/smp.h>
+
 #define EIOINTC_REG_NODEMAP	0x14a0
 #define EIOINTC_REG_IPMAP	0x14c0
 #define EIOINTC_REG_ENABLE	0x1600
@@ -96,6 +98,9 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
 	struct cpumask intersect_affinity;
 	struct eiointc_priv *priv = d->domain->host_data;
 
+	if (!IS_ENABLED(CONFIG_SMP))
+		return -EPERM;
+
 	raw_spin_lock_irqsave(&affinity_lock, flags);
 
 	cpumask_and(&intersect_affinity, affinity, cpu_online_mask);
-- 
2.31.1


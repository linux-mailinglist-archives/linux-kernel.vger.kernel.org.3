Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7E252B416
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiERHt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiERHtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:49:52 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AC21207F0;
        Wed, 18 May 2022 00:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652860191; x=1684396191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=YXZfjMQjUYv74UOxyPEdQftsBYoYCO06rHvgPycGMF8=;
  b=ZAvNySM6n3yl2pZeG1iXhTqolcDLZaADSHpvy3vuynfXl/faTsnXvTAW
   9dYy498KbpKXU2t4bxZ5yBApZyWpfAVS11h2a6re6tcPbsnmG86W+IrGZ
   aID367ji8W1AhFCNt2YXWmv931bK5OejVxrKjvYE8Dqvewi0z7wx/+3GS
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 May 2022 00:49:50 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 00:49:50 -0700
Received: from blr-ubuntu-185.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 00:49:41 -0700
From:   Vivek Kumar <quic_vivekuma@quicinc.com>
To:     <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <axboe@kernel.dk>,
        <rafael@kernel.org>, <akpm@linux-foundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <len.brown@intel.com>, <pavel@ucw.cz>, <paulmck@kernel.org>,
        <bp@suse.de>, <keescook@chromium.org>, <songmuchun@bytedance.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <pasha.tatashin@soleen.com>, <tabba@google.com>, <ardb@kernel.org>,
        <tsoni@quicinc.com>, <quic_psodagud@quicinc.com>,
        <quic_svaddagi@quicinc.com>,
        Vivek Kumar <quic_vivekuma@quicinc.com>,
        Prasanna Kumar <quic_kprasan@quicinc.com>
Subject: [RFC 6/6] irqchip/gic-v3: Re-init GIC hardware upon hibernation restore
Date:   Wed, 18 May 2022 13:18:41 +0530
Message-ID: <1652860121-24092-7-git-send-email-quic_vivekuma@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
References: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code added in this patch takes backup of different set of
registers during hibernation suspend. On receiving hibernation
restore callback, it restores register values from backup. This
ensures state of hardware to be same just before hibernation and
after restore.

Signed-off-by: Vivek Kumar <quic_vivekuma@quicinc.com>
Signed-off-by: Prasanna Kumar <quic_kprasan@quicinc.com>
---
 drivers/irqchip/irq-gic-v3.c | 138 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 2be8dea..442d32f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -29,6 +29,10 @@
 #include <asm/smp_plat.h>
 #include <asm/virt.h>
 
+#include <linux/syscore_ops.h>
+#include <linux/suspend.h>
+#include <linux/notifier.h>
+
 #include "irq-gic-common.h"
 
 #define GICD_INT_NMI_PRI	(GICD_INT_DEF_PRI & ~0x80)
@@ -56,6 +60,14 @@ struct gic_chip_data {
 	bool			has_rss;
 	unsigned int		ppi_nr;
 	struct partition_desc	**ppi_descs;
+#ifdef CONFIG_HIBERNATION
+	unsigned int enabled_irqs[32];
+	unsigned int active_irqs[32];
+	unsigned int irq_edg_lvl[64];
+	unsigned int ppi_edg_lvl;
+	unsigned int enabled_sgis;
+	unsigned int pending_sgis;
+#endif
 };
 
 static struct gic_chip_data gic_data __read_mostly;
@@ -170,6 +182,9 @@ static enum gic_intid_range get_intid_range(struct irq_data *d)
 	return __get_intid_range(d->hwirq);
 }
 
+static void gic_dist_init(void);
+static void gic_cpu_init(void);
+
 static inline unsigned int gic_irq(struct irq_data *d)
 {
 	return d->hwirq;
@@ -828,7 +843,7 @@ static bool gic_has_group0(void)
 	return val != 0;
 }
 
-static void __init gic_dist_init(void)
+static void gic_dist_init(void)
 {
 	unsigned int i;
 	u64 affinity;
@@ -1399,6 +1414,120 @@ static void gic_cpu_pm_init(void)
 static inline void gic_cpu_pm_init(void) { }
 #endif /* CONFIG_CPU_PM */
 
+#ifdef CONFIG_PM
+#ifdef CONFIG_HIBERNATION
+extern int in_suspend;
+static bool hibernation;
+
+static int gic_suspend_notifier(struct notifier_block *nb,
+				unsigned long event,
+				void *dummy)
+{
+	if (event == PM_HIBERNATION_PREPARE)
+		hibernation = true;
+	else if (event == PM_POST_HIBERNATION)
+		hibernation = false;
+	return NOTIFY_OK;
+}
+
+static struct notifier_block gic_notif_block = {
+	.notifier_call = gic_suspend_notifier,
+};
+
+static void gic_hibernation_suspend(void)
+{
+	int i;
+	void __iomem *base = gic_data.dist_base;
+	void __iomem *rdist_base = gic_data_rdist_sgi_base();
+
+	gic_data.enabled_sgis = readl_relaxed(rdist_base + GICD_ISENABLER);
+	gic_data.pending_sgis = readl_relaxed(rdist_base + GICD_ISPENDR);
+	/* Store edge level for PPIs by reading GICR_ICFGR1 */
+	gic_data.ppi_edg_lvl = readl_relaxed(rdist_base + GICR_ICFGR0 + 4);
+
+	for (i = 0; i * 32 < GIC_LINE_NR; i++) {
+		gic_data.enabled_irqs[i] = readl_relaxed(base +
+						GICD_ISENABLER + i * 4);
+		gic_data.active_irqs[i] = readl_relaxed(base +
+						GICD_ISPENDR + i * 4);
+	}
+
+	for (i = 2; i < GIC_LINE_NR / 16; i++)
+		gic_data.irq_edg_lvl[i] = readl_relaxed(base +
+						GICD_ICFGR + i * 4);
+}
+#endif
+
+static int gic_suspend(void)
+{
+#ifdef CONFIG_HIBERNATION
+	if (unlikely(hibernation))
+		gic_hibernation_suspend();
+#endif
+	return 0;
+}
+
+void gic_resume(void)
+{
+#ifdef CONFIG_HIBERNATION
+	int i;
+	void __iomem *base = gic_data.dist_base;
+	void __iomem *rdist_base = gic_data_rdist_sgi_base();
+
+	/*
+	 * in_suspend is defined in hibernate.c and will be 0 during
+	 * hibernation restore case. Also it willl be 0 for suspend to ram case
+	 * and similar cases. Underlying code will not get executed in regular
+	 * cases and will be executed only for hibernation restore.
+	 */
+	if (unlikely((in_suspend == 0 && hibernation))) {
+		pr_info("Re-initializing gic in hibernation restore\n");
+		gic_dist_init();
+		gic_cpu_init();
+		/* Activate and enable SGIs and PPIs */
+		writel_relaxed(gic_data.enabled_sgis,
+			       rdist_base + GICD_ISENABLER);
+		writel_relaxed(gic_data.pending_sgis,
+			       rdist_base + GICD_ISPENDR);
+		/* Restore edge and level triggers for PPIs from GICR_ICFGR1 */
+		writel_relaxed(gic_data.ppi_edg_lvl,
+			       rdist_base + GICR_ICFGR0 + 4);
+
+		/* Restore edge and level triggers */
+		for (i = 2; i < GIC_LINE_NR / 16; i++)
+			writel_relaxed(gic_data.irq_edg_lvl[i],
+					base + GICD_ICFGR + i * 4);
+		gic_dist_wait_for_rwp();
+
+		/* Activate and enable interrupts from backup */
+		for (i = 0; i * 32 < GIC_LINE_NR; i++) {
+			writel_relaxed(gic_data.active_irqs[i],
+				       base + GICD_ISPENDR + i * 4);
+
+			writel_relaxed(gic_data.enabled_irqs[i],
+				       base + GICD_ISENABLER + i * 4);
+		}
+		gic_dist_wait_for_rwp();
+	}
+#endif
+}
+EXPORT_SYMBOL_GPL(gic_resume);
+
+static struct syscore_ops gic_syscore_ops = {
+	.suspend = gic_suspend,
+	.resume = gic_resume,
+};
+
+static void gic_syscore_init(void)
+{
+	register_syscore_ops(&gic_syscore_ops);
+}
+
+#else
+static inline void gic_syscore_init(void) { }
+void gic_resume(void) { }
+#endif
+
 static struct irq_chip gic_chip = {
 	.name			= "GICv3",
 	.irq_mask		= gic_mask_irq,
@@ -1887,6 +2016,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	gic_cpu_init();
 	gic_smp_init();
 	gic_cpu_pm_init();
+	gic_syscore_init();
 
 	if (gic_dist_supports_lpis()) {
 		its_init(handle, &gic_data.rdists, gic_data.domain);
@@ -2092,7 +2222,11 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 			     redist_stride, &node->fwnode);
 	if (err)
 		goto out_unmap_rdist;
-
+#ifdef CONFIG_HIBERNATION
+	err = register_pm_notifier(&gic_notif_block);
+	if (err)
+		goto out_unmap_rdist;
+#endif
 	gic_populate_ppi_partitions(node);
 
 	if (static_branch_likely(&supports_deactivate_key))
-- 
2.7.4


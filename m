Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5D6592D71
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242017AbiHOJa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiHOJa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:30:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE85292;
        Mon, 15 Aug 2022 02:30:23 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M5pny1d6zz1M8w3;
        Mon, 15 Aug 2022 17:27:02 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 17:30:20 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <Frank.li@nxp.com>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>
CC:     <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <zhangshaokun@hisilicon.com>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <konrad.dybcio@somainline.org>,
        <khuong@os.amperecomputing.com>, <john.garry@huawei.com>,
        <jonathan.cameron@huawei.com>, <yangyicong@hisilicon.com>,
        <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH] drivers/perf: Change WARN_ON() to dev_err() on irq_set_affinity() failure
Date:   Mon, 15 Aug 2022 17:28:15 +0800
Message-ID: <20220815092815.11597-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

The WARN_ON() on irq_set_affinity() failure is misused according to the [1]
and may crash people's box unintentionally. This may also be redundant since
in the failure case we may also trigger the WARN and dump the stack in the
perf core[2] for a second time.

So change the WARN_ON() to dev_err() to just print the failure message.

[1] https://github.com/torvalds/linux/blob/master/include/asm-generic/bug.h#L74
[2] https://github.com/torvalds/linux/blob/master/kernel/events/core.c#L313

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
[https://lore.kernel.org/lkml/YuOi3i0XHV++z1YI@kroah.com/]
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/arm-ccn.c                   | 5 +++--
 drivers/perf/arm_dmc620_pmu.c            | 3 ++-
 drivers/perf/arm_smmuv3_pmu.c            | 6 ++++--
 drivers/perf/fsl_imx8_ddr_perf.c         | 3 ++-
 drivers/perf/hisilicon/hisi_pcie_pmu.c   | 6 ++++--
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 6 ++++--
 drivers/perf/qcom_l2_pmu.c               | 8 ++++++--
 drivers/perf/xgene_pmu.c                 | 6 ++++--
 8 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 728d13d8e98a..83abd909ba49 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1210,8 +1210,9 @@ static int arm_ccn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 		return 0;
 	perf_pmu_migrate_context(&dt->pmu, cpu, target);
 	dt->cpu = target;
-	if (ccn->irq)
-		WARN_ON(irq_set_affinity(ccn->irq, cpumask_of(dt->cpu)));
+	if (ccn->irq && irq_set_affinity(ccn->irq, cpumask_of(dt->cpu)))
+		dev_err(ccn->dev, "Failed to set interrupt affinity\n");
+
 	return 0;
 }
 
diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 280a6ae3e27c..b59d3d9eb779 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -621,7 +621,8 @@ static int dmc620_pmu_cpu_teardown(unsigned int cpu,
 		perf_pmu_migrate_context(&dmc620_pmu->pmu, irq->cpu, target);
 	mutex_unlock(&dmc620_pmu_irqs_lock);
 
-	WARN_ON(irq_set_affinity(irq->irq_num, cpumask_of(target)));
+	if (irq_set_affinity(irq->irq_num, cpumask_of(target)))
+		dev_err(dmc620_pmu->pmu.dev, "Failed to set interrupt affinity\n");
 	irq->cpu = target;
 
 	return 0;
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 00d4c45a8017..05e1b3e274d7 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -646,7 +646,8 @@ static int smmu_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 
 	perf_pmu_migrate_context(&smmu_pmu->pmu, cpu, target);
 	smmu_pmu->on_cpu = target;
-	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(target)));
+	if (irq_set_affinity(smmu_pmu->irq, cpumask_of(target)))
+		dev_err(smmu_pmu->dev, "Failed to set interrupt affinity\n");
 
 	return 0;
 }
@@ -892,7 +893,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 
 	/* Pick one CPU to be the preferred one to use */
 	smmu_pmu->on_cpu = raw_smp_processor_id();
-	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
+	if (irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)))
+		dev_err(dev, "Failed to set interrupt affinity\n");
 
 	err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
 					       &smmu_pmu->node);
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 8e058e08fe81..c44192e2d9db 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -671,7 +671,8 @@ static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
 	pmu->cpu = target;
 
-	WARN_ON(irq_set_affinity(pmu->irq, cpumask_of(pmu->cpu)));
+	if (irq_set_affinity(pmu->irq, cpumask_of(pmu->cpu)))
+		dev_err(pmu->dev, "Failed to set interrupt affinity\n");
 
 	return 0;
 }
diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 21771708597d..90aed9e51396 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -655,7 +655,8 @@ static int hisi_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
 
 	if (pcie_pmu->on_cpu == -1) {
 		pcie_pmu->on_cpu = cpu;
-		WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(cpu)));
+		if (irq_set_affinity(pcie_pmu->irq, cpumask_of(cpu)))
+			pci_err(pcie_pmu->pdev, "Failed to set interrupt affinity\n");
 	}
 
 	return 0;
@@ -681,7 +682,8 @@ static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	perf_pmu_migrate_context(&pcie_pmu->pmu, cpu, target);
 	/* Use this CPU for event counting */
 	pcie_pmu->on_cpu = target;
-	WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(target)));
+	if (irq_set_affinity(pcie_pmu->irq, cpumask_of(target)))
+		pci_err(pcie_pmu->pdev, "Failed to set interrupt affinity\n");
 
 	return 0;
 }
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index fbc8a93d5eac..74397b5ec889 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -492,7 +492,8 @@ int hisi_uncore_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
 	hisi_pmu->on_cpu = cpu;
 
 	/* Overflow interrupt also should use the same CPU */
-	WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(cpu)));
+	if (irq_set_affinity(hisi_pmu->irq, cpumask_of(cpu)))
+		dev_err(hisi_pmu->dev, "Failed to set interrupt affinity\n");
 
 	return 0;
 }
@@ -525,7 +526,8 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	perf_pmu_migrate_context(&hisi_pmu->pmu, cpu, target);
 	/* Use this CPU for event counting */
 	hisi_pmu->on_cpu = target;
-	WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(target)));
+	if (irq_set_affinity(hisi_pmu->irq, cpumask_of(target)))
+		dev_err(hisi_pmu->dev, "Failed to set interrupt affinity\n");
 
 	return 0;
 }
diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 30234c261b05..c6fe01c7e637 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -793,7 +793,9 @@ static int l2cache_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
 	cpumask_set_cpu(cpu, &l2cache_pmu->cpumask);
 	cluster_pmu_reset();
 
-	WARN_ON(irq_set_affinity(cluster->irq, cpumask_of(cpu)));
+	if (irq_set_affinity(cluster->irq, cpumask_of(cpu)))
+		dev_err(&l2cache_pmu->pdev->dev,
+			"Failed to set interrupt affinity\n");
 	enable_irq(cluster->irq);
 
 	return 0;
@@ -831,7 +833,9 @@ static int l2cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	perf_pmu_migrate_context(&l2cache_pmu->pmu, cpu, target);
 	cluster->on_cpu = target;
 	cpumask_set_cpu(target, &l2cache_pmu->cpumask);
-	WARN_ON(irq_set_affinity(cluster->irq, cpumask_of(target)));
+	if (irq_set_affinity(cluster->irq, cpumask_of(target)))
+		dev_err(&l2cache_pmu->pdev->dev,
+			"Failed to set interrupt affinity\n");
 
 	return 0;
 }
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 0c32dffc7ede..f31e678fdb69 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1790,7 +1790,8 @@ static int xgene_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
 		cpumask_set_cpu(cpu, &xgene_pmu->cpu);
 
 	/* Overflow interrupt also should use the same CPU */
-	WARN_ON(irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu));
+	if (irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu))
+		dev_err(xgene_pmu->dev, "Failed to set interrupt affinity\n");
 
 	return 0;
 }
@@ -1823,7 +1824,8 @@ static int xgene_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 
 	cpumask_set_cpu(target, &xgene_pmu->cpu);
 	/* Overflow interrupt also should use the same CPU */
-	WARN_ON(irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu));
+	if (irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu))
+		dev_err(xgene_pmu->dev, "Failed to set interrupt affinity\n");
 
 	return 0;
 }
-- 
2.24.0


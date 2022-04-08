Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6A34F8D8A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiDHFBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiDHFB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:01:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83B319E08E;
        Thu,  7 Apr 2022 21:59:18 -0700 (PDT)
X-UUID: 37a1530a4da5400f95a0daa46f6ac910-20220408
X-UUID: 37a1530a4da5400f95a0daa46f6ac910-20220408
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 510264630; Fri, 08 Apr 2022 12:59:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 8 Apr 2022 12:59:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Apr 2022 12:59:11 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <matthias.bgg@gmail.com>, <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, <hsinyi@google.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH V2 03/15] cpufreq: mediatek: Cleanup variables and error handling in mtk_cpu_dvfs_info_init()
Date:   Fri, 8 Apr 2022 12:58:56 +0800
Message-ID: <20220408045908.21671-4-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Wei Chang <jia-wei.chang@mediatek.com>

- Remove several unnecessary varaibles in mtk_cpu_dvfs_info_init().
- Unify error message format and use dev_err_probe() if possible.

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 89 ++++++++++++------------------
 1 file changed, 34 insertions(+), 55 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 9d7d9c8dc184..e0545aca7e41 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -300,96 +300,75 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 {
 	struct device *cpu_dev;
-	struct regulator *proc_reg = ERR_PTR(-ENODEV);
-	struct regulator *sram_reg = ERR_PTR(-ENODEV);
-	struct clk *cpu_clk = ERR_PTR(-ENODEV);
-	struct clk *inter_clk = ERR_PTR(-ENODEV);
 	struct dev_pm_opp *opp;
 	unsigned long rate;
 	int ret;
 
 	cpu_dev = get_cpu_device(cpu);
 	if (!cpu_dev) {
-		pr_err("failed to get cpu%d device\n", cpu);
+		dev_err(cpu_dev, "failed to get cpu%d device\n", cpu);
 		return -ENODEV;
 	}
+	info->cpu_dev = cpu_dev;
 
-	cpu_clk = clk_get(cpu_dev, "cpu");
-	if (IS_ERR(cpu_clk)) {
-		if (PTR_ERR(cpu_clk) == -EPROBE_DEFER)
-			pr_warn("cpu clk for cpu%d not ready, retry.\n", cpu);
-		else
-			pr_err("failed to get cpu clk for cpu%d\n", cpu);
-
-		ret = PTR_ERR(cpu_clk);
-		return ret;
+	info->cpu_clk = clk_get(cpu_dev, "cpu");
+	if (IS_ERR(info->cpu_clk)) {
+		ret = PTR_ERR(info->cpu_clk);
+		return dev_err_probe(cpu_dev, ret,
+				     "cpu%d: failed to get cpu clk\n", cpu);
 	}
 
-	inter_clk = clk_get(cpu_dev, "intermediate");
-	if (IS_ERR(inter_clk)) {
-		if (PTR_ERR(inter_clk) == -EPROBE_DEFER)
-			pr_warn("intermediate clk for cpu%d not ready, retry.\n",
-				cpu);
-		else
-			pr_err("failed to get intermediate clk for cpu%d\n",
-			       cpu);
-
-		ret = PTR_ERR(inter_clk);
+	info->inter_clk = clk_get(cpu_dev, "intermediate");
+	if (IS_ERR(info->inter_clk)) {
+		ret = PTR_ERR(info->inter_clk);
+		dev_err_probe(cpu_dev, ret,
+			      "cpu%d: failed to get intermediate clk\n", cpu);
 		goto out_free_resources;
 	}
 
-	proc_reg = regulator_get_optional(cpu_dev, "proc");
-	if (IS_ERR(proc_reg)) {
-		if (PTR_ERR(proc_reg) == -EPROBE_DEFER)
-			pr_warn("proc regulator for cpu%d not ready, retry.\n",
-				cpu);
-		else
-			pr_err("failed to get proc regulator for cpu%d\n",
-			       cpu);
-
-		ret = PTR_ERR(proc_reg);
+	info->proc_reg = regulator_get_optional(cpu_dev, "proc");
+	if (IS_ERR(info->proc_reg)) {
+		ret = PTR_ERR(info->proc_reg);
+		dev_err_probe(cpu_dev, ret,
+			      "cpu%d: failed to get proc regulator\n", cpu);
 		goto out_free_resources;
 	}
 
 	/* Both presence and absence of sram regulator are valid cases. */
-	sram_reg = regulator_get_exclusive(cpu_dev, "sram");
+	info->sram_reg = regulator_get_exclusive(cpu_dev, "sram");
+	if (IS_ERR(info->sram_reg))
+		info->sram_reg = NULL;
 
 	/* Get OPP-sharing information from "operating-points-v2" bindings */
 	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, &info->cpus);
 	if (ret) {
-		pr_err("failed to get OPP-sharing information for cpu%d\n",
-		       cpu);
+		dev_err(cpu_dev,
+			"cpu%d: failed to get OPP-sharing information\n", cpu);
 		goto out_free_resources;
 	}
 
 	ret = dev_pm_opp_of_cpumask_add_table(&info->cpus);
 	if (ret) {
-		pr_warn("no OPP table for cpu%d\n", cpu);
+		dev_warn(cpu_dev, "cpu%d: no OPP table\n", cpu);
 		goto out_free_resources;
 	}
 
 	/* Search a safe voltage for intermediate frequency. */
-	rate = clk_get_rate(inter_clk);
+	rate = clk_get_rate(info->inter_clk);
 	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
 	if (IS_ERR(opp)) {
-		pr_err("failed to get intermediate opp for cpu%d\n", cpu);
+		dev_err(cpu_dev, "cpu%d: failed to get intermediate opp\n", cpu);
 		ret = PTR_ERR(opp);
 		goto out_free_opp_table;
 	}
 	info->intermediate_voltage = dev_pm_opp_get_voltage(opp);
 	dev_pm_opp_put(opp);
 
-	info->cpu_dev = cpu_dev;
-	info->proc_reg = proc_reg;
-	info->sram_reg = IS_ERR(sram_reg) ? NULL : sram_reg;
-	info->cpu_clk = cpu_clk;
-	info->inter_clk = inter_clk;
-
 	/*
 	 * If SRAM regulator is present, software "voltage tracking" is needed
 	 * for this CPU power domain.
 	 */
-	info->need_voltage_tracking = !IS_ERR(sram_reg);
+	info->need_voltage_tracking = (info->sram_reg != NULL);
 
 	return 0;
 
@@ -397,14 +376,14 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
 
 out_free_resources:
-	if (!IS_ERR(proc_reg))
-		regulator_put(proc_reg);
-	if (!IS_ERR(sram_reg))
-		regulator_put(sram_reg);
-	if (!IS_ERR(cpu_clk))
-		clk_put(cpu_clk);
-	if (!IS_ERR(inter_clk))
-		clk_put(inter_clk);
+	if (!IS_ERR(info->proc_reg))
+		regulator_put(info->proc_reg);
+	if (!IS_ERR(info->sram_reg))
+		regulator_put(info->sram_reg);
+	if (!IS_ERR(info->cpu_clk))
+		clk_put(info->cpu_clk);
+	if (!IS_ERR(info->inter_clk))
+		clk_put(info->inter_clk);
 
 	return ret;
 }
-- 
2.18.0


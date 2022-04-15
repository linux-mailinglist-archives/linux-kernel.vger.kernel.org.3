Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16913502523
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350707AbiDOGDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350243AbiDOGCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:02:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7A225D3;
        Thu, 14 Apr 2022 22:59:31 -0700 (PDT)
X-UUID: c900fbb2368b4d348236a39a9c5f45a4-20220415
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:c3bf4d8c-056b-41fe-8be0-9ec7c3c1d6cb,OB:0,LO
        B:30,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:95
X-CID-INFO: VERSION:1.1.4,REQID:c3bf4d8c-056b-41fe-8be0-9ec7c3c1d6cb,OB:0,LOB:
        30,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:95
X-CID-META: VersionHash:faefae9,CLOUDID:9c133aa9-d103-4e36-82b9-b0e86991b3df,C
        OID:FAIL,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,Q
        S:0,BEC:nil
X-UUID: c900fbb2368b4d348236a39a9c5f45a4-20220415
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1694444438; Fri, 15 Apr 2022 13:59:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 15 Apr 2022 13:59:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Apr 2022 13:59:19 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <jia-wei.chang@mediatek.com>, <roger.lu@mediatek.com>,
        <hsinyi@google.com>, <khilman@baylibre.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH V3 06/15] cpufreq: mediatek: Move voltage limits to platform data
Date:   Fri, 15 Apr 2022 13:59:07 +0800
Message-ID: <20220415055916.28350-7-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Wei Chang <jia-wei.chang@mediatek.com>

Voltages and shifts are defined as macros originally.
There are different requirements of these values for each MediaTek SoCs.
Therefore, we add the platform data and move these values into it.

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 90 ++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 29 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 221f249f8d21..ebc4bfd66ad5 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -10,15 +10,21 @@
 #include <linux/cpumask.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/regulator/consumer.h>
 
-#define MIN_VOLT_SHIFT		(100000)
-#define MAX_VOLT_SHIFT		(200000)
-#define MAX_VOLT_LIMIT		(1150000)
 #define VOLT_TOL		(10000)
 
+struct mtk_cpufreq_platform_data {
+	int min_volt_shift;
+	int max_volt_shift;
+	int proc_max_volt;
+	int sram_min_volt;
+	int sram_max_volt;
+};
+
 /*
  * The struct mtk_cpu_dvfs_info holds necessary information for doing CPU DVFS
  * on each CPU power/clock domain of Mediatek SoCs. Each CPU cluster in
@@ -46,8 +52,11 @@ struct mtk_cpu_dvfs_info {
 	struct notifier_block opp_nb;
 	int opp_cpu;
 	unsigned long opp_freq;
+	const struct mtk_cpufreq_platform_data *soc_data;
 };
 
+static struct platform_device *cpufreq_pdev;
+
 static LIST_HEAD(dvfs_info_list);
 
 static struct mtk_cpu_dvfs_info *mtk_cpu_dvfs_info_lookup(int cpu)
@@ -65,6 +74,7 @@ static struct mtk_cpu_dvfs_info *mtk_cpu_dvfs_info_lookup(int cpu)
 static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 					int new_vproc)
 {
+	const struct mtk_cpufreq_platform_data *soc_data = info->soc_data;
 	struct regulator *proc_reg = info->proc_reg;
 	struct regulator *sram_reg = info->sram_reg;
 	int pre_vproc, pre_vsram, new_vsram, vsram, vproc, ret;
@@ -76,7 +86,8 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 		return pre_vproc;
 	}
 	/* Vsram should not exceed the maximum allowed voltage of SoC. */
-	new_vsram = min(new_vproc + MIN_VOLT_SHIFT, MAX_VOLT_LIMIT);
+	new_vsram = min(new_vproc + soc_data->min_volt_shift,
+			soc_data->sram_max_volt);
 
 	if (pre_vproc < new_vproc) {
 		/*
@@ -99,10 +110,11 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 				return pre_vproc;
 			}
 
-			vsram = min(new_vsram, pre_vproc + MAX_VOLT_SHIFT);
+			vsram = min(new_vsram,
+				    pre_vproc + soc_data->min_volt_shift);
 
-			if (vsram + VOLT_TOL >= MAX_VOLT_LIMIT) {
-				vsram = MAX_VOLT_LIMIT;
+			if (vsram + VOLT_TOL >= soc_data->sram_max_volt) {
+				vsram = soc_data->sram_max_volt;
 
 				/*
 				 * If the target Vsram hits the maximum voltage,
@@ -120,7 +132,7 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 				ret = regulator_set_voltage(sram_reg, vsram,
 							    vsram + VOLT_TOL);
 
-				vproc = vsram - MIN_VOLT_SHIFT;
+				vproc = vsram - soc_data->min_volt_shift;
 			}
 			if (ret)
 				return ret;
@@ -154,7 +166,8 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 				return pre_vsram;
 			}
 
-			vproc = max(new_vproc, pre_vsram - MAX_VOLT_SHIFT);
+			vproc = max(new_vproc,
+				    pre_vsram - soc_data->max_volt_shift);
 			ret = regulator_set_voltage(proc_reg, vproc,
 						    vproc + VOLT_TOL);
 			if (ret)
@@ -163,10 +176,11 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 			if (vproc == new_vproc)
 				vsram = new_vsram;
 			else
-				vsram = max(new_vsram, vproc + MIN_VOLT_SHIFT);
+				vsram = max(new_vsram,
+					    vproc + soc_data->min_volt_shift);
 
-			if (vsram + VOLT_TOL >= MAX_VOLT_LIMIT) {
-				vsram = MAX_VOLT_LIMIT;
+			if (vsram + VOLT_TOL >= soc_data->sram_max_volt) {
+				vsram = soc_data->sram_max_volt;
 
 				/*
 				 * If the target Vsram hits the maximum voltage,
@@ -197,13 +211,14 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 
 static int mtk_cpufreq_set_voltage(struct mtk_cpu_dvfs_info *info, int vproc)
 {
+	const struct mtk_cpufreq_platform_data *soc_data = info->soc_data;
 	int ret;
 
 	if (info->need_voltage_tracking)
 		ret = mtk_cpufreq_voltage_tracking(info, vproc);
 	else
 		ret = regulator_set_voltage(info->proc_reg, vproc,
-					    MAX_VOLT_LIMIT);
+					    soc_data->proc_max_volt);
 	if (!ret)
 		info->pre_vproc = vproc;
 
@@ -581,9 +596,17 @@ static struct cpufreq_driver mtk_cpufreq_driver = {
 
 static int mtk_cpufreq_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
 	struct mtk_cpu_dvfs_info *info, *tmp;
 	int cpu, ret;
 
+	match = dev_get_platdata(&pdev->dev);
+	if (!match || !match->data) {
+		dev_err(&pdev->dev,
+			"failed to get mtk cpufreq platform data\n");
+		return -ENODEV;
+	}
+
 	for_each_possible_cpu(cpu) {
 		info = mtk_cpu_dvfs_info_lookup(cpu);
 		if (info)
@@ -595,6 +618,7 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
 			goto release_dvfs_info_list;
 		}
 
+		info->soc_data = match->data;
 		ret = mtk_cpu_dvfs_info_init(info, cpu);
 		if (ret) {
 			dev_err(&pdev->dev,
@@ -630,20 +654,27 @@ static struct platform_driver mtk_cpufreq_platdrv = {
 	.probe		= mtk_cpufreq_probe,
 };
 
+static const struct mtk_cpufreq_platform_data mt2701_platform_data = {
+	.min_volt_shift = 100000,
+	.max_volt_shift = 200000,
+	.proc_max_volt = 1150000,
+	.sram_min_volt = 0,
+	.sram_max_volt = 1150000,
+};
+
 /* List of machines supported by this driver */
 static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
-	{ .compatible = "mediatek,mt2701", },
-	{ .compatible = "mediatek,mt2712", },
-	{ .compatible = "mediatek,mt7622", },
-	{ .compatible = "mediatek,mt7623", },
-	{ .compatible = "mediatek,mt8167", },
-	{ .compatible = "mediatek,mt817x", },
-	{ .compatible = "mediatek,mt8173", },
-	{ .compatible = "mediatek,mt8176", },
-	{ .compatible = "mediatek,mt8183", },
-	{ .compatible = "mediatek,mt8365", },
-	{ .compatible = "mediatek,mt8516", },
-
+	{ .compatible = "mediatek,mt2701", .data = &mt2701_platform_data },
+	{ .compatible = "mediatek,mt2712", .data = &mt2701_platform_data },
+	{ .compatible = "mediatek,mt7622", .data = &mt2701_platform_data },
+	{ .compatible = "mediatek,mt7623", .data = &mt2701_platform_data },
+	{ .compatible = "mediatek,mt8167", .data = &mt2701_platform_data },
+	{ .compatible = "mediatek,mt817x", .data = &mt2701_platform_data },
+	{ .compatible = "mediatek,mt8173", .data = &mt2701_platform_data },
+	{ .compatible = "mediatek,mt8176", .data = &mt2701_platform_data },
+	{ .compatible = "mediatek,mt8183", .data = &mt2701_platform_data },
+	{ .compatible = "mediatek,mt8365", .data = &mt2701_platform_data },
+	{ .compatible = "mediatek,mt8516", .data = &mt2701_platform_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_cpufreq_machines);
@@ -652,7 +683,6 @@ static int __init mtk_cpufreq_driver_init(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
-	struct platform_device *pdev;
 	int err;
 
 	np = of_find_node_by_path("/");
@@ -676,11 +706,12 @@ static int __init mtk_cpufreq_driver_init(void)
 	 * and the device registration codes are put here to handle defer
 	 * probing.
 	 */
-	pdev = platform_device_register_simple("mtk-cpufreq", -1, NULL, 0);
-	if (IS_ERR(pdev)) {
+	cpufreq_pdev = platform_device_register_data(NULL, "mtk-cpufreq", -1,
+						     match, sizeof(*match));
+	if (IS_ERR(cpufreq_pdev)) {
 		pr_err("failed to register mtk-cpufreq platform device\n");
 		platform_driver_unregister(&mtk_cpufreq_platdrv);
-		return PTR_ERR(pdev);
+		return PTR_ERR(cpufreq_pdev);
 	}
 
 	return 0;
@@ -689,6 +720,7 @@ module_init(mtk_cpufreq_driver_init)
 
 static void __exit mtk_cpufreq_driver_exit(void)
 {
+	platform_device_unregister(cpufreq_pdev);
 	platform_driver_unregister(&mtk_cpufreq_platdrv);
 }
 module_exit(mtk_cpufreq_driver_exit)
-- 
2.18.0


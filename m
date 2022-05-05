Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A47F51BE81
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358685AbiEEL43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356209AbiEEL41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:56:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FD754696;
        Thu,  5 May 2022 04:52:41 -0700 (PDT)
X-UUID: 3357646738684a098c04ee1ab0358742-20220505
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:d304df2c-ad96-430f-8eaa-ff25fa176b05,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:1794b1b2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 3357646738684a098c04ee1ab0358742-20220505
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1062747904; Thu, 05 May 2022 19:52:35 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 5 May 2022 19:52:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 5 May 2022 19:52:34 +0800
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
Subject: [PATCH v6 03/10] cpufreq: mediatek: Move voltage limits to platform data
Date:   Thu, 5 May 2022 19:52:19 +0800
Message-ID: <20220505115226.20130-4-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220505115226.20130-1-rex-bc.chen@mediatek.com>
References: <20220505115226.20130-1-rex-bc.chen@mediatek.com>
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

Voltages and shifts are defined as macros originally.
There are different requirements of these values for each MediaTek SoCs.
Therefore, we add the platform data and move these values into it.

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 84 +++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index d15cbef4a72e..0b6c3479c8cc 100644
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
@@ -41,6 +47,7 @@ struct mtk_cpu_dvfs_info {
 	int intermediate_voltage;
 	bool need_voltage_tracking;
 	int pre_vproc;
+	const struct mtk_cpufreq_platform_data *soc_data;
 };
 
 static struct platform_device *cpufreq_pdev;
@@ -62,6 +69,7 @@ static struct mtk_cpu_dvfs_info *mtk_cpu_dvfs_info_lookup(int cpu)
 static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 					int new_vproc)
 {
+	const struct mtk_cpufreq_platform_data *soc_data = info->soc_data;
 	struct regulator *proc_reg = info->proc_reg;
 	struct regulator *sram_reg = info->sram_reg;
 	int pre_vproc, pre_vsram, new_vsram, vsram, vproc, ret;
@@ -73,7 +81,8 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 		return pre_vproc;
 	}
 	/* Vsram should not exceed the maximum allowed voltage of SoC. */
-	new_vsram = min(new_vproc + MIN_VOLT_SHIFT, MAX_VOLT_LIMIT);
+	new_vsram = min(new_vproc + soc_data->min_volt_shift,
+			soc_data->sram_max_volt);
 
 	if (pre_vproc < new_vproc) {
 		/*
@@ -96,10 +105,11 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
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
@@ -117,7 +127,7 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 				ret = regulator_set_voltage(sram_reg, vsram,
 							    vsram + VOLT_TOL);
 
-				vproc = vsram - MIN_VOLT_SHIFT;
+				vproc = vsram - soc_data->min_volt_shift;
 			}
 			if (ret)
 				return ret;
@@ -151,7 +161,8 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 				return pre_vsram;
 			}
 
-			vproc = max(new_vproc, pre_vsram - MAX_VOLT_SHIFT);
+			vproc = max(new_vproc,
+				    pre_vsram - soc_data->max_volt_shift);
 			ret = regulator_set_voltage(proc_reg, vproc,
 						    vproc + VOLT_TOL);
 			if (ret)
@@ -160,10 +171,11 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
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
@@ -194,13 +206,14 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 
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
 
@@ -509,9 +522,17 @@ static struct cpufreq_driver mtk_cpufreq_driver = {
 
 static int mtk_cpufreq_probe(struct platform_device *pdev)
 {
+	const struct mtk_cpufreq_platform_data *data;
 	struct mtk_cpu_dvfs_info *info, *tmp;
 	int cpu, ret;
 
+	data = dev_get_platdata(&pdev->dev);
+	if (!data) {
+		dev_err(&pdev->dev,
+			"failed to get mtk cpufreq platform data\n");
+		return -ENODEV;
+	}
+
 	for_each_possible_cpu(cpu) {
 		info = mtk_cpu_dvfs_info_lookup(cpu);
 		if (info)
@@ -523,6 +544,7 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
 			goto release_dvfs_info_list;
 		}
 
+		info->soc_data = data;
 		ret = mtk_cpu_dvfs_info_init(info, cpu);
 		if (ret) {
 			dev_err(&pdev->dev,
@@ -558,20 +580,27 @@ static struct platform_driver mtk_cpufreq_platdrv = {
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
@@ -580,6 +609,7 @@ static int __init mtk_cpufreq_driver_init(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
+	const struct mtk_cpufreq_platform_data *data;
 	int err;
 
 	np = of_find_node_by_path("/");
@@ -592,6 +622,7 @@ static int __init mtk_cpufreq_driver_init(void)
 		pr_debug("Machine is not compatible with mtk-cpufreq\n");
 		return -ENODEV;
 	}
+	data = match->data;
 
 	err = platform_driver_register(&mtk_cpufreq_platdrv);
 	if (err)
@@ -603,7 +634,8 @@ static int __init mtk_cpufreq_driver_init(void)
 	 * and the device registration codes are put here to handle defer
 	 * probing.
 	 */
-	cpufreq_pdev = platform_device_register_simple("mtk-cpufreq", -1, NULL, 0);
+	cpufreq_pdev = platform_device_register_data(NULL, "mtk-cpufreq", -1,
+						     data, sizeof(*data));
 	if (IS_ERR(cpufreq_pdev)) {
 		pr_err("failed to register mtk-cpufreq platform device\n");
 		platform_driver_unregister(&mtk_cpufreq_platdrv);
-- 
2.18.0


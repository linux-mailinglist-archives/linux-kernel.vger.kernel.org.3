Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46238502536
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350657AbiDOGC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350238AbiDOGCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:02:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE7063C0;
        Thu, 14 Apr 2022 22:59:32 -0700 (PDT)
X-UUID: 380f74a35ed141589afb6213263b7cc9-20220415
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:8d39a50a-966e-4d19-b54f-d5210416199b,OB:0,LO
        B:40,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:75
X-CID-INFO: VERSION:1.1.4,REQID:8d39a50a-966e-4d19-b54f-d5210416199b,OB:0,LOB:
        40,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:75
X-CID-META: VersionHash:faefae9,CLOUDID:9d133aa9-d103-4e36-82b9-b0e86991b3df,C
        OID:FAIL,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,Q
        S:0,BEC:nil
X-UUID: 380f74a35ed141589afb6213263b7cc9-20220415
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1250411424; Fri, 15 Apr 2022 13:59:21 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 15 Apr 2022 13:59:20 +0800
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
Subject: [PATCH V3 11/15] cpufreq: mediatek: Link CCI device to CPU
Date:   Fri, 15 Apr 2022 13:59:12 +0800
Message-ID: <20220415055916.28350-12-rex-bc.chen@mediatek.com>
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

In some MediaTek SoCs, like MT8183, CPU and CCI share the same power
supplies. Cpufreq needs to check if CCI devfreq exists and wait until
CCI devfreq ready before scaling frequency.

Before CCI devfreq is ready, we record the voltage when booting to
kernel and use the max(cpu target voltage, booting voltage) to
prevent cpufreq adjust to the lower voltage which will cause the CCI
crash because of high frequency and low voltage.

- Add is_ccifreq_ready() to link CCI device to CPI, and CPU will start
  DVFS when CCI is ready.
- Add platform data for MT8183.

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 80 +++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index d4c00237e862..dd3f739fede1 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -22,6 +22,7 @@ struct mtk_cpufreq_platform_data {
 	int proc_max_volt;
 	int sram_min_volt;
 	int sram_max_volt;
+	bool ccifreq_supported;
 };
 
 /*
@@ -38,6 +39,7 @@ struct mtk_cpufreq_platform_data {
 struct mtk_cpu_dvfs_info {
 	struct cpumask cpus;
 	struct device *cpu_dev;
+	struct device *cci_dev;
 	struct regulator *proc_reg;
 	struct regulator *sram_reg;
 	struct clk *cpu_clk;
@@ -45,6 +47,7 @@ struct mtk_cpu_dvfs_info {
 	struct list_head list_head;
 	int intermediate_voltage;
 	bool need_voltage_tracking;
+	int vproc_on_boot;
 	int pre_vproc;
 	/* Avoid race condition for regulators between notify and policy */
 	struct mutex reg_lock;
@@ -52,6 +55,7 @@ struct mtk_cpu_dvfs_info {
 	int opp_cpu;
 	unsigned long opp_freq;
 	const struct mtk_cpufreq_platform_data *soc_data;
+	bool ccifreq_bound;
 };
 
 static struct platform_device *cpufreq_pdev;
@@ -188,6 +192,28 @@ static int mtk_cpufreq_set_voltage(struct mtk_cpu_dvfs_info *info, int vproc)
 	return ret;
 }
 
+static bool is_ccifreq_ready(struct mtk_cpu_dvfs_info *info)
+{
+	struct device_link *sup_link;
+
+	if (info->ccifreq_bound)
+		return true;
+
+	sup_link = device_link_add(info->cpu_dev, info->cci_dev,
+				   DL_FLAG_AUTOREMOVE_CONSUMER);
+	if (!sup_link) {
+		dev_err(info->cpu_dev, "cpu%d: sup_link is NULL\n", info->opp_cpu);
+		return false;
+	}
+
+	if (sup_link->supplier->links.status != DL_DEV_DRIVER_BOUND)
+		return false;
+
+	info->ccifreq_bound = true;
+
+	return true;
+}
+
 static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 				  unsigned int index)
 {
@@ -225,6 +251,14 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	vproc = dev_pm_opp_get_voltage(opp);
 	dev_pm_opp_put(opp);
 
+	/*
+	 * If MediaTek cci is supported but is not ready, we will use the value
+	 * of max(target cpu voltage, booting voltage) to prevent high freqeuncy
+	 * low voltage crash.
+	 */
+	if (info->soc_data->ccifreq_supported && !is_ccifreq_ready(info))
+		vproc = max(vproc, info->vproc_on_boot);
+
 	/*
 	 * If the new voltage or the intermediate voltage is higher than the
 	 * current voltage, scale up voltage first.
@@ -346,6 +380,23 @@ static int mtk_cpufreq_opp_notifier(struct notifier_block *nb,
 	return notifier_from_errno(ret);
 }
 
+static struct device *of_get_cci(struct device *cpu_dev)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+
+	np = of_parse_phandle(cpu_dev->of_node, "mediatek,cci", 0);
+	if (IS_ERR_OR_NULL(np))
+		return NULL;
+
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (IS_ERR_OR_NULL(pdev))
+		return NULL;
+
+	return &pdev->dev;
+}
+
 static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 {
 	struct device *cpu_dev;
@@ -360,6 +411,16 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	}
 	info->cpu_dev = cpu_dev;
 
+	info->ccifreq_bound = false;
+	if (info->soc_data->ccifreq_supported) {
+		info->cci_dev = of_get_cci(info->cpu_dev);
+		if (IS_ERR_OR_NULL(info->cci_dev)) {
+			ret = PTR_ERR(info->cci_dev);
+			dev_err(cpu_dev, "cpu%d: failed to get cci device\n", cpu);
+			return -ENODEV;
+		}
+	}
+
 	info->cpu_clk = clk_get(cpu_dev, "cpu");
 	if (IS_ERR(info->cpu_clk)) {
 		ret = PTR_ERR(info->cpu_clk);
@@ -423,6 +484,13 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	if (ret)
 		goto out_disable_mux_clock;
 
+	info->vproc_on_boot = regulator_get_voltage(info->proc_reg);
+	if (info->vproc_on_boot < 0) {
+		dev_err(info->cpu_dev,
+			"invalid Vproc value: %d\n", info->vproc_on_boot);
+		goto out_disable_inter_clock;
+	}
+
 	/* Search a safe voltage for intermediate frequency. */
 	rate = clk_get_rate(info->inter_clk);
 	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
@@ -623,6 +691,16 @@ static const struct mtk_cpufreq_platform_data mt2701_platform_data = {
 	.proc_max_volt = 1150000,
 	.sram_min_volt = 0,
 	.sram_max_volt = 1150000,
+	.ccifreq_supported = false,
+};
+
+static const struct mtk_cpufreq_platform_data mt8183_platform_data = {
+	.min_volt_shift = 100000,
+	.max_volt_shift = 200000,
+	.proc_max_volt = 1150000,
+	.sram_min_volt = 0,
+	.sram_max_volt = 1150000,
+	.ccifreq_supported = true,
 };
 
 /* List of machines supported by this driver */
@@ -635,7 +713,7 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 	{ .compatible = "mediatek,mt817x", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt8173", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt8176", .data = &mt2701_platform_data },
-	{ .compatible = "mediatek,mt8183", .data = &mt2701_platform_data },
+	{ .compatible = "mediatek,mt8183", .data = &mt8183_platform_data },
 	{ .compatible = "mediatek,mt8365", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt8516", .data = &mt2701_platform_data },
 	{ }
-- 
2.18.0


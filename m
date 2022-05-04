Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F78751A05B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiEDNKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350200AbiEDNJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:09:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B392DA9B;
        Wed,  4 May 2022 06:05:52 -0700 (PDT)
X-UUID: ad26d81e1d15409196e62563f77b68fc-20220504
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:576b7779-7dd4-404c-8ebe-10aa4da612b5,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:385e8cb2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: ad26d81e1d15409196e62563f77b68fc-20220504
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 571115399; Wed, 04 May 2022 21:05:43 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 4 May 2022 21:05:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 4 May 2022 21:05:41 +0800
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
Subject: [PATCH v5 5/9] cpufreq: mediatek: Link CCI device to CPU
Date:   Wed, 4 May 2022 21:05:36 +0800
Message-ID: <20220504130540.5902-6-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220504130540.5902-1-rex-bc.chen@mediatek.com>
References: <20220504130540.5902-1-rex-bc.chen@mediatek.com>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 82 +++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index c9f09ddd4428..1a4c95e06b0e 100644
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
@@ -53,6 +56,7 @@ struct mtk_cpu_dvfs_info {
 	unsigned long opp_freq;
 	const struct mtk_cpufreq_platform_data *soc_data;
 	int vtrack_max;
+	bool ccifreq_bound;
 };
 
 static struct platform_device *cpufreq_pdev;
@@ -171,6 +175,28 @@ static int mtk_cpufreq_set_voltage(struct mtk_cpu_dvfs_info *info, int vproc)
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
@@ -210,6 +236,14 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
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
@@ -331,6 +365,23 @@ static int mtk_cpufreq_opp_notifier(struct notifier_block *nb,
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
@@ -345,6 +396,16 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
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
@@ -408,6 +469,15 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	if (ret)
 		goto out_disable_mux_clock;
 
+	if (info->soc_data->ccifreq_supported) {
+		info->vproc_on_boot = regulator_get_voltage(info->proc_reg);
+		if (info->vproc_on_boot < 0) {
+			dev_err(info->cpu_dev,
+				"invalid Vproc value: %d\n", info->vproc_on_boot);
+			goto out_disable_inter_clock;
+		}
+	}
+
 	/* Search a safe voltage for intermediate frequency. */
 	rate = clk_get_rate(info->inter_clk);
 	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
@@ -617,6 +687,16 @@ static const struct mtk_cpufreq_platform_data mt2701_platform_data = {
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
@@ -629,7 +709,7 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
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


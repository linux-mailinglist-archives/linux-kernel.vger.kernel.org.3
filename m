Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FAD50251C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350313AbiDOGCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350184AbiDOGB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:01:56 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EEF63C0;
        Thu, 14 Apr 2022 22:59:27 -0700 (PDT)
X-UUID: e39b32a0edac40ea8915398fa27b2dbb-20220415
X-UUID: e39b32a0edac40ea8915398fa27b2dbb-20220415
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 360693418; Fri, 15 Apr 2022 13:59:19 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 15 Apr 2022 13:59:19 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 15 Apr
 2022 13:59:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Apr 2022 13:59:18 +0800
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
Subject: [PATCH V3 02/15] cpufreq: mediatek: Use device print to show logs
Date:   Fri, 15 Apr 2022 13:59:03 +0800
Message-ID: <20220415055916.28350-3-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Replace pr_* with dev_* to show logs.
- Remove usage of __func__.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 54 ++++++++++++++++--------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index dc4a87e68940..e040f3574af9 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -65,7 +65,8 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 
 	old_vproc = regulator_get_voltage(proc_reg);
 	if (old_vproc < 0) {
-		pr_err("%s: invalid Vproc value: %d\n", __func__, old_vproc);
+		dev_err(info->cpu_dev,
+			"invalid Vproc value: %d\n", old_vproc);
 		return old_vproc;
 	}
 	/* Vsram should not exceed the maximum allowed voltage of SoC. */
@@ -81,14 +82,14 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 		do {
 			old_vsram = regulator_get_voltage(sram_reg);
 			if (old_vsram < 0) {
-				pr_err("%s: invalid Vsram value: %d\n",
-				       __func__, old_vsram);
+				dev_err(info->cpu_dev,
+					"invalid Vsram value: %d\n", old_vsram);
 				return old_vsram;
 			}
 			old_vproc = regulator_get_voltage(proc_reg);
 			if (old_vproc < 0) {
-				pr_err("%s: invalid Vproc value: %d\n",
-				       __func__, old_vproc);
+				dev_err(info->cpu_dev,
+					"invalid Vproc value: %d\n", old_vproc);
 				return old_vproc;
 			}
 
@@ -136,14 +137,14 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 		do {
 			old_vproc = regulator_get_voltage(proc_reg);
 			if (old_vproc < 0) {
-				pr_err("%s: invalid Vproc value: %d\n",
-				       __func__, old_vproc);
+				dev_err(info->cpu_dev,
+					"invalid Vproc value: %d\n", old_vproc);
 				return old_vproc;
 			}
 			old_vsram = regulator_get_voltage(sram_reg);
 			if (old_vsram < 0) {
-				pr_err("%s: invalid Vsram value: %d\n",
-				       __func__, old_vsram);
+				dev_err(info->cpu_dev,
+					"invalid Vsram value: %d\n", old_vsram);
 				return old_vsram;
 			}
 
@@ -214,7 +215,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	old_freq_hz = clk_get_rate(cpu_clk);
 	old_vproc = regulator_get_voltage(info->proc_reg);
 	if (old_vproc < 0) {
-		pr_err("%s: invalid Vproc value: %d\n", __func__, old_vproc);
+		dev_err(cpu_dev, "invalid Vproc value: %d\n", old_vproc);
 		return old_vproc;
 	}
 
@@ -222,8 +223,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 
 	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
 	if (IS_ERR(opp)) {
-		pr_err("cpu%d: failed to find OPP for %ld\n",
-		       policy->cpu, freq_hz);
+		dev_err(cpu_dev, "cpu%d: failed to find OPP for %ld\n",
+			policy->cpu, freq_hz);
 		return PTR_ERR(opp);
 	}
 	vproc = dev_pm_opp_get_voltage(opp);
@@ -237,8 +238,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	if (old_vproc < target_vproc) {
 		ret = mtk_cpufreq_set_voltage(info, target_vproc);
 		if (ret) {
-			pr_err("cpu%d: failed to scale up voltage!\n",
-			       policy->cpu);
+			dev_err(cpu_dev,
+				"cpu%d: failed to scale up voltage!\n", policy->cpu);
 			mtk_cpufreq_set_voltage(info, old_vproc);
 			return ret;
 		}
@@ -247,8 +248,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	/* Reparent the CPU clock to intermediate clock. */
 	ret = clk_set_parent(cpu_clk, info->inter_clk);
 	if (ret) {
-		pr_err("cpu%d: failed to re-parent cpu clock!\n",
-		       policy->cpu);
+		dev_err(cpu_dev,
+			"cpu%d: failed to re-parent cpu clock!\n", policy->cpu);
 		mtk_cpufreq_set_voltage(info, old_vproc);
 		WARN_ON(1);
 		return ret;
@@ -257,8 +258,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	/* Set the original PLL to target rate. */
 	ret = clk_set_rate(armpll, freq_hz);
 	if (ret) {
-		pr_err("cpu%d: failed to scale cpu clock rate!\n",
-		       policy->cpu);
+		dev_err(cpu_dev,
+			"cpu%d: failed to scale cpu clock rate!\n", policy->cpu);
 		clk_set_parent(cpu_clk, armpll);
 		mtk_cpufreq_set_voltage(info, old_vproc);
 		return ret;
@@ -267,8 +268,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	/* Set parent of CPU clock back to the original PLL. */
 	ret = clk_set_parent(cpu_clk, armpll);
 	if (ret) {
-		pr_err("cpu%d: failed to re-parent cpu clock!\n",
-		       policy->cpu);
+		dev_err(cpu_dev,
+			"cpu%d: failed to re-parent cpu clock!\n", policy->cpu);
 		mtk_cpufreq_set_voltage(info, inter_vproc);
 		WARN_ON(1);
 		return ret;
@@ -281,8 +282,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	if (vproc < inter_vproc || vproc < old_vproc) {
 		ret = mtk_cpufreq_set_voltage(info, vproc);
 		if (ret) {
-			pr_err("cpu%d: failed to scale down voltage!\n",
-			       policy->cpu);
+			dev_err(cpu_dev,
+				"cpu%d: failed to scale down voltage!\n", policy->cpu);
 			clk_set_parent(cpu_clk, info->inter_clk);
 			clk_set_rate(armpll, old_freq_hz);
 			clk_set_parent(cpu_clk, armpll);
@@ -448,15 +449,16 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 
 	info = mtk_cpu_dvfs_info_lookup(policy->cpu);
 	if (!info) {
-		pr_err("dvfs info for cpu%d is not initialized.\n",
-		       policy->cpu);
+		dev_err(info->cpu_dev,
+			"dvfs info for cpu%d is not initialized.\n", policy->cpu);
 		return -EINVAL;
 	}
 
 	ret = dev_pm_opp_init_cpufreq_table(info->cpu_dev, &freq_table);
 	if (ret) {
-		pr_err("failed to init cpufreq table for cpu%d: %d\n",
-		       policy->cpu, ret);
+		dev_err(info->cpu_dev,
+			"failed to init cpufreq table for cpu%d: %d\n",
+			policy->cpu, ret);
 		return ret;
 	}
 
-- 
2.18.0


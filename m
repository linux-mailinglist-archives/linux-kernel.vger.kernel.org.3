Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D474450B23A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445217AbiDVH4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445091AbiDVHzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:55:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9D651E50;
        Fri, 22 Apr 2022 00:52:56 -0700 (PDT)
X-UUID: effb9d6c119640f2980a5de4d55403ff-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:152746a7-88ec-4398-a7d2-6d315cc7852d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:a53f97f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: effb9d6c119640f2980a5de4d55403ff-20220422
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 654765445; Fri, 22 Apr 2022 15:52:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 22 Apr 2022 15:52:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 15:52:43 +0800
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
Subject: [PATCH V4 03/14] cpufreq: mediatek: Replace old_* with pre_*
Date:   Fri, 22 Apr 2022 15:52:28 +0800
Message-ID: <20220422075239.16437-4-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make driver more readable, replace old_* with pre_*.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 84 +++++++++++++++---------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index e040f3574af9..ff27f77e8ee6 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -61,18 +61,18 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 {
 	struct regulator *proc_reg = info->proc_reg;
 	struct regulator *sram_reg = info->sram_reg;
-	int old_vproc, old_vsram, new_vsram, vsram, vproc, ret;
+	int pre_vproc, pre_vsram, new_vsram, vsram, vproc, ret;
 
-	old_vproc = regulator_get_voltage(proc_reg);
-	if (old_vproc < 0) {
+	pre_vproc = regulator_get_voltage(proc_reg);
+	if (pre_vproc < 0) {
 		dev_err(info->cpu_dev,
-			"invalid Vproc value: %d\n", old_vproc);
-		return old_vproc;
+			"invalid Vproc value: %d\n", pre_vproc);
+		return pre_vproc;
 	}
 	/* Vsram should not exceed the maximum allowed voltage of SoC. */
 	new_vsram = min(new_vproc + MIN_VOLT_SHIFT, MAX_VOLT_LIMIT);
 
-	if (old_vproc < new_vproc) {
+	if (pre_vproc < new_vproc) {
 		/*
 		 * When scaling up voltages, Vsram and Vproc scale up step
 		 * by step. At each step, set Vsram to (Vproc + 200mV) first,
@@ -80,20 +80,20 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 		 * Keep doing it until Vsram and Vproc hit target voltages.
 		 */
 		do {
-			old_vsram = regulator_get_voltage(sram_reg);
-			if (old_vsram < 0) {
+			pre_vsram = regulator_get_voltage(sram_reg);
+			if (pre_vsram < 0) {
 				dev_err(info->cpu_dev,
-					"invalid Vsram value: %d\n", old_vsram);
-				return old_vsram;
+					"invalid Vsram value: %d\n", pre_vsram);
+				return pre_vsram;
 			}
-			old_vproc = regulator_get_voltage(proc_reg);
-			if (old_vproc < 0) {
+			pre_vproc = regulator_get_voltage(proc_reg);
+			if (pre_vproc < 0) {
 				dev_err(info->cpu_dev,
-					"invalid Vproc value: %d\n", old_vproc);
-				return old_vproc;
+					"invalid Vproc value: %d\n", pre_vproc);
+				return pre_vproc;
 			}
 
-			vsram = min(new_vsram, old_vproc + MAX_VOLT_SHIFT);
+			vsram = min(new_vsram, pre_vproc + MAX_VOLT_SHIFT);
 
 			if (vsram + VOLT_TOL >= MAX_VOLT_LIMIT) {
 				vsram = MAX_VOLT_LIMIT;
@@ -122,12 +122,12 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 			ret = regulator_set_voltage(proc_reg, vproc,
 						    vproc + VOLT_TOL);
 			if (ret) {
-				regulator_set_voltage(sram_reg, old_vsram,
-						      old_vsram);
+				regulator_set_voltage(sram_reg, pre_vsram,
+						      pre_vsram);
 				return ret;
 			}
 		} while (vproc < new_vproc || vsram < new_vsram);
-	} else if (old_vproc > new_vproc) {
+	} else if (pre_vproc > new_vproc) {
 		/*
 		 * When scaling down voltages, Vsram and Vproc scale down step
 		 * by step. At each step, set Vproc to (Vsram - 200mV) first,
@@ -135,20 +135,20 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 		 * Keep doing it until Vsram and Vproc hit target voltages.
 		 */
 		do {
-			old_vproc = regulator_get_voltage(proc_reg);
-			if (old_vproc < 0) {
+			pre_vproc = regulator_get_voltage(proc_reg);
+			if (pre_vproc < 0) {
 				dev_err(info->cpu_dev,
-					"invalid Vproc value: %d\n", old_vproc);
-				return old_vproc;
+					"invalid Vproc value: %d\n", pre_vproc);
+				return pre_vproc;
 			}
-			old_vsram = regulator_get_voltage(sram_reg);
-			if (old_vsram < 0) {
+			pre_vsram = regulator_get_voltage(sram_reg);
+			if (pre_vsram < 0) {
 				dev_err(info->cpu_dev,
-					"invalid Vsram value: %d\n", old_vsram);
-				return old_vsram;
+					"invalid Vsram value: %d\n", pre_vsram);
+				return pre_vsram;
 			}
 
-			vproc = max(new_vproc, old_vsram - MAX_VOLT_SHIFT);
+			vproc = max(new_vproc, pre_vsram - MAX_VOLT_SHIFT);
 			ret = regulator_set_voltage(proc_reg, vproc,
 						    vproc + VOLT_TOL);
 			if (ret)
@@ -178,8 +178,8 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 			}
 
 			if (ret) {
-				regulator_set_voltage(proc_reg, old_vproc,
-						      old_vproc);
+				regulator_set_voltage(proc_reg, pre_vproc,
+						      pre_vproc);
 				return ret;
 			}
 		} while (vproc > new_vproc + VOLT_TOL ||
@@ -207,16 +207,16 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	struct mtk_cpu_dvfs_info *info = policy->driver_data;
 	struct device *cpu_dev = info->cpu_dev;
 	struct dev_pm_opp *opp;
-	long freq_hz, old_freq_hz;
-	int vproc, old_vproc, inter_vproc, target_vproc, ret;
+	long freq_hz, pre_freq_hz;
+	int vproc, pre_vproc, inter_vproc, target_vproc, ret;
 
 	inter_vproc = info->intermediate_voltage;
 
-	old_freq_hz = clk_get_rate(cpu_clk);
-	old_vproc = regulator_get_voltage(info->proc_reg);
-	if (old_vproc < 0) {
-		dev_err(cpu_dev, "invalid Vproc value: %d\n", old_vproc);
-		return old_vproc;
+	pre_freq_hz = clk_get_rate(cpu_clk);
+	pre_vproc = regulator_get_voltage(info->proc_reg);
+	if (pre_vproc < 0) {
+		dev_err(cpu_dev, "invalid Vproc value: %d\n", pre_vproc);
+		return pre_vproc;
 	}
 
 	freq_hz = freq_table[index].frequency * 1000;
@@ -235,12 +235,12 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	 * current voltage, scale up voltage first.
 	 */
 	target_vproc = (inter_vproc > vproc) ? inter_vproc : vproc;
-	if (old_vproc < target_vproc) {
+	if (pre_vproc < target_vproc) {
 		ret = mtk_cpufreq_set_voltage(info, target_vproc);
 		if (ret) {
 			dev_err(cpu_dev,
 				"cpu%d: failed to scale up voltage!\n", policy->cpu);
-			mtk_cpufreq_set_voltage(info, old_vproc);
+			mtk_cpufreq_set_voltage(info, pre_vproc);
 			return ret;
 		}
 	}
@@ -250,7 +250,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	if (ret) {
 		dev_err(cpu_dev,
 			"cpu%d: failed to re-parent cpu clock!\n", policy->cpu);
-		mtk_cpufreq_set_voltage(info, old_vproc);
+		mtk_cpufreq_set_voltage(info, pre_vproc);
 		WARN_ON(1);
 		return ret;
 	}
@@ -261,7 +261,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 		dev_err(cpu_dev,
 			"cpu%d: failed to scale cpu clock rate!\n", policy->cpu);
 		clk_set_parent(cpu_clk, armpll);
-		mtk_cpufreq_set_voltage(info, old_vproc);
+		mtk_cpufreq_set_voltage(info, pre_vproc);
 		return ret;
 	}
 
@@ -279,13 +279,13 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	 * If the new voltage is lower than the intermediate voltage or the
 	 * original voltage, scale down to the new voltage.
 	 */
-	if (vproc < inter_vproc || vproc < old_vproc) {
+	if (vproc < inter_vproc || vproc < pre_vproc) {
 		ret = mtk_cpufreq_set_voltage(info, vproc);
 		if (ret) {
 			dev_err(cpu_dev,
 				"cpu%d: failed to scale down voltage!\n", policy->cpu);
 			clk_set_parent(cpu_clk, info->inter_clk);
-			clk_set_rate(armpll, old_freq_hz);
+			clk_set_rate(armpll, pre_freq_hz);
 			clk_set_parent(cpu_clk, armpll);
 			return ret;
 		}
-- 
2.18.0


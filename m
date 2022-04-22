Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9431750B249
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445125AbiDVHz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445085AbiDVHzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:55:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D57851E40;
        Fri, 22 Apr 2022 00:52:54 -0700 (PDT)
X-UUID: 4dd2ca6b367d4a1cb3438f730b4a8af9-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:8f79558d-4284-41e3-924c-8ee55adcd219,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:574fc1ef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 4dd2ca6b367d4a1cb3438f730b4a8af9-20220422
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 497109817; Fri, 22 Apr 2022 15:52:45 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 22 Apr 2022 15:52:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Apr
 2022 15:52:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 15:52:42 +0800
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
Subject: [PATCH V4 02/14] cpufreq: mediatek: Use device print to show logs
Date:   Fri, 22 Apr 2022 15:52:27 +0800
Message-ID: <20220422075239.16437-3-rex-bc.chen@mediatek.com>
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

- Replace pr_* with dev_* to show logs.
- Remove usage of __func__.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


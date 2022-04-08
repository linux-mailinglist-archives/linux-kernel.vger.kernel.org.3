Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEF64F8DCD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbiDHFCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiDHFBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:01:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8002F19F21A;
        Thu,  7 Apr 2022 21:59:25 -0700 (PDT)
X-UUID: 2928e39fb82346af80e8f7d98106a2d0-20220408
X-UUID: 2928e39fb82346af80e8f7d98106a2d0-20220408
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 660165636; Fri, 08 Apr 2022 12:59:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Apr 2022 12:59:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Apr 2022 12:59:13 +0800
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
Subject: [PATCH V2 15/15] cpufreq: mediatek: Use device print to show logs
Date:   Fri, 8 Apr 2022 12:59:08 +0800
Message-ID: <20220408045908.21671-16-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
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

Replace pr_* with dev_* to show logs.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 41 +++++++++++++++++-------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 07d3b31e3ee0..34e3baa4927f 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -92,13 +92,15 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 
 	old_vproc = regulator_get_voltage(proc_reg);
 	if (old_vproc < 0) {
-		pr_err("%s: invalid Vproc value: %d\n", __func__, old_vproc);
+		dev_err(info->cpu_dev,
+			"%s: invalid Vproc value: %d\n", __func__, old_vproc);
 		return old_vproc;
 	}
 
 	old_vsram = regulator_get_voltage(sram_reg);
 	if (old_vsram < 0) {
-		pr_err("%s: invalid Vsram value: %d\n", __func__, old_vsram);
+		dev_err(info->cpu_dev,
+			"%s: invalid Vsram value: %d\n", __func__, old_vsram);
 		return old_vsram;
 	}
 
@@ -217,8 +219,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	freq_hz = freq_table[index].frequency * 1000;
 	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
 	if (IS_ERR(opp)) {
-		pr_err("cpu%d: failed to find OPP for %ld\n",
-		       policy->cpu, freq_hz);
+		dev_err(cpu_dev, "cpu%d: failed to find OPP for %ld\n",
+			policy->cpu, freq_hz);
 		return PTR_ERR(opp);
 	}
 	vproc = dev_pm_opp_get_voltage(opp);
@@ -243,8 +245,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	if (old_vproc <= target_vproc) {
 		ret = mtk_cpufreq_set_voltage(info, target_vproc);
 		if (ret) {
-			pr_err("cpu%d: failed to scale up voltage!\n",
-			       policy->cpu);
+			dev_err(cpu_dev, "cpu%d: failed to scale up voltage!\n",
+				policy->cpu);
 			mtk_cpufreq_set_voltage(info, old_vproc);
 			goto out;
 		}
@@ -253,8 +255,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	/* Reparent the CPU clock to intermediate clock. */
 	ret = clk_set_parent(cpu_clk, info->inter_clk);
 	if (ret) {
-		pr_err("cpu%d: failed to re-parent cpu clock!\n",
-		       policy->cpu);
+		dev_err(cpu_dev, "cpu%d: failed to re-parent cpu clock!\n",
+			policy->cpu);
 		mtk_cpufreq_set_voltage(info, old_vproc);
 		goto out;
 	}
@@ -262,8 +264,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	/* Set the original PLL to target rate. */
 	ret = clk_set_rate(armpll, freq_hz);
 	if (ret) {
-		pr_err("cpu%d: failed to scale cpu clock rate!\n",
-		       policy->cpu);
+		dev_err(cpu_dev, "cpu%d: failed to scale cpu clock rate!\n",
+			policy->cpu);
 		clk_set_parent(cpu_clk, armpll);
 		mtk_cpufreq_set_voltage(info, old_vproc);
 		goto out;
@@ -272,8 +274,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	/* Set parent of CPU clock back to the original PLL. */
 	ret = clk_set_parent(cpu_clk, armpll);
 	if (ret) {
-		pr_err("cpu%d: failed to re-parent cpu clock!\n",
-		       policy->cpu);
+		dev_err(cpu_dev, "cpu%d: failed to re-parent cpu clock!\n",
+			policy->cpu);
 		mtk_cpufreq_set_voltage(info, inter_vproc);
 		goto out;
 	}
@@ -285,8 +287,9 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	if (vproc < inter_vproc || vproc < old_vproc) {
 		ret = mtk_cpufreq_set_voltage(info, vproc);
 		if (ret) {
-			pr_err("cpu%d: failed to scale down voltage!\n",
-			       policy->cpu);
+			dev_err(cpu_dev,
+				"cpu%d: failed to scale down voltage!\n",
+				policy->cpu);
 			clk_set_parent(cpu_clk, info->inter_clk);
 			clk_set_rate(armpll, old_freq_hz);
 			clk_set_parent(cpu_clk, armpll);
@@ -568,15 +571,17 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 
 	info = mtk_cpu_dvfs_info_lookup(policy->cpu);
 	if (!info) {
-		pr_err("dvfs info for cpu%d is not initialized.\n",
-		       policy->cpu);
+		dev_err(info->cpu_dev,
+			"dvfs info for cpu%d is not initialized.\n",
+			policy->cpu);
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


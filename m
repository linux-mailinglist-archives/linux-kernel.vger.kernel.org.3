Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B64D4CFE25
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbiCGMX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242043AbiCGMXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:23:14 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F3680216;
        Mon,  7 Mar 2022 04:22:17 -0800 (PST)
X-UUID: aace01c6977b4ec5be76a632ccda92c6-20220307
X-UUID: aace01c6977b4ec5be76a632ccda92c6-20220307
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 4505817; Mon, 07 Mar 2022 20:22:11 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 7 Mar 2022 20:22:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Mar
 2022 20:22:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Mar 2022 20:22:09 +0800
From:   Tim Chang <jia-wei.chang@mediatek.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <fan.chen@mediatek.com>,
        <louis.yu@mediatek.com>, <roger.lu@mediatek.com>,
        <Allen-yy.Lin@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
Subject: [PATCH 3/4] cpufreq: mediatek: clean up cpufreq driver
Date:   Mon, 7 Mar 2022 20:21:50 +0800
Message-ID: <20220307122151.11666-4-jia-wei.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
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

cleanup of naming, print log and comments.

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 487 ++++++++++++++---------------
 1 file changed, 233 insertions(+), 254 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 8e9d706d8081..3f00c7eb01f1 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2015 Linaro Ltd.
- * Author: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
+ * Copyright (C) 2022 MediaTek Inc.
  */
 
 #include <linux/clk.h>
@@ -22,7 +21,7 @@
 #define VOLT_TOL		(10000)
 
 /*
- * The struct mtk_cpu_dvfs_info holds necessary information for doing CPU DVFS
+ * The struct mtk_cpufreq_drv holds necessary information for doing CPU DVFS
  * on each CPU power/clock domain of Mediatek SoCs. Each CPU cluster in
  * Mediatek SoCs has two voltage inputs, Vproc and Vsram. In some cases the two
  * voltage inputs need to be controlled under a hardware limitation:
@@ -32,7 +31,7 @@
  * needs to be switched to another stable PLL clock temporarily until
  * the original PLL becomes stable at target frequency.
  */
-struct mtk_cpu_dvfs_info {
+struct mtk_cpufreq_drv {
 	struct cpumask cpus;
 	struct device *cpu_dev;
 	struct regulator *proc_reg;
@@ -40,45 +39,45 @@ struct mtk_cpu_dvfs_info {
 	struct clk *cpu_clk;
 	struct clk *inter_clk;
 	struct list_head list_head;
-	int intermediate_voltage;
+	int inter_voltage;
 	bool need_voltage_tracking;
-	int old_vproc;
-	struct mutex lock; /* avoid notify and policy race condition */
+	int old_voltage;
+	struct mutex lock;  /* avoid notify and policy race condition */
 	struct notifier_block opp_nb;
 	int opp_cpu;
 	unsigned long opp_freq;
 };
 
-static LIST_HEAD(dvfs_info_list);
+static LIST_HEAD(drv_list);
 
-static struct mtk_cpu_dvfs_info *mtk_cpu_dvfs_info_lookup(int cpu)
+static struct mtk_cpufreq_drv *mtk_cpufreq_drv_lookup(int cpu)
 {
-	struct mtk_cpu_dvfs_info *info;
+	struct mtk_cpufreq_drv *drv;
 
-	list_for_each_entry(info, &dvfs_info_list, list_head) {
-		if (cpumask_test_cpu(cpu, &info->cpus))
-			return info;
+	list_for_each_entry(drv, &drv_list, list_head) {
+		if (cpumask_test_cpu(cpu, &drv->cpus))
+			return drv;
 	}
 
 	return NULL;
 }
 
-static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
-					int new_vproc)
+static int mtk_cpufreq_voltage_tracking(struct mtk_cpufreq_drv *drv,
+					int new_voltage)
 {
-	struct regulator *proc_reg = info->proc_reg;
-	struct regulator *sram_reg = info->sram_reg;
-	int old_vproc, old_vsram, new_vsram, vsram, vproc, ret;
-
-	old_vproc = regulator_get_voltage(proc_reg);
-	if (old_vproc < 0) {
-		pr_err("%s: invalid Vproc value: %d\n", __func__, old_vproc);
-		return old_vproc;
+	struct regulator *proc_reg = drv->proc_reg;
+	struct regulator *sram_reg = drv->sram_reg;
+	int old_voltage, old_vsram, new_vsram, vsram, voltage, ret;
+
+	old_voltage = regulator_get_voltage(proc_reg);
+	if (old_voltage < 0) {
+		pr_err("%s: invalid vproc value: %d\n", __func__, old_voltage);
+		return old_voltage;
 	}
 	/* Vsram should not exceed the maximum allowed voltage of SoC. */
-	new_vsram = min(new_vproc + MIN_VOLT_SHIFT, MAX_VOLT_LIMIT);
+	new_vsram = min(new_voltage + MIN_VOLT_SHIFT, MAX_VOLT_LIMIT);
 
-	if (old_vproc < new_vproc) {
+	if (old_voltage < new_voltage) {
 		/*
 		 * When scaling up voltages, Vsram and Vproc scale up step
 		 * by step. At each step, set Vsram to (Vproc + 200mV) first,
@@ -88,18 +87,18 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 		do {
 			old_vsram = regulator_get_voltage(sram_reg);
 			if (old_vsram < 0) {
-				pr_err("%s: invalid Vsram value: %d\n",
+				pr_err("%s: invalid vsram value: %d\n",
 				       __func__, old_vsram);
 				return old_vsram;
 			}
-			old_vproc = regulator_get_voltage(proc_reg);
-			if (old_vproc < 0) {
-				pr_err("%s: invalid Vproc value: %d\n",
-				       __func__, old_vproc);
-				return old_vproc;
+			old_voltage = regulator_get_voltage(proc_reg);
+			if (old_voltage < 0) {
+				pr_err("%s: invalid vproc value: %d\n",
+				       __func__, old_voltage);
+				return old_voltage;
 			}
 
-			vsram = min(new_vsram, old_vproc + MAX_VOLT_SHIFT);
+			vsram = min(new_vsram, old_voltage + MAX_VOLT_SHIFT);
 
 			if (vsram + VOLT_TOL >= MAX_VOLT_LIMIT) {
 				vsram = MAX_VOLT_LIMIT;
@@ -115,25 +114,25 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 							vsram - VOLT_TOL,
 							vsram);
 
-				vproc = new_vproc;
+				voltage = new_voltage;
 			} else {
 				ret = regulator_set_voltage(sram_reg, vsram,
 							    vsram + VOLT_TOL);
 
-				vproc = vsram - MIN_VOLT_SHIFT;
+				voltage = vsram - MIN_VOLT_SHIFT;
 			}
 			if (ret)
 				return ret;
 
-			ret = regulator_set_voltage(proc_reg, vproc,
-						    vproc + VOLT_TOL);
+			ret = regulator_set_voltage(proc_reg, voltage,
+						    voltage + VOLT_TOL);
 			if (ret) {
 				regulator_set_voltage(sram_reg, old_vsram,
 						      old_vsram);
 				return ret;
 			}
-		} while (vproc < new_vproc || vsram < new_vsram);
-	} else if (old_vproc > new_vproc) {
+		} while (voltage < new_voltage || vsram < new_vsram);
+	} else if (old_voltage > new_voltage) {
 		/*
 		 * When scaling down voltages, Vsram and Vproc scale down step
 		 * by step. At each step, set Vproc to (Vsram - 200mV) first,
@@ -141,29 +140,29 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 		 * Keep doing it until Vsram and Vproc hit target voltages.
 		 */
 		do {
-			old_vproc = regulator_get_voltage(proc_reg);
-			if (old_vproc < 0) {
-				pr_err("%s: invalid Vproc value: %d\n",
-				       __func__, old_vproc);
-				return old_vproc;
+			old_voltage = regulator_get_voltage(proc_reg);
+			if (old_voltage < 0) {
+				pr_err("%s: invalid vproc value: %d\n",
+				       __func__, old_voltage);
+				return old_voltage;
 			}
 			old_vsram = regulator_get_voltage(sram_reg);
 			if (old_vsram < 0) {
-				pr_err("%s: invalid Vsram value: %d\n",
+				pr_err("%s: invalid vsram value: %d\n",
 				       __func__, old_vsram);
 				return old_vsram;
 			}
 
-			vproc = max(new_vproc, old_vsram - MAX_VOLT_SHIFT);
-			ret = regulator_set_voltage(proc_reg, vproc,
-						    vproc + VOLT_TOL);
+			voltage = max(new_voltage, old_vsram - MAX_VOLT_SHIFT);
+			ret = regulator_set_voltage(proc_reg, voltage,
+						    voltage + VOLT_TOL);
 			if (ret)
 				return ret;
 
-			if (vproc == new_vproc)
+			if (voltage == new_voltage)
 				vsram = new_vsram;
 			else
-				vsram = max(new_vsram, vproc + MIN_VOLT_SHIFT);
+				vsram = max(new_vsram, voltage + MIN_VOLT_SHIFT);
 
 			if (vsram + VOLT_TOL >= MAX_VOLT_LIMIT) {
 				vsram = MAX_VOLT_LIMIT;
@@ -184,112 +183,107 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 			}
 
 			if (ret) {
-				regulator_set_voltage(proc_reg, old_vproc,
-						      old_vproc);
+				regulator_set_voltage(proc_reg, old_voltage,
+						      old_voltage);
 				return ret;
 			}
-		} while (vproc > new_vproc + VOLT_TOL ||
+		} while (voltage > new_voltage + VOLT_TOL ||
 			 vsram > new_vsram + VOLT_TOL);
 	}
 
 	return 0;
 }
 
-static int mtk_cpufreq_set_voltage(struct mtk_cpu_dvfs_info *info, int vproc)
+static int mtk_cpufreq_set_voltage(struct mtk_cpufreq_drv *drv, int voltage)
 {
 	int ret;
 
-	if (info->need_voltage_tracking)
-		ret = mtk_cpufreq_voltage_tracking(info, vproc);
+	if (drv->need_voltage_tracking)
+		ret = mtk_cpufreq_voltage_tracking(drv, voltage);
 	else
-		ret = regulator_set_voltage(info->proc_reg, vproc,
+		ret = regulator_set_voltage(drv->proc_reg, voltage,
 					    MAX_VOLT_LIMIT);
 	if (!ret)
-		info->old_vproc = vproc;
+		drv->old_voltage = voltage;
+
 	return ret;
 }
 
-static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
-				  unsigned int index)
+static int mtk_cpufreq_target_index(struct cpufreq_policy *policy,
+				    unsigned int index)
 {
 	struct cpufreq_frequency_table *freq_table = policy->freq_table;
 	struct clk *cpu_clk = policy->clk;
 	struct clk *armpll = clk_get_parent(cpu_clk);
-	struct mtk_cpu_dvfs_info *info = policy->driver_data;
-	struct device *cpu_dev = info->cpu_dev;
+	struct mtk_cpufreq_drv *drv = policy->driver_data;
+	struct device *cpu_dev = drv->cpu_dev;
 	struct dev_pm_opp *opp;
-	long freq_hz, old_freq_hz;
-	int vproc, old_vproc, inter_vproc, target_vproc, ret;
-
-	inter_vproc = info->intermediate_voltage;
-
-	old_freq_hz = clk_get_rate(cpu_clk);
-	old_vproc = info->old_vproc;
-	if (old_vproc == 0)
-		old_vproc = regulator_get_voltage(info->proc_reg);
-	if (old_vproc < 0) {
-		pr_err("%s: invalid Vproc value: %d\n", __func__, old_vproc);
-		return old_vproc;
-	}
+	unsigned long freq, old_freq;
+	int voltage, old_voltage, inter_voltage, target_voltage, ret;
 
-	freq_hz = freq_table[index].frequency * 1000;
+	inter_voltage = drv->inter_voltage;
 
-	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
+	freq = freq_table[index].frequency * 1000;
+	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq);
 	if (IS_ERR(opp)) {
-		pr_err("cpu%d: failed to find OPP for %ld\n",
-		       policy->cpu, freq_hz);
+		pr_err("cpu%d: failed to find opp for freq:%ld\n",
+		       policy->cpu, freq);
 		return PTR_ERR(opp);
 	}
-	vproc = dev_pm_opp_get_voltage(opp);
+	voltage = dev_pm_opp_get_voltage(opp);
 	dev_pm_opp_put(opp);
 
-	mutex_lock(&info->lock);
-	/*
-	 * If the new voltage or the intermediate voltage is higher than the
-	 * current voltage, scale up voltage first.
-	 */
-	target_vproc = (inter_vproc > vproc) ? inter_vproc : vproc;
-	if (old_vproc < target_vproc) {
-		ret = mtk_cpufreq_set_voltage(info, target_vproc);
+	old_freq = clk_get_rate(cpu_clk);
+	old_voltage = drv->old_voltage;
+	if (old_voltage == 0)
+		old_voltage = regulator_get_voltage(drv->proc_reg);
+	if (old_voltage < 0) {
+		pr_err("cpu%d: invalid vproc value: %d\n",
+		       policy->cpu, old_voltage);
+		return old_voltage;
+	}
+
+	mutex_lock(&drv->lock);
+	/* scale up: set voltage first then freq. */
+	target_voltage = (inter_voltage > voltage) ? inter_voltage : voltage;
+	if (old_voltage < target_voltage) {
+		ret = mtk_cpufreq_set_voltage(drv, target_voltage);
 		if (ret) {
-			pr_err("cpu%d: failed to scale up voltage!\n",
+			pr_err("cpu%d: failed to scale up voltage\n",
 			       policy->cpu);
-			mtk_cpufreq_set_voltage(info, old_vproc);
-			mutex_unlock(&info->lock);
+			mtk_cpufreq_set_voltage(drv, old_voltage);
+			mutex_unlock(&drv->lock);
 			return ret;
 		}
 	}
 
-	/* Reparent the CPU clock to intermediate clock. */
-	ret = clk_set_parent(cpu_clk, info->inter_clk);
+	/* switch the cpu clock to intermediate clock source. */
+	ret = clk_set_parent(cpu_clk, drv->inter_clk);
 	if (ret) {
-		pr_err("cpu%d: failed to re-parent cpu clock!\n",
-		       policy->cpu);
-		mtk_cpufreq_set_voltage(info, old_vproc);
+		pr_err("cpu%d: failed to re-parent cpu clock\n", policy->cpu);
+		mtk_cpufreq_set_voltage(drv, old_voltage);
 		WARN_ON(1);
-		mutex_unlock(&info->lock);
+		mutex_unlock(&drv->lock);
 		return ret;
 	}
 
-	/* Set the original PLL to target rate. */
-	ret = clk_set_rate(armpll, freq_hz);
+	/* set the original clock to target rate. */
+	ret = clk_set_rate(armpll, freq);
 	if (ret) {
-		pr_err("cpu%d: failed to scale cpu clock rate!\n",
-		       policy->cpu);
+		pr_err("cpu%d: failed to scale cpu clock rate\n", policy->cpu);
 		clk_set_parent(cpu_clk, armpll);
-		mtk_cpufreq_set_voltage(info, old_vproc);
-		mutex_unlock(&info->lock);
+		mtk_cpufreq_set_voltage(drv, old_voltage);
+		mutex_unlock(&drv->lock);
 		return ret;
 	}
 
-	/* Set parent of CPU clock back to the original PLL. */
+	/* switch the cpu clock back to the original clock source. */
 	ret = clk_set_parent(cpu_clk, armpll);
 	if (ret) {
-		pr_err("cpu%d: failed to re-parent cpu clock!\n",
-		       policy->cpu);
-		mtk_cpufreq_set_voltage(info, inter_vproc);
+		pr_err("cpu%d: failed to re-parent cpu clock\n", policy->cpu);
+		mtk_cpufreq_set_voltage(drv, inter_voltage);
 		WARN_ON(1);
-		mutex_unlock(&info->lock);
+		mutex_unlock(&drv->lock);
 		return ret;
 	}
 
@@ -297,21 +291,21 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	 * If the new voltage is lower than the intermediate voltage or the
 	 * original voltage, scale down to the new voltage.
 	 */
-	if (vproc < inter_vproc || vproc < old_vproc) {
-		ret = mtk_cpufreq_set_voltage(info, vproc);
+	if (voltage < inter_voltage || voltage < old_voltage) {
+		ret = mtk_cpufreq_set_voltage(drv, voltage);
 		if (ret) {
-			pr_err("cpu%d: failed to scale down voltage!\n",
+			pr_err("cpu%d: failed to scale down voltage\n",
 			       policy->cpu);
-			clk_set_parent(cpu_clk, info->inter_clk);
-			clk_set_rate(armpll, old_freq_hz);
+			clk_set_parent(cpu_clk, drv->inter_clk);
+			clk_set_rate(armpll, old_freq);
 			clk_set_parent(cpu_clk, armpll);
-			mutex_unlock(&info->lock);
+			mutex_unlock(&drv->lock);
 			return ret;
 		}
 	}
 
-	info->opp_freq = freq_hz;
-	mutex_unlock(&info->lock);
+	drv->opp_freq = freq;
+	mutex_unlock(&drv->lock);
 
 	return 0;
 }
@@ -323,35 +317,35 @@ static int mtk_cpufreq_opp_notifier(struct notifier_block *nb,
 {
 	struct dev_pm_opp *opp = data;
 	struct dev_pm_opp *new_opp;
-	struct mtk_cpu_dvfs_info *info;
+	struct mtk_cpufreq_drv *drv;
 	unsigned long freq, volt;
 	struct cpufreq_policy *policy;
 	int ret = 0;
 
-	info = container_of(nb, struct mtk_cpu_dvfs_info, opp_nb);
+	drv = container_of(nb, struct mtk_cpufreq_drv, opp_nb);
 
 	if (event == OPP_EVENT_ADJUST_VOLTAGE) {
 		freq = dev_pm_opp_get_freq(opp);
 
-		mutex_lock(&info->lock);
-		if (info->opp_freq == freq) {
+		mutex_lock(&drv->lock);
+		if (drv->opp_freq == freq) {
 			volt = dev_pm_opp_get_voltage(opp);
-			ret = mtk_cpufreq_set_voltage(info, volt);
+			ret = mtk_cpufreq_set_voltage(drv, volt);
 			if (ret)
-				dev_err(info->cpu_dev, "failed to scale voltage: %d\n",
+				dev_err(drv->cpu_dev, "failed to scale voltage: %d\n",
 					ret);
 		}
-		mutex_unlock(&info->lock);
+		mutex_unlock(&drv->lock);
 	} else if (event == OPP_EVENT_DISABLE) {
 		freq = dev_pm_opp_get_freq(opp);
 		/* case of current opp item is disabled */
-		if (info->opp_freq == freq) {
+		if (drv->opp_freq == freq) {
 			freq = 1;
-			new_opp = dev_pm_opp_find_freq_ceil(info->cpu_dev,
+			new_opp = dev_pm_opp_find_freq_ceil(drv->cpu_dev,
 							    &freq);
 			if (!IS_ERR(new_opp)) {
 				dev_pm_opp_put(new_opp);
-				policy = cpufreq_cpu_get(info->opp_cpu);
+				policy = cpufreq_cpu_get(drv->opp_cpu);
 				if (policy) {
 					cpufreq_driver_target(policy,
 							      freq / 1000,
@@ -368,210 +362,192 @@ static int mtk_cpufreq_opp_notifier(struct notifier_block *nb,
 	return notifier_from_errno(ret);
 }
 
-static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
+static int mtk_cpufreq_drv_init(struct mtk_cpufreq_drv *drv, int cpu)
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
+		dev_err(cpu_dev, "cpu%d: failed to get cpu device\n", cpu);
 		return -ENODEV;
 	}
 
-	cpu_clk = clk_get(cpu_dev, "cpu");
-	if (IS_ERR(cpu_clk)) {
-		if (PTR_ERR(cpu_clk) == -EPROBE_DEFER)
-			pr_warn("cpu clk for cpu%d not ready, retry.\n", cpu);
-		else
-			pr_err("failed to get cpu clk for cpu%d\n", cpu);
+	drv->opp_cpu = cpu;
+	drv->cpu_dev = cpu_dev;
+	mutex_init(&drv->lock);
 
-		ret = PTR_ERR(cpu_clk);
-		return ret;
+	drv->cpu_clk = clk_get(cpu_dev, "cpu");
+	if (IS_ERR(drv->cpu_clk)) {
+		ret = PTR_ERR(drv->cpu_clk);
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
+	drv->inter_clk = clk_get(cpu_dev, "intermediate");
+	if (IS_ERR(drv->inter_clk)) {
+		ret = PTR_ERR(drv->inter_clk);
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
+	drv->proc_reg = regulator_get_optional(cpu_dev, "proc");
+	if (IS_ERR(drv->proc_reg)) {
+		ret = PTR_ERR(drv->proc_reg);
+		dev_err_probe(cpu_dev, ret,
+			      "cpu%d: failed to get proc regulator\n", cpu);
 		goto out_free_resources;
 	}
-	ret = regulator_enable(proc_reg);
+
+	ret = regulator_enable(drv->proc_reg);
 	if (ret) {
-		pr_warn("enable vproc for cpu%d fail\n", cpu);
+		dev_warn(cpu_dev, "cpu%d: failed to enable proc regulator\n", cpu);
 		goto out_free_resources;
 	}
 
 	/* Both presence and absence of sram regulator are valid cases. */
-	sram_reg = regulator_get_exclusive(cpu_dev, "sram");
+	drv->sram_reg = regulator_get_exclusive(cpu_dev, "sram");
 
 	/* Get OPP-sharing information from "operating-points-v2" bindings */
-	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, &info->cpus);
+	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, &drv->cpus);
 	if (ret) {
-		pr_err("failed to get OPP-sharing information for cpu%d\n",
-		       cpu);
+		dev_err(cpu_dev, "cpu%d: failed to get opp-sharing information\n",
+			cpu);
 		goto out_free_resources;
 	}
 
-	ret = dev_pm_opp_of_cpumask_add_table(&info->cpus);
+	ret = dev_pm_opp_of_cpumask_add_table(&drv->cpus);
 	if (ret) {
-		pr_warn("no OPP table for cpu%d\n", cpu);
+		dev_warn(cpu_dev, "cpu%d: failed to add opp table\n", cpu);
 		goto out_free_resources;
 	}
 
-	ret = clk_prepare_enable(cpu_clk);
+	ret = clk_prepare_enable(drv->cpu_clk);
 	if (ret)
 		goto out_free_opp_table;
 
-	ret = clk_prepare_enable(inter_clk);
+	ret = clk_prepare_enable(drv->inter_clk);
 	if (ret)
 		goto out_disable_mux_clock;
 
 	/* Search a safe voltage for intermediate frequency. */
-	rate = clk_get_rate(inter_clk);
+	rate = clk_get_rate(drv->inter_clk);
 	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
 	if (IS_ERR(opp)) {
-		pr_err("failed to get intermediate opp for cpu%d\n", cpu);
+		dev_err(cpu_dev, "cpu%d: failed to get intermediate opp\n",
+			cpu);
 		ret = PTR_ERR(opp);
 		goto out_disable_inter_clock;
 	}
-	info->intermediate_voltage = dev_pm_opp_get_voltage(opp);
+	drv->inter_voltage = dev_pm_opp_get_voltage(opp);
 	dev_pm_opp_put(opp);
 
-	info->opp_cpu = cpu;
-	info->opp_nb.notifier_call = mtk_cpufreq_opp_notifier;
-	ret = dev_pm_opp_register_notifier(cpu_dev, &info->opp_nb);
+	drv->opp_nb.notifier_call = mtk_cpufreq_opp_notifier;
+	ret = dev_pm_opp_register_notifier(cpu_dev, &drv->opp_nb);
 	if (ret) {
-		pr_warn("cannot register opp notification\n");
+		dev_warn(cpu_dev, "cpu%d: failed to register opp notifier\n",
+			 cpu);
 		goto out_disable_inter_clock;
 	}
 
-	mutex_init(&info->lock);
-	info->cpu_dev = cpu_dev;
-	info->proc_reg = proc_reg;
-	info->sram_reg = IS_ERR(sram_reg) ? NULL : sram_reg;
-	info->cpu_clk = cpu_clk;
-	info->inter_clk = inter_clk;
-	info->opp_freq = clk_get_rate(cpu_clk);
+	drv->opp_freq = clk_get_rate(drv->cpu_clk);
 
 	/*
 	 * If SRAM regulator is present, software "voltage tracking" is needed
 	 * for this CPU power domain.
 	 */
-	info->need_voltage_tracking = !IS_ERR(sram_reg);
+	drv->need_voltage_tracking = !IS_ERR(drv->sram_reg);
 
 	return 0;
 
 out_disable_inter_clock:
-	clk_disable_unprepare(inter_clk);
+	clk_disable_unprepare(drv->inter_clk);
 
 out_disable_mux_clock:
-	clk_disable_unprepare(cpu_clk);
+	clk_disable_unprepare(drv->cpu_clk);
 
 out_free_opp_table:
-	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
+	dev_pm_opp_of_cpumask_remove_table(&drv->cpus);
 
 out_free_resources:
-	if (!IS_ERR(proc_reg))
-		regulator_put(proc_reg);
-	if (!IS_ERR(sram_reg))
-		regulator_put(sram_reg);
-	if (!IS_ERR(cpu_clk))
-		clk_put(cpu_clk);
-	if (!IS_ERR(inter_clk))
-		clk_put(inter_clk);
+	if (!IS_ERR(drv->proc_reg))
+		regulator_put(drv->proc_reg);
+	if (!IS_ERR(drv->sram_reg))
+		regulator_put(drv->sram_reg);
+	if (!IS_ERR(drv->cpu_clk))
+		clk_put(drv->cpu_clk);
+	if (!IS_ERR(drv->inter_clk))
+		clk_put(drv->inter_clk);
 
 	return ret;
 }
 
-static void mtk_cpu_dvfs_info_release(struct mtk_cpu_dvfs_info *info)
+static void mtk_cpufreq_drv_release(struct mtk_cpufreq_drv *drv)
 {
-	if (!IS_ERR(info->proc_reg)) {
-		regulator_disable(info->proc_reg);
-		regulator_put(info->proc_reg);
+	if (!IS_ERR(drv->proc_reg)) {
+		regulator_disable(drv->proc_reg);
+		regulator_put(drv->proc_reg);
 	}
-	if (!IS_ERR(info->sram_reg))
-		regulator_put(info->sram_reg);
-	if (!IS_ERR(info->cpu_clk)) {
-		clk_disable_unprepare(info->cpu_clk);
-		clk_put(info->cpu_clk);
+	if (!IS_ERR(drv->sram_reg))
+		regulator_put(drv->sram_reg);
+	if (!IS_ERR(drv->cpu_clk)) {
+		clk_disable_unprepare(drv->cpu_clk);
+		clk_put(drv->cpu_clk);
 	}
-	if (!IS_ERR(info->inter_clk)) {
-		clk_disable_unprepare(info->inter_clk);
-		clk_put(info->inter_clk);
+	if (!IS_ERR(drv->inter_clk)) {
+		clk_disable_unprepare(drv->inter_clk);
+		clk_put(drv->inter_clk);
 	}
 
-	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
+	dev_pm_opp_of_cpumask_remove_table(&drv->cpus);
 }
 
 static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 {
-	struct mtk_cpu_dvfs_info *info;
+	struct mtk_cpufreq_drv *drv;
 	struct cpufreq_frequency_table *freq_table;
 	int ret;
 
-	info = mtk_cpu_dvfs_info_lookup(policy->cpu);
-	if (!info) {
-		pr_err("dvfs info for cpu%d is not initialized.\n",
+	drv = mtk_cpufreq_drv_lookup(policy->cpu);
+	if (!drv) {
+		pr_err("cpu%d: failed to initialize cpufreq drv\n",
 		       policy->cpu);
 		return -EINVAL;
 	}
 
-	ret = dev_pm_opp_init_cpufreq_table(info->cpu_dev, &freq_table);
+	ret = dev_pm_opp_init_cpufreq_table(drv->cpu_dev, &freq_table);
 	if (ret) {
-		pr_err("failed to init cpufreq table for cpu%d: %d\n",
+		pr_err("cpu%d: failed to initialize cpufreq table: %d\n",
 		       policy->cpu, ret);
 		return ret;
 	}
 
-	cpumask_copy(policy->cpus, &info->cpus);
+	cpumask_copy(policy->cpus, &drv->cpus);
 	policy->freq_table = freq_table;
-	policy->driver_data = info;
-	policy->clk = info->cpu_clk;
+	policy->driver_data = drv;
+	policy->clk = drv->cpu_clk;
 
 	return 0;
 }
 
 static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
 {
-	struct mtk_cpu_dvfs_info *info = policy->driver_data;
+	struct mtk_cpufreq_drv *drv = policy->driver_data;
 
-	dev_pm_opp_free_cpufreq_table(info->cpu_dev, &policy->freq_table);
+	dev_pm_opp_free_cpufreq_table(drv->cpu_dev, &policy->freq_table);
 
 	return 0;
 }
 
-static struct cpufreq_driver mtk_cpufreq_driver = {
+static struct cpufreq_driver cpufreq_mtk_driver = {
 	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
 		 CPUFREQ_IS_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
-	.target_index = mtk_cpufreq_set_target,
+	.target_index = mtk_cpufreq_target_index,
 	.get = cpufreq_generic_get,
 	.init = mtk_cpufreq_init,
 	.exit = mtk_cpufreq_exit,
@@ -582,55 +558,48 @@ static struct cpufreq_driver mtk_cpufreq_driver = {
 
 static int mtk_cpufreq_probe(struct platform_device *pdev)
 {
-	struct mtk_cpu_dvfs_info *info, *tmp;
+	struct mtk_cpufreq_drv *drv, *tmp;
 	int cpu, ret;
 
 	for_each_possible_cpu(cpu) {
-		info = mtk_cpu_dvfs_info_lookup(cpu);
-		if (info)
+		drv = mtk_cpufreq_drv_lookup(cpu);
+		if (drv)
 			continue;
 
-		info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
-		if (!info) {
+		drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
+		if (!drv) {
 			ret = -ENOMEM;
-			goto release_dvfs_info_list;
+			goto out_release_drv_list;
 		}
 
-		ret = mtk_cpu_dvfs_info_init(info, cpu);
+		ret = mtk_cpufreq_drv_init(drv, cpu);
 		if (ret) {
 			dev_err(&pdev->dev,
-				"failed to initialize dvfs info for cpu%d\n",
+				"cpu%d: failed to initialize cpufreq drv\n",
 				cpu);
-			goto release_dvfs_info_list;
+			goto out_release_drv_list;
 		}
 
-		list_add(&info->list_head, &dvfs_info_list);
+		list_add(&drv->list_head, &drv_list);
 	}
 
-	ret = cpufreq_register_driver(&mtk_cpufreq_driver);
+	ret = cpufreq_register_driver(&cpufreq_mtk_driver);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register mtk cpufreq driver\n");
-		goto release_dvfs_info_list;
+		goto out_release_drv_list;
 	}
 
 	return 0;
 
-release_dvfs_info_list:
-	list_for_each_entry_safe(info, tmp, &dvfs_info_list, list_head) {
-		mtk_cpu_dvfs_info_release(info);
-		list_del(&info->list_head);
+out_release_drv_list:
+	list_for_each_entry_safe(drv, tmp, &drv_list, list_head) {
+		mtk_cpufreq_drv_release(drv);
+		list_del(&drv->list_head);
 	}
 
 	return ret;
 }
 
-static struct platform_driver mtk_cpufreq_platdrv = {
-	.driver = {
-		.name	= "mtk-cpufreq",
-	},
-	.probe		= mtk_cpufreq_probe,
-};
-
 /* List of machines supported by this driver */
 static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 	{ .compatible = "mediatek,mt2701", },
@@ -638,23 +607,27 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 	{ .compatible = "mediatek,mt7622", },
 	{ .compatible = "mediatek,mt7623", },
 	{ .compatible = "mediatek,mt8167", },
-	{ .compatible = "mediatek,mt817x", },
 	{ .compatible = "mediatek,mt8173", },
-	{ .compatible = "mediatek,mt8176", },
 	{ .compatible = "mediatek,mt8183", },
 	{ .compatible = "mediatek,mt8365", },
 	{ .compatible = "mediatek,mt8516", },
-
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_cpufreq_machines);
 
-static int __init mtk_cpufreq_driver_init(void)
+static struct platform_driver mtk_cpufreq_platdrv = {
+	.probe = mtk_cpufreq_probe,
+	.driver = {
+		.name = "mtk-cpufreq",
+	},
+};
+
+static int __init mtk_cpufreq_platdrv_init(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
 	struct platform_device *pdev;
-	int err;
+	int ret;
 
 	np = of_find_node_by_path("/");
 	if (!np)
@@ -667,9 +640,9 @@ static int __init mtk_cpufreq_driver_init(void)
 		return -ENODEV;
 	}
 
-	err = platform_driver_register(&mtk_cpufreq_platdrv);
-	if (err)
-		return err;
+	ret = platform_driver_register(&mtk_cpufreq_platdrv);
+	if (ret)
+		return ret;
 
 	/*
 	 * Since there's no place to hold device registration code and no
@@ -686,8 +659,14 @@ static int __init mtk_cpufreq_driver_init(void)
 
 	return 0;
 }
-device_initcall(mtk_cpufreq_driver_init);
+module_init(mtk_cpufreq_platdrv_init)
+
+static void __exit mtk_cpufreq_platdrv_exit(void)
+{
+	platform_driver_unregister(&mtk_cpufreq_platdrv);
+}
+module_exit(mtk_cpufreq_platdrv_exit)
 
 MODULE_DESCRIPTION("MediaTek CPUFreq driver");
-MODULE_AUTHOR("Pi-Cheng Chen <pi-cheng.chen@linaro.org>");
+MODULE_AUTHOR("Jia-Wei Chang <jia-wei.chang@mediatek.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.18.0


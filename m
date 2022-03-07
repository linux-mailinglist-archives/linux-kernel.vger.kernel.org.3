Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435434CFE26
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242060AbiCGMXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242081AbiCGMXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:23:22 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E1C8021D;
        Mon,  7 Mar 2022 04:22:18 -0800 (PST)
X-UUID: 97de1d34be9743498a6fd7e991f2546a-20220307
X-UUID: 97de1d34be9743498a6fd7e991f2546a-20220307
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1461727132; Mon, 07 Mar 2022 20:22:12 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Mar 2022 20:22:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Mar
 2022 20:22:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Mar 2022 20:22:10 +0800
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
Subject: [PATCH 4/4] cpufreq: mediatek: add platform data and clean up voltage tracking logic
Date:   Mon, 7 Mar 2022 20:21:51 +0800
Message-ID: <20220307122151.11666-5-jia-wei.chang@mediatek.com>
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

1. add required header files and remove unnecessary header files.
2. some soc needs different min/max voltage shift and voltage tracking
   attributes. make these variables into platform data to support
   future soc.
3. add need_voltage_tracking variable to platforma data. if true, it
   indicates soc is required to realize the voltage tracking between
   voltage of sram and voltage of cpu by software approach. otherwise,
   the voltage tracking is realized by hardware approach.
4. add opp frequency look-up function as mtk_cpufreq_get() and
   registered in cpufreq framework.
5. update voltage_tracking() logic and drv_init(). in drv_init(), it
   always sets highest opp voltage before return. it could prevent from
   high-freqeuncy-low-voltage issue if two or more clients using the
   same regulator.

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 332 +++++++++++++++--------------
 1 file changed, 167 insertions(+), 165 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 3f00c7eb01f1..35c653eb59c7 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -7,18 +7,15 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/regulator/consumer.h>
-#include <linux/slab.h>
-#include <linux/thermal.h>
 
-#define MIN_VOLT_SHIFT		(100000)
-#define MAX_VOLT_SHIFT		(200000)
-#define MAX_VOLT_LIMIT		(1150000)
-#define VOLT_TOL		(10000)
+struct mtk_cpufreq_platform_data;
 
 /*
  * The struct mtk_cpufreq_drv holds necessary information for doing CPU DVFS
@@ -46,8 +43,20 @@ struct mtk_cpufreq_drv {
 	struct notifier_block opp_nb;
 	int opp_cpu;
 	unsigned long opp_freq;
+	const struct mtk_cpufreq_platform_data *soc_data;
 };
 
+struct mtk_cpufreq_platform_data {
+	int min_volt_shift;
+	int max_volt_shift;
+	int proc_max_volt;
+	int sram_min_volt;
+	int sram_max_volt;
+	bool need_voltage_tracking;
+};
+
+static struct platform_device *cpufreq_pdev;
+
 static LIST_HEAD(drv_list);
 
 static struct mtk_cpufreq_drv *mtk_cpufreq_drv_lookup(int cpu)
@@ -62,9 +71,21 @@ static struct mtk_cpufreq_drv *mtk_cpufreq_drv_lookup(int cpu)
 	return NULL;
 }
 
+static unsigned int mtk_cpufreq_get(unsigned int cpu)
+{
+	struct mtk_cpufreq_drv *drv;
+
+	drv = mtk_cpufreq_drv_lookup(cpu);
+	if (!drv)
+		return 0;
+
+	return drv->opp_freq / 1000;
+}
+
 static int mtk_cpufreq_voltage_tracking(struct mtk_cpufreq_drv *drv,
 					int new_voltage)
 {
+	const struct mtk_cpufreq_platform_data *soc_data = drv->soc_data;
 	struct regulator *proc_reg = drv->proc_reg;
 	struct regulator *sram_reg = drv->sram_reg;
 	int old_voltage, old_vsram, new_vsram, vsram, voltage, ret;
@@ -74,122 +95,65 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpufreq_drv *drv,
 		pr_err("%s: invalid vproc value: %d\n", __func__, old_voltage);
 		return old_voltage;
 	}
-	/* Vsram should not exceed the maximum allowed voltage of SoC. */
-	new_vsram = min(new_voltage + MIN_VOLT_SHIFT, MAX_VOLT_LIMIT);
-
-	if (old_voltage < new_voltage) {
-		/*
-		 * When scaling up voltages, Vsram and Vproc scale up step
-		 * by step. At each step, set Vsram to (Vproc + 200mV) first,
-		 * then set Vproc to (Vsram - 100mV).
-		 * Keep doing it until Vsram and Vproc hit target voltages.
-		 */
-		do {
-			old_vsram = regulator_get_voltage(sram_reg);
-			if (old_vsram < 0) {
-				pr_err("%s: invalid vsram value: %d\n",
-				       __func__, old_vsram);
-				return old_vsram;
-			}
-			old_voltage = regulator_get_voltage(proc_reg);
-			if (old_voltage < 0) {
-				pr_err("%s: invalid vproc value: %d\n",
-				       __func__, old_voltage);
-				return old_voltage;
-			}
 
-			vsram = min(new_vsram, old_voltage + MAX_VOLT_SHIFT);
-
-			if (vsram + VOLT_TOL >= MAX_VOLT_LIMIT) {
-				vsram = MAX_VOLT_LIMIT;
+	old_vsram = regulator_get_voltage(sram_reg);
+	if (old_vsram < 0) {
+		pr_err("%s: invalid vsram value: %d\n", __func__, old_vsram);
+		return old_vsram;
+	}
 
-				/*
-				 * If the target Vsram hits the maximum voltage,
-				 * try to set the exact voltage value first.
-				 */
-				ret = regulator_set_voltage(sram_reg, vsram,
-							    vsram);
-				if (ret)
-					ret = regulator_set_voltage(sram_reg,
-							vsram - VOLT_TOL,
-							vsram);
+	new_vsram = clamp(new_voltage + soc_data->min_volt_shift,
+			  soc_data->sram_min_volt, soc_data->sram_max_volt);
 
-				voltage = new_voltage;
-			} else {
-				ret = regulator_set_voltage(sram_reg, vsram,
-							    vsram + VOLT_TOL);
+	do {
+		if (old_voltage <= new_voltage) {
+			vsram = clamp(old_voltage + soc_data->max_volt_shift,
+				      soc_data->sram_min_volt, new_vsram);
+			ret = regulator_set_voltage(sram_reg, vsram,
+						    soc_data->sram_max_volt);
 
-				voltage = vsram - MIN_VOLT_SHIFT;
-			}
 			if (ret)
 				return ret;
 
+			if (vsram == soc_data->sram_max_volt ||
+			    new_vsram == soc_data->sram_min_volt)
+				voltage = new_voltage;
+			else
+				voltage = vsram - soc_data->min_volt_shift;
+
 			ret = regulator_set_voltage(proc_reg, voltage,
-						    voltage + VOLT_TOL);
+						    soc_data->proc_max_volt);
 			if (ret) {
 				regulator_set_voltage(sram_reg, old_vsram,
-						      old_vsram);
+						      soc_data->sram_max_volt);
 				return ret;
 			}
-		} while (voltage < new_voltage || vsram < new_vsram);
-	} else if (old_voltage > new_voltage) {
-		/*
-		 * When scaling down voltages, Vsram and Vproc scale down step
-		 * by step. At each step, set Vproc to (Vsram - 200mV) first,
-		 * then set Vproc to (Vproc + 100mV).
-		 * Keep doing it until Vsram and Vproc hit target voltages.
-		 */
-		do {
-			old_voltage = regulator_get_voltage(proc_reg);
-			if (old_voltage < 0) {
-				pr_err("%s: invalid vproc value: %d\n",
-				       __func__, old_voltage);
-				return old_voltage;
-			}
-			old_vsram = regulator_get_voltage(sram_reg);
-			if (old_vsram < 0) {
-				pr_err("%s: invalid vsram value: %d\n",
-				       __func__, old_vsram);
-				return old_vsram;
-			}
-
-			voltage = max(new_voltage, old_vsram - MAX_VOLT_SHIFT);
+		} else if (old_voltage > new_voltage) {
+			voltage = max(new_voltage,
+				    old_vsram - soc_data->max_volt_shift);
 			ret = regulator_set_voltage(proc_reg, voltage,
-						    voltage + VOLT_TOL);
+						    soc_data->proc_max_volt);
 			if (ret)
 				return ret;
 
 			if (voltage == new_voltage)
 				vsram = new_vsram;
 			else
-				vsram = max(new_vsram, voltage + MIN_VOLT_SHIFT);
-
-			if (vsram + VOLT_TOL >= MAX_VOLT_LIMIT) {
-				vsram = MAX_VOLT_LIMIT;
-
-				/*
-				 * If the target Vsram hits the maximum voltage,
-				 * try to set the exact voltage value first.
-				 */
-				ret = regulator_set_voltage(sram_reg, vsram,
-							    vsram);
-				if (ret)
-					ret = regulator_set_voltage(sram_reg,
-							vsram - VOLT_TOL,
-							vsram);
-			} else {
-				ret = regulator_set_voltage(sram_reg, vsram,
-							    vsram + VOLT_TOL);
-			}
+				vsram = max(new_vsram,
+					    voltage + soc_data->min_volt_shift);
 
+			ret = regulator_set_voltage(sram_reg, vsram,
+						    soc_data->sram_max_volt);
 			if (ret) {
 				regulator_set_voltage(proc_reg, old_voltage,
-						      old_voltage);
+						      soc_data->proc_max_volt);
 				return ret;
 			}
-		} while (voltage > new_voltage + VOLT_TOL ||
-			 vsram > new_vsram + VOLT_TOL);
-	}
+		}
+
+		old_voltage = voltage;
+		old_vsram = vsram;
+	} while (voltage != new_voltage || vsram != new_vsram);
 
 	return 0;
 }
@@ -198,11 +162,12 @@ static int mtk_cpufreq_set_voltage(struct mtk_cpufreq_drv *drv, int voltage)
 {
 	int ret;
 
-	if (drv->need_voltage_tracking)
+	if (drv->soc_data->need_voltage_tracking)
 		ret = mtk_cpufreq_voltage_tracking(drv, voltage);
 	else
 		ret = regulator_set_voltage(drv->proc_reg, voltage,
-					    MAX_VOLT_LIMIT);
+					    drv->soc_data->proc_max_volt);
+
 	if (!ret)
 		drv->old_voltage = voltage;
 
@@ -218,7 +183,7 @@ static int mtk_cpufreq_target_index(struct cpufreq_policy *policy,
 	struct mtk_cpufreq_drv *drv = policy->driver_data;
 	struct device *cpu_dev = drv->cpu_dev;
 	struct dev_pm_opp *opp;
-	unsigned long freq, old_freq;
+	unsigned long freq;
 	int voltage, old_voltage, inter_voltage, target_voltage, ret;
 
 	inter_voltage = drv->inter_voltage;
@@ -233,7 +198,6 @@ static int mtk_cpufreq_target_index(struct cpufreq_policy *policy,
 	voltage = dev_pm_opp_get_voltage(opp);
 	dev_pm_opp_put(opp);
 
-	old_freq = clk_get_rate(cpu_clk);
 	old_voltage = drv->old_voltage;
 	if (old_voltage == 0)
 		old_voltage = regulator_get_voltage(drv->proc_reg);
@@ -244,9 +208,10 @@ static int mtk_cpufreq_target_index(struct cpufreq_policy *policy,
 	}
 
 	mutex_lock(&drv->lock);
+
 	/* scale up: set voltage first then freq. */
-	target_voltage = (inter_voltage > voltage) ? inter_voltage : voltage;
-	if (old_voltage < target_voltage) {
+	target_voltage = max(inter_voltage, voltage);
+	if (old_voltage <= target_voltage) {
 		ret = mtk_cpufreq_set_voltage(drv, target_voltage);
 		if (ret) {
 			pr_err("cpu%d: failed to scale up voltage\n",
@@ -296,9 +261,7 @@ static int mtk_cpufreq_target_index(struct cpufreq_policy *policy,
 		if (ret) {
 			pr_err("cpu%d: failed to scale down voltage\n",
 			       policy->cpu);
-			clk_set_parent(cpu_clk, drv->inter_clk);
-			clk_set_rate(armpll, old_freq);
-			clk_set_parent(cpu_clk, armpll);
+			WARN_ON(1);
 			mutex_unlock(&drv->lock);
 			return ret;
 		}
@@ -364,12 +327,11 @@ static int mtk_cpufreq_opp_notifier(struct notifier_block *nb,
 
 static int mtk_cpufreq_drv_init(struct mtk_cpufreq_drv *drv, int cpu)
 {
-	struct device *cpu_dev;
+	struct device *cpu_dev = get_cpu_device(cpu);
 	struct dev_pm_opp *opp;
-	unsigned long rate;
+	unsigned long rate, opp_volt;
 	int ret;
 
-	cpu_dev = get_cpu_device(cpu);
 	if (!cpu_dev) {
 		dev_err(cpu_dev, "cpu%d: failed to get cpu device\n", cpu);
 		return -ENODEV;
@@ -382,8 +344,9 @@ static int mtk_cpufreq_drv_init(struct mtk_cpufreq_drv *drv, int cpu)
 	drv->cpu_clk = clk_get(cpu_dev, "cpu");
 	if (IS_ERR(drv->cpu_clk)) {
 		ret = PTR_ERR(drv->cpu_clk);
-		return dev_err_probe(cpu_dev, ret,
-				     "cpu%d: failed to get cpu clk\n", cpu);
+		dev_err_probe(cpu_dev, ret, "cpu%d: failed to get cpu clk\n",
+			      cpu);
+		goto out_free_resources;
 	}
 
 	drv->inter_clk = clk_get(cpu_dev, "intermediate");
@@ -394,6 +357,23 @@ static int mtk_cpufreq_drv_init(struct mtk_cpufreq_drv *drv, int cpu)
 		goto out_free_resources;
 	}
 
+	if (drv->soc_data->need_voltage_tracking) {
+		drv->sram_reg = regulator_get_optional(cpu_dev, "sram");
+		if (IS_ERR_OR_NULL(drv->sram_reg)) {
+			ret = PTR_ERR(drv->sram_reg);
+			dev_err_probe(cpu_dev, ret,
+				      "cpu%d: failed to get sram regulator\n",
+				      cpu);
+			goto out_free_resources;
+		}
+
+		ret = regulator_enable(drv->sram_reg);
+		if (ret) {
+			dev_warn(cpu_dev, "cpu%d: failed to enable sram regulator\n", cpu);
+			goto out_free_resources;
+		}
+	}
+
 	drv->proc_reg = regulator_get_optional(cpu_dev, "proc");
 	if (IS_ERR(drv->proc_reg)) {
 		ret = PTR_ERR(drv->proc_reg);
@@ -408,10 +388,14 @@ static int mtk_cpufreq_drv_init(struct mtk_cpufreq_drv *drv, int cpu)
 		goto out_free_resources;
 	}
 
-	/* Both presence and absence of sram regulator are valid cases. */
-	drv->sram_reg = regulator_get_exclusive(cpu_dev, "sram");
+	ret = clk_prepare_enable(drv->cpu_clk);
+	if (ret)
+		goto out_free_opp_table;
+
+	ret = clk_prepare_enable(drv->inter_clk);
+	if (ret)
+		goto out_free_opp_table;
 
-	/* Get OPP-sharing information from "operating-points-v2" bindings */
 	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, &drv->cpus);
 	if (ret) {
 		dev_err(cpu_dev, "cpu%d: failed to get opp-sharing information\n",
@@ -425,62 +409,66 @@ static int mtk_cpufreq_drv_init(struct mtk_cpufreq_drv *drv, int cpu)
 		goto out_free_resources;
 	}
 
-	ret = clk_prepare_enable(drv->cpu_clk);
-	if (ret)
-		goto out_free_opp_table;
-
-	ret = clk_prepare_enable(drv->inter_clk);
-	if (ret)
-		goto out_disable_mux_clock;
+	drv->opp_freq = clk_get_rate(drv->cpu_clk);
 
-	/* Search a safe voltage for intermediate frequency. */
 	rate = clk_get_rate(drv->inter_clk);
 	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
 	if (IS_ERR(opp)) {
+		ret = PTR_ERR(opp);
 		dev_err(cpu_dev, "cpu%d: failed to get intermediate opp\n",
 			cpu);
-		ret = PTR_ERR(opp);
-		goto out_disable_inter_clock;
+		goto out_free_opp_table;
 	}
 	drv->inter_voltage = dev_pm_opp_get_voltage(opp);
 	dev_pm_opp_put(opp);
 
+	rate = U32_MAX;
+	opp = dev_pm_opp_find_freq_floor(drv->cpu_dev, &rate);
+	if (IS_ERR(opp)) {
+		ret = PTR_ERR(opp);
+		dev_err(cpu_dev, "cpu%d: failed to get opp\n", drv->opp_cpu);
+		goto out_free_opp_table;
+	}
+
+	opp_volt = dev_pm_opp_get_voltage(opp);
+	dev_pm_opp_put(opp);
+	ret = mtk_cpufreq_set_voltage(drv, opp_volt);
+	if (ret) {
+		dev_err(cpu_dev, "cpu%d: failed to scale to highest voltage %lu in proc_reg\n",
+			drv->opp_cpu, opp_volt);
+		goto out_free_opp_table;
+	}
+
 	drv->opp_nb.notifier_call = mtk_cpufreq_opp_notifier;
 	ret = dev_pm_opp_register_notifier(cpu_dev, &drv->opp_nb);
 	if (ret) {
 		dev_warn(cpu_dev, "cpu%d: failed to register opp notifier\n",
 			 cpu);
-		goto out_disable_inter_clock;
+		goto out_free_opp_table;
 	}
 
-	drv->opp_freq = clk_get_rate(drv->cpu_clk);
-
-	/*
-	 * If SRAM regulator is present, software "voltage tracking" is needed
-	 * for this CPU power domain.
-	 */
-	drv->need_voltage_tracking = !IS_ERR(drv->sram_reg);
-
 	return 0;
 
-out_disable_inter_clock:
-	clk_disable_unprepare(drv->inter_clk);
-
-out_disable_mux_clock:
-	clk_disable_unprepare(drv->cpu_clk);
-
 out_free_opp_table:
 	dev_pm_opp_of_cpumask_remove_table(&drv->cpus);
 
 out_free_resources:
-	if (!IS_ERR(drv->proc_reg))
+	if (!IS_ERR(drv->proc_reg)) {
+		regulator_disable(drv->proc_reg);
 		regulator_put(drv->proc_reg);
-	if (!IS_ERR(drv->sram_reg))
+	}
+	if (!IS_ERR(drv->sram_reg)) {
+		regulator_disable(drv->sram_reg);
 		regulator_put(drv->sram_reg);
-	if (!IS_ERR(drv->cpu_clk))
+	}
+	if (!IS_ERR(drv->cpu_clk)) {
+		clk_disable_unprepare(drv->cpu_clk);
 		clk_put(drv->cpu_clk);
-	if (!IS_ERR(drv->inter_clk))
+	}
+	if (!IS_ERR(drv->inter_clk)) {
+		clk_disable_unprepare(drv->inter_clk);
 		clk_put(drv->inter_clk);
+	}
 
 	return ret;
 }
@@ -491,8 +479,10 @@ static void mtk_cpufreq_drv_release(struct mtk_cpufreq_drv *drv)
 		regulator_disable(drv->proc_reg);
 		regulator_put(drv->proc_reg);
 	}
-	if (!IS_ERR(drv->sram_reg))
+	if (!IS_ERR(drv->sram_reg)) {
+		regulator_disable(drv->sram_reg);
 		regulator_put(drv->sram_reg);
+	}
 	if (!IS_ERR(drv->cpu_clk)) {
 		clk_disable_unprepare(drv->cpu_clk);
 		clk_put(drv->cpu_clk);
@@ -548,7 +538,7 @@ static struct cpufreq_driver cpufreq_mtk_driver = {
 		 CPUFREQ_IS_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = mtk_cpufreq_target_index,
-	.get = cpufreq_generic_get,
+	.get = mtk_cpufreq_get,
 	.init = mtk_cpufreq_init,
 	.exit = mtk_cpufreq_exit,
 	.register_em = cpufreq_register_em_with_opp,
@@ -558,9 +548,16 @@ static struct cpufreq_driver cpufreq_mtk_driver = {
 
 static int mtk_cpufreq_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
 	struct mtk_cpufreq_drv *drv, *tmp;
 	int cpu, ret;
 
+	match = dev_get_platdata(&pdev->dev);
+	if (!match || !match->data) {
+		dev_err(&pdev->dev, "no mtk cpufreq platform data?\n");
+		return -ENODEV;
+	}
+
 	for_each_possible_cpu(cpu) {
 		drv = mtk_cpufreq_drv_lookup(cpu);
 		if (drv)
@@ -572,6 +569,7 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
 			goto out_release_drv_list;
 		}
 
+		drv->soc_data = (const struct mtk_cpufreq_platform_data *)match->data;
 		ret = mtk_cpufreq_drv_init(drv, cpu);
 		if (ret) {
 			dev_err(&pdev->dev,
@@ -600,17 +598,26 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct mtk_cpufreq_platform_data mtk_platform_data = {
+	.min_volt_shift = 0,
+	.max_volt_shift = 0,
+	.proc_max_volt = 1150000,
+	.sram_min_volt = 0,
+	.sram_max_volt = 0,
+	.need_voltage_tracking = false,
+};
+
 /* List of machines supported by this driver */
 static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
-	{ .compatible = "mediatek,mt2701", },
-	{ .compatible = "mediatek,mt2712", },
-	{ .compatible = "mediatek,mt7622", },
-	{ .compatible = "mediatek,mt7623", },
-	{ .compatible = "mediatek,mt8167", },
-	{ .compatible = "mediatek,mt8173", },
-	{ .compatible = "mediatek,mt8183", },
-	{ .compatible = "mediatek,mt8365", },
-	{ .compatible = "mediatek,mt8516", },
+	{ .compatible = "mediatek,mt2701", .data = &mtk_platform_data },
+	{ .compatible = "mediatek,mt2712", .data = &mtk_platform_data },
+	{ .compatible = "mediatek,mt7622", .data = &mtk_platform_data },
+	{ .compatible = "mediatek,mt7623", .data = &mtk_platform_data },
+	{ .compatible = "mediatek,mt8167", .data = &mtk_platform_data },
+	{ .compatible = "mediatek,mt8173", .data = &mtk_platform_data },
+	{ .compatible = "mediatek,mt8183", .data = &mtk_platform_data },
+	{ .compatible = "mediatek,mt8365", .data = &mtk_platform_data },
+	{ .compatible = "mediatek,mt8516", .data = &mtk_platform_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_cpufreq_machines);
@@ -626,7 +633,6 @@ static int __init mtk_cpufreq_platdrv_init(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
-	struct platform_device *pdev;
 	int ret;
 
 	np = of_find_node_by_path("/");
@@ -644,17 +650,12 @@ static int __init mtk_cpufreq_platdrv_init(void)
 	if (ret)
 		return ret;
 
-	/*
-	 * Since there's no place to hold device registration code and no
-	 * device tree based way to match cpufreq driver yet, both the driver
-	 * and the device registration codes are put here to handle defer
-	 * probing.
-	 */
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
@@ -663,6 +664,7 @@ module_init(mtk_cpufreq_platdrv_init)
 
 static void __exit mtk_cpufreq_platdrv_exit(void)
 {
+	platform_device_unregister(cpufreq_pdev);
 	platform_driver_unregister(&mtk_cpufreq_platdrv);
 }
 module_exit(mtk_cpufreq_platdrv_exit)
-- 
2.18.0


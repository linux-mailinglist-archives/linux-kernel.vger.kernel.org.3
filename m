Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22FA502535
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350607AbiDOGCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350291AbiDOGCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:02:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5400CBF56;
        Thu, 14 Apr 2022 22:59:35 -0700 (PDT)
X-UUID: 99b527f1244e4c57b7dd1375de76be7d-20220415
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:634c03d8-e3c5-4ef5-b9b4-080a8bd8c246,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.4,REQID:634c03d8-e3c5-4ef5-b9b4-080a8bd8c246,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:faefae9,CLOUDID:9d987678-0afa-4dca-bdec-ca54c998425a,C
        OID:FAIL,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,Q
        S:0,BEC:nil
X-UUID: 99b527f1244e4c57b7dd1375de76be7d-20220415
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 269884715; Fri, 15 Apr 2022 13:59:21 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 15 Apr 2022 13:59:19 +0800
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
Subject: [PATCH V3 09/15] cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()
Date:   Fri, 15 Apr 2022 13:59:10 +0800
Message-ID: <20220415055916.28350-10-rex-bc.chen@mediatek.com>
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

Because the difference of sram and proc should in a range of min_volt_shift
and max_volt_shift. We need to adjust the sram and proc step by step.

We replace VOLT_TOL (voltage tolerance) with the platform data and update the
logic to determine the voltage boundary and invoking regulator_set_voltage.

- Use 'sram_min_volt' and 'sram_max_volt' to determine the voltage boundary
  of sram regulator.
- Use (sram_min_volt - min_volt_shift) and 'proc_max_volt' to determine the
  voltage boundary of vproc regulator.

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 130 ++++++++---------------------
 1 file changed, 34 insertions(+), 96 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 559f4a383d30..cc44a7a9427a 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -8,6 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -15,8 +16,6 @@
 #include <linux/pm_opp.h>
 #include <linux/regulator/consumer.h>
 
-#define VOLT_TOL		(10000)
-
 struct mtk_cpufreq_platform_data {
 	int min_volt_shift;
 	int max_volt_shift;
@@ -94,91 +93,44 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 			"invalid Vproc value: %d\n", pre_vproc);
 		return pre_vproc;
 	}
-	/* Vsram should not exceed the maximum allowed voltage of SoC. */
-	new_vsram = min(new_vproc + soc_data->min_volt_shift,
-			soc_data->sram_max_volt);
-
-	if (pre_vproc < new_vproc) {
-		/*
-		 * When scaling up voltages, Vsram and Vproc scale up step
-		 * by step. At each step, set Vsram to (Vproc + 200mV) first,
-		 * then set Vproc to (Vsram - 100mV).
-		 * Keep doing it until Vsram and Vproc hit target voltages.
-		 */
-		do {
-			pre_vsram = regulator_get_voltage(sram_reg);
-			if (pre_vsram < 0) {
-				dev_err(info->cpu_dev,
-					"invalid Vsram value: %d\n", pre_vsram);
-				return pre_vsram;
-			}
-			pre_vproc = regulator_get_voltage(proc_reg);
-			if (pre_vproc < 0) {
-				dev_err(info->cpu_dev,
-					"invalid Vproc value: %d\n", pre_vproc);
-				return pre_vproc;
-			}
-
-			vsram = min(new_vsram,
-				    pre_vproc + soc_data->min_volt_shift);
 
-			if (vsram + VOLT_TOL >= soc_data->sram_max_volt) {
-				vsram = soc_data->sram_max_volt;
+	pre_vsram = regulator_get_voltage(sram_reg);
+	if (pre_vsram < 0) {
+		dev_err(info->cpu_dev, "invalid Vsram value: %d\n", pre_vsram);
+		return pre_vsram;
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
+	new_vsram = clamp(new_vproc + soc_data->min_volt_shift,
+			  soc_data->sram_min_volt, soc_data->sram_max_volt);
 
-				vproc = new_vproc;
-			} else {
-				ret = regulator_set_voltage(sram_reg, vsram,
-							    vsram + VOLT_TOL);
+	do {
+		if (pre_vproc <= new_vproc) {
+			vsram = clamp(pre_vproc + soc_data->max_volt_shift,
+				      soc_data->sram_min_volt, new_vsram);
+			ret = regulator_set_voltage(sram_reg, vsram,
+						    soc_data->sram_max_volt);
 
-				vproc = vsram - soc_data->min_volt_shift;
-			}
 			if (ret)
 				return ret;
 
+			if (vsram == soc_data->sram_max_volt ||
+			    new_vsram == soc_data->sram_min_volt)
+				vproc = new_vproc;
+			else
+				vproc = vsram - soc_data->min_volt_shift;
+
 			ret = regulator_set_voltage(proc_reg, vproc,
-						    vproc + VOLT_TOL);
+						    soc_data->proc_max_volt);
 			if (ret) {
 				regulator_set_voltage(sram_reg, pre_vsram,
-						      pre_vsram);
+						      soc_data->sram_max_volt);
 				return ret;
 			}
-		} while (vproc < new_vproc || vsram < new_vsram);
-	} else if (pre_vproc > new_vproc) {
-		/*
-		 * When scaling down voltages, Vsram and Vproc scale down step
-		 * by step. At each step, set Vproc to (Vsram - 200mV) first,
-		 * then set Vproc to (Vproc + 100mV).
-		 * Keep doing it until Vsram and Vproc hit target voltages.
-		 */
-		do {
-			pre_vproc = regulator_get_voltage(proc_reg);
-			if (pre_vproc < 0) {
-				dev_err(info->cpu_dev,
-					"invalid Vproc value: %d\n", pre_vproc);
-				return pre_vproc;
-			}
-			pre_vsram = regulator_get_voltage(sram_reg);
-			if (pre_vsram < 0) {
-				dev_err(info->cpu_dev,
-					"invalid Vsram value: %d\n", pre_vsram);
-				return pre_vsram;
-			}
-
+		} else if (pre_vproc > new_vproc) {
 			vproc = max(new_vproc,
 				    pre_vsram - soc_data->max_volt_shift);
 			ret = regulator_set_voltage(proc_reg, vproc,
-						    vproc + VOLT_TOL);
+						    soc_data->proc_max_volt);
 			if (ret)
 				return ret;
 
@@ -188,32 +140,18 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 				vsram = max(new_vsram,
 					    vproc + soc_data->min_volt_shift);
 
-			if (vsram + VOLT_TOL >= soc_data->sram_max_volt) {
-				vsram = soc_data->sram_max_volt;
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
-
+			ret = regulator_set_voltage(sram_reg, vsram,
+						    soc_data->sram_max_volt);
 			if (ret) {
 				regulator_set_voltage(proc_reg, pre_vproc,
-						      pre_vproc);
+						      soc_data->proc_max_volt);
 				return ret;
 			}
-		} while (vproc > new_vproc + VOLT_TOL ||
-			 vsram > new_vsram + VOLT_TOL);
-	}
+		}
+
+		pre_vproc = vproc;
+		pre_vsram = vsram;
+	} while (vproc != new_vproc || vsram != new_vsram);
 
 	return 0;
 }
@@ -275,8 +213,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	 * If the new voltage or the intermediate voltage is higher than the
 	 * current voltage, scale up voltage first.
 	 */
-	target_vproc = (inter_vproc > vproc) ? inter_vproc : vproc;
-	if (pre_vproc < target_vproc) {
+	target_vproc = max(inter_vproc, vproc);
+	if (pre_vproc <= target_vproc) {
 		ret = mtk_cpufreq_set_voltage(info, target_vproc);
 		if (ret) {
 			dev_err(cpu_dev,
-- 
2.18.0


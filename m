Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4A04F8E29
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiDHFC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbiDHFBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:01:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B1619FF46;
        Thu,  7 Apr 2022 21:59:26 -0700 (PDT)
X-UUID: 645d9c9094cb46778f217604269a5ad0-20220408
X-UUID: 645d9c9094cb46778f217604269a5ad0-20220408
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1923159763; Fri, 08 Apr 2022 12:59:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 8 Apr 2022 12:59:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Apr 2022 12:59:12 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <matthias.bgg@gmail.com>, <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, <hsinyi@google.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH V2 12/15] cpufreq: mediatek: Use maximum voltage in init stage
Date:   Fri, 8 Apr 2022 12:59:05 +0800
Message-ID: <20220408045908.21671-13-rex-bc.chen@mediatek.com>
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

From: Jia-Wei Chang <jia-wei.chang@mediatek.com>

Two or more clients may use the same regulator, and it could cause the
issue of high-freqeuncy-low-voltage.
To prevent this, we use maximum voltage in mtk_cpu_dvfs_info_init().

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index e69b16a6541e..b08ab7c14818 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -333,7 +333,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 {
 	struct device *cpu_dev;
 	struct dev_pm_opp *opp;
-	unsigned long rate;
+	unsigned long rate, opp_volt;
 	int ret;
 
 	cpu_dev = get_cpu_device(cpu);
@@ -417,6 +417,24 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	info->intermediate_voltage = dev_pm_opp_get_voltage(opp);
 	dev_pm_opp_put(opp);
 
+	/* Use highest opp voltage in the init stage */
+	rate = U32_MAX;
+	opp = dev_pm_opp_find_freq_floor(info->cpu_dev, &rate);
+	if (IS_ERR(opp)) {
+		ret = PTR_ERR(opp);
+		dev_err(cpu_dev, "cpu%d: failed to get opp\n", info->opp_cpu);
+		goto out_disable_inter_clock;
+	}
+
+	opp_volt = dev_pm_opp_get_voltage(opp);
+	dev_pm_opp_put(opp);
+	ret = mtk_cpufreq_set_voltage(info, opp_volt);
+	if (ret) {
+		dev_err(cpu_dev, "cpu%d: failed to scale to highest voltage %lu in proc_reg\n",
+			info->opp_cpu, opp_volt);
+		goto out_disable_inter_clock;
+	}
+
 	info->opp_cpu = cpu;
 	info->opp_nb.notifier_call = mtk_cpufreq_opp_notifier;
 	ret = dev_pm_opp_register_notifier(cpu_dev, &info->opp_nb);
-- 
2.18.0


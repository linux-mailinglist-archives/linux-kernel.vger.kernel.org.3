Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF53750B269
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445174AbiDVH4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445092AbiDVHzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:55:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5D851E52;
        Fri, 22 Apr 2022 00:52:56 -0700 (PDT)
X-UUID: bad63f417056459f820c9ab62b929d63-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:6d4504e7-4210-4b8a-a5d2-65e3bab26e6e,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:394097f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: bad63f417056459f820c9ab62b929d63-20220422
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1679407433; Fri, 22 Apr 2022 15:52:47 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 15:52:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Apr
 2022 15:52:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 15:52:44 +0800
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
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH V4 04/14] cpufreq: mediatek: Record previous target vproc value
Date:   Fri, 22 Apr 2022 15:52:29 +0800
Message-ID: <20220422075239.16437-5-rex-bc.chen@mediatek.com>
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

From: Jia-Wei Chang <jia-wei.chang@mediatek.com>

We found the buck voltage may not be exactly the same with what we set
because CPU may share the same buck with other module.
Therefore, we need to record the previous desired value instead of reading
it from regulators.

Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index ff27f77e8ee6..1688cf68849c 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -40,6 +40,7 @@ struct mtk_cpu_dvfs_info {
 	struct list_head list_head;
 	int intermediate_voltage;
 	bool need_voltage_tracking;
+	int pre_vproc;
 };
 
 static LIST_HEAD(dvfs_info_list);
@@ -191,11 +192,17 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 
 static int mtk_cpufreq_set_voltage(struct mtk_cpu_dvfs_info *info, int vproc)
 {
+	int ret;
+
 	if (info->need_voltage_tracking)
-		return mtk_cpufreq_voltage_tracking(info, vproc);
+		ret = mtk_cpufreq_voltage_tracking(info, vproc);
 	else
-		return regulator_set_voltage(info->proc_reg, vproc,
-					     vproc + VOLT_TOL);
+		ret = regulator_set_voltage(info->proc_reg, vproc,
+					    MAX_VOLT_LIMIT);
+	if (!ret)
+		info->pre_vproc = vproc;
+
+	return ret;
 }
 
 static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
@@ -213,7 +220,12 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	inter_vproc = info->intermediate_voltage;
 
 	pre_freq_hz = clk_get_rate(cpu_clk);
-	pre_vproc = regulator_get_voltage(info->proc_reg);
+
+	if (unlikely(info->pre_vproc <= 0))
+		pre_vproc = regulator_get_voltage(info->proc_reg);
+	else
+		pre_vproc = info->pre_vproc;
+
 	if (pre_vproc < 0) {
 		dev_err(cpu_dev, "invalid Vproc value: %d\n", pre_vproc);
 		return pre_vproc;
-- 
2.18.0


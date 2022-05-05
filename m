Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB32151BE96
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiEEL4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358620AbiEEL42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:56:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C750F546A2;
        Thu,  5 May 2022 04:52:48 -0700 (PDT)
X-UUID: 409002121848422793006343771c1647-20220505
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:65f105c7-ddfa-4dcc-9f1f-b6d61d88773c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:0dea5116-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 409002121848422793006343771c1647-20220505
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 248705018; Thu, 05 May 2022 19:52:35 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 5 May 2022 19:52:34 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 5 May 2022 19:52:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 5 May 2022 19:52:28 +0800
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
Subject: [PATCH v6 02/10] cpufreq: mediatek: Add platform_device_unregister when driver exit
Date:   Thu, 5 May 2022 19:52:18 +0800
Message-ID: <20220505115226.20130-3-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220505115226.20130-1-rex-bc.chen@mediatek.com>
References: <20220505115226.20130-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We register the platform device when driver inits. However, we do not
unregister it when driver exits.
To resolve this, we declare the platform data to be a global static
variable and rename it to be "cpufreq_pdev".
With this global variable, we can do platform_device_unregister() when
driver exits.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 901042e9a240..d15cbef4a72e 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -43,6 +43,8 @@ struct mtk_cpu_dvfs_info {
 	int pre_vproc;
 };
 
+static struct platform_device *cpufreq_pdev;
+
 static LIST_HEAD(dvfs_info_list);
 
 static struct mtk_cpu_dvfs_info *mtk_cpu_dvfs_info_lookup(int cpu)
@@ -578,7 +580,6 @@ static int __init mtk_cpufreq_driver_init(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
-	struct platform_device *pdev;
 	int err;
 
 	np = of_find_node_by_path("/");
@@ -602,11 +603,11 @@ static int __init mtk_cpufreq_driver_init(void)
 	 * and the device registration codes are put here to handle defer
 	 * probing.
 	 */
-	pdev = platform_device_register_simple("mtk-cpufreq", -1, NULL, 0);
-	if (IS_ERR(pdev)) {
+	cpufreq_pdev = platform_device_register_simple("mtk-cpufreq", -1, NULL, 0);
+	if (IS_ERR(cpufreq_pdev)) {
 		pr_err("failed to register mtk-cpufreq platform device\n");
 		platform_driver_unregister(&mtk_cpufreq_platdrv);
-		return PTR_ERR(pdev);
+		return PTR_ERR(cpufreq_pdev);
 	}
 
 	return 0;
@@ -615,6 +616,7 @@ module_init(mtk_cpufreq_driver_init)
 
 static void __exit mtk_cpufreq_driver_exit(void)
 {
+	platform_device_unregister(cpufreq_pdev);
 	platform_driver_unregister(&mtk_cpufreq_platdrv);
 }
 module_exit(mtk_cpufreq_driver_exit)
-- 
2.18.0


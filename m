Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B379953A3E9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352729AbiFALXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351199AbiFALWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:22:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2771241983;
        Wed,  1 Jun 2022 04:22:15 -0700 (PDT)
X-UUID: 7232c323de6e4d67aee1036127ed6ebd-20220601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:50f74ee6-8e41-4f4b-a73f-eddef683470e,OB:10,L
        OB:40,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:50f74ee6-8e41-4f4b-a73f-eddef683470e,OB:10,LOB
        :40,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:c090268a-32d7-4fc0-b2ef-8776ac194f8f,C
        OID:c5525a130d66,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 7232c323de6e4d67aee1036127ed6ebd-20220601
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1556151364; Wed, 01 Jun 2022 19:22:06 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 1 Jun 2022 19:22:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 1 Jun 2022 19:22:06 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Dustin L. Howett" <dustin@howett.net>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Subject: [PATCH v1 13/15] remoteproc: mediatek: Wait SCP core 1 probe done
Date:   Wed, 1 Jun 2022 19:21:59 +0800
Message-ID: <20220601112201.15510-14-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220601112201.15510-1-tinghan.shen@mediatek.com>
References: <20220601112201.15510-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCP core 1 driver probing must finish before start loading SCP core 1
image. Add a simple flag checking mechanism when preparing SCP core 1
subdevice.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h     |  1 +
 drivers/remoteproc/mtk_scp_dual.c   |  2 ++
 drivers/remoteproc/mtk_scp_subdev.c | 35 ++++++++++++++++++++++++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index a5c26e56277d..464d013ed6b2 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -153,6 +153,7 @@ struct mtk_scp {
 
 	struct rproc_subdev *rpmsg_subdev;
 	struct rproc_subdev *dual_subdev;
+	int dual_probe_done;
 };
 
 /**
diff --git a/drivers/remoteproc/mtk_scp_dual.c b/drivers/remoteproc/mtk_scp_dual.c
index 90c49716dd39..ab62ab54175c 100644
--- a/drivers/remoteproc/mtk_scp_dual.c
+++ b/drivers/remoteproc/mtk_scp_dual.c
@@ -266,6 +266,8 @@ static int scp_dual_probe(struct platform_device *pdev)
 	if (ret)
 		goto remove_ipi;
 
+	scp->dual_probe_done = 1;
+
 	return 0;
 
 remove_ipi:
diff --git a/drivers/remoteproc/mtk_scp_subdev.c b/drivers/remoteproc/mtk_scp_subdev.c
index 197fb207c756..71dc6fcad61a 100644
--- a/drivers/remoteproc/mtk_scp_subdev.c
+++ b/drivers/remoteproc/mtk_scp_subdev.c
@@ -20,6 +20,7 @@ static struct mtk_scp *scp_dual_get(struct mtk_scp *scp)
 	struct device *dev = scp->dev;
 	struct device_node *np;
 	struct platform_device *dual_pdev;
+	struct mtk_scp *scp_dual;
 
 	np = of_parse_phandle(dev->of_node, "mediatek,scp-core", SCP_DTS_CORE_REF);
 	dual_pdev = of_find_device_by_node(np);
@@ -30,7 +31,11 @@ static struct mtk_scp *scp_dual_get(struct mtk_scp *scp)
 		return NULL;
 	}
 
-	return platform_get_drvdata(dual_pdev);
+	scp_dual = platform_get_drvdata(dual_pdev);
+	if (!scp_dual)
+		put_device(&dual_pdev->dev);
+
+	return scp_dual;
 }
 
 static void scp_dual_put(struct mtk_scp *scp)
@@ -38,6 +43,33 @@ static void scp_dual_put(struct mtk_scp *scp)
 	put_device(scp->dev);
 }
 
+static int scp_dual_rproc_prepare(struct rproc_subdev *subdev)
+{
+	struct scp_subdev_core *subdev_core = to_subdev_core(subdev);
+	struct mtk_scp *scp = subdev_core->main_scp;
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(100);
+	while (1) {
+		struct mtk_scp *scp_dual = scp_dual_get(scp);
+
+		if (scp_dual && scp_dual->dual_probe_done) {
+			scp_dual_put(scp_dual);
+			break;
+		}
+
+		if (scp_dual && !scp_dual->dual_probe_done)
+			scp_dual_put(scp_dual);
+
+		if (time_after(jiffies, timeout)) {
+			dev_err(scp->dev, "scp-dual probe timeout\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
 static int scp_dual_rproc_start(struct rproc_subdev *subdev)
 {
 	struct scp_subdev_core *subdev_core = to_subdev_core(subdev);
@@ -111,6 +143,7 @@ struct rproc_subdev *scp_dual_create_subdev(struct mtk_scp *scp)
 
 	subdev_core->main_scp = scp;
 	subdev_core->scp_dual_wdt_timeout = scp_dual_wdt_handler;
+	subdev_core->subdev.prepare = scp_dual_rproc_prepare;
 	subdev_core->subdev.start = scp_dual_rproc_start;
 	subdev_core->subdev.stop = scp_dual_rproc_stop;
 
-- 
2.18.0


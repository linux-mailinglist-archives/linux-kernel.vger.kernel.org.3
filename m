Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E4D542B4E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiFHJSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbiFHJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:14:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42301E7348;
        Wed,  8 Jun 2022 01:36:10 -0700 (PDT)
X-UUID: 09d8dafa31464edba8697fe29c733233-20220608
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:238cc072-fe5f-4b93-8438-131e46df9dcf,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:238cc072-fe5f-4b93-8438-131e46df9dcf,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:3d2515e5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:ab9fe7398c47,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 09d8dafa31464edba8697fe29c733233-20220608
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 484781445; Wed, 08 Jun 2022 16:36:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 8 Jun 2022 16:36:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 8 Jun 2022 16:36:03 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        "Guenter Roeck" <groeck@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Subject: [PATCH v2 8/9] remoteproc: mediatek: Wait SCP core 1 probe done
Date:   Wed, 8 Jun 2022 16:35:52 +0800
Message-ID: <20220608083553.8697-9-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220608083553.8697-1-tinghan.shen@mediatek.com>
References: <20220608083553.8697-1-tinghan.shen@mediatek.com>
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
 drivers/remoteproc/mtk_common.h |  1 +
 drivers/remoteproc/mtk_scp.c    | 38 ++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 67b41866a100..89f9e53a5879 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -153,6 +153,7 @@ struct mtk_scp {
 
 	struct rproc_subdev *rpmsg_subdev;
 	struct rproc_subdev *dual_subdev;
+	int dual_probe_done;
 };
 
 /**
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index d0e9e19e251f..b66bee4beb4d 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -937,6 +937,7 @@ static struct mtk_scp *scp_dual_get(struct mtk_scp *scp)
 	struct device *dev = scp->dev;
 	struct device_node *np;
 	struct platform_device *dual_pdev;
+	struct mtk_scp *scp_dual;
 
 	np = of_parse_phandle(dev->of_node, "mediatek,scp-core", 0);
 	dual_pdev = of_find_device_by_node(np);
@@ -947,7 +948,11 @@ static struct mtk_scp *scp_dual_get(struct mtk_scp *scp)
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
@@ -955,6 +960,33 @@ static void scp_dual_put(struct mtk_scp *scp)
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
@@ -1014,6 +1046,7 @@ static struct rproc_subdev *scp_dual_create_subdev(struct mtk_scp *scp)
 
 	subdev_core->main_scp = scp;
 	subdev_core->scp_dual_wdt_timeout = scp_dual_wdt_handler;
+	subdev_core->subdev.prepare = scp_dual_rproc_prepare;
 	subdev_core->subdev.start = scp_dual_rproc_start;
 	subdev_core->subdev.stop = scp_dual_rproc_stop;
 
@@ -1155,6 +1188,9 @@ static int scp_probe(struct platform_device *pdev)
 	if (ret)
 		goto remove_subdev;
 
+	if (core_id == SCP_CORE_1)
+		scp->dual_probe_done = 1;
+
 	return 0;
 
 remove_subdev:
-- 
2.18.0


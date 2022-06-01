Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A9353A3F4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352749AbiFALXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351252AbiFALWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:22:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D2946141;
        Wed,  1 Jun 2022 04:22:16 -0700 (PDT)
X-UUID: 62499072bd7446e88494232e49fc2887-20220601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:3adaa018-0038-4699-a42d-4e4d54b3db1c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:2f91268a-32d7-4fc0-b2ef-8776ac194f8f,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 62499072bd7446e88494232e49fc2887-20220601
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1861863262; Wed, 01 Jun 2022 19:22:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 1 Jun 2022 19:22:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 1 Jun 2022 19:22:06 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Subject: [PATCH v1 14/15] remoteproc: mediatek: Support rpmsg for SCP core 1
Date:   Wed, 1 Jun 2022 19:22:00 +0800
Message-ID: <20220601112201.15510-15-tinghan.shen@mediatek.com>
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

Reuse the rpmsg subdevice flow of SCP core 0 on SCP core 1.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h   | 3 +++
 drivers/remoteproc/mtk_scp.c      | 6 ++++--
 drivers/remoteproc/mtk_scp_dual.c | 4 ++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 464d013ed6b2..89e2bec0a087 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -185,4 +185,7 @@ void scp_ipi_handler(struct mtk_scp *scp);
 
 struct rproc_subdev *scp_dual_create_subdev(struct mtk_scp *scp);
 void scp_dual_destroy_subdev(struct rproc_subdev *subdev);
+
+void scp_add_rpmsg_subdev(struct mtk_scp *scp);
+void scp_remove_rpmsg_subdev(struct mtk_scp *scp);
 #endif
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index c7bf0a44ba0d..fbeaa81e914d 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -825,7 +825,7 @@ static struct mtk_rpmsg_info mtk_scp_rpmsg_info = {
 	.ns_ipi_id = SCP_IPI_NS_SERVICE,
 };
 
-static void scp_add_rpmsg_subdev(struct mtk_scp *scp)
+void scp_add_rpmsg_subdev(struct mtk_scp *scp)
 {
 	scp->rpmsg_subdev =
 		mtk_rpmsg_create_rproc_subdev(to_platform_device(scp->dev),
@@ -833,8 +833,9 @@ static void scp_add_rpmsg_subdev(struct mtk_scp *scp)
 	if (scp->rpmsg_subdev)
 		rproc_add_subdev(scp->rproc, scp->rpmsg_subdev);
 }
+EXPORT_SYMBOL_GPL(scp_add_rpmsg_subdev);
 
-static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
+void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
 {
 	if (scp->rpmsg_subdev) {
 		rproc_remove_subdev(scp->rproc, scp->rpmsg_subdev);
@@ -842,6 +843,7 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
 		scp->rpmsg_subdev = NULL;
 	}
 }
+EXPORT_SYMBOL_GPL(scp_remove_rpmsg_subdev);
 
 static void scp_add_dual_subdev(struct mtk_scp *scp)
 {
diff --git a/drivers/remoteproc/mtk_scp_dual.c b/drivers/remoteproc/mtk_scp_dual.c
index ab62ab54175c..caa57516e083 100644
--- a/drivers/remoteproc/mtk_scp_dual.c
+++ b/drivers/remoteproc/mtk_scp_dual.c
@@ -249,6 +249,8 @@ static int scp_dual_probe(struct platform_device *pdev)
 	init_waitqueue_head(&scp->run.wq);
 	init_waitqueue_head(&scp->ack_wq);
 
+	scp_add_rpmsg_subdev(scp);
+
 	ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0), NULL,
 					scp_irq_handler, IRQF_ONESHOT,
 					pdev->name, scp);
@@ -271,6 +273,7 @@ static int scp_dual_probe(struct platform_device *pdev)
 	return 0;
 
 remove_ipi:
+	scp_remove_rpmsg_subdev(scp);
 	scp_ipi_unregister(scp, SCP_IPI_INIT);
 release_dev_mem:
 	scp_unmap_memory_region(scp);
@@ -286,6 +289,7 @@ static int scp_dual_remove(struct platform_device *pdev)
 	struct mtk_scp *scp = platform_get_drvdata(pdev);
 	int i;
 
+	scp_remove_rpmsg_subdev(scp);
 	scp_ipi_unregister(scp, SCP_IPI_INIT);
 	scp_unmap_memory_region(scp);
 	for (i = 0; i < SCP_IPI_MAX; i++)
-- 
2.18.0


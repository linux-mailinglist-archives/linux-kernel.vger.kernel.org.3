Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0F553A3E7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351234AbiFALXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350765AbiFALWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:22:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210574474F;
        Wed,  1 Jun 2022 04:22:14 -0700 (PDT)
X-UUID: 1d7a2d89b66241b5b091f02f8cc80c50-20220601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:01ec95b4-5f4d-4ff5-8aa0-667e0da3ca41,OB:10,L
        OB:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:01ec95b4-5f4d-4ff5-8aa0-667e0da3ca41,OB:10,LOB
        :10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:96648f14-f88c-475e-badf-d9ee54230b8f,C
        OID:63ea4881c016,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 1d7a2d89b66241b5b091f02f8cc80c50-20220601
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 410243960; Wed, 01 Jun 2022 19:22:07 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 1 Jun 2022 19:22:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 1 Jun 2022 19:22:05 +0800
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
Subject: [PATCH v1 09/15] remoteproc: mediatek: Register SCP core 1 initialization ipi
Date:   Wed, 1 Jun 2022 19:21:55 +0800
Message-ID: <20220601112201.15510-10-tinghan.shen@mediatek.com>
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

The SCP core 1 doesn't have vdec/venc functions like SCP core 0.
Remove usage of venc/vdec parameters.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_scp_dual.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/mtk_scp_dual.c b/drivers/remoteproc/mtk_scp_dual.c
index 7bed39722bd5..d4cc15e22640 100644
--- a/drivers/remoteproc/mtk_scp_dual.c
+++ b/drivers/remoteproc/mtk_scp_dual.c
@@ -20,6 +20,16 @@ static const struct rproc_ops scp_ops = {
 	.parse_fw	= scp_parse_fw,
 };
 
+static void scp_init_ipi_handler(void *data, unsigned int len, void *priv)
+{
+	struct mtk_scp *scp = (struct mtk_scp *)priv;
+	struct scp_run *run = (struct scp_run *)data;
+
+	scp->run.signaled = run->signaled;
+	strscpy(scp->run.fw_ver, run->fw_ver, SCP_FW_VER_LEN);
+	wake_up_interruptible(&scp->run.wq);
+}
+
 static int scp_dual_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -68,6 +78,13 @@ static int scp_dual_probe(struct platform_device *pdev)
 	for (i = 0; i < SCP_IPI_MAX; i++)
 		mutex_init(&scp->ipi_desc[i].lock);
 
+	/* register SCP initialization IPI */
+	ret = scp_ipi_register(scp, SCP_IPI_INIT, scp_init_ipi_handler, scp);
+	if (ret) {
+		dev_err(dev, "Failed to register IPI_SCP_INIT\n");
+		goto release_dev_mem;
+	}
+
 	init_waitqueue_head(&scp->run.wq);
 	init_waitqueue_head(&scp->ack_wq);
 
@@ -77,11 +94,13 @@ static int scp_dual_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
-		goto release_dev_mem;
+		goto remove_ipi;
 	}
 
 	return 0;
 
+remove_ipi:
+	scp_ipi_unregister(scp, SCP_IPI_INIT);
 release_dev_mem:
 	scp_unmap_memory_region(scp);
 	for (i = 0; i < SCP_IPI_MAX; i++)
@@ -96,6 +115,7 @@ static int scp_dual_remove(struct platform_device *pdev)
 	struct mtk_scp *scp = platform_get_drvdata(pdev);
 	int i;
 
+	scp_ipi_unregister(scp, SCP_IPI_INIT);
 	scp_unmap_memory_region(scp);
 	for (i = 0; i < SCP_IPI_MAX; i++)
 		mutex_destroy(&scp->ipi_desc[i].lock);
-- 
2.18.0


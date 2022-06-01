Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BC653A3E5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352641AbiFALW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350587AbiFALWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:22:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C762443AD8;
        Wed,  1 Jun 2022 04:22:14 -0700 (PDT)
X-UUID: 17bf1eb0c22d4f76a43a189dd38307f5-20220601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:257e5b34-b647-44bb-bb9e-96140dbf0861,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:257e5b34-b647-44bb-bb9e-96140dbf0861,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:ae90268a-32d7-4fc0-b2ef-8776ac194f8f,C
        OID:cf170092d950,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 17bf1eb0c22d4f76a43a189dd38307f5-20220601
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2088635505; Wed, 01 Jun 2022 19:22:06 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 1 Jun 2022 19:22:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 1 Jun 2022 19:22:05 +0800
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
Subject: [PATCH v1 07/15] remoteproc: mediatek: Add SCP core 1 reserved memory support
Date:   Wed, 1 Jun 2022 19:21:53 +0800
Message-ID: <20220601112201.15510-8-tinghan.shen@mediatek.com>
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

Reuse the SCP core 0 reserved memory API on SCP core 1.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h   | 2 ++
 drivers/remoteproc/mtk_scp.c      | 6 ++++--
 drivers/remoteproc/mtk_scp_dual.c | 5 +++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 2e46be605687..da3ea2243678 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -168,4 +168,6 @@ int scp_stop(struct rproc *rproc);
 int scp_load(struct rproc *rproc, const struct firmware *fw);
 void *scp_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem);
 int scp_parse_fw(struct rproc *rproc, const struct firmware *fw);
+int scp_map_memory_region(struct mtk_scp *scp);
+void scp_unmap_memory_region(struct mtk_scp *scp);
 #endif
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 7b9d12ec2d4f..75d161da0f59 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -747,7 +747,7 @@ void *scp_mapping_dm_addr(struct mtk_scp *scp, u32 mem_addr)
 }
 EXPORT_SYMBOL_GPL(scp_mapping_dm_addr);
 
-static int scp_map_memory_region(struct mtk_scp *scp)
+int scp_map_memory_region(struct mtk_scp *scp)
 {
 	int ret;
 
@@ -773,8 +773,9 @@ static int scp_map_memory_region(struct mtk_scp *scp)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(scp_map_memory_region);
 
-static void scp_unmap_memory_region(struct mtk_scp *scp)
+void scp_unmap_memory_region(struct mtk_scp *scp)
 {
 	if (scp->dram_size == 0)
 		return;
@@ -783,6 +784,7 @@ static void scp_unmap_memory_region(struct mtk_scp *scp)
 			  scp->dma_addr);
 	of_reserved_mem_device_release(scp->dev);
 }
+EXPORT_SYMBOL_GPL(scp_unmap_memory_region);
 
 static int scp_register_ipi(struct platform_device *pdev, u32 id,
 			    ipi_handler_t handler, void *priv)
diff --git a/drivers/remoteproc/mtk_scp_dual.c b/drivers/remoteproc/mtk_scp_dual.c
index e4ada5696bd7..0f932d26f864 100644
--- a/drivers/remoteproc/mtk_scp_dual.c
+++ b/drivers/remoteproc/mtk_scp_dual.c
@@ -60,6 +60,10 @@ static int scp_dual_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(scp->reg_base),
 				     "Failed to parse and map cfg memory\n");
 
+	ret = scp_map_memory_region(scp);
+	if (ret)
+		return ret;
+
 	mutex_init(&scp->send_lock);
 	for (i = 0; i < SCP_IPI_MAX; i++)
 		mutex_init(&scp->ipi_desc[i].lock);
@@ -75,6 +79,7 @@ static int scp_dual_remove(struct platform_device *pdev)
 	struct mtk_scp *scp = platform_get_drvdata(pdev);
 	int i;
 
+	scp_unmap_memory_region(scp);
 	for (i = 0; i < SCP_IPI_MAX; i++)
 		mutex_destroy(&scp->ipi_desc[i].lock);
 	mutex_destroy(&scp->send_lock);
-- 
2.18.0


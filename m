Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C0553A3EB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352687AbiFALXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352538AbiFALWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:22:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1626942A08;
        Wed,  1 Jun 2022 04:22:16 -0700 (PDT)
X-UUID: a9e2278eda1a493487c1d42d9a189f49-20220601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:2bf4b5a4-4a17-4456-a3cf-dcb57f4d3732,OB:60,L
        OB:60,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:90
X-CID-INFO: VERSION:1.1.5,REQID:2bf4b5a4-4a17-4456-a3cf-dcb57f4d3732,OB:60,LOB
        :60,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:90
X-CID-META: VersionHash:2a19b09,CLOUDID:b0648f14-f88c-475e-badf-d9ee54230b8f,C
        OID:cf170092d950,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: a9e2278eda1a493487c1d42d9a189f49-20220601
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2082968515; Wed, 01 Jun 2022 19:22:06 +0800
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
Subject: [PATCH v1 08/15] remoteproc: mediatek: Add SCP core 1 interrupt support
Date:   Wed, 1 Jun 2022 19:21:54 +0800
Message-ID: <20220601112201.15510-9-tinghan.shen@mediatek.com>
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

Reuse the interrupt handling API of SCP core 0 on SCP core 1.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h   |  1 +
 drivers/remoteproc/mtk_scp.c      |  3 ++-
 drivers/remoteproc/mtk_scp_dual.c | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index da3ea2243678..04f7ee590f96 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -170,4 +170,5 @@ void *scp_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem);
 int scp_parse_fw(struct rproc *rproc, const struct firmware *fw);
 int scp_map_memory_region(struct mtk_scp *scp);
 void scp_unmap_memory_region(struct mtk_scp *scp);
+irqreturn_t scp_irq_handler(int irq, void *priv);
 #endif
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 75d161da0f59..c67883c28a43 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -237,7 +237,7 @@ static void mt8195_scp_irq_handler(struct mtk_scp *scp)
 	}
 }
 
-static irqreturn_t scp_irq_handler(int irq, void *priv)
+irqreturn_t scp_irq_handler(int irq, void *priv)
 {
 	struct mtk_scp *scp = priv;
 	int ret;
@@ -254,6 +254,7 @@ static irqreturn_t scp_irq_handler(int irq, void *priv)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(scp_irq_handler);
 
 static int scp_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 {
diff --git a/drivers/remoteproc/mtk_scp_dual.c b/drivers/remoteproc/mtk_scp_dual.c
index 0f932d26f864..7bed39722bd5 100644
--- a/drivers/remoteproc/mtk_scp_dual.c
+++ b/drivers/remoteproc/mtk_scp_dual.c
@@ -71,7 +71,24 @@ static int scp_dual_probe(struct platform_device *pdev)
 	init_waitqueue_head(&scp->run.wq);
 	init_waitqueue_head(&scp->ack_wq);
 
+	ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0), NULL,
+					scp_irq_handler, IRQF_ONESHOT,
+					pdev->name, scp);
+
+	if (ret) {
+		dev_err(dev, "failed to request irq\n");
+		goto release_dev_mem;
+	}
+
 	return 0;
+
+release_dev_mem:
+	scp_unmap_memory_region(scp);
+	for (i = 0; i < SCP_IPI_MAX; i++)
+		mutex_destroy(&scp->ipi_desc[i].lock);
+	mutex_destroy(&scp->send_lock);
+
+	return ret;
 }
 
 static int scp_dual_remove(struct platform_device *pdev)
-- 
2.18.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40305449D7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbiFILSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240884AbiFILSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:18:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D923EAB1;
        Thu,  9 Jun 2022 04:18:13 -0700 (PDT)
X-UUID: 31dd457621b54ff68976ebd409c9348a-20220609
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:6b24e070-4e65-495d-ba0d-9a99248133ca,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:2a19b09,CLOUDID:92c841e5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 31dd457621b54ff68976ebd409c9348a-20220609
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <mengqi.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 253463372; Thu, 09 Jun 2022 19:18:08 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 9 Jun 2022 19:18:07 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 9 Jun 2022 19:18:07 +0800
From:   Mengqi Zhang <mengqi.zhang@mediatek.com>
To:     <chaotian.jing@mediatek.com>, <ulf.hansson@linaro.org>,
        <matthias.bgg@gmail.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wenbin.mei@mediatek.com>,
        Mengqi Zhang <mengqi.zhang@mediatek.com>
Subject: [PATCH V2] mmc: mediatek: wait dma stop bit reset to 0
Date:   Thu, 9 Jun 2022 19:17:50 +0800
Message-ID: <20220609111750.18571-1-mengqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek IP requires that after dma stop, it need to wait this dma stop
bit auto-reset to 0. When bus is in high loading state, it will take a
while for the dma stop complete. If there is no waiting operation here,
when program runs to clear fifo and reset, bus will hang.

In addition, there should be no return in msdc_data_xfer_next() if
there is data need be transferred, because no matter what error occurs
here, it should continue to excute to the following mmc_request_done.
Otherwise the core layer may wait complete forever.

Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 195dc897188b..c925f45786c2 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1385,12 +1385,15 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
 		sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_STOP,
 				1);
 
+		ret = readl_poll_timeout_atomic(host->base + MSDC_DMA_CTRL, val,
+						!(val & MSDC_DMA_CTRL_STOP), 1, 20000);
+		if (ret)
+			dev_dbg(host->dev, "DMA stop timed out\n");
+
 		ret = readl_poll_timeout_atomic(host->base + MSDC_DMA_CFG, val,
 						!(val & MSDC_DMA_CFG_STS), 1, 20000);
-		if (ret) {
-			dev_dbg(host->dev, "DMA stop timed out\n");
-			return false;
-		}
+		if (ret)
+			dev_dbg(host->dev, "DMA inactive timed out\n");
 
 		sdr_clr_bits(host->base + MSDC_INTEN, data_ints_mask);
 		dev_dbg(host->dev, "DMA stop\n");
@@ -2416,6 +2419,9 @@ static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
 	if (recovery) {
 		sdr_set_field(host->base + MSDC_DMA_CTRL,
 			      MSDC_DMA_CTRL_STOP, 1);
+		if (WARN_ON(readl_poll_timeout(host->base + MSDC_DMA_CTRL, val,
+			!(val & MSDC_DMA_CTRL_STOP), 1, 3000)))
+			return;
 		if (WARN_ON(readl_poll_timeout(host->base + MSDC_DMA_CFG, val,
 			!(val & MSDC_DMA_CFG_STS), 1, 3000)))
 			return;
-- 
2.25.1


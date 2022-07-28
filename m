Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2A35839F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbiG1IBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiG1IBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:01:15 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FE06052A;
        Thu, 28 Jul 2022 01:01:07 -0700 (PDT)
X-UUID: 00afaecb19a94d82a2ad66a64a5d3bb0-20220728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:4a3bf7fe-f541-4f2a-aea3-d2995e46dd07,OB:-327
        68,LOB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-32768,FILE:0,RULE:Relea
        se_Ham,ACTION:release,TS:-5
X-CID-INFO: VERSION:1.1.8,REQID:4a3bf7fe-f541-4f2a-aea3-d2995e46dd07,OB:-32768
        ,LOB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-32768,FILE:0,RULE:Release
        _Ham,ACTION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:564690d0-841b-4e95-ad42-8f86e18f54fc,C
        OID:nil,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,QS:
        nil,BEC:nil,COL:0
X-UUID: 00afaecb19a94d82a2ad66a64a5d3bb0-20220728
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1373914139; Thu, 28 Jul 2022 16:00:55 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 28 Jul 2022 16:00:54 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 28 Jul 2022 16:00:52 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: mtk-sd: Clear interrupts when cqe off/disable
Date:   Thu, 28 Jul 2022 16:00:48 +0800
Message-ID: <20220728080048.21336-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we don't clear MSDC interrupts when cqe off/disable, which led
to the data complete interrupt will be reserved for the next command.
If the next command with data transfer after cqe off/disable, we process
the CMD ready interrupt and trigger DMA start for data, but the data
complete interrupt is already exists, then SW assume that the data transfer
is complete, SW will trigger DMA stop, but the data may not be transmitted
yet or is transmitting, so we may encounter the following error:
mtk-msdc 11230000.mmc: CMD bus busy detected.

Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 4ff73d1883de..69d78604d1fc 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2446,6 +2446,9 @@ static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
 	/* disable busy check */
 	sdr_clr_bits(host->base + MSDC_PATCH_BIT1, MSDC_PB1_BUSY_CHECK_SEL);
 
+	val = readl(host->base + MSDC_INT);
+	writel(val, host->base + MSDC_INT);
+
 	if (recovery) {
 		sdr_set_field(host->base + MSDC_DMA_CTRL,
 			      MSDC_DMA_CTRL_STOP, 1);
@@ -2932,11 +2935,14 @@ static int __maybe_unused msdc_suspend(struct device *dev)
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct msdc_host *host = mmc_priv(mmc);
 	int ret;
+	u32 val;
 
 	if (mmc->caps2 & MMC_CAP2_CQE) {
 		ret = cqhci_suspend(mmc);
 		if (ret)
 			return ret;
+		val = readl(host->base + MSDC_INT);
+		writel(val, host->base + MSDC_INT);
 	}
 
 	/*
-- 
2.25.1


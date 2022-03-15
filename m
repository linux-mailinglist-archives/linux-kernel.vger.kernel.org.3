Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0BC4D92F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344601AbiCODZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344085AbiCODZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:25:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A114235862;
        Mon, 14 Mar 2022 20:24:20 -0700 (PDT)
X-UUID: 0983651cd3a0403c98de546432227d00-20220315
X-UUID: 0983651cd3a0403c98de546432227d00-20220315
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 505020276; Tue, 15 Mar 2022 11:24:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Mar 2022 11:24:15 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Mar 2022 11:24:14 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Leilk Liu <leilk.liu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH V4 1/6] spi: mediatek: support tick_delay without enhance_timing
Date:   Tue, 15 Mar 2022 11:24:06 +0800
Message-ID: <20220315032411.2826-2-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315032411.2826-1-leilk.liu@mediatek.com>
References: <20220315032411.2826-1-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch support tick_delay bit[31:30] without enhance_timing feature.

Fixes: f84d866ab43f("spi: mediatek: add tick_delay support")
Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-mt65xx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index bbfeb8046c17..3fd89548ec3c 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -43,8 +43,11 @@
 #define SPI_CFG1_PACKET_LOOP_OFFSET       8
 #define SPI_CFG1_PACKET_LENGTH_OFFSET     16
 #define SPI_CFG1_GET_TICK_DLY_OFFSET      29
+#define SPI_CFG1_GET_TICK_DLY_OFFSET_V1   30
 
 #define SPI_CFG1_GET_TICK_DLY_MASK        0xe0000000
+#define SPI_CFG1_GET_TICK_DLY_MASK_V1     0xc0000000
+
 #define SPI_CFG1_CS_IDLE_MASK             0xff
 #define SPI_CFG1_PACKET_LOOP_MASK         0xff00
 #define SPI_CFG1_PACKET_LENGTH_MASK       0x3ff0000
@@ -346,9 +349,15 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 
 	/* tick delay */
 	reg_val = readl(mdata->base + SPI_CFG1_REG);
-	reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK;
-	reg_val |= ((chip_config->tick_delay & 0x7)
-		<< SPI_CFG1_GET_TICK_DLY_OFFSET);
+	if (mdata->dev_comp->enhance_timing) {
+		reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK;
+		reg_val |= ((chip_config->tick_delay & 0x7)
+			    << SPI_CFG1_GET_TICK_DLY_OFFSET);
+	} else {
+		reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK_V1;
+		reg_val |= ((chip_config->tick_delay & 0x3)
+			    << SPI_CFG1_GET_TICK_DLY_OFFSET_V1);
+	}
 	writel(reg_val, mdata->base + SPI_CFG1_REG);
 
 	/* set hw cs timing */
-- 
2.25.1


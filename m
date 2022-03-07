Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E967F4CF239
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 07:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbiCGGxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 01:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbiCGGxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 01:53:39 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711421EC49;
        Sun,  6 Mar 2022 22:52:43 -0800 (PST)
X-UUID: ad1e5f4cd3504cdaa5f1eaa4b7304580-20220307
X-UUID: ad1e5f4cd3504cdaa5f1eaa4b7304580-20220307
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 49291644; Mon, 07 Mar 2022 14:52:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 7 Mar 2022 14:52:36 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Mar 2022 14:52:35 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH V3 3/7] spi: mediatek: add MT7986 single mode design support
Date:   Mon, 7 Mar 2022 14:52:26 +0800
Message-ID: <20220307065230.12655-4-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307065230.12655-1-leilk.liu@mediatek.com>
References: <20220307065230.12655-1-leilk.liu@mediatek.com>
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

this patch add the support of MT7986 single mode design.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 102 +++++++++++++++++++++++++++++++++------
 1 file changed, 87 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 3fd89548ec3c..aa282cace7db 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -31,6 +31,7 @@
 #define SPI_CFG2_REG                      0x0028
 #define SPI_TX_SRC_REG_64                 0x002c
 #define SPI_RX_DST_REG_64                 0x0030
+#define SPI_CFG3_IPM_REG                  0x0040
 
 #define SPI_CFG0_SCK_HIGH_OFFSET          0
 #define SPI_CFG0_SCK_LOW_OFFSET           8
@@ -51,6 +52,7 @@
 #define SPI_CFG1_CS_IDLE_MASK             0xff
 #define SPI_CFG1_PACKET_LOOP_MASK         0xff00
 #define SPI_CFG1_PACKET_LENGTH_MASK       0x3ff0000
+#define SPI_CFG1_IPM_PACKET_LENGTH_MASK   GENMASK(31, 16)
 #define SPI_CFG2_SCK_HIGH_OFFSET          0
 #define SPI_CFG2_SCK_LOW_OFFSET           16
 
@@ -71,7 +73,13 @@
 #define SPI_CMD_TX_ENDIAN            BIT(15)
 #define SPI_CMD_FINISH_IE            BIT(16)
 #define SPI_CMD_PAUSE_IE             BIT(17)
+#define SPI_CMD_IPM_NONIDLE_MODE     BIT(19)
+#define SPI_CMD_IPM_SPIM_LOOP        BIT(21)
+#define SPI_CMD_IPM_GET_TICKDLY_OFFSET    22
 
+#define SPI_CMD_IPM_GET_TICKDLY_MASK	GENMASK(24, 22)
+#define SPI_CFG3_IPM_HALF_DUPLEX_DIR		BIT(2)
+#define SPI_CFG3_IPM_HALF_DUPLEX_EN		BIT(3)
 #define MT8173_SPI_MAX_PAD_SEL 3
 
 #define MTK_SPI_PAUSE_INT_STATUS 0x2
@@ -81,6 +89,7 @@
 
 #define MTK_SPI_MAX_FIFO_SIZE 32U
 #define MTK_SPI_PACKET_SIZE 1024
+#define MTK_SPI_IPM_PACKET_SIZE SZ_64K
 #define MTK_SPI_32BITS_MASK  (0xffffffff)
 
 #define DMA_ADDR_EXT_BITS (36)
@@ -96,6 +105,9 @@ struct mtk_spi_compatible {
 	bool dma_ext;
 	/* some IC no need unprepare SPI clk */
 	bool no_need_unprepare;
+	/* IPM design improve some single mode features */
+	bool ipm_design;
+
 };
 
 struct mtk_spi {
@@ -119,6 +131,12 @@ static const struct mtk_spi_compatible mt2712_compat = {
 	.must_tx = true,
 };
 
+static const struct mtk_spi_compatible mt7986_compat_single = {
+	.enhance_timing = true,
+	.dma_ext = true,
+	.ipm_design = true,
+};
+
 static const struct mtk_spi_compatible mt6765_compat = {
 	.need_pad_sel = true,
 	.must_tx = true,
@@ -160,6 +178,9 @@ static const struct mtk_chip_config mtk_default_chip_info = {
 };
 
 static const struct of_device_id mtk_spi_of_match[] = {
+	{ .compatible = "mediatek,mt7986-spi-single",
+		.data = (void *)&mt7986_compat_single,
+	},
 	{ .compatible = "mediatek,mt2701-spi",
 		.data = (void *)&mtk_common_compat,
 	},
@@ -278,12 +299,11 @@ static int mtk_spi_set_hw_cs_timing(struct spi_device *spi)
 	return 0;
 }
 
-static int mtk_spi_prepare_message(struct spi_master *master,
-				   struct spi_message *msg)
+static int mtk_spi_hw_init(struct spi_master *master,
+			   struct spi_device *spi)
 {
 	u16 cpha, cpol;
 	u32 reg_val;
-	struct spi_device *spi = msg->spi;
 	struct mtk_chip_config *chip_config = spi->controller_data;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
@@ -291,6 +311,15 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 	cpol = spi->mode & SPI_CPOL ? 1 : 0;
 
 	reg_val = readl(mdata->base + SPI_CMD_REG);
+	if (mdata->dev_comp->ipm_design) {
+		/* SPI transfer without idle time until packet length done */
+		reg_val |= SPI_CMD_IPM_NONIDLE_MODE;
+		if (spi->mode & SPI_LOOP)
+			reg_val |= SPI_CMD_IPM_SPIM_LOOP;
+		else
+			reg_val &= ~SPI_CMD_IPM_SPIM_LOOP;
+	}
+
 	if (cpha)
 		reg_val |= SPI_CMD_CPHA;
 	else
@@ -348,23 +377,39 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 		       mdata->base + SPI_PAD_SEL_REG);
 
 	/* tick delay */
-	reg_val = readl(mdata->base + SPI_CFG1_REG);
 	if (mdata->dev_comp->enhance_timing) {
-		reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK;
-		reg_val |= ((chip_config->tick_delay & 0x7)
-			    << SPI_CFG1_GET_TICK_DLY_OFFSET);
+		if (mdata->dev_comp->ipm_design) {
+			reg_val = readl(mdata->base + SPI_CMD_REG);
+			reg_val &= ~SPI_CMD_IPM_GET_TICKDLY_MASK;
+			reg_val |= ((chip_config->tick_delay & 0x7)
+				    << SPI_CMD_IPM_GET_TICKDLY_OFFSET);
+			writel(reg_val, mdata->base + SPI_CMD_REG);
+		} else {
+			reg_val = readl(mdata->base + SPI_CFG1_REG);
+			reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK;
+			reg_val |= ((chip_config->tick_delay & 0x7)
+				    << SPI_CFG1_GET_TICK_DLY_OFFSET);
+			writel(reg_val, mdata->base + SPI_CFG1_REG);
+		}
 	} else {
+		reg_val = readl(mdata->base + SPI_CFG1_REG);
 		reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK_V1;
 		reg_val |= ((chip_config->tick_delay & 0x3)
 			    << SPI_CFG1_GET_TICK_DLY_OFFSET_V1);
+		writel(reg_val, mdata->base + SPI_CFG1_REG);
 	}
-	writel(reg_val, mdata->base + SPI_CFG1_REG);
 
 	/* set hw cs timing */
 	mtk_spi_set_hw_cs_timing(spi);
 	return 0;
 }
 
+static int mtk_spi_prepare_message(struct spi_master *master,
+				   struct spi_message *msg)
+{
+	return mtk_spi_hw_init(master, msg->spi);
+}
+
 static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	u32 reg_val;
@@ -386,13 +431,13 @@ static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 }
 
 static void mtk_spi_prepare_transfer(struct spi_master *master,
-				     struct spi_transfer *xfer)
+				     u32 speed_hz)
 {
 	u32 div, sck_time, reg_val;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
-	if (xfer->speed_hz < mdata->spi_clk_hz / 2)
-		div = DIV_ROUND_UP(mdata->spi_clk_hz, xfer->speed_hz);
+	if (speed_hz < mdata->spi_clk_hz / 2)
+		div = DIV_ROUND_UP(mdata->spi_clk_hz, speed_hz);
 	else
 		div = 1;
 
@@ -423,12 +468,24 @@ static void mtk_spi_setup_packet(struct spi_master *master)
 	u32 packet_size, packet_loop, reg_val;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
-	packet_size = min_t(u32, mdata->xfer_len, MTK_SPI_PACKET_SIZE);
+	if (mdata->dev_comp->ipm_design)
+		packet_size = min_t(u32,
+				    mdata->xfer_len,
+				    MTK_SPI_IPM_PACKET_SIZE);
+	else
+		packet_size = min_t(u32,
+				    mdata->xfer_len,
+				    MTK_SPI_PACKET_SIZE);
+
 	packet_loop = mdata->xfer_len / packet_size;
 
 	reg_val = readl(mdata->base + SPI_CFG1_REG);
-	reg_val &= ~(SPI_CFG1_PACKET_LENGTH_MASK | SPI_CFG1_PACKET_LOOP_MASK);
+	if (mdata->dev_comp->ipm_design)
+		reg_val &= ~SPI_CFG1_IPM_PACKET_LENGTH_MASK;
+	else
+		reg_val &= ~SPI_CFG1_PACKET_LENGTH_MASK;
 	reg_val |= (packet_size - 1) << SPI_CFG1_PACKET_LENGTH_OFFSET;
+	reg_val &= ~SPI_CFG1_PACKET_LOOP_MASK;
 	reg_val |= (packet_loop - 1) << SPI_CFG1_PACKET_LOOP_OFFSET;
 	writel(reg_val, mdata->base + SPI_CFG1_REG);
 }
@@ -523,7 +580,7 @@ static int mtk_spi_fifo_transfer(struct spi_master *master,
 	mdata->cur_transfer = xfer;
 	mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, xfer->len);
 	mdata->num_xfered = 0;
-	mtk_spi_prepare_transfer(master, xfer);
+	mtk_spi_prepare_transfer(master, xfer->speed_hz);
 	mtk_spi_setup_packet(master);
 
 	if (xfer->tx_buf) {
@@ -556,7 +613,7 @@ static int mtk_spi_dma_transfer(struct spi_master *master,
 	mdata->cur_transfer = xfer;
 	mdata->num_xfered = 0;
 
-	mtk_spi_prepare_transfer(master, xfer);
+	mtk_spi_prepare_transfer(master, xfer->speed_hz);
 
 	cmd = readl(mdata->base + SPI_CMD_REG);
 	if (xfer->tx_buf)
@@ -591,6 +648,19 @@ static int mtk_spi_transfer_one(struct spi_master *master,
 				struct spi_device *spi,
 				struct spi_transfer *xfer)
 {
+	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
+	u32 reg_val = 0;
+
+	/* prepare xfer direction and duplex mode */
+	if (mdata->dev_comp->ipm_design) {
+		if (!xfer->tx_buf || !xfer->rx_buf) {
+			reg_val |= SPI_CFG3_IPM_HALF_DUPLEX_EN;
+			if (xfer->rx_buf)
+				reg_val |= SPI_CFG3_IPM_HALF_DUPLEX_DIR;
+		}
+		writel(reg_val, mdata->base + SPI_CFG3_IPM_REG);
+	}
+
 	if (master->can_dma(master, spi, xfer))
 		return mtk_spi_dma_transfer(master, spi, xfer);
 	else
@@ -757,6 +827,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	if (mdata->dev_comp->must_tx)
 		master->flags = SPI_MASTER_MUST_TX;
+	if (mdata->dev_comp->ipm_design)
+		master->mode_bits |= SPI_LOOP;
 
 	if (mdata->dev_comp->need_pad_sel) {
 		mdata->pad_num = of_property_count_u32_elems(
-- 
2.25.1


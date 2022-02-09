Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B4B4AF109
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbiBIMJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiBIMGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:06:34 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C379C05CB9E;
        Wed,  9 Feb 2022 03:19:45 -0800 (PST)
X-UUID: 6178447457b4491488bbf55058306cf0-20220209
X-UUID: 6178447457b4491488bbf55058306cf0-20220209
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 9602998; Wed, 09 Feb 2022 19:19:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 9 Feb 2022 19:19:41 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Feb 2022 19:19:40 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 2/6] spi: mediatek: add IPM single mode design support
Date:   Wed, 9 Feb 2022 19:19:34 +0800
Message-ID: <20220209111938.16137-3-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209111938.16137-1-leilk.liu@mediatek.com>
References: <20220209111938.16137-1-leilk.liu@mediatek.com>
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

this patch add the support of IPM single mode design.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 103 +++++++++++++++++++++++++++++++++------
 1 file changed, 87 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index a15de10ee286..1e196fa8ac83 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -31,6 +31,7 @@
 #define SPI_CFG2_REG                      0x0028
 #define SPI_TX_SRC_REG_64                 0x002c
 #define SPI_RX_DST_REG_64                 0x0030
+#define SPI_CFG3_IPM_REG                  0x0040
 
 #define SPI_CFG0_SCK_HIGH_OFFSET          0
 #define SPI_CFG0_SCK_LOW_OFFSET           8
@@ -48,6 +49,7 @@
 #define SPI_CFG1_CS_IDLE_MASK             0xff
 #define SPI_CFG1_PACKET_LOOP_MASK         0xff00
 #define SPI_CFG1_PACKET_LENGTH_MASK       0x3ff0000
+#define SPI_CFG1_IPM_PACKET_LENGTH_MASK   GENMASK(31, 16)
 #define SPI_CFG2_SCK_HIGH_OFFSET          0
 #define SPI_CFG2_SCK_LOW_OFFSET           16
 
@@ -68,7 +70,13 @@
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
@@ -78,6 +86,7 @@
 
 #define MTK_SPI_MAX_FIFO_SIZE 32U
 #define MTK_SPI_PACKET_SIZE 1024
+#define MTK_SPI_IPM_PACKET_SIZE SZ_64K
 #define MTK_SPI_32BITS_MASK  (0xffffffff)
 
 #define DMA_ADDR_EXT_BITS (36)
@@ -93,6 +102,9 @@ struct mtk_spi_compatible {
 	bool dma_ext;
 	/* some IC no need unprepare SPI clk */
 	bool no_need_unprepare;
+	/* IPM design improve some single mode features */
+	bool ipm_design;
+
 };
 
 struct mtk_spi {
@@ -116,6 +128,12 @@ static const struct mtk_spi_compatible mt2712_compat = {
 	.must_tx = true,
 };
 
+static const struct mtk_spi_compatible ipm_compat_single = {
+	.enhance_timing = true,
+	.dma_ext = true,
+	.ipm_design = true,
+};
+
 static const struct mtk_spi_compatible mt6765_compat = {
 	.need_pad_sel = true,
 	.must_tx = true,
@@ -157,6 +175,9 @@ static const struct mtk_chip_config mtk_default_chip_info = {
 };
 
 static const struct of_device_id mtk_spi_of_match[] = {
+	{ .compatible = "mediatek,ipm-spi-single",
+		.data = (void *)&ipm_compat_single,
+	},
 	{ .compatible = "mediatek,mt2701-spi",
 		.data = (void *)&mtk_common_compat,
 	},
@@ -275,12 +296,11 @@ static int mtk_spi_set_hw_cs_timing(struct spi_device *spi)
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
 
@@ -288,6 +308,15 @@ static int mtk_spi_prepare_message(struct spi_master *master,
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
@@ -344,18 +373,33 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 		writel(mdata->pad_sel[spi->chip_select],
 		       mdata->base + SPI_PAD_SEL_REG);
 
-	/* tick delay */
-	reg_val = readl(mdata->base + SPI_CFG1_REG);
-	reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK;
-	reg_val |= ((chip_config->tick_delay & 0x7)
-		<< SPI_CFG1_GET_TICK_DLY_OFFSET);
-	writel(reg_val, mdata->base + SPI_CFG1_REG);
+	if (mdata->dev_comp->enhance_timing) {
+		if (mdata->dev_comp->ipm_design) {
+			reg_val = readl(mdata->base + SPI_CMD_REG);
+			reg_val &= ~SPI_CMD_IPM_GET_TICKDLY_MASK;
+			reg_val |= ((chip_config->tick_delay & 0x7)
+				   << SPI_CMD_IPM_GET_TICKDLY_OFFSET);
+			writel(reg_val, mdata->base + SPI_CMD_REG);
+		} else {
+			reg_val = readl(mdata->base + SPI_CFG1_REG);
+			reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK;
+			reg_val |= ((chip_config->tick_delay & 0x7)
+				<< SPI_CFG1_GET_TICK_DLY_OFFSET);
+			writel(reg_val, mdata->base + SPI_CFG1_REG);
+		}
+	}
 
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
@@ -377,13 +421,13 @@ static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
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
 
@@ -414,12 +458,24 @@ static void mtk_spi_setup_packet(struct spi_master *master)
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
@@ -514,7 +570,7 @@ static int mtk_spi_fifo_transfer(struct spi_master *master,
 	mdata->cur_transfer = xfer;
 	mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, xfer->len);
 	mdata->num_xfered = 0;
-	mtk_spi_prepare_transfer(master, xfer);
+	mtk_spi_prepare_transfer(master, xfer->speed_hz);
 	mtk_spi_setup_packet(master);
 
 	if (xfer->tx_buf) {
@@ -547,7 +603,7 @@ static int mtk_spi_dma_transfer(struct spi_master *master,
 	mdata->cur_transfer = xfer;
 	mdata->num_xfered = 0;
 
-	mtk_spi_prepare_transfer(master, xfer);
+	mtk_spi_prepare_transfer(master, xfer->speed_hz);
 
 	cmd = readl(mdata->base + SPI_CMD_REG);
 	if (xfer->tx_buf)
@@ -582,6 +638,19 @@ static int mtk_spi_transfer_one(struct spi_master *master,
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
@@ -746,6 +815,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	if (mdata->dev_comp->must_tx)
 		master->flags = SPI_MASTER_MUST_TX;
+	if (mdata->dev_comp->ipm_design)
+		master->mode_bits |= SPI_LOOP;
 
 	if (mdata->dev_comp->need_pad_sel) {
 		mdata->pad_num = of_property_count_u32_elems(
-- 
2.25.1


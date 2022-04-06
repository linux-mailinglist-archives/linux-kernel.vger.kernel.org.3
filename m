Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DE04F60F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbiDFOL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiDFOLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:11:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7436210DA6B;
        Wed,  6 Apr 2022 03:05:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D4C671F43913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649239458;
        bh=HsnypJDObY+gS8EShVy4Rcq2TEJ4ccVeiDXFBBCM2qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itzf/Py+3LlJBLGZWuLt3X1VLEua3FbCQFwhOdQZZ7MQv5ktJekedJdd4stOr5Pg/
         Wh6j8NGD9m/1Cikso0U4tVd1seUA/wOX8C/RsM5LaTRpDE6PgWTDA9dnRa73GkQ9Uh
         JH6RPbGkDd886G3eGX4HwBMoe6Pp3jZ0fPChoesJS7pRZRO08+rX7La0hHH5sP1a8B
         4F5/ilG+GmcwZSvNBf8hdUwS9wb4eY4ZkCPkASp7GPXHyzHW85VsMTPIuBp+kg3gZk
         giMdMCOaT8fDYJ1F0xsqU+8quI7hNdRr55hVcOt5HOBAfxm5mBc51Q8yBDbzI0oM7a
         OJDCs/0uQD0Xw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 6/7] spi: mt65xx: Add kerneldoc for driver structures
Date:   Wed,  6 Apr 2022 12:04:08 +0200
Message-Id: <20220406100409.93113-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406100409.93113-1-angelogioacchino.delregno@collabora.com>
References: <20220406100409.93113-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the two structures was already partially documented, but not
in kerneldoc format: enhance readability by adding the missing
documentation bits and use kerneldoc.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-mt65xx.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index c5b8aecfada6..8bd0b7335ea0 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -95,21 +95,43 @@
 #define DMA_ADDR_EXT_BITS (36)
 #define DMA_ADDR_DEF_BITS (32)
 
+/**
+ * struct mtk_spi_compatible - device data structure
+ * @need_pad_sel:	Enable pad (pins) selection in SPI controller
+ * @must_tx:		Must explicitly send dummy TX bytes to do RX only transfer
+ * @enhance_timing:	Enable adjusting cfg register to enhance time accuracy
+ * @dma_ext:		DMA address extension supported
+ * @no_need_unprepare:	Don't unprepare the SPI clk during runtime
+ * @ipm_design:		Adjust/extend registers to support IPM design IP features
+ */
 struct mtk_spi_compatible {
 	bool need_pad_sel;
-	/* Must explicitly send dummy Tx bytes to do Rx only transfer */
 	bool must_tx;
-	/* some IC design adjust cfg register to enhance time accuracy */
 	bool enhance_timing;
-	/* some IC support DMA addr extension */
 	bool dma_ext;
-	/* some IC no need unprepare SPI clk */
 	bool no_need_unprepare;
-	/* IPM design adjust and extend register to support more features */
 	bool ipm_design;
-
 };
 
+/**
+ * struct mtk_spi - SPI driver instance
+ * @base:		Start address of the SPI controller registers
+ * @state:		SPI controller state
+ * @pad_num:		Number of pad_sel entries
+ * @pad_sel:		Groups of pins to select
+ * @parent_clk:		Parent of sel_clk
+ * @sel_clk:		SPI master SCK clock
+ * @spi_clk:		Peripheral clock
+ * @cur_transfer:	Currently processed SPI transfer
+ * @xfer_len:		Number of bytes to transfer
+ * @num_xfered:		Number of transferred bytes
+ * @tx_sgl:		TX transfer scatterlist
+ * @rx_sgl:		RX transfer scatterlist
+ * @tx_sgl_len:		Size of TX DMA transfer
+ * @rx_sgl_len:		Size of RX DMA transfer
+ * @dev_comp:		Device data structure
+ * @spi_clk_hz:		Current SPI clock in Hz
+ */
 struct mtk_spi {
 	void __iomem *base;
 	u32 state;
-- 
2.35.1


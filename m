Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A7C4F7E47
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244940AbiDGLrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244886AbiDGLqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:46:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601F819322B;
        Thu,  7 Apr 2022 04:44:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AF59B1F46140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649331886;
        bh=KzX41HFWfAh1talT4BfusFnQWFMhkwcxlsLw5YSyMG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CRc5dbnNiguSDY5h1vjxJzdNAE5U4Eo6u/h2gpMnYoXDmKdru6nU5RVhAxN/UNzQ+
         IdlWPQSH50PRasWIa4QJGw7rn2LX+Y9xEKkVU4+FW+L4bebyZ4sSkG+Ddcl+WZGTG7
         hpdv/1+zThsBFQ07foyBQiUzMcwNqXWRPYI3W7OHHk4rvXHJn/62TPBUt6xQy5n0m0
         ksTAodyGDEFbhrXgRM7wOeXQEb4Wikn2K9C+wA2ZWD0NkisoYabMryLqm0fRcAZ2kF
         MKlRts8I7U9xzZElxYJxKYZsQsZJzuLw7oaSzqJBD399GKRkgQg9gUiVZ7Gc4hBRNt
         7NSxrFiyyJeCw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 7/8] spi: mt65xx: Add kerneldoc for driver structures
Date:   Thu,  7 Apr 2022 13:44:27 +0200
Message-Id: <20220407114428.167091-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407114428.167091-1-angelogioacchino.delregno@collabora.com>
References: <20220407114428.167091-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
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
 drivers/spi/spi-mt65xx.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 111ce351359a..b1472556c5b0 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -110,20 +110,49 @@
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
 };
 
+/**
+ * struct mtk_spi - SPI driver instance
+ * @base:		Start address of the SPI controller registers
+ * @state:		SPI controller state
+ * @pad_num:		Number of pad_sel entries
+ * @pad_sel:		Groups of pins to select
+ * @parent_clk:		Parent of sel_clk
+ * @sel_clk:		SPI master mux clock
+ * @spi_clk:		Peripheral clock
+ * @spi_hclk:		AHB bus clock
+ * @cur_transfer:	Currently processed SPI transfer
+ * @xfer_len:		Number of bytes to transfer
+ * @num_xfered:		Number of transferred bytes
+ * @tx_sgl:		TX transfer scatterlist
+ * @rx_sgl:		RX transfer scatterlist
+ * @tx_sgl_len:		Size of TX DMA transfer
+ * @rx_sgl_len:		Size of RX DMA transfer
+ * @dev_comp:		Device data structure
+ * @spi_clk_hz:		Current SPI clock in Hz
+ * @spimem_done:	SPI-MEM operation completion
+ * @use_spimem:		Enables SPI-MEM
+ * @dev:		Device pointer
+ * @tx_dma:		DMA start for SPI-MEM TX
+ * @rx_dma:		DMA start for SPI-MEM RX
+ */
 struct mtk_spi {
 	void __iomem *base;
 	u32 state;
-- 
2.35.1


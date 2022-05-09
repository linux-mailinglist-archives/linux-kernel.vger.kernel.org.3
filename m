Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E7D5203F7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbiEISBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239921AbiEISBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:01:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEC01A15DF;
        Mon,  9 May 2022 10:57:02 -0700 (PDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4Kxpld4J6jz4ySZ;
        Tue, 10 May 2022 03:57:01 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KxplX1mjLz4xVP;
        Tue, 10 May 2022 03:56:55 +1000 (AEST)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Tao Ren <rentao.bupt@gmail.com>,
        Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Subject: [PATCH v7 05/11] spi: aspeed: Adjust direct mapping to device size
Date:   Mon,  9 May 2022 19:56:10 +0200
Message-Id: <20220509175616.1089346-6-clg@kaod.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220509175616.1089346-1-clg@kaod.org>
References: <20220509175616.1089346-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The segment registers of the FMC/SPI controllers provide a way to
configure the mapping window of the flash device contents on the AHB
bus. Adjust this window to the size of the spi-mem mapping.

Things get more complex with multiple devices. The driver needs to
also adjust the window of the next device to make sure that there is
no overlap, even if there is no available device. The proposal below
is not perfect but it is covering all the cases we have seen on
different boards with one and two devices on the same bus.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Tao Ren <rentao.bupt@gmail.com>
Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 88 ++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 50cc7bd7ba3e..0aff42e20b8d 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -411,6 +411,92 @@ static int aspeed_spi_chip_set_default_window(struct aspeed_spi_chip *chip)
 	return chip->ahb_window_size ? 0 : -1;
 }
 
+static int aspeed_spi_set_window(struct aspeed_spi *aspi,
+				 const struct aspeed_spi_window *win)
+{
+	u32 start = aspi->ahb_base_phy + win->offset;
+	u32 end = start + win->size;
+	void __iomem *seg_reg = aspi->regs + CE0_SEGMENT_ADDR_REG + win->cs * 4;
+	u32 seg_val_backup = readl(seg_reg);
+	u32 seg_val = aspi->data->segment_reg(aspi, start, end);
+
+	if (seg_val == seg_val_backup)
+		return 0;
+
+	writel(seg_val, seg_reg);
+
+	/*
+	 * Restore initial value if something goes wrong else we could
+	 * loose access to the chip.
+	 */
+	if (seg_val != readl(seg_reg)) {
+		dev_err(aspi->dev, "CE%d invalid window [ 0x%.8x - 0x%.8x ] %dMB",
+			win->cs, start, end - 1, win->size >> 20);
+		writel(seg_val_backup, seg_reg);
+		return -EIO;
+	}
+
+	if (win->size)
+		dev_dbg(aspi->dev, "CE%d new window [ 0x%.8x - 0x%.8x ] %dMB",
+			win->cs, start, end - 1,  win->size >> 20);
+	else
+		dev_dbg(aspi->dev, "CE%d window closed", win->cs);
+
+	return 0;
+}
+
+/*
+ * Yet to be done when possible :
+ * - Align mappings on flash size (we don't have the info)
+ * - ioremap each window, not strictly necessary since the overall window
+ *   is correct.
+ */
+static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
+					 u32 local_offset, u32 size)
+{
+	struct aspeed_spi *aspi = chip->aspi;
+	struct aspeed_spi_window windows[ASPEED_SPI_MAX_NUM_CS] = { 0 };
+	struct aspeed_spi_window *win = &windows[chip->cs];
+	int ret;
+
+	aspeed_spi_get_windows(aspi, windows);
+
+	/* Adjust this chip window */
+	win->offset += local_offset;
+	win->size = size;
+
+	if (win->offset + win->size > aspi->ahb_window_size) {
+		win->size = aspi->ahb_window_size - win->offset;
+		dev_warn(aspi->dev, "CE%d window resized to %dMB", chip->cs, win->size >> 20);
+	}
+
+	ret = aspeed_spi_set_window(aspi, win);
+	if (ret)
+		return ret;
+
+	/* Update chip mapping info */
+	chip->ahb_base = aspi->ahb_base + win->offset;
+	chip->ahb_window_size = win->size;
+
+	/*
+	 * Also adjust next chip window to make sure that it does not
+	 * overlap with the current window.
+	 */
+	if (chip->cs < aspi->data->max_cs - 1) {
+		struct aspeed_spi_window *next = &windows[chip->cs + 1];
+
+		/* Change offset and size to keep the same end address */
+		if ((next->offset + next->size) > (win->offset + win->size))
+			next->size = (next->offset + next->size) - (win->offset + win->size);
+		else
+			next->size = 0;
+		next->offset = win->offset + win->size;
+
+		aspeed_spi_set_window(aspi, next);
+	}
+	return 0;
+}
+
 static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 {
 	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
@@ -425,6 +511,8 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (op->data.dir != SPI_MEM_DATA_IN)
 		return -EOPNOTSUPP;
 
+	aspeed_spi_chip_adjust_window(chip, desc->info.offset, desc->info.length);
+
 	if (desc->info.length > chip->ahb_window_size)
 		dev_warn(aspi->dev, "CE%d window (%dMB) too small for mapping",
 			 chip->cs, chip->ahb_window_size >> 20);
-- 
2.35.1


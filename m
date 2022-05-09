Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4D25203EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbiEISA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239899AbiEISAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:00:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A4F19CB5B;
        Mon,  9 May 2022 10:56:57 -0700 (PDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4KxplW564Hz4ySX;
        Tue, 10 May 2022 03:56:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KxplQ2qFdz4xVP;
        Tue, 10 May 2022 03:56:50 +1000 (AEST)
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
Subject: [PATCH v7 04/11] spi: aspeed: Add support for direct mapping
Date:   Mon,  9 May 2022 19:56:09 +0200
Message-Id: <20220509175616.1089346-5-clg@kaod.org>
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

Use direct mapping to read the flash device contents. This operation
mode is called "Command mode" on Aspeed SoC SMC controllers. It uses a
Control Register for the settings to apply when a memory operation is
performed on the flash device mapping window.

If the window is not big enough, fall back to the "User mode" to
perform the read.

Direct mapping for writes will come later when validated.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Tao Ren <rentao.bupt@gmail.com>
Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 68 ++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index cb5a0652e5a4..50cc7bd7ba3e 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -411,10 +411,78 @@ static int aspeed_spi_chip_set_default_window(struct aspeed_spi_chip *chip)
 	return chip->ahb_window_size ? 0 : -1;
 }
 
+static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
+	struct aspeed_spi_chip *chip = &aspi->chips[desc->mem->spi->chip_select];
+	struct spi_mem_op *op = &desc->info.op_tmpl;
+	u32 ctl_val;
+	int ret = 0;
+
+	chip->clk_freq = desc->mem->spi->max_speed_hz;
+
+	/* Only for reads */
+	if (op->data.dir != SPI_MEM_DATA_IN)
+		return -EOPNOTSUPP;
+
+	if (desc->info.length > chip->ahb_window_size)
+		dev_warn(aspi->dev, "CE%d window (%dMB) too small for mapping",
+			 chip->cs, chip->ahb_window_size >> 20);
+
+	/* Define the default IO read settings */
+	ctl_val = readl(chip->ctl) & ~CTRL_IO_CMD_MASK;
+	ctl_val |= aspeed_spi_get_io_mode(op) |
+		op->cmd.opcode << CTRL_COMMAND_SHIFT |
+		CTRL_IO_DUMMY_SET(op->dummy.nbytes / op->dummy.buswidth) |
+		CTRL_IO_MODE_READ;
+
+	/* Tune 4BYTE address mode */
+	if (op->addr.nbytes) {
+		u32 addr_mode = readl(aspi->regs + CE_CTRL_REG);
+
+		if (op->addr.nbytes == 4)
+			addr_mode |= (0x11 << chip->cs);
+		else
+			addr_mode &= ~(0x11 << chip->cs);
+		writel(addr_mode, aspi->regs + CE_CTRL_REG);
+	}
+
+	/* READ mode is the controller default setting */
+	chip->ctl_val[ASPEED_SPI_READ] = ctl_val;
+	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
+
+	dev_info(aspi->dev, "CE%d read buswidth:%d [0x%08x]\n",
+		 chip->cs, op->data.buswidth, chip->ctl_val[ASPEED_SPI_READ]);
+
+	return ret;
+}
+
+static ssize_t aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
+				      u64 offset, size_t len, void *buf)
+{
+	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
+	struct aspeed_spi_chip *chip = &aspi->chips[desc->mem->spi->chip_select];
+
+	/* Switch to USER command mode if mapping window is too small */
+	if (chip->ahb_window_size < offset + len) {
+		int ret;
+
+		ret = aspeed_spi_read_user(chip, &desc->info.op_tmpl, offset, len, buf);
+		if (ret < 0)
+			return ret;
+	} else {
+		memcpy_fromio(buf, chip->ahb_base + offset, len);
+	}
+
+	return len;
+}
+
 static const struct spi_controller_mem_ops aspeed_spi_mem_ops = {
 	.supports_op = aspeed_spi_supports_op,
 	.exec_op = aspeed_spi_exec_op,
 	.get_name = aspeed_spi_get_name,
+	.dirmap_create = aspeed_spi_dirmap_create,
+	.dirmap_read = aspeed_spi_dirmap_read,
 };
 
 static void aspeed_spi_chip_set_type(struct aspeed_spi *aspi, unsigned int cs, int type)
-- 
2.35.1


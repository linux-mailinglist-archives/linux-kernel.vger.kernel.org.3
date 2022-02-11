Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10B74B1D32
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 04:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbiBKDxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 22:53:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbiBKDxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 22:53:33 -0500
Received: from mail-m17664.qiye.163.com (mail-m17664.qiye.163.com [59.111.176.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E8855BE;
        Thu, 10 Feb 2022 19:53:31 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m17664.qiye.163.com (Hmail) with ESMTPA id 7CFE1140127;
        Fri, 11 Feb 2022 11:43:47 +0800 (CST)
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH 2/6] spi: rockchip: Preset cs-high and clk polarity in setup progress
Date:   Fri, 11 Feb 2022 11:43:38 +0800
Message-Id: <20220211034344.4130-2-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211034344.4130-1-jon.lin@rock-chips.com>
References: <20220211034344.4130-1-jon.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRlLHUJWTR4YSEhCHkJDHk
        9MVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTo6ASo5Tj5JEh40CA8PF08w
        CRowFDpVSlVKTU9PTk5KS0lMQ0NNVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
        QVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ09NNwY+
X-HM-Tid: 0a7ee6e13bd2da2fkuws7cfe1140127
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After power up, the cs and clock is in default status, and the cs-high
and clock polarity dts property configuration will take no effect until
the calling of rockchip_spi_config in the first transmission.
So preset them to make sure a correct voltage before the first
transmission coming.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 7ac07569e103..1738a2611a2b 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -711,6 +711,26 @@ static bool rockchip_spi_can_dma(struct spi_controller *ctlr,
 	return xfer->len / bytes_per_word >= rs->fifo_len;
 }
 
+static int rockchip_spi_setup(struct spi_device *spi)
+{
+	struct rockchip_spi *rs = spi_controller_get_devdata(spi->controller);
+	u32 cr0;
+
+	pm_runtime_get_sync(rs->dev);
+
+	cr0 = readl_relaxed(rs->regs + ROCKCHIP_SPI_CTRLR0);
+
+	cr0 |= ((spi->mode & 0x3) << CR0_SCPH_OFFSET);
+	if (spi->mode & SPI_CS_HIGH)
+		cr0 |= BIT(spi->chip_select) << CR0_SOI_OFFSET;
+
+	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);
+
+	pm_runtime_put(rs->dev);
+
+	return 0;
+}
+
 static int rockchip_spi_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -837,6 +857,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	ctlr->min_speed_hz = rs->freq / BAUDR_SCKDV_MAX;
 	ctlr->max_speed_hz = min(rs->freq / BAUDR_SCKDV_MIN, MAX_SCLK_OUT);
 
+	ctlr->setup = rockchip_spi_setup;
 	ctlr->set_cs = rockchip_spi_set_cs;
 	ctlr->transfer_one = rockchip_spi_transfer_one;
 	ctlr->max_transfer_size = rockchip_spi_max_transfer_size;
-- 
2.17.1


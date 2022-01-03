Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8094482EAC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 08:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiACHLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 02:11:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54370 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiACHLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 02:11:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75D2DB80AD6;
        Mon,  3 Jan 2022 07:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B681C36AF1;
        Mon,  3 Jan 2022 07:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641193893;
        bh=GzcRUDfPJW9SzmAleWae6nsRoc+qGYZor16guuT0ELo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t0u5DOP2JrkhAkE1nxdu5sKX0gQEYcOUyM78qxEa4Bo1PaHZd+DiDtiZNFoD1dD0O
         GrFzHEfqIDcQXx8bQF3EpVH7I9o1orMNQ4SYDvwWOx0d8UGoCo7C4DF/riQ933K1hw
         69G2ZBWjekZBmGOPbu2fNDdGjnbF6TEbfKe1hNQBCoWXhSvGy1AFv6IefZzEaQY+qt
         wsQJJOxSxN638kOtwjYFouo9k0hxXrRYd2JcnrpybPrDFmb/06VJ+R4hTHrc0KVok7
         mzghpMsrY+l4fq23WwZSxhp4YH7lsayibYR8nmMC7GmNY5zGC4Bqn+vPgKxN0tErwd
         qfRQbd9Tik/hQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] spi: qcom: geni: handle timeout for gpi mode
Date:   Mon,  3 Jan 2022 12:41:18 +0530
Message-Id: <20220103071118.27220-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220103071118.27220-1-vkoul@kernel.org>
References: <20220103071118.27220-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We missed adding handle_err for gpi mode, so add a new function
spi_geni_handle_err() which would call handle_fifo_timeout() or newly
added handle_gpi_timeout() based on mode

Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
Reported-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
changes in v2:
 - add tags from Doug

 drivers/spi/spi-geni-qcom.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index b82f3ddff0f4..f7d905d2a90f 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -164,6 +164,30 @@ static void handle_fifo_timeout(struct spi_master *spi,
 	}
 }
 
+static void handle_gpi_timeout(struct spi_master *spi, struct spi_message *msg)
+{
+	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+
+	dmaengine_terminate_sync(mas->tx);
+	dmaengine_terminate_sync(mas->rx);
+}
+
+static void spi_geni_handle_err(struct spi_master *spi, struct spi_message *msg)
+{
+	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+
+	switch (mas->cur_xfer_mode) {
+	case GENI_SE_FIFO:
+		handle_fifo_timeout(spi, msg);
+		break;
+	case GENI_GPI_DMA:
+		handle_gpi_timeout(spi, msg);
+		break;
+	default:
+		dev_err(mas->dev, "Abort on Mode:%d not supported", mas->cur_xfer_mode);
+	}
+}
+
 static bool spi_geni_is_abort_still_pending(struct spi_geni_master *mas)
 {
 	struct geni_se *se = &mas->se;
@@ -922,7 +946,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	spi->can_dma = geni_can_dma;
 	spi->dma_map_dev = dev->parent;
 	spi->auto_runtime_pm = true;
-	spi->handle_err = handle_fifo_timeout;
+	spi->handle_err = spi_geni_handle_err;
 	spi->use_gpio_descriptors = true;
 
 	init_completion(&mas->cs_done);
-- 
2.31.1


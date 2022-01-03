Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BAD482EA9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 08:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiACHLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 02:11:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54340 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiACHLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 02:11:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 691F1B80DB9;
        Mon,  3 Jan 2022 07:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710A5C36AEE;
        Mon,  3 Jan 2022 07:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641193890;
        bh=n6UKfjDTeuJX+4v4MoQgf67EJXqNInpbReC0k/n5QLY=;
        h=From:To:Cc:Subject:Date:From;
        b=Za3aussdGledJrUCxdXhrj28blnBYS1EMT6svIlkBFhnB9FSnfkoBV+xjy9egqmUj
         eKEnw7Sid42XR5BqqMVn4Z0RgVllmqZKnNMuXB8oY2xY+doG1H2HW5h/K76v3+w9lC
         EUFFsoanp99mmqnSO0xMcri8+Zii78OhiXdiVkQ7iN5kAzCEqcMmIwmHurdNvbe+7H
         BqG/VZBXqknNIm0aGpQ2rgOq3ylxTzc1yo+xMQhRsT/KC0DAc/2qaJbDuxuq92nQCs
         SDE5ylzPbGqQG/VUg2Z2LkUGOiDSniZnplX9/bXU/sCTMuYosLPX1rk/CDwk16afxE
         joJOl+nIn4D1Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] spi: qcom: geni: set the error code for gpi transfer
Date:   Mon,  3 Jan 2022 12:41:17 +0530
Message-Id: <20220103071118.27220-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before we invoke spi_finalize_current_transfer() in
spi_gsi_callback_result() we should set the spi->cur_msg->status as
appropriate (0 for success, error otherwise).

The helps to return error on transfer and not wait till it timesout on
error

Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---

Changes in v2:
 - add missing spi_finalize_current_transfer() for dma error case

 drivers/spi/spi-geni-qcom.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 413fa1a7a936..b82f3ddff0f4 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -346,17 +346,21 @@ spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
 {
 	struct spi_master *spi = cb;
 
+	spi->cur_msg->status = -EIO;
 	if (result->result != DMA_TRANS_NOERROR) {
 		dev_err(&spi->dev, "DMA txn failed: %d\n", result->result);
+		spi_finalize_current_transfer(spi);
 		return;
 	}
 
 	if (!result->residue) {
+		spi->cur_msg->status = 0;
 		dev_dbg(&spi->dev, "DMA txn completed\n");
-		spi_finalize_current_transfer(spi);
 	} else {
 		dev_err(&spi->dev, "DMA xfer has pending: %d\n", result->residue);
 	}
+
+	spi_finalize_current_transfer(spi);
 }
 
 static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas,
-- 
2.31.1


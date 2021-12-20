Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14C647B380
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbhLTTJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:09:11 -0500
Received: from aposti.net ([89.234.176.197]:34378 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240733AbhLTTJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:09:07 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     list@opendingux.net, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] mmc: jz4740: Support using a bi-directional DMA channel
Date:   Mon, 20 Dec 2021 19:08:40 +0000
Message-Id: <20211220190840.108061-3-paul@crapouillou.net>
In-Reply-To: <20211220190840.108061-1-paul@crapouillou.net>
References: <20211220190840.108061-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the MMC/SD controller in Ingenic SoCs work in half-duplex, it is
possible to use one single DMA channel for both TX and RX operations,
instead of using separate channels.

As some older Ingenic SoCs offer only a handful of DMA channels,
supporting bi-directional channels allow more hardware to use the
channels that would otherwise be used for the MMC/SD operation.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mmc/host/jz4740_mmc.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 80a2c270d502..a0b94f61ddcf 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -217,11 +217,23 @@ static void jz4740_mmc_release_dma_channels(struct jz4740_mmc_host *host)
 		return;
 
 	dma_release_channel(host->dma_tx);
-	dma_release_channel(host->dma_rx);
+	if (host->dma_rx)
+		dma_release_channel(host->dma_rx);
 }
 
 static int jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host *host)
 {
+	struct device *dev = mmc_dev(host->mmc);
+
+	host->dma_tx = dma_request_chan(dev, "tx-rx");
+	if (!IS_ERR(host->dma_tx))
+		return 0;
+
+	if (PTR_ERR(host->dma_tx) != -ENODEV) {
+		dev_err(dev, "Failed to get dma tx-rx channel\n");
+		return PTR_ERR(host->dma_tx);
+	}
+
 	host->dma_tx = dma_request_chan(mmc_dev(host->mmc), "tx");
 	if (IS_ERR(host->dma_tx)) {
 		dev_err(mmc_dev(host->mmc), "Failed to get dma_tx channel\n");
@@ -241,7 +253,10 @@ static int jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host *host)
 static inline struct dma_chan *jz4740_mmc_get_dma_chan(struct jz4740_mmc_host *host,
 						       struct mmc_data *data)
 {
-	return (data->flags & MMC_DATA_READ) ? host->dma_rx : host->dma_tx;
+	if ((data->flags & MMC_DATA_READ) && host->dma_rx)
+		return host->dma_rx;
+	else
+		return host->dma_tx;
 }
 
 static void jz4740_mmc_dma_unmap(struct jz4740_mmc_host *host,
-- 
2.34.1


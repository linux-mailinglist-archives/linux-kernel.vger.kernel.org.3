Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B2355A347
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiFXVHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiFXVG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:06:59 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4A2185797;
        Fri, 24 Jun 2022 14:06:44 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id D969116CC;
        Sat, 25 Jun 2022 00:07:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com D969116CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656104880;
        bh=AQ9cVhH28ibWIJ71leU3acpoUyEPQOPDWXZEPyFlp7k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZOTFESwnyYYXTTlxnltvttHCrpDkZ+gM62/MylYrnld75ppQszb+xmFKTKBxhp051
         BJiv2FZltkXIHmW3pdEVagToIFs9gaJZ2VeLV5hbIdpz573kVX2NfhkadnFkOe8O3A
         x5NRG+2w3wjHaNQyHyXrbOaapqK/Gi2mCN02oIE4=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 25 Jun 2022 00:06:37 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v2] spi: dw: Add deferred DMA-channels setup support
Date:   Sat, 25 Jun 2022 00:06:23 +0300
Message-ID: <20220624210623.6383-1-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610075006.10025-1-Sergey.Semin@baikalelectronics.ru>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if the source DMA device isn't ready to provide the channels
capable of the SPI DMA transfers, the DW SSI controller will be registered
with no DMA support. It isn't right since all what the driver needs to do
is to postpone the probe procedure until the DMA device is ready. Let's
fix that in the framework of the DWC SSI generic DMA implementation. First
we need to use the dma_request_chan() method instead of the
dma_request_slave_channel() function, because the later one is deprecated
and most importantly doesn't return the failure cause but the
NULL-pointer. Second we need to stop the DW SSI controller probe procedure
if the -EPROBE_DEFER error is returned on the DMA initialization. The
procedure will resume later when the channels are ready to be requested.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---

Link: https://lore.kernel.org/linux-spi/20220610075006.10025-1-Sergey.Semin@baikalelectronics.ru/
Changelog v2:
- Just resend.
- Rebase onto the kernel v5.19-rcX.
---
 drivers/spi/spi-dw-core.c |  5 ++++-
 drivers/spi/spi-dw-dma.c  | 25 ++++++++++++++++++-------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index ecea471ff42c..911ea9bddbee 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -942,7 +942,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 
 	if (dws->dma_ops && dws->dma_ops->dma_init) {
 		ret = dws->dma_ops->dma_init(dev, dws);
-		if (ret) {
+		if (ret == -EPROBE_DEFER) {
+			goto err_free_irq;
+		} else if (ret) {
 			dev_warn(dev, "DMA init failed\n");
 		} else {
 			master->can_dma = dws->dma_ops->can_dma;
@@ -963,6 +965,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	if (dws->dma_ops && dws->dma_ops->dma_exit)
 		dws->dma_ops->dma_exit(dws);
 	dw_spi_enable_chip(dws, 0);
+err_free_irq:
 	free_irq(dws->irq, master);
 err_free_master:
 	spi_controller_put(master);
diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 63e5260100ec..1322b8cce5b7 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -139,15 +139,20 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 
 static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 {
-	dws->rxchan = dma_request_slave_channel(dev, "rx");
-	if (!dws->rxchan)
-		return -ENODEV;
+	int ret;
 
-	dws->txchan = dma_request_slave_channel(dev, "tx");
-	if (!dws->txchan) {
-		dma_release_channel(dws->rxchan);
+	dws->rxchan = dma_request_chan(dev, "rx");
+	if (IS_ERR(dws->rxchan)) {
+		ret = PTR_ERR(dws->rxchan);
 		dws->rxchan = NULL;
-		return -ENODEV;
+		goto err_exit;
+	}
+
+	dws->txchan = dma_request_chan(dev, "tx");
+	if (IS_ERR(dws->txchan)) {
+		ret = PTR_ERR(dws->txchan);
+		dws->txchan = NULL;
+		goto free_rxchan;
 	}
 
 	dws->master->dma_rx = dws->rxchan;
@@ -160,6 +165,12 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 	dw_spi_dma_sg_burst_init(dws);
 
 	return 0;
+
+free_rxchan:
+	dma_release_channel(dws->rxchan);
+	dws->rxchan = NULL;
+err_exit:
+	return ret;
 }
 
 static void dw_spi_dma_exit(struct dw_spi *dws)
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E644B3F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbiBNCUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:20:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbiBNCUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:20:06 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C42654FBD;
        Sun, 13 Feb 2022 18:19:55 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id l9so7803127plg.0;
        Sun, 13 Feb 2022 18:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=O7xdWjtC5pvhIAMDw2lRToWj72uk+7vBIgxpmimiVik=;
        b=MgXvCnMuOr9cdvHZxSDwLA6hyyvEjAKPMqKr0oUtvKLeAKoGK4if7kUgptnsTgV0+Q
         3NBzO/QLxWdSdBaQTb24kEnwkYXAvo/4XQ1zE2Q8K6LDbuFh5hh7uCYxJogW4dbvifMr
         Sn3iVCIWA2rgf7Krq11cNwaa5IkbdwUmTf7C0guHR7HZc828bu8qJLc+4lmUUoPC0mGj
         IQ6OnV1jgs2P/jSrhTtaP6AA88a8mGfj/Pqnm/Ec88BchewCs6ZuxnP4vUyaYZ5I4Tjg
         w0VK9JUOK7pGTeBB9GloFpvcZHDYFR4nL7XumhoH+ji3lfErJ6FTQQy3axOVaOfXK4J0
         AKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O7xdWjtC5pvhIAMDw2lRToWj72uk+7vBIgxpmimiVik=;
        b=UwljD+mApLUcIs51D33bcwDYvffQxZYhmEmlNz8hmKttfKoF/vW0JE7sMZ0BazNr7u
         7oa7Y6ACsm0bge5xyqljCIuBNruurcFFFr5GF3c69V3rP6qQU27AMSBJBKHO9EQCjbaz
         kyf+apgPEYWJKVjdF8RCx5M/Cu1Bt4bWqGKDqwxeMkKsVxWRGIjrrcmHEoEv6KYU2oU8
         GmoHAED9IT3osxVOixR54Xab4efVwpNo2mQZATCkSi7Z56DYpJf47ibr5swvx3qcDi+M
         UMd6lUnaTL4NyTw9KHzXr4HEquHUQbR4HZJXGp7HxNCBG/IpKKvab/IGk4V+deavpnMT
         Y/dQ==
X-Gm-Message-State: AOAM530Pi7gzngA6a5Ldh2TI9y3VAkegyVI9+PI2whJvdnchS+Dr6p9E
        ZWymTKDBTBAjTVrRKVRUA6g=
X-Google-Smtp-Source: ABdhPJzQBUQT623YjokWZo6xZ8RPbXSsrp1IJ0m7b0Q+JemesaXXnrucqd+vr1KKdTX8Cxo5UsWqsw==
X-Received: by 2002:a17:90a:5206:: with SMTP id v6mr12107296pjh.220.1644805194970;
        Sun, 13 Feb 2022 18:19:54 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id n5sm9008308pjf.0.2022.02.13.18.19.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Feb 2022 18:19:54 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com, nathan@kernel.org,
        trix@redhat.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH] spi: Fix warning for Clang build and simplify code
Date:   Mon, 14 Feb 2022 10:20:11 +0800
Message-Id: <7d91e6ce29f9a8df2c53a47b4b977664020e237a.1644805060.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang build fails with
spi-sunplus-sp7021.c:405:2: error: variable 'ret' is used
  uninitialized whenever switch default is taken
        default:

simplify code

Restore initializing ret. and add return error at default

Fixes: 47e8fe57a66f ("spi: Modify irq request position and modify parameters")
Reported-by: Tom Rix <trix@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
 drivers/spi/spi-sunplus-sp7021.c | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index ba5ed9f..ade7a0f 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -69,12 +69,6 @@
 #define SP7021_SPI_DATA_SIZE		(255)
 #define SP7021_FIFO_DATA_LEN		(16)
 
-enum SP_SPI_MODE {
-	SP7021_SLAVE_READ = 0,
-	SP7021_SLAVE_WRITE = 1,
-	SP7021_SPI_IDLE = 2,
-};
-
 enum {
 	SP7021_MASTER_MODE = 0,
 	SP7021_SLAVE_MODE = 1,
@@ -375,40 +369,26 @@ static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi
 {
 	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
 	struct device *dev = pspim->dev;
-	int mode, ret;
+	int ret;
 
-	mode = SP7021_SPI_IDLE;
-	if (xfer->tx_buf && xfer->rx_buf) {
-		dev_dbg(&ctlr->dev, "%s() wrong command\n", __func__);
-		return -EINVAL;
-	} else if (xfer->tx_buf) {
+	if (xfer->tx_buf && !xfer->rx_buf) {
 		xfer->tx_dma = dma_map_single(dev, (void *)xfer->tx_buf,
 					      xfer->len, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, xfer->tx_dma))
 			return -ENOMEM;
-		mode = SP7021_SLAVE_WRITE;
-	} else if (xfer->rx_buf) {
+		 ret = sp7021_spi_slave_tx(spi, xfer);
+		 dma_unmap_single(dev, xfer->tx_dma, xfer->len, DMA_TO_DEVICE);
+	} else if (xfer->rx_buf && !xfer->tx_buf) {
 		xfer->rx_dma = dma_map_single(dev, xfer->rx_buf, xfer->len,
 					      DMA_FROM_DEVICE);
 		if (dma_mapping_error(dev, xfer->rx_dma))
 			return -ENOMEM;
-		mode = SP7021_SLAVE_READ;
-	}
-
-	switch (mode) {
-	case SP7021_SLAVE_WRITE:
-		ret = sp7021_spi_slave_tx(spi, xfer);
-		break;
-	case SP7021_SLAVE_READ:
 		ret = sp7021_spi_slave_rx(spi, xfer);
-		break;
-	default:
-		break;
-	}
-	if (xfer->tx_buf)
-		dma_unmap_single(dev, xfer->tx_dma, xfer->len, DMA_TO_DEVICE);
-	if (xfer->rx_buf)
 		dma_unmap_single(dev, xfer->rx_dma, xfer->len, DMA_FROM_DEVICE);
+	} else {
+		dev_dbg(&ctlr->dev, "%s() wrong command\n", __func__);
+		return -EINVAL;
+	}
 
 	spi_finalize_current_transfer(ctlr);
 	return ret;
-- 
2.7.4


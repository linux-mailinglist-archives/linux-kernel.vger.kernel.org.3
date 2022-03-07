Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C307D4D055A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243865AbiCGRiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbiCGRiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:38:20 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8A22FD;
        Mon,  7 Mar 2022 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646674645; x=1678210645;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lV2x/2s+fOd4zHljiq3dDgPjP4RKopRFUfPExzjgZo8=;
  b=K1qhfZQUg3/n6NA9P94epNlN/Jea4gRifhMCpVkz8qxgaWrvAXpdFg40
   LLCBw7coXzE/+xEZmxcdZJgoy1VEtUa2Zt+0jN3t+5ioADVy/JTRF+gPN
   xJRe5x4tG4rRfUKwxItO+F9beQf+W1QWkthQw+P6NY/IN1f61qxtOSQXb
   R0es0HxePutdXvFvedV7/D4OxbSTBffpK/CBAy1Wa6US2d9dZVtM5qRNZ
   rcJr/3wlSSFe8ZEelIF7ik5wcgUt09Dpta6JfXPDbXSXFx5AxWJ5Dm3Dg
   JeQYUtSknpWhCLj46y3O+x3XqYdDL3ErkDpa2f3Z5NL6N95kweDM2hbem
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="315168407"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="315168407"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 09:37:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="512766688"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2022 09:37:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 54AE91D6; Mon,  7 Mar 2022 19:37:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v1 1/1] spi: topcliff-pch: Prevent usage of potentially stale DMA device
Date:   Mon,  7 Mar 2022 19:37:40 +0200
Message-Id: <20220307173740.80996-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA device is expected to be available while SPI transfer is ongoing.

Prevent usage of potentially stale DMA device by keeping reference
count till the end of the transfer.

Fixes: 4d986ffa036a ("spi: add missing pci_dev_put() before return")
Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-topcliff-pch.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 8e1cc345810a..dfaa1d79a78b 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -103,6 +103,7 @@
 static int use_dma = 1;
 
 struct pch_spi_dma_ctrl {
+	struct pci_dev		*dma_dev;
 	struct dma_async_tx_descriptor	*desc_tx;
 	struct dma_async_tx_descriptor	*desc_rx;
 	struct pch_dma_slave		param_tx;
@@ -876,7 +877,6 @@ static void pch_spi_request_dma(struct pch_spi_data *data, int bpw)
 	if (!chan) {
 		dev_err(&data->master->dev,
 			"ERROR: dma_request_channel FAILS(Tx)\n");
-		data->use_dma = 0;
 		goto out;
 	}
 	dma->chan_tx = chan;
@@ -893,13 +893,15 @@ static void pch_spi_request_dma(struct pch_spi_data *data, int bpw)
 			"ERROR: dma_request_channel FAILS(Rx)\n");
 		dma_release_channel(dma->chan_tx);
 		dma->chan_tx = NULL;
-		data->use_dma = 0;
 		goto out;
 	}
 	dma->chan_rx = chan;
 
+	dma->dma_dev = dma_dev;
+	return;
 out:
 	pci_dev_put(dma_dev);
+	data->use_dma = 0;
 }
 
 static void pch_spi_release_dma(struct pch_spi_data *data)
@@ -915,6 +917,8 @@ static void pch_spi_release_dma(struct pch_spi_data *data)
 		dma_release_channel(dma->chan_rx);
 		dma->chan_rx = NULL;
 	}
+
+	pci_dev_put(dma->dma_dev);
 }
 
 static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
-- 
2.34.1


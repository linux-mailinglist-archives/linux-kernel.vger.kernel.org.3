Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD4D469544
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242734AbhLFLz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:55:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:57951 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237397AbhLFLz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:55:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="323553409"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="323553409"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 03:52:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="479090039"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 06 Dec 2021 03:52:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1627F144; Mon,  6 Dec 2021 13:52:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 2/2] mmc: mmc_spi: Use write_or_read temporary variable in mmc_spi_data_do()
Date:   Mon,  6 Dec 2021 13:52:18 +0200
Message-Id: <20211206115218.73874-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211206115218.73874-1-andriy.shevchenko@linux.intel.com>
References: <20211206115218.73874-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use write_or_read temporary variable in mmc_spi_data_do() to deduplicate
the conditional code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/mmc_spi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 4b0f9035ad29..a576181e9db0 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -859,14 +859,14 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 	struct spi_device	*spi = host->spi;
 	struct device		*dma_dev = host->dma_dev;
 	struct spi_transfer	*t;
-	enum dma_data_direction	direction;
+	enum dma_data_direction	direction = mmc_get_dma_dir(data);
 	struct scatterlist	*sg;
 	unsigned		n_sg;
 	bool			multiple = (data->blocks > 1);
+	const char		*write_or_read = (direction == DMA_TO_DEVICE) ? "write" : "read";
 	u32			clock_rate;
 	unsigned long		timeout;
 
-	direction = mmc_get_dma_dir(data);
 	mmc_spi_setup_data_message(host, multiple, direction);
 	t = &host->t;
 
@@ -921,9 +921,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 		while (length) {
 			t->len = min(length, blk_size);
 
-			dev_dbg(&host->spi->dev, "    %s block, %d bytes\n",
-				(direction == DMA_TO_DEVICE) ? "write" : "read",
-				t->len);
+			dev_dbg(&spi->dev, "    %s block, %d bytes\n", write_or_read, t->len);
 
 			if (direction == DMA_TO_DEVICE)
 				status = mmc_spi_writeblock(host, t, timeout);
@@ -948,9 +946,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 
 		if (status < 0) {
 			data->error = status;
-			dev_dbg(&spi->dev, "%s status %d\n",
-				(direction == DMA_TO_DEVICE) ? "write" : "read",
-				status);
+			dev_dbg(&spi->dev, "%s status %d\n", write_or_read, status);
 			break;
 		}
 	}
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D48469542
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242726AbhLFLzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:55:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:57951 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237397AbhLFLzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:55:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="323553406"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="323553406"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 03:52:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="579348504"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 Dec 2021 03:52:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 09169144; Mon,  6 Dec 2021 13:52:28 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 1/2] mmc: mmc_spi: Convert 'multiple' to be boolean in mmc_spi_data_do()
Date:   Mon,  6 Dec 2021 13:52:17 +0200
Message-Id: <20211206115218.73874-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert 'multiple' to be boolean in mmc_spi_data_do() since
it's initially being used as boolean.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/mmc_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index b431cdd27353..4b0f9035ad29 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -547,7 +547,7 @@ mmc_spi_command_send(struct mmc_spi_host *host,
 static void
 mmc_spi_setup_data_message(
 	struct mmc_spi_host	*host,
-	int			multiple,
+	bool			multiple,
 	enum dma_data_direction	direction)
 {
 	struct spi_transfer	*t;
@@ -862,7 +862,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 	enum dma_data_direction	direction;
 	struct scatterlist	*sg;
 	unsigned		n_sg;
-	int			multiple = (data->blocks > 1);
+	bool			multiple = (data->blocks > 1);
 	u32			clock_rate;
 	unsigned long		timeout;
 
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4B35A6C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiH3S2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiH3S2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:28:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C50F65559;
        Tue, 30 Aug 2022 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661884092; x=1693420092;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2WYTg5lKPqDuQOYcZq0AKSkMHmFxEYby1nVsncAnnK0=;
  b=JvqgLPFa4PPaayc7IHmnXyHGtyTvXiVPOam0Cjcvryg8WDA0orWwBbNY
   p2oherQCxH7cxTAlA4Pv5Df0jJxOuBusMXYUN7k6IwBc9lgbVTIPxguUh
   GSf6CNYwuy80GOe9v34mE2LovKeRfbnlrExzTBubSkrVZHKj5cEFqi/Lp
   37HoPBjkXLEcVWkHXQk6BWGSnGTll9B9BbxFWZYkLuxew4eK2j5bQH4tF
   NL4KV23Yn0GPsh/9fgGa16H3NiOfYtOmWWXbff+UMjTXus6WUWXlCRyM0
   gztdyckf1eb6o1IaOyOsqub9d9/byKzoteGDeYoiQMAYyOAhDjgttv2sS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="381566597"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="381566597"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 11:28:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="715417220"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 30 Aug 2022 11:28:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1CD7D174; Tue, 30 Aug 2022 21:28:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] spi: stm32-qspi: Replace of_gpio_named_count() by gpiod_count()
Date:   Tue, 30 Aug 2022 21:28:20 +0300
Message-Id: <20220830182821.47919-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparation to unexport of_gpio_named_count(), convert the
driver to use gpiod_count() instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-stm32-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 227f450aa5f0..5858f5f9c758 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -656,7 +656,7 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	mode = spi->mode & (SPI_TX_OCTAL | SPI_RX_OCTAL);
 	if ((mode == SPI_TX_OCTAL || mode == SPI_RX_OCTAL) ||
 	    ((mode == (SPI_TX_OCTAL | SPI_RX_OCTAL)) &&
-	    of_gpio_named_count(qspi->dev->of_node, "cs-gpios") == -ENOENT)) {
+	    gpiod_count(qspi->dev, "cs") == -ENOENT)) {
 		dev_err(qspi->dev, "spi-rx-bus-width\\/spi-tx-bus-width\\/cs-gpios\n");
 		dev_err(qspi->dev, "configuration not supported\n");
 
@@ -681,7 +681,7 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	 * are both set in spi->mode and "cs-gpios" properties is found in DT
 	 */
 	if (((spi->mode & (SPI_TX_OCTAL | SPI_RX_OCTAL)) == (SPI_TX_OCTAL | SPI_RX_OCTAL)) &&
-	    of_gpio_named_count(qspi->dev->of_node, "cs-gpios")) {
+	    gpiod_count(qspi->dev, "cs")) {
 		qspi->cr_reg |= CR_DFM;
 		dev_dbg(qspi->dev, "Dual flash mode enable");
 	}
-- 
2.35.1


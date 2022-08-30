Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E425A6C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiH3S2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiH3S2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:28:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1BB63F23;
        Tue, 30 Aug 2022 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661884092; x=1693420092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XsNRPNyfbCVjfMcNapRQOptYKGv4F/4Z6dpOZm0HvP0=;
  b=H+el+fNemdbICsYRuZISyLl95///zEBZb6V0acH3NjtAEEUdzUNBfosX
   lysrJpVgHeGyBUWXT3SPVZsa0cSTGmjBFEyYOzJEhihCeHSzUT6sWeWi/
   rAi2yj81pcam7p9Swt1cyf0y/hxsD0wTMXqf1KkiDzfOOXT6W7Kz8D0Lo
   u6A+EuuTpEs6qxA7ZLnOHLyEekLwJbmQkGcyrNwevXXVESYsB8WP+JtOb
   BLLBd8LkIlaQbgOOgyaMcJdM/RpjAbwx9gNkdUM4mvpx6ldJ5yix6MhZh
   T3gxnOOTELD2wYgJzI1ho4+4JwSvDVhgRp3cWboxBTbSTp4X4cbZK9nAB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="356985646"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="356985646"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 11:28:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="611818348"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 30 Aug 2022 11:28:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BAFA119D; Tue, 30 Aug 2022 21:28:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] spi: stm32-qspi: Refactor dual flash mode enable check in ->setup()
Date:   Tue, 30 Aug 2022 21:28:21 +0300
Message-Id: <20220830182821.47919-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830182821.47919-1-andriy.shevchenko@linux.intel.com>
References: <20220830182821.47919-1-andriy.shevchenko@linux.intel.com>
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

gpiod_count() either returns positive number of the CS or negative
error code. In the stm32_qspi_setup() we check that configuration
has enough CS for the dual flash mode and SPI mode is not changing
over the lines of the code. Taking all above into considertion,
refactor dual flash mode enable check by dropping unneeded CS check
and reusing local mode variable.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-stm32-qspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 5858f5f9c758..9131660c1afb 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -680,8 +680,7 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	 * Dual flash mode is only enable in case SPI_TX_OCTAL and SPI_TX_OCTAL
 	 * are both set in spi->mode and "cs-gpios" properties is found in DT
 	 */
-	if (((spi->mode & (SPI_TX_OCTAL | SPI_RX_OCTAL)) == (SPI_TX_OCTAL | SPI_RX_OCTAL)) &&
-	    gpiod_count(qspi->dev, "cs")) {
+	if (mode == (SPI_TX_OCTAL | SPI_RX_OCTAL)) {
 		qspi->cr_reg |= CR_DFM;
 		dev_dbg(qspi->dev, "Dual flash mode enable");
 	}
-- 
2.35.1


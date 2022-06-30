Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ABF5615AF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiF3JJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiF3JJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:09:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98B8193C6;
        Thu, 30 Jun 2022 02:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656580179; x=1688116179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iUvnkyf1FHI9uJJPInSYCIsHn4vsQKorlvRrdapwgDA=;
  b=WIwufNFCV83vKTnm7twdVPI387VI/uFNd8FvzlV+9BRJZ5ZkVyhhbYwc
   ZhY25nBr4+8v/spxEIEASD1+AAT1C7laPV5Ng1lDF/bzpu98r8L/fPXbp
   IclixoPAtCm0/oaHZMiW1h26y09hJWLC5kGD57qEkQ69iLQE1e66bw3+g
   zBR1GRV4FuuLiiKrR4AZ0RZaFZKvfQ+VzKMh8MTCVxrcDw9zFkVVo/fCv
   +zzP1G5ib5XkneP3qz3tpUa8Os7tGx9lNFLzX5WoUyTjIsd93StdE5kMP
   x7VNjkSOyjDM0xP0N5GNi7m3XHg4Y33BjKDYKzCarla0BtTxkxOXDGjFW
   g==;
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="165795106"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2022 02:09:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 30 Jun 2022 02:09:34 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 30 Jun 2022 02:09:31 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <ulf.hansson@linaro.org>
CC:     <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Eugen Hristev" <eugen.hristev@microchip.com>,
        Karl Olsen <karl@micro-technic.com>
Subject: [PATCH] mmc: sdhci-of-at91: fix set_uhs_signaling rewriting of MC1R
Date:   Thu, 30 Jun 2022 12:09:26 +0300
Message-ID: <20220630090926.15061-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In set_uhs_signaling, the DDR bit is being set by fully writing the MC1R
register.
This can lead to accidental erase of certain bits in this register.
Avoid this by doing a read-modify-write operation.

Fixes: d0918764c17b ("mmc: sdhci-of-at91: fix MMC_DDR_52 timing selection")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Tested-by: Karl Olsen <karl@micro-technic.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 10fb4cb2c731..cd0134580a90 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -100,8 +100,13 @@ static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned int clock)
 static void sdhci_at91_set_uhs_signaling(struct sdhci_host *host,
 					 unsigned int timing)
 {
-	if (timing == MMC_TIMING_MMC_DDR52)
-		sdhci_writeb(host, SDMMC_MC1R_DDR, SDMMC_MC1R);
+	u8 mc1r;
+
+	if (timing == MMC_TIMING_MMC_DDR52) {
+		mc1r = sdhci_readb(host, SDMMC_MC1R);
+		mc1r |= SDMMC_MC1R_DDR;
+		sdhci_writeb(host, mc1r, SDMMC_MC1R);
+	}
 	sdhci_set_uhs_signaling(host, timing);
 }
 
-- 
2.25.1


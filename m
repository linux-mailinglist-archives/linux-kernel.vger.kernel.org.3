Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A18C54CB2B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344754AbiFOOWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242702AbiFOOWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:22:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AB3C0F;
        Wed, 15 Jun 2022 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655302959; x=1686838959;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9qyp6+bi5a1Nfggtjv4LRguWeuVmJJ6PLYs6RLiuRn4=;
  b=CnNz3jjRaTFLeQZJGK59xXwRfVNRuTlNlNNdL0RQ2cYHPHK4Byncaytv
   cX1JwiHqDTn+jF1VCr2NfAsvoFe+WSrwWensiHrI96uTN9t29UJ/7oa0Y
   oCdtPHa2JEuaP4gbWEHk18xLR8BlL6mj0SimJ5nG6aL64mxuXKNHZO6KH
   7QrPbb2SLzml3qjuHcYYnXkLw463qKs2wUiFwOg2nwEs892sxEkPlIxbs
   MDbzfkbAeaVlFH6gpOq9KAEZTBhkiqg1qFZVgdEwrP/7HLMkf3yTWfAKe
   pIpeGXtm5fGpq5TkRJ9kWR+3mLq1cpZweY0sTc5TXpoH8Js7NlvPluYb9
   A==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="178078168"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2022 07:22:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Jun 2022 07:22:37 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 15 Jun 2022 07:22:35 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] spi: microchip-core: fix passing zero to PTR_ERR warning
Date:   Wed, 15 Jun 2022 15:20:29 +0100
Message-ID: <20220615142028.2991915-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that the error case for devm_clk_get() returns NULL,
in which case zero will be passed to PTR_ERR() as shown by the Smatch
static checker warning:
drivers/spi/spi-microchip-core.c:557 mchp_corespi_probe()
warn: passing zero to 'PTR_ERR'

Remove the NULL check and carry on with a dummy clock in case of an
error. To avoid a potential div zero, abort calculating clkgen if
clk_get_rate(spi->clk) is zero.

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/linux-spi/20220615091633.GI2168@kadam/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v2: drop the NULL check entirely rather than returning -ENXIO if NULL
---
 drivers/spi/spi-microchip-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 5b2aee30fa04..d866a831104c 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -433,6 +433,8 @@ static int mchp_corespi_calculate_clkgen(struct mchp_corespi *spi,
 	unsigned long clk_hz, spi_hz, clk_gen;
 
 	clk_hz = clk_get_rate(spi->clk);
+	if (!clk_hz)
+		return -EINVAL;
 	spi_hz = min(target_hz, clk_hz);
 
 	/*
@@ -553,7 +555,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	}
 
 	spi->clk = devm_clk_get(&pdev->dev, NULL);
-	if (!spi->clk || IS_ERR(spi->clk)) {
+	if (IS_ERR(spi->clk)) {
 		ret = PTR_ERR(spi->clk);
 		dev_err(&pdev->dev, "could not get clk: %d\n", ret);
 		goto error_release_master;
-- 
2.36.1


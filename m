Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A7254C78C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348100AbiFOLdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345296AbiFOLdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:33:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3112C433B0;
        Wed, 15 Jun 2022 04:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655292785; x=1686828785;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J2xeVFHRhS32YajK2SQJsuNx2FZegiEhlRercXHKr34=;
  b=pPksHNOvxVQktD+GcAmcawkCYt9qVp5vG8s1gtFbOyz5o4CKPEdSeH5n
   dHeHBNCCqikkWjd6XXlqLBCiPBe8pDddFe3Pi0bLUib1MJFk0O3mjkZAA
   Ixmjwsfagq6R0aP902UB0TSQQ2bc8wHqLJtwr3sWDblFXOYMxB5wN0pM1
   iy//o/C0eH6EazuB0Vs3wLbgHTPTPej3vP7ODasx0mmdwDKdnRPhKttRE
   ysbnBBbK4Rly8+QIK/sPPbr1H1inxUI0XvPIcNjCk629mmrCs/ij5cP85
   7NZsH7SXE/E2TXOheHtnLKCQwPgd8tkEK3WpWG1Ivc4ThBH3iuduhGiGb
   g==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="168507967"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2022 04:33:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Jun 2022 04:33:04 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 15 Jun 2022 04:33:02 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] spi: microchip-core: fix passing zero to PTR_ERR warning
Date:   Wed, 15 Jun 2022 12:30:22 +0100
Message-ID: <20220615113021.2493586-1-conor.dooley@microchip.com>
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

Fix the warning by explicitly returning an error if devm_clk_get()
returns NULL.

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/linux-spi/20220615091633.GI2168@kadam/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 5b2aee30fa04..d44663cca071 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -554,7 +554,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 
 	spi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!spi->clk || IS_ERR(spi->clk)) {
-		ret = PTR_ERR(spi->clk);
+		ret = !spi->clk ? -ENXIO : PTR_ERR(spi->clk);
 		dev_err(&pdev->dev, "could not get clk: %d\n", ret);
 		goto error_release_master;
 	}
-- 
2.36.1


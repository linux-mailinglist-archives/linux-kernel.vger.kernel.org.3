Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53184F60FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiDFOLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiDFOJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:09:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64C44ED0CF;
        Wed,  6 Apr 2022 03:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649239550; x=1680775550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YPQ9VGLSnWsFaAo16s8N0avyz4Em8x1yBOhaaJvn2Ic=;
  b=SzBq+cmJwQjCAEeumYgYIGnwYAt7Fn5ThYAgQNYeaGgZkJBLe7MDuWtO
   K4cIKE3ilQV+kjdv5Qg4U90MevprMrXhZtc/KMtF0gv7rN0EwKwIiKA2+
   /EhpBgxkmOZD0btk7zdJlXHie3MvRkJVTY1+Q9FduOuNotxJjvta2BZbM
   PNZHwXzV1o9sPM/ODoAK00DDeHyCl4nir5YAqMxdNaMgVoMOhED3JPfux
   NTm+5iOtDZtf8lvWdffDJvTDXN0uBZ0AVPuOL1eD8Y3wWBSutEt0oP5Nm
   MJyHKrLHhgOTWmMaC+fc+E+vUoWErRJcox6pU3L6bW/QrN6p4kXPkvjou
   g==;
X-IronPort-AV: E=Sophos;i="5.90,239,1643698800"; 
   d="scan'208";a="168611982"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Apr 2022 03:03:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Apr 2022 03:03:47 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 6 Apr 2022 03:03:45 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 2/2] spi: atmel-quadspi: Remove duplicated DTR checks
Date:   Wed, 6 Apr 2022 13:03:40 +0300
Message-ID: <20220406100340.224975-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220406100340.224975-1-tudor.ambarus@microchip.com>
References: <20220406100340.224975-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the DTR checks as they are already handled in
spi_mem_default_supports_op(). This code removal was intentionally not done
in the previous patch that introduced the use of the
spi_mem_default_supports_op() core helper and fixed the buswidth adjustment
between SPIMEM and the SPI controller, so that the fix can be easily
backported to stable kernels.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 938017a60c8e..480c0c8c18e4 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -288,12 +288,6 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
 		op->dummy.nbytes == 0)
 		return false;
 
-	/* DTR ops not supported. */
-	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
-		return false;
-	if (op->cmd.nbytes != 1)
-		return false;
-
 	return true;
 }
 
-- 
2.25.1


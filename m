Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DB958373F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiG1DCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiG1DCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:02:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582CE52FE6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658977325; x=1690513325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=my2dVllPbq4Dgzl/Gtr9GRUHAc9TOrgt08R1DPz0xRo=;
  b=uK6QXiWV0yiJjlR9MJpkwrkXVd0INrZO6cXUFQRpJzX3TSIXt3WYfbkA
   Wob6z9NCZeDBChnVtmOsOOU/AAl57bLvaFsj7ywyrBw/TjpEqpYOvB3Ho
   pL0w4xpsL4ZNNmUIDAC2tUyCNFewR5Kf+aJaTLI8odTV6fAs7LKwex7Iv
   AVdFUhe7k2v/LAkAoq33z4qtTCzkmQocxpY+N5X1C6uuUyUnf/hRVN8ye
   88DiyMGqhCa4kPmzrQSNNDVqjUaa6x6fzxDNoPW4V/gxFUW8yiFkZa4TD
   uYJI86WL5aYJ36bEUhDFmApjwoZ1Qz92BkhPzVwg7BRbalX8udhA+JYqa
   g==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="174079398"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 20:02:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 20:02:04 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 27 Jul 2022 20:02:02 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <pratyush@kernel.org>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH] mtd: spi-nor: core: Add an error message when failing to exit the 4-byte address mode
Date:   Thu, 28 Jul 2022 06:01:59 +0300
Message-ID: <20220728030159.68680-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an error message when failing to exit the 4-byte address mode. Do not
stop the execution and go through the spi_nor_soft_reset() method if used,
in the hope that the flash will default to 3-byte address mode after the
reset.

Suggested-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f2c64006f8d7..1cdbdad97136 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2841,7 +2841,8 @@ void spi_nor_restore(struct spi_nor *nor)
 	/* restore the addressing mode */
 	if (nor->addr_nbytes == 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
 	    nor->flags & SNOR_F_BROKEN_RESET)
-		nor->params->set_4byte_addr_mode(nor, false);
+		if (nor->params->set_4byte_addr_mode(nor, false))
+			dev_err(nor->dev, "Failed to exit 4-byte address mode\n");
 
 	if (nor->flags & SNOR_F_SOFT_RESET)
 		spi_nor_soft_reset(nor);
-- 
2.25.1


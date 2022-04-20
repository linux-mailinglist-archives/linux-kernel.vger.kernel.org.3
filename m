Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8565085FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352295AbiDTKhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352168AbiDTKhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:37:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4173FBD5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650450874; x=1681986874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KdL05nOBJPGL4QzjOb2cpc6owjSkTlqs6bWZgqhrLhw=;
  b=ppjwVIeIho8AUmkU91rkO9u4Hg7eXqysMe2P3oHsYAbRHhSLcpyzDUez
   xURVQmnfX7jlPiDzoObVFsUDFb400DmKzyezpgxGzmgDZWK+HIhemTgxH
   yHJaiBvWaHAUCkMFIBr+2R6x7k3RS417sMFw9JWPxVpkF4jRh0SfIAqhA
   w0gKp4f3S1wrA3BGhGAfO8Coci7X6WJftnikb+ANPeUWca0eTbq26SUjD
   HsrIzWloHJeKuCedEL1zNZbHXjvVag7n1YDjzI6nt4qf35vYUWdQbdyAU
   mX3BtSGuQb7YHjhrkhJ2uoFKLVBq+VXfvUmt5I6xndMviSRTbpMxXrUvN
   w==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643698800"; 
   d="scan'208";a="161091268"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2022 03:34:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Apr 2022 03:34:33 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 20 Apr 2022 03:34:31 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Takahiro.Kuwano@infineon.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v4 01/11] mtd: spi-nor: Rename method, s/spi_nor_match_id/spi_nor_match_name
Date:   Wed, 20 Apr 2022 13:34:17 +0300
Message-ID: <20220420103427.47867-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420103427.47867-1-tudor.ambarus@microchip.com>
References: <20220420103427.47867-1-tudor.ambarus@microchip.com>
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

The method is matching a flash_info entry by searching by name. Rename
the method for better clarity.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index b4f141ad9c9c..214d3a1ac6b0 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2876,8 +2876,8 @@ void spi_nor_restore(struct spi_nor *nor)
 }
 EXPORT_SYMBOL_GPL(spi_nor_restore);
 
-static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
-						 const char *name)
+static const struct flash_info *spi_nor_match_name(struct spi_nor *nor,
+						   const char *name)
 {
 	unsigned int i, j;
 
@@ -2899,7 +2899,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 	const struct flash_info *info = NULL;
 
 	if (name)
-		info = spi_nor_match_id(nor, name);
+		info = spi_nor_match_name(nor, name);
 	/* Try to auto-detect if chip name wasn't specified or not found */
 	if (!info)
 		info = spi_nor_read_id(nor);
-- 
2.25.1


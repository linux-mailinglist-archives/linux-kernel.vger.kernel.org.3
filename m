Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3B748650E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbiAFNQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:16:19 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:59496 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiAFNQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641474978; x=1673010978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IYrdrJWcfkX8IFQj3tKNNLyxg7v2rQIq/226C5qZ1EQ=;
  b=zY52YD/SjyUDF/s0StiOlgE9P4WAxAZyPdyUDBkJx9uvh0rHCkr4iQzX
   1Hb26JJShfzQ/Ocbg0CcrBRwr+uxQn7QEcFe4/GX32BJpYl2X/wuGUrB7
   OkjA2lEisG09sZ6wLMmnWpe0XRxaB8ze9VXqbZhdLrL0TcwG9Ptpg/RDf
   d5DvAVrNI592yYx+ShnVVs5zvKeh6i4oQfmSaUlFqVLogFNy3EYIr+VqT
   jMGaChFc0FLqDlYgu3ieFPzTI5pgLCrPXnMCc+J+8flh4cfi34llu0wuQ
   g6d09/nnlOt9R4R73cWPxxzeeKsG+dXQnCe8CzuOh/jJKupXRAwd+sIqp
   g==;
IronPort-SDR: UpvhNephNHdpHHP+cmFVmdv6qEVcaOTmb9LFOitOUHJj0DVTf09mxyqJUBJgReKreZewIWnJ0J
 w/5JZSjK5+NjQz+ybTMR69PmCExf3Ri1Q445Ii1YDZ2UE4UQ8vqWS2uZjN254IkSY2wTmjcwmn
 Kn6zMbjjwjVi+9A9B0tDq/W/+1x/5cmRNPhKd71lr/D6b2573vYHRQfCmOwghPynMDFRWqwDe2
 ZRV4o9QqN4zXUhwwLW/8uMU6PtLdkBsJtnyxmHSzUNQNf5EnzKXDzQHaXLYq0jwv7Bs+1gBfjV
 +wpWWhs2CKEAxpaGKAmuSsey
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="149326896"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jan 2022 06:16:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 6 Jan 2022 06:16:17 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 6 Jan 2022 06:16:16 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 1/2] mtd: rawnand: Remove of_get_nand_on_flash_bbt() wrapper
Date:   Thu, 6 Jan 2022 15:16:09 +0200
Message-ID: <20220106131610.225661-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the wrapper as it hides for no reason what we really want: find an
of_property. Removing the wrapper makes the code easier to read.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/nand/raw/nand_base.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 113a2e9f43b1..b8e7f1aae032 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5287,11 +5287,6 @@ static int of_get_nand_bus_width(struct device_node *np)
 	}
 }
 
-static bool of_get_nand_on_flash_bbt(struct device_node *np)
-{
-	return of_property_read_bool(np, "nand-on-flash-bbt");
-}
-
 static int of_get_nand_secure_regions(struct nand_chip *chip)
 {
 	struct device_node *dn = nand_get_flash_node(chip);
@@ -5375,7 +5370,7 @@ static int rawnand_dt_init(struct nand_chip *chip)
 	if (of_property_read_bool(dn, "nand-is-boot-medium"))
 		chip->options |= NAND_IS_BOOT_MEDIUM;
 
-	if (of_get_nand_on_flash_bbt(dn))
+	if (of_property_read_bool(dn, "nand-on-flash-bbt"))
 		chip->bbt_options |= NAND_BBT_USE_FLASH;
 
 	of_get_nand_ecc_user_config(nand);
-- 
2.25.1


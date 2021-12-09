Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D7846F180
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbhLIRYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:24:50 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:34200 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbhLIRYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639070476; x=1670606476;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vxKWOQzwqDV/635r6yfLu/pg7KV7X8iCTbkJjrkvp8I=;
  b=iVqP1XLQPVSpHnNwxCcj8aUQReXa9mprHCePGLTnMvkkozfgD78pqrp3
   PWy97OAdi8deFcQ6DUjxGJDvkvZpp4oPGEdFqArMbV0gE/v/IbEEnDC1t
   geSroFNWoTYZXJnNrwD8j8nRe2Eo/IFoXEzIAogPoqEzNVP1Zvjbo0JTu
   OtBvrsqmn82w8CzEWoqfo33OY/NfEQEfWo36PYD9dVWV8YVhWA+0ubL1z
   iEMi+tBwMkvf/GYIh0uinMw/UpUM0SOM2eSgb0gGDbrQBU5/w/Vaf9p1Q
   Kf4OdnzyjfzZtK0ZVxUmLIv6VjF+YkMfNtH8DLUfs5WrbtNS6+rrYKbap
   w==;
IronPort-SDR: wM3TKeiOe4o3X1pUVKAfdHHkb7rloHvDKZb+Ep4ttfYLV1OGAzkgparxSWBr/saNUW/UrUia1M
 9hNNwAaeYOr3hAyOwNfuggBf1XtLQE1nI8ny/DmG+IaWPOl+lUI45wsP0sZ8uxnEVC5hMwyUky
 quzPJmOA3BtSSVQhoBaX/pk7+ndtGM3MAM6UHvrFEs35IC47wW78RobQT0TQ2uphYDjH3qhUYS
 glttgGuJwo58yDZGDU3nKodC1eKfD2dpX5gWfgfuydUt7IRobwIVtFyAYFvvwMS57nechXsU5w
 i5hMsj+c4ZEvuT2nWvCHU4Kt
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="154908042"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Dec 2021 10:21:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 10:21:14 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Dec 2021 10:21:11 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <zhengxunli@mxic.com.tw>,
        <jaimeliao@mxic.com.tw>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 1/2] mtd: spi-nor: core: Introduce SPI_NOR_SOFT_RESET flash_info fixup_flag
Date:   Thu, 9 Dec 2021 19:21:07 +0200
Message-ID: <20211209172109.398258-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Soft Reset and Rescue Sequence Support is defined in BFPT_DWORD(16)
starting with JESD216A. The first version of SFDP, JESD216 (April 2011),
defines just the first 9 BFPT DWORDS, thus it does not contain information
about the Software Reset and Rescue Support. Since this support can not
be discovered by parsing the first SFDP version, introduce a flash_info
fixup_flag that will be used either by flashes that define
JESD216 (April 2011) or by flashes that do not define SFDP at all.
In case a flash defines BFPT_DWORD(16) but with wrong values, one should
instead use a post_bfpt() hook and set SNOR_F_SOFT_RESET.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 3 +++
 drivers/mtd/spi-nor/core.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 2e21d5ac0e2d..32d80fdaa2a2 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2699,6 +2699,9 @@ static void spi_nor_init_fixup_flags(struct spi_nor *nor)
 
 	if (fixup_flags & SPI_NOR_IO_MODE_EN_VOLATILE)
 		nor->flags |= SNOR_F_IO_MODE_EN_VOLATILE;
+
+	if (fixup_flags & SPI_NOR_SOFT_RESET)
+		nor->flags |= SNOR_F_SOFT_RESET;
 }
 
 /**
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 2afb610853a9..70c6bb7f5f04 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -373,6 +373,8 @@ struct spi_nor_fixups {
  *                            memory size above 128Mib.
  *   SPI_NOR_IO_MODE_EN_VOLATILE: flash enables the best available I/O mode
  *                            via a volatile bit.
+ *   SPI_NOR_SOFT_RESET:      flash supports software reset enable, reset
+ *                            sequence.
  * @mfr_flags:      manufacturer private flags. Used in the manufacturer fixup
  *                  hooks to differentiate support between flashes of the same
  *                  manufacturer.
@@ -416,6 +418,7 @@ struct flash_info {
 	u8 fixup_flags;
 #define SPI_NOR_4B_OPCODES		BIT(0)
 #define SPI_NOR_IO_MODE_EN_VOLATILE	BIT(1)
+#define SPI_NOR_SOFT_RESET		BIT(2)
 
 	u8 mfr_flags;
 
-- 
2.25.1


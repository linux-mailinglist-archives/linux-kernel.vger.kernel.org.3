Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D67478C94
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbhLQNor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:44:47 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:6445 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236709AbhLQNoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639748686; x=1671284686;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9w1DxWP4zjlu6ehwUCfkUegP1MtCz8ADBKVsvfDk+Yw=;
  b=ekh4fn5CkCeujIbmZZ8GKkOYX4IiQYFH9SOaQPV1MzI9YvCbJTmVDr7L
   kQRlrrnd96gF5mn3+pTeQEXdbT6eIEHc1sRcZVZH7w1x/dbATUiEde9KE
   aZMDDc9WJ6Xd1HSYoXBykGfRuUyf4cwsyd2CItJ/nB4Lv9GpwUDG+5ASI
   ozw4MNW4GyktDAslsfFoWFE2QT6oD/yMR0xmOfHDxBqApIkZs4YHIQlhU
   h/BhILD68QO7SWFjFrQPv6rMoUTIe2Ng+nGxFPBmBX+bxnQw3ygMt2WO/
   3ARA+bU/lrz2bp89WWMUN6zbtNiq9w2vGrKJceyQf7TNQswLHFAowI+Y7
   Q==;
IronPort-SDR: 89iDa8JCPrGIsCy1CaWmnWR5htcCtVCN+gpbDp7stZL2+i0fLezHnDkUmkNz0G4iGJAE9LFBiH
 aeL7eDJqEkM9b0N/OTQGSCp8TQLWF/YElvpQzWiBuiddfPzPPpmSGtRwdY9kDyoU2l9Wh78CTJ
 Rl8MOvfUl68B6jcESrVwAATuRJDBO/n9EZHx/cQ4wK0qSJdkctLll4aOVDBCOIpaaLNd3155Dw
 VFyzKJ+9zvxUGDH5IchH934/yBI332U5+Id7oMgTORvlpdKUEmn7FMJoGeejj7XP0eOxJV+B/U
 Qwr6EdHfmx/WSG36qVjm6bdy
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="79916992"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Dec 2021 06:44:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 06:44:45 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 17 Dec 2021 06:44:43 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v3 1/2] mtd: spi-nor: core: Introduce SPI_NOR_SOFT_RESET flash_info fixup_flag
Date:   Fri, 17 Dec 2021 15:44:41 +0200
Message-ID: <20211217134442.497950-1-tudor.ambarus@microchip.com>
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
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
v3:
- resend the patch, this time prefixed with v3
- collect R-b
v2: no changes

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


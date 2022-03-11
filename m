Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64B24D5CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347352AbiCKIDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347332AbiCKIDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:03:12 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DBF1B84FF;
        Fri, 11 Mar 2022 00:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646985730; x=1678521730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sk3bFODpPm2ztjb36G+Zu9/OH2gXZtECL/CO9UBfEXo=;
  b=CdW0Lh9W1y6dE/Z/bO3StIgvA3BKmkxHBgY6xhACEgiL2rQRn9udyXrO
   +HEbU6au7LOtPzCwy9rMSK1ddoZkXv05PH3YaJ0AMMeKBmAekWr9toKVZ
   n0CSvsz2xVsU4uRxBB69ZIb7j4Yk193P625t2tC4eQ8EpJkCH2DNrTUzP
   SlTti5xFI6+dQZCZE9pK5rEOVjTKe3QDQkZX2FlKZkm8XMXm+TJMfEyMu
   DPVP1RtkkGkc8GWQocLXC8M5cFd0uxFBqAhMKIHfL28FygyGWa+6vAzGL
   bcJtNRJ5M0cTHLVaIw9W6xsalykDdfj4OmmbGzRNSO9eCktNXNcaDgJE9
   A==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643698800"; 
   d="scan'208";a="148864962"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Mar 2022 01:02:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Mar 2022 01:02:08 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 11 Mar 2022 01:02:05 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>, <broonie@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 5/6] mtd: spi-nor: core: Introduce SPI_NOR_SOFT_RESET flash_info fixup_flag
Date:   Fri, 11 Mar 2022 10:01:46 +0200
Message-ID: <20220311080147.453483-6-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311080147.453483-1-tudor.ambarus@microchip.com>
References: <20220311080147.453483-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Link: https://lore.kernel.org/r/20220209133656.374903-7-tudor.ambarus@microchip.com
---
 drivers/mtd/spi-nor/core.c | 3 +++
 drivers/mtd/spi-nor/core.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d7eebbd01122..7da8cf559dfd 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2417,6 +2417,9 @@ static void spi_nor_init_fixup_flags(struct spi_nor *nor)
 
 	if (fixup_flags & SPI_NOR_IO_MODE_EN_VOLATILE)
 		nor->flags |= SNOR_F_IO_MODE_EN_VOLATILE;
+
+	if (fixup_flags & SPI_NOR_SOFT_RESET)
+		nor->flags |= SNOR_F_SOFT_RESET;
 }
 
 /**
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 4508bbea5df1..fa716e467330 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -483,6 +483,8 @@ struct spi_nor_fixups {
  *                            memory size above 128Mib.
  *   SPI_NOR_IO_MODE_EN_VOLATILE: flash enables the best available I/O mode
  *                            via a volatile bit.
+ *   SPI_NOR_SOFT_RESET:      flash supports software reset enable, reset
+ *                            sequence.
  * @mfr_flags:      manufacturer private flags. Used in the manufacturer fixup
  *                  hooks to differentiate support between flashes of the same
  *                  manufacturer.
@@ -524,6 +526,7 @@ struct flash_info {
 	u8 fixup_flags;
 #define SPI_NOR_4B_OPCODES		BIT(0)
 #define SPI_NOR_IO_MODE_EN_VOLATILE	BIT(1)
+#define SPI_NOR_SOFT_RESET		BIT(2)
 
 	u8 mfr_flags;
 
-- 
2.25.1


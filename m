Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403545089B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376677AbiDTNug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350241AbiDTNue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:50:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAB5366AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650462467; x=1681998467;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sUJroFoXBzmcyruFohmRbLRJI63W9ZiOK3L36C2txXM=;
  b=Cy52VSuH91NrluMqbiT/22uDa0fTBrkj2cbzWyS7qC/03+iuVM4YxfeJ
   vINUi9ft6GZkfNBONhmGur0yeHyYu2AOMKDWjbTzmxAkcZ1Be3pv9C2Zc
   XtGM7DmrLO/A+S5f61X6y9JqpOvJHnfKektq30y81FLge177e6gmYTxIu
   epK9/YU6Lq5hFkMcdtHVyCQi5IdgqxnbgWPMWCElw4pCmSMQmKKLh08+5
   SuiIJUVAhNFy0lacZQY9XchYRm8GEmCnGuY/RSbdZT4a06lhABAlm4jqd
   8xgJzsZWHJJaXEOJkqxDoDprZtU05YrWl6P5cBL8W8qxvITN56f/sflVO
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643698800"; 
   d="scan'208";a="92962328"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2022 06:47:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Apr 2022 06:47:46 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 20 Apr 2022 06:47:43 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <codrin.ciubotariu@microchip.com>, <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 1/3] ARM: configs: at91: Remove MTD_BLOCK and use MTD_UBI_BLOCK for read only block FS
Date:   Wed, 20 Apr 2022 16:47:38 +0300
Message-ID: <20220420134740.193563-1-tudor.ambarus@microchip.com>
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

Using mtdblock on raw flashes is generally a bad idea as it lacks
wear-leveling, bad block handling or power-cut management.
What happens when you use mtdblock and you change any sector of your
mtdblockX device, is that it reads the whole corresponding eraseblock into
the memory, erases the eraseblock, changes the sector in RAM, and writes
the whole eraseblock back. If you have a power failure when the eraseblock
is being erased, you lose all the block device sectors in it. The flash
will likely decay soon because the eraseblocks will wear out.

Remove this archaic tool as its use case should rather be only for debug
purposes. This means that write-capable block file systems like ext2,
ext3, FAT, etc. will no longer be addressed with at91 defconfigs. For
read only block filesystems like SquashFS, use MTD_UBI_BLOCK instead and
benefit of UBI's bit-flip handling and wear-levelling.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 2 +-
 arch/arm/configs/sama5_defconfig   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 549d01be0b47..cf79510631ea 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -50,13 +50,13 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_TESTS=m
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_BLOCK=y
 CONFIG_MTD_DATAFLASH=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_FASTMAP=y
+CONFIG_MTD_UBI_BLOCK=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=4
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 03dd80c2a19e..1c4c5a035518 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -57,13 +57,13 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_TESTS=m
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_FASTMAP=y
+CONFIG_MTD_UBI_BLOCK=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=4
-- 
2.25.1


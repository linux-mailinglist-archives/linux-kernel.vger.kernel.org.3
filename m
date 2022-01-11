Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9B148AE02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbiAKM45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:56:57 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:11534 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiAKM4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641905809; x=1673441809;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lpBCZMTfwjqmUBoS1O/VdPaK28PYoT9VGvqougv00cQ=;
  b=Dg+r3X35ld9AGaUpq4NfdTW7tOB0o0WBqp+27hiWZ+9R6jMgpLp61geP
   pRn2kb8qW6BPBxjrNQGua4cMCRSrbdfAvw235xDqAmLkKLy1NPgESUui4
   drbkX6vAxSzbHtdHrw9bR7JpjormUh+5S5htZQIPucqLsNIMAlxYAdxkd
   lo2rij4cv5JmDRhyu61G+yjjK1PZWM9lKVw31Im3ETt14br9NJao2a61l
   cCNMJEQn6HLC0Jfw5bU05LSa9bZrRcq6A8oZtSxYIFoFrMnuGKcEsz3aI
   rmsbegb4gucc7x6C/dnnHxf5Mq/UeDqEJsfUovnuXPUhGun9AKQVn3E9k
   Q==;
IronPort-SDR: aN0T1vtM72Uz1fnwU2pOc2/lRdUsa1XlyF1tB3sXuulPjDBx9BqpQ68XJYNj1QghuI1+xRriMc
 DuiPtRxD4XQ7aAELJOWkpBKnAf+GDOlzypUSO4GHnWjSclkIPFywI1S1Ew4/cZ1tbB4RHq7dBy
 4u+4RBK5aDJcqyIvc2roXzR6s28rxZzBKBiHSjbN4BOMK4D14CMLaj6UEDKTVkpIvKECMwtf18
 Cs6PVK4o76prsgaq8Xn5ZY9/LLVlEvMRf124Qo+bBT5/25wOwmmfZGEAFXPxG81xs8r9W5DNki
 g7Tr+DRSErqAMrgXVf0BIQQ0
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="145038185"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jan 2022 05:56:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 11 Jan 2022 05:56:48 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 11 Jan 2022 05:56:45 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>
CC:     <claudiu.beznea@microchip.com>, <eugen.hristev@microchip.com>,
        <codrin.ciubotariu@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] ARM: configs: at91: sama7: Enable NAND / SMC
Date:   Tue, 11 Jan 2022 14:56:41 +0200
Message-ID: <20220111125641.903624-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Static Memory Controller. Tested with Micron MT29F4G08ABAEAWP
NAND flash. Software error correction is not needed, as the SMC includes
a PMECC error correction hardware module.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 0368068e04d9..342d9f30d9d2 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -82,6 +82,9 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_TESTS=m
 CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_MTD_NAND_ATMEL=y
+# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -174,7 +177,6 @@ CONFIG_DMATEST=y
 CONFIG_STAGING=y
 CONFIG_MICROCHIP_PIT64B=y
 # CONFIG_IOMMU_SUPPORT is not set
-# CONFIG_ATMEL_EBI is not set
 CONFIG_IIO=y
 CONFIG_IIO_SW_TRIGGER=y
 CONFIG_AT91_SAMA5D2_ADC=y
-- 
2.25.1


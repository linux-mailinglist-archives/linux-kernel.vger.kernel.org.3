Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348F74A9A80
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbiBDN7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:59:12 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:47341 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbiBDN7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643983150; x=1675519150;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vIiDumgiYLPsUjrQQKiQ4DZXahKAc2IiKe0w73Hjfd4=;
  b=rgJl7JAY+o6DxVlrjvTB3+9O5En3GuOUIflHWmSrLoVGuJeEfXqHGTlt
   9fd+e8uOAaYIyi2+dd2GshtgK9NkUU3Hw1DtjNNyDlmDnKcNH05VYz+t1
   vz5N5WK4hGNpb34LhieCvteKQAm0xDPOqLFBYePXhOGBoHo5L+mM+KrMx
   /4m44+dKQtS8YXF7nPoKD5ZT5UnDCAvGo+NL9C4Oue67LSMN+WDGkb4AN
   VeEpocAmzXGXMMt/xuj+9peT3B3qNO+O+S2MUZG+TiAc9jutpu8FRjhGs
   ZWwSSCnrZYOnKD/BaExcgUK5vdNa7PhjEcU3ljHBhxWE8My2UXLAuPOdq
   g==;
IronPort-SDR: xSqAVpI98Oo2Avbl193bkaJgZerhegNz3O51wZviwEZgq+cYwCa+Whql701G+mzj689052h7Op
 Rq6KASA11tQLgXCNapM2uR+EOMQjvUkm+GtJYnbkFCCKV3O5UaePuBNYIB94NDy0s1QGUv5cCK
 CmO9UvP1Av47kgIkzALvqmIaEtA7hfR0iRBbUZjrQBjoyYxyV/fOLEDsVDxNnLov3iq5VjRu6+
 /F/U3xVccxalyvkgEURfbJQcUqbf64u1FaLHXW7rfvxSCvXMXULl/NT1xJilYL2zOU23+8E6yJ
 FSGnBNej4sO8cbPgp8zqBc0v
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="161114220"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Feb 2022 06:59:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Feb 2022 06:59:09 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Feb 2022 06:59:07 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] ARM: configs: at91: sama7: Enable crypto IPs and software algs
Date:   Fri, 4 Feb 2022 15:59:05 +0200
Message-ID: <20220204135905.512013-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to sama5_defconfig, enable hardware acceleration for the
sama7 crypto IPs, enable crypto software implementations in case
the crypto IPs need a fallback to them, and enable the hash and
skcipher user interfaces in case one wants to offload the crypto
algs to the sama7 crypto IPs.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index c12278174579..d6e27b837f88 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -196,7 +196,19 @@ CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_LSM="N"
-# CONFIG_CRYPTO_HW is not set
+CONFIG_CRYPTO_AUTHENC=y
+CONFIG_CRYPTO_GCM=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_CFB=y
+CONFIG_CRYPTO_OFB=y
+CONFIG_CRYPTO_XTS=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_DES=y
+CONFIG_CRYPTO_USER_API_HASH=m
+CONFIG_CRYPTO_USER_API_SKCIPHER=m
+CONFIG_CRYPTO_DEV_ATMEL_AES=y
+CONFIG_CRYPTO_DEV_ATMEL_TDES=y
+CONFIG_CRYPTO_DEV_ATMEL_SHA=y
 CONFIG_CRC_CCITT=y
 CONFIG_CRC_ITU_T=y
 CONFIG_DMA_CMA=y
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355044D2CC8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiCIKIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiCIKII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:08:08 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CC213D55E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646820429; x=1678356429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OgkXGpZYo7BvkpR/FYU9AJidJxqpmQ20r41+loe2PsA=;
  b=ZhqGoDwVhW8koZxqNZVrzpMJjizFd8NYfwgGddqCMicrpWwXUC2jFOcb
   8vwfDrmQOWrkbQfnUzdEAb95JTHIhnQfhObJqY2YK7iwC4Xga4Hybytnv
   xka82JcyDDv5/4FO6Ky3V7pqTPaIJnOgT82PYruWA1N3oXhupN/DMgzCm
   9ufV3PyCnJSlpJFd5MlKBXFWPTtcr2PjtwtV7gykDc9UqyU9zYF/zN4pb
   UgLWTiVDE5A8dpiIYWeaPKXaJKn6ZRL1Pa7Tpjy4A5RG2aM3Q6Wdi6w7v
   yL97puM20ruStqjzSWbJ2PXkuBVJWKvQwAA4XplFNyLlTaC8nJm88TSDS
   g==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="148595292"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 03:07:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 03:07:07 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Mar 2022 03:07:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ARM: at91: Kconfig: implement PIT64B selection
Date:   Wed, 9 Mar 2022 12:08:02 +0200
Message-ID: <20220309100802.3610259-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
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

Implement PIT64B selection thus it will be available for the necessary
targets (at the moment SAM9X60 and SAMA7G5) w/o the necessity to
specify it via defconfig. With this the current CONFIG_TIMER_OF
dependency of PIT64B driver could be removed. Along with changes
on AT91 Kconfig removed CONFIG_MICROCHIP_PIT64B from defconfigs.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig  | 1 -
 arch/arm/configs/multi_v7_defconfig | 1 -
 arch/arm/configs/sama7_defconfig    | 1 -
 arch/arm/mach-at91/Kconfig          | 9 +++++++++
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 549d01be0b47..04f71dac9c97 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -195,7 +195,6 @@ CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_DMADEVICES=y
 CONFIG_AT_HDMAC=y
 CONFIG_AT_XDMAC=y
-CONFIG_MICROCHIP_PIT64B=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_AT91_ADC=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8863fa969ede..bec62d5aa3c6 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -989,7 +989,6 @@ CONFIG_APQ_MMCC_8084=y
 CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
-CONFIG_MICROCHIP_PIT64B=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_GART=y
diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 07b0494ef743..2b0f020a18eb 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -182,7 +182,6 @@ CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_DMADEVICES=y
 CONFIG_AT_XDMAC=y
 CONFIG_STAGING=y
-CONFIG_MICROCHIP_PIT64B=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_IIO_SW_TRIGGER=y
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 279810381256..1531b4625c76 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -165,6 +165,15 @@ config ATMEL_CLOCKSOURCE_TCB
 	  to make a single 32-bit timer.
 	  It can also be used as a clock event device supporting oneshot mode.
 
+config MICROCHIP_CLOCKSOURCE_PIT64B
+	bool "64-bit Periodic Interval Timer (PIT64B) support"
+	default SOC_SAM9X60 || SOC_SAMA7
+	select MICROCHIP_PIT64B
+	help
+	  Select this to get a high resolution clockevent (SAM9X60) or
+	  clocksource and clockevent (SAMA7G5) based on Microchip 64-bit
+	  Periodic Interval Timer.
+
 config HAVE_AT91_UTMI
 	bool
 
-- 
2.32.0


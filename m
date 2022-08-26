Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D830A5A2337
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343693AbiHZIhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245643AbiHZIhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:37:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721E2D345A;
        Fri, 26 Aug 2022 01:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661503047; x=1693039047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=msDgI3aMcCtjyIcnn6jZJTKEB7TrIShLE/Zcmhh9CBU=;
  b=HR2f80QR/ObbO1x2HXGN3P2KHp+wZgaeK+Ror6MOzSwCeH3IvN4kZIsl
   e0dwUkoXTmPNgh+weu0vS5xkJqixcNio2RG/BY5RW0XEYaY0YCtgtSo0+
   UouBwCEdaaL7lMFJZvf5SRaVdX/zYcrbhlxbvdOz/hbTWRQbTEtZME12r
   KOPrK9nluRGqtixOo9322agAA7lsJsFfs7wKGRFHuZg3USODVQwLUdSOm
   6mExK8mrRgOxZGBzawfetjKPWqI96VWCXmuqHdiYkpI1dvvyNcly4QMjc
   ia1wRjFgTjmaE5EPpiE6XfP9hl+EKuCDagEHWeA4xgKKfZ5zk3ofrzREL
   A==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="177981552"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 01:37:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 01:37:16 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 26 Aug 2022 01:37:14 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux@armlinux.org.uk>,
        <arnd@arndb.de>
CC:     <cristian.birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Frederic Schumacher" <frederic.schumacher@microchip.com>
Subject: [PATCH 3/9] ARM: at91: pm: fix DDR recalibration when resuming from backup and self-refresh
Date:   Fri, 26 Aug 2022 11:39:21 +0300
Message-ID: <20220826083927.3107272-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220826083927.3107272-1-claudiu.beznea@microchip.com>
References: <20220826083927.3107272-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SAMA7G5, when resuming from backup and self-refresh, the bootloader
performs DDR PHY recalibration by restoring the value of ZQ0SR0 (stored
in RAM by Linux before going to backup and self-refresh). It has been
discovered that the current procedure doesn't work for all possible values
that might go to ZQ0SR0 due to hardware bug. The workaround to this is to
avoid storing some values in ZQ0SR0. Thus Linux will read the ZQ0SR0
register and cache its value in RAM after processing it (using
modified_gray_code array). The bootloader will restore the processed value.

Fixes: d2d4716d8384 ("ARM: at91: pm: save ddr phy calibration data to securam")
Suggested-by: Frederic Schumacher <frederic.schumacher@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c      | 36 ++++++++++++++++++++++++++++++++----
 include/soc/at91/sama7-ddr.h |  4 ++++
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index df6d673e83d5..f4501dea98b0 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -541,9 +541,41 @@ extern u32 at91_pm_suspend_in_sram_sz;
 
 static int at91_suspend_finish(unsigned long val)
 {
+	unsigned char modified_gray_code[] = {
+		0x00, 0x01, 0x02, 0x03, 0x06, 0x07, 0x04, 0x05, 0x0c, 0x0d,
+		0x0e, 0x0f, 0x0a, 0x0b, 0x08, 0x09, 0x18, 0x19, 0x1a, 0x1b,
+		0x1e, 0x1f, 0x1c, 0x1d, 0x14, 0x15, 0x16, 0x17, 0x12, 0x13,
+		0x10, 0x11,
+	};
+	unsigned int tmp, index;
 	int i;
 
 	if (soc_pm.data.mode == AT91_PM_BACKUP && soc_pm.data.ramc_phy) {
+		/*
+		 * Bootloader will perform DDR recalibration and will try to
+		 * restore the ZQ0SR0 with the value saved here. But the
+		 * calibration is buggy and restoring some values from ZQ0SR0
+		 * is forbidden and risky thus we need to provide processed
+		 * values for these (modified gray code values).
+		 */
+		tmp = readl(soc_pm.data.ramc_phy + DDR3PHY_ZQ0SR0);
+
+		/* Store pull-down output impedance select. */
+		index = (tmp >> DDR3PHY_ZQ0SR0_PDO_OFF) & 0x1f;
+		soc_pm.bu->ddr_phy_calibration[0] = modified_gray_code[index];
+
+		/* Store pull-up output impedance select. */
+		index = (tmp >> DDR3PHY_ZQ0SR0_PUO_OFF) & 0x1f;
+		soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
+
+		/* Store pull-down on-die termination impedance select. */
+		index = (tmp >> DDR3PHY_ZQ0SR0_PDODT_OFF) & 0x1f;
+		soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
+
+		/* Store pull-up on-die termination impedance select. */
+		index = (tmp >> DDR3PHY_ZQ0SRO_PUODT_OFF) & 0x1f;
+		soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
+
 		/*
 		 * The 1st 8 words of memory might get corrupted in the process
 		 * of DDR PHY recalibration; it is saved here in securam and it
@@ -1066,10 +1098,6 @@ static int __init at91_pm_backup_init(void)
 		of_scan_flat_dt(at91_pm_backup_scan_memcs, &located);
 		if (!located)
 			goto securam_fail;
-
-		/* DDR3PHY_ZQ0SR0 */
-		soc_pm.bu->ddr_phy_calibration[0] = readl(soc_pm.data.ramc_phy +
-							  0x188);
 	}
 
 	return 0;
diff --git a/include/soc/at91/sama7-ddr.h b/include/soc/at91/sama7-ddr.h
index 2706bc48c076..6ce3bd22f6c6 100644
--- a/include/soc/at91/sama7-ddr.h
+++ b/include/soc/at91/sama7-ddr.h
@@ -38,6 +38,10 @@
 #define		DDR3PHY_DSGCR_ODTPDD_ODT0	(1 << 20)	/* ODT[0] Power Down Driver */
 
 #define DDR3PHY_ZQ0SR0				(0x188)		/* ZQ status register 0 */
+#define DDR3PHY_ZQ0SR0_PDO_OFF			(0)		/* Pull-down output impedance select offset */
+#define DDR3PHY_ZQ0SR0_PUO_OFF			(5)		/* Pull-up output impedance select offset */
+#define DDR3PHY_ZQ0SR0_PDODT_OFF		(10)		/* Pull-down on-die termination impedance select offset */
+#define DDR3PHY_ZQ0SRO_PUODT_OFF		(15)		/* Pull-up on-die termination impedance select offset */
 
 #define	DDR3PHY_DX0DLLCR			(0x1CC)		/* DDR3PHY DATX8 DLL Control Register */
 #define	DDR3PHY_DX1DLLCR			(0x20C)		/* DDR3PHY DATX8 DLL Control Register */
-- 
2.34.1


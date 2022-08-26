Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEC65A2327
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245282AbiHZIha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343679AbiHZIhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:37:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89F0D5700;
        Fri, 26 Aug 2022 01:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661503035; x=1693039035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R+ZXodYH0NjgQV+jNwarfE1Vs8mAKES25AbetN8LplY=;
  b=2LkRQ/vcglasjXx+CsFkoM/wGiX2wbJci3BvNuvCVo3aQOr1eZqTq/MR
   2bqt6UHjzMZnkBdQ4MKcTVXxVQCyAJ9xr04eTfJuol3gJuxyK8Ktb/awg
   EGB9Llrlz5Gcz5qbECKbTpMIYfs6hVa06hDzI5vhddtbfLo8QwqFg1nDW
   fB0jYY3a9Er70L9vwtgbYVk8abmmGceXHIjVjdQoqHUk/hHzLoqpF2gqr
   MPPjWox4AxMmUzE7bT7aa8U3YiU0SsfFtfKYxnrTP7ULRg13k7fSIheth
   AfyCVWb8lIdWlc7eqIyCEO/Oxk+SHKpNaGnA6kOkmm8mF7bZlyIOzxY7i
   A==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="174284217"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 01:37:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 01:37:13 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 26 Aug 2022 01:37:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux@armlinux.org.uk>,
        <arnd@arndb.de>
CC:     <cristian.birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Frederic Schumacher" <frederic.schumacher@microchip.com>
Subject: [PATCH 2/9] ARM: at91: pm: fix self-refresh for sama7g5
Date:   Fri, 26 Aug 2022 11:39:20 +0300
Message-ID: <20220826083927.3107272-3-claudiu.beznea@microchip.com>
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

It has been discovered that on some parts, from time to time, self-refresh
procedure doesn't work as expected. Debugging and investigating it proved
that disabling AC DLL introduce glitches in RAM controllers which
leads to unexpected behavior. This is confirmed as a hardware bug. DLL
bypass disables 3 DLLs: 2 DX DLLs and AC DLL. Thus, keep only DX DLLs
disabled. This introduce 6mA extra current consumption on VDDCORE when
switching ot any ULP mode or standby mode but the self-refresh procedure
still works.

Fixes: f0bbf17958e8 ("ARM: at91: pm: add self-refresh support for sama7g5")
Suggested-by: Frederic Schumacher <frederic.schumacher@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Tested-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 24 +++++++++++++++++-------
 include/soc/at91/sama7-ddr.h    |  4 ++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index abe4ced33eda..ffed4d949042 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -172,9 +172,15 @@ sr_ena_2:
 	/* Put DDR PHY's DLL in bypass mode for non-backup modes. */
 	cmp	r7, #AT91_PM_BACKUP
 	beq	sr_ena_3
-	ldr	tmp1, [r3, #DDR3PHY_PIR]
-	orr	tmp1, tmp1, #DDR3PHY_PIR_DLLBYP
-	str	tmp1, [r3, #DDR3PHY_PIR]
+
+	/* Disable DX DLLs. */
+	ldr	tmp1, [r3, #DDR3PHY_DX0DLLCR]
+	orr	tmp1, tmp1, #DDR3PHY_DXDLLCR_DLLDIS
+	str	tmp1, [r3, #DDR3PHY_DX0DLLCR]
+
+	ldr	tmp1, [r3, #DDR3PHY_DX1DLLCR]
+	orr	tmp1, tmp1, #DDR3PHY_DXDLLCR_DLLDIS
+	str	tmp1, [r3, #DDR3PHY_DX1DLLCR]
 
 sr_ena_3:
 	/* Power down DDR PHY data receivers. */
@@ -221,10 +227,14 @@ sr_ena_3:
 	bic	tmp1, tmp1, #DDR3PHY_DSGCR_ODTPDD_ODT0
 	str	tmp1, [r3, #DDR3PHY_DSGCR]
 
-	/* Take DDR PHY's DLL out of bypass mode. */
-	ldr	tmp1, [r3, #DDR3PHY_PIR]
-	bic	tmp1, tmp1, #DDR3PHY_PIR_DLLBYP
-	str	tmp1, [r3, #DDR3PHY_PIR]
+	/* Enable DX DLLs. */
+	ldr	tmp1, [r3, #DDR3PHY_DX0DLLCR]
+	bic	tmp1, tmp1, #DDR3PHY_DXDLLCR_DLLDIS
+	str	tmp1, [r3, #DDR3PHY_DX0DLLCR]
+
+	ldr	tmp1, [r3, #DDR3PHY_DX1DLLCR]
+	bic	tmp1, tmp1, #DDR3PHY_DXDLLCR_DLLDIS
+	str	tmp1, [r3, #DDR3PHY_DX1DLLCR]
 
 	/* Enable quasi-dynamic programming. */
 	mov	tmp1, #0
diff --git a/include/soc/at91/sama7-ddr.h b/include/soc/at91/sama7-ddr.h
index 9e17247474fa..2706bc48c076 100644
--- a/include/soc/at91/sama7-ddr.h
+++ b/include/soc/at91/sama7-ddr.h
@@ -39,6 +39,10 @@
 
 #define DDR3PHY_ZQ0SR0				(0x188)		/* ZQ status register 0 */
 
+#define	DDR3PHY_DX0DLLCR			(0x1CC)		/* DDR3PHY DATX8 DLL Control Register */
+#define	DDR3PHY_DX1DLLCR			(0x20C)		/* DDR3PHY DATX8 DLL Control Register */
+#define		DDR3PHY_DXDLLCR_DLLDIS		(1 << 31)	/* DLL Disable */
+
 /* UDDRC */
 #define UDDRC_STAT				(0x04)		/* UDDRC Operating Mode Status Register */
 #define		UDDRC_STAT_SELFREF_TYPE_DIS	(0x0 << 4)	/* SDRAM is not in Self-refresh */
-- 
2.34.1


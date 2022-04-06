Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58804F63DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbiDFPsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbiDFPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:47:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CB03B6647;
        Wed,  6 Apr 2022 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649250311; x=1680786311;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zjf7X0lVKs4SoEyMp3osHnKJa+EJjosbh+q7mblHMAE=;
  b=DAn5I6sNtpKkbG9r/NAjWptVjxqPznJQk2IGaRuOx8XyCAAxwVml7NnM
   ySqWn8fcWul+ESpIyYStfmXsRc9RMWOIsxl+fqMG+xqSKMLkvgulQxBKB
   V8bgX9JZmaemRRrzWEhZOFTWWdoWe8+mLYxh4C/6KF/OUryHm3isx+zjT
   xt+4J3jbdzUO9N+Tsszc7cppVWse9wjOiNSbGm04RZzphMp+gav2sKAWI
   SZfteNR/au4Bhy8MjD1VKB0iAd/HuxZc5aqjJuDwmF7kfbxNFQcYsQXzE
   KuV3iIyFpgXn3Y4wvjyNZgb4XfCUlahaB/Heh3gK+9Hl8pMCdtBb2q1iy
   g==;
X-IronPort-AV: E=Sophos;i="5.90,239,1643698800"; 
   d="scan'208";a="151730482"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Apr 2022 06:05:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Apr 2022 06:05:09 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 6 Apr 2022 06:05:06 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>,
        Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama7g5ek: Align the impedance of the QSPI0's HSIO and PCB lines
Date:   Wed, 6 Apr 2022 16:05:05 +0300
Message-ID: <20220406130505.422042-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The impedance of the QSPI PCB lines on the sama7g5ek is 50 Ohms.
Align the output impedance of the QSPI0 HSIOs by setting a medium drive
strength which corresponds to an impedance of 56 Ohms when VDD is in the
3.0V - 3.6V range. The high drive strength setting corresponds to an
output impedance of 42 Ohms on the QSPI0 HSIOs.

Suggested-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama7g5ek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 08685a10eda1..8f9643170ba3 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -655,7 +655,7 @@ pinctrl_qspi: qspi {
 			 <PIN_PB21__QSPI0_INT>;
 		bias-disable;
 		slew-rate = <0>;
-		atmel,drive-strength = <ATMEL_PIO_DRVSTR_HI>;
+		atmel,drive-strength = <ATMEL_PIO_DRVSTR_ME>;
 	};
 
 	pinctrl_sdmmc0_default: sdmmc0_default {
-- 
2.25.1


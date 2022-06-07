Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733AD53F8FE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbiFGJFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbiFGJFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:05:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52832CBD40;
        Tue,  7 Jun 2022 02:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654592712; x=1686128712;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7G1aWv28grmHqE+jlxP2LzRm4Rvv2RJ0SpbrSY4E25E=;
  b=KoN1wqhY7Q81dXrfr5/BDVHtR3COs+DPHcXYz1RRPZ/bzI/5O6/FfwPf
   z0vkTPmGzvE2KshMPhuavlcT92Nh/lHwJxpJjkOuNYmeDDFYM5N8FILEL
   q+z935kFdfTJFLsg6OQ0e6tVLSDHaGXVfWczB5sM9C8KN0t2rWGD6yFxy
   yc+DphZCGTXUTKJon59IuFzgcVad7MZlV2NldiLDzvUsijZ1ZKaRu+d2Z
   XVh7R9xJZzMNrUq+ag/VJCkAXkdbAS/YwsO8Iv+eSqThX972+9q6v9W9j
   dkVxSpPYs2v6KF4Z4U2ywZO97wQpuqKomqsTzK3Cx3QLb0sfhh5glPSd8
   w==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="167384996"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2022 02:05:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 7 Jun 2022 02:05:06 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 7 Jun 2022 02:05:04 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <claudiu.beznea@microchip.com>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 1/2] ARM: dts: at91: sam9x60ek: fix eeprom compatible and size
Date:   Tue, 7 Jun 2022 12:04:54 +0300
Message-ID: <20220607090455.80433-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The board has a microchip 24aa025e48 eeprom, which is a 2 Kbits memory,
so it's compatible with at24c02 not at24c32.
Also the size property is wrong, it's not 128 bytes, but 256 bytes.
Thus removing and leaving it to the default (256).

Fixes: 1e5f532c27371 ("ARM: dts: at91: sam9x60: add device tree for soc and board")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index 7719ea3d4933c..81ccb0636a009 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -233,10 +233,9 @@ i2c0: i2c@600 {
 		status = "okay";
 
 		eeprom@53 {
-			compatible = "atmel,24c32";
+			compatible = "atmel,24c02";
 			reg = <0x53>;
 			pagesize = <16>;
-			size = <128>;
 			status = "okay";
 		};
 	};
-- 
2.25.1


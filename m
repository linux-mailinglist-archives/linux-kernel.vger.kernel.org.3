Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9A84EDB7A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbiCaONG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237342AbiCaONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:13:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453971AA4A1;
        Thu, 31 Mar 2022 07:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1648735875; x=1680271875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s14Q9frxV/DdiV00e2n8rH5uoNNzzoof8snfleEcI58=;
  b=xD+IVauBKfNNeVcAZt82mhrwq5S8MaiMyYJgD0FuoQ8lGR3DE/D7ckOR
   M5lDaEjlTwNUJjWtmcHiaDrDxXG7+iRj/aHKQGYS8BkoAJ144djmR7eSF
   3bmF6Y3SITw+pxRgbxWgRjSYc1G8Jn7MtAN7FGmAmVMueXhdG75ZBvce1
   9ffkD1ZlwOsiRD7eiKlSuViH7s1TEMF+td7xwy0e2O6thjfsT30Yn6poZ
   2rHqegfpfZ+jVk0qIjc1UA06TLSMYRvDZSEOAQODb2vcLlJpPhz4rmzwC
   fv/5Y/H66/HSYWLk4SKzyzkAgECjnkKRwmBAmsSKmwdrqLBB1H0twvqP6
   w==;
X-IronPort-AV: E=Sophos;i="5.90,225,1643698800"; 
   d="scan'208";a="158386519"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2022 07:11:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 31 Mar 2022 07:11:14 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 31 Mar 2022 07:11:12 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ajay Kathat <ajay.kathat@microchip.com>
Subject: [PATCH 2/2] ARM: dts: at91: fix pinctrl phandles
Date:   Thu, 31 Mar 2022 17:13:23 +0300
Message-ID: <20220331141323.194355-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220331141323.194355-1-claudiu.beznea@microchip.com>
References: <20220331141323.194355-1-claudiu.beznea@microchip.com>
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

Commit bf781869e5cf ("ARM: dts: at91: add pinctrl-{names, 0} for all
gpios") introduces pinctrl phandles for pins used by individual
controllers to avoid failures due to commit 2ab73c6d8323 ("gpio:
Support GPIO controllers without pin-ranges"). For SPI controllers
available on SAMA5D4 and SAMA5D3 some of the pins are defined in
SoC specific dtsi on behalf of pinctrl-0. Adding extra pinctrl phandles
on board specific dts also on behalf of pinctrl-0 overwrite the pinctrl-0
phandle specified in SoC specific dtsi. Thus add the board specific
pinctrl to pinctrl-1.

Fixes: bf781869e5cf ("ARM: dts: at91: add pinctrl-{names, 0} for all gpios")
Depends-on: e8042102d11e ("ARM: dts: at91: sama5d4_xplained: fix pinctrl phandle name")
Reported-by: Ajay Kathat <ajay.kathat@microchip.com>
Co-developed-by: Ajay Kathat <ajay.kathat@microchip.com>
Signed-off-by: Ajay Kathat <ajay.kathat@microchip.com>
Tested-by: Ajay Kathat <ajay.kathat@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi, Nicolas,

If all good with this patches please update the SHA1 on "Depends-on"
tag.

Thank you,
Claudiu Beznea

 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 8 ++++----
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index d72c042f2850..a49c2966b41e 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -57,8 +57,8 @@ slot@0 {
 			};
 
 			spi0: spi@f0004000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_spi0_cs>;
+				pinctrl-names = "default", "cs";
+				pinctrl-1 = <&pinctrl_spi0_cs>;
 				cs-gpios = <&pioD 13 0>, <0>, <0>, <&pioD 16 0>;
 				status = "okay";
 			};
@@ -171,8 +171,8 @@ slot@0 {
 			};
 
 			spi1: spi@f8008000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_spi1_cs>;
+				pinctrl-names = "default", "cs";
+				pinctrl-1 = <&pinctrl_spi1_cs>;
 				cs-gpios = <&pioC 25 0>;
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index accb92cfac44..e519d2747936 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -81,8 +81,8 @@ usart4: serial@fc010000 {
 			};
 
 			spi1: spi@fc018000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_spi1_cs>;
+				pinctrl-names = "default", "cs";
+				pinctrl-1 = <&pinctrl_spi1_cs>;
 				cs-gpios = <&pioB 21 0>;
 				status = "okay";
 			};
-- 
2.32.0


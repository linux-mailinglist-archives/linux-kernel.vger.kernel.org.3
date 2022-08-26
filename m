Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527855A232A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343754AbiHZIiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241853AbiHZIhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:37:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AD7D2E8A;
        Fri, 26 Aug 2022 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661503056; x=1693039056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v/GMC8+uXpbJ05sehOG56CNutF0wXIfUIa6mE5Vt65Y=;
  b=Q6MxTT9EmDA6Bywn7OyxNvawqbqjVTh15P430xTCtHO2N1Ok3GhPaD84
   zp2vK58zOkjB6lQtPiatcpfqc4VX8IsNwfyZ+TL1ULdsWNI+T9ZIplfob
   IbYKUeo+lgdOa42EhCsdIApGOKeMuGKkp6OIrhT4vQ923DClnwvF019aK
   GIUDr73okpnBRPKkF5tLqWyMnUrhBpyopzeTId4X4OOF3juKC0EPavrl5
   wNhN0TCGRqX0QdHpzEtIumjUkDX6jUCxJ0Vm0tw5nB/mAg4H35Jv8BE1K
   fuBrYVn/Q5jt52JRS2eBQK5wAb9F5J55Dro+ZmC+RFZ0V8kBrAPvqKIP5
   w==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="188164749"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 01:37:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 01:37:33 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 26 Aug 2022 01:37:30 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux@armlinux.org.uk>,
        <arnd@arndb.de>
CC:     <cristian.birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 9/9] ARM: dts: at91: sam9x60ek: remove simple-bus for regulators
Date:   Fri, 26 Aug 2022 11:39:27 +0300
Message-ID: <20220826083927.3107272-10-claudiu.beznea@microchip.com>
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

Keep regulators as individual devices. There is no need to have them
under simple bus. This will throw compilation warnings like:
- unnecessary #address-cells/#size-cells without "ranges" or child "reg"
property.
- node has a unit name, but no reg or ranges property.

While at it move it down a bit in the file to keep entries sorted
alphabetically.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts | 78 +++++++++++++---------------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index 81c38e101f58..7ade9979e1c6 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -34,48 +34,6 @@ main_xtal {
 		};
 	};
 
-	regulators: regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		vdd_1v8: fixed-regulator-vdd_1v8@0 {
-			compatible = "regulator-fixed";
-			regulator-name = "VDD_1V8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-			status = "okay";
-		};
-
-		vdd_1v15: fixed-regulator-vdd_1v15@1 {
-			compatible = "regulator-fixed";
-			regulator-name = "VDD_1V15";
-			regulator-min-microvolt = <1150000>;
-			regulator-max-microvolt = <1150000>;
-			regulator-always-on;
-			status = "okay";
-		};
-
-		vdd1_3v3: fixed-regulator-vdd1_3v3@2 {
-			compatible = "regulator-fixed";
-			regulator-name = "VDD1_3V3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-			status = "okay";
-		};
-
-		vdd2_3v3: regulator-fixed-vdd2_3v3@3 {
-			compatible = "regulator-fixed";
-			regulator-name = "VDD2_3V3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-			status = "okay";
-		};
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -111,6 +69,42 @@ blue {
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	vdd_1v8: fixed-regulator-vdd_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		status = "okay";
+	};
+
+	vdd_1v15: fixed-regulator-vdd_1v15 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_1V15";
+		regulator-min-microvolt = <1150000>;
+		regulator-max-microvolt = <1150000>;
+		regulator-always-on;
+		status = "okay";
+	};
+
+	vdd1_3v3: fixed-regulator-vdd1_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD1_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		status = "okay";
+	};
+
+	vdd2_3v3: regulator-fixed-vdd2_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD2_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		status = "okay";
+	};
 };
 
 &adc {
-- 
2.34.1


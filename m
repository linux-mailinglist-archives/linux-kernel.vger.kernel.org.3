Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D299E5A2330
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245330AbiHZIhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245555AbiHZIhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:37:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710B6C2E88;
        Fri, 26 Aug 2022 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661503043; x=1693039043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K/P6g0z1JGf/ROJm+c80WS5FiI62rI1DdtOdiWRQSxs=;
  b=YcFs0w9lx0Vjp+dlABW9n/JvMSaQoa9zJNFHeGnD8buXVxoEKvmpF7l1
   J//cvmwLdKufvMb4M1ujppvmM2xoeZdCe8jtxYRRmdlaiHBAsW0bFOZKY
   pe8u2nyilzH7cdxQxwlmF7nHry2BsSOGu1yXJbLReVoinforgvYBvTyOF
   bd1zq4g1aUka6WsSG2QUF9wUtA2B8VQt+g4BaYEhUKfabrFUelLgndq8d
   czQtVBi8eqQpsrnQivVZQyvzC/6Du2TOubWLTLyiLZNNzSCoWxQoEtY1Q
   kItWhhtn5M1MqGa7Tz57+CXl24aZ4YaYqTL3FmIvDqgaj89GI+D82YnH2
   g==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="171082251"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 01:37:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 01:37:19 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 26 Aug 2022 01:37:16 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux@armlinux.org.uk>,
        <arnd@arndb.de>
CC:     <cristian.birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/9] ARM: dts: at91: sama5d27_wlsom1: specify proper regulator output ranges
Date:   Fri, 26 Aug 2022 11:39:22 +0300
Message-ID: <20220826083927.3107272-5-claudiu.beznea@microchip.com>
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

Min and max output ranges of regulators need to satisfy board
requirements not PMIC requirements. Thus adjust device tree to
cope with this.

Fixes: 5d4c3cfb63fe ("ARM: dts: at91: sama5d27_wlsom1: add SAMA5D27 wlsom1 and wlsom1-ek")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
index 76b2025c67b4..342fcfd974d7 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
@@ -76,8 +76,8 @@ mcp16502@5b {
 		regulators {
 			vdd_3v3: VDD_IO {
 				regulator-name = "VDD_IO";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3700000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-initial-mode = <2>;
 				regulator-allowed-modes = <2>, <4>;
 				regulator-always-on;
@@ -95,8 +95,8 @@ regulator-state-mem {
 
 			vddio_ddr: VDD_DDR {
 				regulator-name = "VDD_DDR";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <1850000>;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
 				regulator-initial-mode = <2>;
 				regulator-allowed-modes = <2>, <4>;
 				regulator-always-on;
@@ -118,8 +118,8 @@ regulator-state-mem {
 
 			vdd_core: VDD_CORE {
 				regulator-name = "VDD_CORE";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <1850000>;
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <1250000>;
 				regulator-initial-mode = <2>;
 				regulator-allowed-modes = <2>, <4>;
 				regulator-always-on;
@@ -160,8 +160,8 @@ regulator-state-mem {
 
 			LDO1 {
 				regulator-name = "LDO1";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3700000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 
 				regulator-state-standby {
@@ -175,8 +175,8 @@ regulator-state-mem {
 
 			LDO2 {
 				regulator-name = "LDO2";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3700000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 
 				regulator-state-standby {
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18295354B6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348961AbiEZUl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348978AbiEZUlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:41:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A462110E7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:41:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q21so5186800ejm.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JYlyUwzREUNvRvRdW1unCJB/bTykeKPCc9bWUs+mR5A=;
        b=nhajAlpe0bqUqLLxJ0vOoSfaBz6aGVR93nZmbJM5g4tix3gVZWIPXayrPIsZFsEeak
         hMaw8CRDZUAMwl4tuiCTkvdAbBAyrowELIhY9p2fNL59YTple5rYZolQgPgUGwQFM25A
         bJL4nT8dIyXMIr0d0t66hb1wLNrY0Wr73CWiIxKGJvG2/ht2RKCzPj0DrnMUFp+jv1g4
         4t+Zuz3QRNCvznmE6df947DZmpyg7+R9PMv/KyrMlnoyhYqpgIu7fKcyVWBlYJpm7dUq
         fICLlXkJfHuZ0Bg1QsZw+3ALJIKmWRInd5OGFvd8Nn5VasL2aM1IimrtAb2WxCs478EL
         0b7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JYlyUwzREUNvRvRdW1unCJB/bTykeKPCc9bWUs+mR5A=;
        b=Jiw/KFR9BSXiEAS7b64fsL2/5mXfih8+xMjJm5Yyp1rxTfZeCZW48lO89uNSc9Gq2A
         jZd3ot44Lu2vN2uQ8rjjHplhE8mwH++0W9jvQVkdmUGHpXk4AfC4hmH5cGA8F8Oykw87
         tRGo37Sqd0Ep7HJba5XNz9ts73aszTInKMIzMpx/qEarZ6VuJX//280TqlKh7L5JQKIT
         LVboiaTRwIhSd8/OMQASYTQiurzNN79aPrUWIN0R2fbqOhQpsgOlK2YCg7iZzgo7ni5d
         Yp06OcVW+Mq5fGxFmAHXAYLm/318AXo1gADuaF7iHk0b940CPve/u1NFn0AuaCjwKnuE
         q7Mg==
X-Gm-Message-State: AOAM533uIbTP4MLqWEAsB/YYC13lhGCLgSbleAEQwG/JBqkpo5m/3M1o
        qU+P4RdJFVdSaShe06RqLHA7zg==
X-Google-Smtp-Source: ABdhPJwghLTccJKPCETF/TdyGeU6B1fjR+weGIEUCbTgEK8EHIHOQI2Rnwnbw3r1jqWW1gGxq2tQEw==
X-Received: by 2002:a17:906:5d12:b0:6ff:2504:f732 with SMTP id g18-20020a1709065d1200b006ff2504f732mr4288075ejt.576.1653597704305;
        Thu, 26 May 2022 13:41:44 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l11-20020a170906a40b00b006f3ef214ddbsm829547ejz.65.2022.05.26.13.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:41:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] arm64: dts: ti: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:41:36 +0200
Message-Id: <20220526204139.831895-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi           |  4 ++--
 arch/arm64/boot/dts/ti/k3-am625-sk.dts             |  2 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |  4 ++--
 arch/arm64/boot/dts/ti/k3-am642-evm.dts            |  2 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts             |  2 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi |  4 ++--
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           | 14 +++++++-------
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         |  4 ++--
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |  4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    |  4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |  4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         |  4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi   |  4 ++--
 13 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index d08abad0bcf4..df3b9883e887 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -144,8 +144,8 @@ dmsc: system-controller@44043000 {
 		compatible = "ti,k2g-sci";
 		ti,host-id = <12>;
 		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 12>,
-			<&secure_proxy_main 13>;
+		mboxes = <&secure_proxy_main 12>,
+			 <&secure_proxy_main 13>;
 		reg-names = "debug_messages";
 		reg = <0x00 0x44043000 0x00 0xfe0>;
 
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 39fb1d763037..d0c3128fa036 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -13,7 +13,7 @@
 #include "k3-am625.dtsi"
 
 / {
-	compatible =  "ti,am625-sk", "ti,am625";
+	compatible = "ti,am625-sk", "ti,am625";
 	model = "Texas Instruments AM625 SK";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index f64b368c6c37..862e6c166c92 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -174,7 +174,7 @@ dmsc: system-controller@44043000 {
 		compatible = "ti,k2g-sci";
 		ti,host-id = <12>;
 		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 12>,
+		mboxes = <&secure_proxy_main 12>,
 			<&secure_proxy_main 13>;
 		reg-names = "debug_messages";
 		reg = <0x00 0x44043000 0x00 0xfe0>;
@@ -1303,7 +1303,7 @@ main_mcan1: can@20711000 {
 		      <0x00 0x20718000 0x00 0x8000>;
 		reg-names = "m_can", "message_ram";
 		power-domains = <&k3_pds 99 TI_SCI_PD_EXCLUSIVE>;
-		clocks =  <&k3_clks 99 5>, <&k3_clks 99 0>;
+		clocks = <&k3_clks 99 5>, <&k3_clks 99 0>;
 		clock-names = "hclk", "cclk";
 		interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 8e7893e58b03..ad150c704623 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -13,7 +13,7 @@
 #include "k3-am642.dtsi"
 
 / {
-	compatible =  "ti,am642-evm", "ti,am642";
+	compatible = "ti,am642-evm", "ti,am642";
 	model = "Texas Instruments AM642 EVM";
 
 	chosen {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 59f506cbd275..64eed5456721 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -12,7 +12,7 @@
 #include "k3-am642.dtsi"
 
 / {
-	compatible =  "ti,am642-sk", "ti,am642";
+	compatible = "ti,am642-sk", "ti,am642";
 	model = "Texas Instruments AM642 SK";
 
 	chosen {
diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 6e41f2fa044a..32b797237581 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -425,7 +425,7 @@ &mcu_i2c0 {
 
 	psu: regulator@60 {
 		compatible = "ti,tps62363";
-		reg =  <0x60>;
+		reg = <0x60>;
 		regulator-name = "tps62363-vout";
 		regulator-min-microvolt = <500000>;
 		regulator-max-microvolt = <1500000>;
@@ -574,7 +574,7 @@ &mcu_spi0 {
 	pinctrl-0 = <&mcu_spi0_pins_default>;
 
 	#address-cells = <1>;
-	#size-cells= <0>;
+	#size-cells = <0>;
 	ti,pindir-d0-out-d1-in;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index e749343acced..8919fede3cd7 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -690,7 +690,7 @@ main_gpio1: gpio@601000 {
 
 	pcie0_rc: pcie@5500000 {
 		compatible = "ti,am654-pcie-rc";
-		reg =  <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x2000>, <0x0 0x5506000 0x0 0x1000>;
+		reg = <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x2000>, <0x0 0x5506000 0x0 0x1000>;
 		reg-names = "app", "dbics", "config", "atu";
 		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <3>;
@@ -710,7 +710,7 @@ pcie0_rc: pcie@5500000 {
 
 	pcie0_ep: pcie-ep@5500000 {
 		compatible = "ti,am654-pcie-ep";
-		reg =  <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x8000000>, <0x0 0x5506000 0x0 0x1000>;
+		reg = <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x8000000>, <0x0 0x5506000 0x0 0x1000>;
 		reg-names = "app", "dbics", "addr_space", "atu";
 		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
 		ti,syscon-pcie-mode = <&pcie0_mode>;
@@ -723,7 +723,7 @@ pcie0_ep: pcie-ep@5500000 {
 
 	pcie1_rc: pcie@5600000 {
 		compatible = "ti,am654-pcie-rc";
-		reg =  <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x2000>, <0x0 0x5606000 0x0 0x1000>;
+		reg = <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x2000>, <0x0 0x5606000 0x0 0x1000>;
 		reg-names = "app", "dbics", "config", "atu";
 		power-domains = <&k3_pds 121 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <3>;
@@ -743,7 +743,7 @@ pcie1_rc: pcie@5600000 {
 
 	pcie1_ep: pcie-ep@5600000 {
 		compatible = "ti,am654-pcie-ep";
-		reg =  <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x4000000>, <0x0 0x5606000 0x0 0x1000>;
+		reg = <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x4000000>, <0x0 0x5606000 0x0 0x1000>;
 		reg-names = "app", "dbics", "addr_space", "atu";
 		power-domains = <&k3_pds 121 TI_SCI_PD_EXCLUSIVE>;
 		ti,syscon-pcie-mode = <&pcie1_mode>;
@@ -843,9 +843,9 @@ dss: dss@4a00000 {
 
 		power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
 
-		clocks =	<&k3_clks 67 1>,
-				<&k3_clks 216 1>,
-				<&k3_clks 67 2>;
+		clocks = <&k3_clks 67 1>,
+			 <&k3_clks 216 1>,
+			 <&k3_clks 67 2>;
 		clock-names = "fck", "vp1", "vp2";
 
 		/*
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index 9c69d0917f69..fa11d7142006 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -12,8 +12,8 @@ dmsc: system-controller@44083000 {
 
 		mbox-names = "rx", "tx";
 
-		mboxes= <&secure_proxy_main 11>,
-			<&secure_proxy_main 13>;
+		mboxes = <&secure_proxy_main 11>,
+			 <&secure_proxy_main 13>;
 
 		reg-names = "debug_messages";
 		reg = <0x44083000 0x1000>;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 57497cb1ed68..f65f31e1ff2a 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -10,7 +10,7 @@
 #include <dt-bindings/net/ti-dp83867.h>
 
 / {
-	compatible =  "ti,am654-evm", "ti,am654";
+	compatible = "ti,am654-evm", "ti,am654";
 	model = "Texas Instruments AM654 Base Board";
 
 	chosen {
@@ -330,7 +330,7 @@ &main_spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_spi0_pins_default>;
 	#address-cells = <1>;
-	#size-cells= <0>;
+	#size-cells = <0>;
 	ti,pindir-d0-out-d1-in;
 
 	flash@0 {
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 1044ec6c4b0d..ff13bbeed30c 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -12,8 +12,8 @@ dmsc: system-controller@44083000 {
 
 		mbox-names = "rx", "tx";
 
-		mboxes= <&secure_proxy_main 11>,
-			<&secure_proxy_main 13>;
+		mboxes = <&secure_proxy_main 11>,
+			 <&secure_proxy_main 13>;
 
 		reg-names = "debug_messages";
 		reg = <0x00 0x44083000 0x00 0x1000>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index b4972dfb7da8..df08724bbf1c 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -12,8 +12,8 @@ dmsc: system-controller@44083000 {
 
 		mbox-names = "rx", "tx";
 
-		mboxes= <&secure_proxy_main 11>,
-			<&secure_proxy_main 13>;
+		mboxes = <&secure_proxy_main 11>,
+			 <&secure_proxy_main 13>;
 
 		reg-names = "debug_messages";
 		reg = <0x00 0x44083000 0x0 0x1000>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index be7f39299894..ff1602bff2af 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -320,7 +320,7 @@ main_sdhci0: mmc@4f80000 {
 		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&k3_pds 98 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 98 7>, <&k3_clks 98 1>;
-		clock-names =  "clk_ahb", "clk_xin";
+		clock-names = "clk_ahb", "clk_xin";
 		assigned-clocks = <&k3_clks 98 1>;
 		assigned-clock-parents = <&k3_clks 98 2>;
 		bus-width = <8>;
@@ -347,7 +347,7 @@ main_sdhci1: mmc@4fb0000 {
 		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&k3_pds 99 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 99 8>, <&k3_clks 99 1>;
-		clock-names =  "clk_ahb", "clk_xin";
+		clock-names = "clk_ahb", "clk_xin";
 		assigned-clocks = <&k3_clks 99 1>;
 		assigned-clock-parents = <&k3_clks 99 2>;
 		bus-width = <4>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 6c5c02edb375..4d1bfabd1313 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -12,8 +12,8 @@ sms: system-controller@44083000 {
 
 		mbox-names = "rx", "tx";
 
-		mboxes= <&secure_proxy_main 11>,
-			<&secure_proxy_main 13>;
+		mboxes = <&secure_proxy_main 11>,
+			 <&secure_proxy_main 13>;
 
 		reg-names = "debug_messages";
 		reg = <0x00 0x44083000 0x00 0x1000>;
-- 
2.34.1


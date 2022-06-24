Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3179A5595F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiFXJCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiFXJB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:01:58 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F35403D2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:01:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z9so902562wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYqi+SGcB0+t2X+VYlC5fZRvt40T3yhMiNazUS1RDXg=;
        b=KTYM3gqN0dbVx0MMpORszENXRVGhqUN/bTd+qbPxDHuW4jPEtauSJwiVkn98ROISpr
         idy6ijgKO6qKA0rE95x5zivQtOETae5BhPw1v4j0c646Qc/6i3unmDqArgdPI4e9hLoI
         MN7bC75nrHoxtLMWdIi+tXEHI52cjL61npeOLG1TP5owvNFkVxOdSauASv73mvfrKQoq
         C9GYBei1j3zCBHlu99Mgwc9i+BZdlSqTur0naohCBXLYYvvI6PddLqqEsIKEJG737wjB
         bE3EmaCI6ft4CWSLe+XkdpKbapkmLgcd/j3BheqsousuJcAcVv1ZysNs4ymDF0mTouMn
         NcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYqi+SGcB0+t2X+VYlC5fZRvt40T3yhMiNazUS1RDXg=;
        b=kZmLaTK/S1ZwWVp1B3N3cMlEM8R/dFOE/lltthC4LdMvR2CySPeNJ93dyIBVI5dOgl
         KOHGgIHNxw8FRvFE1zNI/xvW+DbGN3ucaIpSbDJ5RZS5zxnh8dFvE9wCqcSvQE0Z055Y
         zoZQDpadPKXYqHwKqdnTxuVYOho2X0a0auldFUtSDAE8o6N9cnJSKKRDT8i8ei6INjOD
         WbuctPHNAzTozI9soOKej3jzGFFNtRrzR/U+dFnQ+fl9i1OP3oVSXnf7xurZXRzagNyV
         2yf1EL0F/7EdYJXXIUl0e+yuODmPKmrMw5NICnBkUx1vf8LDYfZPMJEA35nEVEHkBIe6
         zVBA==
X-Gm-Message-State: AJIora+LZd9jxPgiBBpD+c+kTfcluZGkL0BxHZ3U8eWgvh/phwmzlEpT
        mLzAFL7iylWMYHd3v/s8+3lk8+39ga+Xwpqp
X-Google-Smtp-Source: AGRyM1vJblVpTyNWcE6m4PbaUdDUJM1SUYRY98T5uH//0OhEeRyez3qBnHqTgu2Krcaa4KOZaxCo9A==
X-Received: by 2002:a05:600c:3b1f:b0:3a0:2f82:7d6b with SMTP id m31-20020a05600c3b1f00b003a02f827d6bmr2476743wms.3.1656061315059;
        Fri, 24 Jun 2022 02:01:55 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:11eb:7fe2:cb1a:9cd7:1545:5dfc])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c1c0900b0039c7f790f6asm6717084wms.30.2022.06.24.02.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 02:01:54 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH] ARM: dts: stm32: fix pwr regulators references to use scmi
Date:   Fri, 24 Jun 2022 11:00:55 +0200
Message-Id: <20220624090055.569400-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes stm32mp15*-scmi DTS files introduced in [1] to also access PWR
regulators through SCMI service. This is needed since enabling secure
only access to RCC clock and reset controllers also enables secure
access only on PWR voltage regulators reg11, reg18 and usb33 hence
these must also be accessed through SCMI Voltage Domain protocol.
This change applies on commit [2] that already corrects issues from
commit [1].

Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Link: [1] https://lore.kernel.org/linux-arm-kernel/20220422150952.20587-7-alexandre.torgue@foss.st.com
Link: [2] https://lore.kernel.org/linux-arm-kernel/20220613071920.5463-1-alexandre.torgue@foss.st.com
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 arch/arm/boot/dts/stm32mp15-scmi.dtsi      | 52 ++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts |  1 +
 arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts |  1 +
 3 files changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp15-scmi.dtsi b/arch/arm/boot/dts/stm32mp15-scmi.dtsi
index e90cf3acd0b3..d2afb6667479 100644
--- a/arch/arm/boot/dts/stm32mp15-scmi.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-scmi.dtsi
@@ -27,6 +27,37 @@ scmi_reset: protocol@16 {
 				reg = <0x16>;
 				#reset-cells = <1>;
 			};
+
+			scmi_voltd: protocol@17 {
+				reg = <0x17>;
+
+				scmi_reguls: regulators {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					scmi_reg11: reg11@0 {
+						reg = <0>;
+						regulator-name = "reg11";
+						regulator-min-microvolt = <1100000>;
+						regulator-max-microvolt = <1100000>;
+					};
+
+					scmi_reg18: reg18@1 {
+						voltd-name = "reg18";
+						reg = <1>;
+						regulator-name = "reg18";
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+					};
+
+					scmi_usb33: usb33@2 {
+						reg = <2>;
+						regulator-name = "usb33";
+						regulator-min-microvolt = <3300000>;
+						regulator-max-microvolt = <3300000>;
+					};
+				};
+			};
 		};
 	};
 
@@ -45,3 +76,24 @@ scmi_shm: scmi-sram@0 {
 		};
 	};
 };
+
+&reg11 {
+	status = "disabled";
+};
+
+&reg18 {
+	status = "disabled";
+};
+
+&usb33 {
+	status = "disabled";
+};
+
+&usbotg_hs {
+	usb33d-supply = <&scmi_usb33>;
+};
+
+&usbphyc {
+	vdda1v1-supply = <&scmi_reg11>;
+	vdda1v8-supply = <&scmi_reg18>;
+};
diff --git a/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts b/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
index 03226a596904..97e4f94b0a24 100644
--- a/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
+++ b/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
@@ -35,6 +35,7 @@ &cryp1 {
 };
 
 &dsi {
+	phy-dsi-supply = <&scmi_reg18>;
 	clocks = <&rcc DSI_K>, <&scmi_clk CK_SCMI_HSE>, <&rcc DSI_PX>;
 };
 
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts b/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
index 7842384ddbe4..3b9dd6f4ccc9 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
@@ -36,6 +36,7 @@ &cryp1 {
 };
 
 &dsi {
+	phy-dsi-supply = <&scmi_reg18>;
 	clocks = <&rcc DSI_K>, <&scmi_clk CK_SCMI_HSE>, <&rcc DSI_PX>;
 };
 
-- 
2.25.1


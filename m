Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DACD50FF65
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351122AbiDZNpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351064AbiDZNpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:45:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507E9632E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:41:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e2so19259455wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ukJ87PJJQr6WdcFY9U3LOip92CMRk0OSZz5wfX1gBdA=;
        b=kDrmXa+2sq1U9qBMrPJIHx1jotVEcR5D8DKEmsoYwJTXjPNPSRpDulPjvcWztnPFu2
         /dLv84homwh9Uhhqm7+xW2eZY0+Cy+GyNKnGRrACDhnMJLE79ZjBv25ni9Qbgb1P+6/A
         n3WEDDRKRcsStS6hWTAcGEwRUxmvVV9CqJXZa3Nth/Vjmlo5vPmJ9ZtDlaOPBYvBtsSV
         GVM17O6tMCHLlc89ZREHueAsj9aHBW0YiSoS8sVj5gzPfZdueg/vSIOY4IHKY5ouT4FH
         IZVzPCpH6zC4F52l+51ldnrcYRBjCkTm6jL1HvnWuj4HI8Tz+GjdLQog46RZ+kQ8Owvi
         pspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukJ87PJJQr6WdcFY9U3LOip92CMRk0OSZz5wfX1gBdA=;
        b=MmPZPcVAX+O6vONLnB4n3/NJK2Ee5NAfflFbBdGe2L6PnLMaYJc1xEjdGXK6QIgP0q
         KLXL7LjvR06snAcfY8glpoYQ+HB5k7NxkSSO24Ph4VRYKMUoo1Ah4TFotUQs48nP9oy2
         r+4ySpnpFdG0cZYfYBcscEhEKsztEDVPVWnuhAv4wvjY2WCF2U0yd7Fxq/BqQwtbnpNk
         7dF8LNHtUMroXeb/oVXxpH4OLVWE9fLtkSEVFf+VJu3et1tFXr+MYmAJfXhuO93GrqIX
         /3zM/XTCxStsPmamHitDqMTyQ7oNmMxhUqi9J2i7sIatEgxRbBRO3lXVBtKoSk9FpSH9
         LTaw==
X-Gm-Message-State: AOAM531TqQJwvgoRbSzwNzPR7wDOltT9hfBkhPIKkhJo5pqItfvb6Rm2
        Cpc4ellLy28fgUJRaFbXLKMP8g==
X-Google-Smtp-Source: ABdhPJyPVIr76v3m+QAnFXrUZyRfsJs85pAn0hlzBhRMa5PgGJw8PZlDVyZ0amQ+ifKJB0syMBrC5g==
X-Received: by 2002:a05:6000:114d:b0:20a:d608:5e54 with SMTP id d13-20020a056000114d00b0020ad6085e54mr12139126wrx.539.1650980511758;
        Tue, 26 Apr 2022 06:41:51 -0700 (PDT)
Received: from radium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id b6-20020adfd1c6000000b0020aac8a9946sm13628475wrd.47.2022.04.26.06.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:41:51 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Biao Huang <biao.huang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] arm64: dts: mediatek: mt8195-evb: enable ethernet
Date:   Tue, 26 Apr 2022 15:41:02 +0200
Message-Id: <20220426134106.242353-5-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426134106.242353-1-fparent@baylibre.com>
References: <20220426134106.242353-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biao Huang <biao.huang@mediatek.com>

Add ethernet support for MT8195 EVB.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
This patch comes from https://lore.kernel.org/all/20211207015505.16746-7-biao.huang@mediatek.com/

The differences between that patch and this patch is that:
* The EVB dts modification has been split into its own commit
* The patch was rebased to fix merge conflict with the upstream mt8195-evb.dts file
* Re-ordered the node to be correctly sorted based on phandle name 
* Re-ordered the pins for the pinctrl to be sorted by node name
* Fixed dtbs_check: use - instead of _ in node names + prefix pins node with pins-

 arch/arm64/boot/dts/mediatek/mt8195-evb.dts | 90 +++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
index d49ae8605e67..0b04421942ac 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
@@ -5,6 +5,7 @@
  */
 /dts-v1/;
 #include "mt8195.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "MediaTek MT8195 evaluation board";
@@ -28,6 +29,29 @@ &auxadc {
 	status = "okay";
 };
 
+&eth {
+	phy-mode ="rgmii-rxid";
+	phy-handle = <&eth_phy0>;
+	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
+	snps,reset-delays-us = <0 10000 10000>;
+	mediatek,tx-delay-ps = <2030>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&eth_default_pins>;
+	pinctrl-1 = <&eth_sleep_pins>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		eth_phy0: eth_phy0@1 {
+			compatible = "ethernet-phy-id001c.c916";
+			#phy-cells = <0>;
+			reg = <0x1>;
+		};
+	};
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pin>;
@@ -69,6 +93,72 @@ flash@0 {
 };
 
 &pio {
+	eth_default_pins: eth-default-pins {
+		pins-cc {
+			pinmux = <PINMUX_GPIO85__FUNC_GBE_TXC>,
+				 <PINMUX_GPIO88__FUNC_GBE_TXEN>,
+				 <PINMUX_GPIO87__FUNC_GBE_RXDV>,
+				 <PINMUX_GPIO86__FUNC_GBE_RXC>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+		pins-mdio {
+			pinmux = <PINMUX_GPIO89__FUNC_GBE_MDC>,
+				 <PINMUX_GPIO90__FUNC_GBE_MDIO>;
+			input-enable;
+		};
+		pins-power {
+			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
+				 <PINMUX_GPIO92__FUNC_GPIO92>;
+			output-high;
+		};
+		pins-rxd {
+			pinmux = <PINMUX_GPIO81__FUNC_GBE_RXD3>,
+				 <PINMUX_GPIO82__FUNC_GBE_RXD2>,
+				 <PINMUX_GPIO83__FUNC_GBE_RXD1>,
+				 <PINMUX_GPIO84__FUNC_GBE_RXD0>;
+		};
+		pins-txd {
+			pinmux = <PINMUX_GPIO77__FUNC_GBE_TXD3>,
+				 <PINMUX_GPIO78__FUNC_GBE_TXD2>,
+				 <PINMUX_GPIO79__FUNC_GBE_TXD1>,
+				 <PINMUX_GPIO80__FUNC_GBE_TXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+	};
+
+	eth_sleep_pins: eth-sleep-pins {
+		pins-cc {
+			pinmux = <PINMUX_GPIO85__FUNC_GPIO85>,
+				 <PINMUX_GPIO88__FUNC_GPIO88>,
+				 <PINMUX_GPIO87__FUNC_GPIO87>,
+				 <PINMUX_GPIO86__FUNC_GPIO86>;
+		};
+		pins-mdio {
+			pinmux = <PINMUX_GPIO89__FUNC_GPIO89>,
+				 <PINMUX_GPIO90__FUNC_GPIO90>;
+			input-disable;
+			bias-disable;
+		};
+		pins-power {
+			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
+				 <PINMUX_GPIO92__FUNC_GPIO92>;
+			input-disable;
+			bias-disable;
+		};
+		pins-rxd {
+			pinmux = <PINMUX_GPIO81__FUNC_GPIO81>,
+				 <PINMUX_GPIO82__FUNC_GPIO82>,
+				 <PINMUX_GPIO83__FUNC_GPIO83>,
+				 <PINMUX_GPIO84__FUNC_GPIO84>;
+		};
+		pins-txd {
+			pinmux = <PINMUX_GPIO77__FUNC_GPIO77>,
+				 <PINMUX_GPIO78__FUNC_GPIO78>,
+				 <PINMUX_GPIO79__FUNC_GPIO79>,
+				 <PINMUX_GPIO80__FUNC_GPIO80>;
+		};
+	};
+
 	i2c0_pin: i2c0-pins {
 		pins {
 			pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
-- 
2.36.0


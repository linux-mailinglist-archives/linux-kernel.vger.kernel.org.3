Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DB250FF6D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351117AbiDZNpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351067AbiDZNpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:45:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6469A3CFF7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:41:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x18so25590905wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K24pI48bckEH3Y3oSHXKjeqIQ2pS3pf+1QNVp3L1AGk=;
        b=i08Wa0+I8vFqudmLcKEpFUrwdRPyrrmNGYg9ArqPlVQA/tJVlnOobY+g4E4P6S+h3a
         R1H604yOHa5tAQ3PBTVTS74d67hDZNWH9/AIcx/LeoAfVE1+xz9gbna3tKAl4ojTqdvq
         5fCqS2TFR6WdzG6e8JXN9436Js/xK4YQo7zWW80kJ8mIGzxu4Cb/qoBOHtrUib3MC59c
         3hQLeOBI8OdAsq1BY9dLfVUcN2r1t/hSwEcGDfZKGuR+c38WYBj86mt3jqhVHs3DVfQk
         L3Mh3OG2rE0gkT0QyrpsxkNvQWBHAkNCFjUOHP/4M5fy+CvoarAXjTvWpO8ZE4i5CKcS
         bvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K24pI48bckEH3Y3oSHXKjeqIQ2pS3pf+1QNVp3L1AGk=;
        b=Yd/cNYh5dek0o3BpKVvfoeqF4dHakoVXtbfUBTh/wbAeb1C2ryY1Px13gpq5PAHtbP
         9030AGUqlpMx7VAUM/RR/+Tk1fxI1mUYymuzxuJDk2ccZUtc6Xo5rqZM2cQ3PVpotWrc
         HARb9w4EDlFUCg5ERTqNZUb/4Xia+99/i5LlS+TS6PyWnlTXGwsECPpOhsDRXLxJarBq
         EYPHS/NXPakshZu1PymuPuBTQ7P+EWltaY5ucsZMY05uUGt17gHhFXPsS/UkbKDOCNJn
         bHRDGkVXYFvPmblVxvb87J9Odn4Wpv1xaqcoGYyn6utz6NY2R3z1z4r+53RDp86rvD05
         CJmA==
X-Gm-Message-State: AOAM5309f2X/uDkj5Sw9R3HoCgQtUvFLPSHEsqQ2KHjkx0iNSI8zgW2M
        mwC6CJtfmOL2Kc0ke1cSOmJ7Yw==
X-Google-Smtp-Source: ABdhPJwTqjD7xukDeJkwtYT17PIwAxavld4VVDUXrUeGccOnlqTLBHELXQALY+5oCYTdLFIgdPaRCg==
X-Received: by 2002:a5d:6301:0:b0:205:cb42:74a5 with SMTP id i1-20020a5d6301000000b00205cb4274a5mr18242860wru.385.1650980513022;
        Tue, 26 Apr 2022 06:41:53 -0700 (PDT)
Received: from radium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id b6-20020adfd1c6000000b0020aac8a9946sm13628475wrd.47.2022.04.26.06.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:41:52 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] arm64: dts: mediatek: mt8195-demo: enable ethernet
Date:   Tue, 26 Apr 2022 15:41:03 +0200
Message-Id: <20220426134106.242353-6-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426134106.242353-1-fparent@baylibre.com>
References: <20220426134106.242353-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ethernet on the MT8195 demo board.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 108 +++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index 08cab3b3943b..0b7985486e2a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -80,6 +80,30 @@ optee_reserved: optee@43200000 {
 	};
 };
 
+&eth {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&eth_phy>;
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
+
+		eth_phy: phy@1 {
+			compatible = "ethernet-phy-id001c.c916";
+			#phy-cells = <0>;
+			reg = <0x1>;
+		};
+	};
+};
+
 &i2c6 {
 	clock-frequency = <400000>;
 	pinctrl-0 = <&i2c6_pins>;
@@ -260,6 +284,90 @@ &mt6359_vsram_others_ldo_reg {
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
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO89__FUNC_GBE_MDC>,
+				 <PINMUX_GPIO90__FUNC_GBE_MDIO>;
+			input-enable;
+		};
+
+		pins-phy-reset {
+			pinmux = <PINMUX_GPIO93__FUNC_GPIO93>;
+		};
+
+		pins-power {
+			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
+				 <PINMUX_GPIO92__FUNC_GPIO92>;
+			output-high;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO81__FUNC_GBE_RXD3>,
+				 <PINMUX_GPIO82__FUNC_GBE_RXD2>,
+				 <PINMUX_GPIO83__FUNC_GBE_RXD1>,
+				 <PINMUX_GPIO84__FUNC_GBE_RXD0>;
+		};
+
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
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO89__FUNC_GPIO89>,
+				 <PINMUX_GPIO90__FUNC_GPIO90>;
+			input-disable;
+			bias-disable;
+		};
+
+		pins-phy-reset {
+			pinmux = <PINMUX_GPIO93__FUNC_GPIO93>;
+			input-disable;
+			bias-disable;
+		};
+
+		pins-power {
+			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
+				 <PINMUX_GPIO92__FUNC_GPIO92>;
+			input-disable;
+			bias-disable;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO81__FUNC_GPIO81>,
+				 <PINMUX_GPIO82__FUNC_GPIO82>,
+				 <PINMUX_GPIO83__FUNC_GPIO83>,
+				 <PINMUX_GPIO84__FUNC_GPIO84>;
+		};
+
+		pins-txd {
+			pinmux = <PINMUX_GPIO77__FUNC_GPIO77>,
+				 <PINMUX_GPIO78__FUNC_GPIO78>,
+				 <PINMUX_GPIO79__FUNC_GPIO79>,
+				 <PINMUX_GPIO80__FUNC_GPIO80>;
+		};
+	};
+
 	gpio_keys_pins: gpio-keys-pins {
 		pins {
 			pinmux = <PINMUX_GPIO106__FUNC_GPIO106>;
-- 
2.36.0


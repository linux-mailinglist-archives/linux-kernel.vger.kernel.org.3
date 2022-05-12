Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE4D5256AD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358535AbiELU4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358512AbiELU4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:56:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE95C674FC;
        Thu, 12 May 2022 13:56:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 080321F4586B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652388980;
        bh=HKwC3lI9favjFgNO9EQQwuJbOivLz3FL/dhuFZiFRJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0CR1JuByPufcykXJw1jufsCrJyWEadGstXfOtkquInYmZQ13OFnq1b5IxJDBKI8A
         mdmBruxw590ZGfvYRRFGkgcIRTRf3+sSJM1E72pi35RDvD8tEjyKPBT+xsSD5v9QAK
         9RY/027juUVLXD13up1eoOVPU4vqIaNrs4iwMzwXa6b0D10sq8UJ3cbaskH5iGXaBq
         JwePtdYZOZ0Z1TJ0wg6X5TgRb6OFlAYrsBZ44/QL787S5rHrCkolNikZDQxHq92JK+
         +DDufalGUIzo/6du149JDsXoZVtkOenPNuEoC3j0H2r3lv9mO9mj3Ui0+2nh4ixGeB
         EDG115OleyZRA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 05/16] arm64: dts: mediatek: asurada: Add system-wide power supplies
Date:   Thu, 12 May 2022 16:55:51 -0400
Message-Id: <20220512205602.158273-6-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512205602.158273-1-nfraprado@collabora.com>
References: <20220512205602.158273-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add system-wide power supplies present on all of the boards in the
Asurada family.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

---

Changes in v3:
- Renamed nodes to be generic

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index e10636298639..ca55dd095e80 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -19,6 +19,70 @@ memory@40000000 {
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x80000000>;
 	};
+
+	/* system wide LDO 1.8V power rail */
+	pp1800_ldo_g: regulator-1v8-g {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1800_ldo_g";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&pp3300_g>;
+	};
+
+	/* system wide switching 3.3V power rail */
+	pp3300_g: regulator-3v3-g {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_g";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* system wide LDO 3.3V power rail */
+	pp3300_ldo_z: regulator-3v3-z {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_ldo_z";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* separately switched 3.3V power rail */
+	pp3300_u: regulator-3v3-u {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_u";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		/* enable pin wired to GPIO controlled by EC */
+		vin-supply = <&pp3300_g>;
+	};
+
+	/* system wide switching 5.0V power rail */
+	pp5000_a: regulator-5v0-a {
+		compatible = "regulator-fixed";
+		regulator-name = "pp5000_a";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* system wide semi-regulated power rail from battery or USB */
+	ppvar_sys: regulator-var-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvar_sys";
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &pio {
-- 
2.36.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99F75256C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358573AbiELU6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358640AbiELU5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:57:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA0D6A036;
        Thu, 12 May 2022 13:56:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 49C271F45AAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652389008;
        bh=u3bgLWaqCDtC2cPlVcV31sMjvrL2SuIojgozTZcaWa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBsnrd14WnmJAEI02AwFqisQMF9YA8XYqDzyAdJr46KoE/v/2XAsmbrVHng3EQzbJ
         RFWIqYBWD+mV5oeOvMTYsBj9SVMaCmJdA7dujGMygxD8mkkeFUYn9GboiImLMHEQ8P
         5yeItut/AoW9HDg/pfnhwopKp1MZrhyZGkdDGlDMndFWWVbRiPoYj6N6BVDR6RJCIB
         ZLNqF5+oUV/sjp0Gclam+8rjVV/MPbWsmSAKEOkCHdxlPUDEpqeAoJkcG6Q0PNciY0
         qvFmIfcR7vekar7Ka9Hpd4/kitSeLQZ0uFhN5DGOv/WeJal4TVCnPsbW3U8OdWuFGV
         iwp3qLR3/JFqw==
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
Subject: [PATCH v3 16/16] arm64: dts: mediatek: asurada: Add SPMI regulators
Date:   Thu, 12 May 2022 16:56:02 -0400
Message-Id: <20220512205602.158273-17-nfraprado@collabora.com>
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

The Asurada platform uses regulators from MT6315 PMICs acessible through
SPMI. Add support for them.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

---

(no changes since v2)

Changes in v2:
- Added this patch

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index a53f7352f06e..d66b008c01ab 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -7,6 +7,7 @@
 #include "mt8192.dtsi"
 #include "mt6359.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/spmi/spmi.h>
 
 / {
 	aliases {
@@ -683,6 +684,54 @@ cr50@0 {
 	};
 };
 
+&spmi {
+	#address-cells = <2>;
+	#size-cells = <0>;
+
+	mt6315_6: pmic@6 {
+		compatible = "mediatek,mt6315-regulator";
+		reg = <0x6 SPMI_USID>;
+
+		regulators {
+			mt6315_6_vbuck1: vbuck1 {
+				regulator-compatible = "vbuck1";
+				regulator-name = "Vbcpu";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-enable-ramp-delay = <256>;
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+
+			mt6315_6_vbuck3: vbuck3 {
+				regulator-compatible = "vbuck3";
+				regulator-name = "Vlcpu";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-enable-ramp-delay = <256>;
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+		};
+	};
+
+	mt6315_7: pmic@7 {
+		compatible = "mediatek,mt6315-regulator";
+		reg = <0x7 SPMI_USID>;
+
+		regulators {
+			mt6315_7_vbuck1: vbuck1 {
+				regulator-compatible = "vbuck1";
+				regulator-name = "Vgpu";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-enable-ramp-delay = <256>;
+				regulator-allowed-modes = <0 1 2>;
+			};
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.36.1


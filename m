Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC5C51C990
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385437AbiEETv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385368AbiEETun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:50:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A26D5DA7D;
        Thu,  5 May 2022 12:47:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id A6FE71F45CD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651780021;
        bh=riKUyF3QA26FPC6IN4C9exUYKfoEiGvXUwpYMcRDj7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IEVITc3sCSDV2yoTf1mQwuHfgdj8nF+d/X2n/ZXKi5YwM4pS/WjEOl1DDvuWwo0cX
         HRjoOZee/WLN0iYDbwq3L9ydeRrTcCQoKLpcx3sD6uXW+L9di4gL1P7yjES8JrRTZW
         /PIYVbLAV0WClG+LBhsMYiLY/8LzDaRruJ/whCVuUVJngCTA1WixTyslwdSff4daGY
         S1mjJ6Uv2yolUv3Wcyb5cKE92j4ate6tCwKPdN+rxgyrb2k6tY1s/Lt5JHd2DrTKJ1
         F4I3r5vPy3rqobPCxOvXQ9V6zXFeE1WG9wn3UTDOOPczbAqri0k0AX1IX5CBw5MNrz
         5qD5Q98uEZ7nQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 16/16] arm64: dts: mediatek: asurada: Add SPMI regulators
Date:   Thu,  5 May 2022 15:45:50 -0400
Message-Id: <20220505194550.3094656-17-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220505194550.3094656-1-nfraprado@collabora.com>
References: <20220505194550.3094656-1-nfraprado@collabora.com>
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

---

Changes in v2:
- Added this patch

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index a9ffa74b2764..7f4cee928f71 100644
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
2.36.0


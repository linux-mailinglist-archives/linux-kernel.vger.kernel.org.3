Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121A85B243E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiIHRMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiIHRME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:12:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC1913F87;
        Thu,  8 Sep 2022 10:12:03 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A9D7D6601FAB;
        Thu,  8 Sep 2022 18:12:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662657122;
        bh=rOUGO4cGjU8jRBffaVEnBvlEo3ADSgzcmPqVWtblivg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4yZZ88/tyH+Mtz54J7dUPKtAaHu9sulHCvGhJW0XceEyf8xM1bOtseUPo5hgcJH7
         c9D+t/8/oXiBbUIKijjlEigm9H47MnfqvDaxSD/qGlTVe4rrGitDjT6a7OPx6NfmRI
         wGusqe9oxSjjCkXqhrpMSX0ePdYMSMYhD7LaY5FobGoFrjzLqscx/nJ8Z2wK2Qyyuf
         I5F9lkBDNROwsJLXm5zWVH4HW/Vtb60zHdchwPRT/rf1LIOd+RSyUKcZmT8PxcgOCQ
         0P/AM0UQhCDovEesQEDKNiiwIVN7IqgcUCTWdj1vt6mLj2E/2ftgECTPO8kLtT/ful
         tPd0UqN3wFyVg==
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
Subject: [PATCH 2/3] arm64: dts: mediatek: asurada: Add display backlight
Date:   Thu,  8 Sep 2022 13:11:52 -0400
Message-Id: <20220908171153.670762-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220908171153.670762-1-nfraprado@collabora.com>
References: <20220908171153.670762-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the display backlight for the Asurada platform. It relies on the
display PWM controller, so also enable and configure this component.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 1d99e470ea1a..33ef55b6dbe1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -23,6 +23,16 @@ memory@40000000 {
 		reg = <0 0x40000000 0 0x80000000>;
 	};
 
+	backlight_lcd0: backlight-lcd0 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm0 0 500000>;
+		power-supply = <&ppvar_sys>;
+		enable-gpios = <&pio 152 0>;
+		brightness-levels = <0 1023>;
+		num-interpolated-steps = <1023>;
+		default-brightness-level = <576>;
+	};
+
 	pp1000_dpbrdg: regulator-1v0-dpbrdg {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1000_dpbrdg";
@@ -840,6 +850,17 @@ pins-pcie-en-pp3300-wlan {
 		};
 	};
 
+	pwm0_pins: pwm0-default-pins {
+		pins-pwm {
+			pinmux = <PINMUX_GPIO40__FUNC_DISP_PWM>;
+		};
+
+		pins-inhibit {
+			pinmux = <PINMUX_GPIO152__FUNC_GPIO152>;
+			output-high;
+		};
+	};
+
 	scp_pins: scp-pins {
 		pins-vreq-vao {
 			pinmux = <PINMUX_GPIO195__FUNC_SCP_VREQ_VAO>;
@@ -901,6 +922,13 @@ &pmic {
 	interrupts-extended = <&pio 214 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&pwm0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins>;
+};
+
 &scp {
 	status = "okay";
 
-- 
2.37.3


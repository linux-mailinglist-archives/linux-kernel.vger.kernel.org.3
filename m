Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5153157FF7D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 15:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiGYNFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiGYNEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:04:53 -0400
X-Greylist: delayed 964 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Jul 2022 06:04:49 PDT
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96A413E0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=u+Sc1KDzF9RshIeaZARqCUt1rPYR93miba1YFSCpnzo=;
        b=mOofaVbNfZC1bIz73JDpcREMfcB1SIwA5oBroiFip7vmY+8gc/+h0kHj6VrxKwsd4gXSlIwO6Z0Wr
         l0dgcYg96h+TPYjLZgAzk4yMEcmNickJUiHufElW65B6AnYiZfh92+0hgvTnGXaMaW4z5fYh6wM3HN
         dYNrbAfrqEIeoYyGeq1CSEjhn0QO24+Q38dEfoeeM+kcRwpInQXoaYCdBYeb6Lp4MqXCkc3CFM+KpH
         HXAddP7wV3va2tqEkMwcOG/GSuqaBkSeaUQGhveTBMyAzzC/JN3tykwZyTv4wTW9Wmyz6VE/4TJuer
         x1ZA3wmhmYKT3RpPZocDDXEWzlQBbug==
X-MSG-ID: 1cb116df-0c18-11ed-8a45-0050569d11ae
From:   David Jander <david@protonic.nl>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Jander <david@protonic.nl>
Subject: [PATCH] arm: dts: imx6qdl-vicut1.dtsi: Add backlight-isb node
Date:   Mon, 25 Jul 2022 14:48:13 +0200
Message-Id: <20220725124813.1001032-1-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some older hardware models this is needed. It will do no harm if used
with newer models though.

Signed-off-by: David Jander <david@protonic.nl>
---
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
index a1676b5d2980..08d425020088 100644
--- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
@@ -37,6 +37,16 @@ backlight_led: backlight_led {
 		power-supply = <&reg_3v3>;
 	};
 
+	/* only for backwards compatibility with old HW */
+	backlight_isb: backlight_isb {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 5000000 0>;
+		brightness-levels = <0 8 48 255>;
+		num-interpolated-steps = <5>;
+		default-brightness-level = <0>;
+		power-supply = <&reg_3v3>;
+	};
+
 	connector {
 		compatible = "composite-video-connector";
 		label = "Composite0";
@@ -370,6 +380,12 @@ &pwm1 {
 	status = "okay";
 };
 
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "okay";
+};
+
 &pwm3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
@@ -601,6 +617,12 @@ MX6QDL_PAD_DISP0_DAT8__PWM1_OUT			0x1b0b0
 		>;
 	};
 
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX6QDL_PAD_DISP0_DAT9__PWM2_OUT			0x1b0b0
+		>;
+	};
+
 	pinctrl_pwm3: pwm3grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD4_DAT1__PWM3_OUT			0x1b0b0
-- 
2.32.0


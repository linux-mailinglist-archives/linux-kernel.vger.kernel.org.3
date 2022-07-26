Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B7E58132B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbiGZMcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiGZMca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:32:30 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E7722BD4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=fiS+pQsGd1PRAgB4GEWl1w1Wb5frISWb+zTO6Mar7gA=;
        b=QWbND68AXGgpIsgaLdL8AHimYaNgJHyCUn0e8bEt28ritP7Vz4JXwn5cGq6mr46Drdo9bgRYn3eyB
         nckE77x5jjoebQvSh01B/PFVcS0rZx34wE/Ap2nvb0Km3Bsb+30jiDjnrTbCpmtEhCcL9OCOru8PfL
         QTfNNAknm2w2C/yMhd+DVYn5JQYDr2sznMlQGFA4qERTolDByfMAkTvPgRgzF6SCfiujHN4aFIU2Pp
         Ja9yPyl3ImlWwDUc8wl2vN+8v/pcyL2MwPlBMGQhUWt7fiyOT+RHis9g6J6Goh1KCI3v3RFYnKPNwu
         5by4avvTVthbqfkkbOx+WEoBLM1xNEQ==
X-MSG-ID: 00db330a-0cdf-11ed-9051-0050569d2c73
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
Subject: [PATCH v2 1/2] arm: dts: imx6qdl-vicut1.dtsi: Add backlight-isb node
Date:   Tue, 26 Jul 2022 14:32:21 +0200
Message-Id: <20220726123222.1074876-2-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220726123222.1074876-1-david@protonic.nl>
References: <20220726123222.1074876-1-david@protonic.nl>
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
v2:
 - Fix node name to use minus character instead of underscore.
---
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
index a1676b5d2980..8a2512f3f378 100644
--- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
@@ -37,6 +37,16 @@ backlight_led: backlight_led {
 		power-supply = <&reg_3v3>;
 	};
 
+	/* only for backwards compatibility with old HW */
+	backlight_isb: backlight-isb {
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


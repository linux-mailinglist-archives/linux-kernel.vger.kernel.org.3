Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D524BC8FB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 15:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242514AbiBSOwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 09:52:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241935AbiBSOwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 09:52:20 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594A763E4;
        Sat, 19 Feb 2022 06:52:00 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 90DF4403DB;
        Sat, 19 Feb 2022 19:51:55 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1645282317; bh=dTspXvVbwz4GaIzuNN1m6jkmBot3+iM7ucJOLZkyafE=;
        h=From:To:Cc:Subject:Date:From;
        b=JaroDSmNtpsXIG+JQ8Qm9hyyXrjtoHLILP80Tzohiq9iawzeTm2+ZXkAV2uysN6M3
         eyG70BhXtWk9qJnVIF6TtVlFmvE4sZmdotHzVxC3BgGaeyPNLr4JldYBSr+fljWfCD
         idr9odc/ezwHazphZI9lhUKPc+RzMy8Uqh6r7hP0G4VnLwy0cMnkDC6qAWVpVwcAlA
         5oPMoCatjef+VX0DQsqW9mmhKrfIHmGawAXYuZbTmh8xyU+2SnRLEmTXlISxLIitvK
         26EtDVK+rT6Cft18S20bgtMkqT+qqAMbaqQBU1wPQGEZGoHxgUGSXDvrT1q2SBzkIv
         sc65bXu9dGN+w==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] arm64: dts: qcom: msm8916-longcheer-l8150: Add light and proximity sensor
Date:   Sat, 19 Feb 2022 19:51:40 +0500
Message-Id: <20220219145140.84712-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L8150 uses LTR559 as a light and proximity sensor. Add it to the
devicetree.

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index 852de624f5af..b3836dde8a54 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -151,6 +151,21 @@ magnetometer@12 {
 		vddio-supply = <&pm8916_l6>;
 	};
 
+	light-sensor@23 {
+		compatible = "liteon,ltr559";
+		reg = <0x23>;
+		proximity-near-level = <75>;
+
+		interrupt-parent = <&msmgpio>;
+		interrupts = <115 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&light_int_default>;
+
+		vdd-supply = <&pm8916_l17>;
+		vio-supply = <&pm8916_l6>;
+	};
+
 	gyroscope@68 {
 		compatible = "bosch,bmg160";
 		reg = <0x68>;
@@ -392,6 +407,14 @@ gyro_int_default: gyro-int-default {
 		bias-disable;
 	};
 
+	light_int_default: light-int-default {
+		pins = "gpio115";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	magn_int_default: magn-int-default {
 		pins = "gpio113";
 		function = "gpio";
-- 
2.34.1


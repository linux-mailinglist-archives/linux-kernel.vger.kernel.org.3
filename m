Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40124B932B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 22:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbiBPV0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 16:26:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiBPVZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 16:25:56 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BF82AE735;
        Wed, 16 Feb 2022 13:25:43 -0800 (PST)
Received: from localhost.localdomain (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id DD607C7173;
        Wed, 16 Feb 2022 21:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645046742; bh=vlTmR233YI8p9UvGkFUjB1SzePvBOMARWM3FUKEF2OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CR5zq4aRCr5xtbYxdvLKfVX6kUcrhI1U0qbJJrE26TFs2sl9Mps8KlO4CV/IZRRor
         RF14JJTZda1aKBxNNPo0rBuz7Srvzy/mD/wJrI3TH88kcMo1JKvfQiW3iYwFFaXaO/
         45EHHb3rV1+Nit3Nrafk7L8VjdwcUJ+L66sDIJ78=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ARM: dts: qcom: apq8026-lg-lenok: Add Wifi
Date:   Wed, 16 Feb 2022 22:24:31 +0100
Message-Id: <20220216212433.1373903-5-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216212433.1373903-1-luca@z3ntu.xyz>
References: <20220216212433.1373903-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device contains BCM43430A0 for wifi. Add a node for it.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts | 53 +++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
index 5ce42dd962c4..333fae435913 100644
--- a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
@@ -21,6 +21,20 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	vreg_wlan: wlan-regulator {
+		compatible = "regulator-fixed";
+
+		regulator-name = "wl-reg";
+		regulator-min-microvolt = <2950000>;
+		regulator-max-microvolt = <2950000>;
+
+		gpio = <&tlmm 46 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_regulator_default_state>;
+	};
 };
 
 &blsp1_i2c1 {
@@ -206,6 +220,30 @@ &sdhc_1 {
 	non-removable;
 };
 
+&sdhc_3 {
+	status = "okay";
+
+	max-frequency = <100000000>;
+	non-removable;
+
+	vmmc-supply = <&vreg_wlan>;
+	vqmmc-supply = <&pm8226_l6>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	wifi@1 {
+		compatible = "brcm,bcm43430a0-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+
+		interrupts-extended = <&tlmm 37 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "host-wake";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_hostwake_default_state>;
+	};
+};
+
 &smbb {
 	qcom,fast-charge-safe-current = <450000>;
 	qcom,fast-charge-current-limit = <400000>;
@@ -235,6 +273,21 @@ reset {
 			output-high;
 		};
 	};
+
+	wlan_hostwake_default_state: wlan-hostwake-default-state {
+		pins = "gpio37";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		input-enable;
+	};
+
+	wlan_regulator_default_state: wlan-regulator-default-state {
+		pins = "gpio46";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 };
 
 &usb {
-- 
2.35.1


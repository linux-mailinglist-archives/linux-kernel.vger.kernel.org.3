Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547364B932C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 22:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbiBPV0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 16:26:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbiBPVZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 16:25:58 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2FA2AE735;
        Wed, 16 Feb 2022 13:25:45 -0800 (PST)
Received: from localhost.localdomain (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 67313C7184;
        Wed, 16 Feb 2022 21:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645046744; bh=8ZqDBuy6tg3m8U9pU7Xf1AWeHMPKkX8n5xVbekijS/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SZYU6N9MiaCHYAzw+Mkn1+X25IsRjIPgMgeCVa7T/3XMLz0ZVYUu+mzlyCDH3mdQ/
         eHuv6YgWwXFzqw/ya2igm0RiM0aUHty3dQWrAKHrNuzp7bqiQ9MokATxMAod9/9rrg
         3c2beKDIu60gs5EeiBgoj2Eqchy3au4BqEAn+4CA=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ARM: dts: qcom: apq8026-lg-lenok: Add Bluetooth
Date:   Wed, 16 Feb 2022 22:24:32 +0100
Message-Id: <20220216212433.1373903-6-luca@z3ntu.xyz>
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

The device contains BCM43430A0 for bluetooth. Add a node for it.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts | 36 +++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
index 333fae435913..42467f705b26 100644
--- a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
@@ -16,6 +16,7 @@ / {
 
 	aliases {
 		serial0 = &blsp1_uart3;
+		serial1 = &blsp1_uart4;
 	};
 
 	chosen {
@@ -80,6 +81,26 @@ &blsp1_uart3 {
 	status = "okay";
 };
 
+&blsp1_uart4 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&blsp1_uart4_default_state>;
+
+	bluetooth {
+		compatible = "brcm,bcm43430a0-bt";
+
+		max-speed = <3000000>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bluetooth_default_state>;
+
+		host-wakeup-gpios = <&tlmm 48 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&tlmm 47 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&tlmm 45 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &rpm_requests {
 	pm8226-regulators {
 		compatible = "qcom,rpm-pm8226-regulators";
@@ -254,6 +275,21 @@ &smbb {
 };
 
 &tlmm {
+	blsp1_uart4_default_state: blsp1-uart4-default-state {
+		pins = "gpio12", "gpio13", "gpio14", "gpio15";
+		function = "blsp_uart4";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	bluetooth_default_state: bluetooth-default-state {
+		pins = "gpio47", "gpio48";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		input-enable;
+	};
+
 	touch_pins: touch {
 		irq {
 			pins = "gpio17";
-- 
2.35.1


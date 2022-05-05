Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0029C51C549
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381217AbiEEQsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiEEQsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:48:40 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CE3140D2;
        Thu,  5 May 2022 09:45:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.0.11.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E078FCEB6A;
        Thu,  5 May 2022 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1651769069; bh=0xFfXxhaakUSdwQJ4McjhfUEVogdCXDlcNEi2e5reQ0=;
        h=From:To:Cc:Subject:Date;
        b=KSO19uWkd1/Mmzje9o5Bv+NvyzaFuzO8IH5MpkNLFXZSJfY6+1xOfaRfb+jDnLtk6
         Xk7+Mlq8HDz3P/KDE+wQ49soY0mnLZF4/LlL8LU0KP0HkahGat/z4YnIQuN1FIcXM2
         tQmwXhKWw+qRgy1tibq5IUA/NS7/bVN991P+mTec=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: msm8974-hammerhead: Add notification LED
Date:   Thu,  5 May 2022 18:43:37 +0200
Message-Id: <20220505164336.13210-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: André Almeida <andrealmeid@collabora.com>

Nexus 5 has a RGB LED connected to the TRILED and hence channels 7, 6 and
5 of the LPG. Add a node describing this.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
This patch depends on the PM8941 LPG patch:
https://lore.kernel.org/linux-arm-msm/20220504205411.1510667-1-bjorn.andersson@linaro.org/

 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 9493886a5c0d..94f3149d9f87 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -3,6 +3,7 @@
 #include "qcom-pm8841.dtsi"
 #include "qcom-pm8941.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
@@ -313,6 +314,35 @@ otg {
 	};
 };
 
+&pm8941_lpg {
+	status = "okay";
+
+	qcom,power-source = <1>;
+
+	multi-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@7 {
+			reg = <7>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@6 {
+			reg = <6>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@5 {
+			reg = <5>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+};
+
 &rpm_requests {
 	pm8841-regulators {
 		compatible = "qcom,rpm-pm8841-regulators";
-- 
2.36.0


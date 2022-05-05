Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE451C532
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382036AbiEEQhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349984AbiEEQg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:36:56 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772B1541A4;
        Thu,  5 May 2022 09:33:16 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.0.11.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 96EA3CEB69;
        Thu,  5 May 2022 16:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1651768364; bh=W0T8MsmE33FXKnUsBsvXhWW/m3Eju1Zg595SCArEpYM=;
        h=From:To:Cc:Subject:Date;
        b=D9mDis5XW7mFgrcWlEcld/KIuqc9zjp5Sirn/86radN0pHBBqdtPrmTmUvHMbLLqX
         MaNVW29wS2I96P1iX+dSho9vKnOv1l1jnD0S7ets9gm7/oIsYXEhLz5RnPphgGzfMj
         LNfth7bdyJj5XSK7M4xaHI+zgxThoFAKtWR1rcEQ=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: msm8974-FP2: Add notification LED
Date:   Thu,  5 May 2022 18:30:29 +0200
Message-Id: <20220505163029.6541-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
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

FP2 has a RGB LED connected to the TRILED and hence channels 7, 6 and
5 of the LPG. Add a node describing this.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
This patch depends on the PM8941 LPG patch:
https://lore.kernel.org/linux-arm-msm/20220504205411.1510667-1-bjorn.andersson@linaro.org/

 .../dts/qcom-msm8974pro-fairphone-fp2.dts     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
index 0700a0008caa..0fad82fc9e03 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
@@ -3,6 +3,7 @@
 #include "qcom-pm8841.dtsi"
 #include "qcom-pm8941.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
@@ -162,6 +163,35 @@ gpio_keys_pin_a: gpio-keys-active {
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
 &pronto {
 	status = "okay";
 
-- 
2.36.0


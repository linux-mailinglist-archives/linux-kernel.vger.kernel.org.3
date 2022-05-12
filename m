Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55AE52452D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350015AbiELFvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbiELFvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:51:24 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 May 2022 22:51:18 PDT
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0033E506C6;
        Wed, 11 May 2022 22:51:17 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4KzLMh0dpMz9t2F;
        Thu, 12 May 2022 07:45:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1652334304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Mjrv/G6HrIBpduWu1g0fC288vFkgwsi6v+XkaQ1EIAw=;
        b=fyaBxxNAJxPwOOSm4Ko49ricSxn6uh/uoCvNEjbnzlK9D6D+JvaYq4SVn3wuRfS902o1It
        mVW7wJRowWQ7hOBLhWtC040pkFck2OWyHOmeD/ffcaLpG4jb7aF8x+Z/N1rcc5RYAxcWtH
        HSRAAL/d2qjSLFrTMDSM6GDSua39ssYm38AKrc8T1sTeooZAGhaZvLRS/BaOWrJBS2+njE
        5PMrFcAXbkAEW/g4cSk/GWcZAjalBNscC4cXMP9OYF0XY6hho1GB8Zj2DzjVpzaPK5Zfhq
        oAbjT1Mpq0VyJ0H4TvY7ubxKVa3o70QNTOPt9dS+I/Cn8qbamD/3wp0zxbOY9Q==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH] arm64: dts: qcom/sdm845-shift-axolotl: Enable pmi9889 LPG LED
Date:   Thu, 12 May 2022 07:44:39 +0200
Message-Id: <20220512054439.13971-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables the RGB notification LED on the SHIFT 6mq (sdm845-shift-axolotl)
with the Qualcomm Light Pulse Generator bindings by Bjorn Andersson [1].
Patches are merged in for-next branch of linux-leds.
Tested these changes on the SHIFT 6mq.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/commit/?h=for-next&id=a8e53db46f19f67be6a26488aafb7d10c78e33bd

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 847f6217a77b..af412ac2c9d0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -2,11 +2,13 @@
 /*
  * Copyright (c) 2022, Alexander Martinz <amartinz@shiftphones.com>
  * Copyright (c) 2022, Caleb Connolly <caleb@connolly.tech>
+ * Copyright (c) 2022, Dylan Van Assche <me@dylanvanassche.be>
  */
 
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sdm845.dtsi"
 #include "pm8998.dtsi"
@@ -554,6 +556,33 @@ &pmi8998_smb2 {
 	monitored-battery = <&battery>;
 };
 
+&pmi8998_lpg {
+	status = "okay";
+
+	multi-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@3 {
+			reg = <3>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+
+		led@4 {
+			reg = <4>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@5 {
+			reg = <5>;
+			color = <LED_COLOR_ID_RED>;
+		};
+	};
+};
+
 &qup_uart9_default {
 	pinconf-rx {
 		pins = "gpio5";
-- 
2.36.1


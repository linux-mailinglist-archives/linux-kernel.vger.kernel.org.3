Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79F7596FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbiHQNP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbiHQNOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:14:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A064F693
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:14:36 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z6so18949485lfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xXYhGBIEDADNPaF7FntsO5+CaYiCK5EMt2dAgswIP/E=;
        b=rfesmkR/Z2XkW9U5Ai2BIS8LVP73UN+425tKrx0cDTW1zqLqT2gXDM078/lW9QV2yI
         sQG6qAJgYSZUG457LxgdNYYIuMkNQq2Za3JQy/YETZEYWpLvm37fPk9RtQlnG4X0V0dK
         TW066pA7XnpEPtQ1VV1538t+W8+9k4l5WpTNDQpglqG1FRuGBVvBFp43qjaB5IH8sBf7
         /JQ9csPnIN4J6v5N5ljLmSk3hCycOvauDqM6gBbkoyOqFswbH9BgtcKwiiWVJ1VwyGT3
         KUGbmquXwocSJD4TjlGNAOvzw4v7tG5i7B5vjjJoCY+NAtYpaFy0pSVR5FvRuRxWlByI
         tFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xXYhGBIEDADNPaF7FntsO5+CaYiCK5EMt2dAgswIP/E=;
        b=LaaGZ9zpj62xUqABPfBr6HNRUQaM6pFgBOXC6+P4fa0xnqndpmCzbWl4DIO+kZYP/x
         /WMNV8lXcu6gepAriktjL8KRLZ9nx7j5a6ifrgcTCEHzSC/johd4GslUTDwArsTlXjBc
         XLC87wfRPWvSoeeQFCLp5xTiCvKQkV7XRpT8F5lMANCGEzSZSDI4/YuxWSTWVpBsmC8I
         sNzmHKbcoTzrMo+5qf9Lx2NzK0XlP8JHRIeBxkiL8VlRoRQG+U7Urjj4qB8uQxwYG09X
         U+MZudKSo3AJ2f6VjlKhwXToIBAr+q7EeZQMjkmlYSKawRwUD8uLiCp5P7xI0ZYthhVH
         HXOg==
X-Gm-Message-State: ACgBeo2l+MYtezPizbNQLG5GdtGfXLz+HUSHlwpHwei3sEjKs9E/l9yY
        fY/tvLG0misqbe2Mw+lzLeUodg==
X-Google-Smtp-Source: AA6agR6PDcGKSl5yiOIktlWZ0jUH6eEYd3ChNN0RAz7S7jfXE61WPqYwgJ808qhJjFJUkBaxmtwcow==
X-Received: by 2002:a05:6512:2611:b0:478:da8f:e2d8 with SMTP id bt17-20020a056512261100b00478da8fe2d8mr8444745lfb.460.1660742074843;
        Wed, 17 Aug 2022 06:14:34 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id k1-20020a2ea261000000b0026182f31aa0sm1411307ljm.1.2022.08.17.06.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 06:14:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 09/12] ARM: dts: qcom: msm8974: split TCSR halt regs out of mutex
Date:   Wed, 17 Aug 2022 16:14:12 +0300
Message-Id: <20220817131415.714340-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817131415.714340-1-krzysztof.kozlowski@linaro.org>
References: <20220817131415.714340-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCSR halt regs are next to TCSR mutex, so before converting the TCSR
mutex into device with address space, we need to split the halt regs to
its own syscon device.  This also describes more accurately the devices
and their IO address space.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts        |  2 +-
 .../boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts   |  2 +-
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi |  2 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                   | 11 ++++++++---
 arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts   |  2 +-
 arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts    |  2 +-
 .../qcom-msm8974pro-sony-xperia-shinano-castor.dts    |  2 +-
 7 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 3051a861ff0c..2709a99e5c4c 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -38,7 +38,7 @@ &otg {
 	status = "okay";
 
 	phys = <&usb_hs2_phy>;
-	phy-select = <&tcsr 0xb000 1>;
+	phy-select = <&tcsr_2 0xb000 1>;
 	extcon = <&smbb>, <&usb_id>;
 	vbus-supply = <&chg_otg>;
 	hnp-disable;
diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index ec5d340562b6..5fd94dd6a427 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -251,7 +251,7 @@ &otg {
 	status = "okay";
 
 	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
+	phy-select = <&tcsr_2 0xb000 0>;
 
 	extcon = <&charger>, <&usb_id>;
 	vbus-supply = <&usb_otg_vbus>;
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
index 5a70683d9103..118b231f3137 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -136,7 +136,7 @@ &otg {
 	status = "okay";
 
 	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
+	phy-select = <&tcsr_2 0xb000 0>;
 	extcon = <&smbb>, <&usb_id>;
 	vbus-supply = <&chg_otg>;
 
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 0a9f252c88a7..4b602410d72a 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1189,7 +1189,7 @@ remoteproc_mss: remoteproc@fc880000 {
 			resets = <&gcc GCC_MSS_RESTART>;
 			reset-names = "mss_restart";
 
-			qcom,halt-regs = <&tcsr_mutex_block 0x1180 0x1200 0x1280>;
+			qcom,halt-regs = <&tcsr_1 0x180 0x200 0x280>;
 
 			qcom,smem-states = <&modem_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
@@ -1230,10 +1230,15 @@ smd-edge {
 
 		tcsr_mutex_block: syscon@fd484000 {
 			compatible = "syscon";
-			reg = <0xfd484000 0x2000>;
+			reg = <0xfd484000 0x1000>;
 		};
 
-		tcsr: syscon@fd4a0000 {
+		tcsr_1: syscon@fd485000 {
+			compatible = "qcom,msm8974-tcsr", "syscon";
+			reg = <0xfd485000 0x1000>;
+		};
+
+		tcsr_2: syscon@fd4a0000 {
 			compatible = "qcom,msm8974-tcsr", "syscon";
 			reg = <0xfd4a0000 0x10000>;
 		};
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
index ff6e0066768b..c264d17e0953 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
@@ -89,7 +89,7 @@ &otg {
 	status = "okay";
 
 	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
+	phy-select = <&tcsr_2 0xb000 0>;
 	extcon = <&smbb>, <&usb_id>;
 	vbus-supply = <&chg_otg>;
 
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
index 983e10c3d863..2691a6dbbb8b 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
@@ -379,7 +379,7 @@ &otg {
 	status = "okay";
 
 	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
+	phy-select = <&tcsr_2 0xb000 0>;
 
 	hnp-disable;
 	srp-disable;
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 3f45f5c5d37b..d2bef3896c82 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -216,7 +216,7 @@ &otg {
 	status = "okay";
 
 	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
+	phy-select = <&tcsr_2 0xb000 0>;
 	extcon = <&smbb>, <&usb_id>;
 	vbus-supply = <&chg_otg>;
 
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C37955FF82
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiF2MPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiF2MPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:15:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920F31AD9C;
        Wed, 29 Jun 2022 05:15:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id fd6so21905061edb.5;
        Wed, 29 Jun 2022 05:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9nkymMh6Fyk5ogMBLfEwOg5w2y/IS5hDP9brUec1NtE=;
        b=mdiOJKmco0uz+90t28h7UDuv3yVDL2/6xUmKrOOYANCVCX2IzSj2gxsV13mK0aJTI0
         1NBxsEid8Nb2AG7LsGggfPEq00l/PLEFI7n0Yv1YAEp2Ew47RNJrtWfbgmFiWP1R4Pg5
         hkFcr7kBnaPhJW2eS2QDmQC/b/HpuIxBnmJfxKQRcCuUobWomkxjF1EBlaRu07Cj5IcY
         eLQSAHfVtAGS6blCvRz7keXfvn/RvxRcSjuVPyYJbB9RlKXBr2fjaNWpjcnNHIEZPpJu
         EAjRwN2GraWuNkPaL3xvhzrYxB7Cc2lxnh5qPAn6Dj8r2ASzDRTRVcARqrWbQbAp5YpX
         VMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9nkymMh6Fyk5ogMBLfEwOg5w2y/IS5hDP9brUec1NtE=;
        b=6Dg4D4S10oEWNRwNfGDjTkTk7gcd5yKSG+unqMCLhtaTzf9QZIK2SwKre+EOetRx5E
         g/vdS3qkvNjSQgi7WWVCZ2Eu49hpgri/96jdZ+YTQK3O7KSpO0bBwn+H12CZhdqWctm5
         vLaLD0yMuC45Zu656Un+isT0QMmQJTGpQ0LAEnEhN2conx2/3nf9l8mQvG0T6fgsOD3d
         K0Zp5/xn4W0vL+sevyommC/ms7RbqabKXaSwCfzfJpGPOtH0cha+HfCiAWgetEjxEQLU
         FzQiuqMC0Y3PR+I19RVQzYPgKSWgF6iXey/VNfQ6Xv0W97ZrlUDvS8llxu3+0RSpxKVU
         B1Fg==
X-Gm-Message-State: AJIora/bAdbcZKu0+KCwJln27QqBWdN6qSSE7K4X8VixhfxaqFeop4D/
        KCa/RF/gmYnPZlGDIDfW+sk=
X-Google-Smtp-Source: AGRyM1sGidUWBzVWwbLejT/lZ1A3XwWnBKmGFFBW92YO9QU0BMJuUyU+pdv+zl5/dtv8FMXZtUs8HA==
X-Received: by 2002:aa7:c38d:0:b0:435:9257:99a5 with SMTP id k13-20020aa7c38d000000b00435925799a5mr3832719edq.204.1656504903032;
        Wed, 29 Jun 2022 05:15:03 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id l23-20020aa7cad7000000b004356afc7009sm11224421edt.59.2022.06.29.05.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:15:02 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 4/5] ARM: dts: qcom: fix various wrong definition for kpss-gcc node
Date:   Wed, 29 Jun 2022 14:14:40 +0200
Message-Id: <20220629121441.6552-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629121441.6552-1-ansuelsmth@gmail.com>
References: <20220629121441.6552-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtbs_check warning now that we have a correct kpss-gcc yaml
schema. Add additional qcom,kpss-gcc compatible to differentiate
devices where kpss-gcc should provide a clk and where kpss-gcc should
just provide the registers and the syscon phandle.
Add missing #clock-cells and remove useless clock-output-names for
ipq806x.
Add missing bindings for msm8960 and apq8064 kpss-gcc node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 5 ++++-
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ++--
 arch/arm/boot/dts/qcom-mdm9615.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi | 7 +++++--
 5 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 34c0ba7fa358..a5b4574be095 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -836,8 +836,11 @@ mmcc: clock-controller@4000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible	= "qcom,kpss-gcc", "syscon";
+			compatible	= "qcom,kpss-gcc-apq8064", "qcom,kpss-gcc", "syscon";
 			reg		= <0x2011000 0x1000>;
+			clocks		= <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names	= "pll8_vote", "pxo";
+			#clock-cells	= <0>;
 		};
 
 		rpm@108000 {
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 808ea1862283..ba94fb4c3d55 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -782,11 +782,11 @@ tcsr: syscon@1a400000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
 			clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
 			clock-names = "pll8_vote", "pxo";
-			clock-output-names = "acpu_l2_aux";
+			#clock-cells = <0>;
 		};
 
 		lcc: clock-controller@28000000 {
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index 0ce0d04bd994..5df65056247e 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -152,7 +152,7 @@ lcc: clock-controller@28000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-mdm9615", "qcom,kpss-gcc", "syscon";
 			reg = <0x02011000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 47b97daecef1..fcc10cac1218 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -392,7 +392,7 @@ vibrator@4a {
 		};
 
 		l2cc: clock-controller@2082000 {
-			compatible	= "qcom,kpss-gcc", "syscon";
+			compatible	= "qcom,kpss-gcc-msm8660", "qcom,kpss-gcc", "syscon";
 			reg		= <0x02082000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 4a2d74cf01d2..a11a0fe7e0a9 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -63,7 +63,7 @@ cxo_board {
 			clock-output-names = "cxo_board";
 		};
 
-		pxo_board {
+		pxo_board: pxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <27000000>;
@@ -148,8 +148,11 @@ clock-controller@4000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible	= "qcom,kpss-gcc", "syscon";
+			compatible	= "qcom,kpss-gcc-msm8960", "qcom,kpss-gcc", "syscon";
 			reg		= <0x2011000 0x1000>;
+			clocks		= <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names	= "pll8_vote", "pxo";
+			#clock-cells	= <0>;
 		};
 
 		rpm@108000 {
-- 
2.36.1


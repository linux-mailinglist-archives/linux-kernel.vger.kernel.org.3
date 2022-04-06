Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52C24F6BD0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiDFU4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiDFU4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:56:10 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF8E3D2142;
        Wed,  6 Apr 2022 12:16:08 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-df02f7e2c9so3971781fac.10;
        Wed, 06 Apr 2022 12:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=joF76rv1su2HJkDHzu00cHwinoChYU2eD7dMmYK9hq4=;
        b=mEVXWiZHw5fXGIccRn5zCRYqFaftEFWdquK4vftIIqwdJvK8HA+Svjk0kbMZ5IdH04
         eIXAm6xLmDgy5q81EqD9lK3vpTbDZGeqZz5UeDhs8/OSdT9BnHLmDU6nEhj5e4VUJ+O1
         TwN0pynE0o6739Y3EYu74+mmODbx7nR5u5XgbIKsbVn3zkor7iY3DSKF3rD9z32Dq7Rk
         dJjRma6tt1wDUCnF+mW6IQ8DLMVgD9pKPzojb1V+2qGTPPz6er6HUpIk4jxxkXFF5QCK
         e8zWDTrzqwnGyPQ5iHDAa0drqBfraJIbMmqOmlYoYVfV7fGsa5rjkQDZqUWOz6KV8K+e
         1TNw==
X-Gm-Message-State: AOAM531tdCDg96iANg/Pcs4pkRS0azCAiTLtjPEYbUOUo7cZ0qD/c4tZ
        8ILUzsyobq4ioNuWrvD57A==
X-Google-Smtp-Source: ABdhPJzT/qS77COXOCRXvBFiaDxtp4Pbns326cuyD89xK5mSxhPwPbzIwdSd6Xf2u0GHhg3Wj7L3sA==
X-Received: by 2002:a05:6870:9a10:b0:e1:fe1b:be44 with SMTP id fo16-20020a0568709a1000b000e1fe1bbe44mr4827226oab.250.1649272567951;
        Wed, 06 Apr 2022 12:16:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t15-20020a056808158f00b002e331356c87sm6708039oiw.39.2022.04.06.12.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:16:07 -0700 (PDT)
Received: (nullmailer pid 2612457 invoked by uid 1000);
        Wed, 06 Apr 2022 19:16:07 -0000
Date:   Wed, 6 Apr 2022 14:16:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, soc@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] arm/arm64: dts: qcom: Fix boolean properties with
 values
Message-ID: <Yk3m92Sj26/v1mLG@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.32.0
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boolean properties in DT are present or not present and don't take a value.
A property such as 'foo = <0>;' evaluated to true. IOW, the value doesn't
matter.

It may have been intended that 0 values are false, but there is no change
in behavior with this patch.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Can someone please apply this for 5.18.

 arch/arm/boot/dts/qcom-apq8064-pins.dtsi            | 12 ++++++------
 arch/arm64/boot/dts/qcom/msm8996.dtsi               |  4 ++--
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi |  2 +-
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
index cbe42c4153a0..b4d286a6fab1 100644
--- a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
@@ -76,7 +76,7 @@ mux {
 		pinconf {
 			pins = "gpio20", "gpio21";
 			drive-strength = <2>;
-			bias-disable = <0>;
+			bias-disable;
 		};
 	};
 
@@ -116,7 +116,7 @@ mux {
 		pinconf {
 			pins = "gpio24", "gpio25";
 			drive-strength = <2>;
-			bias-disable = <0>;
+			bias-disable;
 		};
 	};
 
@@ -141,7 +141,7 @@ mux {
 		pinconf {
 			pins = "gpio8", "gpio9";
 			drive-strength = <2>;
-			bias-disable = <0>;
+			bias-disable;
 		};
 	};
 
@@ -166,7 +166,7 @@ mux {
 		pinconf {
 			pins = "gpio12", "gpio13";
 			drive-strength = <2>;
-			bias-disable = <0>;
+			bias-disable;
 		};
 	};
 
@@ -229,7 +229,7 @@ mux {
 		pinconf {
 			pins = "gpio16", "gpio17";
 			drive-strength = <2>;
-			bias-disable = <0>;
+			bias-disable;
 		};
 	};
 
@@ -282,7 +282,7 @@ mux {
 		pinconf {
 			pins = "gpio84", "gpio85";
 			drive-strength = <2>;
-			bias-disable = <0>;
+			bias-disable;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 4f1f88a2ec02..a94b44d44b63 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1247,14 +1247,14 @@ blsp1_i2c3_default: blsp1-i2c2-default {
 				pins = "gpio47", "gpio48";
 				function = "blsp_i2c3";
 				drive-strength = <16>;
-				bias-disable = <0>;
+				bias-disable;
 			};
 
 			blsp1_i2c3_sleep: blsp1-i2c2-sleep {
 				pins = "gpio47", "gpio48";
 				function = "gpio";
 				drive-strength = <2>;
-				bias-disable = <0>;
+				bias-disable;
 			};
 
 			blsp2_uart3_4pins_default: blsp2-uart2-4pins {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index e90f99ef5323..e47c74e513af 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -33,7 +33,7 @@ trips {
 };
 
 &alc5682 {
-	realtek,dmic-clk-driving-high = "true";
+	realtek,dmic-clk-driving-high;
 };
 
 &cpu6_alert0 {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 7f42e5315ecb..ad0d6147b6c8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -619,7 +619,7 @@ mux {
 			pins = "gpio6", "gpio25", "gpio26";
 			function = "gpio";
 			drive-strength = <8>;
-			bias-disable = <0>;
+			bias-disable;
 		};
 	};
 
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD7E4CDED0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiCDU0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiCDU0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:26:39 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DE313CA00;
        Fri,  4 Mar 2022 12:25:50 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id z8so5660947oix.3;
        Fri, 04 Mar 2022 12:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucKkxfYKLBbYPD7FcQh88DS8jWvOESBrcy6lhe5YGUI=;
        b=wd46DCLT/491IfvCP+kiRCZQNqUnaVRp1SLZxUEqqhjvxcX/O0yNz3G7JfBCrUksC8
         8Ac56YlWG8vclWfwi5VrI+gyyaH2kPVHKaMouE0yHUxcFT0h41rmCvXVjY+aCCh06MEO
         LxLJUBhGNaFBeOrnHlq1KvQBVkFOGe0jQBn0df0HUdt0qWu9MN9/kntNmMIiTqKvYGT4
         X9hW7WFeHKx5iEVX2p/GtOlcJ30vi4aU4HMWh+kdQhrYcUNXKY/q1umbl2ckfSqabsqz
         CJuXy2ZsrpKRvJb5DiwAr6Y7toEUTBbDbj1e9n/gqRiHYYFYb9KntbIn2P8DA3u26fMz
         tFiQ==
X-Gm-Message-State: AOAM530k+9QAuHmiLUdP0J0LVuKzAF3i+dC963r38Je+r1JrnURpsVq8
        x2hDG3qUAyQzlpsOo/9ciPZMaFSQvw==
X-Google-Smtp-Source: ABdhPJzM5PDl1NN7xeBDRp/7CqSRwGdKro5ru30k4wxS7CXLWyLdDq+PnrDDyS/gmaBpXf1tUfN80w==
X-Received: by 2002:a05:6808:1390:b0:2d5:47e8:5221 with SMTP id c16-20020a056808139000b002d547e85221mr10644588oiw.162.1646425549330;
        Fri, 04 Mar 2022 12:25:49 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id l8-20020a4ad9c8000000b0031bec309e0asm2671994oou.6.2022.03.04.12.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:25:48 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm/arm64: dts: qcom: Fix boolean properties with values
Date:   Fri,  4 Mar 2022 14:25:36 -0600
Message-Id: <20220304202536.316875-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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


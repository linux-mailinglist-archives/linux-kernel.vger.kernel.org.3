Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD4858E862
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiHJIFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiHJIF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:05:26 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8240225E88
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:05:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z25so20199139lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BpcLPBAGuiZcpVrA8pcR24viGnpJaVJd3XMXiJb1Rfg=;
        b=huxWhU8+f11jDxhBwD0M/5LlAFH+ebBTILIwhjbkIe0sEzWtGUi7Rw4KpaIs2JvgTG
         OcC2MiMXatY5dRFtuFsC12r8sRuOO97nA7JptuozHen0gHM94+uF4UVzJ1cZql0aNpeE
         6vjuxGrA+K0FUYg4z0gY5uGsNpmdM+dGEQBpm1xYY8GqMevp2rRlv1plnAndv6lgsm2n
         6xnZt1naQN89p2EDZdnpmUMnMeahCzvDck4eUcU80IE8W/tvO4+x5BThnJNS8eDUpHds
         HmuUIYk++sPiL3jUBmou8Qc3c1yHHqQ4OpfoQ/k/lY1ygVqv6gPFcNbk5L4Qw62qD+jL
         VcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BpcLPBAGuiZcpVrA8pcR24viGnpJaVJd3XMXiJb1Rfg=;
        b=sh1HFnDZVzHmJSF6e4cmfRzSwDlTqUipbo9eoh2pUW3nCCl8nRPh2iqiH86k6g1e3R
         NvdgwS/+h8ET02FZ8d1kts8Sl7bXxFCLktbAckrzsYUaWjP20lJDRwnaNFB3BT11xWFf
         2pjt9F9ng61TCtxVgnJXH9k3cwJPlfNZGMrJY3iH5orYoqXTnJpOOY4svCedoGFp/bIt
         Y9ggOdFWWcQXFKX/HiA6TiRv5xpsIcZo48VXua7BSdZUBIR0Ayd3lFgXJwjxFVEnuZOD
         GpqzBDFrXEzrcnY2y+4HIsDc/irzvsMzvvVy6HZz5yOr+X4zWlnAEuDx6czZjddNbYAh
         2jrA==
X-Gm-Message-State: ACgBeo1I9CFmkbmmxu/F3Kn9dB1tDfubwhDaRNHs+qjX3KICy/d0iQL4
        BeVygmLOaE9VuEbQ3h5ybB050FlvKyeUlepK
X-Google-Smtp-Source: AA6agR4u4BvlM/9iAHgtwXaT7uSI8+FBhSL8xrlmU3bF+vRMEGIsIBnljKY7isbFKHhLwk9D2IpIOg==
X-Received: by 2002:a05:6512:2989:b0:48a:f4b9:84bf with SMTP id du9-20020a056512298900b0048af4b984bfmr9836809lfb.39.1660118721868;
        Wed, 10 Aug 2022 01:05:21 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id h12-20020a2ea48c000000b0025e040510e7sm309571lji.74.2022.08.10.01.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 01:05:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] ARM: dts: qcom: msm8660: override nodes by label
Date:   Wed, 10 Aug 2022 11:05:15 +0300
Message-Id: <20220810080516.166866-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220810080516.166866-1-krzysztof.kozlowski@linaro.org>
References: <20220810080516.166866-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using node paths to extend or override a device tree node is error
prone.  If there was a typo error, a new node will be created instead of
extending the existing node.  This will lead to run-time errors that
could be hard to detect.

A mistyped label on the other hand, will cause a dtc compile error
(during build time).  This also reduces the indentation making the code
easier to read.

The pre/post DTBS are the same.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660-surf.dts | 41 ++++++++++++-------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8660-surf.dts b/arch/arm/boot/dts/qcom-msm8660-surf.dts
index 414280d9bdba..63b8f4285ace 100644
--- a/arch/arm/boot/dts/qcom-msm8660-surf.dts
+++ b/arch/arm/boot/dts/qcom-msm8660-surf.dts
@@ -16,14 +16,6 @@ chosen {
 	};
 
 	soc {
-		gsbi@19c00000 {
-			status = "okay";
-			qcom,mode = <GSBI_PROT_I2C_UART>;
-			serial@19c40000 {
-				status = "okay";
-			};
-		};
-
 		/* Temporary fixed regulator */
 		vsdcc_fixed: vsdcc-regulator {
 			compatible = "regulator-fixed";
@@ -32,21 +24,16 @@ vsdcc_fixed: vsdcc-regulator {
 			regulator-max-microvolt = <2700000>;
 			regulator-always-on;
 		};
+	};
+};
 
-		amba {
-			/* eMMC */
-			sdcc1: mmc@12400000 {
-				status = "okay";
-				vmmc-supply = <&vsdcc_fixed>;
-			};
+&gsbi12 {
+	qcom,mode = <GSBI_PROT_I2C_UART>;
+	status = "okay";
+};
 
-			/* External micro SD card */
-			sdcc3: mmc@12180000 {
-				status = "okay";
-				vmmc-supply = <&vsdcc_fixed>;
-			};
-		};
-	};
+&gsbi12_serial {
+	status = "okay";
 };
 
 &pm8058 {
@@ -76,3 +63,15 @@ MATRIX_KEY(5, 4, KEY_MENU)
 		keypad,num-columns = <5>;
 	};
 };
+
+/* eMMC */
+&sdcc1 {
+	vmmc-supply = <&vsdcc_fixed>;
+	status = "okay";
+};
+
+/* External micro SD card */
+&sdcc3 {
+	vmmc-supply = <&vsdcc_fixed>;
+	status = "okay";
+};
-- 
2.34.1


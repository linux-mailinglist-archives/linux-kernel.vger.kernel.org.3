Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3F9569589
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiGFWyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiGFWy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:54:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2777C2B1BE;
        Wed,  6 Jul 2022 15:54:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id f23so5227959ejc.4;
        Wed, 06 Jul 2022 15:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m28VOuBTGpNfCnRFT81/8lTctjXJrlSyC2RBUZE6DTA=;
        b=qB4XMv9Z9mwRIHcOXaeGCzvqHITF3Rr5WZQvVQHZ55xKR1ErgYbyyrAegfAoAZ8qLU
         VxtDJY64nyBOIuTDMbzQkhEfH3k4c4bRL/taTZ7KKVt+slfv0ipRXABRvK7hKr6YY4cH
         LpT4Thh8PbcAtYG438L4GPc7QdhJoVAg32txf/L5F/TorCscqAugUvgj+HAJiSX6o9ZF
         8j7vwuYz+TCv8e1uLQ1B7jYpo8g/FyzBdbNRYJBZqfRLr+PF6izT8ZFzlVFInRvzWRbV
         Hw5geZs8yqbTNuYx0z7tvY4pMKXv+cDaMFcNjGyiOJyZFkmkaQ/oJZq6Kgud9IvocIni
         iMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m28VOuBTGpNfCnRFT81/8lTctjXJrlSyC2RBUZE6DTA=;
        b=NSe9j1eCWQHZSg0+NHrzHZ/iubO2gmS7hCuLD+JtR52i7pgPQqyUyl70SjaH4XNzWf
         oyIR50rJjoTYOX13456RAou2gqGkUJWrHowUgEN3aqxM+5Yy5ErkrcOkwZbbtSTElJ37
         WbDl88j9gBEwzcL3afbp6p5Tjoa0MDFmjQfQUnshSVdqB8w5S3udLUeo1YKccx1UWjkj
         Eu76vyBkOoX/XgJvnnvbCP6xoLkc/LrFSGPRryFJBWcNkmDC9caCXFGc6iZReT0FyM0O
         NiI7Yp2TEDwONSxMHfHVTCcz7KdfrQOWDvmmgbreEbTC0H8R/NKyDBEl2SWbkxbHt8fS
         Ub1A==
X-Gm-Message-State: AJIora8IXdR/EbDizb5vZmkiAh6WNGXc2QFhrjecfYzGIOZ6iAkDG+0U
        n93ManjVB0TPRsxB3bEuTm4=
X-Google-Smtp-Source: AGRyM1tAISUPgzUk0jqnkPXsXqjqBCW5K0OcYjUxvbGqk7Kziy/5s7SHFSEUD7+BgdkGam0TIVkYnQ==
X-Received: by 2002:a17:907:a06e:b0:72a:e777:451c with SMTP id ia14-20020a170907a06e00b0072ae777451cmr10298763ejc.41.1657148066666;
        Wed, 06 Jul 2022 15:54:26 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id d7-20020a170906304700b006fe921fcb2dsm1767637ejd.49.2022.07.06.15.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:54:26 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 2/4] ARM: DTS: qcom: add rpmcc missing clocks for apq/ipq8064 and msm8660
Date:   Thu,  7 Jul 2022 00:53:19 +0200
Message-Id: <20220706225321.26215-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220706225321.26215-1-ansuelsmth@gmail.com>
References: <20220706225321.26215-1-ansuelsmth@gmail.com>
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

Add missing rpmcc pxo and cxo clock for apq8064, ipq8064 and
msm8660 dtsi.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 2 ++
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 ++
 arch/arm/boot/dts/qcom-msm8660.dtsi | 4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 91adcbd54b17..6a88e616ea01 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -853,6 +853,8 @@ rpm@108000 {
 			rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-apq8064", "qcom,rpmcc";
 				#clock-cells = <1>;
+				clocks = <&pxo_board>, <&cxo_board>;
+				clock-names = "pxo", "cxo";
 			};
 
 			regulators {
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 4b475d98343c..1425a4e4283f 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -773,6 +773,8 @@ rpm: rpm@108000 {
 			rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
 				#clock-cells = <1>;
+				clocks = <&pxo_board>;
+				clock-names = "pxo";
 			};
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index b9cded35b1cc..63a501c63cf8 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -56,7 +56,7 @@ cxo_board {
 			clock-frequency = <19200000>;
 		};
 
-		pxo_board {
+		pxo_board: pxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <27000000>;
@@ -411,6 +411,8 @@ rpm: rpm@104000 {
 			rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-msm8660", "qcom,rpmcc";
 				#clock-cells = <1>;
+				clocks = <&pxo_board>;
+				clock-names = "pxo";
 			};
 
 			pm8901-regulators {
-- 
2.36.1


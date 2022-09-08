Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCB55B168E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiIHIMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiIHILf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:11:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A7F5F9A2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:11:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq23so26445076lfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WbrJFxDN9M+roX+wTBZIP2zZRkjGZwlxDva2DwfHcBI=;
        b=hstIHa10wYZKdgbw+bwt6JUfeyCTmPPR9hwh1lj7fJs4QOwKFX460qW1FomRilmzci
         bXy+QToiGA6WTLaGBDzzdVe+MRM+lF9NtM/fee65hKXEa6/5ZoLYLfWgBwzrkr147tBy
         W7CZe8MoZZx7ADo4ITLXY+CglVlrkPobX/k2re21D8DxwdZW/T9yVnt0zHy4XHurQ7aI
         KopgJy/c9I0SGxL5lhglFIFi8vhQem5048iLPvz9GUhSYj7uInFPPm44LiEEbYoN8Dkm
         ZBOPdCpWR5vl1+fZWHMtE5+tvY1rQslPWVhd6KpONcE2PrSU9Sm05kitVekxpCasBYYd
         uAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WbrJFxDN9M+roX+wTBZIP2zZRkjGZwlxDva2DwfHcBI=;
        b=cr5fO9Nwh9qUhv9cCFwah+MBj0zX0eWQzhDufJ1xgydTRLTxOp8l7skMegFo7d4W/q
         vKMkuzumKRRtrbIiv4uiVTZUNLfta7lQsOl+TavhzzmuGf+I/doBzUTHMH2OHnIT3AgL
         BaaEBtV1a/YMD5/v/4ueIPHLLS/8sjWmzzqTcxY7toGNJgvfPlL2fNzDW2rn0LFOzylC
         KM3lvTU2UMr0RWEolOOnZkcolAStpN+7U8p25J/sswzQVAuMcCDx2iFjS+ZaK6V4nIaU
         9twyCnu6mHq+OFG97A+8BGoZvK/Zp5eU2XzkpDcKjUh0lXBJnKokGJNKTSwzSuyrmGfq
         Umkw==
X-Gm-Message-State: ACgBeo0P14JEOsEy0oqNWYI8JRTzxt3Brrb838l9411X4mpuB3dv/MtI
        s/ZToF8e59lfEsEj5ZF4lVjM+ltmQswVpA==
X-Google-Smtp-Source: AA6agR65kCJXgGOmiLBCOsmHznD6sp8G9/H9QT459/kOlCrrMh5qBYGusq3dde2OIsxeWsgvigZYww==
X-Received: by 2002:a05:6512:1393:b0:48d:6f0:64c7 with SMTP id p19-20020a056512139300b0048d06f064c7mr2221626lfa.20.1662624658338;
        Thu, 08 Sep 2022 01:10:58 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u18-20020a05651c131200b00261e7e7b698sm3075777lja.123.2022.09.08.01.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:10:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/5] arm64: dts: qcom: sa8295p-adp: add missing gpio-ranges in PMIC GPIOs
Date:   Thu,  8 Sep 2022 10:10:50 +0200
Message-Id: <20220908081050.29751-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220908081050.29751-1-krzysztof.kozlowski@linaro.org>
References: <20220908081050.29751-1-krzysztof.kozlowski@linaro.org>
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

The Qualcomm PMIC GPIO bindings require gpio-ranges property:

  qcom/sa8295p-adp.dtb: pmic@8: gpio@c000: 'gpio-ranges' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index 98f8420488b6..b608b82dff03 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -186,6 +186,7 @@ pm8450a_gpios: gpio@c000 {
 			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
+			gpio-ranges = <&pm8450a_gpios 0 0 10>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -202,6 +203,7 @@ pm8450c_gpios: gpio@c000 {
 			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
+			gpio-ranges = <&pm8450c_gpios 0 0 10>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -218,6 +220,7 @@ pm8450e_gpios: gpio@c000 {
 			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
+			gpio-ranges = <&pm8450e_gpios 0 0 10>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -234,6 +237,7 @@ pm8450g_gpios: gpio@c000 {
 			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
+			gpio-ranges = <&pm8450g_gpios 0 0 10>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-- 
2.34.1


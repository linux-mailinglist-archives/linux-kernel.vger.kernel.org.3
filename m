Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB67851BE46
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358407AbiEELmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350382AbiEELl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:41:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9730A53E14
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:38:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a1so4866816edt.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 04:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yzN3FtomMSFQXU8U8DdUxmokxQ+geUR12BbvG9ovSgk=;
        b=qc/bdjCFTaKD5+74QcqLb+atIW0PQikRXnVek6x0CCPDQ6FmKNj8WfJiYWdvTKXKdd
         sIo/zvKAzyXlHhfMwnrEHd9pPVJfXLdPmTmBGpLsDEAE1L8Pc4vNGmpSUhPXFvNa9vHT
         cYc3iFkh9gvs8XIU9M8Pf/phQUkpQbH1FTNe1X1W3Px1MZAvAUbG6t34+BzVTscITInJ
         qh+RQFOFc77tD19EV3NDywtp7Mkq0rWjxzTeUXN15eGRIwqy2Xq2EFA1WYUeWr5O9saE
         KXdYMmy8liuvt0GZUfbuADBzsUGAtWS14lFafOpTnUGtDzRcVZpvf6s0orDvAvVXQjAo
         peiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yzN3FtomMSFQXU8U8DdUxmokxQ+geUR12BbvG9ovSgk=;
        b=j6wXhQhhaVQuOlujKnmkEFL9PM+WZzJBiGlAQkpszagl/7+2Ni6OuIcODvLzb8898l
         iuXsOJjReNBxiogMACNJF6pvXDpuLItfBW+VTQDKwqC4d9Oq7P1T7r4ik1zc9NB5IFXZ
         kaWTMGOXmvEOTkqkg22XmBP70WbREV7yAhzPIjVg2aJQ/6RiB/vU1u6A45IrDC5woygo
         1MX93FByqQ47Y89bTKBkKhIF4hEjEvN4O/8J0PZ9rWZHr4R72eOFtm/8wLt/eRlHQ1QE
         fwRzwleCb0bPWjln/dZ07BOr7V34bttV9K9UMyVKsCzsbkh0Izu2UA/OdGU7fxxseu8W
         Q5qw==
X-Gm-Message-State: AOAM531m1g/4+x0wxajot8hDa0QmLh4KNiHC5RL/v+ooiC2A6P9rPnkE
        maSFNbQW3b7UQZkw29eJ9pV1rQ==
X-Google-Smtp-Source: ABdhPJwyZ0bkH/7KxfvogHNZ3lnAZ5Zds5SQZM3wZx3qP4qu1BIZGmFbnitcT/AtZ9iPouelFQfblw==
X-Received: by 2002:a05:6402:268d:b0:428:c73:95c4 with SMTP id w13-20020a056402268d00b004280c7395c4mr10208557edd.44.1651750691010;
        Thu, 05 May 2022 04:38:11 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709063b0900b006f3ef214db6sm661006ejf.28.2022.05.05.04.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:38:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/6] ARM: dts: qcom: use dedicated QFPROM compatibles
Date:   Thu,  5 May 2022 13:37:58 +0200
Message-Id: <20220505113802.243301-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505113802.243301-1-krzysztof.kozlowski@linaro.org>
References: <20220505113802.243301-1-krzysztof.kozlowski@linaro.org>
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

Use dedicated compatibles for QFPROM on APQ8064, IPQ8064 and MSM9874,
which is expected by the bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 2 +-
 arch/arm/boot/dts/qcom-apq8084.dtsi | 2 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 34c0ba7fa358..3bf870b7de00 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -796,7 +796,7 @@ ref_muxoff: adc-channel@f {
 		};
 
 		qfprom: qfprom@700000 {
-			compatible	= "qcom,qfprom";
+			compatible = "qcom,apq8064-qfprom", "qcom,qfprom";
 			reg		= <0x00700000 0x1000>;
 			#address-cells	= <1>;
 			#size-cells	= <1>;
diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index da50a1a0197f..503b4ae9fb1a 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -242,7 +242,7 @@ apcs: syscon@f9011000 {
 		qfprom: qfprom@fc4bc000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "qcom,qfprom";
+			compatible = "qcom,apq8084-qfprom", "qcom,qfprom";
 			reg = <0xfc4bc000 0x1000>;
 			tsens_calib: calib@d0 {
 				reg = <0xd0 0x18>;
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 808ea1862283..b3c0d140e6a0 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -723,7 +723,7 @@ qcom,ssbi@500000 {
 		};
 
 		qfprom: qfprom@700000 {
-			compatible = "qcom,qfprom";
+			compatible = "qcom,ipq8064-qfprom", "qcom,qfprom";
 			reg = <0x00700000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 814ad0b46232..5d2ab5ceb65c 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1120,7 +1120,7 @@ restart@fc4ab000 {
 		qfprom: qfprom@fc4bc000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "qcom,qfprom";
+			compatible = "qcom,msm8974-qfprom", "qcom,qfprom";
 			reg = <0xfc4bc000 0x1000>;
 			tsens_calib: calib@d0 {
 				reg = <0xd0 0x18>;
-- 
2.32.0


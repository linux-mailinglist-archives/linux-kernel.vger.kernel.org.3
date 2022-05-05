Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9B751BE44
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358469AbiEELmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358327AbiEELmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:42:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FE55418C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:38:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bv19so8173323ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+WqpoGIdyJSyDNz1/n0SzZvxTxflnlsJs1yAYSXzCKI=;
        b=CcZviteHoGf4SavUw+2Kf8Kl3r6Gkj+vE61AgfDlE8ltjTT0+hq7383KQ0wgazC+5P
         fgC+CKPLKQW5zj4lB/0CWTsNISZDhE2M3dB02xlTKsdQL6Tg0XTid8GRTX13n04Owhlc
         P5fPgfxf4BajSZE6DGWMCuoGmhNkiTfW+NjU3Bv5UCYK2eT6eTnuA5XKfu6YqP11bEe3
         AloazsbQ7beAFq9noP5KpbNOFFe5ub20LtjIkJ31ogzniUeP1/eqkeI6tBbfTRzG3rXX
         PMKFzdj4Pri6NFMMjyEAVyrB2ftBkfVQWHR4hW2gcjS3uKXTpfOSsAea5dL86avqyKkn
         LNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+WqpoGIdyJSyDNz1/n0SzZvxTxflnlsJs1yAYSXzCKI=;
        b=ig2cC0xD1k78TrvQMhKvPsGlFMj+tGh2N0p0QOSoBEKKxdQsbeVXTZkqnqLCKP0bXq
         p7jltL3TtHhXNxHEI4IFWfmq1uL06mSeTMbGe0r8k90q/wyl8ps3GLMosB2bZ44xC8bE
         kaU/RxvcApfGDJpR9MILrn8uhb89cmAIt/z9Yr3Wp8YKkXqBmQlvL8PyGWo7kd8jVshq
         +/qPbEIiJh8iaByE+6gzzuxycGHFk27fUa1YeK+LxeMZ7YzrkdswNvtqnCoMuhF//oQH
         pPAFQjwV7Le0NbQBAH85x33mNA1m7nppJlDJySlb2U7H0qaEIs7IYX7RAJPt22NR5cuy
         IGxQ==
X-Gm-Message-State: AOAM532mHcj8fsK9dqsj9OgACTYWFAp3fv4jJVAn3S8VvojYRkhWT5Vc
        /vUYWlUhU86a1Myi554MEd81jw==
X-Google-Smtp-Source: ABdhPJwBtr2Kpwz2XJmTimebmxreUwlReI5+UblLmCc+D7UtsZUoQroXYJ8kFuYvwHG8hvBSNIliFw==
X-Received: by 2002:a17:906:5811:b0:6e8:47dd:c55d with SMTP id m17-20020a170906581100b006e847ddc55dmr25829706ejq.191.1651750694608;
        Thu, 05 May 2022 04:38:14 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709063b0900b006f3ef214db6sm661006ejf.28.2022.05.05.04.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:38:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/6] arm64: dts: qcom: use dedicated QFPROM compatibles
Date:   Thu,  5 May 2022 13:38:01 +0200
Message-Id: <20220505113802.243301-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505113802.243301-1-krzysztof.kozlowski@linaro.org>
References: <20220505113802.243301-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dedicated compatibles for QFPROM on MSM8916, MSM8996, MSM8998,
QCS404 and SDM630 which is expected by the bindings:

  msm8996-mtp.dtb: qfprom@74000: compatible:0: 'qcom,qfprom' is not one of ['qcom,apq8064-qfprom', ...

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 05472510e29d..d2468081c4d2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -436,7 +436,7 @@ restart@4ab000 {
 		};
 
 		qfprom: qfprom@5c000 {
-			compatible = "qcom,qfprom";
+			compatible = "qcom,msm8916-qfprom", "qcom,qfprom";
 			reg = <0x0005c000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 9932186f7ceb..ab95ec4a7491 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -650,7 +650,7 @@ rpm_msg_ram: sram@68000 {
 		};
 
 		qfprom@74000 {
-			compatible = "qcom,qfprom";
+			compatible = "qcom,msm8996-qfprom", "qcom,qfprom";
 			reg = <0x00074000 0x8ff>;
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 758c45bbbe78..9b8e5767fdb6 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -838,7 +838,7 @@ rpm_msg_ram: sram@778000 {
 		};
 
 		qfprom: qfprom@784000 {
-			compatible = "qcom,qfprom";
+			compatible = "qcom,msm8998-qfprom", "qcom,qfprom";
 			reg = <0x00784000 0x621c>;
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index d912166b7552..1cdbe6645f2a 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -366,7 +366,7 @@ usb2_phy_sec: phy@7c000 {
 		};
 
 		qfprom: qfprom@a4000 {
-			compatible = "qcom,qfprom";
+			compatible = "qcom,qcs404-qfprom", "qcom,qfprom";
 			reg = <0x000a4000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index b72e8e6c52f3..505e10674cb6 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -552,7 +552,7 @@ rpm_msg_ram: sram@778000 {
 		};
 
 		qfprom: qfprom@780000 {
-			compatible = "qcom,qfprom";
+			compatible = "qcom,sdm630-qfprom", "qcom,qfprom";
 			reg = <0x00780000 0x621c>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.32.0


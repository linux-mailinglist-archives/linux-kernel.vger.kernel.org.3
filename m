Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169A54EFAEB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351863AbiDAUNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351714AbiDAUMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:12:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0255521F771
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:10:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i27so977363ejd.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IQGxa9YyQHssOaxTF+81MuRID8PvCkcvsqC5/ruRgAI=;
        b=ajcIgZ21mlt1P7xVB3m97uhBbo5eq9fYAbL84nRjPnprks1EJmazXbOpopDpf0XuyL
         XEnFLk7v9NZCqLt3/z4Zhy5hOsPdYsLc4TIhl8KaBnc5ynF1xhyyvR2EaHoH+JuDQalM
         +zVUeT4Tdxc+Tn8z5m5xG/XFuyrvXceX1Jp2YXWa9ahN7rZpGFL7kODXiMa7E9o/W3NJ
         uzBXMLc6vqCgbQT9me/LD8y2TQlyeO9ZxEFdhSlgGiquLcJlVeox4QMCThDlwfUi5J+x
         eaCIdvdo40ucoE99DXM4HOmI2DD/RvREBnknpJhcIBlKcxs7Ixf1W6lm95DGQTiEvF9O
         LdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IQGxa9YyQHssOaxTF+81MuRID8PvCkcvsqC5/ruRgAI=;
        b=6c5g1EqujOfx9VWCxSR031CfGOureSeuC2QEf1Fd5A4zngTbUDCyL0stJVb8bgex16
         566QeBlv5aRet08OC0KiZPRYVb6C58UcnWJeKL1JvliP58CLKb0WH75rpjCLWmkN0U7t
         guTJRatmT2KLGHEAH09RAwkRHzOwPwF4WcLcfWQpnfpyfv241CJAtZvneCkNcHLrQH9c
         56lU3F+QOz+F1hDtvYaArM/cqIEP1h/g3gdX0nrN7KneXA/CkW76Pk01l+Xwiyx//pYc
         uTPV7DKMLN5hiU7iwyfKcnI7wAPJlgVuXq2iZS5jbKbxcXWTTnTwBHhiaxEx5IC21MAp
         bsEA==
X-Gm-Message-State: AOAM531+e8hxfHDxPD0shovxm5vGozgzc4MFhW0nu6kUbwXAa7eYdjKi
        vuIBHmBPzwn9WQiQTsiOpZMAMA==
X-Google-Smtp-Source: ABdhPJxTegazsyWBxTRPRVL6sJAU+mF+4gQcuAxJyef2+FyKoXIYO8kcy4rB3U3DTP4WBWFTuW6nyw==
X-Received: by 2002:a17:907:a40e:b0:6e0:5c84:9ced with SMTP id sg14-20020a170907a40e00b006e05c849cedmr1314966ejc.284.1648843852371;
        Fri, 01 Apr 2022 13:10:52 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bx5-20020a0564020b4500b00418fca53406sm1509041edb.27.2022.04.01.13.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:10:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 07/10] ARM: dts: qcom: do not use underscore in node name
Date:   Fri,  1 Apr 2022 22:10:32 +0200
Message-Id: <20220401201035.189106-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org>
References: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org>
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

Align RPM requests node with DT schema by using hyphen instead of
underscore.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 8 ++++----
 arch/arm/boot/dts/qcom-apq8084.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index a1c8ae516d21..33a4d3441959 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -227,7 +227,7 @@ smem {
 	smd {
 		compatible = "qcom,smd";
 
-		modem@0 {
+		modem-edge {
 			interrupts = <0 37 IRQ_TYPE_EDGE_RISING>;
 
 			qcom,ipc = <&l2cc 8 3>;
@@ -236,7 +236,7 @@ modem@0 {
 			status = "disabled";
 		};
 
-		q6@1 {
+		q6-edge {
 			interrupts = <0 90 IRQ_TYPE_EDGE_RISING>;
 
 			qcom,ipc = <&l2cc 8 15>;
@@ -245,7 +245,7 @@ q6@1 {
 			status = "disabled";
 		};
 
-		dsps@3 {
+		dsps-edge {
 			interrupts = <0 138 IRQ_TYPE_EDGE_RISING>;
 
 			qcom,ipc = <&sps_sic_non_secure 0x4080 0>;
@@ -254,7 +254,7 @@ dsps@3 {
 			status = "disabled";
 		};
 
-		riva@6 {
+		riva-edge {
 			interrupts = <0 198 IRQ_TYPE_EDGE_RISING>;
 
 			qcom,ipc = <&l2cc 8 25>;
diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 52240fc7a1a6..da50a1a0197f 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -470,7 +470,7 @@ rpm {
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-			rpm_requests {
+			rpm-requests {
 				compatible = "qcom,rpm-apq8084";
 				qcom,smd-channels = "rpm_requests";
 
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 02b73739b6f3..2035be2fb8c4 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1614,7 +1614,7 @@ rpm {
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-			rpm_requests: rpm_requests {
+			rpm_requests: rpm-requests {
 				compatible = "qcom,rpm-msm8974";
 				qcom,smd-channels = "rpm_requests";
 
-- 
2.32.0


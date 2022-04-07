Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E074F81AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiDGOdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343974AbiDGOdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:33:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756B7193B61
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:31:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n6so11171522ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1dGsa63pN5ZCpPNmL+yHmV0saMkrSamork3Ro7pz95A=;
        b=lzawayGe4kvEZoU44kV2Zp3WVKdDm74l6mN4itLMS6vW7M5+9KJ4LX6sLynuLMewzc
         t7SIC1oUag2E9uBTpMfamda7cow33xiUxApC1kRuX7qXBgVutECBOWLEsc9BFyNoUkT3
         6QronoYWoOPND5Gvc2xDhh/QPsfOWHkeHrjDlqMZaTIF/Xg6k9J/Xh5MCjsT9eO4jLGx
         4R1hbks0u/1yHCQZBrCIATmcaFfXyYFIR3j4BppV80foC3VuhRd9tyFENy6vs5qpCtcU
         Q0XuSKOlnE7oqSHzPpwZAs9b4FwmJyZDZBsbW+0Wo29xADRB2cd1ahKdtuCK6pRAyW+H
         kvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1dGsa63pN5ZCpPNmL+yHmV0saMkrSamork3Ro7pz95A=;
        b=Iw5eSkwBclKhpa9YtKJKSrUz+ILCa5hRJJkKuYpJOWr2SgplfHh9ph0bU9ZHNtxmf+
         8r4B8oH19NBqCdRapCjoznIVIAwuN9nWJhbjstvdsEvnp6o9SlrmPa3Tf976SJTwzZSS
         sXNkktlhtvkHJYn7eLCjZXleyOxrFn7M65r/hJlkyv1H2mjJHi4C02YQVrIvLmRNe3/q
         HRDZDJGOMqITYraNkZCNLVjXmXq+uKcVI0n1nUq/+t8aoOO3a3Vxu95pewxu/qaWmacb
         SyCWsReDqMn00yOcemqX3NRgiXOi4uqawQIJqPNERB4ZVDHi7c+YXuMXeWk+eTV1Fdg3
         2LTw==
X-Gm-Message-State: AOAM531GLOotOWi9brhe203UnVRWYALG+0yWB09yNdWA/lolTNOUgemo
        0g9rKIYtQII4vnzsABT6z2UQmw==
X-Google-Smtp-Source: ABdhPJxTs9WXr5O7Qgw7WMq45QbwfU6vyNcl7pT6FYicHQXEU2XTEa1goyB1Qf1FL/s4CTskAnETdA==
X-Received: by 2002:a17:906:cc93:b0:6e0:afec:b005 with SMTP id oq19-20020a170906cc9300b006e0afecb005mr13406163ejb.219.1649341876815;
        Thu, 07 Apr 2022 07:31:16 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090654c300b006e4e1a3e9d5sm7256670ejp.144.2022.04.07.07.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:31:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:31:12 +0200
Message-Id: <20220407143112.294930-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407143112.294930-1-krzysztof.kozlowski@linaro.org>
References: <20220407143112.294930-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts | 2 +-
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts    | 2 +-
 arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
index 5aec18308712..821cb7c0c183 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
+++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
@@ -39,7 +39,7 @@ &spi_0 {
 	cs-select = <0>;
 	status = "okay";
 
-	m25p80@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0>;
diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
index b5e1eaa367bf..de20cb98acd3 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
@@ -35,7 +35,7 @@ &blsp1_i2c2 {
 &blsp1_spi1 {
 	status = "okay";
 
-	m25p80@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi b/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
index 07e670829676..ce86d9b10d69 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
@@ -29,7 +29,7 @@ memory {
 &blsp1_spi1 {
 	status = "ok";
 
-	m25p80@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD1A540503
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345929AbiFGRUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345682AbiFGRTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:19:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0270A1053C3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:19:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fu3so35072160ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pR4NnTWcMQlG0JQ/8qorgUfKIVfrcLKapXl8vOZUk2w=;
        b=MbKLkIIECWTUyLE/Df/LNymmAAe7dGCLLVOo/IcMeiRHnCive+XGclpUU8VS8i3aD0
         3A5h797NiJFenxlBcOaiVTrCtrQSGovzYaQ5zvDj81SuOBPUcQiGK1iyeXGFwJCb2hFh
         G5ogF+eAlIo0AFGvVyLJnuydKJyHJT1R+Uj8rrzpn6iOZ3YHDftSRiQw9c8A3lpfQ5Vo
         5RJycZfSa+KmciZg48nzkHAnsSQc9ZiDvZVem79yHkkOaZSwVV0roAU+L5tC8d/T3dbQ
         m6yDacDwiNR/0lHXn04rCy7/4tGq5nf5eCXzZBh+I3C4Zuj54zO1A3swSlJCKv18lVpu
         p33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pR4NnTWcMQlG0JQ/8qorgUfKIVfrcLKapXl8vOZUk2w=;
        b=scz+zLsl6+J/Z4I9juufQJctu3fOxfEFWYlzPUZsPAuI0hzy/vUjQCmpTO8p9tgTXc
         Ugs+POo/5b58c0g55kNeXXxq53pONKCzFc1Cndj6tgIFbNPBl/H+KCK1URw6ypMDtxhQ
         qHf6ilmug/CVDRjV5Ikin+I3iF0k02P1k/r50RmqbqFkBcju9CqTdOdkeNiOA+2lKHwR
         U3i28ixmmoglGrFUEBAhaXb6Cr++wb9LqURDKTxxTCfZSYDNNWW5iVKo67jjF0+T8FLk
         yQhsyyJrD18cgnGz3uVEoTZHGB10oqpIoQKQRgfKbVLM5rBSfEzXl8exPEjm8RMG0J4y
         szFg==
X-Gm-Message-State: AOAM533P91NZk7cVDNZx2pVLlxgKg46CbWiiVYMQ76MLIpFJMXPrqX5F
        85Jb1VzaUcT98V3wMLukolbuew==
X-Google-Smtp-Source: ABdhPJyIAd0bjmDLE+E8nBYdRYxPVNmQY8O79F9dP4MxjiiqwwZRaaf3ja0dJd+eSP1XMDrXZbhPPA==
X-Received: by 2002:a17:907:2cc3:b0:6fa:55f:8805 with SMTP id hg3-20020a1709072cc300b006fa055f8805mr27626881ejc.46.1654622339401;
        Tue, 07 Jun 2022 10:18:59 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i7-20020a170906444700b0070e238ff66fsm5876540ejp.96.2022.06.07.10.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:18:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 08/14] arm64: dts: qcom: use generic sram as name for imem and ocmem nodes
Date:   Tue,  7 Jun 2022 19:18:42 +0200
Message-Id: <20220607171848.535128-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
References: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
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

According to Devicetree specification, the device nodes should be
generic, reflecting the function of the device.  The typical name for
memory regions is "sram".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 0318d42c5736..0327c9941ae5 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -1069,7 +1069,7 @@ mmcc: clock-controller@fd8c0000 {
 					       <600000000>;
 		};
 
-		ocmem: ocmem@fdd00000 {
+		ocmem: sram@fdd00000 {
 			compatible = "qcom,msm8974-ocmem";
 			reg = <0xfdd00000 0x2000>,
 			      <0xfec00000 0x200000>;
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index d912166b7552..1cca749ac9fb 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1102,7 +1102,7 @@ blsp2_spi0: spi@7af5000 {
 			status = "disabled";
 		};
 
-		imem@8600000 {
+		sram@8600000 {
 			compatible = "simple-mfd";
 			reg = <0x08600000 0x1000>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 5dcaac23a138..496fc2857d92 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3247,7 +3247,7 @@ spmi_bus: spmi@c440000 {
 			cell-index = <0>;
 		};
 
-		imem@146aa000 {
+		sram@146aa000 {
 			compatible = "simple-mfd";
 			reg = <0 0x146aa000 0 0x2000>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index e66fc67de206..11fe2ed464d0 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4639,7 +4639,7 @@ sdc2_data_sleep: sdc2-data-sleep {
 			};
 		};
 
-		imem@146a5000 {
+		sram@146a5000 {
 			compatible = "qcom,sc7280-imem", "syscon";
 			reg = <0 0x146a5000 0 0x6000>;
 
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index b72e8e6c52f3..8d38c3d3c940 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1829,7 +1829,7 @@ blsp_i2c8: i2c@c1b8000 {
 			status = "disabled";
 		};
 
-		imem@146bf000 {
+		sram@146bf000 {
 			compatible = "simple-mfd";
 			reg = <0x146bf000 0x1000>;
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0692ae0e60a4..6e13aab15931 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4721,7 +4721,7 @@ spmi_bus: spmi@c440000 {
 			cell-index = <0>;
 		};
 
-		imem@146bf000 {
+		sram@146bf000 {
 			compatible = "simple-mfd";
 			reg = <0 0x146bf000 0 0x1000>;
 
-- 
2.34.1


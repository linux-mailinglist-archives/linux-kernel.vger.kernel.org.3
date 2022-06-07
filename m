Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D145404E4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiFGRTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345662AbiFGRS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:18:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3040D1053CE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:18:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v19so23867131edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95xSn5ZnLXJf8gOJTiH12x4Y2i7vMsP36HiT3AQ0fYQ=;
        b=WLHHjfo9g9OtC97Ni2SdnwCyNBlO3bH4M6XH4VmoqOFPxMwQh+og626C+6TxlPADAk
         lrcLFoTQGyO/g+iVGeVKRMwuu9T/ngU0SYD1CMGcKEYcEPDPc0dYWzGuYwTGtZzKiQue
         R3gJ068LyWhxJ2iodOnCH1MA95bWJO1RIaBgxsrNKOGdMVWKJlmYbYDfAMWORHr3JZ2G
         VoyYDPYbd+jkte9eGh8XzLl/ThfsZ9+JIlb0fEVKC/AcIDVY5ORqnPhVIK/23EYLeAH8
         kl4DkbgF5iWDslWhTWWAi6MLhFm54UIH+0/n5i7u2QPmGLG/QksLU4WlebWWJX8Vtbfj
         L27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95xSn5ZnLXJf8gOJTiH12x4Y2i7vMsP36HiT3AQ0fYQ=;
        b=FluvO33VxFGufS30jb6Ce7V5HmMByEsraEJXm1AKr9dHM82f//lqBOfBcNOA8bLxnT
         WstRTLWwLrg2UpbmSVOQulKRxwmj9voMVJMc9S8vJ2B7WubguEtHTHIy2q5IOq0aJfng
         j3GcxRvBdOz1Hh1g9AXY7aOPzExWeP773gJA6CPqp+EWOFCYi+LzPNe/xAWpwAkGRyTy
         ARJfEWDUfVCrnSVE0bZcEoGNVLuTTk/iM3AbTos/ARrU3a5WbAgZfSlgdHPp5r6c8OfL
         heOrRchEswPRglqtHXzTzoqzqUMKatKI84vBP50u56B+WLfB0Tdlpzrgzivgyzeh+5Rl
         oi5w==
X-Gm-Message-State: AOAM533U6WShMJpMHLSO9QoiaYMDe4TInOIYtVBQVGBk1bQEaeVa+z3x
        oUoS9fDUpGg11+nO601sqgH8gw==
X-Google-Smtp-Source: ABdhPJwJTxFyEVm/dLk4XAcF5mviLMRqjgStSv977bRQo2b9oBdyXECKGSidxoUJXmxfzthmnqIl1A==
X-Received: by 2002:aa7:c34d:0:b0:42d:ce57:5df2 with SMTP id j13-20020aa7c34d000000b0042dce575df2mr34430319edr.315.1654622334478;
        Tue, 07 Jun 2022 10:18:54 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i7-20020a170906444700b0070e238ff66fsm5876540ejp.96.2022.06.07.10.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:18:54 -0700 (PDT)
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
Subject: [PATCH 03/14] ARM: dts: qcom: use generic sram as name for imem and ocmem nodes
Date:   Tue,  7 Jun 2022 19:18:37 +0200
Message-Id: <20220607171848.535128-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
References: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
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

According to Devicetree specification, the device nodes should be
generic, reflecting the function of the device.  The typical name for
memory regions is "sram".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts | 2 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                | 4 ++--
 arch/arm/boot/dts/qcom-sdx55.dtsi                  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
index ca9f73528196..de01e34409f2 100644
--- a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
@@ -341,7 +341,7 @@ mmc@12400000 {
 			};
 		};
 
-		imem@2a03f000 {
+		sram@2a03f000 {
 			compatible = "syscon", "simple-mfd";
 			reg = <0x2a03f000 0x1000>;
 
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 814ad0b46232..09b181bb5365 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1603,7 +1603,7 @@ opp-27000000 {
 			};
 		};
 
-		ocmem@fdd00000 {
+		sram@fdd00000 {
 			compatible = "qcom,msm8974-ocmem";
 			reg = <0xfdd00000 0x2000>,
 			      <0xfec00000 0x180000>;
@@ -1650,7 +1650,7 @@ smd-edge {
 			};
 		};
 
-		imem: imem@fe805000 {
+		imem: sram@fe805000 {
 			compatible = "syscon", "simple-mfd";
 			reg = <0xfe805000 0x1000>;
 
diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 1c2b208a5670..710c7f772d42 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -561,7 +561,7 @@ tlmm: pinctrl@f100000 {
 			#interrupt-cells = <2>;
 		};
 
-		imem@1468f000 {
+		sram@1468f000 {
 			compatible = "simple-mfd";
 			reg = <0x1468f000 0x1000>;
 
-- 
2.34.1


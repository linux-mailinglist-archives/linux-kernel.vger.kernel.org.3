Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE317518516
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbiECNJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbiECNIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:08:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC4739168
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 06:05:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g6so33357058ejw.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YVZd3VX5yDYHZFsgN5vgd0V6QUlWGwER/REYExEMMg0=;
        b=csNpYjc4eRvrfqmATKfLTAmBvnvnCMLWE/GsmHyi6IhYJC98WztvFdjZffp5n3FDS2
         7EckGJqAWC/FlT/DzCFuRjoog4OHIRo4npSQUqjgopM9lf9Atxn+T9s8kJttJxf3tmif
         qkZJhdGaMA2f/H2eFtgin8YaIY97Sc7RR04ek4Q7m6NCTsDrDBYNnRfEp8Z0PkLMJKT1
         83X5i7OeJSSZ/qmcYY/xdH83H19Z32A/N+U0w0RwLWMVCCYbG0IfqOJTSn4xsInkEehg
         WzX9xycipOxRnlfkXk8vEIXkTPrKWO7xDk09UosYpR8K4DhEJgNCRh5YAM3WyKjwITH3
         +zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YVZd3VX5yDYHZFsgN5vgd0V6QUlWGwER/REYExEMMg0=;
        b=mFqemvjnHALbk2VxAtrEGO/e+Gj3VhUBRQtPcxGiE5RcyTmwIHWT9WdzslCGoCQAuw
         Msxx9DxqySge+dDaqNwCeAaYpUpdIr2D9eBku+w6NXo+VVR99q9Z0Us7YqxvVaBmAzHg
         6/8OKs98anCLx/NIQcX9eFvbMj63nBCQ2i5v2OjkP0HazXQjDu8DqmSDl3xa5dbzsYf6
         d+WMSj19+VNhyfUn0uoppgLiILaKg1sNBmC9XFJXBevdFeR0ydzQeSdXK1MmL7Vx8UZP
         qvi/jw/vxLiSFyGW5z4/IesVffir0yC5i7U91OktxoChPMBV0DifSOGgo/GsjUyeXCn0
         u3Qw==
X-Gm-Message-State: AOAM532Mom2xs2EDcjJV7zD7gMr7cRnQs6cyAuiBDRi6pmUWleoILcHU
        V/rRtEBNEddI7F3osWCWcq452A==
X-Google-Smtp-Source: ABdhPJxFX2C0kYEgEZ+7lW5XsDBQeItTn6bDarTIf1+s0VuH4ATzexJD24XtSi3M+wHrQMVybYQLZQ==
X-Received: by 2002:a17:907:d22:b0:6f4:8766:2042 with SMTP id gn34-20020a1709070d2200b006f487662042mr3434137ejc.259.1651583105046;
        Tue, 03 May 2022 06:05:05 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id y13-20020aa7cccd000000b0042617ba639asm7868782edt.36.2022.05.03.06.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 06:05:04 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca, tdas@codeaurora.org,
        anischal@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v2 8/8] arm64: dts: qcom: sm8350: Add DISPCC node
Date:   Tue,  3 May 2022 15:04:48 +0200
Message-Id: <20220503130448.520470-8-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220503130448.520470-1-robert.foss@linaro.org>
References: <20220503130448.520470-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dispcc clock-controller DT node for sm8350.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 52428b6df64e..94c2519e9f48 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -3,7 +3,9 @@
  * Copyright (c) 2020, Linaro Limited
  */
 
+#include <dt-bindings/interconnect/qcom,sm8350.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,dispcc-sm8350.h>
 #include <dt-bindings/clock/qcom,gcc-sm8350.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/dma/qcom-gpi.h>
@@ -2525,6 +2527,31 @@ usb_2_dwc3: usb@a800000 {
 			};
 		};
 
+		dispcc: clock-controller@af00000 {
+			compatible = "qcom,sm8350-dispcc";
+			reg = <0 0x0af00000 0 0x10000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>;
+			clock-names = "bi_tcxo",
+				      "dsi0_phy_pll_out_byteclk",
+				      "dsi0_phy_pll_out_dsiclk",
+				      "dsi1_phy_pll_out_byteclk",
+				      "dsi1_phy_pll_out_dsiclk",
+				      "dp_phy_pll_link_clk",
+				      "dp_phy_pll_vco_div_clk";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+
+			power-domains = <&rpmhpd SM8350_MMCX>;
+			power-domain-names = "mmcx";
+		};
+
 		adsp: remoteproc@17300000 {
 			compatible = "qcom,sm8350-adsp-pas";
 			reg = <0 0x17300000 0 0x100>;
-- 
2.34.1


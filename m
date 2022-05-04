Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4267D519F67
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349561AbiEDMbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349478AbiEDMbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:31:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC54031205
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 05:27:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l18so2556330ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSkVCDsS62zbNJ0pEY1QFDEvKoD+8WUgtpzbx395WvY=;
        b=DaRwqlhRNHO1EnPDdwOSWog92eK26kNofbp4s0Fos4zPvsnCS8Bjw19MFnUzy/QhJi
         8bsUbAldb5kFs7AwS8h4p4b37j3l1XHLSE1dst4bo26gViDCaf5QZjAlhCiKqwDUOHek
         nBjkv7BWGL/MKGEi2rZMDZNIicg80KiS48xn2SQJedhkTyBeaatWeDO+awOAGWsCy/5Y
         iFfTyA9lz4xt5o0ymwt7tp1oyiz5bqAI4AOF3T4D6kRhjZuDtWx/Z4Vw2SzrNm+/qG5q
         pka+cIaQ9ZJ8JWTodvy4Rls/W9X2jAxijLk/x/4xpc1SYUw7fdFW8QLouBN/vV/vyWnd
         HkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSkVCDsS62zbNJ0pEY1QFDEvKoD+8WUgtpzbx395WvY=;
        b=203pJJtE9JugVQi0AVeoKqF2MHQEB/eHhvh/j5v07hehzCkDp/Nz4FrjCKfj7vZQuY
         KKuWwRopMSaOYZ7elFhus1+ULE/F6u+47FOuEkk1sh2mT2t91XlFbe0nNXFmE+8ppqGg
         y0OP+Xlt7Z8a3pn8WXLcLau+1m7KmzRDiQPJ6T355n4FT75XB9nAAQq2pmJEC3ttEQhS
         rWOUXfhm2pbbQCdCAcXsQ9XWar1wc4KQNqmU9sqgnLS2qMMbVnhn8Pc/ZXpxZFurXblW
         9ZPX3hFaYz/7m6nFcNOZff+hdajjqieCpz/8J9SqIKnf3VcOSINlgRAwbA+y8wryqS7P
         sNNA==
X-Gm-Message-State: AOAM533AThQJNGRXBOK7Zkw1DQ6DhbFMiJmjJLY1BZMXxoBicfgyRmGA
        KJo3BNGX8lESriQ7YhFko3K6zA==
X-Google-Smtp-Source: ABdhPJwzeDWUbTfQMHvYIFofhoD3QAniWPEvnXcFRDNNGxaal3xPhaLMgDnS/4fcZIeiXrdarZQDHQ==
X-Received: by 2002:a17:907:3e21:b0:6f4:6c7c:c781 with SMTP id hp33-20020a1709073e2100b006f46c7cc781mr9972155ejc.735.1651667259320;
        Wed, 04 May 2022 05:27:39 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id mm30-20020a170906cc5e00b006f3ef214e06sm5675557ejb.108.2022.05.04.05.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:27:38 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v3 6/6] arm64: dts: qcom: sm8350: Add DISPCC node
Date:   Wed,  4 May 2022 14:27:25 +0200
Message-Id: <20220504122725.179262-7-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220504122725.179262-1-robert.foss@linaro.org>
References: <20220504122725.179262-1-robert.foss@linaro.org>
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

Add the dispcc clock-controller DT node for sm8350.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

Changes since v2
 - Remove interconnect include - Bjorn

 arch/arm64/boot/dts/qcom/sm8350.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 52428b6df64e..99464cd1299e 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,dispcc-sm8350.h>
 #include <dt-bindings/clock/qcom,gcc-sm8350.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/dma/qcom-gpi.h>
@@ -2525,6 +2526,31 @@ usb_2_dwc3: usb@a800000 {
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5A597262
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbiHQPAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240639AbiHQO7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:59:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88879D66D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:59:31 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id e15so19391549lfs.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pqtLuKgHuRzFaU11WfzhWYMqklF7F2EiVQK9EioMBZA=;
        b=zVPpjQIIJ8OmZ92w94YJtshV3DUIFfa+Sqk5BxI1ZsClxztkGJjBhiPARSPgLHGopT
         Ar/AIGTIzu98qmy2pxOzkAN7J/QBw4xQr3aREl/atoMEFblLRKD7xjXzMXXk3HtSB3vC
         CbG18pmQRG6ycJ0EzoWiqK9trc7RFc/G9baFUyZ+hkeCrpeZf2dcsyFXQdgwSYTr+8c9
         rLWeOZl6kMqoX6It/c5G4UTal4I6jJUrQUME9i0wms1ZtUPnIWCnBBRWC9yHXaiyLhB0
         fvBZiy3NcflbAk+OntwE8vemu8GQkUJrQovOzO1pTHhQiXV9lHAsQ+YtNNXMsfZCQDCC
         oseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pqtLuKgHuRzFaU11WfzhWYMqklF7F2EiVQK9EioMBZA=;
        b=MWkgsi8zHj6MbuaKl8ca3VU7P10oFbrx3FYNfAsNyiN4OCNaDHYxn3lqOB6kRgwIM0
         +kK7qqcaRTMT3JfHVcf0iiSUg+NNfKMPjQR6Sy0UTCB4lmcXL+URVKAeDzShg5G25S4k
         Gbi7ZOWh69d3xeuRTTOFlfxteODe49QXIdhPLj1LPOr1oyacWTTOnvkNVf95ZUmN5rPW
         oNis3Px7DVr8bWkuKGUDYTFJ9/SltiYchXHMMZCL6ir1Gm6+n404CkcB4EQmgFz5Pxgl
         /xGz1sNk3Scpbt8XLbtgSwF4iy/PFmpPgq9MXn7XnAP28TEoN5bxTrChgtgua4aoBK9i
         ORUg==
X-Gm-Message-State: ACgBeo1+VH0uLHQhIDnrY/AJEHIK07EjcCt56pKjfEVIq5aeB6xxLO3E
        pbhuYfUsEnjTcJGp28zaqywGUw==
X-Google-Smtp-Source: AA6agR6EoUfzyekWXNUBdFjRp12+JGAyFF1chak9jYX8ET7YJrLxhoX2SvIX49qYE+/+gC6arfYzuw==
X-Received: by 2002:a05:6512:304b:b0:48b:4a82:4d3f with SMTP id b11-20020a056512304b00b0048b4a824d3fmr9156053lfb.314.1660748371305;
        Wed, 17 Aug 2022 07:59:31 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id u16-20020a05651c131000b0025fdf9eec1dsm2250454lja.111.2022.08.17.07.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:59:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 14/17] arm64: dts: qcom: msm8994: switch TCSR mutex to MMIO
Date:   Wed, 17 Aug 2022 17:58:58 +0300
Message-Id: <20220817145901.865977-15-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817145901.865977-1-krzysztof.kozlowski@linaro.org>
References: <20220817145901.865977-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCSR mutex bindings allow device to be described only with address
space (so it uses MMIO, not syscon regmap).  This seems reasonable as
TCSR mutex is actually a dedicated IO address space and it also fixes DT
schema checks:

  qcom/msm8994-sony-xperia-kitakami-suzuran.dtb: hwlock: 'reg' is a required property
  qcom/msm8994-sony-xperia-kitakami-suzuran.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 8bc6c070e306..6a9bca6c2c5f 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -164,12 +164,6 @@ memory@80000000 {
 		reg = <0 0x80000000 0 0>;
 	};
 
-	tcsr_mutex: hwlock {
-		compatible = "qcom,tcsr-mutex";
-		syscon = <&tcsr_mutex_regs 0 0x80>;
-		#hwlock-cells = <1>;
-	};
-
 	pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4)| IRQ_TYPE_LEVEL_HIGH)>;
@@ -762,9 +756,10 @@ spmi_bus: spmi@fc4c0000 {
 			#interrupt-cells = <4>;
 		};
 
-		tcsr_mutex_regs: syscon@fd484000 {
-			compatible = "syscon";
-			reg = <0xfd484000 0x2000>;
+		tcsr_mutex: hwlock@fd484000 {
+			compatible = "qcom,msm8994-tcsr-mutex", "qcom,tcsr-mutex";
+			reg = <0xfd484000 0x1000>;
+			#hwlock-cells = <1>;
 		};
 
 		tlmm: pinctrl@fd510000 {
-- 
2.34.1


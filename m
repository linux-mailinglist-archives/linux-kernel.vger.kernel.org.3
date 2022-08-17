Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35940596F13
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbiHQNEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239567AbiHQNEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:04:07 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D87130555
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:03:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a9so18891671lfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DmgjoU3ZwmShD+iuLbm/N6H6WPhywoNwmKzID5e5568=;
        b=dOoNqvye8xquk0IPEbhQhqui+Qtl+FwGe6xO/9UzbcZeyzno5z0sjyTEDevwNPNzZI
         LxmTr+GSKl1380Nz1jq42Qouq+iXDy1mDR+N3uPjd0W7UCAgLQN985quLi+FE7hVk+GE
         jIOzlHwbLSvijTeh7RfHxO8wXCvrMeaUH0cSa2DTcQM3FToaO4IQGyySLej/+PqUnekK
         z3KGXi8UOxo7kxFjMnJDvEHVn1MzXQKy0Tjd5tizb1D+yQb3y43/Id+I2AtklPjn3em3
         2YbAQ2xzosOaW+DZHq4Y+HSSmZHaOwRL9vwIfsTzbjRJFJqWCB0X0cgYrHX9voJqMhqz
         OMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DmgjoU3ZwmShD+iuLbm/N6H6WPhywoNwmKzID5e5568=;
        b=boQI4gZtgqWTXY2DQY8jwbbfdMsU9AQx6xaCQuzwMYrlYAaRKVaIOe4/MEtGLeQVh1
         bwllvK+HTG+JVw3NSfG1XCSgMHP1e60b3N/uExX4em6Md0t2enWL61a11/9Mze6QmDV/
         AUcguhQZ1OWTd+7dmPsXTw4FnpsKriZXrmoZQKtCGLVEPs5oOxjyZXEFzoqv6Yuvn6NT
         hPRa5JjlpMN0x+KPN0OyYmXUbsqhPkNHmbzbaQ19D/OlWdvIpL3Y4IiPZbxCEdbEb5FR
         9Fou2b3cV/1eC6zaPEb2+WeB7Nsa+Co9RaMZ+KFcbdScoj51U3+sCb8QUzgcuzdtb0Ub
         Clrw==
X-Gm-Message-State: ACgBeo13W8u3sykT5re25Y3Kr7csFHpiI6M6HetRHH1KuZ8V2T2Chlz9
        Pq/aqoy1n1w2ZfZ2wbJcxdA5Lg==
X-Google-Smtp-Source: AA6agR6lqDxgMK9JFImwUaoMuhNueyu4AJdfFEi+SBN7qOkfEFKxa/ji1nEoI+8vSCoCDkGlSQ3nRw==
X-Received: by 2002:a05:6512:b89:b0:490:34f9:d1c6 with SMTP id b9-20020a0565120b8900b0049034f9d1c6mr8336696lfv.637.1660741434903;
        Wed, 17 Aug 2022 06:03:54 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id v1-20020ac25601000000b0048b3768d2ecsm1683243lfd.174.2022.08.17.06.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 06:03:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 03/14] arm64: dts: qcom: msm8996: switch TCSR mutex to MMIO
Date:   Wed, 17 Aug 2022 16:03:31 +0300
Message-Id: <20220817130342.568396-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817130342.568396-1-krzysztof.kozlowski@linaro.org>
References: <20220817130342.568396-1-krzysztof.kozlowski@linaro.org>
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

The TCSR mutex bindings allow device to be described only with address
space (so it uses MMIO, not syscon regmap).  This seems reasonable as
TCSR mutex is actually a dedicated IO address space and it also fixes DT
schema checks:

  qcom/msm8996-xiaomi-natrium.dtb: hwlock: 'reg' is a required property
  qcom/msm8996-xiaomi-natrium.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 3411ced96db6..166374566a49 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -363,12 +363,6 @@ scm {
 		};
 	};
 
-	tcsr_mutex: hwlock {
-		compatible = "qcom,tcsr-mutex";
-		syscon = <&tcsr_mutex_regs 0 0x1000>;
-		#hwlock-cells = <1>;
-	};
-
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the reg */
@@ -838,9 +832,10 @@ pnoc: interconnect@5c0000 {
 				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
 		};
 
-		tcsr_mutex_regs: syscon@740000 {
-			compatible = "syscon";
+		tcsr_mutex: hwlock@740000 {
+			compatible = "qcom,tcsr-mutex";
 			reg = <0x00740000 0x20000>;
+			#hwlock-cells = <1>;
 		};
 
 		tcsr_1: sycon@760000 {
-- 
2.34.1


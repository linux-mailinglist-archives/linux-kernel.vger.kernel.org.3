Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53136599761
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347293AbiHSIcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347472AbiHSIcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:32:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7319E990D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:22 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h5so4954880lfk.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=eD+vvaVGBlUcCXOKP3ANbRbef4Wta7oOIdhhSq0Fgqw=;
        b=w7xq+DeKlMgrmICZ39PCb/6Q8yvh730lY6ThiE6Ll7EFTlbvqgps24gBpg1JjHBKaZ
         eWyxoYwBe2niTLmtulRMg7V1e8JrCWBA+KR5a8L97cLSGVFYYZqAI+5hGuGbcHgfID0m
         Y/9nXpVJaE567RihAUPGmgxsYcQOcUdqytIafR1FpXS2b4GXYPznb5xc/zhmjnUew5es
         MPtD6R6dWK1VwWoKWJoq1EnJHEvdoeip6tNada3AWbAUXQL2MVKCoVDt5/viyOiMYaNV
         E4PCAVT7cOpwfK8eal5W6TrnTfhK1NW7Yxi2z4GatkXaqDmIex1iI3uqJ0kyLCRFjdtv
         2vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eD+vvaVGBlUcCXOKP3ANbRbef4Wta7oOIdhhSq0Fgqw=;
        b=y75FuLMFwrHYcqxfvri0mW2mzvEIF+PVKHfjlN/N64eIXe5h7Ev/FVrbsvfqWioOuV
         nPGa4ONY5hKDE/6Xxr+nODW1RwZr6qJjAy9y2XNS6CvgekrjLoOkfuqkKSlPDTuAAbro
         tChoXiECpR6WSA7FAiDd4AXaRCcEXuFxby3Nsnq2fFwTwQIzumf+yN/TVV+E8vstCZ4n
         nLPsoa9FrxCUxWzy/zMdteIYIBli9+uiqT55t9hNxMCe/IX3BT0ZI/a2+Jv9SlK9qtwq
         7a+7Xmglu6bVlk92w1oagkGy6p/JkPXJsSyyS9hT7t7LmB2PkNaPMGyS0ntoewJVYSpa
         Inrg==
X-Gm-Message-State: ACgBeo3th8IKaf+5wBz8u9mAMk4R2u8yydlxA6RTHzJrgyw8muxbi7G+
        BsgpDTIy83+tXRqKClmAT9mvxF7PSXwHfzHp
X-Google-Smtp-Source: AA6agR4AdJbHeukS6kjEOmGNyNW4p1APIhICE/o1N4MSxFkbRJiScDApC1w50+Jh+Im7FEGG7tSNdg==
X-Received: by 2002:ac2:482d:0:b0:48b:2373:9980 with SMTP id 13-20020ac2482d000000b0048b23739980mr2042813lft.97.1660897940996;
        Fri, 19 Aug 2022 01:32:20 -0700 (PDT)
Received: from krzk-bin.. (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id j8-20020a19f508000000b00492a54f0be1sm545355lfb.284.2022.08.19.01.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:32:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 05/16] arm64: dts: qcom: msm8998: switch TCSR mutex to MMIO
Date:   Fri, 19 Aug 2022 11:31:58 +0300
Message-Id: <20220819083209.50844-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
References: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
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

The TCSR mutex bindings allow device to be described only with address
space (so it uses MMIO, not syscon regmap).  This seems reasonable as
TCSR mutex is actually a dedicated IO address space and it also fixes DT
schema checks:

  qcom/msm8998-asus-novago-tp370ql.dtb: hwlock: 'reg' is a required property
  qcom/msm8998-asus-novago-tp370ql.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f0806ed103f1..22b2da74d105 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -308,12 +308,6 @@ scm {
 		};
 	};
 
-	tcsr_mutex: hwlock {
-		compatible = "qcom,tcsr-mutex";
-		syscon = <&tcsr_mutex_regs 0 0x1000>;
-		#hwlock-cells = <1>;
-	};
-
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -1047,9 +1041,10 @@ ufsphy_lanes: phy@1da7400 {
 			};
 		};
 
-		tcsr_mutex_regs: syscon@1f40000 {
-			compatible = "syscon";
+		tcsr_mutex: hwlock@1f40000 {
+			compatible = "qcom,tcsr-mutex";
 			reg = <0x01f40000 0x20000>;
+			#hwlock-cells = <1>;
 		};
 
 		tcsr_regs_1: sycon@1f60000 {
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CCA59726C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbiHQPBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240728AbiHQO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:59:56 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA549C8EF
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:59:47 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u6so13815222ljk.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Yb2tg6NLcz0SjyT+zhbpZCCAWG7Bnyw4PloKDdxoVAU=;
        b=O9IpmTeGsRfUPMz27j+jEH2NvGlIBNDkmBVbuH+a3duzD7Nvm+VJggLksU1Hhj6iQ8
         P32dT5AlsWtFQ4gsYRGZW5ySkgO243UcyYkQwjx1B02Ty5KYD92KGBFLEt9JBCaDHUOi
         rgYFARGueDV3GAlgTth2gXguhQ7miJfqMVZb6i2vCoBrs4Bvxkx0HS+ysOkNvrOPdsCj
         St7VQIm+CHYTnK0jqQh8JRbvh3m97ElCkKJvMn0L9xmU42We/Vx7AhnNFViiY8Fdu+RB
         A31k2UdKD836o7atJ2MXHL31XSHa9HFNsjM8qW/WCKQ6I4pDCi23tulx14h7d96fDdTZ
         J9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Yb2tg6NLcz0SjyT+zhbpZCCAWG7Bnyw4PloKDdxoVAU=;
        b=4iGHgnnk8MaN7ZJ7yK4mQKHgGEdMTG5xnTq9cnH3bl6wu9wFBeQKS90TYtggi5kKVj
         2UT+idBSsS+xB1Ou/yb8MGKu0to5p1IVUFRlESMoqwh6sD8V/3CewcC7hUik63JPL/HD
         bkLDvF7vvLioUArMvcD2SWuSxpf2ZO3Qd7NLc3hNoCenQVZdE5DuootQApSnRkiALUfn
         mLxA7XqnF7cfoe6iryJ8HbKr5PGK1UCxfQaDPf3gxA99smIKeymO0UpBJsXXsWRGRH0P
         W6j1+7hv4ogD/WoWSrbQN+2wJlkaP7H2vDRy1BBpFpMGwdA7YFtEwFsUH90GWig3A1iY
         SOqg==
X-Gm-Message-State: ACgBeo1qSnkm+hixIYEWJ1luengTgNlOTDA3uzHHV5SN0l3ZFuXPZd37
        bkR3SF2Uejwy3FdWk2w+ZPTweQ==
X-Google-Smtp-Source: AA6agR6u42GqSLiNsJUdR3VEdFKpwI6tk51BOFLOT5dTAvnyQRXheq32VsAnk7cOVE2ifiCeZyd2Hw==
X-Received: by 2002:a05:651c:903:b0:25d:e732:6409 with SMTP id e3-20020a05651c090300b0025de7326409mr8089062ljq.314.1660748377004;
        Wed, 17 Aug 2022 07:59:37 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id u16-20020a05651c131000b0025fdf9eec1dsm2250454lja.111.2022.08.17.07.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:59:36 -0700 (PDT)
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
Subject: [RFT PATCH v2 17/17] ARM: dts: qcom: msm8226: switch TCSR mutex to MMIO
Date:   Wed, 17 Aug 2022 17:59:01 +0300
Message-Id: <20220817145901.865977-18-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817145901.865977-1-krzysztof.kozlowski@linaro.org>
References: <20220817145901.865977-1-krzysztof.kozlowski@linaro.org>
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

  qcom-msm8226-samsung-s3ve3g.dtb: hwlock: 'reg' is a required property
  qcom-msm8226-samsung-s3ve3g.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 0b5effdb269a..efb5d1edc3a8 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -44,13 +44,6 @@ scm {
 		};
 	};
 
-	tcsr_mutex: hwlock {
-		compatible = "qcom,tcsr-mutex";
-		syscon = <&tcsr_mutex_block 0 0x80>;
-
-		#hwlock-cells = <1>;
-	};
-
 	reserved-memory {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -508,9 +501,10 @@ rpm_msg_ram: memory@fc428000 {
 			reg = <0xfc428000 0x4000>;
 		};
 
-		tcsr_mutex_block: syscon@fd484000 {
-			compatible = "syscon";
-			reg = <0xfd484000 0x2000>;
+		tcsr_mutex: hwlock@fd484000 {
+			compatible = "qcom,msm8226-tcsr-mutex", "qcom,tcsr-mutex";
+			reg = <0xfd484000 0x1000>;
+			#hwlock-cells = <1>;
 		};
 	};
 
-- 
2.34.1


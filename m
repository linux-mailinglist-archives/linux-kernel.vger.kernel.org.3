Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25218596F32
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbiHQNFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239607AbiHQNEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:04:38 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A2239BBD
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:04:03 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id v10so13479704ljh.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DbSnvFkY9bvjJ+mlDkzyxC4/7mNnK/XqOObaGJH93/Q=;
        b=DCXz4XYINVpHYEIMfmn91NIOhMiYQDX8amq9srJMdlyklU16yHc0GsXqp2R3vAsKJZ
         eUB89uRwZgzbpTbLUfup3FuESytUkTEjOH2ayHi4YSEzShHbWCVJ4+X3PT+oafCwmYB/
         w0tSfdgooKQUQ2gx3jPmG9jWPs6PKYP1ZARpXJFdmbFKEFcEYjBb6u9YAajQNjGLnSZA
         mnQ7Tjl/jv0Ik6KktCuqWEmL+gsgPWIlw408Wgh3vOMdanfSEJwJkpvXmlgDMaYKQpcu
         BQpqJN1KtIfU1armkcIxH0uN2kfHw3oNmSo0ZTTR5I2OCXpWsbnco54oomjKkiLzqYw1
         c4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DbSnvFkY9bvjJ+mlDkzyxC4/7mNnK/XqOObaGJH93/Q=;
        b=ktBXp+u1XJ7nOak8RdZOHuyGa62R/u6x1L+6ZShhg7GZCFwhuMXXqpJMaWPdkFwc5i
         gROnwnH1cAlkZnqX6c14eKw8w0ZQ4qpkTMfncRxzFheJCXaxABcNHXFrocfMUCukXQzR
         IQ+L/HmrOrqYBKwY/x37grJuyzAl3nT6jr5Cv8Hmr2plhixp1EriHylRcT2L1vPznpZS
         wXHgMRUvE8RGI1dd7TDSF62GsRZ/8fDZqeQdMqAQZcSq7aubN+k10n+WZQqV4nKfFOao
         llObF70YZH1Dt/EnwWo3aUUbMFPxCRLHGG757JYBotuaAuhnG495FJpp9SEm4+ve2Yq/
         4j4A==
X-Gm-Message-State: ACgBeo2foPCFtFmntb017Ldo/TCg2KiH8gidjO527zgTnCnUZKzJPGhr
        RZPB7sbfnQhI8yk9fAQd9I4CuA==
X-Google-Smtp-Source: AA6agR6LJukHMCtjGeJCKZ10+lfXnY0NJek6O2mC9zKYYS73f8w/yuUFVBQrcBJuS3faugWXHdjczA==
X-Received: by 2002:a2e:bf11:0:b0:261:9343:fb2 with SMTP id c17-20020a2ebf11000000b0026193430fb2mr3084063ljr.47.1660741441473;
        Wed, 17 Aug 2022 06:04:01 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id v1-20020ac25601000000b0048b3768d2ecsm1683243lfd.174.2022.08.17.06.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 06:04:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 08/14] arm64: dts: qcom: sc7180: switch TCSR mutex to MMIO
Date:   Wed, 17 Aug 2022 16:03:36 +0300
Message-Id: <20220817130342.568396-9-krzysztof.kozlowski@linaro.org>
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

  qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb: hwlock: 'reg' is a required property
  qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 5d2dd21da79c..e8debb0da411 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -555,12 +555,6 @@ scm {
 		};
 	};
 
-	tcsr_mutex: hwlock {
-		compatible = "qcom,tcsr-mutex";
-		syscon = <&tcsr_mutex_regs 0 0x1000>;
-		#hwlock-cells = <1>;
-	};
-
 	smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_mem>;
@@ -1462,9 +1456,10 @@ ipa: ipa@1e40000 {
 			status = "disabled";
 		};
 
-		tcsr_mutex_regs: syscon@1f40000 {
-			compatible = "syscon";
+		tcsr_mutex: hwlock@1f40000 {
+			compatible = "qcom,tcsr-mutex";
 			reg = <0 0x01f40000 0 0x20000>;
+			#hwlock-cells = <1>;
 		};
 
 		tcsr_regs_1: sycon@1f60000 {
-- 
2.34.1


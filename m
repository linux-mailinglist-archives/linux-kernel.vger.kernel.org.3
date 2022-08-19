Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E91599748
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347226AbiHSIca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347316AbiHSIcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:32:21 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD605E97FE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:19 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z20so3892096ljq.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qy9TWkJXZUtfWQLTmK1W0ItQxoNRQincIzjRzs6MIKA=;
        b=vX0/jTHc82btt23YwOjDhmsjce0tdypxUEa1vZJFlByPF5N1iXDKckLBAd9/M5pEMn
         vJbHO3sJ+QhTWfxUDzNolo5PYfdSOU24IM1mVye0e5WQ8UZIUAfXiRXS8Sl747hsCdra
         iuBehp2aY1PJxnbuYx2RFGg+InVWBU9fkvoyDGjafwLPm7dsnqxuA+pBuuPAlW95O8vX
         IKdnBeHmTBg07dfQoePP6SzcJbBADk20PhAj9qrGMAojPFb9jCyfiwK1tu7wKE38RrPu
         I7f6FE443sXjCk9ryTVd0kbMP6fBx4QzVh9Uth1N99tze+StexA3aTi0+KWgJCpx2Xl/
         dsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qy9TWkJXZUtfWQLTmK1W0ItQxoNRQincIzjRzs6MIKA=;
        b=ulvrU0gJyhww7xaZ12EgpccX654/tJwREAL2kQ/Umn+8rrsHKxH4ZP2ChF5MG1HMJ6
         GBTIOzOx/4YGPU0wOgoSCGRCJHTe5r2ctUm9ttVnAQXf256A0XUwJzmqH9NMcNI0iJRE
         gW2VxRLHoQvT3Y6yn2JVBSzUi73S1AhYIPvAjyTl6JAv3jhVF2HG/Sev1auohjvFqF2e
         2QTy2GEz0xFn5UZ3Az2YeR45Q/xp9qU7kzsPdMQhyzr4kmBEBIu6YFcbN8IG9aJFceZK
         FD//SBhOyIdY00JMgXONnHxRedVcgYH+nROiDx6QeEbURLWcjL7THCfsPV76Cs7pXc2h
         GaQA==
X-Gm-Message-State: ACgBeo0Em2aXWeUuS+lgooDlURzmg2r5ZaAKBseonvAtTXid31246gF9
        fqf7XDAE6NxMaF10pDI1euvq4Q==
X-Google-Smtp-Source: AA6agR5BgMAA8ole7CO+TTXK5IFql3pEQSDpaD4Q/U9GU4pEqaF2Xhd+deXfcE9Fd3tOJvGVx+8cDQ==
X-Received: by 2002:a2e:9b47:0:b0:25e:6dac:8c8c with SMTP id o7-20020a2e9b47000000b0025e6dac8c8cmr1915596ljj.113.1660897938075;
        Fri, 19 Aug 2022 01:32:18 -0700 (PDT)
Received: from krzk-bin.. (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id j8-20020a19f508000000b00492a54f0be1sm545355lfb.284.2022.08.19.01.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:32:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 03/16] arm64: dts: qcom: msm8996: switch TCSR mutex to MMIO
Date:   Fri, 19 Aug 2022 11:31:56 +0300
Message-Id: <20220819083209.50844-4-krzysztof.kozlowski@linaro.org>
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

  qcom/msm8996-xiaomi-natrium.dtb: hwlock: 'reg' is a required property
  qcom/msm8996-xiaomi-natrium.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
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


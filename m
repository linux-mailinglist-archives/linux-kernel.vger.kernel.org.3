Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E18B596EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239656AbiHQNFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239579AbiHQNEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:04:39 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0053E747
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:04:07 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z25so18933920lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=v+CAkv8Hlyo2PxpwLaCJcPFqOS7vWYe9QQHHKSYzECU=;
        b=z2gY6kWdx5thVEWNbyzgP/AV8QjMQfV030JlnCO2kJWlqICwWvYGcK+QYVxh741Jlf
         gadgcu+vGFl66aA0ey07hG3KsXQeIkkfQghuPqFZrC73X6uzdcs2RBT3XxcT3a+PJ7EJ
         x96Jca9TD4Op2SX2pfGnvaAekt6NI7ssHth6FWBwIcAncg7zlm2ZbNg76SEyHqRUzmh5
         tR5sXvcYMdY9wCcCElJz+n4xhRaz1TI4lyDpvBMaqh8f1vLHFGy+9BCBgSL1PoRw1VEZ
         tEEgwqhYzf2JKX45+end44U3T5/RC1v7pG9wAUe3y44U0T3ysANHIsuKn0s/U2HwWa2O
         NwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=v+CAkv8Hlyo2PxpwLaCJcPFqOS7vWYe9QQHHKSYzECU=;
        b=dBvFpv4qikIXCmnOcRyp76rb05yyQEJ1ErRWpvl4cRclOqXPyvUCwhKyyC0Fzuk/U/
         TgCvUClAmbDtYHJVavlUVsB7CO5tIJRHdfiMlsNEqOQ2ak8UKhWBSghxisb82rDSb/QR
         vWYVJzC89bszgFVi5a6phodQiokTsOItbgRFMEfAwak1lpuqF80/7VeS9B4N42aJZoaX
         U6P3E9kKUqElgrY0V3mjE6nscqsrgd8U+huD8i1jLvA16cKLkJPN0uuiw03dk838OJOT
         Xk6UIibyjuH2WV+0qB5MEJgU/ACkqtrXVm5qFOB6hvjnG2UTTnSq+WSSPs3EoAQyGSqN
         W63Q==
X-Gm-Message-State: ACgBeo0J58OPHfvtC10MA7H/Eo+TfnyEKC/U3/rSZdZ+KUyMrQKKhsy/
        HmnAWRp+VrJD2w1P6UXnGIebMQ==
X-Google-Smtp-Source: AA6agR6gGaNvA1OCrY5FS5lVoXuUR7cXFbR03kr2uyJ4BWGJd3ujkvni9qmraTptHX7xhHiknZ+wFw==
X-Received: by 2002:ac2:4d4a:0:b0:48b:1f80:a93d with SMTP id 10-20020ac24d4a000000b0048b1f80a93dmr8147107lfp.403.1660741445480;
        Wed, 17 Aug 2022 06:04:05 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id v1-20020ac25601000000b0048b3768d2ecsm1683243lfd.174.2022.08.17.06.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 06:04:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 11/14] arm64: dts: qcom: sdm845: switch TCSR mutex to MMIO
Date:   Wed, 17 Aug 2022 16:03:39 +0300
Message-Id: <20220817130342.568396-12-krzysztof.kozlowski@linaro.org>
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

  qcom/sdm845-shift-axolotl.dtb: hwlock: 'reg' is a required property
  qcom/sdm845-shift-axolotl.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 21ed14200986..bd0ec0664283 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -919,12 +919,6 @@ compute-cb@8 {
 		};
 	};
 
-	tcsr_mutex: hwlock {
-		compatible = "qcom,tcsr-mutex";
-		syscon = <&tcsr_mutex_regs 0 0x1000>;
-		#hwlock-cells = <1>;
-	};
-
 	smp2p-cdsp {
 		compatible = "qcom,smp2p";
 		qcom,smem = <94>, <432>;
@@ -2588,9 +2582,10 @@ ipa: ipa@1e40000 {
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


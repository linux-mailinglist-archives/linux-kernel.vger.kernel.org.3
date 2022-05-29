Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72017537283
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 22:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiE2U1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 16:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiE2U0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 16:26:41 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10EF3ED14
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 13:26:39 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h62-20020a1c2141000000b0039aa4d054e2so1288806wmh.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7BSd+gf/ck0W1eHbOBBMckcPV2+14YCFy97u8V9nibQ=;
        b=r+uKBFxx100oKdFlHUazH37v/u76hZIcb0FSQYlogP+tc89e+JNsYgqwxqR77Zadam
         eRhTUGZXceN0Shp8zKvV5mSRS68HADRm+VQ24tASGmZ/ErKNSWxXX5AIJPU2sCzciod7
         H/WyTzdjX5mMeLJv/zFN/0HUZyFjnN1CNz5UuFSgffNZq20T84ZTIjRklSxZbYMRvBMN
         UnJgJBLnopF48TxJwv+dEU/4fEZaF+qKnYaLCwM0p6o0uqyCIyCCpZbvQTk0OQYIGGiM
         Jntvsc4suVF7mh5Icbhp4SSRSMXwGbYH/7UaCeykdUGSaTksez74exhaNjnaGxRw4xoK
         1Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7BSd+gf/ck0W1eHbOBBMckcPV2+14YCFy97u8V9nibQ=;
        b=aoREYXScaUfiq3YCTr3HrLjUufCaZsYV6dwqv9JiX14JppoVLTEpEuxuvpBfE5hwU0
         byR7IUb5Lnuc03dh348kxVIKF01qano3gR7H3DtLHSagMUysLJStW7pOWfvJdqgbGlIn
         QIa4WtVQB5m5MCUVYgCjzFb30k3kakgvcGoxvxvpWZETxOUalXSFhSHPFMRX14eY9e9P
         mGaOkhV5rDytkT4/RgFZXHqGVcVwP/Hj1JboRZuT54ofe2cXdoOvN0NiJ8GNk9zeTd6+
         E/b2bH60iStDrOrwa67bITw5bOLsOW6ppLpygl3muIXDfH82Tv6c3J+uN/2s8PfeYkc0
         dvLQ==
X-Gm-Message-State: AOAM531CtPH8Ncbeq40aO7552rszSUt1dNZOF4F7SF/hET+2tGUTE7ly
        ak+J0owtEgNBN5LWp65iec40Bw==
X-Google-Smtp-Source: ABdhPJyesDDD/9OKesZcNDxQ5eAvtq1e4HWl/uDzDpbXjkvyhyIw77G9rq75UYadBVk5htYtuwtdzQ==
X-Received: by 2002:a05:600c:1e1c:b0:397:3c4b:b188 with SMTP id ay28-20020a05600c1e1c00b003973c4bb188mr16403234wmb.64.1653855998079;
        Sun, 29 May 2022 13:26:38 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d6144000000b0020c5253d8f7sm7099310wrt.67.2022.05.29.13.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 13:26:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] arm64: dts: qcom: msm8998-oneplus: split qcom,board-id into tuples
Date:   Sun, 29 May 2022 22:26:28 +0200
Message-Id: <20220529202629.47588-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220529202629.47588-1-krzysztof.kozlowski@linaro.org>
References: <20220529202629.47588-1-krzysztof.kozlowski@linaro.org>
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

The qcom,board-id is an uint32 matrix, so a list of tuples.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts | 2 +-
 arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dts     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
index 9563eb62db88..0a6d3e4ac48f 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
@@ -13,7 +13,7 @@ / {
 	compatible = "oneplus,cheeseburger", "qcom,msm8998";
 	chassis-type = "handset";
 	/* Required for bootloader to select correct board */
-	qcom,board-id = <8 0 16859 23>;
+	qcom,board-id = <8 0>, <16859 23>;
 
 	/* Capacitive keypad button backlight */
 	leds {
diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dts b/arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dts
index 5d0dabbaee4e..60718c06e17e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dts
@@ -12,7 +12,7 @@ / {
 	compatible = "oneplus,dumpling", "qcom,msm8998";
 	chassis-type = "handset";
 	/* Required for bootloader to select correct board */
-	qcom,board-id = <8 0 17801 43>;
+	qcom,board-id = <8 0>, <17801 43>;
 };
 
 /* Update the screen height values from 1920 to 2160 on the 5T */
-- 
2.34.1


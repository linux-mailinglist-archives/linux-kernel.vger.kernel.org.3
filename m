Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7EF596F23
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiHQNEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbiHQND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:03:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB9F30F42
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:03:52 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o2so18950261lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=4qwI8r7xcTle/RTrQ0bmgC2r/rDzNq/R01LY3t7eMOs=;
        b=jyze1ABXKCiIHI0FYhq9qo2XDD6SBhR7tHMg30BbzHmVgJtdEObinYDbnxVjvaJJYl
         Ult/7SJMggPynHFoPI7TcN+Bp6sRtnx19+HmYZa2qOcP2FNpjXokmMgIcmL5WHirg6Wr
         Ju852VOsgMbGoklz0YOfBLaXYzV5yiYz+2YTVm9CjUMTS34YJmktecRVq9j8Kfli7b2H
         68vz+tSvY4V1uZ3jUpQLZs/5FX1FSkCQoNwk96y2oelSHjz9Pm6HVaJhKnAPjEJeq7Gm
         6vyPgyBekCyyhZjyxP8KDvmMmR5zwsoZhNdWRhrz5YpftGCh1xzlqwBF9XQKtkaIPFPZ
         bIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=4qwI8r7xcTle/RTrQ0bmgC2r/rDzNq/R01LY3t7eMOs=;
        b=UemqACSt2jp2Pr6Omn1rTNvmCwCViUYi04bj9wv4heNhYfseALDqbDyzKUXysMM/Gr
         KOzVcYTYsC60GccUTqGZnePF+emS7vTkCRvH0Krjh0orOXzz8lcigUvj0r4js4QTW05N
         0G4LKMr20BA7XzvaWZ4P3MLJDfzwLqaiz4cwIT3AkhLBth8pNfOrEmheMaKHKjFU4Ca1
         WkzPetdX1g/WoryVQAItC5oNhqYK4e9UUwYjyszctccGaRcZ9622NdNEH0IEffJR67yS
         pphWHuxz0o/qQSe/xEYyFUenOVnylpS9z+AsUQUz42s+1/SgvljgUEu99wTxqTk8ZsND
         k8sg==
X-Gm-Message-State: ACgBeo3J6rgau7yKjzUz92k0ilYDQCeEt5UVLvZjHf4/ESdxZXy1/lIW
        7hVdp+AP2i4rjYLR2GqAhaC/bg==
X-Google-Smtp-Source: AA6agR50foDzFuQRZJhXdYMw3M4pyhXPmpcvRx/VXukLnqSaLgQ7YiSlPkYH9iujI7XGct0VKeEMwg==
X-Received: by 2002:a05:6512:c25:b0:48b:1241:fb9f with SMTP id z37-20020a0565120c2500b0048b1241fb9fmr9134415lfu.74.1660741431051;
        Wed, 17 Aug 2022 06:03:51 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id v1-20020ac25601000000b0048b3768d2ecsm1683243lfd.174.2022.08.17.06.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 06:03:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 00/14] arm64: dts: qcom: improvements to TCSR mutex in DTS
Date:   Wed, 17 Aug 2022 16:03:28 +0300
Message-Id: <20220817130342.568396-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Hi,

Changes since v1
================
1. Correct order of compatibles in the binding.

Description
===========
Set of improvements for TCSR mutex to match the bindings after conversion to DT schema.

Tested briefly on SDM845. Please kindly test on other platformss (therefore RFT).

Best regards,
Krzysztof

Krzysztof Kozlowski (14):
  dt-bindings: mfd: qcom,tcsr: add SC7x80, SDM845 and MSM8996/8
  arm64: dts: qcom: msm8996: split TCSR halt regs out of mutex
  arm64: dts: qcom: msm8996: switch TCSR mutex to MMIO
  arm64: dts: qcom: msm8998: split TCSR halt regs out of mutex
  arm64: dts: qcom: msm8998: switch TCSR mutex to MMIO
  arm64: dts: qcom: sc7180: add missing TCSR syscon compatible
  arm64: dts: qcom: sc7180: split TCSR halt regs out of mutex
  arm64: dts: qcom: sc7180: switch TCSR mutex to MMIO
  arm64: dts: qcom: sc7280: split TCSR halt regs out of mutex
  arm64: dts: qcom: sdm845: split TCSR halt regs out of mutex
  arm64: dts: qcom: sdm845: switch TCSR mutex to MMIO
  arm64: dts: qcom: qcs404: switch TCSR mutex to MMIO
  arm64: dts: qcom: sdm630: switch TCSR mutex to MMIO
  arm64: dts: qcom: sm8150: switch TCSR mutex to MMIO

 .../devicetree/bindings/mfd/qcom,tcsr.yaml    |  5 ++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 24 ++++++++---------
 arch/arm64/boot/dts/qcom/msm8998.dtsi         | 20 +++++++-------
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 11 +++-----
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 26 +++++++++----------
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 19 +++++++++-----
 arch/arm64/boot/dts/qcom/sdm630.dtsi          | 13 +++-------
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 20 +++++++-------
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 13 +++-------
 9 files changed, 73 insertions(+), 78 deletions(-)

-- 
2.34.1


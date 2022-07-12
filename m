Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E52571D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiGLOnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiGLOnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:43:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38077BB7CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:42:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t1so10777421lft.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=duo15aJQ11HVOFnF0u0+cfPbWBklkXMRH+jQvhcfDM0=;
        b=W2+TJoZL15WjMJkW5SsQPLZXpaZePymWoty4EwF3TZbktoOiu1oZPeMbtFEtHe19QJ
         e9b8dgtWv4fGxppHggk3KEa3VLczIcJdIad99jGM3y6R7LPWIuB4yEM5Dp/TC+SpncmY
         U4VnwLoo2Mujm3raxn3ml075Af48QYckFEKp/Vr2X/HCRlugUG2MaFLWt6P7FQY3449R
         Hne4eQXbM0YXnsx4uTZsM7HL4TzOS+1WP9UHxuVm8kS5NBd+95f8RxFoalgBUtWBmev3
         egRzYdsGON2qSd7LKkNVLWvBepKpeJTV7EOPX0GKaIQOT4TX0wNuCDFrQAhi6gTMBLx4
         asFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=duo15aJQ11HVOFnF0u0+cfPbWBklkXMRH+jQvhcfDM0=;
        b=VNrQAdmnRyRIlYxNkgGAUruB/Os2xxCccF+pbOoC8qkl86/QMkhtl6xLOHCtWxrMzf
         gH/TUHefbaU3BgEX4MrMBW6BpC7Q8bLsUP8YcIaNNTjBGHJ2Gje8gNhKBZDMZp1YKYso
         i1e1+kgMHgOgEhiSI3iBWLvN9QTPG+Zqzl3McJ8/KRff3HHBFeRXuZTiK1AO2YKDoQAD
         XBG1iIu2uxlS0ZBb0M1PinLBZkOzUkvrmQWUfsYxNebiemN5a0pgp33h7RKu1o8H92Cw
         CECFdiaxyj0TjSqbmee2tsAxlh2BN8WtGtFBOSJXKBWmrPI4R//FDM4kBeKSgmwBLNlN
         oUmA==
X-Gm-Message-State: AJIora/mRse/8AJTVJbzlT9m4RQBUYm/nnKBxsAZsC7KNHKQxW0rGvfS
        0y+HZfbdEVn3gHK81RKN/RhCwg==
X-Google-Smtp-Source: AGRyM1uv/sWosfiNGc4Z3vNfnR7RVSVKABYb7xResLOIpsGi9cEr3Rl8/H2Bx7x3+kYsHUZGoHcOJw==
X-Received: by 2002:a05:6512:3342:b0:489:e36b:60e4 with SMTP id y2-20020a056512334200b00489e36b60e4mr5896293lfd.674.1657636976614;
        Tue, 12 Jul 2022 07:42:56 -0700 (PDT)
Received: from krzk-bin.. (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id w15-20020a05651234cf00b00489e88d6a72sm737577lfr.198.2022.07.12.07.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:42:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 0/5] dt-bindings: mmc: / ARM: qcom: correct reg-names and clock entries
Date:   Tue, 12 Jul 2022 16:42:40 +0200
Message-Id: <20220712144245.17417-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Hi,

No dependencies.  DT bindings patches are independent from DTS, so they can go
via separate tree.

Changes since v2
================
1. Add Rb tags.
2. Correct typo in subject of patch 2.

Changes since v1
================
1. Add Rb tags.
2. Rework reg-names constraints according to Doug's feedback.

Best regards,
Krzysztof

Krzysztof Kozlowski (5):
  dt-bindings: mmc: sdhci-msm: fix reg-names entries
  dt-bindings: mmc: sdhci-msm: constrain reg-names per variants
  arm64: dts: qcom: align SDHCI reg-names with DT schema
  ARM: dts: qcom: align SDHCI reg-names with DT schema
  ARM: dts: qcom: align SDHCI clocks with DT schema

 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 61 ++++++++++++-------
 arch/arm/boot/dts/qcom-apq8084.dtsi           | 16 ++---
 arch/arm/boot/dts/qcom-ipq4019.dtsi           |  5 +-
 arch/arm/boot/dts/qcom-msm8226.dtsi           | 24 ++++----
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 24 ++++----
 arch/arm/boot/dts/qcom-msm8974pro.dtsi        |  6 +-
 arch/arm/boot/dts/qcom-sdx65.dtsi             |  2 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |  2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  2 +-
 13 files changed, 87 insertions(+), 71 deletions(-)

-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5250596E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbiHQMEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239177AbiHQMEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:04:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCD24D176
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:14 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id v2so18728764lfi.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=yqssnPgj5AL6F0xZ/NeSjNCL9/LCIOq0NDJYiOB1qxU=;
        b=RNZ0gz96FCyTInbkdKq7kFz/xXvFC9CqaukFbtQ74i3N1mysOLy08KcyEMXOYjHAmc
         u30h2X3eTzG/DRaTinny0000oJsEUc4q3JVdQ5UEjv/hS3kA4n9bdoRuG3rFXdFYwxYU
         kUvlkc6fb/i9rLYbFpBqw6B+kz/Xwfd/PbSHzK1gB+ulya+svg4WVUB/9tOeh71nSvzE
         RWW351YYzAZw9TQ4Mxj8XYpv8/DYmBGLKcqJLO2xgylu0PDe6OZtGg26DCl/++R/WYqO
         cEwMUNxgrySu7pPRBU6jPRywK3ymG3yWn3dEXvNpfOdNTd4/cBjv9Mq0eBGKuUHILdTM
         qoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=yqssnPgj5AL6F0xZ/NeSjNCL9/LCIOq0NDJYiOB1qxU=;
        b=CDZUUixbFoFHpqAJWTzxG9IeiEHdC1+pzYK4hEOdFSyv0Yw1ALMekXah97iE+X9Qby
         95kscpHsKeVDI1ukS+NRvkdAXkJ4VLzrRIYWVLdDDcGrDUSXoAHHK/3fc7wRBweu9TxQ
         S/gyCmsnnhi7iwBc4GqyHEJGY4FEborA4e4rn3Re8QKAnV/pvKcblGwv7MH97fpRUbJc
         AIfbhCInPoFWQ5RErE0BXdvLqUVpyDb+RaRhCn4dp8sy8H6isU/+C/AyUUjPtFP61KAw
         +FduiztCwXMX8Ki9wcx1bFk25UOniox1a3tdXU4+pH0Y2EsXoXW2Bu7Y7M837GQIAAnm
         37fw==
X-Gm-Message-State: ACgBeo3E9eXFLsV2IPhJhw/30fYkzc36FKpNRv1QNRAJu4hzVGjsZk6l
        YI9tk4EUZ+sq667JKb8MuXE10w==
X-Google-Smtp-Source: AA6agR41ljtllSk6AwaS1v+x8NlqpoDbXtXK5sbPFe8/L6CKLHW/A0mdoe/rV6/tbtHihW7P1ebnrA==
X-Received: by 2002:a05:6512:2210:b0:48c:eba9:5493 with SMTP id h16-20020a056512221000b0048ceba95493mr8530991lfu.540.1660737852630;
        Wed, 17 Aug 2022 05:04:12 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id d15-20020a05651221cf00b0048a97042251sm1670496lft.22.2022.08.17.05.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:04:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 00/14] arm64: dts: qcom: improvements to TCSR mutex in DTS
Date:   Wed, 17 Aug 2022 15:03:48 +0300
Message-Id: <20220817120403.458000-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Hi,

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


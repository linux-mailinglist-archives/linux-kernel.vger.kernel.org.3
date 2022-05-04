Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B75851A09C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350427AbiEDNXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiEDNXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:23:06 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144A81AF03
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:19:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dk23so2833266ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FIMtArNQCnScXPxbG5Ez4i9eHYlrhfD1C1i0rJpy+2k=;
        b=WKnIzMa4uw++B6tgm1O9xzDfioCiVRLAjCp/D8BmAMMdnCL2kI/oXL29qtsXVKAYqx
         Sv6kNrga8vB2oX8fWx9TNep2jWk/tdtOd2c2k0I+wNcoSHBNYW+iOyip9R55j7/TBrmQ
         xvQWybw1naWhL+ploNpYOArvHYOtvDpJqwZZBJ6fTfKjDMxo6ZOMi7/AHHtinO042Fnv
         ohlbUIWonp8O9PBg46TQQga4yqliYr19JaumNVcj6+4rw/QMR1AKlk5P7zYKN2OisTc6
         z/JxjA3bg9lb3AxhAofBFvb/LbjpK4yVibuB0fZ3E6zCLcmLql3XrrLVmCL5x1PLMBty
         Dh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FIMtArNQCnScXPxbG5Ez4i9eHYlrhfD1C1i0rJpy+2k=;
        b=mwpZEYvPv/zc+CPkO5Wx68qG6CdJR1sBxaBTx2zvoNIv9m8PrhHW7/DUZmI1bhuEQ/
         mrVhtJEBsOFbDkdGpZqzv30uXPqBH6zWrsoJIi51hVl99eHrzXrqiUW+ngyCEd9x8vZN
         EyEWBhxavU7WJRMi4ubS+9rhmJWmeYJU5DeNm9nj1+ypTrESF8TKs/BDZxYym+B20WQv
         cV3s335xzPo37UCFSL6rxUa787F1rECRYpJtjc8MOFNAzXyjt2kSe23FIqkFYyKRtvAB
         je5BzRnIYBons/GHMd2QSopV+h6HgbTfeXD6KflsojvU6RgwAUvxkzmBtdFBwyf02PHR
         OQsA==
X-Gm-Message-State: AOAM531wiQ1fzUe1AgigryA3NQcp6Y59J/yI+UWfgZQ0y+/lP9diBxiY
        gnbromGs63s2dTg+b5647xJtgQ==
X-Google-Smtp-Source: ABdhPJyQrb/3lujjFvxdI3/EJeFf0fBea6dXetyFjPJrkIJ0Ia3Uhb0W9zifuVNK7ZmrJk1z/xNGiw==
X-Received: by 2002:a17:907:8a0b:b0:6f4:4899:db98 with SMTP id sc11-20020a1709078a0b00b006f44899db98mr14038112ejc.622.1651670367697;
        Wed, 04 May 2022 06:19:27 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gx3-20020a1709068a4300b006f3ef214dc4sm5660924ejc.42.2022.05.04.06.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 06:19:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/13] dt-bindings/arm64: dts: qcom: minor cleanups with DT schema
Date:   Wed,  4 May 2022 15:19:10 +0200
Message-Id: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Hi,

The patches are independent, so they can be picked up as is (or everything
through Qualcomm SoC tree).

Best regards,
Krzysztof

Krzysztof Kozlowski (13):
  dt-bindings: soc: qcom: aoss: document qcom,sm8450-aoss-qmp
  dt-bindings: soc: qcom: qcom,smd-rpm: add power-controller
  dt-bindings: usb: qcom,dwc3: add IPQ8074, MSM8994, QCS404 and SM6125
  dt-bindings: usb: qcom,dwc3: fix clock matching
  arm64: dts: qcom: add missing AOSS QMP compatible fallback
  arm64: dts: qcom: correct DWC3 node names and unit addresses
  arm64: dts: qcom: ipq8074: add dedicated qcom,ipq8074-dwc3 compatible
  arm64: dts: qcom: msm8994: add dedicated qcom,msm8994-dwc3 compatible
  arm64: dts: qcom: sm6125: add dedicated qcom,sm6125-dwc3 compatible
  arm64: dts: qcom: qcs404: add dedicated qcom,qcs404-dwc3 compatible
  arm64: dts: qcom: msm8996: add clock-names to DWC3 USB node
  arm64: dts: qcom: align DWC3 USB clocks with DT schema
  arm64: dts: qcom: align DWC3 USB interrupts with DT schema

 .../bindings/soc/qcom/qcom,aoss-qmp.yaml      |   1 +
 .../bindings/soc/qcom/qcom,smd-rpm.yaml       |   3 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml    | 226 ++++++++++++++++--
 arch/arm/boot/dts/qcom-ipq4019.dtsi           |   2 +-
 arch/arm/boot/dts/qcom-sdx55.dtsi             |  11 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts   |  18 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  12 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |  16 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi         |  11 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi         |   7 +-
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |  20 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  23 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  13 +-
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi      |   7 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |   8 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |  15 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |  34 ++-
 arch/arm64/boot/dts/qcom/sdm630.dtsi          |  12 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  26 +-
 arch/arm64/boot/dts/qcom/sm6125.dtsi          |  16 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi          |  11 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  24 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  22 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |  23 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  20 +-
 25 files changed, 424 insertions(+), 157 deletions(-)

-- 
2.32.0


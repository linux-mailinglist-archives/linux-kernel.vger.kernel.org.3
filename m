Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30465249B8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351315AbiELKA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352381AbiELKAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:00:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9413E22EA76
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:00:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gh6so9227843ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Zp+2diUhLqJh/VRlBbOUJIH+1ZusBjmOxNx3/jn12c=;
        b=Hovk9jpftMlDEMTIOLXZKkYl2INRhhlanGrwxzxRz7NLy9Avh+tY515Qes5jtUwIaz
         C9uegpk2TtzoApq+arXIioVCnoQFBV7tgqPxA/40jIJpKcZxKG8abP8EtCVPARu/lcEM
         UlknoUXfVkZHx2tcca3sf9q16LP5tQ8fpNekpH5pwalLmUi/jSivCNWCqHrNXpOup8L7
         jw9r0EwAkk3asx0eltfTIb85hvZCY542q5qI7duABSDoAdrXuPfiyFiHeF8ZimrVyLTN
         6TcK0R6hU+ks9olChlsg5ukzqVPL913owG8sJeb0DslrWoj6IC07jx/0CO1VwTFJNb6z
         R7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Zp+2diUhLqJh/VRlBbOUJIH+1ZusBjmOxNx3/jn12c=;
        b=AH38cPVULZqA4Nch9oEtXsJnIlJVShJ2qSJa7if2ubwY4TcknmxzJciXnu+/eaoFwA
         MNjMX1gBLLxTvAHYmjUQ8baDQe5AJ35xpHoEzTnYCQ/Rbzml7zQcoN4Tt7jnnu3PgMzc
         HjcCLqY2+EIjcd8p3D1yGAZotV08sQ9m1/jVH2tpHfwQF4az33GqnbOVwHAH0nac/Xzy
         MTf3Vm5ZxHGQ6DVk9IsCzMMr2PEJA7aZCX8mVOblCi5/RrQemPq53TgrR8r4pcQBTk4e
         rJPWo3gO5dncSP0DXpEJiZY10BcJjKf0wsy+JRwzhRtrWEazVxpKvQs62bEoCtRX7cYd
         3SMQ==
X-Gm-Message-State: AOAM532T4OM42sM5ufOyBBtUmByOKtY7i+1Fifvj1SbnxEQJmhgdV13a
        liM84kCDvnSPFKcwwlqgvnqSBQ==
X-Google-Smtp-Source: ABdhPJycS9G6r3sETF2n3MDCHJPZcx+QFPO7xASHkbyQRcNb5A9u1OQSm1Qu5g3TYJkGf9igP/caYA==
X-Received: by 2002:a17:907:3e99:b0:6f3:d1e1:23ae with SMTP id hs25-20020a1709073e9900b006f3d1e123aemr29969066ejc.470.1652349616083;
        Thu, 12 May 2022 03:00:16 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d17-20020a170906641100b006f3ef214da1sm1970287ejm.7.2022.05.12.03.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:00:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/12] dt-bindings: remoteproc: qcom: cleanups and improvements
Date:   Thu, 12 May 2022 11:59:54 +0200
Message-Id: <20220512100006.99695-1-krzysztof.kozlowski@linaro.org>
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

Patches are mostly independent, so they can go via:
1. Qualcomm SoC (dt-bindings/soc: + arm64)
2. remoteproc (dt-bindings).

Best regards,
Krzysztof

Krzysztof Kozlowski (12):
  dt-bindings: soc: qcom,wcnss: remove unneeded ref for names
  dt-bindings: remoteproc: remove unneeded ref for names
  dt-bindings: remoteproc: qcom,adsp: add interconnects
  dt-bindings: remoteproc: qcom,adsp: simplify interrupts
  dt-bindings: remoteproc: qcom,adsp: simplify SM8150 power domains
  dt-bindings: remoteproc: qcom,adsp: use GIC_SPI defines in example
  dt-bindings: remoteproc: qcom,glink-edge: define re-usable schema for
    glink-edge
  dt-bindings: remoteproc: qcom,smd-edge: define re-usable schema for
    smd-edge
  arm64: dts: qcom: ipq6018: add label to remoteproc node
  arm64: dts: qcom: sdm630: remove unneeded address/size cells in
    glink-edge
  arm64: dts: qcom: sm8350: remove duplicated glink-edge interrupt
  arm64: dts: qcom: sm8450: remove duplicated glink-edge interrupt

 .../bindings/remoteproc/qcom,adsp.yaml        | 74 ++++++----------
 .../bindings/remoteproc/qcom,glink-edge.yaml  | 72 +++++++++++++++
 .../remoteproc/qcom,qcs404-cdsp-pil.yaml      |  1 -
 .../remoteproc/qcom,sc7280-wpss-pil.yaml      | 21 ++---
 .../remoteproc/qcom,sdm845-adsp-pil.yaml      |  1 -
 .../bindings/remoteproc/qcom,smd-edge.yaml    | 88 +++++++++++++++++++
 .../bindings/soc/qcom/qcom,smd.yaml           | 53 +----------
 .../bindings/soc/qcom/qcom,wcnss.yaml         |  1 -
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  1 +
 arch/arm64/boot/dts/qcom/sdm630.dtsi          |  2 -
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |  1 -
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  1 -
 12 files changed, 196 insertions(+), 120 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml

-- 
2.32.0


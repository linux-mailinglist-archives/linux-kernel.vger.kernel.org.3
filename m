Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D164EFAC1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351684AbiDAUMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiDAUMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:12:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D72E214060
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:10:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bh17so8100319ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wZcoxvb7+ZLDwTeQD+hjkDPjIR0SXEiE7FVLTNvQVs=;
        b=kwcW1jSZpHJRPWS/q+/yKLIdOKu51YsIhJPEvx1hTh5CdP/24vFnQsoDX8t8I/EA18
         0K+y6UsHPLzZX/3YtNRDuOXZM5YVeuOMU1lQkQZSYnrPxjSNtLxMn8S13PELEM4xtziw
         jvzgO03Cz/57QPZ2s8+QnbcP64x6KwF++6xaYQXLcPdaJtC5Z6e6N/l5gJyU8qWgHbjM
         TqSIZwRCiYcMSgoy8lxIhrKZOvadUtXMKKIEsmk70ndyNFTi1UgAOlWMgosjFCup3GeM
         po2tjV0YBicGElRbmBLGIcqe2jwx7Xpf1TKDoop5tKZqXow8ff8TC5OprbiL6NUhBcnB
         EYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wZcoxvb7+ZLDwTeQD+hjkDPjIR0SXEiE7FVLTNvQVs=;
        b=R4v3H6AAcWWqPIDseo0BFmNCmBmF5UhrVL3iQeVFt9PGOSF40Twi5u5e77GkVJWH0I
         ux8nVQAuT9AlNVcxvPcp73wmNTHBatCF1rNLFGC5HjwkbWuc9DVJSoQXD34HV7S85obS
         3mt5MfBqG10L6YfzTUNHm2s5shvun4uViEHo55SsrA1xwg8BSoAQjsTBqNjf7bxrHV0U
         meYq5DimdVdoVMeUxx/rR1iPkBrRvvlbW1OIN9E9/CjRbvS5MBgnpMEcIxG2P1dJAONa
         TYtNxnutQw45NGxJFiPJ0ZzhbP7HP5FlVVxrcUnmmwGgSW2mrT4IK7Skg1b6XkQADVNn
         hwug==
X-Gm-Message-State: AOAM533EEQj9gctVyTz3c3rClYzzF5a27zUz3ZB6G1uydWTxMU8M3No5
        JpfT2bgk4nkd9aIpWgCvogCyEw==
X-Google-Smtp-Source: ABdhPJx3248xj2ECjEpo2EmyEJ3T727gIATeSKJ1kASZj0fkpUuIOY0E9ezVEbTrCsYZ9ha9IPpCvg==
X-Received: by 2002:a17:907:a0c8:b0:6e0:da87:fde9 with SMTP id hw8-20020a170907a0c800b006e0da87fde9mr1329911ejc.90.1648843840760;
        Fri, 01 Apr 2022 13:10:40 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bx5-20020a0564020b4500b00418fca53406sm1509041edb.27.2022.04.01.13.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:10:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/10] qcom: convert to dtschema qcom,smd and qcom,rpmcc
Date:   Fri,  1 Apr 2022 22:10:25 +0200
Message-Id: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Convert to DT schema clock/qcom,rpmcc and soc/qcom,smd. The SoC and clock
schema patches are independent, although Rob's bot might complain about
compatible without schema, so maybe let's take them via one tree?

The DTS patches are independent fixes/cleanups for issues pointed out by this
schema and can be taken independently.  Not tested, although no impact on
functionality is expected.

Best regards,
Krzysztof

Krzysztof Kozlowski (10):
  arm64: dts: qcom: msm8953: do not use underscore in node name
  arm64: dts: qcom: msm8994: remove SMD qcom,local-pid property
  arm64: dts: qcom: add RPM clock controller fallback compatible
  ARM: dts: qcom: msm8974-lge-nexus5: move gpio-keys out of soc
  ARM: dts: qcom: msm8974-samsung-klte: move gpio-keys out of soc
  ARM: dts: qcom: msm8974: override nodes by label
  ARM: dts: qcom: do not use underscore in node name
  dt-bindings: soc: qcom,smd: convert to dtschema
  dt-bindings: clock: qcom,rpmcc: convert to dtschema
  dt-bindings: clock: qcom,rpmcc: add clocks property

 .../devicetree/bindings/clock/qcom,rpmcc.txt  |   63 -
 .../devicetree/bindings/clock/qcom,rpmcc.yaml |   75 ++
 .../regulator/qcom,smd-rpm-regulator.yaml     |    2 +-
 .../bindings/remoteproc/qcom,q6v5.txt         |    2 +-
 .../bindings/remoteproc/qcom,wcnss-pil.txt    |    2 +-
 .../bindings/soc/qcom/qcom,smd-rpm.yaml       |    8 +-
 .../devicetree/bindings/soc/qcom/qcom,smd.txt |   98 --
 .../bindings/soc/qcom/qcom,smd.yaml           |  137 ++
 arch/arm/boot/dts/qcom-apq8064.dtsi           |    8 +-
 .../arm/boot/dts/qcom-apq8074-dragonboard.dts |  614 +++++----
 arch/arm/boot/dts/qcom-apq8084.dtsi           |    2 +-
 .../boot/dts/qcom-msm8974-fairphone-fp2.dts   |  581 +++++----
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 1105 ++++++++--------
 .../boot/dts/qcom-msm8974-samsung-klte.dts    | 1127 ++++++++---------
 .../dts/qcom-msm8974-sony-xperia-amami.dts    |  569 ++++-----
 .../dts/qcom-msm8974-sony-xperia-castor.dts   |  908 +++++++------
 .../dts/qcom-msm8974-sony-xperia-honami.dts   |  636 +++++-----
 arch/arm/boot/dts/qcom-msm8974.dtsi           |   16 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi         |    4 +-
 arch/arm64/boot/dts/qcom/msm8992.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi         |    3 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |    2 +-
 24 files changed, 3000 insertions(+), 2968 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml

-- 
2.32.0


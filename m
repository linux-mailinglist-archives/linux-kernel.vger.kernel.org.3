Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6FB4F233D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiDEGhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiDEGhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:37:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3E4186E8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:35:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id qh7so14507834ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 23:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZVOlEoPcv7etW4yTPL40XZm6BrVD+zkvNhnS+k7d+84=;
        b=Mm+uE6NCTSD9QA5M4JvptIzC/jYfYYbosJo0l2q/SG1Sma4kJVbKoOTalxBEg8miUX
         3y73qyIPVcOKUJRz8imt/dH8uWiqNZseBtZFYcpE4cSoH6IZXqjA1lPSlYNG+A2v174z
         v/+RAoNM8ilhJIDNHmF+MaGjkgbHSgkmIFGRDjijB1xL/67NxV1uwD9md9VQWkMG/0Vj
         ot52LG1eAfXObUieCk/T4hIRvPE1LzoEotx4KotDoKgdZP1Vx8dPFwNUdmemwam8t1Qh
         1BG5StidWK3+MF/gS3SkPQmwycDZcRhJmJoyJ4EwsKvsw1vJHp0SZ7ZFj47jZKVYnt6z
         U2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZVOlEoPcv7etW4yTPL40XZm6BrVD+zkvNhnS+k7d+84=;
        b=rSh8EFXQFf/1jiufR86CfMoLI7qFQ+7ykp6S0KFOrZsM0s0AcwyOUfjC422R+SOqpM
         CGzQilzogEmBZzoAqRIr7fTVcsqduHpG7QS+5liykxKb5Px39mdOzX981Hy8+KUPkTOF
         Pn4MFe1/okzvHQSA4oubcjQgtfzfpwb++W8OsVpx7ar64nv4tqj/jmDS82eWixWL5Gug
         UvUeRJ9dr6UP8u5HQzHpBKbh9JzUOOyla6mQ3nDhwxU6O9t6+qWtgoulc4PfB7sxycku
         QVLDwfaBqw8feHS/F73TVPp5WFbCs5Osg0eCMDrrggTxbK3F5tRj2IoQy6RIvCYdhDwy
         5V8A==
X-Gm-Message-State: AOAM532EK+xdi1OdTc5nPlbALJYRC6F3kb23gHFgug+Ma/6b+nHHJrRI
        exfwlWGVOvLR2CP6e26OEhl3IA==
X-Google-Smtp-Source: ABdhPJxS7iOzqhI4WwYQ6CeegQwQdBFBkNc8Qc3CdBWtS3OsJ+afGAEfmelMeHB71yUMdj8gRD9aDA==
X-Received: by 2002:a17:907:6d92:b0:6e5:d50e:9170 with SMTP id sb18-20020a1709076d9200b006e5d50e9170mr1984668ejc.506.1649140508716;
        Mon, 04 Apr 2022 23:35:08 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bs7-20020a056402304700b004197e5d2350sm6086543edb.54.2022.04.04.23.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 23:35:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 0/9] dt-bindings: qcom: convert entire GSBI (QUP I2C/SPI/UART) to DT schema
Date:   Tue,  5 Apr 2022 08:34:42 +0200
Message-Id: <20220405063451.12011-1-krzysztof.kozlowski@linaro.org>
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

Changes since v3
================
1. Correct dmas in serial/UART bindings example.
2. Use "const" in compatible for GSBI.
3. Add review tags.

Changes since v2
================
1. Several new schema patches (GSBI, I2C and UART schema).
2. Several DTS fixes for clocks and DMAs. The choice of dma tx-rx
   and clocks core-iface was by more-or-less number of fixes needed.
3. Add Kuldeep acks to patches without changes.

Changes since v1
================
1. Fix path in com/qcom,gsbi.txt.
2. Merge clock-names in example, correct $ref path (Kuldeep).

Merging
=======
1. The DTS patches are independent and silence warnings pointed
    out by schema.

2. The DT schema patches should be taken together as GSBI (final patch)
   depends on previous bindings.

Best regards,
Krzysztof

Cc: Kuldeep Singh <singh.kuldeep87k@gmail.com>

Krzysztof Kozlowski (9):
  arm64: dts: qcom: align dmas in I2C/SPI/UART with DT schema
  arm64: dts: qcom: align clocks in I2C/SPI with DT schema
  ARM: dts: qcom: ipq4019: align dmas in SPI/UART with DT schema
  ARM: dts: qcom: ipq4019: align clocks in I2C with DT schema
  ARM: dts: qcom: msm8660: disable GSBI8
  spi: dt-bindings: qcom,spi-qup: convert to dtschema
  dt-bindings: serial: qcom,msm-uartdm: convert to dtschema
  dt-bindings: i2c: qcom,i2c-qup: convert to dtschema
  dt-bindings: qcom: qcom,gsbi: convert to dtschema

 .../devicetree/bindings/i2c/qcom,i2c-qup.txt  |  40 ------
 .../devicetree/bindings/i2c/qcom,i2c-qup.yaml |  89 ++++++++++++
 .../bindings/serial/qcom,msm-uartdm.txt       |  81 -----------
 .../bindings/serial/qcom,msm-uartdm.yaml      | 112 +++++++++++++++
 .../bindings/soc/qcom/qcom,gsbi.txt           |  87 ------------
 .../bindings/soc/qcom/qcom,gsbi.yaml          | 132 ++++++++++++++++++
 .../devicetree/bindings/spi/qcom,spi-qup.txt  | 103 --------------
 .../devicetree/bindings/spi/qcom,spi-qup.yaml |  81 +++++++++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi           |  36 ++---
 arch/arm/boot/dts/qcom-msm8660.dtsi           |   1 +
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  20 +--
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |  40 +++---
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  68 ++++-----
 arch/arm64/boot/dts/qcom/msm8953.dtsi         |  48 +++----
 arch/arm64/boot/dts/qcom/msm8994.dtsi         |  42 +++---
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  36 ++---
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  92 ++++++------
 17 files changed, 606 insertions(+), 502 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml

-- 
2.32.0


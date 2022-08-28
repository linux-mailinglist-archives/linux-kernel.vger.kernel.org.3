Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7A05A3CBA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 10:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiH1Inx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 04:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiH1Ins (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 04:43:48 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9659825EE
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:43:46 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id by6so5333658ljb.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=/Fwl045S1dsQ3HxEquGO5zqihazSyiEpOUfTmECs+Ek=;
        b=LWaybTeqNmE4QDBziHOyFv1uhoE0VljiIGD6CZSWq0lfzAI+eIonp6LQzY8JY2ovZZ
         wJVE2xsyP1Fk3DuUbN//QdutI/V6cbENT5U+QxUHe7mYr8xmEiaKgsO5+nGzC51N3rP6
         OlNeH7NyuwI5rM1r5NQmgwXgyLM2orSyfLwxzYjIgZWlx8Mklo7RVvGjaRCZwDMO4kPZ
         XKJHgO7ibYZAC1s1U02nWEuv1KKFd4sLIh2wD7sYQF3YRavf2yYR+nqe7FOt5XP6B59x
         bQFvU5ANsGbYWE078sP5LeToq2ZXWFC927SD93Ho0zfgVV9GX0Azstj2bH/nGwznax2H
         W5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/Fwl045S1dsQ3HxEquGO5zqihazSyiEpOUfTmECs+Ek=;
        b=IQMIuDgxfEmYLCWMG63ETKr31uHHpnMLY0FaTgkVSwDbq1Ztv7zY4wEhXxiRBqvkrr
         tVF73F4OeNQWDp02TYMKTXtfjuDpfCllHBor/mqrmh3hIBQVZtc0SCMYlXoH8s18R3Vu
         ejb+s5jF0kYXou9lv44oLl6VjOoVQpsUUrjwboQcELEkuuRHHy00PzJcCKtzHKg2hpan
         44BrtVsHm4bEv64FpYnB1v76pYVpk60umyKIq9XMCR0funDeSOJxxs1sBOED0k5g2F1a
         H41YUc3nU+1kcx3mt/pQhgGwWfQzPzSMuGNUeTsmgegEhiNRINzcwJW43w4ylHI7zd0f
         xQhw==
X-Gm-Message-State: ACgBeo3HG4X8ZKxOZYfCyFPs6Iy+B/uDQ3lZNGVlPmVxFEUXk5S2hkp5
        ndBp8n0KMzHa5Rnd/xKUJ7hCDA==
X-Google-Smtp-Source: AA6agR7UvIjrpeLlb0imNg+s4iFUQt4yjzH0e9ZN9Yl0F54Foe5OhPD2DoLBCOP3KZQfO97oJvv8mQ==
X-Received: by 2002:a05:651c:10b0:b0:261:ca24:def5 with SMTP id k16-20020a05651c10b000b00261ca24def5mr4136896ljn.169.1661676224920;
        Sun, 28 Aug 2022 01:43:44 -0700 (PDT)
Received: from krzk-bin.starman.ee (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id c6-20020ac25f66000000b0048afe02c925sm890114lfc.219.2022.08.28.01.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 01:43:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/14] arm64/dt-bindings: mfd: qcom: SPMI PMIC fixes
Date:   Sun, 28 Aug 2022 11:43:27 +0300
Message-Id: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
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

The Qualcomm SPMI PMIC DT schema conversion was not really tested and several
issues in the bindings and DTS should be corrected.

1. The DTS patches can go independently.
2. The binding change continuous work of PWM reg fix and depends on it in
   context (diff hunk):
   https://lore.kernel.org/all/20220827145640.3530878-1-bryan.odonoghue@linaro.org/
   Binidings changes and above, can be taken via MFD tree (fixed commit was
   merged in v6.0-rc1).

Best regards,
Krzysztof

Krzysztof Kozlowski (14):
  ARM: dts: qcom: align SPMI PMIC ADC node name with dtschema
  ARM: dts: qcom: pm8941: align SPMI PMIC LPG node name with dtschema
  ARM: dts: qcom: pmx55: align SPMI PMIC Power-on node name with
    dtschema
  arm64: dts: qcom: pmk8350: drop incorrect io-channel-ranges
  arm64: dts: qcom: pmk8350: drop interrupt-names from ADC
  arm64: dts: qcom: align SPMI PMIC ADC node name with dtschema
  arm64: dts: qcom: align SPMI PMIC regulators node name with dtschema
  arm64: dts: qcom: align SPMI PMIC LPG node name with dtschema
  arm64: dts: qcom: align SPMI PMIC Power-on node name with dtschema
  arm64: dts: qcom: align PMIC GPIO pin configuration with DT schema
  arm64: dts: qcom: sc7280-idp: correct ADC channel node name and unit
    address
  arm64: dts: qcom: sdm845-mtp: correct ADC settle time
  dt-bindings: mfd: qcom,spmi-pmic: fix regulator node schema
  dt-bindings: mfd: qcom,spmi-pmic: fix TM ADC node schema on PM8998

 .../bindings/mfd/qcom,spmi-pmic.yaml          | 20 +++++++++++++++++--
 arch/arm/boot/dts/qcom-pm8941.dtsi            |  4 ++--
 arch/arm/boot/dts/qcom-pma8084.dtsi           |  2 +-
 arch/arm/boot/dts/qcom-pmx55.dtsi             |  2 +-
 arch/arm64/boot/dts/qcom/pm660.dtsi           |  2 +-
 arch/arm64/boot/dts/qcom/pm660l.dtsi          |  4 ++--
 arch/arm64/boot/dts/qcom/pm8150.dtsi          |  2 +-
 arch/arm64/boot/dts/qcom/pm8150b.dtsi         |  4 ++--
 arch/arm64/boot/dts/qcom/pm8150l.dtsi         |  4 ++--
 arch/arm64/boot/dts/qcom/pm8953.dtsi          |  2 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi          |  2 +-
 arch/arm64/boot/dts/qcom/pmi8994.dtsi         |  2 +-
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |  2 +-
 arch/arm64/boot/dts/qcom/pmk8350.dtsi         |  3 ---
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |  2 +-
 arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi     |  2 +-
 .../boot/dts/qcom/sc7280-herobrine-crd.dts    |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts       |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  2 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       | 12 +++++------
 .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  2 +-
 21 files changed, 46 insertions(+), 33 deletions(-)

-- 
2.34.1


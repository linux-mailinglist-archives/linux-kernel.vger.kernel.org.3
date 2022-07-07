Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1C6569C79
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiGGIEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiGGIEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:04:40 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A9DE00
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:04:39 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id w2so4920265ljj.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6cTL70t81aTnV9x0x+mDaCfTVWwcqwkSWQQpbKRysc=;
        b=je6ZJ8G24GI5T7f3zVncXY2R3x/GyryMMiZeWydkL5djDwH1y3R7eh9Jq7GZ+VjSmb
         a+eZLklX94jyOz1YD9eehlDaxgYhFP6qzL8qeUH37Tl8CnuJ36fytFm/LKbEq5ghCWY7
         52C6lpBA/LauPnoSxudh+wPUKILLcfTJMzWPlgNch+LCoN5IgLz2Ehm9S+caQ5g3MFfv
         lfFYLqzsKAOcxRUzYSGYFwsSx9YRZZcaNuffd5QCnza1wOsBnwCksWBuR8uwRT0ydprz
         tl8NMIphq/6HsC8d9JJPNgkNAqR+qMtNZJQSjeh7/RRcJbvchImmlZUiQ7Wr3633/+3q
         N/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6cTL70t81aTnV9x0x+mDaCfTVWwcqwkSWQQpbKRysc=;
        b=lkFnf5OH0NhCc4V6kadQ7/1grSwhyIHCmqCc+jOH+bw5HJqORAP1CCh+DT/hm1T/PI
         ly/jstYhntcNTCcTfnu/UqaciCogd9y/TFVijmDzl/8fNktZcJCkKXQhUDdHN1SFenr3
         YxPIDA3XLyB6r9SyHf1YEbOmGECAIycqhQg3Is/S7jwjGDY3+zfXCbbWXYHe5x6Y4q6W
         CoR0dfW0dcZ41GacYW7b3LmIU5G305FODPRHRQk5Hff7smLlgMQUcaKx4y5sHiDpMkvY
         EHSbKEya2VNZl4mIsa6Ou85XKRK2L/vRTGINu1m5eEvGWyZGKVG2Pl173KoHfTD6P/9f
         eXuA==
X-Gm-Message-State: AJIora/u2ccvDFs6fPLgT2baiuUWjQJPUisnIFSAwaUjwcMfw00KHzBL
        3te+ZWU7hxSYxGDA9yrrxvyjMw==
X-Google-Smtp-Source: AGRyM1s/K+WamhzckF/8xnMBEQZ4YAGMlkNm4IeBoow2nLBL8pH0v4jvCtU+LTl5jPsnxiMxi2PgOg==
X-Received: by 2002:a05:651c:511:b0:25b:f78e:cb30 with SMTP id o17-20020a05651c051100b0025bf78ecb30mr22584914ljp.327.1657181078252;
        Thu, 07 Jul 2022 01:04:38 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512214600b0047b0f2d7650sm6697187lfr.271.2022.07.07.01.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:04:37 -0700 (PDT)
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
Cc:     Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/5] dt-bindings: mmc: / ARM: qcom: correct reg-names and clock entries
Date:   Thu,  7 Jul 2022 09:51:46 +0200
Message-Id: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org>
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

Best regards,
Krzysztof

Krzysztof Kozlowski (5):
  dt-bindings: mmc: sdhci-msm: fix reg-names entries
  dt-bindings: mmc: sdhci-msm: constrain reg-names at least for one
    variant
  ARM: dts: qcom: align SDHCI reg-names with DT schema
  arm64: dts: qcom: align SDHCI reg-names with DT schema
  ARM: dts: qcom: align SDHCI clocks with DT schema

 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 40 +++++++++++++------
 arch/arm/boot/dts/qcom-apq8084.dtsi           | 16 ++++----
 arch/arm/boot/dts/qcom-ipq4019.dtsi           |  5 ++-
 arch/arm/boot/dts/qcom-msm8226.dtsi           | 24 +++++------
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 24 +++++------
 arch/arm/boot/dts/qcom-msm8974pro.dtsi        |  6 +--
 arch/arm/boot/dts/qcom-sdx65.dtsi             |  2 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |  2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  2 +-
 13 files changed, 77 insertions(+), 60 deletions(-)

-- 
2.34.1


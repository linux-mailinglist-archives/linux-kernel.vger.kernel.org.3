Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68BC519F51
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349445AbiEDMbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345750AbiEDMbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:31:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07425240AC
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 05:27:33 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a21so1523294edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J9R3Lsqjcoyq8xBzCQ7oMbOHcOpzWiLwQluOtaowe4M=;
        b=ZDFzQBE+/w7Mm1JfSHlBFMWC12aJmVXpdoIL8k4jma12fhI26nXzZT7pjCBjuxoUPK
         4Vs+e2Mr8SiIXAUzv2OgAiKRr63tB1N0xNeapCZlo4Nvw7lSh/95Iv9rIJacgVso96vv
         oVGXEKmFeAHDNzbcMCeIxZ99IV4wFn1asusC5/w2SwdNn2S1UKxdqlmzUTZ3/gC8E+vN
         0IHmzrLkeBe0I1dPrblQNVMwuoF0lNhITxYZu6rIDO1XNFVHLtZ5JkrK6sLblo5zwD+G
         5nuIIcantrDlw3C+80pBFYBkDkWxpLbTLvJeIyPgs3CoM4MCfCWvNLW/U4TC3l+uei93
         CMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J9R3Lsqjcoyq8xBzCQ7oMbOHcOpzWiLwQluOtaowe4M=;
        b=MxD9P+9luSBLaTXs6SDWTiP/H9G93lscl/veMR3XMcvA9fvOAOAK9M35Yi/4PuKkCN
         iTKpiUJZGdjwoeJ8yK/cyGcUSjaR0EWkhR4PxFeKNIKyXfCYT6KOvYrDqUPb+FpHsoWI
         fuB3lRuiXMT2xNV4ij6iqhEBGRjqwcf0Ch6e9SZQZiM8yx7b65Ihcw/n4FTpzR6fXCyE
         OqN3OAGsPBWrXHXQ5yd41nXZyKHdhX7OKhzaNpiesvX875qbXmvkupldKEPbehnV1EVa
         5k8vISNB4YzP9ogd/TjGWBACnLCau4cuZ/n+0iM+lRi7HdbrrbgZdf2xsHSrVRVZ3/KA
         rpFw==
X-Gm-Message-State: AOAM533mNb5zi2oD1OyH79Et+PERHLGFoJJEbM/PuUTG9BB/9t5P+JEH
        QmhzbP9zwM+z3deZYuL4WZgqvMR9MbNRqw==
X-Google-Smtp-Source: ABdhPJwrxZtnX0wxqljSsLFU8r1SztMvEgtOve76g4EWg1J/NHn3VNdPNVFo8rs9bpMDLkhLZDuFfw==
X-Received: by 2002:aa7:d9d6:0:b0:425:dafc:2fc6 with SMTP id v22-20020aa7d9d6000000b00425dafc2fc6mr22490855eds.340.1651667251521;
        Wed, 04 May 2022 05:27:31 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id mm30-20020a170906cc5e00b006f3ef214e06sm5675557ejb.108.2022.05.04.05.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:27:30 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v3 0/6] SM8350 Display/GPU clock enablement
Date:   Wed,  4 May 2022 14:27:19 +0200
Message-Id: <20220504122725.179262-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
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

This series depends on a patch[1] for parked RCGs, which is being reviewed seperately from this series.

Additionally this series is pending a decision about .fw_name .index  for new drivers, so please don't merge this yet.

[1] https://lore.kernel.org/linux-arm-msm/20220426212136.1543984-1-bjorn.andersson@linaro.org/


Changes since v2
 - Dropped "clk: Introduce CLK_ASSUME_ENABLED_WHEN_UNUSED"
 - Dropped "clk: qcom: sm8250-dispcc: Flag shared RCGs as assumed enable"
 - Dropped "clk: qcom: rcg2: Cache rate changes for parked RCGs"


Jonathan Marek (3):
  clk: qcom: add support for SM8350 GPUCC
  clk: qcom: add support for SM8350 DISPCC
  dt-bindings: clock: Add Qcom SM8350 DISPCC bindings

Robert Foss (3):
  arm64: dts: qcom: sm8350: Replace integers with rpmpd defines
  dt-bindings: clock: Add Qcom SM8350 GPUCC bindings
  arm64: dts: qcom: sm8350: Add DISPCC node

 .../bindings/clock/qcom,dispcc-sm8x50.yaml    |   6 +-
 .../devicetree/bindings/clock/qcom,gpucc.yaml |   2 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |  42 +-
 drivers/clk/qcom/Kconfig                      |  12 +-
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/dispcc-sm8250.c              |  60 +-
 drivers/clk/qcom/gpucc-sm8350.c               | 637 ++++++++++++++++++
 .../dt-bindings/clock/qcom,dispcc-sm8350.h    |   1 +
 include/dt-bindings/clock/qcom,gpucc-sm8350.h |  52 ++
 9 files changed, 800 insertions(+), 13 deletions(-)
 create mode 100644 drivers/clk/qcom/gpucc-sm8350.c
 create mode 120000 include/dt-bindings/clock/qcom,dispcc-sm8350.h
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8350.h

-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65E0557848
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiFWKyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiFWKyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:54:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4A24B43A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:54:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u12so40191983eja.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITqWXPM0CMutsVQgWnD+dufUaUOFlV5N4sbMJ4eWGxc=;
        b=LBG1ZLEW6BFd+jvGvjrJU1oXS33K++g2frwy0dEaIVaujicywMYeScGmpjkyr/cd9L
         OkNUVjFZQtz6k4pMKqLIZpHrijNdToZnVo+EKLfVVxQJpg0+5Vt0wVA93X8zwNTTaYe2
         157z6rXWbggVB4nEnHqJfDEmwEu8Q2xOx5p5I4qwx4T/Dgw2zcGFs2XffsppfZupqg7c
         edXqDVXcDmtj3l0qkHvocpFH0lBpzqDI4EsZTCQRgXUpudVRC6t/7kHG/B40lmponObN
         f7QLGBQQG3Yj6Ci/ZMFeRduqZH9FWx61VtKCbCEOsftqcc0oIgS2SpwUJ84l6pTCjxlq
         Ll6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITqWXPM0CMutsVQgWnD+dufUaUOFlV5N4sbMJ4eWGxc=;
        b=RkAi0s+ohe1w04AZdgn5XnSvWAQ6nrY7HSh7C9CwqNiH5x1PrjnjouRRjpdYoplGFc
         uv8ojzyKAWlbbAZ9nPzd+CZU0zy4T/8qSj8Qu8tuw/eIXW2V86CHk5HQTIMeZANsNe8H
         YQYS0QKHp3OL1OopLbFHkpuKemrS+SY2gzWd+794SGpHKOKgTTvQ2J7iVE8+ciLGt6G4
         AwpbQ6hI8I96ZBN4rlCYXn3q8oYjdq3pppwCghx70HOBLhleaPMoKHFYc3MgksDfXpZ3
         0+DcHGYkpKiIiCM7rVLXGPLfil28JXedW2wxgMsEpImTPSKoZs7x0Dgr0i6hiHyPmFKs
         qcxg==
X-Gm-Message-State: AJIora9uK4PNOna16yxmmVEHbgpGKaLbvsBRN/Wonv3S+BxcPdf5Ak/m
        RAfCO6pDjRGeajSVkq6su5vidA==
X-Google-Smtp-Source: AGRyM1vbv2UsG+PPRTCgO6q66zSNufB51hMleDw8etsnFIZ0GMqq+d+Gqvdhi9dVLDt9P86ejDK1cQ==
X-Received: by 2002:a17:907:3f84:b0:724:2ec:b474 with SMTP id hr4-20020a1709073f8400b0072402ecb474mr3175563ejc.644.1655981645363;
        Thu, 23 Jun 2022 03:54:05 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k27-20020a17090632db00b00721d8e5bf0bsm7854096ejk.6.2022.06.23.03.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 03:54:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 0/3] dt-bindings: arm: qcom: qcom,board-id and qcom,msm-id
Date:   Thu, 23 Jun 2022 12:53:58 +0200
Message-Id: <20220623105401.168122-1-krzysztof.kozlowski@linaro.org>
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

Changes since v3
================
1. Patch #1: Define all SoC IDs, based on Qualcomm socid driver (Konrad). Keep
   Dmitry Rb tag, even though it is quite a change.
2. New patch #2: use bindings in the socid driver.  The patch fails on checkpatch:
   "Macros with complex values should be enclosed in parentheses"
   but that's expected considering the macro contents.

Changes since v2
================
1. Adjust description of new fields after review (Dmitry).
2. Change name of msm8996 define (Dmitry).
3. Add Rb tags.

Changes since v1
================
1. Make the qcom,board-id and qcom,msm-id properties deprecated and limited to
   certain SoCs (Rob).
2. Extend the qcom,board-id schema to match OnePlus variant - four elements -
   and drop DTS patches splitting four into two touples (Stephan).

Description
===========
The discussion [1] brought several arguments for keeping the qcom,board-id and
qcom,msm-id properties.  Keeping means we should document them, so the DT
schema checks pass.

I revived old patch [2] with several changes and improvements.  The commit msg
hopefully collects feedback from the discussion.

Best regards,
Krzysztof

[1] https://lore.kernel.org/r/a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org/
[2] https://lore.kernel.org/all/1425503602-24916-1-git-send-email-galak@codeaurora.org/

Krzysztof Kozlowski (3):
  dt-bindings: arm: qcom: document qcom,msm-id and qcom,board-id
  soc: qcom: socinfo: create soc_id table from bindings
  arm64: dts: qcom: msm8992-xiaomi-libra: split qcom,msm-id into tuples

 .../devicetree/bindings/arm/qcom.yaml         | 121 ++++++++
 .../boot/dts/qcom/msm8992-xiaomi-libra.dts    |   2 +-
 drivers/soc/qcom/socinfo.c                    | 259 +++++++++---------
 include/dt-bindings/arm/qcom,ids.h            | 146 ++++++++++
 4 files changed, 401 insertions(+), 127 deletions(-)
 create mode 100644 include/dt-bindings/arm/qcom,ids.h

-- 
2.34.1


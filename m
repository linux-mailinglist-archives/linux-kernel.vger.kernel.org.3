Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66D3537276
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 22:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiE2U0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiE2U0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 16:26:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32C15FAE
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 13:26:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q7so1239203wrg.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 13:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h8ru6+TUygsITuuMy5/fU0s1hgN1EJHJdiikz744dEY=;
        b=BV/wRTutp18iyRwJngQpHf66dQIc4xk8P8lL8rUQE27zJzvXhu5DxBlCtH+I8JyB6G
         xgIyGkBJ7pJc4c97UxXKih8tsrYm+CVt5UyPggSKMHZk1XowuAkwj7elJXS5yndSyTvc
         HIDk/d4i3+ciWZoBPJQwx29ZP9Rma7dGaqVcyFopybanzRRGnJ7Xvi91/wdAOWV8s9+c
         DpLOMNiiRkbLasG6Yp2qjryI8KKD1hgSTi2TLSMJBtGDPZWoK2L/4uTdEUsE97ITcs2K
         DoFaWiV2o0Po7V3RjoO0zGViHlr5FltffPXqZBsW2j1JQmpSjTr4FGjNzucVg+TxLiKt
         JtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h8ru6+TUygsITuuMy5/fU0s1hgN1EJHJdiikz744dEY=;
        b=tNtLwOu6vkji6/lzh3PGlQTbj15T4OsnLRaGZxawE9lTg2NecGgZ/+WQTkib3+keta
         ijNldRAPjJW+2YIfp4NOUSiX16kebh5dQdm1h4OXLa4C2+fWHzJI91VuOoZGTMauxJPP
         PM0L+3qFSv/U234EwQnfosGYTo5PkKnaawZpifhWfo2nChuFQGQoX7LQaoo9x8IAgRJA
         saSH1IMUvuB/+P/qi1Jbe77Qs9FfyJXL7iIysJz3U2wkYMwksGZclHhXKRhVyatFlfeL
         3HmIWqZzFFZA2bSMJSKPA1k2utuzCJP8rXSigj3JYXIP6DNQ7Hu2J77CmmtGPrppxnvY
         a61g==
X-Gm-Message-State: AOAM530klZqN9WugoUBchGiZXwWGqo1a5S6cbMxRchge2KQCv95GtGp3
        x2IXSa0wlKLObTxKj7PMeS6nbw==
X-Google-Smtp-Source: ABdhPJwF3WjG8bKJP/LnrPfGtqIR6zFTacfn+stRp1U8CpS2jgaHGQDcas9p3pJQqDzFs6iTtmQJEw==
X-Received: by 2002:a5d:6b49:0:b0:20d:45a:98bd with SMTP id x9-20020a5d6b49000000b0020d045a98bdmr43230290wrw.446.1653855994099;
        Sun, 29 May 2022 13:26:34 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d6144000000b0020c5253d8f7sm7099310wrt.67.2022.05.29.13.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 13:26:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/4] dt-bindings: arm: qcom: qcom,board-id and qcom,msm-id
Date:   Sun, 29 May 2022 22:26:25 +0200
Message-Id: <20220529202629.47588-1-krzysztof.kozlowski@linaro.org>
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

The discussion [1] brought several arguments for keeping the qcom,board-id and
qcom,msm-id properties.  Keeping means we should document them, so the DT
schema checks pass.

I revived old patch [2] with several changes and improvements.  The commit msg
hopefully collects feedback from the discussion.

Best regards,
Krzysztof

[1] https://lore.kernel.org/r/a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org/
[2] https://lore.kernel.org/all/1425503602-24916-1-git-send-email-galak@codeaurora.org/

Krzysztof Kozlowski (4):
  dt-bindings: arm: qcom: document qcom,msm-id and qcom,board-id
  arm64: dts: qcom: msm8992-xiaomi-libra: split qcom,msm-id into tuples
  arm64: dts: qcom: msm8998-oneplus: split qcom,board-id into tuples
  arm64: dts: qcom: sdm845-oneplus: split qcom,board-id into tuples

 .../devicetree/bindings/arm/qcom.yaml         | 58 +++++++++++++++++++
 .../boot/dts/qcom/msm8992-xiaomi-libra.dts    |  2 +-
 .../dts/qcom/msm8998-oneplus-cheeseburger.dts |  2 +-
 .../dts/qcom/msm8998-oneplus-dumpling.dts     |  2 +-
 .../dts/qcom/sdm845-oneplus-enchilada.dts     |  2 +-
 .../boot/dts/qcom/sdm845-oneplus-fajita.dts   |  2 +-
 include/dt-bindings/arm/qcom,ids.h            | 30 ++++++++++
 7 files changed, 93 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/arm/qcom,ids.h

-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484355539DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 20:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352204AbiFUS5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 14:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352194AbiFUS47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:56:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D692A24E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 11:56:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id e5so8004691wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 11:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MAE15+uRagTlK+c2TFhZlYB3GN3MmW6xrYt0iUHtakw=;
        b=qNHCwJDs3SVr2xlcN0pxTRz5pt6W/9NJzFsqYTDX70iKdgWjkM/A3o5DS58BfYkrL0
         /VUN+O0WEzId26TKrER/ikSGMHZuRgJlPCdbWICl3Fo45DGa3j3VG3FmBScz/oAQnNjs
         hJg23bcg5wR8lqNIgXBF1vPaARlfA6Ti+I8yqFsdgR1ywd9YMLzdzvyPwZmgEEei0ueR
         aJKr+IL5KfsQvQRuZLr4ABYXM3V6LI26LACgeM1JRB6efRzxS7+fZGGKw+ro7zF2poWA
         +SmOx0B9TRmvM52ESqi+X5XbpMsPZs8gEHXsG703PLCKLFd3xWKXsnxyAWnqjKFTUnA0
         qcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MAE15+uRagTlK+c2TFhZlYB3GN3MmW6xrYt0iUHtakw=;
        b=Tl1AUr8liLPCV+0JdgqjDGuoaETqN+7QCLNf1aOvrDfAZy5QV4AjY+X2chr/Z4RIBj
         wESKr7tpcamF//kQ1yS8JvbCQVvE0BQa3SSPFDd5UbGy9Aim4cHViFY+pxiatQphpGws
         BVmeo4BkcaRBfHniKBUvB7pVeYXl2nATrXJ6mOqwK1aZ7bHRQEQhFkagO2Oohc5dOJya
         qLNU3b1aYIvHvZ1EuCwz1TwbFj/1THROn8WMensCh6yCSpKaIz4cTXbdQ81nkK4y932/
         4haUqJHlvkcYedm+YpQPqkhLTscyopsnGwYFb+OfuKValLFV9Buxs0qzgpWN41F5+Srs
         O3wQ==
X-Gm-Message-State: AOAM5316Ag9xfjDq9RylB3QaNiE0sgljzMw15kKBfSyrkKC95Jy8mtJP
        JvLJVlc8DqGdlO3moZYGBcKYvQ==
X-Google-Smtp-Source: ABdhPJyMTmOn6VvC9oK/W0wrY5MF2afG5xmsce7eVsRzGKZu+UWBIiz85sb/bgOaQ6OEHyQXawZyOg==
X-Received: by 2002:a7b:cc94:0:b0:39c:4507:e806 with SMTP id p20-20020a7bcc94000000b0039c4507e806mr42707775wma.91.1655837816332;
        Tue, 21 Jun 2022 11:56:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f6-20020a1c6a06000000b003a0231af43csm294903wmc.48.2022.06.21.11.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 11:56:55 -0700 (PDT)
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
        Kumar Gala <galak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/2] dt-bindings: arm: qcom: qcom,board-id and qcom,msm-id
Date:   Tue, 21 Jun 2022 20:56:47 +0200
Message-Id: <20220621185649.37391-1-krzysztof.kozlowski@linaro.org>
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

Krzysztof Kozlowski (2):
  dt-bindings: arm: qcom: document qcom,msm-id and qcom,board-id
  arm64: dts: qcom: msm8992-xiaomi-libra: split qcom,msm-id into tuples

 .../devicetree/bindings/arm/qcom.yaml         | 123 ++++++++++++++++++
 .../boot/dts/qcom/msm8992-xiaomi-libra.dts    |   2 +-
 include/dt-bindings/arm/qcom,ids.h            |  30 +++++
 3 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/arm/qcom,ids.h

-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A33052EC32
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349372AbiETMdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349368AbiETMdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:33:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E27B1660B8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:33:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c19so973454lfv.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0nYhv1nPF+LOWvBH2h9U+emDwliIywhBz9unRXuVff8=;
        b=CDIy1o7JzUQ8oO1748IY88xdw8Ua+rGPADPPyoThG/Xnlz/eHKS4pb2QGraPmx2knR
         upjQAjqiHsd3dsMrTZnGFpmPoq4DpY1EP5OHEBoluomy6KSQaBUQVgy0WSLcfXJz3yKE
         nmS4P72VtJSS+7h54PJUGI6I+MOcF33XNV6H7p8lxvaApeDM1ef5T85CdoUgA3mbvhx4
         Drf4ql4fyKQMyc7KLxDJSkLCvDtEx/W3mmP0LgFPQlJxVOMHgwsqbAoDCDIqmEuRTmJT
         b4eEh+r+AGI15VYc2PgfIM2f+s7NzQSjkhzqd18caoEIChhFhAFad1zSV/oatzFndsJJ
         28mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nYhv1nPF+LOWvBH2h9U+emDwliIywhBz9unRXuVff8=;
        b=rZuT0UFVYo+PzV3SbDP+xJdwWs2JjKAe3VQR4Ah4QSG2OEdtKoKUQjtuvI4qWcmJvU
         +Vfxn8QLDT5AOdClgaFbv44vtAHQ7wAPHEJJ1Qe+y557mNFqmfIW4EkykljP87XartgX
         Sj7BXKmsLTZn00m+v9ZCFks9jyzkJhgioW5nx+2erqnJiQO3rYFEdmNyIpLmvWyYbJuF
         yvKkDRg4iN5Kzzzdi/7b1GgJHRs9Nk/Gq9pptt62EFTyLfz94T3MN/y3dBkPmWhp86iQ
         6v1CXCWTnrO9FYRLm8TuSdvD5dTRNucQQHbjeFIBCH+8w3vudG9Olw10ce4XREL20945
         1MwQ==
X-Gm-Message-State: AOAM53245tQQYD4Sfndo4Yg0wG61fNTGaRI8Ca4SZjdQDuNW7v3kB9pX
        6EvhzxEyzjluCS9jzeYCNamQmQ==
X-Google-Smtp-Source: ABdhPJzH0eTCGcr4er18fwN1OAwNl7z7bDJwYFHVl/nuToICzEzhRN22hemPJ9frItGFrqfqVlRceg==
X-Received: by 2002:a05:6512:139a:b0:474:15ce:9204 with SMTP id p26-20020a056512139a00b0047415ce9204mr6535256lfa.461.1653049986242;
        Fri, 20 May 2022 05:33:06 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512374e00b0047255d211bfsm643973lfs.238.2022.05.20.05.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:33:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 9/9] dt-bindings: arm: qcom: add missing SM8350 board compatibles
Date:   Fri, 20 May 2022 14:32:52 +0200
Message-Id: <20220520123252.365762-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
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

Document several board compatibles already present in Linux kernel.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index abc5f709678c..25ae8a850be1 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -319,8 +319,11 @@ properties:
 
       - items:
           - enum:
+              - microsoft,surface-duo2
               - qcom,sm8350-hdk
               - qcom,sm8350-mtp
+              - sony,pdx214-generic
+              - sony,pdx215-generic
           - const: qcom,sm8350
 
       - items:
-- 
2.32.0


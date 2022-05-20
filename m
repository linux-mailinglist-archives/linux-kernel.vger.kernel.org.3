Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2088452EC34
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349359AbiETMdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349332AbiETMdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:33:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE57163F7E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:33:05 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id l13so7407125lfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hn3/9kUSa1/kuIhOYNB1KYwxshqDjg7Lqg5RGdir50Q=;
        b=GTnkzypVpWOR58+R3H1CHNGDU57dIHIQa9bX4qEssKnYbQmaeDGq8hM850mBnNo5zx
         YBrM3kOxfR8t3ZRiDMvHRVo6C0hPxa9/1JjG0PtfLvETPU8L2pREFiZy4j+WQWfPE8md
         EKTxZ2alLFMLyPz59p2Kd8BYWhn6cM72dnCt7LEYcA1JSSAy2kneAiumPc55yrR5eDdr
         +I1ZE6eZpGubLarXHWZj7zmzM27BA+Zotj8kCeLLfF51vZaeiH4+TyKmAjbfOzgcMCMp
         ewqDWn0owSfEhq15M0KWK7mKoBlKhfJ3MJp/U0sTQ3cmImNW0jWszy53hpCgaEXURFvl
         /hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hn3/9kUSa1/kuIhOYNB1KYwxshqDjg7Lqg5RGdir50Q=;
        b=v300N3mdeLWZxDDXzPdAaUi1PaH2N+0+rM8OsJ7oOKkr/QuaR7p+UlB1HPlnaVczF0
         J/blLGpdFcjgB4yUshZfJPiXhZnBAYKxsUTjfNLis0hPto5YDR76dGFG7xcJu0pYTIjR
         tw5+BtTkB25QZ087jL0gWINQGp9Y+b3e30DjcX67VNiwI9NLPbc9WX+RHEDR8pBs77MF
         Dr6zPfCPkkGAeN1xAdPiXrPOmd26uWBDzorsOJFRMHphZBKqPX+1rWx347TJ9p9mOWvE
         HOG4ZHnEtZZajA5Xb+/tOSiwenXwrbjwLv0aejAEHyeOYcuVL81NvRx5KwyDZKv22mzZ
         gVEw==
X-Gm-Message-State: AOAM530fjhasjMytG3wZr1+OL19VNuK4nOGz+JpDDwy2BffwztF07GBw
        s8PIgKTmUEAFYml+X27r826ByQ==
X-Google-Smtp-Source: ABdhPJxyK4/5DD5Ttz5+aitQgtY5m2pgRLdttq2MCPEn7e2qdAntd/di98ShYfStffq2IN+/ziz/XA==
X-Received: by 2002:a05:6512:3e24:b0:478:55ff:8e44 with SMTP id i36-20020a0565123e2400b0047855ff8e44mr1320030lfv.78.1653049985071;
        Fri, 20 May 2022 05:33:05 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512374e00b0047255d211bfsm643973lfs.238.2022.05.20.05.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:33:04 -0700 (PDT)
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
Subject: [PATCH 8/9] dt-bindings: arm: qcom: add missing SM8250 board compatibles
Date:   Fri, 20 May 2022 14:32:51 +0200
Message-Id: <20220520123252.365762-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
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

Document several board compatibles already present in Linux kernel.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 7b6deb766c6c..abc5f709678c 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -311,7 +311,10 @@ properties:
       - items:
           - enum:
               - qcom,qrb5165-rb5
+              - qcom,sm8250-hdk
               - qcom,sm8250-mtp
+              - sony,pdx203-generic
+              - sony,pdx206-generic
           - const: qcom,sm8250
 
       - items:
-- 
2.32.0


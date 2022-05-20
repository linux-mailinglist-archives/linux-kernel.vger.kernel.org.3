Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1405B52EC2E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349334AbiETMdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349309AbiETMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:33:03 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F153E163F77
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:33:01 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id i23so9518600ljb.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FTuvAmNdnqdvE/8wL2UC/iwKT7/fppBPnvSA/RuAA1s=;
        b=WJ8bTULuEv77wPqCeQzUS8BcxdjrjYLaaV9uRMYCJy9Vd7Tgtf124y5P2MoyIlwXyc
         EaVxwJcqz63X5t/19D+FL2oqeaZxwrWzngWsyFMmFYCvUk//P29epeFbqyxfsBodBvfQ
         TI63FopHkhB5i0bDCAfiXTkc5DuB0lvZxNwJ5ScwqF0aqLy/QtCe8c4THhGCM9M4jvJh
         THmqtWi64y3fgnYdhjtTYBrjOSDqdbN6gyo2erpRB3Hdn1Msk28bkl8bfEUeElUmV+No
         5R1PH/w1GLXJYTr/2+20kRVpXVIYKB59XmVOEaD33jjIvUcRWedkDgSZ4sx0DaYiu3LK
         2fIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FTuvAmNdnqdvE/8wL2UC/iwKT7/fppBPnvSA/RuAA1s=;
        b=xRS+k7THd9Hnq8W4eShxmPmUSDocB/EewyqjAw/8b+NvOzWBHpOUaaVkmjk0Sb1YVa
         DO1fzNcLbHu0xgOvVjjjSa6CwGiwc4uS9x+TFxKbUCD8qzDUbf4DOLcWv0cH888mVk6G
         9K0iHCcGjnLPl4ew8dak3IyzKsDS0G/FyM/vknvGBaqVekNTGXi3E4mz2WxA1983CdBm
         4XMp9Vw5qWhIaOOeP5+60ohD3JuaoxRwxunifPgoG3Gk0ZxpUL3JE9vq3qYbPMbiFJWF
         LOoh2umG65fMWCiO4ltcJIToEFd+Ohxj6kUp6lm62nccXXtQBXc/DyB6Kxy1krF0g4BW
         b3aA==
X-Gm-Message-State: AOAM530jk6k49txB7WUhLSR9umkpTjvOy6DmE8wbIumRGG0jdIGFYcHk
        CAY7kasvrWjoCXMWFvGXr9BZhg==
X-Google-Smtp-Source: ABdhPJxiOfdNJUV0bZTxeVWMj3jwLJ9BaFDnExgZXj3y5M2vLVQ/Wr4knsDQw6/DAfI5n8JpG5jKoA==
X-Received: by 2002:a2e:9a84:0:b0:24f:4160:305d with SMTP id p4-20020a2e9a84000000b0024f4160305dmr5346810lji.375.1653049980328;
        Fri, 20 May 2022 05:33:00 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512374e00b0047255d211bfsm643973lfs.238.2022.05.20.05.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:32:59 -0700 (PDT)
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
Subject: [PATCH 4/9] dt-bindings: arm: qcom: fix MSM8994 boards compatibles
Date:   Fri, 20 May 2022 14:32:47 +0200
Message-Id: <20220520123252.365762-4-krzysztof.kozlowski@linaro.org>
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

The compatibles for APQ8094/MSM8994 boards are different than specified
in bindings.  None of them use fallback to other SoC variant.

Fixes: 9ad3c08f6f1b ("dt-bindings: arm: qcom: Document sony boards for apq8094")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 5ae6fc79fb5d..88759f8a3049 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -172,12 +172,15 @@ properties:
       - items:
           - enum:
               - sony,karin_windy
+          - const: qcom,apq8094
+
+      - items:
+          - enum:
               - sony,karin-row
               - sony,satsuki-row
               - sony,sumire-row
               - sony,suzuran-row
-              - qcom,msm8994
-          - const: qcom,apq8094
+          - const: qcom,msm8994
 
       - items:
           - enum:
-- 
2.32.0


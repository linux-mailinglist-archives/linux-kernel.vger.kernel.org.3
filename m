Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC3E599005
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345725AbiHRWGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiHRWGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:06:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883F7D21FD;
        Thu, 18 Aug 2022 15:06:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o22so3517121edc.10;
        Thu, 18 Aug 2022 15:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+/nnw6P3VjEE7fxsWw9HS7hocIb1CR7Edy+bXNA5xbE=;
        b=GqVlQND4Ffnhd10O5kdtYmasl4lYsiHuOHijvyeuejZibxkh6pgTGB/1Q4+P2pXXtf
         QHXifGoBLmD3+rFuaIYZfWGreKWAEwGrw8qJH4/og6VfOk/5B3MqUpuJbCEd59Rimtav
         112M7O33GK1xc3fRWSo2AGMy691pRXYs6omlu1bhEtlQR7TkmiJ5LqYNVe/olde2I9hm
         U7b0gfzV431wEYeS8guM70bHKjbu5NXAeqSYNUuNDMDjrE3319qknMz64TOHCYi6cqvn
         mMKsTNZ3OFN9lig95nuTqoxcbv7w6Sk9/26DPdBgKHQz/JjTcS8HiT7hZodsmb72D9Du
         hKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+/nnw6P3VjEE7fxsWw9HS7hocIb1CR7Edy+bXNA5xbE=;
        b=6e+rxu21MuM0C1St9Q5FtiRLRS8DntFDSZqtuGI1qO69matfgByRwHyEd8kSieOOZT
         rgp8iIBA3tD+lyKVHr00yas5NGgDDZDJkKHZDXcwtk87mYpueA2e4LPOu3ajcqt7Gcfi
         A5RzGy7C9JluoLBs6lYDiZz+Z/9PToukW5PsTtjVuiCD2Oe/5PdUuc74k5vbCVt3axWH
         i43vEhItCQNllulZ2/nvBD4MxyyDYDScp9igZN5LRN0fAv1y9r/gIJ/Fu6Bk/TleTW8m
         2zFj2BRHJCsG+sUrjcEDESSk7JznNzXixbxYflhOqJfkOHfuKDeKUEIY8HSAk8M1ieZJ
         fIJA==
X-Gm-Message-State: ACgBeo36AEaJjiPSGfrI/mIkD/+eVy1CUTKeucmJOAADVb4jwSe8RacD
        Qj4D6kHdOrqQoT6SBp97gXo=
X-Google-Smtp-Source: AA6agR7cQrTvw/gSZQdLR46VStoL3nBL64dfZY9uQj7dx0rSXb/S/dW226Tf5G+7CHNsTp0e65cezQ==
X-Received: by 2002:a50:9f44:0:b0:445:dfca:87da with SMTP id b62-20020a509f44000000b00445dfca87damr3660384edf.105.1660860394145;
        Thu, 18 Aug 2022 15:06:34 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id dk5-20020a0564021d8500b00442d5054a51sm1851584edb.87.2022.08.18.15.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:06:33 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 4/9] dt-bindings: clock: qcom,a53pll: add IPQ8074 compatible
Date:   Fri, 19 Aug 2022 00:06:23 +0200
Message-Id: <20220818220628.339366-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818220628.339366-1-robimarko@gmail.com>
References: <20220818220628.339366-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IPQ8074 compatible to A53 PLL bindings.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,a53pll.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
index fbd758470b88..76830816982e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,ipq6018-a53pll
+      - qcom,ipq8074-a53pll
       - qcom,msm8916-a53pll
       - qcom,msm8939-a53pll
 
-- 
2.37.2


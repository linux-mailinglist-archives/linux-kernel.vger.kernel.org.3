Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9A157BE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiGTT2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiGTT2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:28:16 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A26F48E9B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:28:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id o7so31930674lfq.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rSBQ7JAB+vjeRoqorLkGeTA/zEJLIaKb2x2azJOWcTw=;
        b=gfI/K/TNFcBfDJGFoOa5ZIwPpi22P63+Yy4snJWbZUnIqcaTs7PWMYawLV0u42j1gg
         6SAizAsdZ07oIO5WR+BjaVwcExwiIyPNjA/hwprpMgM9mds+BkSC3tDsyy//VfgxVWnQ
         sXO/JP8fRjr9Eh1v4UDc4RIiIdUJqI1FUoVRQtnfhDBiS5kqDtmY7HRbAh65EfwAb6ms
         pOq49Bd9jeYpEaCPU2fgkEcN7wXwOE48eQ1j6Z8SGztZPB697BnDGbTGkxv8eyPYGEuc
         skdiQD5vFfEEDG4NeifksEDcp+3iopKyoYhWJT6MZ0ZNJHdEZtX2GBvyCLNWptIorrk2
         hzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSBQ7JAB+vjeRoqorLkGeTA/zEJLIaKb2x2azJOWcTw=;
        b=1bptv6+pzRcCf1rcbHIdk/ny0wtvVBAKNP/pG5wAds/EoxJpn/zbDnsKwNp4OLOJgO
         RtHtgdnb9CHI1BKgjgHkZqYYHg4wX1NN/G5YQJn8cnGtTsLTluDjFsv8reTgp8UGcUG6
         oMNa0PCRKw2BVL/finCxg25jUblkRkQzrzZIX+F+8e0VQ2VI/vs4edPYg/ugPAkWZzmZ
         MrKwq5uS+c/GTTZHOoL60vX27LbbdQjown3dveg+yxKWRElKffFz/swNOBEoPMjSb1ve
         Z3KpVHbYBnmkezPUFiZL78hnuyRn6q1N8h0vTb4rKxjUwX5cVrGTjBxbToIPPOdV10Ly
         4rfQ==
X-Gm-Message-State: AJIora9z/7w7HahW/Rb5Sp6llrJyG1qE2cRZ/sq3z1Y8DAgv2CVAtqPb
        EfR+3VfL0HYnetrLtImylefalQ==
X-Google-Smtp-Source: AGRyM1t5JUB4BiPdMRrJAR4SN7NgCflQcP4z/9qo1349hofBeiS3KfqTb2LYhIPLfW1uoOIY6y6T1w==
X-Received: by 2002:a05:6512:3c96:b0:489:e6c1:a5a7 with SMTP id h22-20020a0565123c9600b00489e6c1a5a7mr22357322lfv.38.1658345293788;
        Wed, 20 Jul 2022 12:28:13 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id h32-20020a0565123ca000b0047fac0f34absm3985771lfv.196.2022.07.20.12.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:28:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH 01/10] dt-bindings: interconnect: qcom,msm8998-bwmon: add support for SDM845 LLCC BWMON
Date:   Wed, 20 Jul 2022 21:27:58 +0200
Message-Id: <20220720192807.130098-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for SDM845 Bandwidth Monitor instance measuring traffic
between LLCC and memory.  It comes with different register layout:
called v5.

Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index c2e697f6e6cf..32e2892d736b 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -27,6 +27,7 @@ properties:
               - qcom,sdm845-bwmon
           - const: qcom,msm8998-bwmon
       - const: qcom,msm8998-bwmon       # BWMON v4
+      - const: qcom,sdm845-llcc-bwmon   # BWMON v5
 
   interconnects:
     maxItems: 1
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32C0596962
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbiHQGVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbiHQGVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:21:07 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2A36FA0D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:21:05 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f20so17773251lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Rog7VYeMn/H1upxCLx+q6vp1wAOAowOxeUWllio/J+g=;
        b=ohqj3a4wQTZovUqZLXp0xogsdNViPOwIVNpJWuEO+ZFnqPEjENqa8/y9Njr3Q//40U
         TNLlbTVOvUCNiQLwN2x/J1WIIKM8c/96PKMnq6zqFuJn2B44XdFT9zmFqCqHUreNQfOK
         McQNiprU/MPm74wZHTSbjB3t/1ywKvykUhHSGoJaO62amY2dNXItbRtIg8h7y/3YN4xS
         mUunFDU009YYzQH6r//SVQo/O7ksDseS+Ohlpyir5AxwLO3kV22tWB+LRfJ4k+oiXGyI
         qNw52OctYbcWor8BhTvaSezooXENy8Q/8VwNhULHMHAolZVmRSsnixriqIC3tlfBqOP3
         UgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Rog7VYeMn/H1upxCLx+q6vp1wAOAowOxeUWllio/J+g=;
        b=IwUdepBlovsEWx7vD+xK44NvBCK/yC8TSHtPrLNqnAidnO9ceSqBfx+Whor9xIyKKg
         5KUFbbr2+cdcKd9h7Yq16VJTEg4uSvd01hj/DtauC6uVaEHWJubsP6upLQ9gYqoIrD1t
         A9GBkJ9OFp/HWo9UqtYu82TCIUz+1RFR+C7YeWKVNDlj9aCCONpwAWraI3cNLmJaco6z
         SKSzxrPE29FqRISzwntQUx2WGf2WbLY6NUCeM2U1Zul17W9A29p0f62UqIAhNg6IVHYm
         1pcrfY0Sm3Xa+jUwQjPUTKg88jAypQYvDSwGwhLSvByAdpHZWAuzZqsQfeVnj9nO/dtU
         W/4A==
X-Gm-Message-State: ACgBeo2Eg/+bgknfXX9QXjZiDkg3tPjcO9RNKjS4YqR7knYy3pj6BNNS
        KsVo/jsYgqK3ePHIKLWq4W/KHQ==
X-Google-Smtp-Source: AA6agR6BAB8xPf0LrOTlk1zGcSN5EKe1DwN3DW738X4J95hxDOhdrCqha1LTmLKF7/67PQFthUeckA==
X-Received: by 2002:a05:6512:13a4:b0:477:a28a:2280 with SMTP id p36-20020a05651213a400b00477a28a2280mr7695629lfa.689.1660717264108;
        Tue, 16 Aug 2022 23:21:04 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id u27-20020ac258db000000b0048b0062a14fsm1581002lfo.144.2022.08.16.23.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 23:21:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/5] dt-bindings: display/msm: dpu-msm8998: add missing DPU opp-table
Date:   Wed, 17 Aug 2022 09:20:55 +0300
Message-Id: <20220817062059.18640-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817062059.18640-1-krzysztof.kozlowski@linaro.org>
References: <20220817062059.18640-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'display-controller' child (DPU) of Display SubSystem (MDSS) uses
opp-table, so reference it which allows restricting DPU schema to fixed
list of properties.

Fixes: 6e986a8f1cf1 ("dt-bindings: display: msm: Add binding for msm8998 dpu")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 .../devicetree/bindings/display/msm/dpu-msm8998.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml b/Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml
index 2df64afb76e6..253665c693e6 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml
@@ -62,6 +62,7 @@ patternProperties:
   "^display-controller@[0-9a-f]+$":
     type: object
     description: Node containing the properties of DPU.
+    additionalProperties: false
 
     properties:
       compatible:
@@ -105,6 +106,9 @@ patternProperties:
         maxItems: 1
 
       operating-points-v2: true
+      opp-table:
+        type: object
+
       ports:
         $ref: /schemas/graph.yaml#/properties/ports
         description: |
-- 
2.34.1


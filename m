Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F2858F95F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbiHKIoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbiHKIn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:43:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C3890C70
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:43:44 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x19so16360739lfq.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ooM7y6v9J6zgXgg6OqlmVWX6M0IPHPI6lI2ab0c9pDA=;
        b=d4tvCxgrvq0CXKar5cnmPvhPR5M9QrNQCbiuAr0vViRXBOQvDWi5Hgfk45hiB7Sh3+
         YDNN5v4Qw/iogPERl3ywwvSQaR/jBFtNNKUujqIGW/q7jBrvLhSYK1xa83prb9SC5khx
         UQNcQWM5cAXyS3nX93hC2PSqhNma4LrF9szVkjQKzYwGvM3OrBaJIDrWTzV9LpghS3E6
         b1B9M7lyGXZBd5sljALlvj0Pq+XgKZMqqkHpUQ0gQMbcLmYKyovpg5fc7knns2nOTnoq
         d4IDsNbw7M8rOnGMSOHtHh+ozfYAoKLcZ3L3zRaAPNh2JKb8g5cYsgIxkP+S29uyZId8
         OmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ooM7y6v9J6zgXgg6OqlmVWX6M0IPHPI6lI2ab0c9pDA=;
        b=VVlYbFjk/2uVV8MDm+Jr33k7ekjAwPY+/NR3qHqn2mRt7CfSme1ymgm5FZLelEbDZd
         edjcpLS3dgyD7bBy/f0mFgctSRhP7B8ViCafqBwspDpEgfSA+Epe27n2uMCfQVH2HbJA
         lKGg19vVNL9QcAwULMFYVFTx/O+6iBiePb3P6VqiNTsK1tebFUB/KgRb6o9TuSH9Aips
         WiH98SQc5Llk/WWcIcD989YUrpRVtD5o+9ovhftgKETPtLRnpTd7lsxrcLeJGCPJL+jW
         iglngYLKVmL/6DKyvbnjR7UMko9ouAzoZ1UvX5TirQYyjBMeJQTuOXZkqSsaj1GqW4Tp
         nWEA==
X-Gm-Message-State: ACgBeo2nKNaiJvoSgIpqvyMpcH9jz9gAynSLPOHoFo+pJSOTzn3FDbYx
        dt7km4r3lulXoPvLOS24VzkKfQ==
X-Google-Smtp-Source: AA6agR5mO3DiFZ3t4Lgk1NnmeQ8cSRVtzF9qwzrrk5oLi5kRvefXVkYodaLJf5t1o/M2ohExFwDVIA==
X-Received: by 2002:a05:6512:108f:b0:48b:a169:d291 with SMTP id j15-20020a056512108f00b0048ba169d291mr8339394lfg.198.1660207422686;
        Thu, 11 Aug 2022 01:43:42 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id f4-20020a056512360400b0048af379957asm631077lfs.72.2022.08.11.01.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 01:43:42 -0700 (PDT)
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
Subject: [PATCH 5/5] dt-bindings: display/msm: dpu-sdm845: add missing DPU opp-table
Date:   Thu, 11 Aug 2022 11:43:31 +0300
Message-Id: <20220811084331.83715-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220811084331.83715-1-krzysztof.kozlowski@linaro.org>
References: <20220811084331.83715-1-krzysztof.kozlowski@linaro.org>
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

The 'display-controller' child (DPU) of Display SubSystem (MDSS) uses
opp-table, so reference it which allows restricting DPU schema to fixed
list of properties.

Fixes: 3d7a0dd8f39b ("dt-bindings: msm: disp: add yaml schemas for DPU bindings")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml b/Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml
index 2bb8896beffc..aa99201dae3f 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml
@@ -65,6 +65,7 @@ patternProperties:
   "^display-controller@[0-9a-f]+$":
     type: object
     description: Node containing the properties of DPU.
+    additionalProperties: false
 
     properties:
       compatible:
@@ -102,6 +103,8 @@ patternProperties:
         maxItems: 1
 
       operating-points-v2: true
+      opp-table: true
+
       ports:
         $ref: /schemas/graph.yaml#/properties/ports
         description: |
-- 
2.34.1


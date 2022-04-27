Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B65511162
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358201AbiD0GoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358232AbiD0GoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:44:02 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA8F2F017
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:40:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a1so798118edt.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/IgkY60sLZ5va6K7CFzGZoYOec4od+02bA7F+n5qTsg=;
        b=HbXKwAVYF7rE9LN5gGQcU1gzecSP6eaxw/GOSK6GzXl5DOstDY2RrYO+4JQkXlgmvJ
         /Lx11lrXNurltKRp9y56w2xiQ1STr1JKeMIbNdlfkwnp9EMJuDSdUnA7Jx7SbFQr79hB
         35++QFaSynFZpasyp6oUyVSudT70V7IP6Pelt/QTaiTs1QG0E1OGAVdm4H9xLiUdqLOi
         4rfZQ4CVCoRwO7HPjpwnlRAh0x2njl/3YpEa+DGYy+kTMOKXmMtPA27yGdUCfLAmGvKF
         uQiZ2CS8cu9mEAX51mYspUxsykXTA71G+2NlNtw/h65djoc1sRYreTX2CvvENsndBWY7
         GuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/IgkY60sLZ5va6K7CFzGZoYOec4od+02bA7F+n5qTsg=;
        b=ltkkeVkHJa1MTv7maJ134XTe/9FgxE535vuKhmBAaT7KO2DTO4Mc1E5hxNO7EPGzoY
         UqLwQvNPJZRkhIjX7j3nZ2RU00KC03MlUzB/W8d8+ak8JmSwsHUGTPi/eSHY8DcZe2Me
         WqUUtRWr/Q2osh6XK/nX35y2QLtwMB/ok+N67/6kouihK6Uj2kN5VH/ZWjEFPe6npDST
         c39QLT3u1XkhGYzfS2zr1Nma2TI40DjnfVH0JMzIBm0//CoZv8HJ9IyrbXp62P5PVs7w
         5M1NY5eEPDWReBQy1Sd2pvHKGWHxO+WJdevcElIvmMV1hH3UJ6cl/2RUP1an0H9oRdW8
         heQw==
X-Gm-Message-State: AOAM530UWVHa4U1v9aubrrEi8qDL1Kekaaw3VsLlHYk0QDStWLY61pVU
        HBiEsyjsv9Ie1i+xMXSQUHeVkw==
X-Google-Smtp-Source: ABdhPJx1PvFzUSqLyTieYHsix8g4TVYP2ugzMBddEcwAX02fqPtKHCJCZWty5RZQLszFVuwD6xF+5Q==
X-Received: by 2002:aa7:d407:0:b0:425:f57e:7ae5 with SMTP id z7-20020aa7d407000000b00425f57e7ae5mr10801445edq.393.1651041651406;
        Tue, 26 Apr 2022 23:40:51 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u19-20020a17090617d300b006cea86ca384sm6122527eje.40.2022.04.26.23.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 23:40:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: dma: pl330: Add power-domains
Date:   Wed, 27 Apr 2022 08:40:48 +0200
Message-Id: <20220427064048.86635-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pl330 DMA controller on Exynos SoC (e.g. dma-controller@3880000 in
Exynos5420) belongs to power domain, so allow such property.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/dma/arm,pl330.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/arm,pl330.yaml b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
index decab185cf4d..2bec69b308f8 100644
--- a/Documentation/devicetree/bindings/dma/arm,pl330.yaml
+++ b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
@@ -55,6 +55,9 @@ properties:
 
   dma-coherent: true
 
+  power-domains:
+    maxItems: 1
+
   resets:
     minItems: 1
     maxItems: 2
-- 
2.32.0


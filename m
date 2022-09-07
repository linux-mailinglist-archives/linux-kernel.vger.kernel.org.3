Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3AE5B01B8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiIGKSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiIGKRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:17:15 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFCF399DF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:16:24 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id by6so15353838ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IE9iYaf4ljXjTzH90yeiguLHiQ95amY6yCG9ecN7egM=;
        b=ChWRI8qDis+YWkKe0I+qyMCm0aW5WKr/0HGHzuKwD32pRYC5t8LRindSrtP0Cd3ajj
         eIUcTl+TvJd5BR0FR4oHNqM3YPOjV3cNUPt7ubturR3ZceiLSDdufIbavuNYSkhW3APo
         /e+tKcLEObXGRRip17WUYl0nffilkBw2qRH1INCiaoNdj94+ndnw2N02CcylccwJenFk
         EhlX2HfbZKPsrxTRhp+Ep3xcDMioWlBBw5VcV6L2As+NavAZY3izxUb6Gw0IYyYqZWvg
         MrUWAfbWXv74yLWFbkPNguDu0y6bbrdc35P2HV2NOG2gBGtQIDnfmG3y5hvcqi4RtxPJ
         W0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IE9iYaf4ljXjTzH90yeiguLHiQ95amY6yCG9ecN7egM=;
        b=mdJrIh7V8vO9AnXgJFvGxc0kFBM9J/8wOfNmyG+PFeGtnVGAH2sKmQZ0SAAPtsR1yK
         Lva4B9up7WCP4Y4ivY2aqyBYjtxAQaFb2TbbLie4W9vRa0N0GaM0EMS4Z5E72Z4A9bUE
         nSIodHZAoahCmTjp7biFsThvHKTOhF993K9GfH1YBmW8JDdOgkCtjYj5c4BrmCemZ6PF
         /LKIDH/V9rSSewFZxbbsaX0Ez2R4J3doq/TTnOKgdiVFwcCRpFJ5KLydTWbQ4CuvUeSr
         6tsbS2EBM+nzypSjZGDlL9A3h25PEs+bqHmT2K8Inkz0Zx1nQ/0JUrD/pgP5rGVo+das
         ll8Q==
X-Gm-Message-State: ACgBeo0SorUyHvVoOujLn2svKUOTCqx5KZtKdmDyB5jGdFLjRcvyHJkY
        aZie1Db1gWLnRWLpJsDx1knjAw==
X-Google-Smtp-Source: AA6agR4qNoMuCGTXy/UbzjBcRROS+BhHEWrT0sR/EQ2fEGnRWEpeJSviNxaq4edkYpNdKXZZvg87oQ==
X-Received: by 2002:a2e:b003:0:b0:26a:d07d:c501 with SMTP id y3-20020a2eb003000000b0026ad07dc501mr204338ljk.388.1662545782589;
        Wed, 07 Sep 2022 03:16:22 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u9-20020a2ea169000000b0026ab0e480bcsm960734ljl.39.2022.09.07.03.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 03:16:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 13/14] ASoC: dt-bindings: qcom,q6apm-dai: adjust indentation in example
Date:   Wed,  7 Sep 2022 12:15:55 +0200
Message-Id: <20220907101556.37394-14-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907101556.37394-1-krzysztof.kozlowski@linaro.org>
References: <20220907101556.37394-1-krzysztof.kozlowski@linaro.org>
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

Cleanup the example DTS by fixing indentation to 4-spaces and adding
blank lines for readability.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. New patch
---
 .../devicetree/bindings/sound/qcom,q6apm-dai.yaml   | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
index 844d72b30969..24f7bf2bfd95 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
@@ -33,13 +33,14 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+
         service@1 {
-          compatible = "qcom,q6apm";
-          reg = <1>;
+            compatible = "qcom,q6apm";
+            reg = <1>;
 
-          dais {
-            compatible = "qcom,q6apm-dais";
-            iommus = <&apps_smmu 0x1801 0x0>;
-          };
+            dais {
+                compatible = "qcom,q6apm-dais";
+                iommus = <&apps_smmu 0x1801 0x0>;
+            };
         };
     };
-- 
2.34.1


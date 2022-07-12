Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEE6571FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiGLPq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbiGLPqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:46:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A74C5494
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:46:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t25so14623770lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5pYk2bgENoJKmAgJjP5u55IOFZv0T0dQhNKXZeD8lc=;
        b=M0hAkO/ALSrNhqkwUr/tsVDZsxYCiyAIDDaijWDF/AlvXiL+HHnJ5t0UlDpdX+DVui
         fpE/bgj461v35xJXE/X/OGyNTzRHO0A5Xzp4NxbpNF7ToaLTQm5rzo17JjVyc1cC5RQc
         1LqplN58movOWgeQdwxI5PqkvhLU3nr5qKvb5IKR8xjaUWl5nWVWiPis6Zjrjx/LiiQY
         pQa5/An7MivsJ2Fzw5QhqcEZQrylU3HRJRoFk/plVSQX+Gj3z4mM+CwO9yruN/l8Qdm9
         NAhyI1rJCJf+8dxsnOOEnFrBZE2lwR81m+hfLiDeF/9tFwHZ9L7xmWE65jtXW5YtEML8
         ADLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5pYk2bgENoJKmAgJjP5u55IOFZv0T0dQhNKXZeD8lc=;
        b=cjLOa2fViRcXn0ztfRuTsWp1+eNLzBCUn0Y72XJua49GLPQ5ifK668CTY4aYtcRDPC
         drAuj3fspbP+ODhCxvXwGAGeWaW0g1ibGtxV/V3MlDP3tlWImwFEmGxcNMY93mm3NsPz
         0iOvQbd9ZiiKmXSUVE5KC5Sg1ZDAUF45+kTKaWg2LCGJIl3uvsD+7KQzQPlDWKuecJmU
         Eoc7bz/DINt8tKJlc/sslNaHa9T4201yn8c4omRPvaFznZf74rNBOzD+pkz9RUdiDXtb
         CVe3nUqGKOScva5rbKf4g7K7FSoYd1iHUGszu9u4w5gdv/SySnlcmvcduVXTxeC1HMxS
         qJOA==
X-Gm-Message-State: AJIora+OWVdde5b45ztVhPnsS4RicaC+kuSE68jSFebXbawL83m4BK+G
        tgBsIdhtx79HAxnVsjn2RDSh8Q==
X-Google-Smtp-Source: AGRyM1vv1jizlfHJgxqT0dOxee25WGxKd5vBg/s8PWXRo0/Bt2J1h5OGxf2AyNpVQfJjMnogy+hAdw==
X-Received: by 2002:a05:6512:2290:b0:489:d433:605d with SMTP id f16-20020a056512229000b00489d433605dmr8806532lfu.629.1657640780501;
        Tue, 12 Jul 2022 08:46:20 -0700 (PDT)
Received: from krzk-bin.. (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id q5-20020a056512210500b00489ed49d243sm582396lfr.260.2022.07.12.08.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:46:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Srba <Michael.Srba@seznam.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: bus: qcom,ssc-block-bus: rework arrays and drop redundant minItems
Date:   Tue, 12 Jul 2022 17:46:02 +0200
Message-Id: <20220712154602.26994-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

There is no need to specify "minItems" if it equals to "maxItems".  On the
other hand number of items in an array can be specified via describing
items, which might bring some additional information.  This simplifies a
bit the binding.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/bus/qcom,ssc-block-bus.yaml      | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/qcom,ssc-block-bus.yaml b/Documentation/devicetree/bindings/bus/qcom,ssc-block-bus.yaml
index 5b9705079015..8e9e6ff35d7d 100644
--- a/Documentation/devicetree/bindings/bus/qcom,ssc-block-bus.yaml
+++ b/Documentation/devicetree/bindings/bus/qcom,ssc-block-bus.yaml
@@ -28,11 +28,9 @@ properties:
       - const: qcom,ssc-block-bus
 
   reg:
-    description: |
-      Shall contain the addresses of the SSCAON_CONFIG0 and SSCAON_CONFIG1
-      registers
-    minItems: 2
-    maxItems: 2
+    items:
+      - description: SSCAON_CONFIG0 registers
+      - description: SSCAON_CONFIG1 registers
 
   reg-names:
     items:
@@ -48,7 +46,6 @@ properties:
   ranges: true
 
   clocks:
-    minItems: 6
     maxItems: 6
 
   clock-names:
@@ -61,9 +58,9 @@ properties:
       - const: ssc_ahbs
 
   power-domains:
-    description: Power domain phandles for the ssc_cx and ssc_mx power domains
-    minItems: 2
-    maxItems: 2
+    items:
+      - description: CX power domain
+      - description: MX power domain
 
   power-domain-names:
     items:
@@ -71,11 +68,11 @@ properties:
       - const: ssc_mx
 
   resets:
-    description: |
-      Reset phandles for the ssc_reset and ssc_bcr resets (note: ssc_bcr is the
-      branch control register associated with the ssc_xo and ssc_ahbs clocks)
-    minItems: 2
-    maxItems: 2
+    items:
+      - description: Main reset
+      - description:
+          SSC Branch Control Register reset (associated with the ssc_xo and
+          ssc_ahbs clocks)
 
   reset-names:
     items:
-- 
2.34.1


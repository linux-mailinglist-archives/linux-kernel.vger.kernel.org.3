Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828E250F15F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbiDZGqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245749AbiDZGp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:45:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB0012C406
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:42:46 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gh6so9959969ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEOSnXjfcH/l5Es8VtB/ak1K3hreA1C3eDBJ8dHARyo=;
        b=bASAClY6Ytda/4xUhup8MUSUMsRpRAR50cqsJ0XAhppisIw/yr3Xf8wWEbZ5+xFHAI
         TOHWNUaLKHbhBnYaZ2Q9x9tGRWB0zFVJFafT2ODZVUTXhAMONRvUCRUf2QdJ7NOT3Xdi
         GtfHjgDwHJKBPP6tvv+uw318ezvkJt13nlj2HrLqud15LIUkl+IzyVCZ7DJ0QlV2CrcQ
         G9fFDlVrRM3nHlVe/lfOa6Oq+iQuNKfkFOs6uC/DXvxAtb6pVhPTws9BjtCfeQW/AXxm
         /t2ybFAayhGpTecMphERvHj25Qx0POiUlJLQe2OOQUCoeXGzWX9AFfPMTBWMvmKmPCaX
         u4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEOSnXjfcH/l5Es8VtB/ak1K3hreA1C3eDBJ8dHARyo=;
        b=qsI9m6TYigP/I238dl189f0hGOIzL4AHUoxu258KL7hOgt0YhlWWCPRgRn6IujbYTc
         U+kJ58YEvAr8TbPNHEXzI/uuznnQb1Ou4bxemQCqgiLSQEeWUpchyOZlPUN8vpbJ0ami
         AO1Mzt2/gnYR0cr/7BEv+V5qidq89myv50sQEa0eDgsNVl/8gDM5uz7k87JPhC0iayz+
         NW2OEWauayRGKMjjD18aafUgtPs2HGzO41bb5ulDzo+ChFxtNfiHaLkbWyf6na6nqFw0
         JYAjlVB3fNDWenOAns2Ut6CU6WARviw7twg/jelWU6HPAco1DIYWhp5Leu2rJktoh8l8
         IxjA==
X-Gm-Message-State: AOAM5332yeUnnpPBw/lipd2j1U239hYrGYOEtMtcY4/E20cES7xi66km
        Rgnt+VIBCl5KS8eViiGpvTNboA==
X-Google-Smtp-Source: ABdhPJyQuE+1pRBGE66dl8vawhJjRk0oRMEc2gZhd7SNDASBfF96iGQsJRh6XDctSdl8wKwtt+jiWw==
X-Received: by 2002:a17:906:1315:b0:6ef:5903:c5d1 with SMTP id w21-20020a170906131500b006ef5903c5d1mr19635606ejb.537.1650955365291;
        Mon, 25 Apr 2022 23:42:45 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id fx3-20020a170906b74300b006daecedee44sm4386885ejb.220.2022.04.25.23.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 23:42:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] dt-bindings: clock: qcom,gcc-apq8064: Fix typo in compatible and split apq8084
Date:   Tue, 26 Apr 2022 08:42:41 +0200
Message-Id: <20220426064241.6379-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

The qcom,gcc-apq8064.yaml was meant to describe only APQ8064 and APQ8084
should have slightly different bindings (without Qualcomm thermal sensor
device).  Add new bindings for APQ8084.

Fixes: a469bf89a009 ("dt-bindings: clock: simplify qcom,gcc-apq8064 Documentation")
Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Correct Taniya's email.
2. Correct chipset name in description.
3. Extend commit msg.
---
 .../bindings/clock/qcom,gcc-apq8064.yaml      |  4 +-
 ...gcc-apq8064.yaml => qcom,gcc-apq8084.yaml} | 57 +++++--------------
 2 files changed, 16 insertions(+), 45 deletions(-)
 copy Documentation/devicetree/bindings/clock/{qcom,gcc-apq8064.yaml => qcom,gcc-apq8084.yaml} (31%)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
index 97936411b6b4..9fafcb080069 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
@@ -20,12 +20,10 @@ description: |
   See also:
   - dt-bindings/clock/qcom,gcc-msm8960.h
   - dt-bindings/reset/qcom,gcc-msm8960.h
-  - dt-bindings/clock/qcom,gcc-apq8084.h
-  - dt-bindings/reset/qcom,gcc-apq8084.h
 
 properties:
   compatible:
-    const: qcom,gcc-apq8084
+    const: qcom,gcc-apq8064
 
   nvmem-cells:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml
similarity index 31%
copy from Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
copy to Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml
index 97936411b6b4..397fb918e032 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml
@@ -1,69 +1,42 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/clock/qcom,gcc-apq8064.yaml#
+$id: http://devicetree.org/schemas/clock/qcom,gcc-apq8084.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Global Clock & Reset Controller Binding for APQ8064
-
-allOf:
-  - $ref: qcom,gcc.yaml#
+title: Qualcomm Global Clock & Reset Controller Binding for APQ8084
 
 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>
 
 description: |
   Qualcomm global clock control module which supports the clocks, resets and
-  power domains on APQ8064.
+  power domains on APQ8084.
 
-  See also:
-  - dt-bindings/clock/qcom,gcc-msm8960.h
-  - dt-bindings/reset/qcom,gcc-msm8960.h
+  See also::
   - dt-bindings/clock/qcom,gcc-apq8084.h
   - dt-bindings/reset/qcom,gcc-apq8084.h
 
+allOf:
+  - $ref: qcom,gcc.yaml#
+
 properties:
   compatible:
     const: qcom,gcc-apq8084
 
-  nvmem-cells:
-    minItems: 1
-    maxItems: 2
-    description:
-      Qualcomm TSENS (thermal sensor device) on some devices can
-      be part of GCC and hence the TSENS properties can also be part
-      of the GCC/clock-controller node.
-      For more details on the TSENS properties please refer
-      Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
-
-  nvmem-cell-names:
-    minItems: 1
-    items:
-      - const: calib
-      - const: calib_backup
-
-  '#thermal-sensor-cells':
-    const: 1
-
 required:
   - compatible
-  - nvmem-cells
-  - nvmem-cell-names
-  - '#thermal-sensor-cells'
 
 unevaluatedProperties: false
 
 examples:
   - |
-    clock-controller@900000 {
-      compatible = "qcom,gcc-apq8064";
-      reg = <0x00900000 0x4000>;
-      nvmem-cells = <&tsens_calib>, <&tsens_backup>;
-      nvmem-cell-names = "calib", "calib_backup";
-      #clock-cells = <1>;
-      #reset-cells = <1>;
-      #power-domain-cells = <1>;
-      #thermal-sensor-cells = <1>;
+    clock-controller@fc400000 {
+        compatible = "qcom,gcc-apq8084";
+        reg = <0xfc400000 0x4000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+        #power-domain-cells = <1>;
     };
 ...
-- 
2.32.0


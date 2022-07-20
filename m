Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D5D57B1D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbiGTHdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiGTHde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:33:34 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20E8675A5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:33:33 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u14so12133487lju.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFHqm8LK5q9e9AM50wknJiUgH9ZSVdccKeaSxOT6p7U=;
        b=MC+i+3maH27etmdXK5VZeEK9Jt3HYbRxwe7KhGdIx5Pw3prLoIu50ECVMDRqYHREI5
         KS1s5OSOvfxOMEa7h4WhAwwKGH+XT+nUonGxwNnepyMhGoqZy5TGz9XeMbx5jSOUOR8c
         O5MXtld9Ch1CfFsUSlK26q5DXWOBX113P49vxMzvNRBktwBnR1Uyn0T7D+PpHYs1ekoV
         iMm+EQJhF+ggpISnc8D+l2CG/vEUX3MX2e/Xv0vJEG+G5Bqih/au6u9C+w17QyQ+TN9Z
         /eLE+S0z5GS56iiEbrP53P9wHghMEMa84m+DGgOd6lrtNzW4px+UJEnZff9de2esXAWf
         rrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFHqm8LK5q9e9AM50wknJiUgH9ZSVdccKeaSxOT6p7U=;
        b=LmN/3vn5PrRXggUVZlu8fAKfIvYON0Oz2tQF9/oz5MNb/535NkfBi+APU1U+9r/Ibl
         nbdmSv3DT8QE/2qxsXPl3afeHx8KvdFBgaJuj0do67xloSrimci7AnfE1l1IKsW4cuNZ
         F3D+cMWiHmHPAydEdWzGOwc2X0vZSjQ/vlMqc8LAfWophIP6M3ntb/8U8PsOGTTlPbqk
         s4quCUfSya4dwPlUZPy7i6IJj1t/bWfmCMqmMS62tzwgrYGmoiK5oPpqeqTjFpqrYc+7
         9/bp3BG3IHa6CAZ+17u0ZY3/Z/nC9tLDTdisdbz6ergexw1bWk343keSdV6HLzSfJ0xK
         X7Bg==
X-Gm-Message-State: AJIora9x6IOgS1qaaedNrC8e0FQGDTV4ZiwlN30lidJNFVpzKoHusxm3
        +tqWG2Wnf9vuZCHrvMOUbem3JeUikBJ5g7cg
X-Google-Smtp-Source: AGRyM1tMAPO2SAQlLw6viF5ZFG3cCvo2nU2eOp7XalUwZV40NplyUAGZ/xfqZuH5O0/V3pDrqmZwxA==
X-Received: by 2002:a2e:bf27:0:b0:25d:b90b:c487 with SMTP id c39-20020a2ebf27000000b0025db90bc487mr6696076ljr.372.1658302412016;
        Wed, 20 Jul 2022 00:33:32 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id m2-20020a056512114200b0047f7a390b30sm3627287lfg.76.2022.07.20.00.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 00:33:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Subject: [PATCH v5] dt-bindings: qcom: document preferred compatible naming
Date:   Wed, 20 Jul 2022 09:33:26 +0200
Message-Id: <20220720073326.19591-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Compatibles can come in two formats.  Either "vendor,ip-soc" or
"vendor,soc-ip".  Qualcomm bindings were mixing both of usages, so add a
DT schema file documenting preferred policy and enforcing it for all new
compatibles, except few existing patterns.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Depends on:
https://lore.kernel.org/all/20220627143340.477120-1-krzysztof.kozlowski@linaro.org/
https://lore.kernel.org/all/20220628092253.21905-1-krzysztof.kozlowski@linaro.org/

Changes since v4:
1. Add qcm.
2. Add more qcom,ipq806x exceptions.
3. Add Rob's tag.

Changes since v3:
1. Add qcom,kpss-wdt-xxx to pattern for exceptions.
2. Add ipq806x entries to list of exceptions.

Changes since v2:
1. Narrow the expected pattern to be followed by dash '-' after model
   number (msm8996-) or by two letters and a dash (sc8280xp-).
2. Add qcom,apss-wdt-xxx to list of exceptions.
3. Use comment instead of description in the oneOf list.

Changes since v1:
1. Add schema instead of readme (Rob).

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Alex Elder <elder@linaro.org>
Cc: Robert Foss <robert.foss@linaro.org>
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/arm/qcom-soc.yaml     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom-soc.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
new file mode 100644
index 000000000000..9918b20e4478
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/qcom-soc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SoC compatibles naming convention
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: |
+  Guidelines for new compatibles for SoC blocks/components.
+  When adding new compatibles in new bindings, use the format::
+    qcom,SoC-IP
+
+  For example::
+   qcom,sdm845-llcc-bwmon
+
+  When adding new compatibles to existing bindings, use the format in the
+  existing binding, even if it contradicts the above.
+
+select:
+  properties:
+    compatible:
+      pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      # Preferred naming style for compatibles of SoC components:
+      - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+-.*$"
+      - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
+
+      # Legacy namings - variations of existing patterns/compatibles are OK,
+      # but do not add completely new entries to these:
+      - pattern: "^qcom,[ak]pss-wdt-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - pattern: "^qcom,gcc-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - pattern: "^qcom,mmcc-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - pattern: "^qcom,pcie-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - pattern: "^qcom,rpm-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - pattern: "^qcom,scm-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - enum:
+          - qcom,gpucc-sdm630
+          - qcom,gpucc-sdm660
+          - qcom,lcc-apq8064
+          - qcom,lcc-ipq8064
+          - qcom,lcc-mdm9615
+          - qcom,lcc-msm8960
+          - qcom,lpass-cpu-apq8016
+          - qcom,usb-ss-ipq4019-phy
+          - qcom,usb-hs-ipq4019-phy
+          - qcom,vqmmc-ipq4019-regulator
+
+      # Legacy compatibles with wild-cards - list cannot grow with new bindings:
+      - enum:
+          - qcom,ipq806x-gmac
+          - qcom,ipq806x-nand
+          - qcom,ipq806x-sata-phy
+          - qcom,ipq806x-usb-phy-ss
+          - qcom,ipq806x-usb-phy-hs
+
+additionalProperties: true
-- 
2.34.1


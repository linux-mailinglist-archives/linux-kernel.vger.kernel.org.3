Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B1C5673F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiGEQNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiGEQNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:13:07 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584AC1A3A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 09:13:06 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t24so21410714lfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 09:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o+RavR69O/i0XybehkxEWzRL/gE89Dkn/aDhrJuOgt0=;
        b=oHpGDtseU7FweA4q+RPWEiAYAyp+RdGvnWI7Mj4gQhNX0kRXKfN1SA0ZpupDIV29i+
         LQJaGBw0iRFgDdnk9BDoFOLAhU8BWQcS+LrogwVrBYWmbGNdkrYQr+9c1XNgIUEmEzjY
         DTN1Exi11d93P/pbkfQYzlOtsOgTZQZm2icJcN3QS6T34bkB6B8YiIBZ8xSDgv+psWNx
         6X31WVHizXD7/ZBlqINNwCgMKxowvgElI1APkaSYuvgG90R8M+excM8VcEdRLm2+Vf7h
         7O1cD9NIjKWwl2hYs0yWt/uBJN2Zt5et/3J/376gdzPmPIISKGtYeLhmVGl1xywmAr6Z
         5i/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o+RavR69O/i0XybehkxEWzRL/gE89Dkn/aDhrJuOgt0=;
        b=YG0CZXuYIqZvONPqGEiIbKnHz32gIaV5jcu6UU2esl9iCkm/h4v1LvcGtXQqFsS7AV
         VdwM8iCqzVQUF8cLA8JUhCVMCDADsJxY+cp/cZAvOrnBwW7FjBmjPMou8krtK+T3Fzxl
         /OXGiX+XxUDizOIXjKTobNVUiR33YxNU4SUQsmGIdWoC7mwYADyQjxAD47TJN+xXlG8s
         fpP98t843zW7lS4zWbsGc8Of39vsp85/gum4f2frVIPfP3/6vv3uiWqKmub6r+NRXRWl
         RwlGss1ZalbSHve5vAN1avaStWW7qeX/GtF9TW+8Zpz1MsIydDb9mwHexJeaWAXG3H17
         4BkQ==
X-Gm-Message-State: AJIora/rbF5Go6N2jqLRTSPxfHyX7zT8DCs2yojE6ll1/ZyICI1S+QBF
        HjEQCMB2UO7hgcZ18QgUvGT04Q==
X-Google-Smtp-Source: AGRyM1u3+EonOLsdNofjXqDUPya18vAH0Z8I0g7+adh3kl8lDdcZ0zdGDCZIkUQjhiOPKOKX4xV3VQ==
X-Received: by 2002:a05:6512:2623:b0:47d:ace7:c804 with SMTP id bt35-20020a056512262300b0047dace7c804mr23706499lfb.647.1657037584653;
        Tue, 05 Jul 2022 09:13:04 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id e20-20020a2ea554000000b00258eac98baasm5582698ljn.77.2022.07.05.09.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 09:13:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Subject: [PATCH v4] dt-bindings: qcom: document preferred compatible naming
Date:   Tue,  5 Jul 2022 18:13:01 +0200
Message-Id: <20220705161301.493364-1-krzysztof.kozlowski@linaro.org>
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

Compatibles can come in two formats.  Either "vendor,ip-soc" or
"vendor,soc-ip".  Qualcomm bindings were mixing both of usages, so add a
DT schema file documenting preferred policy and enforcing it for all new
compatibles, except few existing patterns.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

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
 .../devicetree/bindings/arm/qcom-soc.yaml     | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom-soc.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
new file mode 100644
index 000000000000..0be18c1d2961
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
@@ -0,0 +1,63 @@
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
+      pattern: "^qcom,.*(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      # Preferred naming style for compatibles of SoC components:
+      - pattern: "^qcom,(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+-.*$"
+      - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
+
+      # Legacy namings - variations of existing patterns/compatibles are OK,
+      # but do not add completely new entries to these:
+      - pattern: "^qcom,[ak]pss-wdt-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - pattern: "^qcom,gcc-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - pattern: "^qcom,mmcc-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - pattern: "^qcom,pcie-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - pattern: "^qcom,rpm-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - pattern: "^qcom,scm-(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
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
+          - qcom,ipq806x-nand
+          - qcom,ipq806x-usb-phy-ss
+          - qcom,ipq806x-usb-phy-hs
+
+additionalProperties: true
-- 
2.34.1


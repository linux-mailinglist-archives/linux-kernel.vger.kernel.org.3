Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1374BADBF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiBQX52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:57:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiBQX5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:57:21 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39374199F;
        Thu, 17 Feb 2022 15:57:05 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i14so11635737wrc.10;
        Thu, 17 Feb 2022 15:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GhfqE66RcE6mULFm/BNS10WyDFrpBaBNl2/KWoO7yS0=;
        b=WGR23Y5NZcNK4e+nErbVqEIfDf9apuClOqHY9rKI9mj0fvjvfo1egzxrENb+1++RMb
         MUoF4qoUKaUhfZU52LbXbVCzA1YenQoJA5eb4H8pQv1NDH4nwkNNtoqJmY9wTkvPzmDH
         /l9r31x4hJiMsvXnXiwsbVD7+jq6B8YXEVeZ6gwf4mk8132QWr2WCqhEBi/1/15obr9e
         +Az5v8f1VNCcIyEt56MSx2nCjXz2zhBi9iwfMX1k2vXjSb8YYkn27xHSY85iFdTMFWiZ
         bhmJMHsncy9F/QProtLyqtHq/T3B+TNeH4RrQvFwcf+zHYjI5+Bqwc3p7e2vwHP6FIOL
         bcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GhfqE66RcE6mULFm/BNS10WyDFrpBaBNl2/KWoO7yS0=;
        b=fbTzbZBUQ/qTtgh9Toen4/s+HMJzhR86c5mz6qi5+JUneL5KrUc+kqXqMG+Dr2j8sp
         sIpOvODxVRANVxq+e/2sKaUlQsvrGryS817BWgtbkidfVQEYbEkU3b6j6piWXpGOnpVj
         GdTH+/MHH9OSkvkaVrSVLtEdj6bYzYE0L68mHIeBZVMGXuTueuYypYr1/5aV1u/DO6RN
         +6YQMJ2+xfc+eKiQ9jQtyfDLVDuDAS9JpMRPY7Pwtuj7qI27udF551hxY7G0BRdrf7ME
         uYOhm2C8BXXgjD61qlTqfNsFT2A+pujsZVRiF81sU62dg70NW3yUBgFYMXfZn7fx+RZp
         SnyA==
X-Gm-Message-State: AOAM533L84U/OfCu5P6H8isIjR8LxyPycGg1BqTBkdj+wKcLhC6BwW8f
        qWQ9CfI803pwoj05Ejr18P8=
X-Google-Smtp-Source: ABdhPJw7ts93fqNET/0zp4esm0DBKgRhh4/5Km47RboR8Ip5r3eOEPVw0UnlP4BLGRPhqx0cRk3Mpw==
X-Received: by 2002:adf:d1c9:0:b0:1e4:bd6b:8bd4 with SMTP id b9-20020adfd1c9000000b001e4bd6b8bd4mr4070440wrd.88.1645142224358;
        Thu, 17 Feb 2022 15:57:04 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id r2sm3691694wmq.24.2022.02.17.15.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:57:04 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/16] dt-bindings: clock: split qcom,gcc.yaml to common and specific schema
Date:   Fri, 18 Feb 2022 00:56:48 +0100
Message-Id: <20220217235703.26641-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217235703.26641-1-ansuelsmth@gmail.com>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
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

Split qcom,gcc.yaml to common and specific schema to use it as a
template for schema that needs to use the gcc bindings and require
to add additional bindings.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/clock/qcom,gcc-other.yaml        | 76 +++++++++++++++++++
 .../devicetree/bindings/clock/qcom,gcc.yaml   | 63 ++-------------
 2 files changed, 82 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
new file mode 100644
index 000000000000..824d80530683
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller Binding
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+  - Taniya Das <tdas@codeaurora.org>
+
+description:
+  Qualcomm global clock control module which supports the clocks, resets and
+  power domains.
+
+  See also:
+  - dt-bindings/clock/qcom,gcc-apq8084.h
+  - dt-bindings/reset/qcom,gcc-apq8084.h
+  - dt-bindings/clock/qcom,gcc-ipq4019.h
+  - dt-bindings/clock/qcom,gcc-ipq6018.h
+  - dt-bindings/reset/qcom,gcc-ipq6018.h
+  - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
+  - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
+  - dt-bindings/clock/qcom,gcc-msm8939.h
+  - dt-bindings/clock/qcom,gcc-msm8953.h
+  - dt-bindings/reset/qcom,gcc-msm8939.h
+  - dt-bindings/clock/qcom,gcc-msm8660.h
+  - dt-bindings/reset/qcom,gcc-msm8660.h
+  - dt-bindings/clock/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
+  - dt-bindings/reset/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
+  - dt-bindings/clock/qcom,gcc-mdm9607.h
+  - dt-bindings/clock/qcom,gcc-mdm9615.h
+  - dt-bindings/reset/qcom,gcc-mdm9615.h
+  - dt-bindings/clock/qcom,gcc-sdm660.h  (qcom,gcc-sdm630 and qcom,gcc-sdm660)
+
+allOf:
+  - $ref: "qcom,gcc.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - qcom,gcc-apq8084
+      - qcom,gcc-ipq4019
+      - qcom,gcc-ipq6018
+      - qcom,gcc-ipq8064
+      - qcom,gcc-mdm9607
+      - qcom,gcc-msm8226
+      - qcom,gcc-msm8660
+      - qcom,gcc-msm8916
+      - qcom,gcc-msm8939
+      - qcom,gcc-msm8953
+      - qcom,gcc-msm8960
+      - qcom,gcc-msm8974
+      - qcom,gcc-msm8974pro
+      - qcom,gcc-msm8974pro-ac
+      - qcom,gcc-mdm9615
+      - qcom,gcc-sdm630
+      - qcom,gcc-sdm660
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  # Example for GCC for MSM8960:
+  - |
+    clock-controller@900000 {
+      compatible = "qcom,gcc-msm8960";
+      reg = <0x900000 0x4000>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
index f66d703bd913..ea1dd94d8bf1 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
@@ -1,60 +1,20 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/clock/qcom,gcc.yaml#
+$id: http://devicetree.org/schemas/clock/qcom,gcc-common.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Global Clock & Reset Controller Binding
+title: Qualcomm Global Clock & Reset Controller Binding Common Bindings
 
 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
   - Taniya Das <tdas@codeaurora.org>
 
 description: |
-  Qualcomm global clock control module which supports the clocks, resets and
-  power domains.
-
-  See also:
-  - dt-bindings/clock/qcom,gcc-apq8084.h
-  - dt-bindings/reset/qcom,gcc-apq8084.h
-  - dt-bindings/clock/qcom,gcc-ipq4019.h
-  - dt-bindings/clock/qcom,gcc-ipq6018.h
-  - dt-bindings/reset/qcom,gcc-ipq6018.h
-  - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
-  - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
-  - dt-bindings/clock/qcom,gcc-msm8939.h
-  - dt-bindings/clock/qcom,gcc-msm8953.h
-  - dt-bindings/reset/qcom,gcc-msm8939.h
-  - dt-bindings/clock/qcom,gcc-msm8660.h
-  - dt-bindings/reset/qcom,gcc-msm8660.h
-  - dt-bindings/clock/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
-  - dt-bindings/reset/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
-  - dt-bindings/clock/qcom,gcc-mdm9607.h
-  - dt-bindings/clock/qcom,gcc-mdm9615.h
-  - dt-bindings/reset/qcom,gcc-mdm9615.h
-  - dt-bindings/clock/qcom,gcc-sdm660.h  (qcom,gcc-sdm630 and qcom,gcc-sdm660)
+  Common bindings for Qualcomm global clock control module which supports
+  the clocks, resets and power domains.
 
 properties:
-  compatible:
-    enum:
-      - qcom,gcc-apq8084
-      - qcom,gcc-ipq4019
-      - qcom,gcc-ipq6018
-      - qcom,gcc-ipq8064
-      - qcom,gcc-mdm9607
-      - qcom,gcc-msm8226
-      - qcom,gcc-msm8660
-      - qcom,gcc-msm8916
-      - qcom,gcc-msm8939
-      - qcom,gcc-msm8953
-      - qcom,gcc-msm8960
-      - qcom,gcc-msm8974
-      - qcom,gcc-msm8974pro
-      - qcom,gcc-msm8974pro-ac
-      - qcom,gcc-mdm9615
-      - qcom,gcc-sdm630
-      - qcom,gcc-sdm660
-
   '#clock-cells':
     const: 1
 
@@ -72,22 +32,11 @@ properties:
       Protected clock specifier list as per common clock binding.
 
 required:
-  - compatible
   - reg
   - '#clock-cells'
   - '#reset-cells'
   - '#power-domain-cells'
 
-additionalProperties: false
+additionalProperties: true
 
-examples:
-  # Example for GCC for MSM8960:
-  - |
-    clock-controller@900000 {
-      compatible = "qcom,gcc-msm8960";
-      reg = <0x900000 0x4000>;
-      #clock-cells = <1>;
-      #reset-cells = <1>;
-      #power-domain-cells = <1>;
-    };
 ...
-- 
2.34.1


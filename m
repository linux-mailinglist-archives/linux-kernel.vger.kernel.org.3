Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1654C5657
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiBZNxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiBZNxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:53:14 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA59D3C49F;
        Sat, 26 Feb 2022 05:52:39 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hw13so16092707ejc.9;
        Sat, 26 Feb 2022 05:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vm6lJuyZcbXo+FxtA5M87f0TgQlaX41HYt3vXz/+Rb4=;
        b=luKsGbZcmf2Oggrxz9hEvIuCMJwE6jx/c94N+zOf9XvotK7zL8KHM7rXtAhgODZFKy
         mqsPi7+S0VcsDPnPQqLG+61zdN8Zg1y4kVEBuFtzhXwpneKdVmFpHmynoOOq2mRaBkiT
         nNqtL99MBFpN+KqUSJILmOeiUXQ4bKv9HiumSrFR1Lu032PFS7SHpDONhYmOg70OkVcZ
         iF5MKaCEsrn/DsyrfIbe1jFrKClO+gt+4uSkPPVsdsCO45rBnYTw5IDrwHLM76il7lsk
         iigHTgKuHsoj5bDmJ2cm7Ht6iUzT+cn753AaGohK6AqXMrNaCukuiFNTa6A3JwH8eDUi
         PYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vm6lJuyZcbXo+FxtA5M87f0TgQlaX41HYt3vXz/+Rb4=;
        b=VKWruv3r7QJ/UilwHuOrV5B3isOZaLftBsWkmhND3/gISf9iWzaGe3SMqYAbcqkzhi
         tug7wZ/PvkGc88jO6HQZUs39zTyIT5uefJWUdvmNy/OdJCd62hzmR/r4ZwjbxxOZJwda
         qnOOmBBeK1oNlEDMe63GnmjMnoyhL8Dag+c2hSfeTA3XJhsIIyIERkBmeZ6xcTL1XkUv
         jzgRAm0h0ZbWc66KZsOfTxKem9p02YjrYZcH0AIBQBQs0qgQugxlM9zomDK/79OwJY+o
         6tU0b+Voc5CVeAzAsN8v+ea5CMe+YdAcTZL5/aaIXDfc+JDSaX+HOhFyPtnUvdjJirTT
         Z7PA==
X-Gm-Message-State: AOAM530y3Nr1VgmCoILr9blGozDVm93tAWxIeBvheHVdRDSEHeKQgNVb
        NfLktBJcu+3DJtY2htfY8FQzLQLPYDE=
X-Google-Smtp-Source: ABdhPJxZqUzYIg1rlHYnrtW6wRMjanlof9hGLdN5t2k6FpeHmeLqnB1NqXMFOqZbFLW1UhzNr4km/g==
X-Received: by 2002:a17:906:81d5:b0:6cf:1fb9:3440 with SMTP id e21-20020a17090681d500b006cf1fb93440mr9422511ejx.351.1645883558216;
        Sat, 26 Feb 2022 05:52:38 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-95-251-226-220.retail.telecomitalia.it. [95.251.226.220])
        by smtp.googlemail.com with ESMTPSA id j21-20020aa7c415000000b004127ac9ddc3sm2836369edq.50.2022.02.26.05.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 05:52:37 -0800 (PST)
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
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v6 01/15] dt-bindings: clock: split qcom,gcc.yaml to common and specific schema
Date:   Sat, 26 Feb 2022 14:52:21 +0100
Message-Id: <20220226135235.10051-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220226135235.10051-1-ansuelsmth@gmail.com>
References: <20220226135235.10051-1-ansuelsmth@gmail.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 .../bindings/clock/qcom,gcc-other.yaml        | 76 +++++++++++++++++++
 .../devicetree/bindings/clock/qcom,gcc.yaml   | 59 +-------------
 2 files changed, 80 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
new file mode 100644
index 000000000000..4e5903bcd70d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-other.yaml#
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
index f66d703bd913..2ed27a2ef445 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
@@ -4,57 +4,17 @@
 $id: http://devicetree.org/schemas/clock/qcom,gcc.yaml#
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


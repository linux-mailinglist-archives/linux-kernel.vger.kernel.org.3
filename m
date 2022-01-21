Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E9D4966C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiAUVD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiAUVDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:03:53 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EEBC06173B;
        Fri, 21 Jan 2022 13:03:53 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id h7so3334683ejf.1;
        Fri, 21 Jan 2022 13:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=thoVAsRaEwpb4DhploDdrZwAcBcB7cc7KQIcQ0vTONA=;
        b=K0ZzayTdbBg4OwEgBwSR/qM8f9XwoITHN7ZGYjlhaXggiVd7vMSnnhCCjV1hIcz7db
         5tfEfaJv+UKdSMau4QaCao5DJuH+4bhB5ZdCFV7KoRAdscW1aTWUhYTOiwlLfJGpWqZu
         obGL1kTFR1EN6QdnPBAxK08Gfbic2M9/XX+JBO81FxF+HFUkYmd5KZYQhTkKOspKumt4
         tmvESl1a7sSXlvdOIVGI3eoxzHYChhArfXqKEpTKySFCQyrM+mF04Bf2EtOzjHP4tUYE
         ukgFI8y3PZTOwFlWJ4988aN8iEoRFIKnsM6wHlpEuDfdIqs3kOw0QmKMtcPIlaCJuUb7
         ycYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thoVAsRaEwpb4DhploDdrZwAcBcB7cc7KQIcQ0vTONA=;
        b=TEPBtvLFIcb5VfRGwRg8Nbpm4a+dCdjVOhHwQ1HzeO8ujfVgNCs4m9hXGjR6AyV592
         kAr8pufH6Wb0YdIoLk9cY48DBo5fFqNtXJnTfdYod5AyIuNLOXs4283OJffLPdYuIF3I
         1zNEHQN7MVmul/uLfvoSFo61BkwAXEPGu89N++crUxoO5M6t8YndXTarqRG/E5egE2qN
         7ucrMDo267Ahe1FJx2NSuDaou7bHSDDHaOwNln0mhIh1UE/GvGXebwcKbqyKRhVbUqO7
         SOTOG1FjiiPNJ/vbPNpPn/sN+9lOZeiDBOgDzof9rtBYz7mGLdH099sg1xC94y2yWRRK
         RNIg==
X-Gm-Message-State: AOAM530fVks+DIo94SRAD9ouhr0dX0QoZUA/NwGTd2TCwDVvnHFOODHS
        +kelP9XbYyxCPdf0vjgjKZ4=
X-Google-Smtp-Source: ABdhPJxe5dAqO9zR9ccWNYgggXWzEW1s4go1xo46o/4QRFSLZ3y2IgwCaqFNTEKdeXoBGORI47tPlA==
X-Received: by 2002:a17:906:99c3:: with SMTP id s3mr3948309ejn.16.1642799031556;
        Fri, 21 Jan 2022 13:03:51 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id p23sm2898595edx.86.2022.01.21.13.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:03:51 -0800 (PST)
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
Subject: [PATCH v3 01/15] dt-bindings: clock: split qcom,gcc.yaml to common and specific schema
Date:   Fri, 21 Jan 2022 22:03:26 +0100
Message-Id: <20220121210340.32362-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220121210340.32362-1-ansuelsmth@gmail.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split qcom,gcc.yaml to common and specific schema to use it as a
template for schema that needs to use the gcc bindings and require
to add additional bindings.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/clock/qcom,gcc-common.yaml       | 42 +++++++++++++++++++
 .../devicetree/bindings/clock/qcom,gcc.yaml   | 25 ++---------
 2 files changed, 46 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-common.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-common.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-common.yaml
new file mode 100644
index 000000000000..ea1dd94d8bf1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-common.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller Binding Common Bindings
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+  - Taniya Das <tdas@codeaurora.org>
+
+description: |
+  Common bindings for Qualcomm global clock control module which supports
+  the clocks, resets and power domains.
+
+properties:
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  protected-clocks:
+    description:
+      Protected clock specifier list as per common clock binding.
+
+required:
+  - reg
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: true
+
+...
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
index f66d703bd913..73e3ff4979c6 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
@@ -34,6 +34,9 @@ description: |
   - dt-bindings/reset/qcom,gcc-mdm9615.h
   - dt-bindings/clock/qcom,gcc-sdm660.h  (qcom,gcc-sdm630 and qcom,gcc-sdm660)
 
+allOf:
+  - $ref: "qcom,gcc-common.yaml#"
+
 properties:
   compatible:
     enum:
@@ -55,30 +58,10 @@ properties:
       - qcom,gcc-sdm630
       - qcom,gcc-sdm660
 
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
-  reg:
-    maxItems: 1
-
-  protected-clocks:
-    description:
-      Protected clock specifier list as per common clock binding.
-
 required:
   - compatible
-  - reg
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   # Example for GCC for MSM8960:
-- 
2.33.1


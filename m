Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACE451491B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358984AbiD2MYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353508AbiD2MXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:23:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276CD205CD;
        Fri, 29 Apr 2022 05:20:18 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z99so8869574ede.5;
        Fri, 29 Apr 2022 05:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2jO8iQFRsavkZH0i8n1gjUFOf09L/MY+4sf/fbVG9MQ=;
        b=f2BZWRV2LBKXH/7uVWkd9+7wi7GfY27JxC45DIQ7OQEAz9gy9aa+EY2WFjHsbj7Fdr
         /YGVKX7hgu/LFnjIvCrzybjYHH3Jgf2VvGPh1Yt3wL3Ho27zujWp/2u49/YhHwCPeVG/
         z0ppT0JeP9FNG5TMJDemWdqRmAoicXbX+yqVr0LWmgDwlA0ViosYecmG6/KKuiDjBDPc
         UeGxFeofIshTU2kju8Z57a5uJw9U+VIUaCb8TDZ6vtwB0oV570jGPvyG2uvHJJmRMyRO
         6OL6z0ZbPO7/ZopL+saXJnHwmdTnkqGCFCNQg03ENHMEYXEt2qO6NjxcOxmhPPPLtVhI
         WaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jO8iQFRsavkZH0i8n1gjUFOf09L/MY+4sf/fbVG9MQ=;
        b=ONkAb/DHsbCpro8rTcKFcd6EX5jTfaEvvtUEMqgNAYrTxnfVuRVar/o6sNqwBTnT7b
         JkeWqUUOjlrYsyGytA5SRpQAhngiADbwE+LE7bWtwvBQocnrBI7hpLGKZgiWT/+eUx3Y
         NL9Xh63HbkXI2vmeVcEOJKkjTwOVMiqIiwljlS0Q7n+gfC1Kl4tpBnbObNiAP/CXex+0
         bnPoZ357LjxQNVfj+dCGJtO7vx6l38K8MGr75ol8x3sL/SRU/oCa5tGC0D1YnKxwxHlm
         gNCqVsAuJVABA56sVPAfX9N9yO7YQ4jmLoQzefOs6iMv9ZIohba9zoRH0zuqomxOcRF9
         hmcg==
X-Gm-Message-State: AOAM533iF77efVUyJrQvnJs3m6m4PqEI1QLgIs6ToqZdKii6CFV5M0+a
        oUp0MJfkxBFu29CMjkRCRuU=
X-Google-Smtp-Source: ABdhPJxE3LKcCgKYwMS/eAlJbMIZso8DmyhEMwuUf34ioGF2XkQtIS5Ufq8i/IiL8nk6qXNEUsrbWg==
X-Received: by 2002:a05:6402:3492:b0:426:19be:bf36 with SMTP id v18-20020a056402349200b0042619bebf36mr12678605edc.36.1651234816564;
        Fri, 29 Apr 2022 05:20:16 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id rb48-20020a170907693000b006f3ef214e10sm602694ejc.118.2022.04.29.05.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:20:16 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml
Date:   Fri, 29 Apr 2022 14:17:38 +0200
Message-Id: <20220429121739.28584-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220429121739.28584-1-ansuelsmth@gmail.com>
References: <20220429121739.28584-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert kpss-acc driver Documentation to yaml.
The original Documentation was wrong all along. Fix it while we are
converting it.
The example was wrong as kpss-acc-v2 should only expose the regs but we
don't have any driver that expose additional clocks. The kpss-acc driver
is only specific to v1. For this exact reason, limit all the additional
bindings (clocks, clock-names, clock-output-names and #clock-cells) to
v1 and also flag that these bindings should NOT be used for v2.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
 .../bindings/arm/msm/qcom,kpss-acc.yaml       | 94 +++++++++++++++++++
 2 files changed, 94 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
deleted file mode 100644
index 7f696362a4a1..000000000000
--- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
-
-The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
-There is one ACC register region per CPU within the KPSS remapped region as
-well as an alias register region that remaps accesses to the ACC associated
-with the CPU accessing the region.
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: should be one of:
-			"qcom,kpss-acc-v1"
-			"qcom,kpss-acc-v2"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: the first element specifies the base address and size of
-		    the register region. An optional second element specifies
-		    the base address and size of the alias register region.
-
-- clocks:
-        Usage: required
-        Value type: <prop-encoded-array>
-        Definition: reference to the pll parents.
-
-- clock-names:
-        Usage: required
-        Value type: <stringlist>
-        Definition: must be "pll8_vote", "pxo".
-
-- clock-output-names:
-	Usage: optional
-	Value type: <string>
-	Definition: Name of the output clock. Typically acpuX_aux where X is a
-		    CPU number starting at 0.
-
-Example:
-
-	clock-controller@2088000 {
-		compatible = "qcom,kpss-acc-v2";
-		reg = <0x02088000 0x1000>,
-		      <0x02008000 0x1000>;
-		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
-		clock-names = "pll8_vote", "pxo";
-		clock-output-names = "acpu0_aux";
-	};
diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
new file mode 100644
index 000000000000..707a81a6c30e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-acc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
+  There is one ACC register region per CPU within the KPSS remapped region as
+  well as an alias register region that remaps accesses to the ACC associated
+  with the CPU accessing the region.
+
+properties:
+  compatible:
+    enum:
+      - qcom,kpss-acc-v1
+      - qcom,kpss-acc-v2
+
+  reg:
+    items:
+      - description: Base address and size of the register region
+      - description: Optional base address and size of the alias register region
+
+  clocks:
+    items:
+      - description: phandle to pll8_vote
+      - description: phandle to pxo_board
+
+  clock-names:
+    items:
+      - const: pll8_vote
+      - const: pxo
+
+  clock-output-names:
+    description: Name of the aux clock. Krait can have at most 4 cpu.
+    enum:
+      - acpu0_aux
+      - acpu1_aux
+      - acpu2_aux
+      - acpu3_aux
+
+  '#clock-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,kpss-acc-v1
+      then:
+        required:
+          - clocks
+          - clock-names
+          - clock-output-names
+          - '#clock-cells'
+    else:
+      properties:
+        clocks: false
+        clock-names: false
+        clock-output-names: false
+        '#clock-cells': false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
+
+    clock-controller@2088000 {
+      compatible = "qcom,kpss-acc-v1";
+      reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+      clock-names = "pll8_vote", "pxo";
+      clock-output-names = "acpu0_aux";
+      #clock-cells = <0>;
+    };
+
+  - |
+    clock-controller@f9088000 {
+      compatible = "qcom,kpss-acc-v2";
+      reg = <0xf9088000 0x1000>,
+            <0xf9008000 0x1000>;
+    };
+...
-- 
2.34.1


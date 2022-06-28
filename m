Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2857855ED08
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiF1St5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiF1Stq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:49:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490C824950;
        Tue, 28 Jun 2022 11:49:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fi2so27600468ejb.9;
        Tue, 28 Jun 2022 11:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4FPkUUdFj7N4cyVSH9dZ9KXQ/52X77hSvZgVoO/7D4M=;
        b=gstC7xo1AEvWKUhvixaizNSnyNWPy//LAansrSGGap4FYta3JPXGOHPqqnQyEsZbYv
         1V2XO0bcJYzSN1QRNlFneRJvJ2LZT7VHktV20UrAvgL1J+I4ZGls7+gJ7zgZ4nbqifC+
         /qBW53hb8bTJeAEKYYn67EZhp6osLjLzL4o0gpiMzkiHCUk3hWszbhncRRBPFQJO8Iy0
         74GVcWvxx71koaL3DH+mVrT+sX+XJXsrwdSFhK6WSONLaRenXbbekAPrdPchTQ2Y1sqa
         u4SIJK/nOc7hFPenaHmgt22phNLyCtqkcq1COD3RFOiQqA9A5dIYbx/xNH27jvVN9aBP
         CNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FPkUUdFj7N4cyVSH9dZ9KXQ/52X77hSvZgVoO/7D4M=;
        b=IjNoKql2OKfaSli1erHLcqqPck1vcu2eMVFKd61+KPBK/mrKZLOpt7jUADRa65L16K
         8fiN+/B+Wa6MT7e+mtM4XGBF+N8beG/AylplSlg25/4PiuJbSvWilOqry1G1b0PhblZr
         1xxc1LDzR78HxoODQrFH7S24LFgTOrePaEzpCD/b1QeDilrxz2V8VDZbfWBbJQc48P3T
         1XvfTFAr2KYJUC3niepjBpPr5MQjErBEV2eCJf+zSo+zhL1zBt2gRUDxdI3/EJTGvA6o
         B1ZFhQK5TNRL2CMRwXtcGJO3n7BnxLzdF6IWOQYHQR7uLy73X1yhs/JJA7EEyN5p3Ccu
         cGBQ==
X-Gm-Message-State: AJIora+ORyBAyD9MQ+voLQS1etbvZcpwJZi6AHuCYpdSHgzb1F+sSeln
        aKYgNiHCcyyREqGBbZvDsuk=
X-Google-Smtp-Source: AGRyM1sPbUQJUF9V3odw3WotosGv+O2gMJkST/dUL5e6cE6iQuL6RVKt7CTyXB2U8YLH6A85XHAKYg==
X-Received: by 2002:a17:906:9508:b0:723:ef49:fe4c with SMTP id u8-20020a170906950800b00723ef49fe4cmr19791717ejx.489.1656442183703;
        Tue, 28 Jun 2022 11:49:43 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id t21-20020a05640203d500b0043573c59ea0sm9747593edw.90.2022.06.28.11.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 11:49:43 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 3/4] dt-bindings: arm: msm: Rework kpss-gcc driver Documentation to yaml
Date:   Tue, 28 Jun 2022 20:41:36 +0200
Message-Id: <20220628184137.21678-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628184137.21678-1-ansuelsmth@gmail.com>
References: <20220628184137.21678-1-ansuelsmth@gmail.com>
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

Rework kpss-gcc driver Documentation to yaml Documentation.
The current kpss-gcc Documentation have major problems and can't be
converted directly. Introduce various changes to the original
Documentation.

Add #clock-cells additional binding as this clock outputs a static clk
named acpu_l2_aux with supported compatible.
Only some compatible require and outputs a clock, for the others, set
only the reg as a required binding to correctly export the kpss-gcc
registers. As the reg is shared also add the required syscon compatible.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
 .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 89 +++++++++++++++++++
 2 files changed, 89 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
deleted file mode 100644
index e628758950e1..000000000000
--- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: should be one of the following. The generic compatible
-			"qcom,kpss-gcc" should also be included.
-			"qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc"
-			"qcom,kpss-gcc-apq8064", "qcom,kpss-gcc"
-			"qcom,kpss-gcc-msm8974", "qcom,kpss-gcc"
-			"qcom,kpss-gcc-msm8960", "qcom,kpss-gcc"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: base address and size of the register region
-
-- clocks:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: reference to the pll parents.
-
-- clock-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "pll8_vote", "pxo".
-
-- clock-output-names:
-	Usage: required
-	Value type: <string>
-	Definition: Name of the output clock. Typically acpu_l2_aux indicating
-		    an L2 cache auxiliary clock.
-
-Example:
-
-	l2cc: clock-controller@2011000 {
-		compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc";
-		reg = <0x2011000 0x1000>;
-		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
-		clock-names = "pll8_vote", "pxo";
-		clock-output-names = "acpu_l2_aux";
-	};
diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
new file mode 100644
index 000000000000..04db9aca5ca3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  Krait Processor Sub-system (KPSS) Global Clock Controller (GCC). Used
+  to control L2 mux (in the current implementation) and provide access
+  to the kpss-gcc registers.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,kpss-gcc-ipq8064
+          - qcom,kpss-gcc-apq8064
+          - qcom,kpss-gcc-msm8974
+          - qcom,kpss-gcc-msm8960
+          - qcom,kpss-gcc-msm8660
+          - qcom,kpss-gcc-mdm9615
+      - const: qcom,kpss-gcc
+      - const: syscon
+
+  reg:
+    maxItems: 1
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
+  '#clock-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - qcom,kpss-gcc-ipq8064
+          - qcom,kpss-gcc-msm8974
+          - qcom,kpss-gcc-msm8960
+then:
+  required:
+    - clocks
+    - clock-names
+    - '#clock-cells'
+else:
+  properties:
+    clock: false
+    clock-names: false
+    '#clock-cells': false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
+
+    clock-controller@2011000 {
+      compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc", "syscon";
+      reg = <0x2011000 0x1000>;
+      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+      clock-names = "pll8_vote", "pxo";
+      #clock-cells = <0>;
+    };
+
+  - |
+    clock-controller@2011000 {
+      compatible = "qcom,kpss-gcc-mdm9615", "qcom,kpss-gcc", "syscon";
+      reg = <0x02011000 0x1000>;
+    };
+...
+
-- 
2.36.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0DC55FF7A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiF2MPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiF2MPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:15:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B8B1AD9C;
        Wed, 29 Jun 2022 05:15:02 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eq6so21877091edb.6;
        Wed, 29 Jun 2022 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vIzhJkVyCpTAKMG5+MRKoujKBdQJIdgiXek5IjiiVIA=;
        b=cITZOKLlxyJebJSNf3yzbElxUA202vtBkGrcO/jEW1GaGiArVyL54hZ59ANT5JzUnZ
         Innu5ME8UqOfoO2THXdLxbtBauY5eMbQm2cNdgIJvYANQyHoY5oDUKYdyDYnWObY2c7G
         iopna332+GnaWm75ckr3JlWtpUtiarLC4k/fYV+os7ecjJ1S/5jKpUf+F65o3NUeH3+W
         JZu9owM/swmf2MtcHFX9Ft+RWp7BOMAeNwpNJ7F93Bg3igWi5Scm7cwhREeLWDzVicaj
         8lWCKY3n/OlZKZS4rdl3kEg9Dy+z2qmpwxuLVBXkYXEaxzxL8IQ/dRuJ5I/9bqriPgM3
         hWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIzhJkVyCpTAKMG5+MRKoujKBdQJIdgiXek5IjiiVIA=;
        b=2raQZ92MtcCkF/HUix7800PUlm+Nr5xDhvX0QmnHIoaZKmo5nut5rphhatAw1OtOUu
         ld2Ar0P1bXQh97oqLn0nhydbndi6BWurTG5YBWTsGb41C7/axehdA4IiTAZLo6wToA6j
         QTnwMojMstgDmN9SOiIXQ2EkNSw41KiFEJSAvKLsPN+IxPF4GCctCekl6tsPa+gOMPZf
         YXE7/8j9ZG5k0cN6HLaq/ru+1fM+NUb2s5/CvZakeU/VxQL+16Ieb1l9al/9zv3NZt2B
         7fEv5sOx9S3YisbWZZ5TvWlrMlZPOIwzoMhCPKUlBjQ2fOzqfq1A33+q38wh6REthX2W
         WK4Q==
X-Gm-Message-State: AJIora9PA2Kl/Drtm8E0sgFxytQGeOtfWtxyANUGr9bFui248Li5gLSa
        GacuU47klWt4R2EAjCU9WiQ=
X-Google-Smtp-Source: AGRyM1u3n5Z6J1UG+WyEpBIJkbO+FgU6JDzeYAmHvCT0NjjFOPlqT5aFPBxEASkBjKhL7cb7Dn4g2g==
X-Received: by 2002:a05:6402:e9f:b0:435:644e:4a7d with SMTP id h31-20020a0564020e9f00b00435644e4a7dmr3906193eda.114.1656504901767;
        Wed, 29 Jun 2022 05:15:01 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id l23-20020aa7cad7000000b004356afc7009sm11224421edt.59.2022.06.29.05.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:15:01 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 3/5] dt-bindings: arm: msm: Rework kpss-gcc driver Documentation to yaml
Date:   Wed, 29 Jun 2022 14:14:39 +0200
Message-Id: <20220629121441.6552-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629121441.6552-1-ansuelsmth@gmail.com>
References: <20220629121441.6552-1-ansuelsmth@gmail.com>
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
 .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 90 +++++++++++++++++++
 2 files changed, 90 insertions(+), 44 deletions(-)
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
index 000000000000..27f7df7e3ec4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
@@ -0,0 +1,90 @@
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
+          - qcom,kpss-gcc-apq8064
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


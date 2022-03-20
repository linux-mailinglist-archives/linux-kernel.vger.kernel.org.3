Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5E34E1CD8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242222AbiCTQbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245585AbiCTQaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:30:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B0134656;
        Sun, 20 Mar 2022 09:28:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so7222886wmb.3;
        Sun, 20 Mar 2022 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bUbi/jkzYIKSOu8T7OV/skgoIWQk4BHawXnXdm1xB5I=;
        b=QBfsjPV1XhoP5TR9nsbodr4/tWA62M6TCQ+D/v4Rrlnr0Opm3EEHHihqX0tPW+Jfqm
         OQs6vgTDFJcfW0rEm9mDlhIkg1MMLfwW9WjuwoUSLi4pGhYBdaWXOzMTAsoZ+aTKg3zZ
         kpQKsf01ab1ZKflLaRWZEgC8sAPL4V4YHziilfXjgo/wkzqUqGy1QJHvMMMwrRXJ6vj5
         MbWwBLmaqX5PLtdjzafeVHC07m2GBxQ/Ahl+1v7rOzufYaGxk7EArv+r/XsoDtKEoEIh
         x2GnJ6zvHJuqXIXWNt135+62fZT/11VboelJWlqmPt6ndE6HD02HnsWX/wq3GAdu85Gn
         JFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUbi/jkzYIKSOu8T7OV/skgoIWQk4BHawXnXdm1xB5I=;
        b=ZZXxs/nCM8pCByfwOc+Dp2a18PLc1yZZVq1kKrWkg+mboiCwjTYPrnGOhEeW1ikdEx
         bm6qItVZ/QCa6XNuo3RqGjqKR/azKIInXhX2KXQ948FAnUnuTLnhbiTsEmCBk+SD8A7g
         FNf0BRQ/rIsH0LK9pU1msQMmBHWpKBjOEFVx3/xGY4BhHThVoOM7Mv4bjpn9T8zFN0Qb
         LABDvJ1YMGEqZ1IJrFISSUtjja9onL80WPUVJYjFtICxOGVrFAKriJgPHk05bn34MVZe
         76X8S2te7tTwI1EcLToR1t/yzIIr/viiPecT49SaNytTaiOqQGwJ2vDYsywYk5ZNA2ge
         RvrA==
X-Gm-Message-State: AOAM531oXSJqeZd6p4WHe+mK+GMh+sbaxGle7NQOwbIz5StWhKLEpS4P
        m3u+04FWVARnxVVRS2P85mo=
X-Google-Smtp-Source: ABdhPJxQEeFWTDjt9U0eUu1Y+jsiC77yc6QUch/tNSKtkN/tpZTxvIGkyhsnawpJHsgdcwmo9KYENA==
X-Received: by 2002:a05:600c:4142:b0:38c:9dc6:c87a with SMTP id h2-20020a05600c414200b0038c9dc6c87amr3628753wmm.114.1647793710898;
        Sun, 20 Mar 2022 09:28:30 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:30 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 18/18] dt-bindings: arm: msm: Convert kpss-gcc driver Documentation to yaml
Date:   Sun, 20 Mar 2022 12:34:30 +0100
Message-Id: <20220320113430.26076-19-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220320113430.26076-1-ansuelsmth@gmail.com>
References: <20220320113430.26076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert kpss-gcc driver Documentation to yaml.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ------------
 .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 44 deletions(-)
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
index 000000000000..351a88407f4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  Krait Processor Sub-system (KPSS) Global Clock Controller (GCC). Used
+  to control L2 mux (in the current implementation).
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - qcom,kpss-gcc-ipq8064
+        - qcom,kpss-gcc-apq8064
+        - qcom,kpss-gcc-msm8974
+        - qcom,kpss-gcc-msm8960
+      - const: qcom,kpss-gcc
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
+  clock-output-names:
+    const: acpu_l2_aux
+
+  '#clock-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - clock-output-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
+
+    clock-controller@2011000 {
+      compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc";
+      reg = <0x2011000 0x1000>;
+      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+      clock-names = "pll8_vote", "pxo";
+      clock-output-names = "acpu_l2_aux";
+      #clock-cells = <0>;
+    };
+...
+
-- 
2.34.1


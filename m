Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DA1514916
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359083AbiD2MYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356732AbiD2MXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:23:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EEFE0B0;
        Fri, 29 Apr 2022 05:20:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gh6so15193788ejb.0;
        Fri, 29 Apr 2022 05:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e6HTTfg5BzZgVlVHutoMY6UjT5iplTny53rcKCZeVPU=;
        b=Kqjqq3mYGtUO2FJScGKYzHQnFvB3Lwwwwh1JifM/q84GUfKaZP5uh+6BdQhLGCo6+4
         fAzs+JKdg/kLphPCzIJK9UIB8E7oFoibKetAK+fs4RVUd+/N72f6g8+FPU7MpNFIbdqk
         M/5/NpHt0y+IrWYYLm6X7V+oZudwW9x5tTLo56MwXgY2WqRhqWaJvgW8QrHI5N2TdAxw
         V3INxVKlxmBWV4ooqQ7SE4zpmjjAv49CCQ4Tdk5KrznyynqJbf09WVAId+A0kS6BN+Xi
         trGa+GopJYnLDg4kQRB4FSmL8UzOqbIPUJBCzUaDqeAfFkKCJJ640CBZvIl96d8P60QC
         RVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e6HTTfg5BzZgVlVHutoMY6UjT5iplTny53rcKCZeVPU=;
        b=ZW8ppdaf6T+OJkbjW8EsI41xxRCP8MaNyt21GmpAkApZYfKZ+CrTRwvpKqGW2hKubm
         jmun0zc45WE5/P1ewyNGb7PaHCthkkrADrHc4lj3nrRcMA/Py82L8UvaPhmEwln1poql
         dc+ehLx3sy3ihbH755MP4tD4D5TVTcpTJyc371viILW+L2LxebW6xx+5HQxp3MRu7+4p
         bgj9yn424aCli2ZH+ZwucLqirGZqMp10+QYx/NH5krZqoVaXChPKDvUfbG7XG9BPbv3P
         JUr51TXRXnPV8WIDkOK7u/tLxRR2wqSW/jAL9OTX7D4YZMB8fIZZuu9bbqQhk8gTuCyT
         xEAw==
X-Gm-Message-State: AOAM5302dOSZUxwfa3sOJVVv8hzZU1TQvIYcRYwrZeB7SGkeShXVnUsw
        bPOwn4JEQ+ZE9g/Cv5tDdYg=
X-Google-Smtp-Source: ABdhPJwxmg15oh0W8TMtdZuy6yOocDsuoh6bunug6rM//k6NWG+zKlm9Vt0c0++1y6czvqeRkp8eoA==
X-Received: by 2002:a17:906:58c9:b0:6f3:966a:7d5c with SMTP id e9-20020a17090658c900b006f3966a7d5cmr23620762ejs.728.1651234815342;
        Fri, 29 Apr 2022 05:20:15 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id rb48-20020a170907693000b006f3ef214e10sm602694ejc.118.2022.04.29.05.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:20:14 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/3] dt-bindings: clock: Convert qcom,krait-cc to yaml
Date:   Fri, 29 Apr 2022 14:17:37 +0200
Message-Id: <20220429121739.28584-2-ansuelsmth@gmail.com>
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

Convert qcom,krait-cc to yaml Documentation.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/qcom,krait-cc.txt          | 34 -----------
 .../bindings/clock/qcom,krait-cc.yaml         | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt b/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
deleted file mode 100644
index 030ba60dab08..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Krait Clock Controller
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-			"qcom,krait-cc-v1"
-			"qcom,krait-cc-v2"
-
-- #clock-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: must be 1
-
-- clocks:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: reference to the clock parents of hfpll, secondary muxes.
-
-- clock-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb".
-
-Example:
-
-	kraitcc: clock-controller {
-		compatible = "qcom,krait-cc-v1";
-		clocks = <&hfpll0>, <&hfpll1>, <&acpu0_aux>, <&acpu1_aux>, <qsb>;
-		clock-names = "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb";
-		#clock-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
new file mode 100644
index 000000000000..e879bfbe67ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,krait-cc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Krait Clock Controller
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  Qualcomm Krait Clock Controller used to correctly scale the CPU and the L2
+  rates.
+
+properties:
+  compatible:
+    enum:
+      - qcom,krait-cc-v1
+      - qcom,krait-cc-v2
+
+  clocks:
+    items:
+      - description: phandle to hfpll for CPU0 mux
+      - description: phandle to hfpll for CPU1 mux
+      - description: phandle to CPU0 aux clock
+      - description: phandle to CPU1 aux clock
+      - description: phandle to QSB fixed clk
+
+  clock-names:
+    items:
+      - const: hfpll0
+      - const: hfpll1
+      - const: acpu0_aux
+      - const: acpu1_aux
+      - const: qsb
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller {
+      compatible = "qcom,krait-cc-v1";
+      clocks = <&hfpll0>, <&hfpll1>,
+               <&acpu0_aux>, <&acpu1_aux>, <&qsb>;
+      clock-names = "hfpll0", "hfpll1",
+                    "acpu0_aux", "acpu1_aux", "qsb";
+      #clock-cells = <1>;
+    };
+...
-- 
2.34.1


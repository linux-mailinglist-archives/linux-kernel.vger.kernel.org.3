Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A8F55FF7F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiF2MPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiF2MPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:15:01 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00E1271A;
        Wed, 29 Jun 2022 05:15:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eq6so21877091edb.6;
        Wed, 29 Jun 2022 05:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qf5xZr94K/ycK+i9/Wok3iiobG+7FvR7R5ERaeixzlU=;
        b=AUKEH+eD45lQpRdbUNmtdHx7zciIzjYohTdqBdgEbadeFOfo/1SzabF8Sgxm7zhUIG
         xnX2jst11smiFreOfr3PguzGRoVJDQFRoEQdoHAwflLFMFNBFVdgkTFFus3wdC0DoDXX
         NcxBwniilqb5JsBl/3EzgkThZuUF1vNsBux8owIENmQonhRrfgC5u7u8XGL8sk3UhuuG
         MP3IXWGxPI7rccZKA/wHWST+C0PzCl9yjZb2tylRM1Kw87fPsve0YvTVZrKaHn7u05J+
         n9HHSbukrZyBQ8drnwOEmXj/V41lHwVSfKJ5dAx4eZlcO7/4ZW3CcFS8VHGd6IcKZYoD
         8klQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qf5xZr94K/ycK+i9/Wok3iiobG+7FvR7R5ERaeixzlU=;
        b=FtX7oOSsb9m5qqgbvQP11sLTLZQR1OQoIur08Zg7l6+XxE75EbO3Tj/b0BymC7flRG
         0o05NgLH/kSwkaoM2Bi8CbJSCSTzEGJ2gb/qT444l2xUDWwJb/68zfsuvdF6IgB7CL9o
         eiNtlWfwwQ1xrTl3Iq+p+JtLXGm+ecU1mUuD8/nalpj0ZEwYijrRwnkMl1yC5rxLSpnT
         5Ij0U/7W9Ea2EXnjQ0ichD8r/9nFy01+tA4PS2m3mWeURZZ86Jwx9r/7HWL5FXBjqxey
         cMCHPZ66V+oCFjecKuG2sUlXpwzPTTCq6CDIe2encW0Fb4rzXCb4epxIOebrIfjIj13/
         clCQ==
X-Gm-Message-State: AJIora+H/RsbhVlw+qumdv978ZVAg/eORTTOhGDRozujIBLECz3+rFxD
        s9TJu2yVFaO7NIn6ulPiAkk=
X-Google-Smtp-Source: AGRyM1uSinNpEi2Cls2oLD+IjPHYJcJjCLMkRPBPn8nZEELMhakrYGJ1pm1qA4ld+0yuZTF3wLDfNw==
X-Received: by 2002:a05:6402:25c2:b0:431:932e:eb6f with SMTP id x2-20020a05640225c200b00431932eeb6fmr3958374edb.296.1656504899405;
        Wed, 29 Jun 2022 05:14:59 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id l23-20020aa7cad7000000b004356afc7009sm11224421edt.59.2022.06.29.05.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:14:59 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/5] dt-bindings: clock: Convert qcom,krait-cc to yaml
Date:   Wed, 29 Jun 2022 14:14:37 +0200
Message-Id: <20220629121441.6552-2-ansuelsmth@gmail.com>
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

Convert qcom,krait-cc to yaml Documentation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
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
index 000000000000..8caa5a677394
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
+  - Christian Marangi <ansuelsmth@gmail.com>
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
2.36.1


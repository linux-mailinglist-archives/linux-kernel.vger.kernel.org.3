Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAF655FF88
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiF2MPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiF2MPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:15:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A1217E1F;
        Wed, 29 Jun 2022 05:15:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q6so32103259eji.13;
        Wed, 29 Jun 2022 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5r/KEXu3oOU25wHhmNXJIXLUeqHnhpIpl6aSaRMG3+Y=;
        b=myUUuQ5j1xmOgloRaFglBCQYjGiVoYOn1Fcc4/xslN0UZdK7sYkKxoMpBPEQve/X5O
         eL561JsuQmWXdrgIp8QbqTOq96/0b56/iu6BpDREU5iwyrMS1Z0fWKXH7p0LEM5qYUof
         kJX1nc1GebpqwAP29WN5jVJ9S18fmS7cF5iMKR8rEH5a5yU5ste71FyH6o9RB3ozhztQ
         gClA35syZBHapt1SNtuLS+z8cX8xL7NrfPIHJFBTCxDLQgI4K9iWfp00X2nuxU/tptnm
         gbZX/XRaLDrt1yRYunMxKrDcaY/qeutV4hyLMuF4uh5Yac20vcVQ/9RYYBwCmFe2fno/
         LevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5r/KEXu3oOU25wHhmNXJIXLUeqHnhpIpl6aSaRMG3+Y=;
        b=pv9WnRq58TQzGS0ozAOgRdbi9miViZrWHCzSlt31/4O7QO/9Jpkl0SDmyJlK0krvjt
         uyuvHfJxJp1qlaCCxwHfH/dygTMJcBsRWAwbMcKwtXcr9+zvr2GJWkCtdiSRVGNWk6RV
         IEtjQhRRG8gcXoJCCq1bbCuFIzvcPuAJQWKLc4bUyTabn2qV/Gvf6pGFN6DjCNWWHR/e
         kWtf4rTrYWxBjxViqBJLlWG8vAme+UbGRSk1XGuhmnoIvKfmGdxfJfLfcRO8GngQDLmj
         Q5C9kLnzlXH9SwB54qpGVxEIbggwdShuQyO2/LPvCJ2Pc62KypS3MNgLj2w6lNX8dJNt
         gUqg==
X-Gm-Message-State: AJIora/7gWfFT4h2uisFVfqsLSJRnR83Xr0GC04FEgT4b9kbbJ56D+Fp
        ocpzGKM71ddSPlF2VRXkhps=
X-Google-Smtp-Source: AGRyM1va/Fh9fc6YLFIDQwpk7EGXEv5PoTTKIVa7yFMniQnDHlOS0ygDvEbD+4KldZ7jJlx9qlDnNQ==
X-Received: by 2002:a17:907:94c5:b0:726:b8a9:f9b9 with SMTP id dn5-20020a17090794c500b00726b8a9f9b9mr3052612ejc.123.1656504900622;
        Wed, 29 Jun 2022 05:15:00 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id l23-20020aa7cad7000000b004356afc7009sm11224421edt.59.2022.06.29.05.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:15:00 -0700 (PDT)
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
Subject: [PATCH v4 2/5] dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml
Date:   Wed, 29 Jun 2022 14:14:38 +0200
Message-Id: <20220629121441.6552-3-ansuelsmth@gmail.com>
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

Convert kpss-acc driver Documentation to yaml.
The original Documentation was wrong all along. Fix it while we are
converting it.
The example was wrong as kpss-acc-v2 should only expose the regs but we
don't have any driver that expose additional clocks. The kpss-acc driver
is only specific to v1. For this exact reason, limit all the additional
bindings (clocks, clock-names, clock-output-names and #clock-cells) to
v1 and also flag that these bindings should NOT be used for v2.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
 .../bindings/arm/msm/qcom,kpss-acc.yaml       | 93 +++++++++++++++++++
 2 files changed, 93 insertions(+), 49 deletions(-)
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
index 000000000000..5e16121d9f0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-acc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
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
+if:
+  properties:
+    compatible:
+      contains:
+        const: qcom,kpss-acc-v1
+then:
+  required:
+    - clocks
+    - clock-names
+    - clock-output-names
+    - '#clock-cells'
+else:
+  properties:
+    clocks: false
+    clock-names: false
+    clock-output-names: false
+    '#clock-cells': false
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
2.36.1


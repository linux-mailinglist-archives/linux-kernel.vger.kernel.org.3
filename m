Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7EE4C563E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiBZNx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiBZNxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:53:17 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B1A4D24B;
        Sat, 26 Feb 2022 05:52:42 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cm8so11144489edb.3;
        Sat, 26 Feb 2022 05:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YCt9c/WuqfeK1V8ITXi9o4SIK/apj8BwIP8ElbF2qwQ=;
        b=MQ0zXot/amDVyTfUC/LxEWDtR1MSnVHjtRhaacKr/vWf4+d19k+rOrgIckIx4Yt9rx
         rGX/KsxbvzawdVv5TVU2Qa7xyyopjs5qe2kWPeEfjN0uXB6vdlbn4c74wnuWZq9F/OtW
         qu3N5WXGUM0T0F9pgCn5NWJfS5t+EGFS9Sylrs305ORH/u+XmEH8Nl60Bxy4KybICwF6
         kFweM4GVIK81gCMDV+Xt1XH9fMZ8AXsfIvK+fgOo7e665FTHOnjs2xcZW/VHw+IajK0T
         vd556AhsHg+iVc2X4CkXy/bmRuCpjNBx3/RiEQ1bL8YI6Ufg/IN2BtSZfPUdifcg82z0
         MYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCt9c/WuqfeK1V8ITXi9o4SIK/apj8BwIP8ElbF2qwQ=;
        b=eIkR5Pp07RNuNXx+5WnFF93DEZ3FS5NWYEfrDIDAuDfvHoWsZolAiJYWSRzayvd2w3
         +ozOhrWy53UP5xiE77DTCo5qaLJ3DnSsR1J7WtSV/qJuOT5wqCh1j1RTYAWH5mosUyLe
         G/8J/BwBNunf5HordwO7fppZBdQYtaSF3sfDxyoXREJcjt2yH8u5n2ojBs37TnAgZ9GS
         YcVyAOb9WBRAlHqNgoOtB6ZONaGOLvUcMZjUPmu1Rb6TfDaSYBYfrAQjCSBUR/hMKbCW
         0nXpplGx5grdg67ZNA/n+LDZZDHvSFqk1lSczC29F8PP8UeuZDyyQ9tpKyF2LKKrBlmG
         PfaA==
X-Gm-Message-State: AOAM532zkVYVzArBsyP6B3P5SY2DtjAfdZ9iWtFZns4fJSMTo8Xbvexo
        Me/JBtS0V0r8+3uk6zTRICc=
X-Google-Smtp-Source: ABdhPJz2UGTvCeUzeUhcTCqmsi+9paQ2RFXAT8gwmiKvmtwgN/8I9PkQIg8onL0u0m6bHi6ro1rqGg==
X-Received: by 2002:a05:6402:268a:b0:410:cc67:e792 with SMTP id w10-20020a056402268a00b00410cc67e792mr11472140edd.218.1645883560792;
        Sat, 26 Feb 2022 05:52:40 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-95-251-226-220.retail.telecomitalia.it. [95.251.226.220])
        by smtp.googlemail.com with ESMTPSA id j21-20020aa7c415000000b004127ac9ddc3sm2836369edq.50.2022.02.26.05.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 05:52:40 -0800 (PST)
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
Subject: [PATCH v6 03/15] dt-bindings: clock: document qcom,gcc-ipq8064 binding
Date:   Sat, 26 Feb 2022 14:52:23 +0100
Message-Id: <20220226135235.10051-4-ansuelsmth@gmail.com>
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

Document qcom,gcc-ipq8064 binding needed to declare pxo and cxo source
clocks. The gcc node is also used by the tsens driver, already documented,
to get the calib nvmem cells and the base reg from gcc. Use
qcom,gcc.yaml as a template and remove the compatible from
generic qcom,gcc-other.yaml

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 .../bindings/clock/qcom,gcc-ipq8064.yaml      | 76 +++++++++++++++++++
 .../bindings/clock/qcom,gcc-other.yaml        |  3 -
 2 files changed, 76 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
new file mode 100644
index 000000000000..9eb91dd22557
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-ipq8064.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller Binding for IPQ8064
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  Qualcomm global clock control module which supports the clocks, resets and
+  power domains on IPQ8064.
+
+  See also:
+  - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
+  - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
+
+properties:
+  compatible:
+    items:
+      - const: qcom,gcc-ipq8064
+      - const: syscon
+
+  clocks:
+    items:
+      - description: PXO source
+      - description: CXO source
+
+  clock-names:
+    items:
+      - const: pxo
+      - const: cxo
+
+  thermal-sensor:
+    type: object
+
+    allOf:
+      - $ref: /schemas/thermal/qcom-tsens.yaml#
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gcc: clock-controller@900000 {
+      compatible = "qcom,gcc-ipq8064", "syscon";
+      reg = <0x00900000 0x4000>;
+      clocks = <&pxo_board>, <&cxo_board>;
+      clock-names = "pxo", "cxo";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+
+      tsens: thermal-sensor {
+        compatible = "qcom,ipq8064-tsens";
+
+        nvmem-cells = <&tsens_calib>, <&tsens_calib_backup>;
+        nvmem-cell-names = "calib", "calib_backup";
+        interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "uplow";
+
+        #qcom,sensors = <11>;
+        #thermal-sensor-cells = <1>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
index 47e1c5332d76..4dc0274dbd6b 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
@@ -18,8 +18,6 @@ description:
   - dt-bindings/clock/qcom,gcc-ipq4019.h
   - dt-bindings/clock/qcom,gcc-ipq6018.h
   - dt-bindings/reset/qcom,gcc-ipq6018.h
-  - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
-  - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
   - dt-bindings/clock/qcom,gcc-msm8939.h
   - dt-bindings/clock/qcom,gcc-msm8953.h
   - dt-bindings/reset/qcom,gcc-msm8939.h
@@ -40,7 +38,6 @@ properties:
     enum:
       - qcom,gcc-ipq4019
       - qcom,gcc-ipq6018
-      - qcom,gcc-ipq8064
       - qcom,gcc-mdm9607
       - qcom,gcc-msm8226
       - qcom,gcc-msm8660
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9B6598747
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbiHRPVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344309AbiHRPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:20:57 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7023165653;
        Thu, 18 Aug 2022 08:20:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s9so2020258ljs.6;
        Thu, 18 Aug 2022 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=q2XLcyt3tzP00pg88Mw/OrtWwfeDykowFDlLq96odSU=;
        b=ZLwb0fCxjRUQE0GOvA6jYjue9fJ5zfaHkqFoJq65L6/14KRAlR2oqtG12sJTFmLxG/
         n3SccAhhsXHaBr/mvntZigqI2zQSx0BoQUYvKtt1IIgH4T4Jod0Mm3FwqTzZuSSEEA06
         zFIULSbxbAas0f6O5U1zYaPq6hznt5sUIq6FObkT3jf3/ZLEvtGqAAEFrZMy/AEODLnz
         rtq10+ewuqjuCzYIHiEEyVIRcjMc+FuJCL8S5mz0596QhnCVwxzZR1Nga/OjDa8sw7NJ
         Wl5zDP7wjeFxxaVCpV+5cJPt0mj/Rhcu8Sj1ZipJCQBT3CFkDthFfvIfzymoZiCYXGVg
         XXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=q2XLcyt3tzP00pg88Mw/OrtWwfeDykowFDlLq96odSU=;
        b=AHeZGv/7MnEHqguwBoVZQHkJSpiagQ79m6swhiCpkiRubFGcyPQgLaC5OCsnfKTUc4
         sPePqHDJzF9p9bNsVzUtiarCju1PJGiHROYfX4P3maU/nq8m3qKcJ4/Qg/M0XpHbXD71
         6V40V1WK9FGBpcc64YyTXzYSvxs4dtDRaj0XtBh53vkFJUak7J9zP8kTRge1lknpCmlx
         QsS9CaXfkzYfcPmbUEe5h7GGS9N0TI9jDxEUFNIQTiTyiHT3Qdya6IbiYIIiEZ/1pjyw
         Vcd/eeKkJLab2WZjZNP7brw728fiTmUDPuGwa0a3BNIFCp2ncVFE9ihfMnmIWUYyFlTH
         J0aw==
X-Gm-Message-State: ACgBeo1W6SVPY0e4+qh20N7KWItYTvRwkPTg8O/ZniUckFXP0SOqWrhE
        zhg7Ghn5gRmIOdyIdL9c9TbiiRU4Bd0=
X-Google-Smtp-Source: AA6agR5WCAeK2OZPxOyTrn6j3xfP+QpajM9LzEC6ge8tLBPKZ8wKP2kI1Gcbww4mRN0BDpO3UI3VTw==
X-Received: by 2002:a05:651c:1695:b0:261:b5d4:371a with SMTP id bd21-20020a05651c169500b00261b5d4371amr584288ljb.154.1660836053539;
        Thu, 18 Aug 2022 08:20:53 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id p8-20020a2eba08000000b0025df5f38da8sm263859lja.119.2022.08.18.08.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:20:53 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: clock: add QCOM SM6115 display clock bindings
Date:   Thu, 18 Aug 2022 17:18:20 +0200
Message-Id: <20220818151850.19917-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818151850.19917-1-a39.skl@gmail.com>
References: <20220818151850.19917-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for display clock controller for
Qualcomm Technology Inc's SM6115 SoC.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 .../bindings/clock/qcom,dispcc-sm6115.yaml    | 88 +++++++++++++++++++
 .../dt-bindings/clock/qcom,dispcc-sm6115.h    | 36 ++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6115.yaml
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6115.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6115.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6115.yaml
new file mode 100644
index 000000000000..2b9671112934
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6115.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,dispcc-sm6115.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock Controller Binding for SM6115
+
+maintainers:
+  - Taniya Das <tdas@codeaurora.org>
+
+description: |
+  Qualcomm display clock control module which supports the clocks and
+  power domains on SM6115.
+
+  See also:
+    dt-bindings/clock/qcom,dispcc-sm6115.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm6115-dispcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Byte clock from DSI PHY0
+      - description: Pixel clock from DSI PHY0
+      - description: GPLL0 clock from GCC
+      - description: GPLL0 div clock from GCC
+      - description: Board sleep clock
+
+  clock-names:
+    items:
+      - const: bi_tcxo
+      - const: dsi0_phy_pll_out_byteclk
+      - const: dsi0_phy_pll_out_dsiclk
+      - const: gcc_disp_gpll0_clk_src
+      - const: gcc_disp_gpll0_div_clk_src
+      - const: sleep_clk
+
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
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/clock/qcom,gcc-sm6115.h>
+    clock-controller@5f00000 {
+      compatible = "qcom,sm6115-dispcc";
+      reg = <0x5f00000 0x20000>;
+      clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+               <&dsi0_phy 0>,
+               <&dsi0_phy 1>,
+               <&gcc GCC_DISP_GPLL0_CLK_SRC>,
+               <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>,
+               <&sleep_clk>;
+      clock-names = "bi_tcxo",
+                    "dsi0_phy_pll_out_byteclk",
+                    "dsi0_phy_pll_out_dsiclk",
+                    "gcc_disp_gpll0_clk_src",
+                    "gcc_disp_gpll0_div_clk_src",
+                    "sleep_clk";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,dispcc-sm6115.h b/include/dt-bindings/clock/qcom,dispcc-sm6115.h
new file mode 100644
index 000000000000..d1a6c45b5029
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,dispcc-sm6115.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_SM6115_H
+#define _DT_BINDINGS_CLK_QCOM_DISP_CC_SM6115_H
+
+/* DISP_CC clocks */
+#define DISP_CC_PLL0			0
+#define DISP_CC_PLL0_OUT_MAIN		1
+#define DISP_CC_MDSS_AHB_CLK		2
+#define DISP_CC_MDSS_AHB_CLK_SRC	3
+#define DISP_CC_MDSS_BYTE0_CLK		4
+#define DISP_CC_MDSS_BYTE0_CLK_SRC	5
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC	6
+#define DISP_CC_MDSS_BYTE0_INTF_CLK	7
+#define DISP_CC_MDSS_ESC0_CLK		8
+#define DISP_CC_MDSS_ESC0_CLK_SRC	9
+#define DISP_CC_MDSS_MDP_CLK		10
+#define DISP_CC_MDSS_MDP_CLK_SRC	11
+#define DISP_CC_MDSS_MDP_LUT_CLK	12
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK	13
+#define DISP_CC_MDSS_PCLK0_CLK		14
+#define DISP_CC_MDSS_PCLK0_CLK_SRC	15
+#define DISP_CC_MDSS_ROT_CLK		16
+#define DISP_CC_MDSS_ROT_CLK_SRC	17
+#define DISP_CC_MDSS_VSYNC_CLK		18
+#define DISP_CC_MDSS_VSYNC_CLK_SRC	19
+#define DISP_CC_SLEEP_CLK		20
+#define DISP_CC_SLEEP_CLK_SRC		21
+
+/* DISP_CC GDSCR */
+#define MDSS_GDSC			0
+
+#endif
-- 
2.25.1


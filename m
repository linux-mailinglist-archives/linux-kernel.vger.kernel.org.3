Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A5B59A704
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350918AbiHSUN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350436AbiHSUNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:13:20 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B69A474;
        Fri, 19 Aug 2022 13:13:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m3so1799927lfg.10;
        Fri, 19 Aug 2022 13:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZnBAI4bHDwuRaycfcS/jwb7PASSKuVJbrNRnbDO6Imk=;
        b=hdIW/dpx9v0ZXLlLFBtw7HjgPLoLlk6V0+LWSltRv800HDnJqp483lc7fFnhgk+F6H
         mLXFxEolhFwCTjb4TysviWLACUIPPtThQXX6xV2N0V1ZSVhyXP0rRkV5NkL2eICS2NG3
         1yEZfYClzEpJlOQ2RrDr9rVnqpcKYUCYINPetsilMIQbAsonCh4ch4g55LayX7kIMRk/
         3MG2zI7u3BqKAPylrnFEj7LYcv2ICRA7zhhMHcN+40dAZQGgf9MtCTv2hwhsS80ML6Yl
         U8hDmNjz2E0RrTNQH+PL+2ol/QHxLbE6VEYy7I/U97m+BaFahikcI5XxIA3fogXycafj
         SK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZnBAI4bHDwuRaycfcS/jwb7PASSKuVJbrNRnbDO6Imk=;
        b=aMsSraq7NgshPQcTYYl4H2Z532Hb9c7E6PbtIlMc1D0O10ntWpwwl06w+VRv3tZwFW
         kXX1nDQ3d3dTLEYrW+9x3ViNCTb0or2JoCnjsY/aA9oUBvQKA35BJ3zNneY6ceG6ZC9z
         SRUflSb9rTASzwevJ9ssWv1d9A7m/KIrW3+hRHHL8X2nHBoEuWnvrFnNXHl+ld2aQr0I
         3m1H9WnWNU3AVKNlPJQMBJf0fyiarzj8C4DUJU7VR5O0Lygz9M3TuhaOjBceXMWgk1D1
         JvUYPV+v4xG1wUHaRqMv5RsjwJGdAiO0a9SC8zKYtWbfbWroBBveTazCa792OnZpmZdy
         o3ow==
X-Gm-Message-State: ACgBeo2XVZwqoQRKDco+itWXUGAvxaFChNzP3Q/myDV5jheyJZ1k3X1b
        Y0ZpwCixcNWAHo4e9tjPcdM8UCgWy1k=
X-Google-Smtp-Source: AA6agR6Es0q8FY+8lXsaBH2MdyBsM7WIMJqXFIPB3+T59TtCjZGRFK91aNahgmzW/P+hxTmF6abCZA==
X-Received: by 2002:a05:6512:1399:b0:486:2ae5:be71 with SMTP id p25-20020a056512139900b004862ae5be71mr2856878lfa.246.1660939995938;
        Fri, 19 Aug 2022 13:13:15 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id h25-20020ac250d9000000b004916f129729sm753895lfm.50.2022.08.19.13.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:13:15 -0700 (PDT)
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
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: clock: add QCOM SM6115 display clock bindings
Date:   Fri, 19 Aug 2022 22:12:21 +0200
Message-Id: <20220819201231.23474-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819201231.23474-1-a39.skl@gmail.com>
References: <20220819201231.23474-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../bindings/clock/qcom,sm6115-dispcc.yaml    | 88 +++++++++++++++++++
 .../dt-bindings/clock/qcom,sm6115-dispcc.h    | 36 ++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm6115-dispcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
new file mode 100644
index 000000000000..c9b97281171c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm6115-dispcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock Controller Binding for SM6115
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: |
+  Qualcomm display clock control module which supports the clocks and
+  power domains on SM6115.
+
+  See also:
+    dt-bindings/clock/qcom,sm6115-dispcc.h
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
diff --git a/include/dt-bindings/clock/qcom,sm6115-dispcc.h b/include/dt-bindings/clock/qcom,sm6115-dispcc.h
new file mode 100644
index 000000000000..d1a6c45b5029
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm6115-dispcc.h
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


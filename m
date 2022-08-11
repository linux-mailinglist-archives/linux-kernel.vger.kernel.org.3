Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C7958F6A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 06:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiHKEJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 00:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHKEJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:09:43 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F250488DC0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:09:36 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u14so11923682oie.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KoSqt9eCSwhfFC2EdVN/ENhO6I7ktE7Afb4kvBzUv8U=;
        b=KGJY0q7I+gKaHTRi+E690HI02W/pzEPNN1FC7/iznxb136gXX9JE/QrXv2XcdbEqVi
         bGp6pDKsO9/AYx0I8Vahi4WHwaVNEOXgzlotqpVlIDdI5/oNVrtCMpqpISXRVyoWYXxB
         OH/QLreZ/eoe6pCU1xK8qSLYg9n4DqFQqXV2W/kK38ln6lMatM9hR5U0CHpyCVq2grOv
         kOaEMwzy5dvQshAdjXnC2LfucT/lvDla8lEHYcCbpcTDqGjBigkXZg8j4O28L3V7MkA0
         2UleTy3F0pgoNuDG+tXplyp3QZK5macW8T0X5zLD9aPNVqUtvNnVQYLiBjn3ZnzAZlEf
         XXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KoSqt9eCSwhfFC2EdVN/ENhO6I7ktE7Afb4kvBzUv8U=;
        b=TA55MVsaVGkqYdhIBSh/y5HI5/L1qJok5oA1RRIcqqgKOgrcWa4byUgsQpD9Ux7f7y
         eDBh1AOvwqPxV+MRiELFs5DYH/CSWlV0wEhbqq0Pkh9cYZ13sc35e+bcfmQYuGAFEExC
         OwZdQQ2MTNdjmSOIvQm0RIwLisLdVkKoMVWbSDq5lgDsMQ+7OOm84flS8BJR0HX2L8Sz
         rOkMuEouHp2AdEvBUbwP4AoXIpbvnNI2qljS6i/OVyAQJ9CknAbVpSNaoCSUT+Utav2p
         DmR/AUOdXwsOZ+ddGNP+be77rJ1UoQ02CvQVfkmu97McT5/2/wTchh446zFPb9YQmr0g
         eWiA==
X-Gm-Message-State: ACgBeo2UbFKm6FCA/ZGoXrMTbd+Bo/JKLVq+Yzyjw1bX8OYV84QBOSfC
        VMykFzEiYAixzUVd/IwK8EoIdA==
X-Google-Smtp-Source: AA6agR6nuNyve3yR6N5UnKujM6sdtMO7gDAO6D6K1Fs5QfKufL/9sxjah0dXXJ/NDfTpNZZB4vGz9A==
X-Received: by 2002:aca:5e84:0:b0:342:d6b5:f434 with SMTP id s126-20020aca5e84000000b00342d6b5f434mr2604302oib.265.1660190976269;
        Wed, 10 Aug 2022 21:09:36 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z9-20020a056870738900b0010eaeee89a1sm4111321oam.46.2022.08.10.21.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 21:09:35 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: clock: Add Qualcomm SC8280XP display clock bindings
Date:   Wed, 10 Aug 2022 21:12:10 -0700
Message-Id: <20220811041211.3825786-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811041211.3825786-1-bjorn.andersson@linaro.org>
References: <20220811041211.3825786-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SC8280XP platform has two display clock controllers, add a
binding for these.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../bindings/clock/qcom,dispcc-sc8280xp.yaml  |  98 +++++++++++++++++
 .../dt-bindings/clock/qcom,dispcc-sc8280xp.h  | 100 ++++++++++++++++++
 2 files changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sc8280xp.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
new file mode 100644
index 000000000000..98e5dfd53f76
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,dispcc-sc8280xp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock & Reset Controller Binding for SC8280XP
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: |
+  Qualcomm display clock control module which supports the clocks, resets and
+  power domains for the two MDSS instances on SC8280XP.
+
+  See also:
+    include/dt-bindings/clock/qcom,dispcc-sc8280xp.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc8280x-dispcc0
+      - qcom,sc8280x-dispcc1
+
+  clocks:
+    items:
+      - description: AHB interface clock,
+      - description: SoC CXO clock
+      - description: SoC sleep clock
+      - description: DisplayPort 0 link clock
+      - description: DisplayPort 0 VCO div clock
+      - description: DisplayPort 1 link clock
+      - description: DisplayPort 1 VCO div clock
+      - description: DisplayPort 2 link clock
+      - description: DisplayPort 2 VCO div clock
+      - description: DisplayPort 3 link clock
+      - description: DisplayPort 3 VCO div clock
+      - description: DSI 0 PLL byte clock
+      - description: DSI 0 PLL DSI clock
+      - description: DSI 1 PLL byte clock
+      - description: DSI 1 PLL DSI clock
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
+  power-domains:
+    description:
+      A phandle and PM domain specifier for the MMCX power domain.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    clock-controller@af00000 {
+      compatible = "qcom,sc8280xp-dispcc0";
+      reg = <0x0af00000 0x20000>;
+      clocks = <&gcc GCC_DISP_AHB_CLK>,
+               <&rpmhcc RPMH_CXO_CLK>,
+               <&sleep_clk>,
+               <&mdss0_dp_phy0 0>,
+               <&mdss0_dp_phy0 1>,
+               <&mdss0_dp_phy1 0>,
+               <&mdss0_dp_phy1 1>,
+               <&mdss0_dp_phy2 0>,
+               <&mdss0_dp_phy2 1>,
+               <&mdss0_dp_phy3 0>,
+               <&mdss0_dp_phy3 1>,
+               <&mdss0_dsi0_phy 0>,
+               <&mdss0_dsi0_phy 1>,
+               <&mdss0_dsi1_phy 0>,
+               <&mdss0_dsi1_phy 1>;
+      power-domains = <&rpmhpd SC8280XP_MMCX>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,dispcc-sc8280xp.h b/include/dt-bindings/clock/qcom,dispcc-sc8280xp.h
new file mode 100644
index 000000000000..2831c61fa979
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,dispcc-sc8280xp.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_SC8280XP_H
+#define _DT_BINDINGS_CLK_QCOM_DISP_CC_SC8280XP_H
+
+/* DISPCC clocks */
+#define DISP_CC_PLL0					0
+#define DISP_CC_PLL1					1
+#define DISP_CC_PLL1_OUT_EVEN				2
+#define DISP_CC_PLL2					3
+#define DISP_CC_MDSS_AHB1_CLK				4
+#define DISP_CC_MDSS_AHB_CLK				5
+#define DISP_CC_MDSS_AHB_CLK_SRC			6
+#define DISP_CC_MDSS_BYTE0_CLK				7
+#define DISP_CC_MDSS_BYTE0_CLK_SRC			8
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC			9
+#define DISP_CC_MDSS_BYTE0_INTF_CLK			10
+#define DISP_CC_MDSS_BYTE1_CLK				11
+#define DISP_CC_MDSS_BYTE1_CLK_SRC			12
+#define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC			13
+#define DISP_CC_MDSS_BYTE1_INTF_CLK			14
+#define DISP_CC_MDSS_DPTX0_AUX_CLK			15
+#define DISP_CC_MDSS_DPTX0_AUX_CLK_SRC			16
+#define DISP_CC_MDSS_DPTX0_LINK_CLK			17
+#define DISP_CC_MDSS_DPTX0_LINK_CLK_SRC			18
+#define DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC		19
+#define DISP_CC_MDSS_DPTX0_LINK_INTF_CLK		20
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK			21
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC		22
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK			23
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC		24
+#define DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK	25
+#define DISP_CC_MDSS_DPTX1_AUX_CLK			26
+#define DISP_CC_MDSS_DPTX1_AUX_CLK_SRC			27
+#define DISP_CC_MDSS_DPTX1_LINK_CLK			28
+#define DISP_CC_MDSS_DPTX1_LINK_CLK_SRC			29
+#define DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC		30
+#define DISP_CC_MDSS_DPTX1_LINK_INTF_CLK		31
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK			32
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC		33
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK			34
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC		35
+#define DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK	36
+#define DISP_CC_MDSS_DPTX2_AUX_CLK			37
+#define DISP_CC_MDSS_DPTX2_AUX_CLK_SRC			38
+#define DISP_CC_MDSS_DPTX2_LINK_CLK			39
+#define DISP_CC_MDSS_DPTX2_LINK_CLK_SRC			40
+#define DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC		41
+#define DISP_CC_MDSS_DPTX2_LINK_INTF_CLK		42
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK			43
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC		44
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK			45
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC		46
+#define DISP_CC_MDSS_DPTX3_AUX_CLK			47
+#define DISP_CC_MDSS_DPTX3_AUX_CLK_SRC			48
+#define DISP_CC_MDSS_DPTX3_LINK_CLK			49
+#define DISP_CC_MDSS_DPTX3_LINK_CLK_SRC			50
+#define DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC		51
+#define DISP_CC_MDSS_DPTX3_LINK_INTF_CLK		52
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK			53
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC		54
+#define DISP_CC_MDSS_ESC0_CLK				55
+#define DISP_CC_MDSS_ESC0_CLK_SRC			56
+#define DISP_CC_MDSS_ESC1_CLK				57
+#define DISP_CC_MDSS_ESC1_CLK_SRC			58
+#define DISP_CC_MDSS_MDP1_CLK				59
+#define DISP_CC_MDSS_MDP_CLK				60
+#define DISP_CC_MDSS_MDP_CLK_SRC			61
+#define DISP_CC_MDSS_MDP_LUT1_CLK			62
+#define DISP_CC_MDSS_MDP_LUT_CLK			63
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK			64
+#define DISP_CC_MDSS_PCLK0_CLK				65
+#define DISP_CC_MDSS_PCLK0_CLK_SRC			66
+#define DISP_CC_MDSS_PCLK1_CLK				67
+#define DISP_CC_MDSS_PCLK1_CLK_SRC			68
+#define DISP_CC_MDSS_ROT1_CLK				69
+#define DISP_CC_MDSS_ROT_CLK				70
+#define DISP_CC_MDSS_ROT_CLK_SRC			71
+#define DISP_CC_MDSS_RSCC_AHB_CLK			72
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK			73
+#define DISP_CC_MDSS_VSYNC1_CLK				74
+#define DISP_CC_MDSS_VSYNC_CLK				75
+#define DISP_CC_MDSS_VSYNC_CLK_SRC			76
+#define DISP_CC_SLEEP_CLK				77
+#define DISP_CC_SLEEP_CLK_SRC				78
+#define DISP_CC_XO_CLK					79
+#define DISP_CC_XO_CLK_SRC				80
+
+/* DISPCC resets */
+#define DISP_CC_MDSS_CORE_BCR				0
+#define DISP_CC_MDSS_RSCC_BCR				1
+
+/* DISPCC GDSCs */
+#define MDSS_GDSC					0
+#define MDSS_INT2_GDSC					1
+
+#endif
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074F158F688
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 05:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiHKD6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 23:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiHKD6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 23:58:50 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEF383F27
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 20:58:47 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id q184so20044937oif.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 20:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=W/Ddv3FILaw5kcUD3MzHcpXXotpPc2TE/jad5ETUSuM=;
        b=cUwl8twTqYs/ew9sdT3ULDGEmiDGjv97A+o5Dp3uk3glhVxXP5H7+tiQJel2pQbBzY
         +eIHdQUDm/Fk01osvE2rIePFAwIVLN6NQENxUMm1P410V7p6/MIQb0X1cOC8x2nfGkX1
         u5ouO+IccIFz/MfaE1gZTp2ly1+oMAiRCZVLWdjQa4J7gxrCBLwpeCtd96jqtz2yc6Yt
         A2J3vg/WlVtcvF9Bg8bwvaAEw4y+JJE+k8CFX91QuqzGlRz+LZh/5ovk1U0lS5uryQBf
         yvt2XVgmcV7367e14/bcpm7J+Uw70eFaTq8YI995sPZhq8D7C1dHu8hXmqhly3Mv19y1
         4AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=W/Ddv3FILaw5kcUD3MzHcpXXotpPc2TE/jad5ETUSuM=;
        b=xUKg9NP0Hk/cdU68GjsA12ZEK0SDkmbRuWSupM5JfROon3z56WhGMtdKJ4A2AJgZEw
         yISk6I72wj3nvX5fwYB71jBa90ik6iy53q0R4+YF4kn2YFL70TOv/bzG6Mt2y/c12a5Y
         L20aiS8jeYtXMBNxlWFb+6wZwC1Roi2rGpgk4QGaZ+9bgDXLcoJgBbFlkzrVqzppTZ/e
         Yol1rQxoH1T3lIyBCTTIRhj+j8Txt7tC2PqnE83iIpnVEN4DZTU34xepgFdHMzLg65OQ
         mS1Ogj7Avs7L00XL9rUvBGaExx1ZpfwJB3XutWIi4kRzC4S7XO9XUADHSrqa2b90+qUr
         t8sQ==
X-Gm-Message-State: ACgBeo3AquX43MVeLUzY2HXxVeQMZR2cNwAg77ZVwhGqceHaUvjxeg7z
        zK3/ykKD8CEvpoyXqgH4y+FPaA==
X-Google-Smtp-Source: AA6agR4Bivj+6SyN7gYcv9JGlrUXaDqXqgBvYMIom0ezxOmJPpuIcHoZGl3zZJaCiacFxTRvdVAV/w==
X-Received: by 2002:a05:6808:30a8:b0:343:538c:33ef with SMTP id bl40-20020a05680830a800b00343538c33efmr228693oib.91.1660190326462;
        Wed, 10 Aug 2022 20:58:46 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w22-20020a056808141600b00338869042fdsm891443oiv.32.2022.08.10.20.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 20:58:45 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: display/msm: Add binding for SC8280XP MDSS
Date:   Wed, 10 Aug 2022 21:01:19 -0700
Message-Id: <20220811040121.3775613-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811040121.3775613-1-bjorn.andersson@linaro.org>
References: <20220811040121.3775613-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the display subsystem and display processing unit in the
Qualcomm SC8280XP platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../bindings/display/msm/dpu-sc8280xp.yaml    | 284 ++++++++++++++++++
 1 file changed, 284 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml

diff --git a/Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml b/Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml
new file mode 100644
index 000000000000..6c25943e639c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml
@@ -0,0 +1,284 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/dpu-sc8280xp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Processing Unit for SC8280XP
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  Device tree bindings for MSM Mobile Display Subsystem (MDSS) that encapsulates
+  sub-blocks like DPU display controller, DSI and DP interfaces etc. Device tree
+  bindings of MDSS and DPU are mentioned for SC8280XP.
+
+properties:
+  compatible:
+    const: qcom,sc8280xp-mdss
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    const: mdss
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Display AHB clock from gcc
+      - description: Display AHB clock from dispcc
+      - description: Display core clock
+
+  clock-names:
+    items:
+      - const: iface
+      - const: ahb
+      - const: core
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+  "#interrupt-cells":
+    const: 1
+
+  iommus:
+    items:
+      - description: Phandle to apps_smmu node with SID mask for Hard-Fail port0
+
+  ranges: true
+
+  interconnects:
+    minItems: 2
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: mdp0-mem
+      - const: mdp1-mem
+
+  resets:
+    items:
+      - description: MDSS_CORE reset
+
+patternProperties:
+  "^display-controller@[0-9a-f]+$":
+    type: object
+    description: Node containing the properties of DPU.
+
+    properties:
+      compatible:
+        const: qcom,sc8280xp-dpu
+
+      reg:
+        items:
+          - description: Address offset and size for mdp register set
+          - description: Address offset and size for vbif register set
+
+      reg-names:
+        items:
+          - const: mdp
+          - const: vbif
+
+      clocks:
+        items:
+          - description: Display hf axi clock
+          - description: Display sf axi clock
+          - description: Display ahb clock
+          - description: Display lut clock
+          - description: Display core clock
+          - description: Display vsync clock
+
+      clock-names:
+        items:
+          - const: bus
+          - const: nrt_bus
+          - const: iface
+          - const: lut
+          - const: core
+          - const: vsync
+
+      interrupts:
+        maxItems: 1
+
+      power-domains:
+        maxItems: 1
+
+      operating-points-v2: true
+
+      ports:
+        $ref: /schemas/graph.yaml#/properties/ports
+        description: |
+          Contains the list of output ports from DPU device. These ports
+          connect to interfaces that are external to the DPU hardware,
+          such as DSI, DP etc. Each output port contains an endpoint that
+          describes how it is connected to an external interface.
+
+        patternProperties:
+          '^port@[0-8]$':
+            $ref: /schemas/graph.yaml#/properties/port
+            description: DPU interfaces
+
+    required:
+      - compatible
+      - reg
+      - reg-names
+      - clocks
+      - interrupts
+      - power-domains
+      - operating-points-v2
+      - ports
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - power-domains
+  - clocks
+  - interrupts
+  - interrupt-controller
+  - iommus
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
+    #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interconnect/qcom,sc8280xp.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    display-subsystem@ae00000 {
+      compatible = "qcom,sc8280xp-mdss";
+      reg = <0x0ae00000 0x1000>;
+      reg-names = "mdss";
+
+      power-domains = <&dispcc0 MDSS_GDSC>;
+
+      clocks = <&gcc GCC_DISP_AHB_CLK>,
+               <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
+               <&dispcc0 DISP_CC_MDSS_MDP_CLK>;
+      clock-names = "iface",
+                    "ahb",
+                    "core";
+
+      assigned-clocks = <&dispcc0 DISP_CC_MDSS_MDP_CLK>;
+      assigned-clock-rates = <460000000>;
+
+      resets = <&dispcc0 DISP_CC_MDSS_CORE_BCR>;
+
+      interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+
+      interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>,
+                      <&mmss_noc MASTER_MDP1 0 &mc_virt SLAVE_EBI1 0>;
+      interconnect-names = "mdp0-mem", "mdp1-mem";
+
+      iommus = <&apps_smmu 0x1000 0x402>;
+
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+
+      display-controller@ae01000 {
+        compatible = "qcom,sc8280xp-dpu";
+        reg = <0x0ae01000 0x8f000>,
+              <0x0aeb0000 0x2008>;
+        reg-names = "mdp", "vbif";
+
+        clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+                 <&gcc GCC_DISP_SF_AXI_CLK>,
+                 <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
+                 <&dispcc0 DISP_CC_MDSS_MDP_LUT_CLK>,
+                 <&dispcc0 DISP_CC_MDSS_MDP_CLK>,
+                 <&dispcc0 DISP_CC_MDSS_VSYNC_CLK>;
+        clock-names = "bus",
+                      "nrt_bus",
+                      "iface",
+                      "lut",
+                      "core",
+                      "vsync";
+
+        assigned-clocks = <&dispcc0 DISP_CC_MDSS_MDP_CLK>,
+                          <&dispcc0 DISP_CC_MDSS_VSYNC_CLK>;
+        assigned-clock-rates = <460000000>,
+                               <19200000>;
+
+        operating-points-v2 = <&mdss0_mdp_opp_table>;
+        power-domains = <&rpmhpd SC8280XP_MMCX>;
+
+        interrupt-parent = <&mdss0>;
+        interrupts = <0>;
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+              endpoint {
+                remote-endpoint = <&mdss0_dp0_in>;
+              };
+          };
+
+          port@4 {
+            reg = <4>;
+            endpoint {
+              remote-endpoint = <&mdss0_dp1_in>;
+            };
+          };
+
+          port@5 {
+            reg = <5>;
+              endpoint {
+                remote-endpoint = <&mdss0_dp3_in>;
+              };
+          };
+
+          port@6 {
+            reg = <6>;
+              endpoint {
+                remote-endpoint = <&mdss0_dp2_in>;
+              };
+          };
+        };
+
+        mdss0_mdp_opp_table: opp-table {
+          compatible = "operating-points-v2";
+
+          opp-200000000 {
+            opp-hz = /bits/ 64 <200000000>;
+            required-opps = <&rpmhpd_opp_low_svs>;
+          };
+
+          opp-300000000 {
+            opp-hz = /bits/ 64 <300000000>;
+            required-opps = <&rpmhpd_opp_svs>;
+          };
+
+          opp-345000000 {
+            opp-hz = /bits/ 64 <345000000>;
+            required-opps = <&rpmhpd_opp_svs_l1>;
+          };
+
+          opp-460000000 {
+            opp-hz = /bits/ 64 <460000000>;
+            required-opps = <&rpmhpd_opp_nom>;
+          };
+        };
+      };
+    };
+...
+
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ADD4E759D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359457AbiCYPDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244579AbiCYPD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:03:29 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC4A954B8;
        Fri, 25 Mar 2022 08:01:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b24so9546587edu.10;
        Fri, 25 Mar 2022 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANMaiNS+tsFPctCqYM7KG7s3uQ7H+7+M41RZf3QmwQw=;
        b=Zb8YJdLbsmUBPPOglHtnDhCB7mEIlgPslESZhBkCjEeHxAAE1DnFP3KFn/UgPgebDm
         XaBJbuhCiLkLxG9Rtn1DsE5KnwMx5DeQABb1hV2JqGa0dOadKyVG6IOj4Cb8QsCuLGmP
         zGa65rlUzK+0gSpiR7COruu8RSHG9a33cLKgX6ihrwehY92naYONPCJHucQwWDv33N8Z
         OaVi+TMeKwrslLWvRbFipT3j5El/BC6fMY34G2OiYt0iTR9YUXT/rC63H/+yWscmGYqk
         Eg3Yzxo8+qFWNDt4X+l0CzBn82tPPMgFVj+D7RbXCEz9EezX7KolyPQ0tfM+q7TOSYF9
         eDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANMaiNS+tsFPctCqYM7KG7s3uQ7H+7+M41RZf3QmwQw=;
        b=YCJI+R3PJWJyGLqwdZ/gzvCSlHr+8WITBpnezdWGmt0ZaA40+Zm72ieANHkSoR1Fbj
         GLla0M39Z6rcGxV8ZjrvZ2/dRc4MpRgp9VpfclLLB1o0AZida6bGyZk8kTrKIJw8JNrn
         xg8fZ8LEHOXtRU+9Tng3fDkiDCiFSVyJ8SdWIyy2gIJA2hmHdWP2yApGxcnPPSiuue/K
         lUcyOuLq4j1VwV/amg/k3zbYxULseGxpE30hVX9CFa6Z5jMGI49I7NLYYfabxxwc0wVG
         oilaFoqpg4XPrFJcg9wrhqToWzfCVAPEobku+bMB385zRMee7sO1x69Lzq/aMMcmiL5z
         3x3w==
X-Gm-Message-State: AOAM531WHrWVoGdL5BkzoAQKSD0NUFGmtJ7WsTSEbK95IMt09wFWaMH5
        x5u1OF7/S7jciqLdslK+bfQ=
X-Google-Smtp-Source: ABdhPJy6yOYyRZlGnUG37FK3ih1/UHdYyPKxA95erpwf4j37GXfNckTUyllGt0WI2IMCepVF43gazw==
X-Received: by 2002:aa7:cb93:0:b0:415:d57a:4603 with SMTP id r19-20020aa7cb93000000b00415d57a4603mr13503112edt.62.1648220513124;
        Fri, 25 Mar 2022 08:01:53 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w14-20020a170906d20e00b006cee22553f7sm2455714ejz.213.2022.03.25.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 08:01:52 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: clock: convert rockchip,rk3188-cru.txt to YAML
Date:   Fri, 25 Mar 2022 16:01:45 +0100
Message-Id: <20220325150146.18638-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with RK3188/RK3066 'cru' nodes are manually verified.
In order to automate this process rockchip,rk3188-cru.txt has to be
converted to YAML.

Changed:
  Add properties to fix notifications by clocks.yaml for example:
    clocks
    clock-names

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V2:
  change clocks maxItems
  add clock-names
  use clock-controller node name
  remove assigned-xxx
---
 .../bindings/clock/rockchip,rk3188-cru.txt    | 61 ---------------
 .../bindings/clock/rockchip,rk3188-cru.yaml   | 76 +++++++++++++++++++
 2 files changed, 76 insertions(+), 61 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
deleted file mode 100644
index 7f368530a..000000000
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-* Rockchip RK3188/RK3066 Clock and Reset Unit
-
-The RK3188/RK3066 clock controller generates and supplies clock to various
-controllers within the SoC and also implements a reset controller for SoC
-peripherals.
-
-Required Properties:
-
-- compatible: should be "rockchip,rk3188-cru", "rockchip,rk3188a-cru" or
-			"rockchip,rk3066a-cru"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- #clock-cells: should be 1.
-- #reset-cells: should be 1.
-
-Optional Properties:
-
-- rockchip,grf: phandle to the syscon managing the "general register files"
-  If missing pll rates are not changeable, due to the missing pll lock status.
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume. All available clocks are defined as
-preprocessor macros in the dt-bindings/clock/rk3188-cru.h and
-dt-bindings/clock/rk3066-cru.h headers and can be used in device tree sources.
-Similar macros exist for the reset sources in these files.
-
-External clocks:
-
-There are several clocks that are generated outside the SoC. It is expected
-that they are defined using standard clock bindings with following
-clock-output-names:
- - "xin24m" - crystal input - required,
- - "xin32k" - rtc clock - optional,
- - "xin27m" - 27mhz crystal input on rk3066 - optional,
- - "ext_hsadc" - external HSADC clock - optional,
- - "ext_cif0" - external camera clock - optional,
- - "ext_rmii" - external RMII clock - optional,
- - "ext_jtag" - externalJTAG clock - optional
-
-Example: Clock controller node:
-
-	cru: cru@20000000 {
-		compatible = "rockchip,rk3188-cru";
-		reg = <0x20000000 0x1000>;
-		rockchip,grf = <&grf>;
-
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-Example: UART controller node that consumes the clock generated by the clock
-  controller:
-
-	uart0: serial@10124000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x10124000 0x400>;
-		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <1>;
-		clocks = <&cru SCLK_UART0>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
new file mode 100644
index 000000000..8d2fe7982
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3188-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3188/RK3066 Clock and Reset Unit (CRU)
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The RK3188/RK3066 clock controller generates and supplies clocks to various
+  controllers within the SoC and also implements a reset controller for SoC
+  peripherals.
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All available clocks are defined as
+  preprocessor macros in the dt-bindings/clock/rk3188-cru.h and
+  dt-bindings/clock/rk3066-cru.h headers and can be used in device tree sources.
+  Similar macros exist for the reset sources in these files.
+  There are several clocks that are generated outside the SoC. It is expected
+  that they are defined using standard clock bindings with following
+  clock-output-names:
+    - "xin24m"    - crystal input                 - required
+    - "xin32k"    - RTC clock                     - optional
+    - "xin27m"    - 27mhz crystal input on RK3066 - optional
+    - "ext_hsadc" - external HSADC clock          - optional
+    - "ext_cif0"  - external camera clock         - optional
+    - "ext_rmii"  - external RMII clock           - optional
+    - "ext_jtag"  - external JTAG clock           - optional
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3066a-cru
+      - rockchip,rk3188-cru
+      - rockchip,rk3188a-cru
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: xin24m
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing the "general register files" (GRF),
+      if missing pll rates are not changeable, due to the missing pll lock status.
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    cru: clock-controller@20000000 {
+      compatible = "rockchip,rk3188-cru";
+      reg = <0x20000000 0x1000>;
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1


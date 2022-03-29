Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1794EB1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbiC2QcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239647AbiC2QcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:32:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2D22467DD;
        Tue, 29 Mar 2022 09:30:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r23so21355548edb.0;
        Tue, 29 Mar 2022 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d1S/S8hgFbgrR0O65twBXNIv5pIOQ9OSLSPFpnPfz8s=;
        b=YWWSRnIauJSl8GV+h692nAqVdl2yPxmvRjetyo7oLsUsa04Zd1Tbm/AFTmx2QohXjJ
         mjBSZAmo9VRs/Yv18bacq5PdVBLRqSq9mGg661WqYU9yALjEpTe0vMBZPDTIYwt6bFgI
         X7Lm8LTy0w6Zj4GFsFUVBXvUhzx2LsYBjiQLqUpBWVqAzqa2u9pIxILaiq4W1HZZrrsa
         LfMkVQoCS4/m4IFpVcI+W0Ag5NYX2Vx4a9Y8zXDZeDm0h2Xow+UdUu2KkNgLIdkQPOXV
         lcXeFa41lws/n7gQwk2nouWO+uXQX3bTB70+DEl3t5LIJV70fdxtbaFenoQF1eYWZUKg
         h+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d1S/S8hgFbgrR0O65twBXNIv5pIOQ9OSLSPFpnPfz8s=;
        b=noTl5JuvineVIhj6AloTgQ/OdGf43D/mXXZzG8Lr1bMY5quaGxW+VAOy1s0JbXOlyL
         bx3OUoXyotBnwApm5s3c+x74zSVHia4kyxeH5L039pY+rTe4GqMzhoWwgHfzpz9dlrT5
         ItKjivRXVfwZuR17WgGsw1kr5b9STuuxwQBBd7eJ3x6gebdJytfBhObEUPtN1IFedeSN
         jWk9NO6x/LRHWDxm92rFXJ/CjnSVthSs6tlzi3Y9jNct/B3GZlBwIF9SzpiWY8w/2lSl
         hE/a5Ji1oJkYAFXqz2HHeRdcsu5ix2H5RLt4XGHWJbVde1OSCGqaAYAGe3pv49SzqHG9
         pCpg==
X-Gm-Message-State: AOAM532qzx+S0zkQ1dK8JF7JYwxJ8bFi4j721EUaeUxZiOFHAB2wAGQc
        4RoKN5tCtjmOGVkcMAWU4/o=
X-Google-Smtp-Source: ABdhPJyAmd7mdqFmqHLCmRFi1gR1ClGaGIb+efJ6Hu6voyCX6CW37zaNOeSUt0Y6IXtICaaQsIixTA==
X-Received: by 2002:a05:6402:d2:b0:413:2e50:d6fd with SMTP id i18-20020a05640200d200b004132e50d6fdmr5565813edu.171.1648571427125;
        Tue, 29 Mar 2022 09:30:27 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k26-20020a056402049a00b004197b0867e0sm8601179edv.42.2022.03.29.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 09:30:26 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: clock: convert rockchip,rk3328-cru.txt to YAML
Date:   Tue, 29 Mar 2022 18:30:14 +0200
Message-Id: <20220329163016.27458-1-jbx6244@gmail.com>
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

Current dts files with RK3328 'cru' nodes are manually verified.
In order to automate this process rockchip,rk3328-cru.txt has to be
converted to YAML.

Changed:
  Add properties to fix notifications by clocks.yaml for example:
    clocks
    clock-names

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/clock/rockchip,rk3328-cru.txt    | 58 ---------------
 .../bindings/clock/rockchip,rk3328-cru.yaml   | 74 +++++++++++++++++++
 2 files changed, 74 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt
deleted file mode 100644
index 904ae682e..000000000
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* Rockchip RK3328 Clock and Reset Unit
-
-The RK3328 clock controller generates and supplies clock to various
-controllers within the SoC and also implements a reset controller for SoC
-peripherals.
-
-Required Properties:
-
-- compatible: should be "rockchip,rk3328-cru"
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
-preprocessor macros in the dt-bindings/clock/rk3328-cru.h headers and can be
-used in device tree sources. Similar macros exist for the reset sources in
-these files.
-
-External clocks:
-
-There are several clocks that are generated outside the SoC. It is expected
-that they are defined using standard clock bindings with following
-clock-output-names:
- - "xin24m" - crystal input - required,
- - "clkin_i2s" - external I2S clock - optional,
- - "gmac_clkin" - external GMAC clock - optional
- - "phy_50m_out" - output clock of the pll in the mac phy
- - "hdmi_phy" - output clock of the hdmi phy pll - optional
-
-Example: Clock controller node:
-
-	cru: clock-controller@ff440000 {
-		compatible = "rockchip,rk3328-cru";
-		reg = <0x0 0xff440000 0x0 0x1000>;
-		rockchip,grf = <&grf>;
-
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-Example: UART controller node that consumes the clock generated by the clock
-  controller:
-
-	uart0: serial@ff120000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0xff120000 0x100>;
-		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		clocks = <&cru SCLK_UART0>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.yaml
new file mode 100644
index 000000000..f079c7a25
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3328-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3328 Clock and Reset Unit (CRU)
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The RK3328 clock controller generates and supplies clocks to various
+  controllers within the SoC and also implements a reset controller for SoC
+  peripherals.
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All available clocks are defined as
+  preprocessor macros in the dt-bindings/clock/rk3328-cru.h headers and can be
+  used in device tree sources. Similar macros exist for the reset sources in
+  these files.
+  There are several clocks that are generated outside the SoC. It is expected
+  that they are defined using standard clock bindings with following
+  clock-output-names:
+    - "xin24m"      - crystal input                          - required,
+    - "clkin_i2s"   - external I2S clock                     - optional,
+    - "gmac_clkin"  - external GMAC clock                    - optional
+    - "phy_50m_out" - output clock of the pll in the mac phy
+    - "hdmi_phy"    - output clock of the hdmi phy pll       - optional
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3328-cru
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
+      if missing pll rates are not changeable, due to the missing pll
+      lock status.
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
+    cru: clock-controller@ff440000 {
+      compatible = "rockchip,rk3328-cru";
+      reg = <0xff440000 0x1000>;
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1


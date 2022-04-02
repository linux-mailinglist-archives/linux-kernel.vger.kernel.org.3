Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217CC4F041E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356649AbiDBOjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356595AbiDBOin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:38:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907DD181B13;
        Sat,  2 Apr 2022 07:36:51 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id yy13so11446475ejb.2;
        Sat, 02 Apr 2022 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDX6XR3jVDm9yWJ+XzR+YFdJXpUjQXrovXJ8YXoJ/eQ=;
        b=Gkcp8k95sTeZEk8ouc+Cz0NB5BQTPfw9R9dJ5Q1aGu6JQ4E+2wJuYyFT3PY9hcZcy1
         HVvbItxziBvdTE95+7S+Z4pZ7EVz44W+pLxU4OTDCxqpNIEBZ+OpaGTQD1HNSpLI6P9K
         1Zo7OY9F1u4i8U4TjwPZwsMrJ8cM9E2yKyba1siqaiw7T7WP5l0kt3v4+ZeQsLYiBqtX
         xF0ahmQsB6PMLPpxh6VYMBHIEC5UeKJ10JD3WcYU3Gbwbxc68L4HPcDvtKoxc3CmtoM9
         lGhlD48L3rczzHKysiYUxi6yEZ5Q8doxOP9MNE773DBjePlQlq5iDvpCzpMvwe/l8OPk
         eR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDX6XR3jVDm9yWJ+XzR+YFdJXpUjQXrovXJ8YXoJ/eQ=;
        b=vsWoaeNj0187tTosILrf68O7jLJbPehiIwh1H+8knUk8VJ8VE+gmQp1F4RuOYRHnex
         f6h3hpC8V/95KNRRY63tSFAtnyboRrC/6rruhANn10gESrkj0BYs/aIi83K0U+Y6OBhc
         g6vZlK5OT10TNjD/Hj09sH7GRX8aWPX4PX6wdYP6WSRUE9/IyTPUkmIl3oLtfbDwjqR4
         KPLRTGsKxdTZ8vnp+lMj7Ank4W/A4tG4p/86SQz1lXLUlu6bAMESxmZiIScE2Kgtw91/
         ECiWqUjgB+YMI6IorJGmbuoRXfiqRg0/rXdRcVv1jEzu3w/1wW1X5Ivjh9ovkEkPCeal
         OO0Q==
X-Gm-Message-State: AOAM533UkSqvzeD99uOi7p6SRYk6G/1T2+8GYb6HHGiF6L7W32UTfNb2
        x0qbJRVBx73dQw6uhuhvrcg=
X-Google-Smtp-Source: ABdhPJxDsZ0j8m7pCLEC+sxvbQOm35l111ofY5I/W40A9SpsH55KuoLgxiZNEbcTmIxdLc1g3Li69g==
X-Received: by 2002:a17:907:6e03:b0:6e0:15ce:77ba with SMTP id sd3-20020a1709076e0300b006e015ce77bamr3988665ejc.67.1648910210153;
        Sat, 02 Apr 2022 07:36:50 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bp8-20020a170907918800b006e0daaa63ddsm2169557ejb.60.2022.04.02.07.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 07:36:49 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/16] dt-bindings: clock: convert rockchip,rk3328-cru.txt to YAML
Date:   Sat,  2 Apr 2022 16:36:27 +0200
Message-Id: <20220402143636.15222-8-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220402143636.15222-1-jbx6244@gmail.com>
References: <20220402143636.15222-1-jbx6244@gmail.com>
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

Convert rockchip,rk3328-cru.txt to YAML.

Changes against original bindings:
  Add clocks and clock-names because the device has to have
  at least one input clock.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V4:
  add more clocks
  add clocks to example
  add clocks requirement
---
 .../bindings/clock/rockchip,rk3328-cru.txt    | 58 -------------
 .../bindings/clock/rockchip,rk3328-cru.yaml   | 82 +++++++++++++++++++
 2 files changed, 82 insertions(+), 58 deletions(-)
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
index 000000000..965f67be3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.yaml
@@ -0,0 +1,82 @@
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
+  that they are defined using standard clock bindings with the
+  clock-output-names defined in this schema.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3328-cru
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 5
+
+  clock-names:
+    minItems: 1
+    maxItems: 5
+    items:
+      enum:
+        - xin24m
+        - clkin_i2s
+        - gmac_clkin
+        - hdmi_phy
+        - phy_50m_out
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing the "general register files" (GRF),
+      if missing pll rates are not changeable, due to the missing pll
+      lock status.
+
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
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
+      clocks = <&xin24m>;
+      clock-names = "xin24m";
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A450D4F042F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356581AbiDBOim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356564AbiDBOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:38:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B564181B19;
        Sat,  2 Apr 2022 07:36:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id yy13so11446214ejb.2;
        Sat, 02 Apr 2022 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ay5bIkDMN0uWXFaucFOQ03lqhqXOzPmmv54m4o8auLE=;
        b=RvgbPEG3WIiL//B+ubI3vbRFJWsOVYJku3J9ODjBbgB1bLKL0HE6yHEpz7c0zAEFoN
         w7WiczXcCXezSPwFP5LqpDHoGG9De5viqdBAgEgAwa4apaYbR/mU093W6ZqzW6QZXbbM
         t8ch6M0V6mJsKJJo0+crOv8cGXYX7AOfq4sQYQsYhGmEn9qj05qYEK0OA1yz/01L1Dun
         U1Dw0nWZPGiSSWZ9wJNcGBci24sNtT1Ssyj4TQ42/d32seY0xLUMdSBUaAf9LY2Al6pv
         RS9XH11lyqWAD70gS/S22z5YUM9Vp6Jm7Do8nTPDYtnJfHD6SZN231AI1+Vm8KfFLg7h
         BZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ay5bIkDMN0uWXFaucFOQ03lqhqXOzPmmv54m4o8auLE=;
        b=5skUcvBqT7ozUNxiZTRFv7lsipqhUOa8VE6LGBBNgtK1XXHUskh4mECB/ZsPjFJHdv
         kjd/n69ckXrqEb+IZHdHn2QKA5Uy3zzj6yBBjRXRfXvB5k2p0DevB9Fk/RpeSq+2cGcr
         OpcGkRy0iNnUjVNK9P2ao1lLLgktGvefzVfmuvUbfkVkT/JWxPQI2FfpFLhLAapxjjI+
         CKYM+SZcZ1Jx4XxqGtW9sekh39UQHmhZrf5ms1pYQWmGPTjfCI6eOZbNYcFXdnYRzAAr
         M162HNauya52tdu3IpcTNXe5K9wgtuUj8vWs4fyDGMp6fIJm63RU4x6U0jbVqeQxmDIN
         DLYg==
X-Gm-Message-State: AOAM530TkGqI0cjLVyiXqPNonpqNox9+qauySVb1DqSP6McovSqc4nfF
        QV0wAfY0lGIXPyyyj+avzZ0frPcch7I=
X-Google-Smtp-Source: ABdhPJxm4mqwNr+KeTDo/7qreofruqZueesSFWpUFtS4m+sFct+MNlyiLH22R+eW/XGiaHx72ivOSQ==
X-Received: by 2002:a17:907:2cc3:b0:6e6:45fb:39fa with SMTP id hg3-20020a1709072cc300b006e645fb39famr2593392ejc.545.1648910204514;
        Sat, 02 Apr 2022 07:36:44 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bp8-20020a170907918800b006e0daaa63ddsm2169557ejb.60.2022.04.02.07.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 07:36:44 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/16] dt-bindings: clock: convert rockchip,px30-cru.txt to YAML
Date:   Sat,  2 Apr 2022 16:36:21 +0200
Message-Id: <20220402143636.15222-2-jbx6244@gmail.com>
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

Convert rockchip,px30-cru.txt to YAML.

Changes against original bindings:
  Use compatible string: "rockchip,px30-pmucru"

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V4:
  add more clocks

Changed V2:
  add allOf:if:then: constraining
---
 .../bindings/clock/rockchip,px30-cru.txt      |  70 ----------
 .../bindings/clock/rockchip,px30-cru.yaml     | 120 ++++++++++++++++++
 2 files changed, 120 insertions(+), 70 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
deleted file mode 100644
index 55e78cdde..000000000
--- a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-* Rockchip PX30 Clock and Reset Unit
-
-The PX30 clock controller generates and supplies clock to various
-controllers within the SoC and also implements a reset controller for SoC
-peripherals.
-
-Required Properties:
-
-- compatible: PMU for CRU should be "rockchip,px30-pmu-cru"
-- compatible: CRU should be "rockchip,px30-cru"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- clocks: A list of phandle + clock-specifier pairs for the clocks listed
-          in clock-names
-- clock-names: Should contain the following:
-  - "xin24m" for both PMUCRU and CRU
-  - "gpll" for CRU (sourced from PMUCRU)
-- #clock-cells: should be 1.
-- #reset-cells: should be 1.
-
-Optional Properties:
-
-- rockchip,grf: phandle to the syscon managing the "general register files"
-  If missing, pll rates are not changeable, due to the missing pll lock status.
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume. All available clocks are defined as
-preprocessor macros in the dt-bindings/clock/px30-cru.h headers and can be
-used in device tree sources. Similar macros exist for the reset sources in
-these files.
-
-External clocks:
-
-There are several clocks that are generated outside the SoC. It is expected
-that they are defined using standard clock bindings with following
-clock-output-names:
- - "xin24m" - crystal input - required,
- - "xin32k" - rtc clock - optional,
- - "i2sx_clkin" - external I2S clock - optional,
- - "gmac_clkin" - external GMAC clock - optional
-
-Example: Clock controller node:
-
-	pmucru: clock-controller@ff2bc000 {
-		compatible = "rockchip,px30-pmucru";
-		reg = <0x0 0xff2bc000 0x0 0x1000>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-	cru: clock-controller@ff2b0000 {
-		compatible = "rockchip,px30-cru";
-		reg = <0x0 0xff2b0000 0x0 0x1000>;
-		rockchip,grf = <&grf>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-Example: UART controller node that consumes the clock generated by the clock
-  controller:
-
-	uart0: serial@ff030000 {
-		compatible = "rockchip,px30-uart", "snps,dw-apb-uart";
-		reg = <0x0 0xff030000 0x0 0x100>;
-		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&pmucru SCLK_UART0_PMU>, <&pmucru PCLK_UART0_PMU>;
-		clock-names = "baudclk", "apb_pclk";
-		reg-shift = <2>;
-		reg-io-width = <4>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
new file mode 100644
index 000000000..c88e7e3db
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,px30-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip PX30 Clock and Reset Unit (CRU)
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The PX30 clock controller generates and supplies clocks to various
+  controllers within the SoC and also implements a reset controller for SoC
+  peripherals.
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All available clocks are defined as
+  preprocessor macros in the dt-bindings/clock/px30-cru.h headers and can be
+  used in device tree sources. Similar macros exist for the reset sources in
+  these files.
+  There are several clocks that are generated outside the SoC. It is expected
+  that they are defined using standard clock bindings with the
+  clock-output-names defined in this schema.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,px30-cru
+      - rockchip,px30-pmucru
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
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,px30-cru
+
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 5
+
+        clock-names:
+          minItems: 1
+          maxItems: 5
+          items:
+            enum:
+              - xin24m
+              - xin32k
+              - gpll
+              - gmac_clkin
+              - i2sx_clkin
+
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          const: xin24m
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/px30-cru.h>
+
+    pmucru: clock-controller@ff2bc000 {
+      compatible = "rockchip,px30-pmucru";
+      reg = <0xff2bc000 0x1000>;
+      clocks = <&xin24m>;
+      clock-names = "xin24m";
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
+
+    cru: clock-controller@ff2b0000 {
+      compatible = "rockchip,px30-cru";
+      reg = <0xff2b0000 0x1000>;
+      clocks = <&xin24m>, <&pmucru PLL_GPLL>;
+      clock-names = "xin24m", "gpll";
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1


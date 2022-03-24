Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EACE4E641F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350456AbiCXNeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243053AbiCXNeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:34:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D8A673E8;
        Thu, 24 Mar 2022 06:32:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y10so5632825edv.7;
        Thu, 24 Mar 2022 06:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kUVvYnYs4g2TTfOXTOoNhPTZFus1FHIFlYQM09GP0Vk=;
        b=Q8035X5zS23vYfXMn75+bVrxoYlc/oa9RWON9lVbkl1KBuSsYR2Y5iGqOTiwemLcAd
         DFCZ0VFdAofKru5LChgYARUyGn0H6Vovf7xmfOsHUfqU3/AsvBqISW16bHTmVrtB7V4Q
         OvcTra3rKbvwC9HzEjPCQcl4Nwn7Da+XFkKmJGFurbYzxct507mmnxbIFOdQoQlbh0E3
         gJckgjjxM5DUe7zlfS7DjhAN369LWzpcLCtX//2fnrQrdQiDQnakPkoXjzFKPsLeZu1I
         051XpIpdcyZu/YDzZVzCtq7T7DfHtjRMf5JCrgy7Qg7psg9fEXS8Tr11/dKCF0gWFPy1
         Ci/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kUVvYnYs4g2TTfOXTOoNhPTZFus1FHIFlYQM09GP0Vk=;
        b=jKTBpiD4sLND4HtTzZnH3vdApS4Pxupl45zBqnB1QY/wRtG2WJhxzQ7hlTvSe9btMc
         b1pFrKidhq+u14jYjftHdCG8SSWVO/UEXi7h8DLA8WBcmXXXlmCd/aM0cnnViGnr6JmA
         BAQBhLVEpPBUoC6I4rKxZQDBmx9OU7Rh0vgO5x+hU7il7dHEOzLNxYHYOR823UtbtLhF
         /gAVQS7Sr4QeAALZVWNX7087Zld6+nQ6X5ZwAE++Mg2F7nUuBhr99sDN5ij/vNHPMajq
         jOoS+d9T/MPm6LAVf/6IZF1g/7EP1yWLKNx0p3ZjumX/eQdfovXnLfjcoK9kbsIGpBnL
         k7hg==
X-Gm-Message-State: AOAM533lJY+LmA4STsCa+PyBIDEz5smqq8YJq5nKesSyu7P1d+bjtI3r
        +cqTDlCQaIL3s0R+pzosmiFHa2/Gb28=
X-Google-Smtp-Source: ABdhPJwpYrQv1JTNbSVl+ILm6u1YPNfOOvT6AddOYMuAqF2bXalSsHTwkuk6zOWeUfzN99+SZG72bA==
X-Received: by 2002:a05:6402:1388:b0:419:3d1a:9844 with SMTP id b8-20020a056402138800b004193d1a9844mr6762385edv.256.1648128756186;
        Thu, 24 Mar 2022 06:32:36 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906538b00b006ae38eb0561sm1145586ejo.195.2022.03.24.06.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 06:32:35 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: clock: convert rockchip,rk3188-cru.txt to YAML
Date:   Thu, 24 Mar 2022 14:32:29 +0100
Message-Id: <20220324133229.24035-1-jbx6244@gmail.com>
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
    assigned-clock-rates
    assigned-clocks

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/clock/rockchip,rk3188-cru.txt    | 61 --------------
 .../bindings/clock/rockchip,rk3188-cru.yaml   | 81 +++++++++++++++++++
 2 files changed, 81 insertions(+), 61 deletions(-)
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
index 000000000..136a9771e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
@@ -0,0 +1,81 @@
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
+    minItems: 1
+
+  assigned-clock-rates:
+    minItems: 1
+    maxItems: 64
+
+  assigned-clocks:
+    minItems: 1
+    maxItems: 64
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
+    cru: cru@20000000 {
+      compatible = "rockchip,rk3188-cru";
+      reg = <0x20000000 0x1000>;
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1


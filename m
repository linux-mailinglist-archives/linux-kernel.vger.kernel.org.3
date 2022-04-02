Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8F74F0400
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356669AbiDBOjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356564AbiDBOim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:38:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66DA181B19;
        Sat,  2 Apr 2022 07:36:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qh7so1398596ejb.11;
        Sat, 02 Apr 2022 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=McFpQ5/hW4Zbu4Ht8+BLpCgdUXBbUIZ2u7Nful4GDGM=;
        b=CnkrWwg6ioIxsLmOZcg3Ae61uiEygQtLuvT17CHCUiEYmLqsKPLFhHKsNC5XJcLkC9
         z9DBA+3MQg/zDKo9j3fAn6s7rPu06EZk0o9P8VH9UeBrABB5cGvmEb2JOtcBGUZixHGI
         y2URA+odVgsW/AB9CoqA3Z1dz5yo31ykqaP0Bav13LX+1IMC5z9Q03L2MU1I5e1qDxXL
         sD0e6ZLKUcWPlUwu0u7yXj+GQGDwfi4ukto2UZd6KOo/atEJAQO1GL/M1a9lIB8dAv7L
         hBqs7DnY/22R6Tdkmrmr5zbRpoTaYGaEGJNO4y8vCpMsfx5wkTBp9FBcOLJkom1Vi22j
         oQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=McFpQ5/hW4Zbu4Ht8+BLpCgdUXBbUIZ2u7Nful4GDGM=;
        b=Z77Jm3iEszC0H4QFL4HFcseaSCwBcVPAbNCkLho/w5mUfvBCyukMhYIAo5V1gIQx6W
         4rRGNETH1sAq5FoJTL4B66NcBybiExwxOFMc1t9XTdnGq7/eJuj482jg4wIVi6YmOUo/
         nPb1jtqldleQ8j4HB48P8oJQfF3DT9b/hK2nx62f9p93brBbWvn+ZQagEkwGXdm5Djmq
         O1P5OH1y8un6ACPa5rwHAT/Io0XCqYIxZTbmyJHS1fzWVHae+ffsvKZHI5t0YfXswlCQ
         0PH8mMU1X+9n5/ZYCxc2OhfOqKeSWmUEJJDlLqJFWdZndwuCYr5+heOqOzf7jZ9Z6HQg
         Xkgw==
X-Gm-Message-State: AOAM531FNOTfTYMq9i1bvmIh5XhfdO0R64Me5aqXo1M/UvbhQC8M09+7
        0XjSejI4fNEDjtNWOMKFEe4=
X-Google-Smtp-Source: ABdhPJzpTeP7eaTWHqyR4NNPQDqgajKijKBnn1fgmM99LPS0+oVSq68qsxMPcdcn+EUwY81sEQ1ufw==
X-Received: by 2002:a17:907:2d8d:b0:6df:a06c:7c55 with SMTP id gt13-20020a1709072d8d00b006dfa06c7c55mr4054714ejc.325.1648910209152;
        Sat, 02 Apr 2022 07:36:49 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bp8-20020a170907918800b006e0daaa63ddsm2169557ejb.60.2022.04.02.07.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 07:36:48 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/16] dt-bindings: clock: convert rockchip,rk3308-cru.txt to YAML
Date:   Sat,  2 Apr 2022 16:36:26 +0200
Message-Id: <20220402143636.15222-7-jbx6244@gmail.com>
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

Convert rockchip,rk3308-cru.txt to YAML.

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
 .../bindings/clock/rockchip,rk3308-cru.txt    | 60 -------------
 .../bindings/clock/rockchip,rk3308-cru.yaml   | 86 +++++++++++++++++++
 2 files changed, 86 insertions(+), 60 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.txt
deleted file mode 100644
index 9b151c5b0..000000000
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.txt
+++ /dev/null
@@ -1,60 +0,0 @@
-* Rockchip RK3308 Clock and Reset Unit
-
-The RK3308 clock controller generates and supplies clock to various
-controllers within the SoC and also implements a reset controller for SoC
-peripherals.
-
-Required Properties:
-
-- compatible: CRU should be "rockchip,rk3308-cru"
-- reg: physical base address of the controller and length of memory mapped
-  region.
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
-preprocessor macros in the dt-bindings/clock/rk3308-cru.h headers and can be
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
- - "mclk_i2s0_8ch_in", "mclk_i2s1_8ch_in", "mclk_i2s2_8ch_in",
-   "mclk_i2s3_8ch_in", "mclk_i2s0_2ch_in",
-   "mclk_i2s1_2ch_in" - external I2S or SPDIF clock - optional,
- - "mac_clkin" - external MAC clock - optional
-
-Example: Clock controller node:
-
-	cru: clock-controller@ff500000 {
-		compatible = "rockchip,rk3308-cru";
-		reg = <0x0 0xff500000 0x0 0x1000>;
-		rockchip,grf = <&grf>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-Example: UART controller node that consumes the clock generated by the clock
-  controller:
-
-	uart0: serial@ff0a0000 {
-		compatible = "rockchip,rk3308-uart", "snps,dw-apb-uart";
-		reg = <0x0 0xff0a0000 0x0 0x100>;
-		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
-		clock-names = "baudclk", "apb_pclk";
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		status = "disabled";
-	};
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml
new file mode 100644
index 000000000..01f2d1690
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3308-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3308 Clock and Reset Unit (CRU)
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The RK3308 clock controller generates and supplies clocks to various
+  controllers within the SoC and also implements a reset controller for SoC
+  peripherals.
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All available clocks are defined as
+  preprocessor macros in the dt-bindings/clock/rk3308-cru.h headers and can be
+  used in device tree sources. Similar macros exist for the reset sources in
+  these files.
+  There are several clocks that are generated outside the SoC. It is expected
+  that they are defined using standard clock bindings with the
+  clock-output-names defined in this schema.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3308-cru
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 9
+
+  clock-names:
+    minItems: 1
+    maxItems: 9
+    items:
+      enum:
+        - xin24m
+        - xin32k
+        - mac_clkin
+        - mclk_i2s0_2ch_in
+        - mclk_i2s1_2ch_in
+        - mclk_i2s0_8ch_in
+        - mclk_i2s1_8ch_in
+        - mclk_i2s2_8ch_in
+        - mclk_i2s3_8ch_in
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
+    cru: clock-controller@ff500000 {
+      compatible = "rockchip,rk3308-cru";
+      reg = <0xff500000 0x1000>;
+      clocks = <&xin24m>;
+      clock-names = "xin24m";
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1


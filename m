Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F874EB39F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240658AbiC2Sph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiC2Spd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:45:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39496338A4;
        Tue, 29 Mar 2022 11:43:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a8so36806748ejc.8;
        Tue, 29 Mar 2022 11:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VMqff0AA4ues5gejWo82ERpXccxpeB9zCdHCRWcLylw=;
        b=Ro5n3KjVjRw3+k4L60gptenas6QL3UcFcMzVDbvIwdJAEDTRjaS4ve085vhJrtapzy
         XiZLKb8tjOI+LdDzMfUspzyAHb8rCGjb6CIecLT0UWJBGDzIt7mrso/cjDO95T1B0bgr
         UusxGBlf6jUUsScu8RuobfVNr2QiRR2hGtNHwdIg7vqIiCJvJId4/nIVhJfeC2729mZW
         T2GnOsdxqE+k3TVG8EJtzdpzQdVMEn7dhqXdzLXsmeueGeXFlxmNZmFY2S0Ub+peczDB
         d/QmHEeOGDJLvrL2Bq6Cw6vj60w01yKqwZnrtM3XdAwHVETOlaMicOo3xNTaaqqp8DXt
         jgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VMqff0AA4ues5gejWo82ERpXccxpeB9zCdHCRWcLylw=;
        b=ka0o6ti4HHEK7K0XjFckUWybblWzw93aVMyaIiMPkgW/ADPqarXBd7QO5p3fHB45qX
         F4QlC1qSw2p+g+x3+I1nayRnY3sIXCxRjltiFH3ZDFdr7OeYcswEGIP2xJwsIkWrytUR
         K5BK5rb4Bx4k9c2zQVTUqN+sefc7vy1qDV7i0R9fMI7LgBrFwG7k5nxyZbHUMattG/JV
         e9vJU7rPN4+aJ9XpCE1fhT0o0HdZyn8LHIy/6OOVhnjfy0tgP1CNgQp9rT/drTUMmjJV
         0ITXlGFDWE8+hSkpqlXTipBgoQeXCmvm7Fcm35sqyAWh0UcOPkz8QKHwFHAbAOfx+sQi
         EnqQ==
X-Gm-Message-State: AOAM530iXobIYsQRO/QY7xzdi5pogEUhMxSFcSqGXy4YH1feYjN/QbSX
        zOt/eucXduUa9XXuR0a8hIA=
X-Google-Smtp-Source: ABdhPJwEs5t8gHV99e7n5X+AeeylUWh58oZWTzleCryNYu9GZNqAFcGZtF6/9Onh5jQb/4YUIguDYg==
X-Received: by 2002:a17:906:c1d6:b0:6d6:e0a3:bbc7 with SMTP id bw22-20020a170906c1d600b006d6e0a3bbc7mr36833053ejb.484.1648579427760;
        Tue, 29 Mar 2022 11:43:47 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090674cc00b006df9afdda91sm7138714ejl.185.2022.03.29.11.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 11:43:47 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: clock: convert rockchip,rk3308-cru.txt to YAML
Date:   Tue, 29 Mar 2022 20:43:38 +0200
Message-Id: <20220329184339.1134-1-jbx6244@gmail.com>
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

Convert rockchip,rk3308-cru.txt to YAML.

Changes against original bindings:
 - Add clocks and clock-names because the device has to have
   at least one input clock.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/clock/rockchip,rk3308-cru.txt    | 60 ---------------
 .../bindings/clock/rockchip,rk3308-cru.yaml   | 76 +++++++++++++++++++
 2 files changed, 76 insertions(+), 60 deletions(-)
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
index 000000000..523ee578a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml
@@ -0,0 +1,76 @@
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
+  that they are defined using standard clock bindings with following
+  clock-output-names:
+    - "xin24m"                               - crystal input      - required
+    - "xin32k"                               - rtc clock          - optional
+    - "mclk_i2s0_8ch_in", "mclk_i2s1_8ch_in",
+      "mclk_i2s2_8ch_in", "mclk_i2s3_8ch_in",
+      "mclk_i2s0_2ch_in", "mclk_i2s1_2ch_in" - external I2S or
+                                               SPDIF clock        - optional
+    - "mac_clkin"                            - external MAC clock - optional
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3308-cru
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
+    cru: clock-controller@ff500000 {
+      compatible = "rockchip,rk3308-cru";
+      reg = <0xff500000 0x1000>;
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1


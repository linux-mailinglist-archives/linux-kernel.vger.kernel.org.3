Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD604F0430
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356604AbiDBOjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356578AbiDBOil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:38:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB169182D96;
        Sat,  2 Apr 2022 07:36:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i27so4263855ejd.9;
        Sat, 02 Apr 2022 07:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4sJAGR00sQPyOa2NU6Kbyt+hZau/MXPRKhM5pgnXKBk=;
        b=nSX9fb1plzvZ8Fzbh6lDWAeF2413rghTIuHHV7jUMZEmWpfKljublWpjDg9xSVwPmU
         5maN3DQhb1xh1LGSQRKfXUOvwnun1NLQTqIf86MH5vUqvKSV0XCzfFjdTJD3Gculn+qt
         kfR7+8cWZ7HpXAMeEjPfjJnuGjKXrNRDqnGRUEsiHgXqoRqOlEFKWSeh5Co+Ehw/sW9d
         akAsexFf5b2vD4OwgfrTTWgj9n3ScWe4MMvASNWVO3SpocPl8uky5WZMFqlEmjYo/Xlv
         49igTm1MeW0W7oRKPrUX0t62lYwLPbuFDsPETsWqcAk446julRqLLIqxQmWpnATKlzqs
         3BXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4sJAGR00sQPyOa2NU6Kbyt+hZau/MXPRKhM5pgnXKBk=;
        b=uXHhJt+Fr0lmTCPO6ytswSgDV7hxa0P2fV/vaDdbELT843Ch3i3q3EQAsjDb5ICyPe
         WLXPIiXR8dOoIE1S5r0y4PQrjXeao9444ZNdoFwnmpvH4jhEk2NicV647MFqiwjta6NU
         hB7/HTtXNpri05ZQ5HGrrXJIBsjUIbOGRyHoS2kCTf0jB9Zx2/DCHUjrMsW3E8vOar0r
         OylJi4cDqt8XvFCW/CGTH8jZN4UVemLJe2TlCgA9k+g3cqZZPYigiNZvn/GdumCaFeIm
         ph/Ds6cfhZGrJQab2WMnG4yD/ZeDNRw3j7RHPiYYz/z/t2pEHvZOy6CjVAJvsz+orRfz
         vjOQ==
X-Gm-Message-State: AOAM531ulE4Pl9U+8x3unz1x8+XM3glVKrH0f1i4vvGjDZMXXRUeq+AD
        vQs/kV0uXeYyr4AFBOEaV87J5OrW4Gk=
X-Google-Smtp-Source: ABdhPJwUDASQKnl3UVkOThXossDxGeZHDcmYNFHcd6uJ8J+iXty3WoVJI3QJE2Ya1Uh+nRCJNTJKEg==
X-Received: by 2002:a17:907:7295:b0:6e6:d8c7:5b4b with SMTP id dt21-20020a170907729500b006e6d8c75b4bmr1651189ejc.606.1648910208241;
        Sat, 02 Apr 2022 07:36:48 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bp8-20020a170907918800b006e0daaa63ddsm2169557ejb.60.2022.04.02.07.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 07:36:47 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/16] dt-bindings: clock: convert rockchip,rk3288-cru.txt to YAML
Date:   Sat,  2 Apr 2022 16:36:25 +0200
Message-Id: <20220402143636.15222-6-jbx6244@gmail.com>
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

Convert rockchip,rk3288-cru.txt to YAML.

Changes against original bindings:
  Add clocks and clock-names because the device has to have
  at least one input clock.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V4:
  add more clocks
  add clocks to example
  add clocks requirement

Changed V2:
  add Rockchip maintainer on her request
  fix yamllint line too long
  restyle
---
 .../bindings/clock/rockchip,rk3288-cru.txt    | 67 -------------
 .../bindings/clock/rockchip,rk3288-cru.yaml   | 93 +++++++++++++++++++
 2 files changed, 93 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
deleted file mode 100644
index bf3a9ec19..000000000
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-* Rockchip RK3288 Clock and Reset Unit
-
-The RK3288 clock controller generates and supplies clock to various
-controllers within the SoC and also implements a reset controller for SoC
-peripherals.
-
-A revision of this SoC is available: rk3288w. The clock tree is a bit
-different so another dt-compatible is available. Noticed that it is only
-setting the difference but there is no automatic revision detection. This
-should be performed by bootloaders.
-
-Required Properties:
-
-- compatible: should be "rockchip,rk3288-cru" or "rockchip,rk3288w-cru" in
-  case of this revision of Rockchip rk3288.
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
-preprocessor macros in the dt-bindings/clock/rk3288-cru.h headers and can be
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
- - "ext_i2s" - external I2S clock - optional,
- - "ext_hsadc" - external HSADC clock - optional,
- - "ext_edp_24m" - external display port clock - optional,
- - "ext_vip" - external VIP clock - optional,
- - "ext_isp" - external ISP clock - optional,
- - "ext_jtag" - external JTAG clock - optional
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
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
new file mode 100644
index 000000000..558e5a094
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3288-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3288 Clock and Reset Unit (CRU)
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The RK3288 clock controller generates and supplies clocks to various
+  controllers within the SoC and also implements a reset controller for SoC
+  peripherals.
+
+  A revision of this SoC is available: rk3288w. The clock tree is a bit
+  different so another dt-compatible is available. Noticed that it is only
+  setting the difference but there is no automatic revision detection. This
+  should be performed by boot loaders.
+
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All available clocks are defined as
+  preprocessor macros in the dt-bindings/clock/rk3288-cru.h headers and can be
+  used in device tree sources. Similar macros exist for the reset sources in
+  these files.
+
+  There are several clocks that are generated outside the SoC. It is expected
+  that they are defined using standard clock bindings with the
+  clock-output-names defined in this schema.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3288-cru
+      - rockchip,rk3288w-cru
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 8
+
+  clock-names:
+    minItems: 1
+    maxItems: 8
+    items:
+      enum:
+        - xin24m
+        - xin32k
+        - ext_i2s
+        - ext_hsadc
+        - ext_edp_24m
+        - ext_vip
+        - ext_isp
+        - ext_jtag
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
+    cru: clock-controller@ff760000 {
+      compatible = "rockchip,rk3288-cru";
+      reg = <0xff760000 0x1000>;
+      clocks = <&xin24m>;
+      clock-names = "xin24m";
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1


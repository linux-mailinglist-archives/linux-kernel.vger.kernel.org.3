Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD24EC55E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345836AbiC3NSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345817AbiC3NSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:18:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226F62FFF8;
        Wed, 30 Mar 2022 06:16:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bg10so41457684ejb.4;
        Wed, 30 Mar 2022 06:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kIZngZOjWy/J3S+b4z6+BUn/eXOxV020jVmkrkFNZpQ=;
        b=biH0nxISIqGQSS6v7IiQeP0zNDT0PEkBjLFaq1jmJRMkJP74TqKUjH2bP7aVt9KtQp
         TWRHFlLQ4mYWPEgAbR1NxjkfM75bZdcQu2rANl3Uo6noaZggYAYLZk9nXfn4965pQynB
         yooB4KgRMwDuXQPgsHGc2V49mFs4YafwhRqTzklEIj0mMBufGVxwLNzzVn9ba5f1qIJs
         iNbMX+bmavYi2ijWIwfXVxONCIlUgyCh1MGo3zg3A/nu1cVlHdB34YY5tM95G1/uym+q
         GgajeY3vUZ4rK263Jey0gj5Y6Iuq+lL5nNYHa03Ha+SR1tpxhGHob+DPqSw+g2NHMG+F
         34BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kIZngZOjWy/J3S+b4z6+BUn/eXOxV020jVmkrkFNZpQ=;
        b=klM1ZNhv2JrXjsEA20rl7rlfp10A61v1Prg8cLYaxdNQ2vGnfvowD/YBO/lqlMXbV5
         yj+jmRLoAy3JIKJAvQ2mmeCHbPK2xGURj5MYhDRj7iuRZdqql3/eZrLdovoPqvcSOoxs
         f0msUmj0wv+KAM/d8L9pZ/ZEO6rmTpwEVWEXOl/WmX+rms2fEDmUTTRy6mpYHqPleDdl
         il2CDFxyA0PS8B9Z0wgbnYrMfslm0dJHMvyMagd3cDUAYWpIVZllp3xdfLZB+DsAumKv
         KeN0vz+BBRvIh1VBypKF6O8LdFZj/INiHayGSbXxaK/BY9buOLe9G8a+4fJUEDaWrnWK
         KmIg==
X-Gm-Message-State: AOAM530k0FRXC7oY8cL8IKmpnrfYnKQwDNlLROBipbigHNACekovgLu4
        zNPQogpCS6awR6zo3ygQzmk=
X-Google-Smtp-Source: ABdhPJxS9G9VHO3IThZxz4ao9YzTgP8Wz1c0iHE9nerrkjAwT9R8JXr1OX+n2TYNV647tHhxNfQ6vg==
X-Received: by 2002:a17:906:a4b:b0:6d0:fbdd:7cb5 with SMTP id x11-20020a1709060a4b00b006d0fbdd7cb5mr40462121ejf.152.1648646174471;
        Wed, 30 Mar 2022 06:16:14 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ge13-20020a170907908d00b006e09a005d73sm6603476ejb.31.2022.03.30.06.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:16:14 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: clock: convert rockchip,rv1108-cru.txt to YAML
Date:   Wed, 30 Mar 2022 15:16:06 +0200
Message-Id: <20220330131608.30040-1-jbx6244@gmail.com>
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

Convert rockchip,rv1108-cru.txt to YAML.

Changes against original bindings:
  Add clocks and clock-names because the device has to have
  at least one input clock.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/clock/rockchip,rv1108-cru.txt    | 59 ---------------
 .../bindings/clock/rockchip,rv1108-cru.yaml   | 75 +++++++++++++++++++
 2 files changed, 75 insertions(+), 59 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.txt
deleted file mode 100644
index 161326a4f..000000000
--- a/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.txt
+++ /dev/null
@@ -1,59 +0,0 @@
-* Rockchip RV1108 Clock and Reset Unit
-
-The RV1108 clock controller generates and supplies clock to various
-controllers within the SoC and also implements a reset controller for SoC
-peripherals.
-
-Required Properties:
-
-- compatible: should be "rockchip,rv1108-cru"
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
-preprocessor macros in the dt-bindings/clock/rv1108-cru.h headers and can be
-used in device tree sources. Similar macros exist for the reset sources in
-these files.
-
-External clocks:
-
-There are several clocks that are generated outside the SoC. It is expected
-that they are defined using standard clock bindings with following
-clock-output-names:
- - "xin24m" - crystal input - required,
- - "ext_vip" - external VIP clock - optional
- - "ext_i2s" - external I2S clock - optional
- - "ext_gmac" - external GMAC clock - optional
- - "hdmiphy" - external clock input derived from HDMI PHY - optional
- - "usbphy" - external clock input derived from USB PHY - optional
-
-Example: Clock controller node:
-
-	cru: cru@20200000 {
-		compatible = "rockchip,rv1108-cru";
-		reg = <0x20200000 0x1000>;
-		rockchip,grf = <&grf>;
-
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-Example: UART controller node that consumes the clock generated by the clock
-  controller:
-
-	uart0: serial@10230000 {
-		compatible = "rockchip,rv1108-uart", "snps,dw-apb-uart";
-		reg = <0x10230000 0x100>;
-		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		clocks = <&cru SCLK_UART0>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml
new file mode 100644
index 000000000..20421c22f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rv1108-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RV1108 Clock and Reset Unit (CRU)
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The RV1108 clock controller generates and supplies clocks to various
+  controllers within the SoC and also implements a reset controller for SoC
+  peripherals.
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All available clocks are defined as
+  preprocessor macros in the dt-bindings/clock/rv1108-cru.h headers and can be
+  used in device tree sources. Similar macros exist for the reset sources in
+  these files.
+  There are several clocks that are generated outside the SoC. It is expected
+  that they are defined using standard clock bindings with following
+  clock-output-names:
+    - "xin24m"   - crystal input                              - required
+    - "ext_vip"  - external VIP clock                         - optional
+    - "ext_i2s"  - external I2S clock                         - optional
+    - "ext_gmac" - external GMAC clock                        - optional
+    - "hdmiphy"  - external clock input derived from HDMI PHY - optional
+    - "usbphy"   - external clock input derived from USB PHY  - optional
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rv1108-cru
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
+    cru: clock-controller@20200000 {
+      compatible = "rockchip,rv1108-cru";
+      reg = <0x20200000 0x1000>;
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1


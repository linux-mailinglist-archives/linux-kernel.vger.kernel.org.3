Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605DF4F0408
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356614AbiDBOjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356597AbiDBOio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:38:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B9E182D8A;
        Sat,  2 Apr 2022 07:36:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bh17so11385337ejb.8;
        Sat, 02 Apr 2022 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2aGoR+jxGDzn8cgNTtv9/Wz52MpH/aK9EVPCLp/ehIM=;
        b=ikSmNvyPeCmAtCK60FrPC5QI4QD8u3dzi7SFtTmYR496NfMiTk8b5Dl39Y0zvp/jC8
         IM8bYf2NPzpzlihE4OBUu2VqwXhXtgbYJr2i+nhcHEy58gdLz1yI7NiDrc6Py+4IWi/J
         qCb4hvKBYmsPqijBuW9cuTQ0VkVoRI2l4tf2VIGskizoiNP6VY+C/7I3sJJwf6Mt6LHh
         C2EbJ2ea5OgCwEdIe73JzUmuHA0/c15H6hLK53wccqG+MUcuctoa4z0YBb+nyw32M04B
         Tf8r8pkvmUh75AcQGMB9P3Jn5Gql6rEJxwuzwzplrPjPK53waSKt+VbnEH3R/S2JK8PF
         lvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2aGoR+jxGDzn8cgNTtv9/Wz52MpH/aK9EVPCLp/ehIM=;
        b=NzEvV9h3NIn7n5JHau+RlcL+q/Ha0JxSabhdQGh/pCFnCMSMni3BBLY+qWMgC2/JQZ
         e0JLPgUetJg4BzTFtCLgXtxt60TVKEp682laK3dvboXAzBJwchaVTpR2mgawi6N7An3b
         P6vB6Cn6fc0PoYLjp5kCC/47bkkfwcV5FxcooFeMDNfz0W0Frd6TN+so5jtUZP+C2BBH
         tIXWohjTaGwkG79EGaLmSGl5MKUQJuMffgJr270iw1+5oU26D+Fd87cAQ4djUQXMSgvT
         5WzbKdnbGZlEmX/WN0ShQhkxesAKh4MZTLWXJGta6N+iOTJ1EwVyjMAc9KgUwTYODabB
         SH5g==
X-Gm-Message-State: AOAM533d8wCX/X8XazT7NGP5YKFQlHipJ5fZvjBQOmSaquzVfmqBmDOw
        /L0/AxLRgMympUyxYXeCEzA=
X-Google-Smtp-Source: ABdhPJxi9Qq9lRX++GDHOv/U4QNe8vF8sPKa2MqR4wILfaeO88cZNIUGrkotlOQi22yA9u5y56mrBQ==
X-Received: by 2002:a17:906:a398:b0:6ce:71b:deff with SMTP id k24-20020a170906a39800b006ce071bdeffmr3974682ejz.204.1648910211054;
        Sat, 02 Apr 2022 07:36:51 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bp8-20020a170907918800b006e0daaa63ddsm2169557ejb.60.2022.04.02.07.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 07:36:50 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/16] dt-bindings: clock: convert rockchip,rk3368-cru.txt to YAML
Date:   Sat,  2 Apr 2022 16:36:28 +0200
Message-Id: <20220402143636.15222-9-jbx6244@gmail.com>
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

Convert rockchip,rk3368-cru.txt to YAML.

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
 .../bindings/clock/rockchip,rk3368-cru.txt    | 61 -------------
 .../bindings/clock/rockchip,rk3368-cru.yaml   | 86 +++++++++++++++++++
 2 files changed, 86 insertions(+), 61 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.txt
deleted file mode 100644
index 7c8bbcfed..000000000
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-* Rockchip RK3368 Clock and Reset Unit
-
-The RK3368 clock controller generates and supplies clock to various
-controllers within the SoC and also implements a reset controller for SoC
-peripherals.
-
-Required Properties:
-
-- compatible: should be "rockchip,rk3368-cru"
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
-preprocessor macros in the dt-bindings/clock/rk3368-cru.h headers and can be
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
- - "ext_gmac" - external GMAC clock - optional
- - "ext_hsadc" - external HSADC clock - optional,
- - "ext_isp" - external ISP clock - optional,
- - "ext_jtag" - external JTAG clock - optional
- - "ext_vip" - external VIP clock - optional,
- - "usbotg_out" - output clock of the pll in the otg phy
-
-Example: Clock controller node:
-
-	cru: clock-controller@ff760000 {
-		compatible = "rockchip,rk3368-cru";
-		reg = <0x0 0xff760000 0x0 0x1000>;
-		rockchip,grf = <&grf>;
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
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml
new file mode 100644
index 000000000..b09d169c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3368-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3368 Clock and Reset Unit (CRU)
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The RK3368 clock controller generates and supplies clocks to various
+  controllers within the SoC and also implements a reset controller for SoC
+  peripherals.
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All available clocks are defined as
+  preprocessor macros in the dt-bindings/clock/rk3368-cru.h headers and can be
+  used in device tree sources. Similar macros exist for the reset sources in
+  these files.
+  There are several clocks that are generated outside the SoC. It is expected
+  that they are defined using standard clock bindings with the
+  clock-output-names defined in this schema.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3368-cru
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
+        - ext_i2s
+        - ext_gmac
+        - ext_hsadc
+        - ext_isp
+        - ext_jtag
+        - ext_vip
+        - usbotg_out
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
+      compatible = "rockchip,rk3368-cru";
+      reg = <0xff760000 0x1000>;
+      clocks = <&xin24m>;
+      clock-names = "xin24m";
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1


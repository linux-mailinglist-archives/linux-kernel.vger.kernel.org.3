Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07CF4F040B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356601AbiDBOip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356566AbiDBOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:38:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D74182AE9;
        Sat,  2 Apr 2022 07:36:46 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r13so11403622ejd.5;
        Sat, 02 Apr 2022 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufsyFzWX+CGvBkTM6+OlUoN/PVXoz5psm+dkWM18YxY=;
        b=CsaViOiw1wtT2ca0hqNq2k4rPL0P4BrLEaUK1vr8ezWHE1usaWJ2+tB3i8Kv79/nvT
         TFILa3c3gvlnXjwMS0EIt1ggkKsWjo+veW6SYhiStX7rLApFks72dsviBFHLURZZJkpt
         sD2HtG+lUOW9vnqPX9LpNxuip2v6tw+wzE1xZCFpD8ymIF2EscZD79/UY7m7TzBmqnQI
         zudasWsdDTIKctuaezV3psE930pYYQ5KNo3YfR9P6bOpBp3pVGs7y7NNvxl+Z3Oi9NjM
         jRRbuBfLT8NX6gKucTpIG5drpaM8qJPkAdMsfsgUcALbYxzIMM05qCtwX2tESkJVa/yW
         9wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufsyFzWX+CGvBkTM6+OlUoN/PVXoz5psm+dkWM18YxY=;
        b=bOdIdTfeA6/FkFVAccNB+nA7B+Rkf72WlGq+uupL5Sed0utals0o+fpXZvzwnOraXd
         sksw5/FYjOAiOODpQTOoKuXLuKhsBS3/FZ369tv3OQmxkbl7z61dUNIqM3bwsXm2U+3C
         /aFc9wmm2e1bKdxsV0OdAir1IQ3yn00YgGsJyz3yF8PZsOvJM3wn4lEu80rqPv3bkJSB
         qTkHDn9AJH9v/h54N0A4wUcekL09QNGvedKT7MvHiKJxymbznQJU5oJNctTWxoebR0Zl
         3JgjHUhUYBPkVi4qBWUC3TFRYgjJNwEdMgloKuO/GRcD6IxpkTpV6ZPU5QlVqWYX3ivv
         OYPg==
X-Gm-Message-State: AOAM533fMXHVEgwxfeSDrNcz7zRevete3I3AagrwdM1eLaoQYH4DBGFe
        Ze1FxWnhvYLVXNW2x5wTIIY=
X-Google-Smtp-Source: ABdhPJyKu2ptLDRlztPlfYTVwwF23IydRosnHQX9fwIkOdiZ72WUzQaJsA7kY6ipIsV6HPAerSZIFA==
X-Received: by 2002:a17:906:7943:b0:6df:e5b3:6553 with SMTP id l3-20020a170906794300b006dfe5b36553mr3994573ejo.398.1648910205452;
        Sat, 02 Apr 2022 07:36:45 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bp8-20020a170907918800b006e0daaa63ddsm2169557ejb.60.2022.04.02.07.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 07:36:45 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/16] dt-bindings: clock: convert rockchip,rk3036-cru.txt to YAML
Date:   Sat,  2 Apr 2022 16:36:22 +0200
Message-Id: <20220402143636.15222-3-jbx6244@gmail.com>
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

Convert rockchip,rk3036-cru.txt to YAML.

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
 .../bindings/clock/rockchip,rk3036-cru.txt    | 56 -------------
 .../bindings/clock/rockchip,rk3036-cru.yaml   | 80 +++++++++++++++++++
 2 files changed, 80 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.txt
deleted file mode 100644
index 20df350b9..000000000
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-* Rockchip RK3036 Clock and Reset Unit
-
-The RK3036 clock controller generates and supplies clock to various
-controllers within the SoC and also implements a reset controller for SoC
-peripherals.
-
-Required Properties:
-
-- compatible: should be "rockchip,rk3036-cru"
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
-preprocessor macros in the dt-bindings/clock/rk3036-cru.h headers and can be
-used in device tree sources. Similar macros exist for the reset sources in
-these files.
-
-External clocks:
-
-There are several clocks that are generated outside the SoC. It is expected
-that they are defined using standard clock bindings with following
-clock-output-names:
- - "xin24m" - crystal input - required,
- - "ext_i2s" - external I2S clock - optional,
- - "rmii_clkin" - external EMAC clock - optional
-
-Example: Clock controller node:
-
-	cru: cru@20000000 {
-		compatible = "rockchip,rk3036-cru";
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
-	uart0: serial@20060000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x20060000 0x100>;
-		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		clocks = <&cru SCLK_UART0>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml
new file mode 100644
index 000000000..121b298a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3036-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3036 Clock and Reset Unit (CRU)
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The RK3036 clock controller generates and supplies clocks to various
+  controllers within the SoC and also implements a reset controller for SoC
+  peripherals.
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All available clocks are defined as
+  preprocessor macros in the dt-bindings/clock/rk3036-cru.h headers and can be
+  used in device tree sources. Similar macros exist for the reset sources in
+  these files.
+  There are several clocks that are generated outside the SoC. It is expected
+  that they are defined using standard clock bindings with the
+  clock-output-names defined in this schema.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3036-cru
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum:
+        - xin24m
+        - ext_i2s
+        - rmii_clkin
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
+    cru: clock-controller@20000000 {
+      compatible = "rockchip,rk3036-cru";
+      reg = <0x20000000 0x1000>;
+      clocks = <&xin24m>;
+      clock-names = "xin24m";
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1


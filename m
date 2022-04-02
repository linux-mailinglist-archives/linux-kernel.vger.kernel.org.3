Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0679D4F0414
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356599AbiDBOjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356610AbiDBOi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:38:57 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60385182D96;
        Sat,  2 Apr 2022 07:36:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ot30so1483788ejb.12;
        Sat, 02 Apr 2022 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RI0GoRc5b1X0/vt9l1Smbq3N/ifsIvAYcPQbiupDesQ=;
        b=Fu/AyvztsYDGFE4E4SbHfWP3jdau9pB/RhNZtRTr4NEiw1+HpAsmxypnrgc3eRo3PN
         yxf7tfLd/8WleFomFsQAFVAY2P2s11ZRRnRrZDtw6JfaQX+dJG0N3l7Mg4jCkNX5Nh9f
         7LNzDlVxDYDHMvD2pAAMU2aPPNEx2HFh9DuVW/ZkJsmpEnVmai2WkRHnGLOzt0AX2lSG
         sTc76KvIh0+DE/bEG3jQSnXA1hKyGlHzCu+17XZqm0ITfxmpJkyjHzjvswUCf1Qe9Rzh
         jnZChEKN2Gxe/yjqtbMXag8rAHfE7Tfq4IYhvSiWw4fDr75CM0UfpLlZ9vqJfcbLNBV3
         nbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RI0GoRc5b1X0/vt9l1Smbq3N/ifsIvAYcPQbiupDesQ=;
        b=Kpkd+wreo5UytwZjmGJ8zHmYF5wuhtWiINCPwi+Smf7EM82luuFbcgKlPC5sBjYlFZ
         JLfWvhtXSUqsZdOfPXq1KLz9C45AB8j3rBSXaOjXYJEB8jbNLu+Q/imbDcLikwOR1ALi
         ka4X4bBwrefRZvNYgF6CSTcGkX3fTC9acPblnZRAx8P6k9iz2CVYCFj99rCFDieGvQ6O
         rGHf/4fzMdr9WRE1N2RXvwIW7w9fCiShfH3h8zB/H7q5z2ZHi4dy7EwP4lcPDkBe++1S
         KHPihAenJBfRJz3zO301JJa5oFiYLj9RM+tIa0gim7GU0+g1PNiT0L+RgdJyJvv37CWI
         6+kQ==
X-Gm-Message-State: AOAM5321b4P2fQAIS2+DpUbVcJtTMdEgskncsqnsCfSIZbdnh0Tlde97
        O05l+jf8oqbRmf/rTxwoBuq3o85UIOk=
X-Google-Smtp-Source: ABdhPJxjvkr5bVULkIKPFJH4QLeCWNip5rPSmhjzRxv3NkzjaHPu80dIevC+y3oKx/F/XxZBhky4fA==
X-Received: by 2002:a17:907:60cf:b0:6db:f0a6:74af with SMTP id hv15-20020a17090760cf00b006dbf0a674afmr3927634ejc.317.1648910211938;
        Sat, 02 Apr 2022 07:36:51 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bp8-20020a170907918800b006e0daaa63ddsm2169557ejb.60.2022.04.02.07.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 07:36:51 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/16] dt-bindings: clock: convert rockchip,rv1108-cru.txt to YAML
Date:   Sat,  2 Apr 2022 16:36:29 +0200
Message-Id: <20220402143636.15222-10-jbx6244@gmail.com>
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

Convert rockchip,rv1108-cru.txt to YAML.

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
 .../bindings/clock/rockchip,rv1108-cru.txt    | 59 -------------
 .../bindings/clock/rockchip,rv1108-cru.yaml   | 83 +++++++++++++++++++
 2 files changed, 83 insertions(+), 59 deletions(-)
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
index 000000000..abbfdfae8
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml
@@ -0,0 +1,83 @@
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
+  that they are defined using standard clock bindings with the
+  clock-output-names defined in this schema.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rv1108-cru
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 6
+
+  clock-names:
+    minItems: 1
+    maxItems: 6
+    items:
+      enum:
+        - xin24m
+        - ext_gmac
+        - ext_i2s
+        - ext_vip
+        - hdmiphy
+        - usbphy
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
+    cru: clock-controller@20200000 {
+      compatible = "rockchip,rv1108-cru";
+      reg = <0x20200000 0x1000>;
+      clocks = <&xin24m>;
+      clock-names = "xin24m";
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1


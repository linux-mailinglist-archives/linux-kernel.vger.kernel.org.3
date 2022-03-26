Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0E84E80B8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 13:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiCZMLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 08:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiCZML3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 08:11:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDA062A02;
        Sat, 26 Mar 2022 05:09:50 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x34so11893257ede.8;
        Sat, 26 Mar 2022 05:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rkpQ2CvLx5/YOytL3DUt1U7LW03Ve0SSyCtKDL1HKQY=;
        b=cv/OXQ3kn0vZd+oalJeNtX7VyFKKTOQdKzR0MzowDFH69xIOlKBGmPW2QBt1H/awLB
         EfkUgZd/oiK1dD+SvmSCVlRvuPGdppO/QDzvov6XSX5FJ+IRDdS1qUXWRhD6T8XZjdKk
         6nk4WYC5TIux739Y2eK1mrP8sdzSJm6UsaVasewRQ5EXUxCUUP0o1Bcwe+BVluvUhOq6
         8BlGcxm0jF0GfC6wDwuxntMb+hdGR0EXizhlJqgmbL2oFcTJSpoDl1kEczjrzfmIuqi8
         gSeWetQE8MRzsSit53Ow9rQ4PKfzDQIJJQL/8iSJemCBUX1XYnabzSKBDEJdDULFjKHS
         nkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rkpQ2CvLx5/YOytL3DUt1U7LW03Ve0SSyCtKDL1HKQY=;
        b=YIYc8IfnSE0T6gOVKv5eY/lefSezzeIPK29SEGxdFxfoQ5DVvzDmbFdAGUNz4Sp/W9
         AvJ0TrAKPqkU+X6eW/qDhIfkHqr4iYlmoSQDFnMcF80T8+Di6qOmxocH/WPVSSOMwIhC
         MgzTcUiZlIgVmKUY8Ne9OhHQlU2+GjxndNWAqgj9SdhGbb8P72odihLiR8QRIeVJ+Dl0
         usWl2B3npaKlTB0PE2BQvuskc1Na+htRWXmIrzeuVdxwjbL4HIVRPxfxUfVFuNpp56ke
         9HwICZh1GSVeJwfgsT+omB9iJpxBU+ClWQWxnXi6tnsVQErepuh7ByxSvdJmkZW3XmXo
         abew==
X-Gm-Message-State: AOAM5305d3g5Uin+CqZEpmle00tbxErKzci1WD7PATnT6ulocvEphjqs
        qi+Y6qjr9VUowqOmfx8uz89btNGksws=
X-Google-Smtp-Source: ABdhPJzTrzjvLOcgoh8sDDfmO2EFpSX8kVF9ThptSc0DTR0uV/5q6FdEiwo6Fc8Q/a0EnUykuXUzPQ==
X-Received: by 2002:aa7:c056:0:b0:418:e8d7:52a3 with SMTP id k22-20020aa7c056000000b00418e8d752a3mr3983658edo.301.1648296589084;
        Sat, 26 Mar 2022 05:09:49 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cr19-20020a170906d55300b006df6b316e29sm3559920ejc.208.2022.03.26.05.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 05:09:48 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: clock: convert rockchip,rk3288-cru.txt to YAML
Date:   Sat, 26 Mar 2022 13:09:41 +0100
Message-Id: <20220326120942.24008-1-jbx6244@gmail.com>
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

Current dts files with RK3288 'cru' nodes are manually verified.
In order to automate this process rockchip,rk3288-cru.txt has to be
converted to YAML.

Changed:
  Add properties to fix notifications by clocks.yaml for example:
    clocks
    clock-names

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/clock/rockchip,rk3288-cru.txt    | 67 ---------------
 .../bindings/clock/rockchip,rk3288-cru.yaml   | 83 +++++++++++++++++++
 2 files changed, 83 insertions(+), 67 deletions(-)
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
index 000000000..e5f89a78e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3288-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3288 Clock and Reset Unit (CRU)
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The RK3288 clock controller generates and supplies clock to various
+  controllers within the SoC and also implements a reset controller for SoC
+  peripherals.
+
+  A revision of this SoC is available: rk3288w. The clock tree is a bit
+  different so another dt-compatible is available. Noticed that it is only
+  setting the difference but there is no automatic revision detection. This
+  should be performed by bootloaders.
+
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All available clocks are defined as
+  preprocessor macros in the dt-bindings/clock/rk3288-cru.h headers and can be
+  used in device tree sources. Similar macros exist for the reset sources in
+  these files.
+
+  There are several clocks that are generated outside the SoC. It is expected
+  that they are defined using standard clock bindings with following
+  clock-output-names:
+    - "xin24m"      - crystal input               - required,
+    - "xin32k"      - rtc clock                   - optional,
+    - "ext_i2s"     - external I2S clock          - optional,
+    - "ext_hsadc"   - external HSADC clock        - optional,
+    - "ext_edp_24m" - external display port clock - optional,
+    - "ext_vip"     - external VIP clock          - optional,
+    - "ext_isp"     - external ISP clock          - optional,
+    - "ext_jtag"    - external JTAG clock         - optional
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
+      Phandle to the syscon managing the "general register files",
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
+    cru: clock-controller@ff760000 {
+      compatible = "rockchip,rk3288-cru";
+      reg = <0xff760000 0x1000>;
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3DB4EAC6C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbiC2Li5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiC2Lis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:38:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA6327CED;
        Tue, 29 Mar 2022 04:37:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bi12so34566904ejb.3;
        Tue, 29 Mar 2022 04:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hCnL6RKbl/0gd0mX1U+C8cwbrGEmpjTXEvUenDkK/s8=;
        b=QSObvql7zKYC/Y9Ep1oLf6rPg2Kba6oQ3Y7UXUmyIQ1q97G3vvf/6dnLeHtnNFFKj/
         y1VqwLolKGrSvzJcLBt2eiHw+wgAe+XdhnBDblexk490tRl9h2yeSyXgwl1srpgCGR2I
         RrGAssLMzNL+dEAqFwMaTmRAVf9P0JLXdeTZtIKuWb/FRrfNjjjq956U3Nww/ytcAZcP
         kOzoo8+aFHDDWTyrK/U7c1/0cGgirJoJ+TxO1IkLQeK4BA/+ZeZlDtpTSC3EVaVLo4sE
         yDw++DFXX9B1Eh/D0xmc/YnzN4lC0Zsn+8M8JLObxKn6vUJpgWCKRcz0HQ7Fz9at390i
         KEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hCnL6RKbl/0gd0mX1U+C8cwbrGEmpjTXEvUenDkK/s8=;
        b=aldQoQmkZK/bAfOJJJ1YujaX/4CEmRZ2JmbVFU5H7CPpkUw1qfdr+j0XSPey8901jc
         hI/Cgwtb6Qk5wuNMxRa5VyeOz1SHYIBQU+jAHRxzRjT8KCZKKbALHnYAZ+3y+y3m+a+I
         UrXJthGkFNtSnRyRaL+mZ+uvlZpn7w57JFv8kGsp5/rf6lRJHcepmiNMrQ7hqQmwX9mN
         J2f+1BphIevZSqTIM5uUA4mQUnT06nBS7XHIo0KTc7MbSKT3AbuHJpkDxyvTaSOuPDFt
         8V5QbZ/73PLR6STScyBSlMdDN/CftMwWz0edcCZffcIW2W1zfCUG0t+bYyjAA8OZY5uW
         MlrA==
X-Gm-Message-State: AOAM530Sa010JC02jPbBoDRUJMuIJaTeYZ5zFAArhY5/w0ttMVEn+te1
        xBKs2eYy8XQIdxHLoSvdmVA=
X-Google-Smtp-Source: ABdhPJz7dLbUR2EgWOc3/DD5a6k2wltDDSvCJ/1rDHOJTmrTDeh63dCToD05ccbHbD5ER8aep7/hwg==
X-Received: by 2002:a17:906:c0d6:b0:6ca:457e:f1b7 with SMTP id bn22-20020a170906c0d600b006ca457ef1b7mr33973744ejb.399.1648553824050;
        Tue, 29 Mar 2022 04:37:04 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id da19-20020a056402177300b00413583e0996sm8171298edb.14.2022.03.29.04.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:37:03 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: clock: convert rockchip,rk3288-cru.txt to YAML
Date:   Tue, 29 Mar 2022 13:36:56 +0200
Message-Id: <20220329113657.4567-1-jbx6244@gmail.com>
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

Changed V2:
  add Rockchip maintainer on her request
  fix yamllint line too long
  restyle
---
 .../bindings/clock/rockchip,rk3288-cru.txt    | 67 ---------------
 .../bindings/clock/rockchip,rk3288-cru.yaml   | 85 +++++++++++++++++++
 2 files changed, 85 insertions(+), 67 deletions(-)
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
index 000000000..96bc05749
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
@@ -0,0 +1,85 @@
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
+    cru: clock-controller@ff760000 {
+      compatible = "rockchip,rk3288-cru";
+      reg = <0xff760000 0x1000>;
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5234EC210
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345119AbiC3L6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344444AbiC3LxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:53:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9CF261DF7;
        Wed, 30 Mar 2022 04:48:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bh17so1480145ejb.8;
        Wed, 30 Mar 2022 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QnygP4l4hTZOc+NFDXu9YYi5sXjYreslpEJf/CgWJFU=;
        b=L4D9vUp++dIar8oRx2cyilIRQpIbE8aTyXC7bD8/IQy5GxKarN9FPrJKt8vtzjtYK8
         MWTYlILu33ArTJ8ShiNwg1pOMYcgFwQvMJxcreeKPzN0tspJ0HK9Yvu3oyTPvtYsKJXY
         IrJRaZzbDlhgURR2UzliOGVkpCwaS/l/3LhQN91N195HK0ckoaGVLdgtxcOB+ZXdYCmO
         KpMOKWoRLB501a9wQuKcFWp4n0UldaFxeDVLCR3ANYXQd1VaIBpvr2dr5wwOAEQKtRzy
         79Awx4y8ntCN3kwn5zGGwY7kDivYHem6swodfHzXGGOC7J6lAfxvHZom9ftcccvbj5Vp
         ROTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QnygP4l4hTZOc+NFDXu9YYi5sXjYreslpEJf/CgWJFU=;
        b=EYHGByaBKjGSO76P33iJA2BRFm0FgpaaMx35mYyMF5XMGudyOjqsQQ/OT79GRMsIII
         MdbCjb4jHRr4/4x5kdfdNXgryFQzovTov0kBTx7F7wehC+rqVEtbLstdyJdahIbVZnt2
         dBR+JZhESgcP0eB87Otc/tZVVakTzW4yU/G5AvZHRIM1pgJ1dNTE+ehQQ4KOvC8yjTX5
         6EPGbuVRSU3eUYDwmspsTHag1x5LGY/o4d+Zc37nwPMKzyLUCqUY/uSBdRQG1365/VT1
         CvfmNcYAyjXuMbUF+n1dzixf71ce8CDQopP5IS3FxCUgQr0at1f+h7sZAt20ROfOz97A
         7Mcw==
X-Gm-Message-State: AOAM531UUrGSJRXZPf5fs3X3vNZrjv+v4bJ7rLe4PA56dtIugVaoTM3l
        bavbolBmUw/s2GtRoIwVOiggoNHQyPA=
X-Google-Smtp-Source: ABdhPJw4fExfdVyAn2ssY8SyPCua0EfDQ35g+WWMCOkxPzNpgIv/ZzrQ/OVM2E3Kzv+Bw3J5rAnauQ==
X-Received: by 2002:a17:907:94c6:b0:6da:9561:ce0 with SMTP id dn6-20020a17090794c600b006da95610ce0mr38918680ejc.342.1648640933738;
        Wed, 30 Mar 2022 04:48:53 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g9-20020aa7c849000000b00412fc6bf26dsm9934442edt.80.2022.03.30.04.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 04:48:53 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: clock: convert rockchip,rk3036-cru.txt to YAML
Date:   Wed, 30 Mar 2022 13:48:45 +0200
Message-Id: <20220330114847.18633-1-jbx6244@gmail.com>
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

Convert rockchip,rk3036-cru.txt to YAML.

Changes against original bindings:
  Add clocks and clock-names because the device has to have
  at least one input clock.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/clock/rockchip,rk3036-cru.txt    | 56 ---------------
 .../bindings/clock/rockchip,rk3036-cru.yaml   | 72 +++++++++++++++++++
 2 files changed, 72 insertions(+), 56 deletions(-)
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
index 000000000..1376230fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml
@@ -0,0 +1,72 @@
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
+  that they are defined using standard clock bindings with following
+  clock-output-names:
+    - "xin24m"     - crystal input       - required
+    - "ext_i2s"    - external I2S clock  - optional
+    - "rmii_clkin" - external EMAC clock - optional
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3036-cru
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
+    cru: clock-controller@20000000 {
+      compatible = "rockchip,rk3036-cru";
+      reg = <0x20000000 0x1000>;
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1


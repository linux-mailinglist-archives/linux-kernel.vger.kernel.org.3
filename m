Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67244EB31D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbiC2SHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238435AbiC2SHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:07:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ED4B1A99;
        Tue, 29 Mar 2022 11:05:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id yy13so36772123ejb.2;
        Tue, 29 Mar 2022 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e4m/D5l3KDsPRngzvS7EkoWX9CMsR37lkK4pBdzetSc=;
        b=pt9656q6hUdtbj96D1qtMoWStCNlo95qQx2puqQPY5hoRO9MB9jgAhUkV2Z82MvUqV
         FCU5jda68sBkoh30nVPoCUvlrqU12AEO6xg2EAYSvd0YDRvJ9ws4EAwJ5TTMkcEnUJP8
         OkD0in1ATcmXBgD52BwsIrh9eoRNvt2x1TKELXxrmimAj/eiyJgOLSnxDdWAfIQ6AYv+
         iqiciZuYaMVSgPRcWOV1EsjaOC9k1lLn3XO/ikNWCO0RgERceQQXcKi2XQDD6XjKVGrT
         kOtUU374RthsotLgZmnWg8oynYwSqeloOjzNBfkho+g0oWABerVjG7sodNI5m3+0zOna
         FMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e4m/D5l3KDsPRngzvS7EkoWX9CMsR37lkK4pBdzetSc=;
        b=UXdLvhKmlGOGexs/qbtMDK8Z5wIcS/szZGFAhT8KWMYEGRWinamv2P/FRoFtOFcnWg
         Iemn3zPHk/ZQ8XK41H1ANcqIR8PdYQiyeZLkQn1YxsN8b7K7zOD3pPEp+crBiGIlSbns
         vw7mYumFyLtCChwPIR5I8BIAmN1odQ0TBPC4mSL0A1+10+vPCSIst/YxUQ3MN3UOR6pw
         g+P9tBRGOEw4UK6JRALYkE47uSIhwboWlv5VpQCJgxZIDB7U3yCgcyBVrGrBgJt9S9sa
         Wdu6za2aNo08/I009DLAaKO9xLU5tP42rKGFrwamLWuEGLF1H4m+u+RHYBF9lGMUf3QP
         fOkA==
X-Gm-Message-State: AOAM533YjaynZPPex3E9Knz12sv1pOuXlFygyDWwbgZRHpTQm04Hytmj
        3uAEVc5hd+P3f4GL/CWaO8QzYYYotkg=
X-Google-Smtp-Source: ABdhPJxsIoyAWSdjq/D3fR6BX5MlUInd3wY5rUSex5bsHFuGwqz4q9B8RSkRFY0vtZRNhcfdHjgYFw==
X-Received: by 2002:a17:907:1b15:b0:6d7:13bd:dd62 with SMTP id mp21-20020a1709071b1500b006d713bddd62mr35310420ejc.673.1648577156966;
        Tue, 29 Mar 2022 11:05:56 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906255500b006e08c4862ccsm6443616ejb.96.2022.03.29.11.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 11:05:56 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: clock: convert rockchip,rk3368-cru.txt to YAML
Date:   Tue, 29 Mar 2022 20:05:49 +0200
Message-Id: <20220329180550.31043-1-jbx6244@gmail.com>
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

Convert rockchip,rk3368-cru.txt to YAML.

Changes against original bindings:
 - Add clocks and clock-names because the device has to have
   at least one input clock.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/clock/rockchip,rk3368-cru.txt    | 61 ---------------
 .../bindings/clock/rockchip,rk3368-cru.yaml   | 78 +++++++++++++++++++
 2 files changed, 78 insertions(+), 61 deletions(-)
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
index 000000000..adb678777
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml
@@ -0,0 +1,78 @@
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
+  that they are defined using standard clock bindings with following
+  clock-output-names:
+    - "xin24m"     - crystal input                          - required
+    - "xin32k"     - rtc clock                              - optional
+    - "ext_i2s"    - external I2S clock                     - optional
+    - "ext_gmac"   - external GMAC clock                    - optional
+    - "ext_hsadc"  - external HSADC clock                   - optional
+    - "ext_isp"    - external ISP clock                     - optional
+    - "ext_jtag"   - external JTAG clock                    - optional
+    - "ext_vip"    - external VIP clock                     - optional
+    - "usbotg_out" - output clock of the pll in the otg phy
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3368-cru
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
+      compatible = "rockchip,rk3368-cru";
+      reg = <0xff760000 0x1000>;
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1


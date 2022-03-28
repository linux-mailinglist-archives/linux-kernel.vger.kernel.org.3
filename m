Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C3E4E8C22
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbiC1Cax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbiC1Cav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:30:51 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 878433B2AA;
        Sun, 27 Mar 2022 19:29:10 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:36846.2128613048
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id E75071002AD;
        Mon, 28 Mar 2022 10:28:56 +0800 (CST)
Received: from  ([172.27.8.53])
        by gateway-151646-dep-b7fbf7d79-bwdqx with ESMTP id a5209208547c4c5d897db3cc05d5d19f for mripard@kernel.org;
        Mon, 28 Mar 2022 10:29:09 CST
X-Transaction-ID: a5209208547c4c5d897db3cc05d5d19f
X-Real-From: 15330273260@189.cn
X-Receive-IP: 172.27.8.53
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v13 3/6] dt-bindings: display: Add Loongson display controller
Date:   Mon, 28 Mar 2022 10:28:32 +0800
Message-Id: <20220328022835.2508587-3-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328022835.2508587-1-15330273260@189.cn>
References: <20220328022835.2508587-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings and simple usages for Loongson display controller
found in LS7A1000 bridge chip and LS2k1000 SoC.

Signed-off-by: Sui Jingfeng <15330273260@189.cn>
---
 .../loongson/loongson,display-controller.yaml | 321 ++++++++++++++++++
 1 file changed, 321 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml

diff --git a/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
new file mode 100644
index 000000000000..34060ed55a25
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
@@ -0,0 +1,321 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/loongson/loongson,display-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson LS7A1000/LS2K1000/LS2K0500 Display Controller Device Tree Bindings
+
+maintainers:
+  - Sui Jingfeng <suijingfeng@loongson.cn>
+
+description: |+
+
+  Loongson display controllers are simple which require scanout buffers
+  to be physically contiguous. LS2K1000/LS2K0500 is a SOC, only system
+  memory is available. LS7A1000/LS7A2000 is bridge chip which is equipped
+  with a dedicated video RAM which is 64MB or more, precise size can be
+  read from the PCI BAR 2 of the GPU device(0x0014:0x7A15) in the bridge
+  chip.
+
+  LSDC has two display pipes, each way has a DVO interface which provide
+  RGB888 signals, vertical & horizontal synchronisations, data enable and
+  the pixel clock. LSDC has two CRTC, each CRTC is able to scanout from
+  1920x1080 resolution at 60Hz. Each CRTC has two FB address registers.
+
+  For LS7A1000, there are 4 dedicated GPIOs whose control register is
+  located at the DC register space. They are used to emulate two way i2c,
+  One for DVO0, another for DVO1.
+
+  LS2K1000 and LS2K0500 SoC grab i2c adapter from other module, either
+  general purpose GPIO emulated i2c or hardware i2c in the SoC.
+
+  LSDC's display pipeline have several components as below description,
+
+  The display controller in LS7A1000:
+     ___________________                                     _________
+    |            -------|                                   |         |
+    |  CRTC0 --> | DVO0 ----> Encoder0 ---> Connector0 ---> | Monitor |
+    |  _   _     -------|        ^             ^            |_________|
+    | | | | |    -------|        |             |
+    | |_| |_|    | i2c0 <--------+-------------+
+    |            -------|
+    |   DC IN LS7A1000  |
+    |  _   _     -------|
+    | | | | |    | i2c1 <--------+-------------+
+    | |_| |_|    -------|        |             |             _________
+    |            -------|        |             |            |         |
+    |  CRTC1 --> | DVO1 ----> Encoder1 ---> Connector1 ---> |  Panel  |
+    |            -------|                                   |_________|
+    |___________________|
+
+  Simple usage of LS7A1000 with LS3A4000 CPU:
+
+    +------+            +------------------------------------+
+    | DDR4 |            |  +-------------------+             |
+    +------+            |  | PCIe Root complex |   LS7A1000  |
+       || MC0           |  +--++---------++----+             |
+  +----------+  HT 3.0  |     ||         ||                  |
+  | LS3A4000 |<-------->| +---++---+  +--++--+     +---------+   +------+
+  |   CPU    |<-------->| | GC1000 |  | LSDC |<--->| DDR3 MC |<->| VRAM |
+  +----------+          | +--------+  +-+--+-+     +---------+   +------+
+       || MC1           +---------------|--|-----------------+
+    +------+                            |  |
+    | DDR4 |          +-------+   DVO0  |  |  DVO1   +------+
+    +------+   VGA <--|ADV7125|<--------+  +-------->|TFP410|--> DVI/HDMI
+                      +-------+                      +------+
+
+  The display controller in LS2K1000/LS2K0500:
+     ___________________                                     _________
+    |            -------|                                   |         |
+    |  CRTC0 --> | DVO0 ----> Encoder0 ---> Connector0 ---> | Monitor |
+    |  _   _     -------|        ^              ^           |_________|
+    | | | | |           |        |              |
+    | |_| |_|           |     +------+          |
+    |                   <---->| i2c0 |<---------+
+    |   DC IN LS2K1000  |     +------+
+    |  _   _            |     +------+
+    | | | | |           <---->| i2c1 |----------+
+    | |_| |_|           |     +------+          |            _________
+    |            -------|        |              |           |         |
+    |  CRTC1 --> | DVO1 ----> Encoder1 ---> Connector1 ---> |  Panel  |
+    |            -------|                                   |_________|
+    |___________________|
+
+properties:
+  $nodename:
+    pattern: "^display-controller@[0-9a-f],[0-9a-f]$"
+
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - loongson,ls7a1000-dc
+              - loongson,ls2k1000-dc
+              - loongson,ls2k0500-dc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  i2c@6:
+    $ref: /schemas/i2c/i2c-controller.yaml#
+    description: |
+      Built-in GPIO emulate i2c exported for display bridge configuration,
+      monitor detection and edid read back etc, for ls7a1000 only.
+
+    properties:
+      $nodename:
+        const: i2c
+
+      compatible:
+        const: loongson,gpio-i2c
+
+      reg:
+        minItems: 1
+        description: address offset and range
+
+      loongson,nr:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Indicates the I2C bus number this DT node represents.
+
+      loongson,sda:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: gpio pin used for the sda signal
+
+      loongson,scl:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: gpio pin used for the scl signal
+
+      loongson,udelay:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: delay between GPIO operations, unit is us.
+
+      loongson,timeout:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: timeout to get data, unit is ms.
+
+    required:
+      - compatible
+      - loongson,sda
+      - loongson,scl
+      - loongson,nr
+
+  i2c@7:
+    $ref: /schemas/i2c/i2c-controller.yaml#
+    description: |
+      Built-in GPIO emulate i2c exported for display bridge configuration,
+      monitor detection and edid read back etc, for ls7a1000 only.
+    properties:
+      $nodename:
+        const: i2c
+
+      compatible:
+        const: loongson,gpio-i2c
+
+      reg:
+        minItems: 1
+        description: address offset and range
+
+      loongson,nr:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Indicates the I2C bus number this DT node represents.
+
+      loongson,sda:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: gpio pin used for the sda signal
+
+      loongson,scl:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: gpio pin used for the scl signal
+
+      loongson,udelay:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: delay between GPIO operations, unit is us.
+
+      loongson,timeout:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: timeout to get data, unit is ms.
+
+    required:
+      - compatible
+      - loongson,sda
+      - loongson,scl
+      - loongson,nr
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: output port node connected with DPI panels or external encoders, with only one endpoint.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: output port node connected with DPI panels or external encoders, with only one endpoint.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    bus {
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+        #interrupt-cells = <2>;
+
+        display-controller@6,1 {
+            compatible = "loongson,ls7a1000-dc";
+            reg = <0x3100 0x0 0x0 0x0 0x0>;
+            interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    bus {
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+        #interrupt-cells = <2>;
+
+        display-controller@6,1 {
+            compatible = "loongson,ls7a1000-dc";
+            reg = <0x3100 0x0 0x0 0x0 0x0>;
+            interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            i2c@6 {
+                compatible = "loongson,gpio-i2c";
+                reg = <0x00001650 0x00000020>;
+                loongson,nr = <6>;
+                loongson,sda = <0>;
+                loongson,scl = <1>;
+                loongson,udelay = <5>;
+                loongson,timeout = <2200>;
+            };
+
+            i2c@7 {
+                compatible = "loongson,gpio-i2c";
+                reg = <0x00001650 0x00000020>;
+                loongson,nr = <7>;
+                loongson,sda = <2>;
+                loongson,scl = <3>;
+                loongson,udelay = <5>;
+                loongson,timeout = <2200>;
+            };
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                port@0 {
+                    reg = <0>;
+                    endpoint {
+                            remote-endpoint = <&vga_encoder_in>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    endpoint {
+                            remote-endpoint = <&dvi_encoder_in>;
+                    };
+                };
+            };
+        };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    bus {
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+        #interrupt-cells = <2>;
+
+        display-controller@6,0 {
+            compatible = "loongson,ls2k1000-dc";
+            reg = <0x3100 0x0 0x0 0x0 0x0>;
+            interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                port@0 {
+                    reg = <0>;
+                    endpoint {
+                            remote-endpoint = <&panel_in>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    endpoint {
+                            remote-endpoint = <&hdmi_encoder_in>;
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.25.1


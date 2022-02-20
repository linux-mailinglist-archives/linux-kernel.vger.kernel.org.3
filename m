Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CBD4BCF21
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 15:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbiBTO4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 09:56:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244045AbiBTO43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 09:56:29 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59C8845ADD;
        Sun, 20 Feb 2022 06:56:06 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.41:45934.2136022094
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 8B60E1002AB;
        Sun, 20 Feb 2022 22:56:04 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-9vctg with ESMTP id a3d8657f1f5e402daacebd602d06d102 for mripard@kernel.org;
        Sun, 20 Feb 2022 22:56:05 CST
X-Transaction-ID: a3d8657f1f5e402daacebd602d06d102
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
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
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 2/4] Documentation/dt: Add descriptions for loongson display controller
Date:   Sun, 20 Feb 2022 22:55:52 +0800
Message-Id: <20220220145554.117854-3-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220220145554.117854-1-15330273260@189.cn>
References: <20220220145554.117854-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: suijingfeng <suijingfeng@loongson.cn>

Add DT documentation for loongson display controller found in LS2K1000,
LS2K0500 and LS7A1000.

v2: DT binding docs and includes should be a separate patch,
    fix a warnning because of that.

v3: split dt-bindings from other changes into a separate patch.

v4: fix warnings and errors when running make dt_binding_check

Reported-by: Rob Herring <robh@kernel.org>
Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
Signed-off-by: Sui Jingfeng <15330273260@189.cn>
---
 .../loongson/loongson,display-controller.yaml | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml

diff --git a/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
new file mode 100644
index 000000000000..ee1a59b91943
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
@@ -0,0 +1,122 @@
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
+  with a dedicated video ram which is 64MB or more.
+
+  For LS7A1000, there are 4 dedicated GPIOs whose control register is
+  located at the DC register space. They are used to emulate two way i2c,
+  One for DVO0, another for DVO1.
+
+  LS2K1000 and LS2K0500 SoC grab i2c adapter from other module, either
+  general purpose GPIO emulated i2c or hardware i2c in the SoC.
+
+  LSDC has two display pipes, each way has a DVO interface which provide
+  RGB888 signals, vertical & horizontal synchronisations, data enable and
+  the pixel clock. LSDC has two CRTC, each CRTC is able to scanout from
+  1920x1080 resolution at 60Hz. Each CRTC has two FB address registers.
+
+  LSDC's display pipeline have several components as below description,
+
+  The display controller in LS7A1000:
+    ___________________                                     _________
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
+    +------+            +-----------------------------------+
+    | DDR4 |            |  +-------------------+            |
+    +------+            |  | PCIe Root complex |   LS7A1000 |
+       || MC0           |  +--++---------++----+            |
+  +----------+  HT 3.0  |     ||         ||                 |
+  | LS3A4000 |<-------->| +---++---+  +--++--+    +---------+   +------+
+  |   CPU    |<-------->| | GC1000 |  | LSDC |<-->| DDR3 MC |<->| VRAM |
+  +----------+          | +--------+  +-+--+-+    +---------+   +------+
+       || MC1           +---------------|--|----------------+
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
+    enum:
+      - loongson,ls7a1000-dc
+      - loongson,ls2k1000-dc
+      - loongson,ls2k0500-dc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+        lsdc: display-controller@6,1 {
+            compatible = "loongson,ls7a1000-dc";
+            reg = <0x3100 0x0 0x0 0x0 0x0>;
+            interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-parent = <&pic>;
+        };
+    };
+...
-- 
2.25.1


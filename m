Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58F24E8779
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 13:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiC0Lky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 07:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiC0Lku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 07:40:50 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30C9C4707A;
        Sun, 27 Mar 2022 04:39:11 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:60662.210632910
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 76E2B10026E;
        Sun, 27 Mar 2022 19:39:06 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-bwdqx with ESMTP id 14d6f6b8f8744900a8fa84a75f6847a9 for mripard@kernel.org;
        Sun, 27 Mar 2022 19:39:10 CST
X-Transaction-ID: 14d6f6b8f8744900a8fa84a75f6847a9
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
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v12 2/6] MIPS: Loongson64: introduce board specific dts and add model property
Date:   Sun, 27 Mar 2022 19:38:42 +0800
Message-Id: <20220327113846.2498146-3-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220327113846.2498146-1-15330273260@189.cn>
References: <20220327113846.2498146-1-15330273260@189.cn>
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

This patch introduce three board specific dts and assign different
model property to them according to the board name on the top overlay
of the PCB.

The model property added is used to provide board specific information,
mips kernel use it as machine name. For example:

$ cat /proc/cpuinfo

system type             : Generic Loongson64 System
machine                 : LX-6901  <-------------------- notice here
processor               : 0
cpu model               : ICT Loongson-3 V0.1  FPU V0.1
BogoMIPS                : 3594.02
tlb_entries             : 2112
isa                     : mips64r2
ASEs implemented        : vz msa loongson-ext2
...

1) ls3A4000 evaluation board

  The board name is LS3A4000_7A1000_EVB_BOARD_V1.4, it consist of 1.8Ghz
  mips64r5 4-core CPU and LS7A1000 bridge chip. It has PCIe GEN2 x8 slot,
  therefore can play with discrete graphics card.

  While the integrated display copntroller is equipped with a VGA output
  and a DVI output, the VGA is connect to the DVO0 output port of the
  display controller, the DVI is connected to DVO1 output port of the
  display controller.

    +------+            +-----------------------------------+
    | DDR4 |            |  +-------------------+            |
    +------+            |  | PCIe Root complex |   LS7A1000 |
       || MC0           |  +--++---------++----+            |
  +----------+  HT 3.0  |     ||         ||                 |
  | LS3A4000 |<-------->| +---++---+  +--++--+    +---------+   +------+
  |   CPU    |<-------->| | GC1000 |  | LSDC |<-->| DDR3 MC |<->| VRAM |
  +----------+          | +--------+  +-+--+-+    +---------+   +------+
       || MC1           +---------------|--|----------------+
    +------+                            |  |
    | DDR4 |          +-------+   DVO0  |  |  DVO1   +------+
    +------+   VGA <--|ADV7125|<--------+  +-------->|TFP410|--> DVI/HDMI
                      +-------+                      +------+

2) lemote A1901 motherboard

  This board is made by LEMOTE corporation, it has two name, one is
  LX-6901, another is A1901. This board has only one VGA output which
  is connected to the DVO1 of the display controller.

    +------+            +-----------------------------------+
    | DDR4 |            |  +-------------------+            |
    +------+            |  | PCIe Root complex |   LS7A1000 |
       || MC0           |  +--++---------++----+            |
  +----------+  HT 3.0  |     ||         ||                 |
  | LS3A4000 |<-------->| +---++---+  +--++--+    +---------+   +------+
  |   CPU    |<-------->| | GC1000 |  | LSDC |<-->| DDR3 MC |<->| VRAM |
  +----------+          | +--------+  +-+--+-+    +---------+   +------+
       || MC1           +---------------|--|----------------+
    +------+                            |  |
    | DDR4 |       DVO0 is not get used |  |  DVO1   +-------+
    +------+       <--------------------+  +-------->|ADV7125|---> VGA
                                                     +-------+

3) ls2k1000 pai evaluation board

  ls2k1000 is a two core 1.0Ghz Mips64r2 compatible SoC, desprite very
  slow, lacking i2c driver support, various display dridge drivers can
  only be tested on it. We still try to provide a minimal support.
   ___________________                           ____________________
  |            -------|                         |                    |
  |  CRTC0 --> | DVO0 ------------------------> | 1024x600 DPI Panel |
  |  _   _     -------|  | Which panel to use   |____________________|
  | | | | |           |  | with this board is a  ___________________
  | |_| |_|           |  | choice of the user   |                   |
  |                   |  +--------------------> | 800x480 DPI Panel |
  |   DC In LS2K1000  |                         |___________________|
  |  _   _            |     +------+
  | | | | |           <---->| i2c1 |-----------+
  | |_| |_|           |     +------+           |
  |                   |        | <--- config   | DDC           _________
  |            -------|    +---------+         |              |         |
  |  CRTC1 --> | DVO1 ---> | sii9022 | --> HDMI connector --> | Monitor |
  |            -------|    +---------+                        |_________|
  |___________________|

  The sii9022 HDMI transmitter working in transparent mode, because the
  PCB designer make the board working in this way. In this case the EDID
  is read from the monitor directly, not through sii9022's ddc channel.
  The i2c0 is not get used by lsdc driver for this board.

Signed-off-by: Sui Jingfeng <15330273260@189.cn>
---
 arch/mips/boot/dts/loongson/Makefile          |   4 +
 arch/mips/boot/dts/loongson/lemote_a1901.dts  |  96 ++++++++++++
 .../boot/dts/loongson/ls2k1000_pai_udb.dts    | 107 ++++++++++++++
 .../boot/dts/loongson/ls3a4000_7a1000_evb.dts | 138 ++++++++++++++++++
 4 files changed, 345 insertions(+)
 create mode 100644 arch/mips/boot/dts/loongson/lemote_a1901.dts
 create mode 100644 arch/mips/boot/dts/loongson/ls2k1000_pai_udb.dts
 create mode 100644 arch/mips/boot/dts/loongson/ls3a4000_7a1000_evb.dts

diff --git a/arch/mips/boot/dts/loongson/Makefile b/arch/mips/boot/dts/loongson/Makefile
index 5c6433e441ee..c60acbafbfce 100644
--- a/arch/mips/boot/dts/loongson/Makefile
+++ b/arch/mips/boot/dts/loongson/Makefile
@@ -6,4 +6,8 @@ dtb-$(CONFIG_MACH_LOONGSON64)	+= loongson64c_8core_rs780e.dtb
 dtb-$(CONFIG_MACH_LOONGSON64)	+= loongson64g_4core_ls7a.dtb
 dtb-$(CONFIG_MACH_LOONGSON64)	+= loongson64v_4core_virtio.dtb
 
+dtb-$(CONFIG_MACH_LOONGSON64)	+= ls2k1000_pai_udb.dtb
+dtb-$(CONFIG_MACH_LOONGSON64)	+= lemote_a1901.dtb
+dtb-$(CONFIG_MACH_LOONGSON64)	+= ls3a4000_7a1000_evb.dtb
+
 obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/loongson/lemote_a1901.dts b/arch/mips/boot/dts/loongson/lemote_a1901.dts
new file mode 100644
index 000000000000..880bb9153c03
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/lemote_a1901.dts
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "loongson64g-package.dtsi"
+#include "ls7a-pch.dtsi"
+
+/ {
+	model = "LX-6901";
+
+	vga-encoder {
+		compatible = "adi,adv7123", "dumb-vga-dac";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				adv7123_in: endpoint {
+					remote-endpoint = <&dc_out_rgb1>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				adv7123_out: endpoint {
+					remote-endpoint = <&vga_connector_in>;
+				};
+			};
+		};
+	};
+
+	vga-connector {
+		compatible = "vga-connector";
+		label = "vga";
+
+		ddc-i2c-bus = <&i2c7>;
+
+		port {
+			vga_connector_in: endpoint {
+				remote-endpoint = <&adv7123_out>;
+			};
+		};
+	};
+};
+
+&package0 {
+	htvec: interrupt-controller@efdfb000080 {
+		compatible = "loongson,htvec-1.0";
+		reg = <0xefd 0xfb000080 0x40>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&liointc>;
+		interrupts = <24 IRQ_TYPE_LEVEL_HIGH>,
+			     <25 IRQ_TYPE_LEVEL_HIGH>,
+			     <26 IRQ_TYPE_LEVEL_HIGH>,
+			     <27 IRQ_TYPE_LEVEL_HIGH>,
+			     <28 IRQ_TYPE_LEVEL_HIGH>,
+			     <29 IRQ_TYPE_LEVEL_HIGH>,
+			     <30 IRQ_TYPE_LEVEL_HIGH>,
+			     <31 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
+&pch {
+	msi: msi-controller@2ff00000 {
+		compatible = "loongson,pch-msi-1.0";
+		reg = <0 0x2ff00000 0 0x8>;
+		interrupt-controller;
+		msi-controller;
+		loongson,msi-base-vec = <64>;
+		loongson,msi-num-vecs = <192>;
+		interrupt-parent = <&htvec>;
+	};
+};
+
+&lsdc {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			status = "disabled";
+		};
+
+		port@1 {
+			reg = <1>;
+			status = "ok";
+			dc_out_rgb1: endpoint {
+				remote-endpoint = <&adv7123_in>;
+			};
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/loongson/ls2k1000_pai_udb.dts b/arch/mips/boot/dts/loongson/ls2k1000_pai_udb.dts
new file mode 100644
index 000000000000..972987975ada
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/ls2k1000_pai_udb.dts
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "loongson64-2k1000.dtsi"
+
+/ {
+	model = "LS2K1000_PAI_UDB_V1.5";
+
+	panel: display@0 {
+		compatible = "panel-dpi";
+		label = "LCD070CG1024600+DC21";
+
+		rotation = <0>;
+		width-mm = <86>;
+		height-mm = <154>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			panel_in: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&dc_out_rgb0>;
+			};
+		};
+
+		panel-timing {
+			clock-frequency = <51200000>;
+			hactive = <1024>;
+			vactive = <600>;
+			hsync-len = <4>;
+			hfront-porch = <160>;
+			hback-porch = <156>;
+			vfront-porch = <11>;
+			vback-porch = <23>;
+			vsync-len = <1>;
+
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+	};
+
+	monitor: display@1 {
+		compatible = "panel-dpi";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			monitor_in: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&dc_out_rgb1>;
+			};
+		};
+
+		panel-timing {
+			clock-frequency = <65000000>;
+			hactive = <1024>;
+			vactive = <768>;
+			hfront-porch = <24>;
+			hsync-len = <136>;
+			hback-porch = <160>;
+			vfront-porch = <3>;
+			vback-porch = <6>;
+			vsync-len = <29>;
+
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+	};
+};
+
+&lsdc {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dc_out_rgb0: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dc_out_rgb1: endpoint {
+				remote-endpoint = <&monitor_in>;
+			};
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/loongson/ls3a4000_7a1000_evb.dts b/arch/mips/boot/dts/loongson/ls3a4000_7a1000_evb.dts
new file mode 100644
index 000000000000..e342eb9ea12e
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/ls3a4000_7a1000_evb.dts
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "loongson64g-package.dtsi"
+#include "ls7a-pch.dtsi"
+
+/ {
+	compatible = "loongson,loongson64g-4core-ls7a";
+	model = "LS3A4000_7A1000_EVB_BOARD_V1.4";
+
+	vga-encoder {
+		compatible = "adi,adv7123", "dumb-vga-dac";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				adv7123_in: endpoint {
+					remote-endpoint = <&dc_out_rgb0>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				adv7123_out: endpoint {
+					remote-endpoint = <&vga_connector_in>;
+				};
+			};
+		};
+	};
+
+	vga-connector {
+		compatible = "vga-connector";
+		label = "vga";
+
+		ddc-i2c-bus = <&i2c6>;
+
+		port {
+			vga_connector_in: endpoint {
+				remote-endpoint = <&adv7123_out>;
+			};
+		};
+	};
+
+	tfp410: dvi-encoder {
+		compatible = "ti,tfp410";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				tfp410_in: endpoint {
+					pclk-sample = <1>;
+					bus-width = <24>;
+					remote-endpoint = <&dc_out_rgb1>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				tfp410_out: endpoint {
+					remote-endpoint = <&dvi_connector_in>;
+				};
+			};
+		};
+	};
+
+	dvi-connector {
+		compatible = "dvi-connector";
+		label = "dvi";
+		digital;
+
+		ddc-i2c-bus = <&i2c7>;
+
+		port {
+			dvi_connector_in: endpoint {
+				remote-endpoint = <&tfp410_out>;
+			};
+		};
+	};
+};
+
+&package0 {
+	htvec: interrupt-controller@efdfb000080 {
+		compatible = "loongson,htvec-1.0";
+		reg = <0xefd 0xfb000080 0x40>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&liointc>;
+		interrupts = <24 IRQ_TYPE_LEVEL_HIGH>,
+			     <25 IRQ_TYPE_LEVEL_HIGH>,
+			     <26 IRQ_TYPE_LEVEL_HIGH>,
+			     <27 IRQ_TYPE_LEVEL_HIGH>,
+			     <28 IRQ_TYPE_LEVEL_HIGH>,
+			     <29 IRQ_TYPE_LEVEL_HIGH>,
+			     <30 IRQ_TYPE_LEVEL_HIGH>,
+			     <31 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
+&pch {
+	msi: msi-controller@2ff00000 {
+		compatible = "loongson,pch-msi-1.0";
+		reg = <0 0x2ff00000 0 0x8>;
+		interrupt-controller;
+		msi-controller;
+		loongson,msi-base-vec = <64>;
+		loongson,msi-num-vecs = <192>;
+		interrupt-parent = <&htvec>;
+	};
+};
+
+&lsdc {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dc_out_rgb0: endpoint {
+				remote-endpoint = <&adv7123_in>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dc_out_rgb1: endpoint {
+				remote-endpoint = <&tfp410_in>;
+			};
+		};
+	};
+};
-- 
2.25.1


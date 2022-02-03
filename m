Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3054A804B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349491AbiBCI0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:26:00 -0500
Received: from ptr.189.cn ([183.61.185.102]:13124 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346996AbiBCIZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:25:58 -0500
HMM_SOURCE_IP: 10.64.8.41:55068.1434336740
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 747F41002A0;
        Thu,  3 Feb 2022 16:25:53 +0800 (CST)
Received: from  ([172.27.8.53])
        by gateway-151646-dep-b7fbf7d79-9vctg with ESMTP id cad0d7f99194492f8c96908ab712865a for dan.carpenter@oracle.com;
        Thu, 03 Feb 2022 16:25:55 CST
X-Transaction-ID: cad0d7f99194492f8c96908ab712865a
X-Real-From: 15330273260@189.cn
X-Receive-IP: 172.27.8.53
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v6 3/3] dt-bindings: mips: loongson: introduce board specific dts
Date:   Thu,  3 Feb 2022 16:25:46 +0800
Message-Id: <20220203082546.3099-4-15330273260@189.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220203082546.3099-1-15330273260@189.cn>
References: <20220203082546.3099-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: suijingfeng <suijingfeng@loongson.cn>

For board specific devices which is outside of the cpu and bridge chip.
This patch introduce two dts, one for lemote a1901(aka LX-6901) motherboard
which one only one vga output connected to DVO1.
more document can be found from [1].

Another one is ls3A4000+ls7a1000 evb board, this board have a VGA and DVO
interface. The VGA is connected to the DVO0 and the dvi is connected to
DVO1.

We need introduce board specific dts because of we need the device tree
to tell how does the connectors and encoders are connected to the DVO port
of the display controller.

[1] https://wiki.godson.ac.cn/device:lemote_a1901

Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
Signed-off-by: Sui Jingfeng <15330273260@189.cn>
---
 arch/mips/boot/dts/loongson/lemote_a1901.dts  | 64 +++++++++++++++++
 .../boot/dts/loongson/ls3a4000_7a1000_evb.dts | 68 +++++++++++++++++++
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi     |  2 +-
 3 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/boot/dts/loongson/lemote_a1901.dts
 create mode 100644 arch/mips/boot/dts/loongson/ls3a4000_7a1000_evb.dts

diff --git a/arch/mips/boot/dts/loongson/lemote_a1901.dts b/arch/mips/boot/dts/loongson/lemote_a1901.dts
new file mode 100644
index 000000000000..81828945ba52
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/lemote_a1901.dts
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "loongson64g-package.dtsi"
+#include "ls7a-pch.dtsi"
+
+/ {
+	compatible = "lemode,a1901", "loongson,loongson64g-4core-ls7a";
+	model = "lemode,a1901";
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
+	/* use_vram_helper; */
+	output-ports = <&dvo0 &dvo1>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	dvo0: dvo@0 {
+		/* 0 for DVO0 */
+		reg = <0>;
+		status = "disabled";
+	};
+
+	dvo1: dvo@1 {
+		/* 1 for DVO1 */
+		reg = <1>;
+		connector = "vga-connector";
+		encoder = "adi,adv7125";
+		status = "okay";
+	};
+};
diff --git a/arch/mips/boot/dts/loongson/ls3a4000_7a1000_evb.dts b/arch/mips/boot/dts/loongson/ls3a4000_7a1000_evb.dts
new file mode 100644
index 000000000000..ff07f529ea43
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/ls3a4000_7a1000_evb.dts
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "loongson64g-package.dtsi"
+#include "ls7a-pch.dtsi"
+
+/ {
+	compatible = "loongson,loongson64g-4core-ls7a";
+	model = "loongson,ls3a4000_7a1000_evb";
+	version = "v1.4";
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
+	/* use_vram_helper; */
+	output-ports = <&dvo0 &dvo1>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	dvo0: dvo@0 {
+		/* 0 for DVO0 */
+		reg = <0>;
+		connector = "vga-connector";
+		encoder = "adi,adv7125";
+		status = "okay";
+	};
+
+	dvo1: dvo@1 {
+		/* 1 for DVO1 */
+		reg = <1>;
+		connector = "dvi-connector";
+		encoder = "ti,tfp410";
+		digital;
+		status = "okay";
+	};
+};
diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
index 2f45fce2cdc4..70a0b7ac0839 100644
--- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
@@ -160,7 +160,7 @@
 				interrupt-parent = <&pic>;
 			};
 
-			dc@6,1 {
+			lsdc: dc@6,1 {
 				compatible = "pci0014,7a06.0",
 						   "pci0014,7a06",
 						   "pciclass030000",
-- 
2.20.1


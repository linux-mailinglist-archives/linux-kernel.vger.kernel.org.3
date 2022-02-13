Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCD44B3BBF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 15:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbiBMORa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 09:17:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbiBMORK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 09:17:10 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6514F5F8C4;
        Sun, 13 Feb 2022 06:17:04 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.41:34274.536114013
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id B6FA21002B3;
        Sun, 13 Feb 2022 22:17:02 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-9vctg with ESMTP id be66858997da4a03ade58a24083bc740 for mripard@kernel.org;
        Sun, 13 Feb 2022 22:17:03 CST
X-Transaction-ID: be66858997da4a03ade58a24083bc740
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
        Qing Zhang <zhangqing@loongson.cn>, Li Yi <liyi@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v7 6/7] MIPS: Loongson: Add dts for ls2k1000 pai evaluation board
Date:   Sun, 13 Feb 2022 22:16:48 +0800
Message-Id: <20220213141649.1115987-7-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220213141649.1115987-1-15330273260@189.cn>
References: <20220213141649.1115987-1-15330273260@189.cn>
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

   ___________________                           ____________________
  |            -------|                         |                    |
  |  CRTC0 --> | DVO0 ------------------------> | 1024x600 DPI Panel |
  |  _   _     -------|                         |____________________|
  | | | | |           |  i2c0 is not get used
  | |_| |_|           |     +------+
  |                   <---->| i2c0 |
  |          LSDC     |     +------+
  |  _   _            |     +------+
  | | | | |           <---->| i2c1 |-----------+
  | |_| |_|           |     +------+           |
  |                   |        |               |               _________
  |            -------|    +---------+         |              |         |
  |  CRTC1 --> | DVO1 ---> | sii9022 | --> hdmi connector --> | Monitor |
  |            -------|    +---------+                        |_________|
  |___________________|

The sii9022 tranmnitter working in tramsparent mode, that is the edid
is read from the monitor directly, not through sil9022's ddc channel.
The PMON firmware is responsible for consigure the sii9022 at boot time.

[1] https://wiki.debian.org/InstallingDebianOn/Lemote/Loongson2K1000

Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
Signed-off-by: Sui Jingfeng <15330273260@189.cn>
---
 arch/mips/boot/dts/loongson/ls2k1000_pai.dts | 69 ++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 arch/mips/boot/dts/loongson/ls2k1000_pai.dts

diff --git a/arch/mips/boot/dts/loongson/ls2k1000_pai.dts b/arch/mips/boot/dts/loongson/ls2k1000_pai.dts
new file mode 100644
index 000000000000..6c18280d2129
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/ls2k1000_pai.dts
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "loongson64-2k1000.dtsi"
+
+/ {
+	model = "LS2K1000_PAI_UDB_V1.5";
+
+	memory@200000 {
+		compatible = "memory";
+		device_type = "memory";
+		// 238 MB at 2 MB
+		// 2GB - 512 MB at 2GB + 512 MB
+		// total 2 GB
+		reg = <0x00000000 0x00200000 0x00000000 0x0EE00000
+		       0x00000000 0xA0000000 0x00000000 0x60000000
+		       0x00000001 0x10000000 0x00000000 0x10000000>;
+	};
+};
+
+&lsdc {
+	output-ports = <&dvo0 &dvo1>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	dvo0: dvo@0 {
+		/* 0 for connector 0 (DVO0) */
+		reg = <0>;
+		connector = "dpi-connector";
+		status = "ok";
+
+		display-timings {
+			native-mode = <&mode_0_1024x600_60>;
+
+			mode_0_1024x600_60: panel-timing@0 {
+				clock-frequency = <51200000>;
+				hactive = <1024>;
+				vactive = <600>;
+				hsync-len = <4>;
+				hfront-porch = <160>;
+				hback-porch = <156>;
+				vfront-porch = <11>;
+				vback-porch = <23>;
+				vsync-len = <1>;
+			};
+
+			mode_1_800x480_60: panel-timing@1 {
+				clock-frequency = <30066000>;
+				hactive = <800>;
+				vactive = <480>;
+				hfront-porch = <50>;
+				hback-porch = <70>;
+				hsync-len = <50>;
+				vback-porch = <0>;
+				vfront-porch = <0>;
+				vsync-len = <50>;
+			};
+		};
+	};
+
+	dvo1: dvo@1 {
+		/* 1 for connector 1 (DVO1) */
+		reg = <1>;
+		connector = "virtual-connector";
+		status = "ok";
+	};
+};
-- 
2.25.1


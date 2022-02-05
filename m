Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F854AAB4C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381320AbiBESzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:55:38 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:55305 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381110AbiBESzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:55:03 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 662CF240005;
        Sat,  5 Feb 2022 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iNMjeTSTYJWtCgqk4JWldVwNxl2M8W9yqqfxH9Lo+PQ=;
        b=O6brv+0gz71Bgj5FaCTMMxjJldoA7zvtEHZTLzMWrTISdZJAe2zfowEfg4BAZyUTnEvMq0
        u8rWCZsPR+lyp71wgYxAyo7/6BX9O+IxWzXTmU0dfoyR16JC+EpVn+dnG5BKmO7CuLtUTH
        QDtyTvlqp/QSfri7vBfm2F+zsKEnK6pRUhfqnI25alRK9eNMqTAFYSvgUcsN9/r6FC0C7J
        zQCw/SJXdO8iPWEWWUnImI3wPK/9qHZYfgXCf9Y1rnCAGcXaiEXC+1gRj8LMX5jacHXl7m
        o522xb/Znw7YQggjOUvpt6cGh1Zv5NnoHWIziwB/Cux5j6drbbhc8gGLk5iXKQ==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 11/66] ARM: dts: sun8i: v3s: Add nodes for MIPI CSI-2 support
Date:   Sat,  5 Feb 2022 19:53:34 +0100
Message-Id: <20220205185429.2278860-12-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIPI CSI-2 is supported on the V3s with an A31-based MIPI CSI-2 bridge
controller. The controller uses a separate D-PHY, which is the same
that is otherwise used for MIPI DSI, but used in Rx mode.

On the V3s, the CSI0 controller is dedicated to MIPI CSI-2 as it does
not have access to any parallel interface pins.

Add all the necessary nodes (CSI0, MIPI CSI-2 bridge and D-PHY) to
support the MIPI CSI-2 interface.

Note that a fwnode graph link is created between CSI0 and MIPI CSI-2
even when no sensor is connected. This will result in a probe failure
for the controller as long as no sensor is connected but this is fine
since no other interface is available.

While the interconnects property is used to inherit the proper dma
ranges, the associated index for the cell is set to 0 since no
particular meaning is attached to it. This might need to be changed
later on (when identifying a proper mbus channel becomes relevant,
e.g. for things like QoS).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 71 ++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 1b3048b6f197..f5f7dfec49f9 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -614,6 +614,77 @@ gic: interrupt-controller@1c81000 {
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		csi0: camera@1cb0000 {
+			compatible = "allwinner,sun8i-v3s-csi";
+			reg = <0x01cb0000 0x1000>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CSI>,
+				 <&ccu CLK_CSI1_SCLK>,
+				 <&ccu CLK_DRAM_CSI>;
+			clock-names = "bus", "mod", "ram";
+			resets = <&ccu RST_BUS_CSI>;
+			interconnects = <&mbus 0>;
+			interconnect-names = "dma-mem";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					reg = <1>;
+
+					csi0_in_mipi_csi2: endpoint {
+						remote-endpoint = <&mipi_csi2_out_csi0>;
+					};
+				};
+			};
+		};
+
+		mipi_csi2: csi@1cb1000 {
+			compatible = "allwinner,sun8i-v3s-mipi-csi2",
+				     "allwinner,sun6i-a31-mipi-csi2";
+			reg = <0x01cb1000 0x1000>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CSI>,
+				 <&ccu CLK_CSI1_SCLK>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_CSI>;
+			status = "disabled";
+
+			phys = <&dphy>;
+			phy-names = "dphy";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mipi_csi2_in: port@0 {
+					reg = <0>;
+				};
+
+				mipi_csi2_out: port@1 {
+					reg = <1>;
+
+					mipi_csi2_out_csi0: endpoint {
+						remote-endpoint = <&csi0_in_mipi_csi2>;
+					};
+				};
+			};
+		};
+
+		dphy: d-phy@1cb2000 {
+			compatible = "allwinner,sun6i-a31-mipi-dphy";
+			reg = <0x01cb2000 0x1000>;
+			clocks = <&ccu CLK_BUS_CSI>,
+				 <&ccu CLK_MIPI_CSI>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_CSI>;
+			allwinner,direction = "rx";
+			status = "disabled";
+			#phy-cells = <0>;
+		};
+
 		csi1: camera@1cb4000 {
 			compatible = "allwinner,sun8i-v3s-csi";
 			reg = <0x01cb4000 0x3000>;
-- 
2.34.1


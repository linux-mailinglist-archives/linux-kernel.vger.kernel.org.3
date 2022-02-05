Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E105C4AAB29
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381056AbiBESyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:54:45 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:34451 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358317AbiBESyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:54:43 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8CD26240002;
        Sat,  5 Feb 2022 18:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2/xu3hAtIBOWd+KCnFmzXwlyYrEkfN5VTs0idJ4hc5I=;
        b=OLmTKT6anszjEQxSYcOhR8iI7S7a95IAwH5bqilJOumk5CfMfJsMZUAKlw/7yByGvALBwy
        rCqHLTX95g/krIoIeIbw71ZgtV8GtWiYINgMb7YSwY5iXaoEaK07NrnDxOEEesIBNnAxPP
        LTxDJQ2JbLnnVhijD5ZQ49hNkQnFS/jKt0cteDTI+nIb+AELxTvRkJhyBWJc+FJLy5TxvZ
        9sFTBIaa3UfJnYNyiF0HWftWLamuAhG28UZK986Eq18Z2/8031GKqP/S2W5E0CC+vVQeJg
        Cx+dIcuZWqA+NyXpPltyTz77qljicjtPsb0OM4yLItkyfmbJCDIjpffBKSceWA==
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
Subject: [PATCH v2 01/66] ARM: dts: sun8i: v3s: Move the csi1 block to follow address order
Date:   Sat,  5 Feb 2022 19:53:24 +0100
Message-Id: <20220205185429.2278860-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The csi1 block node was mistakenly added before the gic node, although
its address comes after the gic's. Move the node to its correct
position.

Fixes: 90e048101fa1 ("ARM: dts: sun8i: V3/V3s/S3/S3L: add CSI1 device node")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index b30bc1a25ebb..084323d5c61c 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -593,6 +593,17 @@ spi0: spi@1c68000 {
 			#size-cells = <0>;
 		};
 
+		gic: interrupt-controller@1c81000 {
+			compatible = "arm,gic-400";
+			reg = <0x01c81000 0x1000>,
+			      <0x01c82000 0x2000>,
+			      <0x01c84000 0x2000>,
+			      <0x01c86000 0x2000>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
 		csi1: camera@1cb4000 {
 			compatible = "allwinner,sun8i-v3s-csi";
 			reg = <0x01cb4000 0x3000>;
@@ -604,16 +615,5 @@ csi1: camera@1cb4000 {
 			resets = <&ccu RST_BUS_CSI>;
 			status = "disabled";
 		};
-
-		gic: interrupt-controller@1c81000 {
-			compatible = "arm,gic-400";
-			reg = <0x01c81000 0x1000>,
-			      <0x01c82000 0x2000>,
-			      <0x01c84000 0x2000>,
-			      <0x01c86000 0x2000>;
-			interrupt-controller;
-			#interrupt-cells = <3>;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-		};
 	};
 };
-- 
2.34.1


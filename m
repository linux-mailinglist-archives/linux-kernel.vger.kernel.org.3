Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4148E4CB0D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245153AbiCBVMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245086AbiCBVMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:12:01 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CC5D205D;
        Wed,  2 Mar 2022 13:11:16 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9E5DF1C0005;
        Wed,  2 Mar 2022 21:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646255475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/5n7yQVFkjHDumXqMtthmB2QZa/t3eGn8kkUaHEXQi8=;
        b=ef+bo92JNW3E4zIiSiFG9rkh+TlNLP8VEd7bM6+CCWgR11oCbiHsncfD9J5bDKk860FbOG
        mPWVG9oSt6xPAgOXNg+rI4PZIqxviSOoa2I257jlq5PBreFnUZSo4F16VcZpII2keidsPu
        txZCnXP9PQxtP7LM0JzNaZS0bujV54regO/tNlgEey4DLZ61cB7wcrIgkCR5UlY+NJTrX8
        gGRrYdAdeJrZLK2/ojaUthx9k+7x+IBQLmrWqJBBwF/WKZ+3MFT4BlvLePsoPhARDEBI7x
        q6wG4bd9OeAQBaPIlXJfPU46mIlG1BSc+ftXKTxvo1mlHWAmq3qGhk/yIvxi0w==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3 7/8] ARM: dts: sun8i: a83t: Add MIPI CSI-2 controller node
Date:   Wed,  2 Mar 2022 22:10:59 +0100
Message-Id: <20220302211100.65264-8-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302211100.65264-1-paul.kocialkowski@bootlin.com>
References: <20220302211100.65264-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIPI CSI-2 is supported on the A83T with a dedicated controller that
covers both the protocol and D-PHY. It can be connected to the CSI
interface as a V4L2 subdev through the fwnode graph.

This is not done by default since connecting the bridge without a
subdev attached to it will cause a failure on the CSI driver.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 82fdb04122ca..ecf9f3b2c0c0 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -1064,6 +1064,32 @@ csi: camera@1cb0000 {
 			status = "disabled";
 		};
 
+		mipi_csi2: csi@1cb1000 {
+			compatible = "allwinner,sun8i-a83t-mipi-csi2";
+			reg = <0x01cb1000 0x1000>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CSI>,
+				 <&ccu CLK_CSI_SCLK>,
+				 <&ccu CLK_MIPI_CSI>,
+				 <&ccu CLK_CSI_MISC>;
+			clock-names = "bus", "mod", "mipi", "misc";
+			resets = <&ccu RST_BUS_CSI>;
+			status = "disabled";
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
+				};
+			};
+		};
+
 		hdmi: hdmi@1ee0000 {
 			compatible = "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.35.1


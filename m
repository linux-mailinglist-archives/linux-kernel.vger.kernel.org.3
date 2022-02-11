Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F684B2D67
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352760AbiBKTNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:13:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349908AbiBKTM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:12:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DD9CED;
        Fri, 11 Feb 2022 11:12:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AC3461F3C;
        Fri, 11 Feb 2022 19:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC34C340F1;
        Fri, 11 Feb 2022 19:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644606775;
        bh=icDAxhIilkMcIBD/iE5/3SiYgSSWiOTuHCkrhxzg/7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jBzHpQ5pdB0MztPObMedFoQYSkox1wWNSoNrPLoB0nNDR35MVSlsgv+pOSyFpp/IK
         oM3CSNSjYuenhrlMbUdGwfWp1QC1kkJNnrJdPmUsk8oOPAy+mjMW4pSW3ks6q0sKit
         NUpq4DZKVxjHKmZdHeqYObqM4XAKvUlUAIYndC1YkKlHgWKzfqtWFSclQWTQXjLLvn
         oq/DpY3BEyv8vF9lK6ovNagwkYk6rvkT6y9Bbe4if0Bv6PajxQklOvutFvXUUkMw94
         J65CVQxFaghRpTsGsgsWH2GoiMyNj6juzzFLTWSl6t34AXFPHItlRiTfL/XWfz2pQr
         K5QmJmhAycRNQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v8 5/6] arm64: dts: marvell: armada-37xx: add device node for UART clock and use it
Date:   Fri, 11 Feb 2022 20:12:37 +0100
Message-Id: <20220211191238.2142-6-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211191238.2142-1-kabel@kernel.org>
References: <20220211191238.2142-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Define DT node for UART clock "marvell,armada-3700-uart-clock" and use
this UART clock as a base clock for all UART devices.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
Changes since v7:
- changed commit message ("This change defines" -> "Define")
- added Marek's Reviewed-by tag
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 673f4906eef9..4cf6c8aa0ac2 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -132,10 +132,20 @@ avs: avs@11500 {
 				reg = <0x11500 0x40>;
 			};
 
+			uartclk: clock-controller@12010 {
+				compatible = "marvell,armada-3700-uart-clock";
+				reg = <0x12010 0x4>, <0x12210 0x4>;
+				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
+					 <&tbg 3>, <&xtalclk>;
+				clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S",
+					      "TBG-B-S", "xtal";
+				#clock-cells = <1>;
+			};
+
 			uart0: serial@12000 {
 				compatible = "marvell,armada-3700-uart";
 				reg = <0x12000 0x18>;
-				clocks = <&xtalclk>;
+				clocks = <&uartclk 0>;
 				interrupts =
 				<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
@@ -147,7 +157,7 @@ uart0: serial@12000 {
 			uart1: serial@12200 {
 				compatible = "marvell,armada-3700-uart-ext";
 				reg = <0x12200 0x30>;
-				clocks = <&xtalclk>;
+				clocks = <&uartclk 1>;
 				interrupts =
 				<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
 				<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
-- 
2.34.1


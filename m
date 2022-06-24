Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41560559D48
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiFXP0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 11:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiFXP0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:26:49 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D67515B1;
        Fri, 24 Jun 2022 08:26:44 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 91C1A1BF20E;
        Fri, 24 Jun 2022 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656084403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wD+f6RoGESWUd50gh7hz7GMhaUjGtOMiPEM0xd+2bV0=;
        b=cgY6IVNZI/ieXXDiDCYRs5umVd/6Ukdb3BWmr4gdPExgBMLGe3VOqnFnZ0hd2GtAhLRL20
        l46SHG2lov1Bpg/q79ePfs2pN9NsPM873tK8xmHjrKQjH7HaO4P0tI2b4F6apBhdfkcWJW
        StfaKubcvYfB6BVrD1BYL75Jhjy3U2rJTYFis866+9ilIqY+ESRVljAaElGmp7kQDYqw1f
        5RH6LsoEq6EMjc/fmojJzV/ZKY9IICw85qze8XCcgLNqktd7uowXOBtbLmnxEAbLkf7avK
        YXl0mkHXjJ9/ReWXv7ZhHrIBYG/iPX7HuywWW5OejJv2kZ1ABc+4Nv//Bxv9kA==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH] MIPS: mscc: ocelot: enable FDMA usage
Date:   Fri, 24 Jun 2022 17:25:48 +0200
Message-Id: <20220624152548.128700-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Enable FDMA usage by adding "fdma" resource in regs and interrupts.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot.dtsi | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
index cfc219a72bdd..6bd8a1ad94da 100644
--- a/arch/mips/boot/dts/mscc/ocelot.dtsi
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -136,13 +136,14 @@ switch@1010000 {
 			      <0x1880000 0x10000>,
 			      <0x1040000 0x10000>,
 			      <0x1050000 0x10000>,
-			      <0x1060000 0x10000>;
+			      <0x1060000 0x10000>,
+			      <0x1a0 0x1c4>;
 			reg-names = "sys", "rew", "qs", "ptp", "port0", "port1",
 				    "port2", "port3", "port4", "port5", "port6",
 				    "port7", "port8", "port9", "port10", "qsys",
-				    "ana", "s0", "s1", "s2";
-			interrupts = <18 21 22>;
-			interrupt-names = "ptp_rdy", "xtr", "inj";
+				    "ana", "s0", "s1", "s2", "fdma";
+			interrupts = <18 21 22 16>;
+			interrupt-names = "ptp_rdy", "xtr", "inj", "fdma";
 
 			ethernet-ports {
 				#address-cells = <1>;
-- 
2.36.1


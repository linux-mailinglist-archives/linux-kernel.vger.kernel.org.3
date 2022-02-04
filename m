Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331AF4A9CCD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376499AbiBDQS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 11:18:27 -0500
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:48461 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376439AbiBDQSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:18:21 -0500
Received: from pro2.mail.ovh.net (unknown [10.109.156.10])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id E7989E1D4894;
        Fri,  4 Feb 2022 17:18:18 +0100 (CET)
Received: from localhost.localdomain (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Feb
 2022 17:18:17 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] ARM: dts: r9a06g032: Add the watchdog nodes
Date:   Fri, 4 Feb 2022 17:18:02 +0100
Message-ID: <20220204161806.3126321-5-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204161806.3126321-1-jjhiblot@traphandler.com>
References: <20220204161806.3126321-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 5893804537991477723
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrgeelgdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepfeeugefgieeutdfhvdegveetvdeuvefgveegleeileevveehfeejjeffgfduudeknecukfhppedtrddtrddtrddtpdekkedruddvhedrudefvddrjeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This SOC includes 2 watchdog controllers (one per A7 core).

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index c47896e4ab58..54c91b46a5d0 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -184,6 +184,22 @@ gic: interrupt-controller@44101000 {
 			interrupts =
 				<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
+
+		wdt0: watchdog@40008000 {
+			compatible = "renesas,rzn1-wdt";
+			reg = <0x40008000 0x1000>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&sysctrl R9A06G032_CLK_WATCHDOG>;
+			status = "disabled";
+		};
+
+		wdt1: watchdog@40009000 {
+			compatible = "renesas,rzn1-wdt";
+			reg = <0x40009000 0x1000>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&sysctrl R9A06G032_CLK_WATCHDOG>;
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435495691F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiGFSfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiGFSex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:34:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2987A205FB;
        Wed,  6 Jul 2022 11:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0479B81E83;
        Wed,  6 Jul 2022 18:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39161C341CB;
        Wed,  6 Jul 2022 18:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657132489;
        bh=zdWKypwxKe9RMtSGTkJ1CzZTOGoibtwH4u3hWLAxNhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EznejKqR1AaC7CqP/l/kyinGc3w5Fa7BJ5ewgeHTlaNEWXk95GAakURzxE5izbhm9
         AFiVW9lYteE5Mf5Yd5VJWJQFFDloEoHYm/X7NESUdUCMOvkekL/C3ihq2YGtvDaL7X
         sXxGYaYEGy1Cyg2IbGpShEZ2rJLVHoNK3eiBkv+MIwMgfWcNxvfOmZXw9YPbKevFdL
         I2+spOJzm+Yf7PTZH92wbWZy2TAtLaOHw2sRwdWgKzKsAixwZjSqkWOcRUYS7q+PAV
         PvmGqbZEyLppMb7lRIQhml1Pv45PI1IEkrpL8HuWHCZbhfmFabu/Qcz1AySSes/Twy
         A0qw8xwRS83zA==
Received: by pali.im (Postfix)
        id 695557F1; Wed,  6 Jul 2022 20:34:46 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] ARM: dts: kirkwood: Add definitions for PCIe legacy INTx interrupts
Date:   Wed,  6 Jul 2022 20:31:04 +0200
Message-Id: <20220706183114.30783-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220706183114.30783-1-pali@kernel.org>
References: <20220706183114.30783-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/kirkwood-6192.dtsi     | 14 ++++++++++--
 arch/arm/boot/dts/kirkwood-6281.dtsi     | 14 ++++++++++--
 arch/arm/boot/dts/kirkwood-6282.dtsi     | 28 ++++++++++++++++++++----
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi | 14 ++++++++++--
 4 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-6192.dtsi b/arch/arm/boot/dts/kirkwood-6192.dtsi
index 396bcba08adb..07f4f7f98c0c 100644
--- a/arch/arm/boot/dts/kirkwood-6192.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6192.dtsi
@@ -26,12 +26,22 @@
 				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &intc 9>;
+				interrupt-names = "intx";
+				interrupts = <9>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie_intc 0>,
+						<0 0 0 2 &pcie_intc 1>,
+						<0 0 0 3 &pcie_intc 2>,
+						<0 0 0 4 &pcie_intc 3>;
 				marvell,pcie-port = <0>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gate_clk 2>;
 				status = "disabled";
+
+				pcie_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kirkwood-6281.dtsi
index faa05849a40d..d08a9a5ecc26 100644
--- a/arch/arm/boot/dts/kirkwood-6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
@@ -26,12 +26,22 @@
 				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &intc 9>;
+				interrupt-names = "intx";
+				interrupts = <9>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie_intc 0>,
+						<0 0 0 2 &pcie_intc 1>,
+						<0 0 0 3 &pcie_intc 2>,
+						<0 0 0 4 &pcie_intc 3>;
 				marvell,pcie-port = <0>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gate_clk 2>;
 				status = "disabled";
+
+				pcie_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index e84c54b77dea..2eea5b304f47 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -30,12 +30,22 @@
 				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &intc 9>;
+				interrupt-names = "intx";
+				interrupts = <9>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie0_intc 0>,
+						<0 0 0 2 &pcie0_intc 1>,
+						<0 0 0 3 &pcie0_intc 2>,
+						<0 0 0 4 &pcie0_intc 3>;
 				marvell,pcie-port = <0>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gate_clk 2>;
 				status = "disabled";
+
+				pcie0_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			pcie1: pcie@2,0 {
@@ -48,12 +58,22 @@
 				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
 					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &intc 10>;
+				interrupt-names = "intx";
+				interrupts = <10>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie1_intc 0>,
+						<0 0 0 2 &pcie1_intc 1>,
+						<0 0 0 3 &pcie1_intc 2>,
+						<0 0 0 4 &pcie1_intc 3>;
 				marvell,pcie-port = <1>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gate_clk 18>;
 				status = "disabled";
+
+				pcie1_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
index 299c147298c3..070bc13242b8 100644
--- a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
+++ b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
@@ -26,12 +26,22 @@
 				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &intc 9>;
+				interrupt-names = "intx";
+				interrupts = <9>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie_intc 0>,
+						<0 0 0 2 &pcie_intc 1>,
+						<0 0 0 3 &pcie_intc 2>,
+						<0 0 0 4 &pcie_intc 3>;
 				marvell,pcie-port = <0>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gate_clk 2>;
 				status = "disabled";
+
+				pcie_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 		};
 	};
-- 
2.20.1


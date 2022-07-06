Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9865C5691F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiGFSf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiGFSe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:34:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326BC26ADF;
        Wed,  6 Jul 2022 11:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCE8AB81BE5;
        Wed,  6 Jul 2022 18:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61098C3411C;
        Wed,  6 Jul 2022 18:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657132494;
        bh=/PRqhXfoMAMe1uTp35V4AGMKnm98tSJQbAkiI3gqq+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0LOW1qgyZ/IuXyO6WKx0ucz0M9/Sjp0XIOdZ02/byDL7eu+Dy0iWKvWYDCUqxROk
         dQ5GZb8ENVeSdM2clye+SXt2E1wwOE3Mbis5o/qnxmQO67Dez1V2GCif3U3v6fePdw
         dWoOEYNMfZRwMeAALIf5IoNZCOlYKrF1BBce5+39ZTuENKYRVkAQstctU4jlmrUOpq
         SugSO0czGuJd0IR5FzhovOKNYk1vhUolYpmkql6I8UvB3JQa9+OiOTvRclqpgR5wsV
         vB9iFqu3ZEH99IzC6YUVwUuR+n89456t604CGcOgp5d4QhSDNgCDTUkJ7aNHJa3C4V
         NREJGMGazpZxQ==
Received: by pali.im (Postfix)
        id 1ADE97BA; Wed,  6 Jul 2022 20:34:54 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] ARM: dts: armada-380.dtsi: Add definitions for PCIe legacy INTx interrupts
Date:   Wed,  6 Jul 2022 20:31:12 +0200
Message-Id: <20220706183114.30783-10-pali@kernel.org>
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
 arch/arm/boot/dts/armada-380.dtsi | 42 ++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/armada-380.dtsi
index cff1269f3fbf..ce1dddb2269b 100644
--- a/arch/arm/boot/dts/armada-380.dtsi
+++ b/arch/arm/boot/dts/armada-380.dtsi
@@ -64,16 +64,26 @@
 				reg = <0x0800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie1_intc 0>,
+						<0 0 0 2 &pcie1_intc 1>,
+						<0 0 0 3 &pcie1_intc 2>,
+						<0 0 0 4 &pcie1_intc 3>;
 				marvell,pcie-port = <0>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 8>;
 				status = "disabled";
+
+				pcie1_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			/* x1 port */
@@ -83,16 +93,26 @@
 				reg = <0x1000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
 					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie2_intc 0>,
+						<0 0 0 2 &pcie2_intc 1>,
+						<0 0 0 3 &pcie2_intc 2>,
+						<0 0 0 4 &pcie2_intc 3>;
 				marvell,pcie-port = <1>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 5>;
 				status = "disabled";
+
+				pcie2_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			/* x1 port */
@@ -102,16 +122,26 @@
 				reg = <0x1800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
 					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie3_intc 0>,
+						<0 0 0 2 &pcie3_intc 1>,
+						<0 0 0 3 &pcie3_intc 2>,
+						<0 0 0 4 &pcie3_intc 3>;
 				marvell,pcie-port = <2>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 6>;
 				status = "disabled";
+
+				pcie3_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 		};
 	};
-- 
2.20.1


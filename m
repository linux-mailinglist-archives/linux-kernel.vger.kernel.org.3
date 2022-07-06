Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8E55691EE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiGFSfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiGFSe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:34:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14F42183C;
        Wed,  6 Jul 2022 11:34:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D2A9B81E89;
        Wed,  6 Jul 2022 18:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB59BC341CF;
        Wed,  6 Jul 2022 18:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657132491;
        bh=73aLwGE6/u1y7rodedb6D/wKo0OAgih6CmuMXtphdO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HePW2c76rvcv/1b12jQRK9lxKDY274MloWTbBbh4FymZA8dFfzs0tLU7CmVtaviB9
         AsaYfSltLAz1zVJtg3SWhz3m1Ft1o05DoiBmHur3LjOxaFQGC5jCNLEidCbhY4Q1pw
         b72F1L9gXbNoUeq9AUbdKSJ7td/MvT42iVviRxjxlkLt2ND28c9hvGvO4XOPBtuuGK
         e9/kQaaaoyK53IjFA8krAUEGVQaxzYvE+qkUtr/m9aLL0CGTcYPKz1viASRIkKK3ig
         S8XxES2oOkETe8YYst5Pg/VwDzDpk7/Fhma+jscGsEleDepA7hw6bj5NDp0mvAByXh
         np3fGEixvJBfg==
Received: by pali.im (Postfix)
        id 536C6825; Wed,  6 Jul 2022 20:34:48 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] ARM: dts: armada-370.dtsi: Add definitions for PCIe legacy INTx interrupts
Date:   Wed,  6 Jul 2022 20:31:06 +0200
Message-Id: <20220706183114.30783-4-pali@kernel.org>
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
 arch/arm/boot/dts/armada-370.dtsi | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 46e6d3ed8f35..9dc928859ad3 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -60,16 +60,26 @@
 				reg = <0x0800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&mpic 58>;
 				#interrupt-cells = <1>;
                                 ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
                                           0x81000000 0 0 0x81000000 0x1 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &mpic 58>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie0_intc 0>,
+						<0 0 0 2 &pcie0_intc 1>,
+						<0 0 0 3 &pcie0_intc 2>,
+						<0 0 0 4 &pcie0_intc 3>;
 				marvell,pcie-port = <0>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 5>;
 				status = "disabled";
+
+				pcie0_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			pcie2: pcie@2,0 {
@@ -78,16 +88,26 @@
 				reg = <0x1000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&mpic 62>;
 				#interrupt-cells = <1>;
                                 ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
                                           0x81000000 0 0 0x81000000 0x2 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &mpic 62>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie2_intc 0>,
+						<0 0 0 2 &pcie2_intc 1>,
+						<0 0 0 3 &pcie2_intc 2>,
+						<0 0 0 4 &pcie2_intc 3>;
 				marvell,pcie-port = <1>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 9>;
 				status = "disabled";
+
+				pcie2_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 		};
 
-- 
2.20.1


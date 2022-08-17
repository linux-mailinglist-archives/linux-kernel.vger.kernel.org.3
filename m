Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE245979B1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbiHQWbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbiHQWbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:31:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C3FA1A49;
        Wed, 17 Aug 2022 15:31:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C60696164A;
        Wed, 17 Aug 2022 22:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BDEC43470;
        Wed, 17 Aug 2022 22:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660775482;
        bh=v1FWDWavfkxNH4CEfWDIWKinWv6Npa0K9nHnOM9WMDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPJg6ATKxmRDmz3nNiTn8aQbSiyhJ7zrdKGJhW/6HQUFUDxynh4TY88yWpc3BfCHW
         2rqGvVfgma33lEQDumO6/qVPq9PR2KC+zQp2AbWIo53TWgzQLVU9h4D7p9qkeJt9ng
         HYUi/N73kgSFKyOqW7EBsIB07scPpKSmTQPIIRw+X+GRM60X43qRMy75YNRttdafy6
         P/ECrDuL/K+ruigg5ix+uKAiOUIbNnbUlWQEWyFLbKsjm/qrHT0TlcHz3eC/vsDFoI
         wSeWyOVlM+BaD3VL0UWAPtcuqyhAoJR+12H9TuOgguJtuNZdWv2wVWfnZ42VCgeChp
         TZR2VkMjtHCpQ==
Received: by pali.im (Postfix)
        id 91E1E77A; Thu, 18 Aug 2022 00:31:21 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 3/6] ARM: dts: armada-xp: Fix assigned-addresses for every PCIe Root Port
Date:   Thu, 18 Aug 2022 00:30:50 +0200
Message-Id: <20220817223053.31141-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220817223053.31141-1-pali@kernel.org>
References: <20220817223053.31141-1-pali@kernel.org>
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

BDF of resource in DT assigned-addresses property of Marvell PCIe Root Port
(PCI-to-PCI bridge) should match BDF in address part in that DT node name
as specified resource belongs to Marvell PCIe Root Port itself.

Fixes: 9d8f44f02d4a ("arm: mvebu: add PCIe Device Tree informations for Armada XP")
Fixes: 12b69a599745 ("ARM: mvebu: second PCIe unit of Armada XP mv78230 is only x1 capable")
Fixes: 2163e61c92d9 ("ARM: mvebu: fix second and third PCIe unit of Armada XP mv78260")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |  8 ++++----
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 3a709ca5ba05..b8d169c4feec 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -107,7 +107,7 @@
 
 			pcie2: pcie@2,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
+				assigned-addresses = <0x82001000 0 0x44000 0 0x2000>;
 				reg = <0x1000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -135,7 +135,7 @@
 
 			pcie3: pcie@3,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
+				assigned-addresses = <0x82001800 0 0x48000 0 0x2000>;
 				reg = <0x1800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -163,7 +163,7 @@
 
 			pcie4: pcie@4,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
+				assigned-addresses = <0x82002000 0 0x4c000 0 0x2000>;
 				reg = <0x2000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -191,7 +191,7 @@
 
 			pcie5: pcie@5,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x80000 0 0x2000>;
+				assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
 				reg = <0x2800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 8adbd4df8ee1..febd9d98a44e 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -122,7 +122,7 @@
 
 			pcie2: pcie@2,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
+				assigned-addresses = <0x82001000 0 0x44000 0 0x2000>;
 				reg = <0x1000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -150,7 +150,7 @@
 
 			pcie3: pcie@3,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
+				assigned-addresses = <0x82001800 0 0x48000 0 0x2000>;
 				reg = <0x1800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -178,7 +178,7 @@
 
 			pcie4: pcie@4,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
+				assigned-addresses = <0x82002000 0 0x4c000 0 0x2000>;
 				reg = <0x2000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -206,7 +206,7 @@
 
 			pcie5: pcie@5,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x80000 0 0x2000>;
+				assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
 				reg = <0x2800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -234,7 +234,7 @@
 
 			pcie6: pcie@6,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x84000 0 0x2000>;
+				assigned-addresses = <0x82003000 0 0x84000 0 0x2000>;
 				reg = <0x3000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -262,7 +262,7 @@
 
 			pcie7: pcie@7,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x88000 0 0x2000>;
+				assigned-addresses = <0x82003800 0 0x88000 0 0x2000>;
 				reg = <0x3800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -290,7 +290,7 @@
 
 			pcie8: pcie@8,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x8c000 0 0x2000>;
+				assigned-addresses = <0x82004000 0 0x8c000 0 0x2000>;
 				reg = <0x4000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -318,7 +318,7 @@
 
 			pcie9: pcie@9,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x42000 0 0x2000>;
+				assigned-addresses = <0x82004800 0 0x42000 0 0x2000>;
 				reg = <0x4800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
-- 
2.20.1


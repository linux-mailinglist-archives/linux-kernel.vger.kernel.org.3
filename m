Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA95374D6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiE3GMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbiE3GM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:12:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460D540928;
        Sun, 29 May 2022 23:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653891146; x=1685427146;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tBvQfCOYFrR0l7ILIQ7upbMTaW9rSS67FbpWNkdmxU8=;
  b=EmVxCENkJpLZw03VpZ+iA1m2VwoFDz48nAdNzLM5wmv2kUgY0jyQoHnx
   LjsF0UQnYj9yWtyx5EuxWaIXCy/O3IsBXSK/gSYdd84fmmEgdp/R66UZA
   gDIR3t9t9h2hnhPKHN3lU85+VW3XpVUiGg9YaHbIu5D47IKHLuVmOywPv
   pllgwFr0oSS5jeTQicYiAEzzTzf527V1PnFrOyo1OT8tED1vp4l/Ge0nG
   Lrvlmj/qG4KQyKHjDkH6X36MWy1YwntTbuPmwZD6n0trCgs+kdND8XKJl
   a+87grS4Gy1FLjg3VN0v4Xxpu6o393bVpCc/h3yD1rrLNN126+TmAUI+G
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="272474749"
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="272474749"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 23:12:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="605019238"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga008.jf.intel.com with ESMTP; 29 May 2022 23:12:24 -0700
From:   niravkumar.l.rabara@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        niravkumar.l.rabara@intel.com
Subject: [PATCH] arm64: dts: intel: socfpga_agilex: use defined GIC interrupt type for ECC
Date:   Mon, 30 May 2022 14:12:12 +0800
Message-Id: <20220530061212.1682439-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Use defined GIC interrupt type instead of hard-coded numbers for ECC

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index caccb0334ada..7bbec8aafa62 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -581,7 +581,7 @@ eccmgr {
 			sdramedac {
 				compatible = "altr,sdram-edac-s10";
 				altr,sdr-syscon = <&sdr>;
-				interrupts = <16 4>;
+				interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			ocram-ecc@ff8cc000 {
@@ -589,7 +589,7 @@ ocram-ecc@ff8cc000 {
 					     "altr,socfpga-a10-ocram-ecc";
 				reg = <0xff8cc000 0x100>;
 				altr,ecc-parent = <&ocram>;
-				interrupts = <1 4>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			usb0-ecc@ff8c4000 {
@@ -597,7 +597,7 @@ usb0-ecc@ff8c4000 {
 					     "altr,socfpga-usb-ecc";
 				reg = <0xff8c4000 0x100>;
 				altr,ecc-parent = <&usb0>;
-				interrupts = <2 4>;
+				interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			emac0-rx-ecc@ff8c0000 {
@@ -605,7 +605,7 @@ emac0-rx-ecc@ff8c0000 {
 					     "altr,socfpga-eth-mac-ecc";
 				reg = <0xff8c0000 0x100>;
 				altr,ecc-parent = <&gmac0>;
-				interrupts = <4 4>;
+				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			emac0-tx-ecc@ff8c0400 {
@@ -613,7 +613,7 @@ emac0-tx-ecc@ff8c0400 {
 					     "altr,socfpga-eth-mac-ecc";
 				reg = <0xff8c0400 0x100>;
 				altr,ecc-parent = <&gmac0>;
-				interrupts = <5 4>;
+				interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sdmmca-ecc@ff8c8c00 {
@@ -621,8 +621,8 @@ sdmmca-ecc@ff8c8c00 {
 					     "altr,socfpga-sdmmc-ecc";
 				reg = <0xff8c8c00 0x100>;
 				altr,ecc-parent = <&mmc>;
-				interrupts = <14 4>,
-					     <15 4>;
+				interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
+					     <15 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF62537561
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiE3H0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiE3HZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:25:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D062513E3D;
        Mon, 30 May 2022 00:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653895557; x=1685431557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vcglmkkx+1VN4zPJUFXhB/fuNxotUIij+3gXdIHQq8I=;
  b=iW/GAA+ysQsp1LU89zVuKezke76xM2Emt0q4LKuHJJbR9VPaEHMC1Fyc
   IniW4bjmFsy5Slmv8iwVlK71FC+GsRorRwzG8wweBEGkaKBGsla00v5Dy
   uDd+8h4Vfoq91PrBRMXR9jtKpxgrZcBpmXwqQ/X4OXnoYa1YyJc7dpq5w
   J+/ALE9XOTcZkHmme9Y3ekEaRvyxH0fokRKzP6vOrXuPUrgrztjdlNCJx
   qKPnk9UlSAkYolQvBNaQOSUf22P71/UIcMbmvOhgvw3BfBoWTDW1ueAm8
   9USBJsUEW0yFKW3B+pP544eZGkLailH7h6Ww3qpa9smMyN4miKwjEvbtn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="335570383"
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="335570383"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 00:25:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="679027018"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by fmsmga002.fm.intel.com with ESMTP; 30 May 2022 00:25:55 -0700
From:   niravkumar.l.rabara@intel.com
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, niravkumar.l.rabara@intel.com
Subject: [PATCH v2] arm64: dts: intel: socfpga_agilex: use defined GIC interrupt type for ECC
Date:   Mon, 30 May 2022 15:25:30 +0800
Message-Id: <20220530072530.1685970-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220530061212.1682439-1-niravkumar.l.rabara@intel.com>
References: <20220530061212.1682439-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Use defined GIC interrupt type instead of hard-coded numbers for ECC
(Error Correction Code) memory, which creates edac sysfs interface.

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


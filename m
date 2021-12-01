Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18F9464B68
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242669AbhLAKRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:17:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:58097 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237378AbhLAKRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:17:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="217122404"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="217122404"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 02:14:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="576222812"
Received: from pg-vnc03.altera.com ([10.142.129.92])
  by fmsmga004.fm.intel.com with ESMTP; 01 Dec 2021 02:14:22 -0800
From:   sin.hui.kho@linux.intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yau Wai Gan <yau.wai.gan@intel.com>,
        Sin Hui Kho <sin.hui.kho@intel.com>
Subject: [PATCH] arm64: dts: Update NAND MTD partition for Agilex and Stratix 10
Date:   Wed,  1 Dec 2021 18:13:53 +0800
Message-Id: <20211201101353.51670-1-sin.hui.kho@linux.intel.com>
X-Mailer: git-send-email 2.13.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sin Hui Kho <sin.hui.kho@intel.com>

Change NAND flash MTD partition in device tree after implementation of
UBI and UBIFS. "u-boot" partition remain for raw u-boot image, but "root"
partition is use for UBI image containing all other components.

Signed-off-by: Sin Hui Kho <sin.hui.kho@intel.com>
---
 .../dts/altera/socfpga_stratix10_socdk_nand.dts    | 24 ++--------------------
 .../boot/dts/intel/socfpga_agilex_socdk_nand.dts   | 20 ++----------------
 2 files changed, 4 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
index f9b4a39683cf..bbc3db42d6e8 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
@@ -119,28 +119,8 @@
 		};
 
 		partition@200000 {
-			label = "env";
-			reg = <0x200000 0x40000>;
-		};
-
-		partition@240000 {
-			label = "dtb";
-			reg = <0x240000 0x40000>;
-		};
-
-		partition@280000 {
-			label = "kernel";
-			reg = <0x280000 0x2000000>;
-		};
-
-		partition@2280000 {
-			label = "misc";
-			reg = <0x2280000 0x2000000>;
-		};
-
-		partition@4280000 {
-			label = "rootfs";
-			reg = <0x4280000 0x3bd80000>;
+			label = "root";
+			reg = <0x200000 0x3fe00000>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
index cc2dcabf34e3..57f83481f551 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
@@ -91,24 +91,8 @@
 			reg = <0 0x200000>;
 		};
 		partition@200000 {
-			label = "env";
-			reg = <0x200000 0x40000>;
-		};
-		partition@240000 {
-			label = "dtb";
-			reg = <0x240000 0x40000>;
-		};
-		partition@280000 {
-			label = "kernel";
-			reg = <0x280000 0x2000000>;
-		};
-		partition@2280000 {
-			label = "misc";
-			reg = <0x2280000 0x2000000>;
-		};
-		partition@4280000 {
-			label = "rootfs";
-			reg = <0x4280000 0x3bd80000>;
+			label = "root";
+			reg = <0x200000 0x3fe00000>;
 		};
 	};
 };
-- 
2.13.0


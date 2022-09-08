Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD015B12CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 05:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIHDGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 23:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIHDGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 23:06:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0233710572;
        Wed,  7 Sep 2022 20:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662606373; x=1694142373;
  h=from:to:cc:subject:date:message-id;
  bh=zVh0oYIy9y1opOEwiMk1DNjymznwB43MlPe1XapXiDo=;
  b=jxJEvHPqmkRZqooTgJjrn1GKKFX8gVyDk7ln/UYhaBrG7es4yWR5GooF
   igeaDN/1iEe/Xhgxb4RkNFiV/quKNJ7pOlQximBqrJMScR3RgEGvg8HOD
   2iLfpwzw3TLU5qC15NuiPE/ipwViYWQOedx4EOwuQZq+tKyoIv11QSOSs
   Qw5FdNJpgLmY5GFMparuC6saSXkw2E6S3oVmdBGMRXkuHgmNzr6RSlBIh
   b/xkqBvJYutGfs2eLIgCi2V9rH96mVy8xZwrFamJZTb2jNjbiXXQ3Y69K
   NnNxYhLQWIAfOxe4UKWym0QgYh27A0In4mg3JZzl+xxdXLLHpJ1NYuYxZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="276787824"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="276787824"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 20:06:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="644888788"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.170])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2022 20:06:10 -0700
From:   ji.sheng.teoh@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Teoh Ji Sheng <ji.sheng.teoh@intel.com>
Subject: [PATCH] ARM: dts: socfpga: arria10: Increase boot partition size for NAND
Date:   Thu,  8 Sep 2022 03:10:22 +0000
Message-Id: <20220908031022.38080-1-ji.sheng.teoh@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Teoh Ji Sheng <ji.sheng.teoh@intel.com>

Content in NAND boot partition have exceeded 32MB defined in device
tree node.
Increase boot partition size to 37MB to support larger kernel Image
and FPGA bitstream.

Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
---
 arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
index 9aa897b79544..a662df319a84 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
@@ -16,11 +16,11 @@
 
 		partition@0 {
 			label = "Boot and fpga data";
-			reg = <0x0 0x02000000>;
+			reg = <0x0 0x02500000>;
 		};
 		partition@1c00000 {
 			label = "Root Filesystem - JFFS2";
-			reg = <0x02000000 0x06000000>;
+			reg = <0x02500000 0x05500000>;
 		};
 	};
 };
-- 
2.17.1


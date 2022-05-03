Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677DB518D6A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242157AbiECTtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbiECTtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:49:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEF41EC69;
        Tue,  3 May 2022 12:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651607162; x=1683143162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=15VPEkkpNfoHEDQrDJC9rIeebWmswoBg5hQZL9hNclE=;
  b=CLv7Df7eErjcC4fll0pkV6Dh89yb565cCCltpnCxmRQjjeCcn3uf1Stk
   xgtMHKc+7S3E3dLJh5fJM0IuxBIzOBcKoM2RAzkEy4dKdGkScI2DxBH/O
   dsGy8CeFabI10L7PAJihpevqsgwW61e9d3OFmF2gXKg4/0VDACPrJ1Fxb
   LurIUh2K8vhL08NK5YOhGvEXcUAtvDuHPR1Fi3/aMNpHCB9JNOin3Nzr5
   UEl5TVVbUmZ+uUXTKqdHHto57WK1/4wxLtGJQtErzRTTHzzSvQhHX+9WA
   OFy3WTxp5AzbhpAYuRFmewHXLQK1h5RoMgwZXLEkTw9y164KuAR++UWvn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248114162"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="248114162"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 12:46:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="584345940"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 12:45:59 -0700
From:   matthew.gerlach@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v2 3/3] arm64: dts: intel: add device tree for n6000
Date:   Tue,  3 May 2022 12:45:46 -0700
Message-Id: <20220503194546.1287679-4-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com>
References: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add a device tree for the n6000 instantiation of Agilex
Hard Processor System (HPS).

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v2:
  - fix copy engine node name
  - fix compatible field for copy engine
  - remove redundant status field
  - add compatibility field for the board
  - fix SPDX
  - fix how osc1 clock frequency is set
---
 arch/arm64/boot/dts/intel/Makefile            |  3 +-
 .../boot/dts/intel/socfpga_agilex_n6000.dts   | 76 +++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 0b5477442263..c2a723838344 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
-dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_socdk.dtb \
+dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
+				socfpga_agilex_socdk.dtb \
 				socfpga_agilex_socdk_nand.dtb \
 				socfpga_n5x_socdk.dtb
 dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
new file mode 100644
index 000000000000..6f8b7bf7a53f
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021-2022, Intel Corporation
+ */
+#include "socfpga_agilex.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex n6000";
+	compatible = "intel,socfpga-agilex-n6000", "intel,socfpga-agilex";
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart0;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	soc {
+		agilex_hps_bridges: bus@80000000 {
+			compatible = "simple-bus";
+			reg = <0x80000000 0x60000000>,
+				<0xf9000000 0x00100000>;
+			reg-names = "axi_h2f", "axi_h2f_lw";
+			#address-cells = <0x2>;
+			#size-cells = <0x1>;
+			ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
+
+			hps_cp_eng@0 {
+				compatible = "intel,hps-copy-engine";
+				reg = <0x00000000 0x00000000 0x00001000>;
+			};
+		};
+	};
+};
+
+&osc1 {
+	clock-frequency = <25000000>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+
+	spidev: spidev@0 {
+		status = "okay";
+		compatible = "linux,spidev";
+		spi-max-frequency = <25000000>;
+		reg = <0>;
+	};
+};
+
+&watchdog0 {
+	status = "okay";
+};
+
+&fpga_mgr {
+	status = "disabled";
+};
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636E24FB901
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345087AbiDKKIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345063AbiDKKHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:07:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0A5E0A6;
        Mon, 11 Apr 2022 03:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRlfIjub7RrXGehRzuO4/5xz/z5nlytAmOMpkde2iyOD5F/QEoHR66vtcbwxPlyl2v5s3w0O+BRz10LsS/oojl5RoZU5v2y1QBat9TsdXiSFxAVdaNF46wkT7Z1HMEiHVsGrKAXSXbVZ/sBaJ9NtVGPITqhzVetgMXiVHtdYgwoJuP28sLcGJ7e7l3Xhis0wteFpcyzmsQnM48C53HMM9z7/VY+f2Us2ebVedDzVFrAyQ2g15oG7crQaYjjFXU8FwCQ8DuWRW8qZplzgJd0rSBaSIU32rorytnTLfk1srgWsVkpCaqLsrUjfFYgPi/1Z7fVbfNkfIu1Q+eZIE8tzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsuVcn0zsaXZC7/lxaWqAMet+tY+BkEhFwbb6/bomuY=;
 b=nHtFRD7VH/nq2PpNVDfpaYAZJ79fjXfpcKtlSj6m1+nDJdfCEI3JqTBkkThk6mLyEtY6Ya21s2QIzSVb6WvRYRHpIcUQRb/657OMcubd7QbgjEG+zKI8kc7scikG6rXqCWm/6XACuouQUkftfKPji4hSY1ed/FaJsbfvA5qaw4FtIux1/s5Pd/UZ5LNQLWzhT1jvOY/oUS4/OhWMpt3m/PLiU3JrJ04gmJ+f2RLPJ8LUGvDqH+WNuO5xqLK/0FqvENWhHlA+dt1bNN3CC8qi0n33vfzcXw9MxhpR1PUggz3fgI+W7E89Usm+MvoJh+YdwWykR5aPwOXRCuKOXiZvQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsuVcn0zsaXZC7/lxaWqAMet+tY+BkEhFwbb6/bomuY=;
 b=b3ILBNPaBLfErAYRJbbRl1N8vVMERetAs0+5/J9vLMyrfVWLIBEPszPXPRwHCIUF17wXKHxUF73qhU2qj5li9hUAi5+8vnVdAwgyIUagT/5c5txmY1LVwL0C1WTTe3JpgEE5f/DLbo5uRwAzq9wZR8yJTT01amgWzV1U9fvs8Lo=
Received: from BN6PR1401CA0002.namprd14.prod.outlook.com
 (2603:10b6:405:4b::12) by BL0PR02MB4417.namprd02.prod.outlook.com
 (2603:10b6:208:45::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 10:04:53 +0000
Received: from BN1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::b5) by BN6PR1401CA0002.outlook.office365.com
 (2603:10b6:405:4b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 10:04:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT009.mail.protection.outlook.com (10.13.2.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.21 via Frontend Transport; Mon, 11 Apr 2022 10:04:53 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Apr 2022 03:04:52 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Apr 2022 03:04:52 -0700
Envelope-to: linux-clk@vger.kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 sboyd@kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.59] (port=36530 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1ndqui-0003Jf-9l; Mon, 11 Apr 2022 03:04:52 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-clk@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v14 2/5] clk: clocking-wizard: Move clocking-wizard out
Date:   Mon, 11 Apr 2022 15:34:40 +0530
Message-ID: <20220411100443.15132-3-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
References: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e20d81f2-5beb-4802-c1d6-08da1ba2b969
X-MS-TrafficTypeDiagnostic: BL0PR02MB4417:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB4417E198479D003162AFE207AAEA9@BL0PR02MB4417.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pMPXILG/SY/XgKftcDqhyM26hdC3ZL+PTkKJ5AfeO+3mcNu1G/OMOCsANzORUVr7MEhnk2JeXO1qXmMd/0S2nV7WXWBXH74i6b8KWcF0pHdBAcEwQXQHK5pEKoFs9hGybRwsugFTo0B2xrn0VZKeuvmQmZCPisb/XiLDPFhkSqN8c3q5lz1fCl9v3Zgi6GX18xR+q4vmVBjfFUKgmHRvZaeDjmRrRptsh2Q750FIMUgmGN8T6tgVEcSrc9C3hw7fZAHQce9Kbt2Y1ZD0N6jrAGqx0t8rTsneMcJgRdaPupXRI1a9oBLVDcjbKI7O122mVAFfQLPnFNEasZz3XpEqeFnWoKQZJFg8WujSrHHAcsK+CUAlofPt1a6FI6g6v7xvDp4x0VQ++3kYuIZem1ShvHbcqZhyf9YNDF5/qg9YgBn5Iq24sTfAZ80c2byvj7/7OVDTbNVLiviuMCMNfWfxXNY3pZkTsldyoVnPXUkpghX72U4x+EQB5BC8ZefmcrvALsVkPgCzRKZK+h5xFfoaVQt32TUQTg7GTZzPzYGRDQOh/XMqK7ZR/v42TCW/2+KDmhZ9P3mYbkZfSXjtiPifsb49ZuuPnnT5lCusCcRKqig2PgYz/z5LCSS1lW23SBhbvo4O/gye3JOxv49nk1Gs1ySxnTljkzzkyyCbgr2TfsDHhRnZdAchzacCutPFBVMGY5/+VGKEeZWF8D0O72BWY9+qUfbozrmUtm/O3/AeHXqyNfq/6fw36DiUEY273jZS0pyXEj6isKMi86pePJQmhtx9tPWBwvKakligdO517sd//WgdI1TZx/xCGIeDSa1G+5mf97y4X9jbR6nmiK2RA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(356005)(9786002)(6666004)(8936002)(7636003)(5660300002)(44832011)(316002)(26005)(186003)(1076003)(966005)(54906003)(8676002)(508600001)(2616005)(6916009)(107886003)(7696005)(4326008)(70206006)(70586007)(36860700001)(426003)(66574015)(336012)(47076005)(82310400005)(83380400001)(40460700003)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 10:04:53.4464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e20d81f2-5beb-4802-c1d6-08da1ba2b969
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4417
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocking wizard driver to clk.
And delete the driver from the staging as it is in drivers/clk.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/clk/xilinx/Kconfig                    | 11 +++++++
 drivers/clk/xilinx/Makefile                   |  1 +
 .../xilinx}/clk-xlnx-clock-wizard.c           |  3 +-
 drivers/staging/Kconfig                       |  2 --
 drivers/staging/Makefile                      |  1 -
 drivers/staging/clocking-wizard/Kconfig       | 10 -------
 drivers/staging/clocking-wizard/Makefile      |  2 --
 drivers/staging/clocking-wizard/TODO          | 13 --------
 .../staging/clocking-wizard/dt-binding.txt    | 30 -------------------
 9 files changed, 14 insertions(+), 59 deletions(-)
 rename drivers/{staging/clocking-wizard => clk/xilinx}/clk-xlnx-clock-wizard.c (99%)
 delete mode 100644 drivers/staging/clocking-wizard/Kconfig
 delete mode 100644 drivers/staging/clocking-wizard/Makefile
 delete mode 100644 drivers/staging/clocking-wizard/TODO
 delete mode 100644 drivers/staging/clocking-wizard/dt-binding.txt

diff --git a/drivers/clk/xilinx/Kconfig b/drivers/clk/xilinx/Kconfig
index 5224114176ed..5b99ecfd2f06 100644
--- a/drivers/clk/xilinx/Kconfig
+++ b/drivers/clk/xilinx/Kconfig
@@ -17,3 +17,14 @@ config XILINX_VCU
 	  To compile this driver as a module, choose M here: the
 	  module will be called xlnx_vcu.
 
+config COMMON_CLK_XLNX_CLKWZRD
+	tristate "Xilinx Clocking Wizard"
+	depends on COMMON_CLK && OF
+	help
+	  Support for the Xilinx Clocking Wizard IP core clock generator.
+	  Adds support for clocking wizard and compatible.
+	  This driver supports the Xilinx clocking wizard programmable clock
+	  synthesizer. The number of output is configurable in the design.
+
+	  If unsure, say N.
+
diff --git a/drivers/clk/xilinx/Makefile b/drivers/clk/xilinx/Makefile
index dee8fd51e303..7ac1789c6b1b 100644
--- a/drivers/clk/xilinx/Makefile
+++ b/drivers/clk/xilinx/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_XILINX_VCU)	+= xlnx_vcu.o
+obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+= clk-xlnx-clock-wizard.o
diff --git a/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
similarity index 99%
rename from drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
rename to drivers/clk/xilinx/clk-xlnx-clock-wizard.c
index 39367712ef54..ec377f0d569b 100644
--- a/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -2,9 +2,10 @@
 /*
  * Xilinx 'Clocking Wizard' driver
  *
- *  Copyright (C) 2013 - 2014 Xilinx
+ *  Copyright (C) 2013 - 2021 Xilinx
  *
  *  Sören Brinkmann <soren.brinkmann@xilinx.com>
+ *
  */
 
 #include <linux/platform_device.h>
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 932acb4e8cbc..15b4103275c6 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -66,8 +66,6 @@ source "drivers/staging/fwserial/Kconfig"
 
 source "drivers/staging/unisys/Kconfig"
 
-source "drivers/staging/clocking-wizard/Kconfig"
-
 source "drivers/staging/fbtft/Kconfig"
 
 source "drivers/staging/most/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 3ffb35ccfae2..584399d790db 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -23,7 +23,6 @@ obj-$(CONFIG_STAGING_BOARD)	+= board/
 obj-$(CONFIG_LTE_GDM724X)	+= gdm724x/
 obj-$(CONFIG_FIREWIRE_SERIAL)	+= fwserial/
 obj-$(CONFIG_UNISYSSPAR)	+= unisys/
-obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+= clocking-wizard/
 obj-$(CONFIG_FB_TFT)		+= fbtft/
 obj-$(CONFIG_MOST)		+= most/
 obj-$(CONFIG_KS7010)		+= ks7010/
diff --git a/drivers/staging/clocking-wizard/Kconfig b/drivers/staging/clocking-wizard/Kconfig
deleted file mode 100644
index 2324b5d73788..000000000000
--- a/drivers/staging/clocking-wizard/Kconfig
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Xilinx Clocking Wizard Driver
-#
-
-config COMMON_CLK_XLNX_CLKWZRD
-	tristate "Xilinx Clocking Wizard"
-	depends on COMMON_CLK && OF && HAS_IOMEM
-	help
-	  Support for the Xilinx Clocking Wizard IP core clock generator.
diff --git a/drivers/staging/clocking-wizard/Makefile b/drivers/staging/clocking-wizard/Makefile
deleted file mode 100644
index b1f915224d96..000000000000
--- a/drivers/staging/clocking-wizard/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+= clk-xlnx-clock-wizard.o
diff --git a/drivers/staging/clocking-wizard/TODO b/drivers/staging/clocking-wizard/TODO
deleted file mode 100644
index c7e1dc58dfba..000000000000
--- a/drivers/staging/clocking-wizard/TODO
+++ /dev/null
@@ -1,13 +0,0 @@
-TODO:
-	- support for fractional multiplier
-	- support for fractional divider (output 0 only)
-	- support for set_rate() operations (may benefit from Stephen Boyd's
-	  refactoring of the clk primitives:
-	  https://lore.kernel.org/lkml/1409957256-23729-1-git-send-email-sboyd@codeaurora.org)
-	- review arithmetic
-	  - overflow after multiplication?
-	  - maximize accuracy before divisions
-
-Patches to:
-	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-	Sören Brinkmann <soren.brinkmann@xilinx.com>
diff --git a/drivers/staging/clocking-wizard/dt-binding.txt b/drivers/staging/clocking-wizard/dt-binding.txt
deleted file mode 100644
index efb67ff9f76c..000000000000
--- a/drivers/staging/clocking-wizard/dt-binding.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Binding for Xilinx Clocking Wizard IP Core
-
-This binding uses the common clock binding[1]. Details about the devices can be
-found in the product guide[2].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Clocking Wizard Product Guide
-https://www.xilinx.com/support/documentation/ip_documentation/clk_wiz/v5_1/pg065-clk-wiz.pdf
-
-Required properties:
- - compatible: Must be 'xlnx,clocking-wizard'
- - reg: Base and size of the cores register space
- - clocks: Handle to input clock
- - clock-names: Tuple containing 'clk_in1' and 's_axi_aclk'
- - clock-output-names: Names for the output clocks
-
-Optional properties:
- - speed-grade: Speed grade of the device (valid values are 1..3)
-
-Example:
-	clock-generator@40040000 {
-		reg = <0x40040000 0x1000>;
-		compatible = "xlnx,clocking-wizard";
-		speed-grade = <1>;
-		clock-names = "clk_in1", "s_axi_aclk";
-		clocks = <&clkc 15>, <&clkc 15>;
-		clock-output-names = "clk_out0", "clk_out1", "clk_out2",
-				     "clk_out3", "clk_out4", "clk_out5",
-				     "clk_out6", "clk_out7";
-	};
-- 
2.17.1


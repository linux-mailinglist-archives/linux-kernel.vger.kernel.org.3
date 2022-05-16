Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFB4528A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiEPQcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343615AbiEPQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:32:07 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A4F3917B
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:32:05 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GDjWtQ014154;
        Mon, 16 May 2022 16:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id; s=pps0720;
 bh=wpSXGNAyuHWjjFPq5i7K7209W2allUtcooZdy2mljhE=;
 b=RYo1MX2HP1cCjuiYReEJxaLXe6z432/j5cG0ok57ro8WN5lgTl5BgORLjJVS8cQJdBMF
 XAkk2ZdFEdPuZsYL2N3Fe7rVi+xlorG9yvRyhMUf8FqP2GSXwDoYezqlHzt67oe4Gs5n
 ChC5DBfmn8XBaaIdOwDue3G7I+vNPVHoW59zzOAGthnA2BOZDzo0eKwcgE/1rq33Zv5s
 T3Z7XcYb9lM9Mxe8JjdsGr8QJbf6QnjUqw0HCszU72soUVfhckSuTnxfa/ZQ0kV8ZQLE
 5EH7i/+OxbKuZmsTBz44ATXupyTmo5D4r4SRxC9hD9rPFMy/VWjPXvkAI0qveg5e7Anp 2Q== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3g3qs2t4jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 16:31:57 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 303F98D;
        Mon, 16 May 2022 16:31:56 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id ACCD84C;
        Mon, 16 May 2022 16:31:55 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, joel@jms.id.au,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>
Subject: [PATCH v8 1/8] ARM: hpe: Introduce the HPE GXP architecture
Date:   Mon, 16 May 2022 11:33:39 -0500
Message-Id: <20220516163347.44890-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: J0tNU-A42C1B7yvcsFEiVqFp3wC3QQr4
X-Proofpoint-GUID: J0tNU-A42C1B7yvcsFEiVqFp3wC3QQr4
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_15,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160092
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP is the HPE BMC SoC that is used in the majority
of current generation HPE servers. Traditionally the asic will
last multiple generations of server before being replaced.

Info about SoC:

HPE GXP is the name of the HPE Soc. This SoC is used to implement many BMC
features at HPE. It supports ARMv7 architecture based on the Cortex A9
core. It is capable of using an AXI bus to whicha memory controller is
attached. It has multiple SPI interfaces to connect boot flash and BIOS
flash. It uses a 10/100/1000 MAC for network connectivity. It has multiple
i2c engines to drive connectivity with a host infrastructure. There
currently are no public specifications but this process is being worked.

Previously there was a requirement to reset the EHCI controller for the
asic to boot. This functionality has been moved to the u-boot
bootloader.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v8:
* No change
v7:
* No change
v6:
* Adjusted title to match log entries
* Reconfigured commit message to be closer to 75 char.
* Add space before comment delimiter.
* Added a more elaborate Kconfig help section and fixed punctuation.
* Fixed l2c_aux_map initialization.
v5:
* Fixed version log
* Removed incorrect statement about reset.
v4:
* Removed unnecessary code: restart, iomap, init_machine
* Reordered Kconfig depends
* Removed SPARSE_IRQ, MULTI_IRQ_HANDLER, IRQ_DOMAIN, PINCTL from
  Kconfig
v3:
* Put into proper patchset format
v2:
* No change
---
 arch/arm/Kconfig           |  2 ++
 arch/arm/Makefile          |  1 +
 arch/arm/mach-hpe/Kconfig  | 23 +++++++++++++++++++++++
 arch/arm/mach-hpe/Makefile |  1 +
 arch/arm/mach-hpe/gxp.c    | 16 ++++++++++++++++
 5 files changed, 43 insertions(+)
 create mode 100644 arch/arm/mach-hpe/Kconfig
 create mode 100644 arch/arm/mach-hpe/Makefile
 create mode 100644 arch/arm/mach-hpe/gxp.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2e8091e2d8a8..13f77eec7c40 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -620,6 +620,8 @@ source "arch/arm/mach-highbank/Kconfig"
 
 source "arch/arm/mach-hisi/Kconfig"
 
+source "arch/arm/mach-hpe/Kconfig"
+
 source "arch/arm/mach-imx/Kconfig"
 
 source "arch/arm/mach-integrator/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a2391b8de5a5..97a89023c10f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -179,6 +179,7 @@ machine-$(CONFIG_ARCH_FOOTBRIDGE)	+= footbridge
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
 machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
 machine-$(CONFIG_ARCH_HISI)		+= hisi
+machine-$(CONFIG_ARCH_HPE)		+= hpe
 machine-$(CONFIG_ARCH_INTEGRATOR)	+= integrator
 machine-$(CONFIG_ARCH_IOP32X)		+= iop32x
 machine-$(CONFIG_ARCH_IXP4XX)		+= ixp4xx
diff --git a/arch/arm/mach-hpe/Kconfig b/arch/arm/mach-hpe/Kconfig
new file mode 100644
index 000000000000..3372bbf38d38
--- /dev/null
+++ b/arch/arm/mach-hpe/Kconfig
@@ -0,0 +1,23 @@
+menuconfig ARCH_HPE
+	bool "HPE SoC support"
+	depends on ARCH_MULTI_V7
+	help
+	  This enables support for HPE ARM based BMC chips.
+if ARCH_HPE
+
+config ARCH_HPE_GXP
+	bool "HPE GXP SoC"
+	depends on ARCH_MULTI_V7
+	select ARM_VIC
+	select GENERIC_IRQ_CHIP
+	select CLKSRC_MMIO
+	help
+	  HPE GXP is the name of the HPE Soc. This SoC is used to implement many
+	  BMC features at HPE. It supports ARMv7 architecture based on the Cortex
+	  A9 core. It is capable of using an AXI bus to which a memory controller
+	  is attached. It has multiple SPI interfaces to connect boot flash and
+	  BIOS flash. It uses a 10/100/1000 MAC for network connectivity. It
+	  has multiple i2c engines to drive connectivity with a host
+	  infrastructure.
+
+endif
diff --git a/arch/arm/mach-hpe/Makefile b/arch/arm/mach-hpe/Makefile
new file mode 100644
index 000000000000..8b0a91234df4
--- /dev/null
+++ b/arch/arm/mach-hpe/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARCH_HPE_GXP) += gxp.o
diff --git a/arch/arm/mach-hpe/gxp.c b/arch/arm/mach-hpe/gxp.c
new file mode 100644
index 000000000000..ef3341373006
--- /dev/null
+++ b/arch/arm/mach-hpe/gxp.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
+
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+
+static const char * const gxp_board_dt_compat[] = {
+	"hpe,gxp",
+	NULL,
+};
+
+DT_MACHINE_START(GXP_DT, "HPE GXP")
+	.dt_compat	= gxp_board_dt_compat,
+	.l2c_aux_val = 0,
+	.l2c_aux_mask = ~0,
+MACHINE_END
-- 
2.17.1


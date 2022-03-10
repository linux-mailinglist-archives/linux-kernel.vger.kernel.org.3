Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252654D528F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244190AbiCJTvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiCJTvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:51:22 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94097ECC43
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:50:20 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AHWEWx021527;
        Thu, 10 Mar 2022 19:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id; s=pps0720;
 bh=9tL6vGftLX7I4EakjMlpMYrSUwc+8DlAsoS1M1GFjIg=;
 b=GEDQx91HxwGGy2m9oe/qPfHA4LrWdteA/Ehy3wwQD87qSLsAEMfPoOElg3Gy9gGr67UA
 eaoraG95R0wJ0pnvIIGdzLdldVm9wFpnNe2/DqCPARIEKQsRep0oqabeLKyKGlIOqdMU
 VTucvMbxdWfp1ly2/nsDsT8g0T1o0Ym8Li7RJBpveIdbta4/XwjYSCaogW3ZbYUYW5FW
 htgN/d8a/EEa0xZ0h5KitR0syaLyKmbqJyHvYCnL+GbFnRF/y8bJiLN42r2c4IqYWkwg
 3i+tc3MqrslkSHIk03ikxQdg26U9Tch3pS7eJzYj/LioyzSp9SVt6XcVatj63YdR50vE vg== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3eqb9f7sbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 19:50:14 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 0CBB482;
        Thu, 10 Mar 2022 19:50:13 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/10] arch: arm: mach-hpe: Introduce the HPE GXP architecture
Date:   Thu, 10 Mar 2022 13:52:20 -0600
Message-Id: <20220310195229.109477-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: qF5SqWJqNmnq3zjRF2nTAsrsQrH6qABv
X-Proofpoint-ORIG-GUID: qF5SqWJqNmnq3zjRF2nTAsrsQrH6qABv
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100100
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP is the HPE BMC SoC that is used in the majority
of HPE Generation 10 servers. Traditionally the asic will
last multiple generations of server before being replaced.
In gxp.c we reset the EHCI controller early to boot the asic.

Info about SoC:

HPE GXP is the name of the HPE Soc. This SoC is used to implement
many BMC features at HPE. It supports ARMv7 architecture based on
the Cortex A9 core. It is capable of using an AXI bus to which
a memory controller is attached. It has multiple SPI interfaces
to connect boot flash and BIOS flash. It uses a 10/100/1000 MAC
for network connectivity. It has multiple i2c engines to drive
connectivity with a host infrastructure. The initial patches
enable the watchdog and timer enabling the host to be able to
boot.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 arch/arm/Kconfig           |  2 ++
 arch/arm/Makefile          |  1 +
 arch/arm/mach-hpe/Kconfig  | 20 +++++++++++++
 arch/arm/mach-hpe/Makefile |  1 +
 arch/arm/mach-hpe/gxp.c    | 61 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 85 insertions(+)
 create mode 100644 arch/arm/mach-hpe/Kconfig
 create mode 100644 arch/arm/mach-hpe/Makefile
 create mode 100644 arch/arm/mach-hpe/gxp.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c97cb40eebb..6998b5b5f59e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -618,6 +618,8 @@ source "arch/arm/mach-highbank/Kconfig"
 
 source "arch/arm/mach-hisi/Kconfig"
 
+source "arch/arm/mach-hpe/Kconfig"
+
 source "arch/arm/mach-imx/Kconfig"
 
 source "arch/arm/mach-integrator/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 77172d555c7e..1cc0523d0a0a 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -178,6 +178,7 @@ machine-$(CONFIG_ARCH_FOOTBRIDGE)	+= footbridge
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
 machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
 machine-$(CONFIG_ARCH_HISI)		+= hisi
+machine-$(CONFIG_ARCH_HPE)		+= hpe
 machine-$(CONFIG_ARCH_INTEGRATOR)	+= integrator
 machine-$(CONFIG_ARCH_IOP32X)		+= iop32x
 machine-$(CONFIG_ARCH_IXP4XX)		+= ixp4xx
diff --git a/arch/arm/mach-hpe/Kconfig b/arch/arm/mach-hpe/Kconfig
new file mode 100644
index 000000000000..9b27f97c6536
--- /dev/null
+++ b/arch/arm/mach-hpe/Kconfig
@@ -0,0 +1,20 @@
+menuconfig ARCH_HPE
+	bool "HPE SoC support"
+	help
+	  This enables support for HPE ARM based SoC chips
+if ARCH_HPE
+
+config ARCH_HPE_GXP
+	bool "HPE GXP SoC"
+	select ARM_VIC
+	select PINCTRL
+	select IRQ_DOMAIN
+	select GENERIC_IRQ_CHIP
+	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
+	select CLKSRC_MMIO
+	depends on ARCH_MULTI_V7
+	help
+	  Support for GXP SoCs
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
index 000000000000..44f6d719a346
--- /dev/null
+++ b/arch/arm/mach-hpe/gxp.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P.*/
+
+
+#include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#define IOP_REGS_PHYS_BASE 0xc0000000
+#define IOP_REGS_VIRT_BASE 0xf0000000
+#define IOP_REGS_SIZE (240*SZ_1M)
+#define RESET_CMD 0x00080002
+
+static struct map_desc gxp_io_desc[] __initdata = {
+	{
+		.virtual	= (unsigned long)IOP_REGS_VIRT_BASE,
+		.pfn		= __phys_to_pfn(IOP_REGS_PHYS_BASE),
+		.length		= IOP_REGS_SIZE,
+		.type		= MT_DEVICE,
+	},
+};
+
+void __init gxp_map_io(void)
+{
+	iotable_init(gxp_io_desc, ARRAY_SIZE(gxp_io_desc));
+}
+
+static void __init gxp_dt_init(void)
+{
+	void __iomem *gxp_init_regs;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "hpe,gxp-cpu-init");
+	gxp_init_regs = of_iomap(np, 0);
+
+	/*it is necessary for our SOC to reset ECHI through this*/
+	/* register due to a hardware limitation*/
+	__raw_writel(RESET_CMD,
+		(gxp_init_regs));
+
+}
+
+static void gxp_restart(enum reboot_mode mode, const char *cmd)
+{
+	__raw_writel(1, (void __iomem *) IOP_REGS_VIRT_BASE);
+}
+
+static const char * const gxp_board_dt_compat[] = {
+	"hpe,gxp",
+	NULL,
+};
+
+DT_MACHINE_START(GXP_DT, "HPE GXP")
+	.init_machine	= gxp_dt_init,
+	.map_io		= gxp_map_io,
+	.restart	= gxp_restart,
+	.dt_compat	= gxp_board_dt_compat,
+MACHINE_END
-- 
2.17.1


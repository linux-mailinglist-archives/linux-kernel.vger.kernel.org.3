Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7BF508B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379893AbiDTPC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379913AbiDTPCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:02:48 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD2BC05
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:00:01 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KERNxD001436;
        Wed, 20 Apr 2022 14:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id; s=pps0720;
 bh=6EVzzWw3rbj9GSV1LKyai+gYVjSZk7leRknLcBfEe9s=;
 b=l4/slpp2U+2GoRPgu5qG/B2OHjc3WWFc+MqXscpC278eJmu1KtEmlb6xucaTUHuhSmhK
 Uy83Ald8LeESdeGdolMuvztvmy5ldYV6nbcYRfrTlhbVH5ezJF5MLke+oYmFqbraapgY
 jQICQnQ9LSI03gBr72HP8aWoqfK86RPoIAP08svddZMJ+b+TQptij8vCmoxfhzlrex+t
 vy6y5udyfez2Y+/aPl/+ID+jGvcNl6dJbzW7bxDjU79ft3Glhh+uWU/U4HGa7FYOQ3pi
 DzHLprY0Vb8fxkj15i6Dtjd/E2pJdAJZt+utd2KrNJBOgxbqLKkYjcgzXXTqaEmTYPpb VA== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fjky1g9ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:59:51 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 8150062;
        Wed, 20 Apr 2022 14:59:50 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id ABFA339;
        Wed, 20 Apr 2022 14:59:49 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick@hpe.com, joel@jms.id.au, arnd@arndb.de
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/11] arch: arm: mach-hpe: Introduce the HPE GXP architecture
Date:   Wed, 20 Apr 2022 10:01:45 -0500
Message-Id: <20220420150156.47405-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: 4qIB7juVVhcG3vJ--lShEnkS0ZVVj76l
X-Proofpoint-GUID: 4qIB7juVVhcG3vJ--lShEnkS0ZVVj76l
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204200089
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
v4:
* Removed unecessary code: restart, iomap, init_machine
* Reordered Kconfig so depends
* Removed SPARSE_IRQ, MULTI_IRQ_HANDLER, IRQ_DOMAIN, PINCTL from
  Kconfig
---
 arch/arm/Kconfig           |  2 ++
 arch/arm/Makefile          |  1 +
 arch/arm/mach-hpe/Kconfig  | 17 +++++++++++++++++
 arch/arm/mach-hpe/Makefile |  1 +
 arch/arm/mach-hpe/gxp.c    | 16 ++++++++++++++++
 5 files changed, 37 insertions(+)
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
index 000000000000..c075248b259e
--- /dev/null
+++ b/arch/arm/mach-hpe/Kconfig
@@ -0,0 +1,17 @@
+menuconfig ARCH_HPE
+	bool "HPE SoC support"
+	depends on ARCH_MULTI_V7
+	help
+	  This enables support for HPE ARM based SoC chips
+if ARCH_HPE
+
+config ARCH_HPE_GXP
+	bool "HPE GXP SoC"
+	depends on ARCH_MULTI_V7
+	select ARM_VIC
+	select GENERIC_IRQ_CHIP
+	select CLKSRC_MMIO
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
index 000000000000..e2f0c3ae6bd8
--- /dev/null
+++ b/arch/arm/mach-hpe/gxp.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P.*/
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
+	.l2c_aux_mask = 0,
+MACHINE_END
-- 
2.17.1


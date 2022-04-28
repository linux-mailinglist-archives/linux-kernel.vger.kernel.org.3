Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C70513532
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347233AbiD1NgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347218AbiD1NgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:36:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307D121242;
        Thu, 28 Apr 2022 06:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2D9BB82D13;
        Thu, 28 Apr 2022 13:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB31C385AA;
        Thu, 28 Apr 2022 13:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651152765;
        bh=TdsmGBfhLb6EpL2bc7aXZ8uPegbZvnGnOlqjuT9ku/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aydvV/UDHxMpY73vPCQLCCSlEHykG4e0WFWP1/Et4Z/zDuUfu59W/vZnjyHFUn+9X
         WgmfcD9QI/LNcOivsnP0+aEhtKEdOCTnwzrQdmysmVtwaMu/RqpEVQwyJCpdpBeige
         ZkbkZNTqjpzOa/9FB7YIiwDFMQ5ctrE3nuSc6wOgB9M/O0yuTCBt5c9jA7vYN/l/wR
         BwB8Yg6Rc/0hHeuLnTCVmx8yTDwMCTZ+K/wDn4sHcal/ownzW8tgR8Ku2gk30hl81H
         Y2zz/gwneAcwI2np1utg+Qb1P+4PWkwpeflTarZanEcUgYJENw//3kJwtB9CD4lIc2
         YLJ92mcW7/mzQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     tony@atomide.com, jmkrzyszt@gmail.com, aaro.koskinen@iki.fi,
        vireshk@kernel.org, shiraz.linux.kernel@gmail.com, nsekhar@ti.com,
        brgl@bgdev.pl, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/6] ARM: omap2: remove include/mach/ subdirectory
Date:   Thu, 28 Apr 2022 15:31:53 +0200
Message-Id: <20220428133210.990808-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220428133210.990808-1-arnd@kernel.org>
References: <20220428133210.990808-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

mach/serial.h is only included from arch/arm/mach-omap2/serial.h,
and the other two files are unused and empty.

Remove the directory by relocating the contents of mach/serial.h
and dropping all other references.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/Makefile                |  3 -
 arch/arm/mach-omap2/include/mach/hardware.h |  3 -
 arch/arm/mach-omap2/include/mach/irqs.h     |  3 -
 arch/arm/mach-omap2/include/mach/serial.h   | 66 --------------------
 arch/arm/mach-omap2/serial.h                | 67 ++++++++++++++++++++-
 5 files changed, 66 insertions(+), 76 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/serial.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8306ad686bc8..2feb9f6630af 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,9 +3,6 @@
 # Makefile for the linux kernel.
 #
 
-ccflags-y := -I$(srctree)/$(src)/include \
-	-I$(srctree)/arch/arm/plat-omap/include
-
 # Common support
 obj-y := id.o io.o control.o devices.o fb.o pm.o \
 	 common.o dma.o omap-headsmp.o sram.o
diff --git a/arch/arm/mach-omap2/include/mach/hardware.h b/arch/arm/mach-omap2/include/mach/hardware.h
deleted file mode 100644
index 54492dbf6973..000000000000
--- a/arch/arm/mach-omap2/include/mach/hardware.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/*
- * arch/arm/mach-omap2/include/mach/hardware.h
- */
diff --git a/arch/arm/mach-omap2/include/mach/irqs.h b/arch/arm/mach-omap2/include/mach/irqs.h
deleted file mode 100644
index ba5282cafa42..000000000000
--- a/arch/arm/mach-omap2/include/mach/irqs.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/*
- * arch/arm/mach-omap2/include/mach/irqs.h
- */
diff --git a/arch/arm/mach-omap2/include/mach/serial.h b/arch/arm/mach-omap2/include/mach/serial.h
deleted file mode 100644
index 7ca1fcff453b..000000000000
--- a/arch/arm/mach-omap2/include/mach/serial.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * Copyright (C) 2009 Texas Instruments
- * Added OMAP4 support- Santosh Shilimkar <santosh.shilimkar@ti.com>
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- */
-
-/* OMAP2 serial ports */
-#define OMAP2_UART1_BASE	0x4806a000
-#define OMAP2_UART2_BASE	0x4806c000
-#define OMAP2_UART3_BASE	0x4806e000
-
-/* OMAP3 serial ports */
-#define OMAP3_UART1_BASE	OMAP2_UART1_BASE
-#define OMAP3_UART2_BASE	OMAP2_UART2_BASE
-#define OMAP3_UART3_BASE	0x49020000
-#define OMAP3_UART4_BASE	0x49042000	/* Only on 36xx */
-#define OMAP3_UART4_AM35XX_BASE	0x4809E000	/* Only on AM35xx */
-
-/* OMAP4 serial ports */
-#define OMAP4_UART1_BASE	OMAP2_UART1_BASE
-#define OMAP4_UART2_BASE	OMAP2_UART2_BASE
-#define OMAP4_UART3_BASE	0x48020000
-#define OMAP4_UART4_BASE	0x4806e000
-
-/* TI81XX serial ports */
-#define TI81XX_UART1_BASE	0x48020000
-#define TI81XX_UART2_BASE	0x48022000
-#define TI81XX_UART3_BASE	0x48024000
-
-/* AM3505/3517 UART4 */
-#define AM35XX_UART4_BASE	0x4809E000	/* Only on AM3505/3517 */
-
-/* AM33XX serial port */
-#define AM33XX_UART1_BASE	0x44E09000
-
-/* OMAP5 serial ports */
-#define OMAP5_UART1_BASE	OMAP2_UART1_BASE
-#define OMAP5_UART2_BASE	OMAP2_UART2_BASE
-#define OMAP5_UART3_BASE	OMAP4_UART3_BASE
-#define OMAP5_UART4_BASE	OMAP4_UART4_BASE
-#define OMAP5_UART5_BASE	0x48066000
-#define OMAP5_UART6_BASE	0x48068000
-
-/* External port on Zoom2/3 */
-#define ZOOM_UART_BASE		0x10000000
-#define ZOOM_UART_VIRT		0xfa400000
-
-#define OMAP_PORT_SHIFT		2
-#define ZOOM_PORT_SHIFT		1
-
-#define OMAP24XX_BASE_BAUD	(48000000/16)
-
-#ifndef __ASSEMBLER__
-
-struct omap_board_data;
-struct omap_uart_port_info;
-
-extern void omap_serial_init(void);
-extern void omap_serial_board_init(struct omap_uart_port_info *platform_data);
-extern void omap_serial_init_port(struct omap_board_data *bdata,
-		struct omap_uart_port_info *platform_data);
-#endif
diff --git a/arch/arm/mach-omap2/serial.h b/arch/arm/mach-omap2/serial.h
index c4014f013df0..7ca1fcff453b 100644
--- a/arch/arm/mach-omap2/serial.h
+++ b/arch/arm/mach-omap2/serial.h
@@ -1 +1,66 @@
-#include <mach/serial.h>
+/*
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support- Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+/* OMAP2 serial ports */
+#define OMAP2_UART1_BASE	0x4806a000
+#define OMAP2_UART2_BASE	0x4806c000
+#define OMAP2_UART3_BASE	0x4806e000
+
+/* OMAP3 serial ports */
+#define OMAP3_UART1_BASE	OMAP2_UART1_BASE
+#define OMAP3_UART2_BASE	OMAP2_UART2_BASE
+#define OMAP3_UART3_BASE	0x49020000
+#define OMAP3_UART4_BASE	0x49042000	/* Only on 36xx */
+#define OMAP3_UART4_AM35XX_BASE	0x4809E000	/* Only on AM35xx */
+
+/* OMAP4 serial ports */
+#define OMAP4_UART1_BASE	OMAP2_UART1_BASE
+#define OMAP4_UART2_BASE	OMAP2_UART2_BASE
+#define OMAP4_UART3_BASE	0x48020000
+#define OMAP4_UART4_BASE	0x4806e000
+
+/* TI81XX serial ports */
+#define TI81XX_UART1_BASE	0x48020000
+#define TI81XX_UART2_BASE	0x48022000
+#define TI81XX_UART3_BASE	0x48024000
+
+/* AM3505/3517 UART4 */
+#define AM35XX_UART4_BASE	0x4809E000	/* Only on AM3505/3517 */
+
+/* AM33XX serial port */
+#define AM33XX_UART1_BASE	0x44E09000
+
+/* OMAP5 serial ports */
+#define OMAP5_UART1_BASE	OMAP2_UART1_BASE
+#define OMAP5_UART2_BASE	OMAP2_UART2_BASE
+#define OMAP5_UART3_BASE	OMAP4_UART3_BASE
+#define OMAP5_UART4_BASE	OMAP4_UART4_BASE
+#define OMAP5_UART5_BASE	0x48066000
+#define OMAP5_UART6_BASE	0x48068000
+
+/* External port on Zoom2/3 */
+#define ZOOM_UART_BASE		0x10000000
+#define ZOOM_UART_VIRT		0xfa400000
+
+#define OMAP_PORT_SHIFT		2
+#define ZOOM_PORT_SHIFT		1
+
+#define OMAP24XX_BASE_BAUD	(48000000/16)
+
+#ifndef __ASSEMBLER__
+
+struct omap_board_data;
+struct omap_uart_port_info;
+
+extern void omap_serial_init(void);
+extern void omap_serial_board_init(struct omap_uart_port_info *platform_data);
+extern void omap_serial_init_port(struct omap_board_data *bdata,
+		struct omap_uart_port_info *platform_data);
+#endif
-- 
2.29.2


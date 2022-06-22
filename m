Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4FC554AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354697AbiFVNLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354191AbiFVNLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:11:47 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE3D36E08;
        Wed, 22 Jun 2022 06:11:42 -0700 (PDT)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E0E83FF804;
        Wed, 22 Jun 2022 13:11:26 +0000 (UTC)
From:   Ash Logan <ash@heyquark.com>
To:     paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net, linkmauve@linkmauve.fr,
        rw-r-r-0644@protonmail.com, devicetree@vger.kernel.org
Subject: [PATCH v2 06/12] powerpc: wiiu: udbg support for latteipc
Date:   Wed, 22 Jun 2022 23:10:31 +1000
Message-Id: <20220622131037.57604-7-ash@heyquark.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622131037.57604-1-ash@heyquark.com>
References: <20220302044406.63401-1-ash@heyquark.com>
 <20220622131037.57604-1-ash@heyquark.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for using the Latte chipset IPC for udbg on the Nintendo Wii
U console.
These messages can then be received by a special firmware running on the
"Starbuck" coprocessor.

Signed-off-by: Ash Logan <ash@heyquark.com>
---
 arch/powerpc/Kconfig.debug                  |   9 ++
 arch/powerpc/include/asm/udbg.h             |   1 +
 arch/powerpc/kernel/head_book3s_32.S        |  20 ++++
 arch/powerpc/kernel/udbg.c                  |   3 +
 arch/powerpc/platforms/wiiu/Kconfig         |  13 +++
 arch/powerpc/platforms/wiiu/Makefile        |   2 +
 arch/powerpc/platforms/wiiu/udbg_latteipc.c | 122 ++++++++++++++++++++
 arch/powerpc/platforms/wiiu/udbg_latteipc.h |  27 +++++
 8 files changed, 197 insertions(+)
 create mode 100644 arch/powerpc/platforms/wiiu/udbg_latteipc.c
 create mode 100644 arch/powerpc/platforms/wiiu/udbg_latteipc.h

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 192f0ed0097f..15c7fa7c040a 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -254,6 +254,15 @@ config PPC_EARLY_DEBUG_USBGECKO
 	  Select this to enable early debugging for Nintendo GameCube/Wii
 	  consoles via an external USB Gecko adapter.
 
+config PPC_EARLY_DEBUG_LATTEIPC
+	bool "Early debugging through Latte chipset IPC"
+	depends on WIIU
+	select LATTEIPC_UDBG
+	help
+	  Select this to enable early debugging for Nintendo Wii U consoles via
+	  chipset IPC to the security coprocessor. This assumes a firmware is
+	  running on the coprocessor to receive messages.
+
 config PPC_EARLY_DEBUG_PS3GELIC
 	bool "Early debugging through the PS3 Ethernet port"
 	depends on PPC_PS3
diff --git a/arch/powerpc/include/asm/udbg.h b/arch/powerpc/include/asm/udbg.h
index b4aa0d88ce2c..266b0e744ddc 100644
--- a/arch/powerpc/include/asm/udbg.h
+++ b/arch/powerpc/include/asm/udbg.h
@@ -53,6 +53,7 @@ extern void __init udbg_init_ehv_bc(void);
 extern void __init udbg_init_ps3gelic(void);
 extern void __init udbg_init_debug_opal_raw(void);
 extern void __init udbg_init_debug_opal_hvsi(void);
+extern void __init udbg_init_latteipc(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */
diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 6c739beb938c..48d487efb25c 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -164,6 +164,9 @@ __after_mmu_off:
 #ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
 	bl	setup_usbgecko_bat
 #endif
+#ifdef CONFIG_PPC_EARLY_DEBUG_LATTEIPC
+	bl	setup_latteipc_bat
+#endif
 
 /*
  * Call setup_cpu for CPU 0 and initialize 6xx Idle
@@ -1201,4 +1204,21 @@ setup_usbgecko_bat:
 	blr
 #endif
 
+#ifdef CONFIG_PPC_EARLY_DEBUG_LATTEIPC
+setup_latteipc_bat:
+	/* prepare a BAT for early io */
+	lis	r8, 0x0d80
+
+	/*
+	 * The virtual address used must match the virtual address
+	 * associated to the fixmap entry FIX_EARLY_DEBUG_BASE.
+	 */
+	lis	r11, 0xfffe	/* top 128K */
+	ori	r8, r8, 0x002a	/* uncached, guarded ,rw */
+	ori	r11, r11, 0x2	/* 128K, Vs=1, Vp=0 */
+	mtspr	SPRN_DBAT1L, r8
+	mtspr	SPRN_DBAT1U, r11
+	blr
+#endif
+
 	.data
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index b1544b2f6321..84eae25c195e 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -67,6 +67,9 @@ void __init udbg_early_init(void)
 	udbg_init_debug_opal_raw();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_OPAL_HVSI)
 	udbg_init_debug_opal_hvsi();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_LATTEIPC)
+	/* For use on Nintendo Wii U */
+	udbg_init_latteipc();
 #endif
 
 #ifdef CONFIG_PPC_EARLY_DEBUG
diff --git a/arch/powerpc/platforms/wiiu/Kconfig b/arch/powerpc/platforms/wiiu/Kconfig
index e5513205da3c..fa86cbc33d5e 100644
--- a/arch/powerpc/platforms/wiiu/Kconfig
+++ b/arch/powerpc/platforms/wiiu/Kconfig
@@ -3,3 +3,16 @@
 config WIIU
 	bool "Nintendo Wii U"
 	depends on PPC_BOOK3S_32
+
+config LATTEIPC_UDBG
+	bool "Chipset IPC udbg console for the Nintendo Wii U"
+	depends on WIIU
+	help
+	  If you say yes to this option, support will be included for the
+	  Wii U's chipset IPC as a udbg console.
+	  These IPC messages can be received by a firmware running on the
+	  console's "Starbuck" security coprocessor.
+
+	  This driver bypasses the IPC layer completely.
+
+	  If in doubt, say N here.
diff --git a/arch/powerpc/platforms/wiiu/Makefile b/arch/powerpc/platforms/wiiu/Makefile
index f66554cd5c45..b1e0e1307f6e 100644
--- a/arch/powerpc/platforms/wiiu/Makefile
+++ b/arch/powerpc/platforms/wiiu/Makefile
@@ -1 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_LATTEIPC_UDBG) += udbg_latteipc.o
diff --git a/arch/powerpc/platforms/wiiu/udbg_latteipc.c b/arch/powerpc/platforms/wiiu/udbg_latteipc.c
new file mode 100644
index 000000000000..d546b3ba9bab
--- /dev/null
+++ b/arch/powerpc/platforms/wiiu/udbg_latteipc.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Nintendo Wii U udbg support (to Starbuck coprocessor, via chipset IPC)
+ *
+ * Copyright (C) 2022 The linux-wiiu Team
+ *
+ * Based on arch/powerpc/platforms/embedded6xx/udbgecko_udbg.c
+ * Copyright (C) 2008-2009 The GameCube Linux Team
+ * Copyright (C) 2008-2009 Albert Herranz
+ */
+
+#include <mm/mmu_decl.h>
+
+#include <linux/io.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/fixmap.h>
+
+#define LT_MMIO_BASE ((phys_addr_t)0x0d800000)
+#define LT_IPC_PPCMSG 0x00
+#define LT_IPC_PPCCTRL 0x04
+#define LT_IPC_PPCCTRL_X1 0x01
+
+#define WIIU_LOADER_CMD_PRINT 0x01000000
+
+void __iomem *latteipc_io_base;
+
+/*
+ * Transmits a character.
+ * Sends over IPC to linux-loader for printing.
+ */
+static void latteipc_udbg_putc(char c)
+{
+	void __iomem *ppcmsg_reg = latteipc_io_base + LT_IPC_PPCMSG;
+	void __iomem *ppcctrl_reg = latteipc_io_base + LT_IPC_PPCCTRL;
+
+	out_be32(ppcmsg_reg, WIIU_LOADER_CMD_PRINT | (c << 16));
+	out_be32(ppcctrl_reg, LT_IPC_PPCCTRL_X1);
+
+	while (in_be32(ppcctrl_reg) & LT_IPC_PPCCTRL_X1)
+		barrier();
+}
+
+/*
+ * Retrieves and prepares the virtual address needed to access the hardware.
+ */
+static void __iomem *latteipc_udbg_setup_ipc_io_base(struct device_node *np)
+{
+	void __iomem *ipc_io_base = NULL;
+	phys_addr_t paddr;
+	const unsigned int *reg;
+
+	reg = of_get_property(np, "reg", NULL);
+	if (reg) {
+		paddr = of_translate_address(np, reg);
+		if (paddr)
+			ipc_io_base = ioremap(paddr, reg[1]);
+	}
+	return ipc_io_base;
+}
+
+/*
+ * Latte IPC udbg support initialization.
+ */
+void __init latteipc_udbg_init(void)
+{
+	struct device_node *np;
+	void __iomem *ipc_io_base;
+
+	if (latteipc_io_base)
+		udbg_printf("%s: early -> final\n", __func__);
+
+	np = of_find_compatible_node(NULL, NULL, "nintendo,latte-ipc");
+	if (!np) {
+		udbg_printf("%s: IPC node not found\n", __func__);
+		goto out;
+	}
+
+	ipc_io_base = latteipc_udbg_setup_ipc_io_base(np);
+	if (!ipc_io_base) {
+		udbg_printf("%s: failed to setup IPC io base\n", __func__);
+		goto done;
+	}
+
+	udbg_putc = latteipc_udbg_putc;
+	udbg_printf("latteipc_udbg: ready\n");
+
+done:
+	of_node_put(np);
+out:
+	return;
+}
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_LATTEIPC
+
+void __init udbg_init_latteipc(void)
+{
+	/*
+	 * At this point we have a BAT already setup that enables I/O
+	 * to the IPC hardware.
+	 *
+	 * The BAT uses a virtual address range reserved at the fixmap.
+	 * This must match the virtual address configured in
+	 * head_32.S:setup_latteipc_bat().
+	 */
+	latteipc_io_base = (void __iomem *)__fix_to_virt(FIX_EARLY_DEBUG_BASE);
+
+	/* Assume a firmware is present, add hooks */
+	udbg_putc = latteipc_udbg_putc;
+
+	/*
+	 * Prepare again the same BAT for MMU_init.
+	 * This allows udbg I/O to continue working after the MMU is
+	 * turned on for real.
+	 * It is safe to continue using the same virtual address as it is
+	 * a reserved fixmap area.
+	 */
+	setbat(1, (unsigned long)latteipc_io_base, LT_MMIO_BASE, 128 * 1024,
+	       PAGE_KERNEL_NCG);
+}
+
+#endif /* CONFIG_PPC_EARLY_DEBUG_LATTEIPC */
diff --git a/arch/powerpc/platforms/wiiu/udbg_latteipc.h b/arch/powerpc/platforms/wiiu/udbg_latteipc.h
new file mode 100644
index 000000000000..ca6d34e49158
--- /dev/null
+++ b/arch/powerpc/platforms/wiiu/udbg_latteipc.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Nintendo Wii U udbg support (to Starbuck coprocessor, via chipset IPC)
+ *
+ * Copyright (C) 2022 The linux-wiiu Team
+ *
+ * Based on arch/powerpc/platforms/embedded6xx/udbgecko_udbg.h
+ * Copyright (C) 2008-2009 The GameCube Linux Team
+ * Copyright (C) 2008-2009 Albert Herranz
+ */
+
+#ifndef __LATTEIPC_UDBG_H
+#define __LATTEIPC_UDBG_H
+
+#ifdef CONFIG_LATTEIPC_UDBG
+
+void __init latteipc_udbg_init(void);
+
+#else
+
+static inline void __init latteipc_udbg_init(void)
+{
+}
+
+#endif /* CONFIG_LATTEIPC_UDBG */
+
+#endif /* __LATTEIPC_UDBG_H */
-- 
2.36.1


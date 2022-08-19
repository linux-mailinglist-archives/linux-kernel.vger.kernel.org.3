Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70DC59A784
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351330AbiHSVNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349982AbiHSVNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:13:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E97AE193E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ECE50CE26AA
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 21:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAA1C433B5;
        Fri, 19 Aug 2022 21:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660943583;
        bh=+Rvw9vn0HtDtyc7wIEhqRjcE8VcOb2fJ7652n66XI/k=;
        h=From:To:Cc:Subject:Date:From;
        b=qjQUXq8ne3MVJz1PvvEuCrv9H6+PbsCnaxvUgGkgZAX+3JDFxZW1i5pNAJLp6aDBN
         Eix6ZeHtL9VxU26NZFGmg6S5JY+FzjdjJJGLCFljW0opnATM4vXm9LGRQr1IG95nRq
         xwhFWEl24xKndOWF/L0QLHL8338BrCxjNyn3HcpU9JNAMb1VJEXMOLrtnPjIITyPPg
         DmTyhmkTf6AuZkKe49lfaz2j4UZ+m+UjYdNSpZOlFAopXnI4xPsCFfqiKtJd82rl1z
         3xTcXmH3quaUfsOetDSMeHHQ97EDal8/Ui8zV6NPnimLKXVBGv2ds5d4lYs1OuFEvA
         DLg+S6zZWhXGw==
Received: by pali.im (Postfix)
        id E674B761; Fri, 19 Aug 2022 23:12:59 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nick Child <nick.child@ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Add support for early debugging via Serial 16550 console
Date:   Fri, 19 Aug 2022 23:12:54 +0200
Message-Id: <20220819211254.22192-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently powerpc early debugging contains lot of platform specific
options, but does not support standard UART / serial 16550 console.

Later legacy_serial.c code supports registering UART as early debug console
from device tree but it is not early during booting, but rather later after
machine description code finishes.

So for real early debugging via UART is current code unsuitable.

Add support for new early debugging option CONFIG_PPC_EARLY_DEBUG_16550
which enable Serial 16550 console on address defined by new option
CONFIG_PPC_EARLY_DEBUG_16550_PHYSADDR and by stride by option
CONFIG_PPC_EARLY_DEBUG_16550_STRIDE.

With this change it is possible to debug powerpc machine descriptor code.
For example this early debugging code can print on serial console also
"No suitable machine description found" error which is done before
legacy_serial.c code.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
Tested on P2020 board. It allowed me do debug and implement this patch series:
https://lore.kernel.org/linuxppc-dev/20220819191557.28116-1-pali@kernel.org/
---
 arch/powerpc/Kconfig.debug       | 14 ++++++++++++++
 arch/powerpc/include/asm/udbg.h  |  1 +
 arch/powerpc/kernel/udbg.c       |  2 ++
 arch/powerpc/kernel/udbg_16550.c | 33 ++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 9f363c143d86..a4e7d90a45d2 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -276,6 +276,11 @@ config PPC_EARLY_DEBUG_OPAL_HVSI
 	  Select this to enable early debugging for the PowerNV platform
 	  using an "hvsi" console
 
+config PPC_EARLY_DEBUG_16550
+	bool "Serial 16550"
+	help
+	  Select this to enable early debugging via Serial 16550 console
+
 config PPC_EARLY_DEBUG_MEMCONS
 	bool "In memory console"
 	help
@@ -355,6 +360,15 @@ config PPC_EARLY_DEBUG_CPM_ADDR
 	  platform probing is done, all platforms selected must
 	  share the same address.
 
+config PPC_EARLY_DEBUG_16550_PHYSADDR
+	hex "Early debug Serial 16550 physical address"
+	depends on PPC_EARLY_DEBUG_16550
+
+config PPC_EARLY_DEBUG_16550_STRIDE
+	int "Early debug Serial 16550 stride"
+	depends on PPC_EARLY_DEBUG_16550
+	default 1
+
 config FAIL_IOMMU
 	bool "Fault-injection capability for IOMMU"
 	depends on FAULT_INJECTION
diff --git a/arch/powerpc/include/asm/udbg.h b/arch/powerpc/include/asm/udbg.h
index b4aa0d88ce2c..20b5a37ab772 100644
--- a/arch/powerpc/include/asm/udbg.h
+++ b/arch/powerpc/include/asm/udbg.h
@@ -53,6 +53,7 @@ extern void __init udbg_init_ehv_bc(void);
 extern void __init udbg_init_ps3gelic(void);
 extern void __init udbg_init_debug_opal_raw(void);
 extern void __init udbg_init_debug_opal_hvsi(void);
+extern void __init udbg_init_debug_16550(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index b1544b2f6321..92b3fc258d11 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -67,6 +67,8 @@ void __init udbg_early_init(void)
 	udbg_init_debug_opal_raw();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_OPAL_HVSI)
 	udbg_init_debug_opal_hvsi();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_16550)
+	udbg_init_debug_16550();
 #endif
 
 #ifdef CONFIG_PPC_EARLY_DEBUG
diff --git a/arch/powerpc/kernel/udbg_16550.c b/arch/powerpc/kernel/udbg_16550.c
index d3942de254c6..46f2d831d7c9 100644
--- a/arch/powerpc/kernel/udbg_16550.c
+++ b/arch/powerpc/kernel/udbg_16550.c
@@ -8,6 +8,7 @@
 #include <asm/udbg.h>
 #include <asm/io.h>
 #include <asm/reg_a2.h>
+#include <asm/early_ioremap.h>
 
 extern u8 real_readb(volatile u8 __iomem  *addr);
 extern void real_writeb(u8 data, volatile u8 __iomem *addr);
@@ -335,3 +336,35 @@ void __init udbg_init_debug_microwatt(void)
 }
 
 #endif /* CONFIG_PPC_EARLY_DEBUG_MICROWATT */
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_16550
+
+static void __iomem *udbg_uart_early_addr;
+
+void __init udbg_init_debug_16550(void)
+{
+	udbg_uart_early_addr = early_ioremap(CONFIG_PPC_EARLY_DEBUG_16550_PHYSADDR, 0x1000);
+	udbg_uart_init_mmio(udbg_uart_early_addr, CONFIG_PPC_EARLY_DEBUG_16550_STRIDE);
+}
+
+static int __init udbg_init_debug_16550_ioremap(void)
+{
+	void __iomem *addr;
+
+	if (!udbg_uart_early_addr)
+		return 0;
+
+	addr = ioremap(CONFIG_PPC_EARLY_DEBUG_16550_PHYSADDR, 0x1000);
+	if (WARN_ON(!addr))
+		return -ENOMEM;
+
+	udbg_uart_init_mmio(addr, CONFIG_PPC_EARLY_DEBUG_16550_STRIDE);
+	early_iounmap(udbg_uart_early_addr, 0x1000);
+	udbg_uart_early_addr = NULL;
+
+	return 0;
+}
+
+early_initcall(udbg_init_debug_16550_ioremap);
+
+#endif /* CONFIG_PPC_EARLY_DEBUG_16550 */
-- 
2.20.1


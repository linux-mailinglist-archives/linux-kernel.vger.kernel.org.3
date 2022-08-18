Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3B359869A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343850AbiHRO5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343851AbiHRO4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2F422283
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB89E6130D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9317C433D6;
        Thu, 18 Aug 2022 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660834598;
        bh=8EZFeDNWmKrvsacQqIwuZ/oUAfUGitD4UpNlh/cjBZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gJMiWOYBXDYqg3yoM2J1o/Qfvt2yTaRYNdhnpS55u+9zO54jW+Hks7Jl/f7Ni5S0+
         ksaATPcDLR6+nSAG8AfTUiDnQ4bUwn3vIAf3VqFJuVYir33wQGgy6cd8paTLBhUI0/
         GXvyxWOfftXEX2vYvhs1+S1Vngml7fqDzguZMcnagKsi/63Rph9ipVIgz4FxQ8Ou8T
         O46j7a+bKGjsIlVouXMo+3uftRA74kfYWkS2Hm46/Y3Qo2KeuYC/JzwP9+O8Hr6IZ7
         xJSt1a6W2P/nGLEOyLzO4PGj3jK38J+G5a9zv7CRJxS9+0Oi3Zq9ansSTvDIuDGD5L
         AsHVJbA6Ubc7Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 1/5] ARM: remove obsolete Makefile.boot infrastructure
Date:   Thu, 18 Aug 2022 16:56:12 +0200
Message-Id: <20220818145616.3156379-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818145616.3156379-1-arnd@kernel.org>
References: <20220818145616.3156379-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are a number of old Makefile.boot files that remain from the
multiplatform conversion, and three that are still in use.

These provide the "ZRELADDR", "PARAMS_PHYS" and "INITRD_PHYS" values
that are platform specific. It turns out that we can generally just
derive this from information that is available elsewhere:

- ZRELADDR is normally detected at runtime with the
  CONFIG_AUTO_ZRELADDR flag, but also needed to be passed to
  for 'make uImage'. In a multiplatform kernel, one always has
  to pass this as the $(LOADADDR) variable, but in the StrongARM
  kernels we can derive it from the sum of $(CONFIG_PHYS_OFFSET)
  and $(TEXT_OFFSET) that are already known.

- PARAMS_PHYS and INITRD_PHYS are only used for bootpImage, which
  in turn is only used for the pre-ATAGS 'param_struct' based boot
  interface on StrongARM based machines with old boot loaders.
  They can both be derived from CONFIG_PHYS_OFFSET and a machine
  specific offset for the initrd, so all of the logic for these
  can be part of arch/arm/boot/bootp/Makefile.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                       |  2 +-
 arch/arm/Makefile                      |  4 +--
 arch/arm/boot/Makefile                 | 27 ++++++--------------
 arch/arm/boot/bootp/Makefile           | 35 ++++++++++++++++++++++++--
 arch/arm/mach-at91/Makefile.boot       |  4 ---
 arch/arm/mach-davinci/Makefile.boot    |  8 ------
 arch/arm/mach-dove/Makefile.boot       |  4 ---
 arch/arm/mach-ep93xx/Makefile.boot     |  2 --
 arch/arm/mach-footbridge/Makefile.boot |  5 ----
 arch/arm/mach-imx/Makefile.boot        |  0
 arch/arm/mach-iop32x/Makefile.boot     |  4 ---
 arch/arm/mach-lpc18xx/Makefile.boot    |  4 ---
 arch/arm/mach-lpc32xx/Makefile.boot    |  4 ---
 arch/arm/mach-omap1/Makefile.boot      |  4 ---
 arch/arm/mach-rpc/Makefile.boot        |  5 ----
 arch/arm/mach-s3c/Makefile.boot        |  9 -------
 arch/arm/mach-sa1100/Makefile.boot     |  9 -------
 arch/arm/mach-stm32/Makefile.boot      |  4 ---
 arch/arm/mach-versatile/Makefile.boot  |  4 ---
 arch/arm/mach-vt8500/Makefile.boot     |  4 ---
 20 files changed, 43 insertions(+), 99 deletions(-)
 delete mode 100644 arch/arm/mach-at91/Makefile.boot
 delete mode 100644 arch/arm/mach-davinci/Makefile.boot
 delete mode 100644 arch/arm/mach-dove/Makefile.boot
 delete mode 100644 arch/arm/mach-ep93xx/Makefile.boot
 delete mode 100644 arch/arm/mach-footbridge/Makefile.boot
 delete mode 100644 arch/arm/mach-imx/Makefile.boot
 delete mode 100644 arch/arm/mach-iop32x/Makefile.boot
 delete mode 100644 arch/arm/mach-lpc18xx/Makefile.boot
 delete mode 100644 arch/arm/mach-lpc32xx/Makefile.boot
 delete mode 100644 arch/arm/mach-omap1/Makefile.boot
 delete mode 100644 arch/arm/mach-rpc/Makefile.boot
 delete mode 100644 arch/arm/mach-s3c/Makefile.boot
 delete mode 100644 arch/arm/mach-sa1100/Makefile.boot
 delete mode 100644 arch/arm/mach-stm32/Makefile.boot
 delete mode 100644 arch/arm/mach-versatile/Makefile.boot
 delete mode 100644 arch/arm/mach-vt8500/Makefile.boot

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87badeae3181..6894b4758bfb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -274,7 +274,7 @@ config NEED_MACH_MEMORY_H
 
 config PHYS_OFFSET
 	hex "Physical address of main memory" if MMU
-	depends on !ARM_PATCH_PHYS_VIRT
+	depends on !ARM_PATCH_PHYS_VIRT || !AUTO_ZRELADDR
 	default DRAM_BASE if !MMU
 	default 0x00000000 if ARCH_FOOTBRIDGE
 	default 0x10000000 if ARCH_OMAP1 || ARCH_RPC
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 56f655deebb1..369490d5f18a 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -310,7 +310,7 @@ bootpImage uImage: zImage
 zImage: Image
 
 $(BOOT_TARGETS): vmlinux
-	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 	@$(kecho) '  Kernel: $(boot)/$@ is ready'
 
 $(INSTALL_TARGETS): KBUILD_IMAGE = $(boot)/$(patsubst %install,%Image,$@)
@@ -324,7 +324,7 @@ ifeq ($(CONFIG_VDSO),y)
 endif
 
 # My testing targets (bypasses dependencies)
-bp:;	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/bootpImage
+bp:;	$(Q)$(MAKE) $(build)=$(boot) $(boot)/bootpImage
 
 
 define archhelp
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 54a09f9464fb..abd6a2889fd0 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -10,22 +10,16 @@
 #
 # Copyright (C) 1995-2002 Russell King
 #
-
 OBJCOPYFLAGS	:=-O binary -R .comment -S
 
-ifneq ($(MACHINE),)
-include $(MACHINE)/Makefile.boot
-endif
-
-# Note: the following conditions must always be true:
 #   ZRELADDR == virt_to_phys(PAGE_OFFSET + TEXT_OFFSET)
-#   PARAMS_PHYS must be within 4MB of ZRELADDR
-#   INITRD_PHYS must be in RAM
-ZRELADDR    := $(zreladdr-y)
-PARAMS_PHYS := $(params_phys-y)
-INITRD_PHYS := $(initrd_phys-y)
+ifdef CONFIG_PHYS_OFFSET
+add_hex = $(shell printf 0x%x $$(( $(1) + $(2) )) )
+ZRELADDR    := $(call add_hex, $(CONFIG_PHYS_OFFSET), $(TEXT_OFFSET))
+endif
 
-export ZRELADDR INITRD_PHYS PARAMS_PHYS
+PHYS_OFFSET := $(CONFIG_PHYS_OFFSET)
+export ZRELADDR PARAMS_PHYS PHYS_OFFSET
 
 targets := Image zImage xipImage bootpImage uImage
 
@@ -90,17 +84,10 @@ $(obj)/uImage:	$(obj)/zImage FORCE
 	@$(check_for_multiple_loadaddr)
 	$(call if_changed,uimage)
 
-$(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
+$(obj)/bootp/bootp: $(obj)/zImage FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
 
 $(obj)/bootpImage: $(obj)/bootp/bootp FORCE
 	$(call if_changed,objcopy)
 
-PHONY += initrd
-initrd:
-	@test "$(INITRD_PHYS)" != "" || \
-	(echo This machine does not support INITRD; exit -1)
-	@test "$(INITRD)" != "" || \
-	(echo You must specify INITRD; exit -1)
-
 subdir-	    := bootp compressed dts
diff --git a/arch/arm/boot/bootp/Makefile b/arch/arm/boot/bootp/Makefile
index 981a8d03f064..a2934e6fd89a 100644
--- a/arch/arm/boot/bootp/Makefile
+++ b/arch/arm/boot/bootp/Makefile
@@ -5,9 +5,40 @@
 # This file is included by the global makefile so that you can add your own
 # architecture-specific flags and dependencies.
 #
-
 GCOV_PROFILE	:= n
 
+ifdef PHYS_OFFSET
+add_hex = $(shell printf 0x%x $$(( $(1) + $(2) )) )
+
+# If PHYS_OFFSET is set, INITRD_PHYS and PARAMS_PHYS can be derived,
+# otherwise they must be passed on the command line.
+#
+# Note: the following conditions must always be true:
+#   PARAMS_PHYS must be within 4MB of ZRELADDR
+#   INITRD_PHYS must be in RAM
+
+PARAMS_PHYS := $(call add_hex, $(PHYS_OFFSET), 0x100)
+
+# guess an initrd location if possible
+initrd_offset-$(CONFIG_ARCH_FOOTBRIDGE)	+= 0x00800000
+initrd_offset-$(CONFIG_ARCH_SA1100)	+= 0x00800000
+initrd_offset-$(CONFIG_ARCH_RPC)	+= 0x08000000
+INITRD_OFFSET := $(initrd_offset-y)
+ifdef INITRD_OFFSET
+INITRD_PHYS := $(call add_hex, $(PHYS_OFFSET), $(INITRD_OFFSET))
+endif
+
+endif
+
+PHONY += initrd
+initrd:
+	@test "$(PARAMS_PHYS)" != "" || \
+	(echo bootpImage: You must specify PHYS_OFFSET of PARAMS_PHYS ; exit -1)
+	@test "$(INITRD_PHYS)" != "" || \
+	(echo bootpImage: You must specify INITRD_OFFSET or INITRD_PHYS ; exit -1)
+	@test "$(INITRD)" != "" || \
+	(echo bootpImage: You must specify INITRD; exit -1)
+
 LDFLAGS_bootp	:= --no-undefined -X \
 		 --defsym initrd_phys=$(INITRD_PHYS) \
 		 --defsym params_phys=$(PARAMS_PHYS) -T
@@ -24,6 +55,6 @@ $(obj)/bootp:	$(src)/bootp.lds $(addprefix $(obj)/,init.o kernel.o initrd.o) FOR
 
 $(obj)/kernel.o: arch/arm/boot/zImage FORCE
 
-$(obj)/initrd.o: $(INITRD) FORCE
+$(obj)/initrd.o: initrd $(INITRD) FORCE
 
 PHONY += $(INITRD)
diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
deleted file mode 100644
index 5dde7328a7a9..000000000000
--- a/arch/arm/mach-at91/Makefile.boot
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-# Empty file waiting for deletion once Makefile.boot isn't needed any more.
-# Patch waits for application at
-# https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7889/1 .
diff --git a/arch/arm/mach-davinci/Makefile.boot b/arch/arm/mach-davinci/Makefile.boot
deleted file mode 100644
index d36b251f325b..000000000000
--- a/arch/arm/mach-davinci/Makefile.boot
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-zreladdr-$(CONFIG_ARCH_DAVINCI_DA8XX)		+= 0xc0008000
-params_phys-$(CONFIG_ARCH_DAVINCI_DA8XX)	:= 0xc0000100
-initrd_phys-$(CONFIG_ARCH_DAVINCI_DA8XX)	:= 0xc0800000
-
-zreladdr-$(CONFIG_ARCH_DAVINCI_DMx)		+= 0x80008000
-params_phys-$(CONFIG_ARCH_DAVINCI_DMx)		:= 0x80000100
-initrd_phys-$(CONFIG_ARCH_DAVINCI_DMx)		:= 0x80800000
diff --git a/arch/arm/mach-dove/Makefile.boot b/arch/arm/mach-dove/Makefile.boot
deleted file mode 100644
index e4dd1d26038f..000000000000
--- a/arch/arm/mach-dove/Makefile.boot
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-ep93xx/Makefile.boot b/arch/arm/mach-ep93xx/Makefile.boot
deleted file mode 100644
index 4c0a039a5027..000000000000
--- a/arch/arm/mach-ep93xx/Makefile.boot
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-# Empty file waiting for deletion once Makefile.boot isn't needed any more.
diff --git a/arch/arm/mach-footbridge/Makefile.boot b/arch/arm/mach-footbridge/Makefile.boot
deleted file mode 100644
index e4313e912cac..000000000000
--- a/arch/arm/mach-footbridge/Makefile.boot
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
-
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/arch/arm/mach-iop32x/Makefile.boot b/arch/arm/mach-iop32x/Makefile.boot
deleted file mode 100644
index 5c3af01c4000..000000000000
--- a/arch/arm/mach-iop32x/Makefile.boot
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-   zreladdr-y	+= 0xa0008000
-params_phys-y	:= 0xa0000100
-initrd_phys-y	:= 0xa0800000
diff --git a/arch/arm/mach-lpc18xx/Makefile.boot b/arch/arm/mach-lpc18xx/Makefile.boot
deleted file mode 100644
index cec195d4fcba..000000000000
--- a/arch/arm/mach-lpc18xx/Makefile.boot
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-# Empty file waiting for deletion once Makefile.boot isn't needed any more.
-# Patch waits for application at
-# http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7889/1 .
diff --git a/arch/arm/mach-lpc32xx/Makefile.boot b/arch/arm/mach-lpc32xx/Makefile.boot
deleted file mode 100644
index 37d09ddb27f8..000000000000
--- a/arch/arm/mach-lpc32xx/Makefile.boot
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-   zreladdr-y	+= 0x80008000
-params_phys-y	:= 0x80000100
-initrd_phys-y	:= 0x82000000
diff --git a/arch/arm/mach-omap1/Makefile.boot b/arch/arm/mach-omap1/Makefile.boot
deleted file mode 100644
index 2c771515a606..000000000000
--- a/arch/arm/mach-omap1/Makefile.boot
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-   zreladdr-y		+= 0x10008000
-params_phys-y		:= 0x10000100
-initrd_phys-y		:= 0x10800000
diff --git a/arch/arm/mach-rpc/Makefile.boot b/arch/arm/mach-rpc/Makefile.boot
deleted file mode 100644
index 0ed8e8fbde99..000000000000
--- a/arch/arm/mach-rpc/Makefile.boot
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-   zreladdr-y	+= 0x10008000
-params_phys-y	:= 0x10000100
-initrd_phys-y	:= 0x18000000
-
diff --git a/arch/arm/mach-s3c/Makefile.boot b/arch/arm/mach-s3c/Makefile.boot
deleted file mode 100644
index 7f19e226035e..000000000000
--- a/arch/arm/mach-s3c/Makefile.boot
+++ /dev/null
@@ -1,9 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-ifeq ($(CONFIG_PM_H1940),y)
-	zreladdr-y	+= 0x30108000
-	params_phys-y	:= 0x30100100
-else
-	zreladdr-y	+= 0x30008000
-	params_phys-y	:= 0x30000100
-endif
diff --git a/arch/arm/mach-sa1100/Makefile.boot b/arch/arm/mach-sa1100/Makefile.boot
deleted file mode 100644
index 9d8246f2cab4..000000000000
--- a/arch/arm/mach-sa1100/Makefile.boot
+++ /dev/null
@@ -1,9 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-ifeq ($(CONFIG_SA1111),y)
-   zreladdr-y	+= 0xc0208000
-else
-   zreladdr-y	+= 0xc0008000
-endif
-params_phys-y	:= 0xc0000100
-initrd_phys-y	:= 0xc0800000
-
diff --git a/arch/arm/mach-stm32/Makefile.boot b/arch/arm/mach-stm32/Makefile.boot
deleted file mode 100644
index 5dde7328a7a9..000000000000
--- a/arch/arm/mach-stm32/Makefile.boot
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-# Empty file waiting for deletion once Makefile.boot isn't needed any more.
-# Patch waits for application at
-# https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7889/1 .
diff --git a/arch/arm/mach-versatile/Makefile.boot b/arch/arm/mach-versatile/Makefile.boot
deleted file mode 100644
index cec195d4fcba..000000000000
--- a/arch/arm/mach-versatile/Makefile.boot
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-# Empty file waiting for deletion once Makefile.boot isn't needed any more.
-# Patch waits for application at
-# http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7889/1 .
diff --git a/arch/arm/mach-vt8500/Makefile.boot b/arch/arm/mach-vt8500/Makefile.boot
deleted file mode 100644
index 883985f4b6c1..000000000000
--- a/arch/arm/mach-vt8500/Makefile.boot
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x01000000
-- 
2.29.2


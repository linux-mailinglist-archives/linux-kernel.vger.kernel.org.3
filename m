Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAED52928B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348501AbiEPVP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349128AbiEPVPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:15:18 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9258A17E0E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:10:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2fee45054e4so41092037b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Cg/cFHLp/jZrY1nm9TRZV4CgzVKGA5vHDB+v+p7d350=;
        b=OFlMnYZP35WuoywYTRyjactXswtkgG8edUTQpDFiotOEF6nZ2p/Y6nHvUmwTcWOh0d
         N7wdpaLH+cSa7B6iwGPjyVhfXJRHRsYs+VpmwsJFSXdCvf5S4K/D1veSXbRDhwnccTR+
         n9U5o5ouJS5yjVcpez3POY7zgXM7F04+1/QNG6JTlwBdalYzNwY4NOu/7MMc7pg18BXv
         LLiS0cSazbxyO9A9HGYKqYWZDUYkjaWED/fZW1DNVD9RGdc6aMuWMuxM8d5KNUAa/sTe
         Y6UqspDHsqjbJbRDYKYDDsTyULbBCx3QsJIb0urb0CBQfxbWE+IItbLlGfuk98RSkgkm
         Vt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Cg/cFHLp/jZrY1nm9TRZV4CgzVKGA5vHDB+v+p7d350=;
        b=X7/d35oyeloxDz74KF92L8kKYZOym6THgjqH5PpnIhcM0zn+5K63kUdTWAwj6HBpNS
         FZRkBKwXr52Ntvi402guqYUcXL1fvCmQEW4zYiSd6YTbxh6gnaZnPPfaQNne6cK5wWAT
         feo1ce+geQLhSdrmk7IV0Fcw4xz2hjabv1pb743ReO5RXy29kyBl4ftgsihw5QIVlgwP
         URI5U4aHKvJ5KfV8+CF9g+K+KRxsZCyJD6th6xZTJ2VyStJAPbn3fIXKLs3GMAYsYkVb
         mQRnwxPWjYKH8G6rIi6yLdfBIYgkz/CFtF2YXXKZRSu9yxze8OzHdZ24TiBSFmMFurXT
         j3ug==
X-Gm-Message-State: AOAM531wcZMNKBw6bJ+gRZ1WVik0cskw7POCJ0RU0G7OTeRwKerAjx9w
        aE2ZmW9YkyNwoST86gceyspogFSsn/lYNO3HnX0=
X-Google-Smtp-Source: ABdhPJzmHgtcc5q4X920N077OyuIcalo4tyZUpXY8uRkxAFMRx0eqN1AJtmsUf+h9hleSsZXX+5nhUFEQt9x2FqE9Nk=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:2ef0:b8de:b9c8:da45])
 (user=ndesaulniers job=sendgmr) by 2002:a0d:f007:0:b0:2f4:ce96:514b with SMTP
 id z7-20020a0df007000000b002f4ce96514bmr22919879ywe.148.1652735407736; Mon,
 16 May 2022 14:10:07 -0700 (PDT)
Date:   Mon, 16 May 2022 14:09:52 -0700
In-Reply-To: <20220516210954.1660716-1-ndesaulniers@google.com>
Message-Id: <20220516210954.1660716-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220516210954.1660716-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1652735394; l=21462;
 s=20211004; h=from:subject; bh=lWL9CI3d/2sCju02NOTSxZQK2cjA6Q8x5ATsTbJtBVs=;
 b=WQ9ecbMOrJfVUGeJAcE5xMH13aM8Mr6YhRDw7W69/GNLoL9s45Qe5Vad9X6R3kkSPLmMjLezI+32
 fvy3OV8uBGI9z5Z0LVmmFIXFOmgUtYvw8OhFl+UXXWiA8gxCd5Q/
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 2/4] ARM: use .arch directives instead of assembler command
 line flags
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Arnd Bergmann <arnd@arndb.de>, Ard@google.com,
        Biesheuvel@google.com
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit a6c30873ee4a ("ARM: 8989/1: use .fpu assembler
directives instead of assembler arguments").

GCC and GNU binutils support setting the "sub arch" via -march=,
-Wa,-march, target function attribute, and .arch assembler directive.

Clang was missing support for -Wa,-march=, but this was implemented in
clang-13.

The behavior of both GCC and Clang is to
prefer -Wa,-march= over -march= for assembler and assembler-with-cpp
sources, but Clang will warn about the -march= being unused.

clang: warning: argument unused during compilation: '-march=armv6k'
[-Wunused-command-line-argument]

Since most assembler is non-conditionally assembled with one sub arch
(modulo arch/arm/delay-loop.S which conditionally is assembled as armv4
based on CONFIG_ARCH_RPC, and arch/arm/mach-at91/pm-suspend.S which is
conditionally assembled as armv7-a based on CONFIG_CPU_V7), prefer the
.arch assembler directive.

Link: https://github.com/llvm/llvm-project/commit/1d51c699b9e2ebc5bcfdbe85c74cc871426333d4
Link: https://bugs.llvm.org/show_bug.cgi?id=48894
Link: https://github.com/ClangBuiltLinux/linux/issues/1195
Link: https://github.com/ClangBuiltLinux/linux/issues/1315
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
[arnd] add a few more instances found in compile testing
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/compressed/Makefile   |  1 -
 arch/arm/common/Makefile            |  2 --
 arch/arm/common/mcpm_head.S         |  2 ++
 arch/arm/common/vlock.S             |  2 ++
 arch/arm/kernel/Makefile            |  2 --
 arch/arm/kernel/hyp-stub.S          |  2 ++
 arch/arm/kernel/swp_emulate.c       |  1 +
 arch/arm/lib/Makefile               |  4 ----
 arch/arm/lib/delay-loop.S           |  4 ++++
 arch/arm/mach-at91/Makefile         |  3 ---
 arch/arm/mach-at91/pm_suspend.S     |  4 ++++
 arch/arm/mach-imx/Makefile          |  3 ---
 arch/arm/mach-imx/headsmp.S         |  2 ++
 arch/arm/mach-imx/resume-imx6.S     |  2 ++
 arch/arm/mach-imx/suspend-imx6.S    |  2 ++
 arch/arm/mach-mvebu/Makefile        |  3 ---
 arch/arm/mach-mvebu/coherency_ll.S  |  1 +
 arch/arm/mach-mvebu/pmsu.c          |  1 +
 arch/arm/mach-npcm/Makefile         |  2 --
 arch/arm/mach-npcm/headsmp.S        |  2 ++
 arch/arm/mach-tegra/Makefile        |  2 --
 arch/arm/mach-tegra/reset-handler.S |  2 ++
 arch/arm/mach-tegra/sleep-tegra20.S |  2 ++
 arch/arm/mach-tegra/sleep-tegra30.S |  2 ++
 arch/arm/mm/Makefile                | 15 ---------------
 arch/arm/mm/abort-ev6.S             |  1 +
 arch/arm/mm/abort-ev7.S             |  1 +
 arch/arm/mm/cache-v6.S              |  2 ++
 arch/arm/mm/cache-v7.S              |  2 ++
 arch/arm/mm/cache-v7m.S             |  2 ++
 arch/arm/mm/copypage-feroceon.c     |  1 +
 arch/arm/mm/proc-v6.S               |  2 ++
 arch/arm/mm/proc-v7-2level.S        |  2 ++
 arch/arm/mm/proc-v7.S               |  2 ++
 arch/arm/mm/tlb-v6.S                |  2 ++
 arch/arm/mm/tlb-v7.S                |  2 ++
 drivers/memory/Makefile             |  2 --
 drivers/memory/ti-emif-sram-pm.S    |  1 +
 drivers/soc/bcm/brcmstb/pm/Makefile |  1 -
 drivers/soc/bcm/brcmstb/pm/s2-arm.S |  1 +
 40 files changed, 52 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 41bcbb460fac..e5c80ff42a4f 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -163,4 +163,3 @@ $(obj)/piggy_data: $(obj)/../Image FORCE
 $(obj)/piggy.o: $(obj)/piggy_data
 
 CFLAGS_font.o := -Dstatic=
-AFLAGS_hyp-stub.o := -Wa,-march=armv7-a
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 8cd574be94cf..6a42600fa4c5 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -14,7 +14,5 @@ obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_CPU_V7)		+= secure_cntvoff.o
 obj-$(CONFIG_MCPM)		+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
 CFLAGS_REMOVE_mcpm_entry.o	= -pg
-AFLAGS_mcpm_head.o		:= -march=armv7-a
-AFLAGS_vlock.o			:= -march=armv7-a
 obj-$(CONFIG_BL_SWITCHER)	+= bL_switcher.o
 obj-$(CONFIG_BL_SWITCHER_DUMMY_IF) += bL_switcher_dummy_if.o
diff --git a/arch/arm/common/mcpm_head.S b/arch/arm/common/mcpm_head.S
index 291d969bc719..299495c43dfd 100644
--- a/arch/arm/common/mcpm_head.S
+++ b/arch/arm/common/mcpm_head.S
@@ -15,6 +15,8 @@
 
 #include "vlock.h"
 
+.arch armv7-a
+
 .if MCPM_SYNC_CLUSTER_CPUS
 .error "cpus must be the first member of struct mcpm_sync_struct"
 .endif
diff --git a/arch/arm/common/vlock.S b/arch/arm/common/vlock.S
index f1c7fd44f1b1..1fa09c4697ed 100644
--- a/arch/arm/common/vlock.S
+++ b/arch/arm/common/vlock.S
@@ -12,6 +12,8 @@
 #include <linux/linkage.h>
 #include "vlock.h"
 
+.arch armv7-a
+
 /* Select different code if voting flags  can fit in a single word. */
 #if VLOCK_VOTING_SIZE > 4
 #define FEW(x...)
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 553866751e1a..e64ed3a82f70 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_HAVE_TCM)		+= tcm.o
 obj-$(CONFIG_OF)		+= devtree.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_SWP_EMULATE)	+= swp_emulate.o
-CFLAGS_swp_emulate.o		:= -Wa,-march=armv7-a
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 
 obj-$(CONFIG_CPU_XSCALE)	+= xscale-cp0.o
@@ -100,7 +99,6 @@ CFLAGS_head-inflate-data.o := $(call cc-option,-Wframe-larger-than=10240)
 obj-$(CONFIG_XIP_DEFLATED_DATA) += head-inflate-data.o
 
 obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
-AFLAGS_hyp-stub.o		:=-Wa,-march=armv7-a
 ifeq ($(CONFIG_ARM_PSCI),y)
 obj-$(CONFIG_SMP)		+= psci_smp.o
 endif
diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index b699b22a4db1..3a506b9095a5 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -9,6 +9,8 @@
 #include <asm/assembler.h>
 #include <asm/virt.h>
 
+.arch armv7-a
+
 #ifndef ZIMAGE
 /*
  * For the kernel proper, we need to find out the CPU boot mode long after
diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
index b74bfcf94fb1..fdce83c95acb 100644
--- a/arch/arm/kernel/swp_emulate.c
+++ b/arch/arm/kernel/swp_emulate.c
@@ -34,6 +34,7 @@
  */
 #define __user_swpX_asm(data, addr, res, temp, B)		\
 	__asm__ __volatile__(					\
+	".arch armv7-a\n"					\
 	"0:	ldrex"B"	%2, [%3]\n"			\
 	"1:	strex"B"	%0, %1, [%3]\n"			\
 	"	cmp		%0, #0\n"			\
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 6d2ba454f25b..42fb75c06647 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -36,10 +36,6 @@ else
   lib-y	+= io-readsw-armv4.o io-writesw-armv4.o
 endif
 
-ifeq ($(CONFIG_ARCH_RPC),y)
-  AFLAGS_delay-loop.o		+= -march=armv4
-endif
-
 $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
diff --git a/arch/arm/lib/delay-loop.S b/arch/arm/lib/delay-loop.S
index 3ccade0f8130..3ac05177d097 100644
--- a/arch/arm/lib/delay-loop.S
+++ b/arch/arm/lib/delay-loop.S
@@ -8,6 +8,10 @@
 #include <asm/assembler.h>
 #include <asm/delay.h>
 
+#ifdef CONFIG_ARCH_RPC
+		.arch	armv4
+#endif
+
 		.text
 
 .LC0:		.word	loops_per_jiffy
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 522b680b6446..e7a47fa03626 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -14,9 +14,6 @@ obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
 # Power Management
 obj-$(CONFIG_ATMEL_PM)		+= pm.o pm_suspend.o
 
-ifeq ($(CONFIG_CPU_V7),y)
-AFLAGS_pm_suspend.o := -march=armv7-a
-endif
 ifeq ($(CONFIG_PM_DEBUG),y)
 CFLAGS_pm.o += -DDEBUG
 endif
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index abe4ced33eda..f0aa220d668d 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -12,6 +12,10 @@
 #include "pm.h"
 #include "pm_data-offsets.h"
 
+#ifdef CONFIG_CPU_V7
+.arch armv7-a
+#endif
+
 #define	SRAMC_SELF_FRESH_ACTIVE		0x01
 #define	SRAMC_SELF_FRESH_EXIT		0x00
 
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 6fb3965b9ae6..5c650bf40e02 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -34,7 +34,6 @@ obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
 obj-$(CONFIG_HAVE_IMX_SRC) += src.o
 ifneq ($(CONFIG_SOC_IMX6)$(CONFIG_SOC_IMX7D_CA7)$(CONFIG_SOC_LS1021A),)
-AFLAGS_headsmp.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SMP) += headsmp.o platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 endif
@@ -48,12 +47,10 @@ obj-$(CONFIG_SOC_IMX7D_CM4) += mach-imx7d-cm4.o
 obj-$(CONFIG_SOC_IMX7ULP) += mach-imx7ulp.o pm-imx7ulp.o
 
 ifeq ($(CONFIG_SUSPEND),y)
-AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
 obj-$(CONFIG_SOC_IMX53) += suspend-imx53.o
 endif
 ifeq ($(CONFIG_ARM_CPU_SUSPEND),y)
-AFLAGS_resume-imx6.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SOC_IMX6) += resume-imx6.o
 endif
 obj-$(CONFIG_SOC_IMX6) += pm-imx6.o
diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
index fcba58be8e79..5f9c7b48ae80 100644
--- a/arch/arm/mach-imx/headsmp.S
+++ b/arch/arm/mach-imx/headsmp.S
@@ -8,6 +8,8 @@
 #include <linux/init.h>
 #include <asm/assembler.h>
 
+.arch armv7-a
+
 diag_reg_offset:
 	.word	g_diag_reg - .
 
diff --git a/arch/arm/mach-imx/resume-imx6.S b/arch/arm/mach-imx/resume-imx6.S
index 5bd1ba7ef15b..2c0c5c771251 100644
--- a/arch/arm/mach-imx/resume-imx6.S
+++ b/arch/arm/mach-imx/resume-imx6.S
@@ -9,6 +9,8 @@
 #include <asm/hardware/cache-l2x0.h>
 #include "hardware.h"
 
+.arch armv7-a
+
 /*
  * The following code must assume it is running from physical address
  * where absolute virtual addresses to the data section have to be
diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index e06f946b75b9..63ccc2d0e920 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -9,6 +9,8 @@
 #include <asm/hardware/cache-l2x0.h>
 #include "hardware.h"
 
+.arch armv7-a
+
 /*
  * ==================== low level suspend ====================
  *
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index cb106899dd7c..9b9fddb69958 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -1,9 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-orion/include
 
-AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
-CFLAGS_pmsu.o			:= -march=armv7-a
-
 obj-$(CONFIG_MACH_MVEBU_ANY)	 += system-controller.o mvebu-soc-id.o
 
 ifeq ($(CONFIG_MACH_MVEBU_V7),y)
diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index a3a64bf97250..25197290632d 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -23,6 +23,7 @@
 #include <asm/assembler.h>
 #include <asm/cp15.h>
 
+	.arch armv7-a
 	.text
 /*
  * Returns the coherency base address in r1 (r0 is untouched), or 0 if
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 73d5d72dfc3e..9a77cc3a10bd 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -294,6 +294,7 @@ int armada_370_xp_pmsu_idle_enter(unsigned long deepidle)
 
 	/* Test the CR_C bit and set it if it was cleared */
 	asm volatile(
+	".arch	armv7-a\n\t"
 	"mrc	p15, 0, r0, c1, c0, 0 \n\t"
 	"tst	r0, %0 \n\t"
 	"orreq	r0, r0, #(1 << 2) \n\t"
diff --git a/arch/arm/mach-npcm/Makefile b/arch/arm/mach-npcm/Makefile
index 8d61fcd42fb1..ac83e1caf2ee 100644
--- a/arch/arm/mach-npcm/Makefile
+++ b/arch/arm/mach-npcm/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-AFLAGS_headsmp.o		+= -march=armv7-a
-
 obj-$(CONFIG_ARCH_WPCM450)	+= wpcm450.o
 obj-$(CONFIG_ARCH_NPCM7XX)	+= npcm7xx.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
diff --git a/arch/arm/mach-npcm/headsmp.S b/arch/arm/mach-npcm/headsmp.S
index c083fe09a07b..84d2b6daaf0b 100644
--- a/arch/arm/mach-npcm/headsmp.S
+++ b/arch/arm/mach-npcm/headsmp.S
@@ -6,6 +6,8 @@
 #include <linux/init.h>
 #include <asm/assembler.h>
 
+.arch armv7-a
+
 /*
  * The boot ROM does not start secondary CPUs in SVC mode, so we need to do that
  * here.
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 07572b5373b8..a2bb55bc0081 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-asflags-y				+= -march=armv7-a
-
 obj-y                                   += io.o
 obj-y                                   += irq.o
 obj-y					+= pm.o
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 06ca44b09381..0ea456264f3e 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -19,6 +19,8 @@
 
 #define PMC_SCRATCH41	0x140
 
+.arch armv7-a
+
 #ifdef CONFIG_PM_SLEEP
 /*
  *	tegra_resume
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index a5a36cce142a..d8cd487a8f63 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -47,6 +47,8 @@
 #define PLLM_STORE_MASK			(1 << 1)
 #define PLLP_STORE_MASK			(1 << 2)
 
+.arch armv7-a
+
 .macro test_pll_state, rd, test_mask
 	ldr	\rd, tegra_pll_state
 	tst	\rd, #\test_mask
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 0cc40b6b2ba3..134ea5fe49b2 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -78,6 +78,8 @@
 #define PLLX_STORE_MASK			(1 << 4)
 #define PLLM_PMC_STORE_MASK		(1 << 5)
 
+.arch armv7-a
+
 .macro emc_device_mask, rd, base
 	ldr	\rd, [\base, #EMC_ADR_CFG]
 	tst	\rd, #0x1
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 3510503bc5e6..71b858c9b10c 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -33,9 +33,6 @@ obj-$(CONFIG_CPU_ABRT_EV5TJ)	+= abort-ev5tj.o
 obj-$(CONFIG_CPU_ABRT_EV6)	+= abort-ev6.o
 obj-$(CONFIG_CPU_ABRT_EV7)	+= abort-ev7.o
 
-AFLAGS_abort-ev6.o	:=-Wa,-march=armv6k
-AFLAGS_abort-ev7.o	:=-Wa,-march=armv7-a
-
 obj-$(CONFIG_CPU_PABRT_LEGACY)	+= pabort-legacy.o
 obj-$(CONFIG_CPU_PABRT_V6)	+= pabort-v6.o
 obj-$(CONFIG_CPU_PABRT_V7)	+= pabort-v7.o
@@ -49,10 +46,6 @@ obj-$(CONFIG_CPU_CACHE_FA)	+= cache-fa.o
 obj-$(CONFIG_CPU_CACHE_NOP)	+= cache-nop.o
 obj-$(CONFIG_CPU_CACHE_V7M)	+= cache-v7m.o
 
-AFLAGS_cache-v6.o	:=-Wa,-march=armv6
-AFLAGS_cache-v7.o	:=-Wa,-march=armv7-a
-AFLAGS_cache-v7m.o	:=-Wa,-march=armv7-m
-
 obj-$(CONFIG_CPU_COPY_V4WT)	+= copypage-v4wt.o
 obj-$(CONFIG_CPU_COPY_V4WB)	+= copypage-v4wb.o
 obj-$(CONFIG_CPU_COPY_FEROCEON)	+= copypage-feroceon.o
@@ -62,8 +55,6 @@ obj-$(CONFIG_CPU_XSCALE)	+= copypage-xscale.o
 obj-$(CONFIG_CPU_XSC3)		+= copypage-xsc3.o
 obj-$(CONFIG_CPU_COPY_FA)	+= copypage-fa.o
 
-CFLAGS_copypage-feroceon.o := -march=armv5te
-
 obj-$(CONFIG_CPU_TLB_V4WT)	+= tlb-v4.o
 obj-$(CONFIG_CPU_TLB_V4WB)	+= tlb-v4wb.o
 obj-$(CONFIG_CPU_TLB_V4WBI)	+= tlb-v4wbi.o
@@ -72,9 +63,6 @@ obj-$(CONFIG_CPU_TLB_V6)	+= tlb-v6.o
 obj-$(CONFIG_CPU_TLB_V7)	+= tlb-v7.o
 obj-$(CONFIG_CPU_TLB_FA)	+= tlb-fa.o
 
-AFLAGS_tlb-v6.o		:=-Wa,-march=armv6
-AFLAGS_tlb-v7.o		:=-Wa,-march=armv7-a
-
 obj-$(CONFIG_CPU_ARM7TDMI)	+= proc-arm7tdmi.o
 obj-$(CONFIG_CPU_ARM720T)	+= proc-arm720.o
 obj-$(CONFIG_CPU_ARM740T)	+= proc-arm740.o
@@ -101,9 +89,6 @@ obj-$(CONFIG_CPU_V6K)		+= proc-v6.o
 obj-$(CONFIG_CPU_V7)		+= proc-v7.o proc-v7-bugs.o
 obj-$(CONFIG_CPU_V7M)		+= proc-v7m.o
 
-AFLAGS_proc-v6.o	:=-Wa,-march=armv6
-AFLAGS_proc-v7.o	:=-Wa,-march=armv7-a
-
 obj-$(CONFIG_OUTER_CACHE)	+= l2c-common.o
 obj-$(CONFIG_CACHE_B15_RAC)	+= cache-b15-rac.o
 obj-$(CONFIG_CACHE_FEROCEON_L2)	+= cache-feroceon-l2.o
diff --git a/arch/arm/mm/abort-ev6.S b/arch/arm/mm/abort-ev6.S
index c58bf8b43fea..836dc1299243 100644
--- a/arch/arm/mm/abort-ev6.S
+++ b/arch/arm/mm/abort-ev6.S
@@ -16,6 +16,7 @@
  * abort here if the I-TLB and D-TLB aren't seeing the same
  * picture.  Unfortunately, this does happen.  We live with it.
  */
+	.arch	armv6k
 	.align	5
 ENTRY(v6_early_abort)
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
diff --git a/arch/arm/mm/abort-ev7.S b/arch/arm/mm/abort-ev7.S
index f81bceacc660..53fb41c24774 100644
--- a/arch/arm/mm/abort-ev7.S
+++ b/arch/arm/mm/abort-ev7.S
@@ -12,6 +12,7 @@
  *
  * Purpose : obtain information about current aborted instruction.
  */
+	.arch	armv7-a
 	.align	5
 ENTRY(v7_early_abort)
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index f0f65eb073e4..250c83bf7158 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -19,6 +19,8 @@
 #define D_CACHE_LINE_SIZE	32
 #define BTB_FLUSH_SIZE		8
 
+.arch armv6
+
 /*
  *	v6_flush_icache_all()
  *
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 7c9499b728c4..127afe2096ba 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -16,6 +16,8 @@
 
 #include "proc-macros.S"
 
+.arch armv7-a
+
 #ifdef CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND
 .globl icache_size
 	.data
diff --git a/arch/arm/mm/cache-v7m.S b/arch/arm/mm/cache-v7m.S
index 1bc3a0a50753..eb60b5e5e2ad 100644
--- a/arch/arm/mm/cache-v7m.S
+++ b/arch/arm/mm/cache-v7m.S
@@ -18,6 +18,8 @@
 
 #include "proc-macros.S"
 
+.arch armv7-m
+
 /* Generic V7M read/write macros for memory mapped cache operations */
 .macro v7m_cache_read, rt, reg
 	movw	\rt, #:lower16:BASEADDR_V7M_SCB + \reg
diff --git a/arch/arm/mm/copypage-feroceon.c b/arch/arm/mm/copypage-feroceon.c
index 064b19e63571..5fc8ef1e665f 100644
--- a/arch/arm/mm/copypage-feroceon.c
+++ b/arch/arm/mm/copypage-feroceon.c
@@ -15,6 +15,7 @@ static void feroceon_copy_user_page(void *kto, const void *kfrom)
 	int tmp;
 
 	asm volatile ("\
+.arch	armv5te					\n\
 1:	ldmia	%1!, {r2 - r7, ip, lr}		\n\
 	pld	[%1, #0]			\n\
 	pld	[%1, #32]			\n\
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index a0618f3e6836..203dff89ab1a 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -32,6 +32,8 @@
 #define TTB_FLAGS_SMP	TTB_RGN_WBWA|TTB_S
 #define PMD_FLAGS_SMP	PMD_SECT_WBWA|PMD_SECT_S
 
+.arch armv6
+
 ENTRY(cpu_v6_proc_init)
 	ret	lr
 
diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index 5db029c8f987..0a3083ad19c2 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -24,6 +24,8 @@
 #define TTB_FLAGS_SMP	TTB_IRGN_WBWA|TTB_S|TTB_NOS|TTB_RGN_OC_WBWA
 #define PMD_FLAGS_SMP	PMD_SECT_WBWA|PMD_SECT_S
 
+.arch armv7-a
+
 /*
  *	cpu_v7_switch_mm(pgd_phys, tsk)
  *
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 26d726a08a34..6b4ef9539b68 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -24,6 +24,8 @@
 #include "proc-v7-2level.S"
 #endif
 
+.arch armv7-a
+
 ENTRY(cpu_v7_proc_init)
 	ret	lr
 ENDPROC(cpu_v7_proc_init)
diff --git a/arch/arm/mm/tlb-v6.S b/arch/arm/mm/tlb-v6.S
index 74f4b383afe3..1d91e49b2c2d 100644
--- a/arch/arm/mm/tlb-v6.S
+++ b/arch/arm/mm/tlb-v6.S
@@ -17,6 +17,8 @@
 
 #define HARVARD_TLB
 
+.arch armv6
+
 /*
  *	v6wbi_flush_user_tlb_range(start, end, vma)
  *
diff --git a/arch/arm/mm/tlb-v7.S b/arch/arm/mm/tlb-v7.S
index 87bf4ab17721..35fd6d4f0d03 100644
--- a/arch/arm/mm/tlb-v7.S
+++ b/arch/arm/mm/tlb-v7.S
@@ -16,6 +16,8 @@
 #include <asm/tlbflush.h>
 #include "proc-macros.S"
 
+.arch armv7-a
+
 /*
  *	v7wbi_flush_user_tlb_range(start, end, vma)
  *
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index bc7663ed1c25..d1388a748872 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -32,8 +32,6 @@ obj-$(CONFIG_FPGA_DFL_EMIF)	+= dfl-emif.o
 
 ti-emif-sram-objs		:= ti-emif-pm.o ti-emif-sram-pm.o
 
-AFLAGS_ti-emif-sram-pm.o	:=-Wa,-march=armv7-a
-
 $(obj)/ti-emif-sram-pm.o: $(obj)/ti-emif-asm-offsets.h
 
 $(obj)/ti-emif-asm-offsets.h: $(obj)/emif-asm-offsets.s FORCE
diff --git a/drivers/memory/ti-emif-sram-pm.S b/drivers/memory/ti-emif-sram-pm.S
index d1c83bd5b98e..af2feb251303 100644
--- a/drivers/memory/ti-emif-sram-pm.S
+++ b/drivers/memory/ti-emif-sram-pm.S
@@ -36,6 +36,7 @@
 
 	.arm
 	.align 3
+	.arch armv7-a
 
 ENTRY(ti_emif_sram)
 
diff --git a/drivers/soc/bcm/brcmstb/pm/Makefile b/drivers/soc/bcm/brcmstb/pm/Makefile
index 8e10abb14f8b..f849cfa69446 100644
--- a/drivers/soc/bcm/brcmstb/pm/Makefile
+++ b/drivers/soc/bcm/brcmstb/pm/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_ARM)		+= s2-arm.o pm-arm.o
-AFLAGS_s2-arm.o			:= -march=armv7-a
 obj-$(CONFIG_BMIPS_GENERIC)	+= s2-mips.o s3-mips.o pm-mips.o
diff --git a/drivers/soc/bcm/brcmstb/pm/s2-arm.S b/drivers/soc/bcm/brcmstb/pm/s2-arm.S
index 5f0c4a8ae9df..0d693795de27 100644
--- a/drivers/soc/bcm/brcmstb/pm/s2-arm.S
+++ b/drivers/soc/bcm/brcmstb/pm/s2-arm.S
@@ -8,6 +8,7 @@
 
 #include "pm.h"
 
+	.arch armv7-a
 	.text
 	.align	3
 
-- 
2.36.0.550.gb090851708-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2496E4AF1F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiBIMjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiBIMi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:38:28 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB65C05CBBB;
        Wed,  9 Feb 2022 04:38:29 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nHmEk-0001Mv-Aa; Wed, 09 Feb 2022 13:38:18 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, huffman@cadence.com,
        mick@ics.forth.gr, allen.baum@esperantotech.com,
        jscheid@ventanamicro.com, rtrauben@gmail.com, samuel@sholland.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v6 02/14] riscv: integrate alternatives better into the main architecture
Date:   Wed,  9 Feb 2022 13:37:48 +0100
Message-Id: <20220209123800.269774-3-heiko@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209123800.269774-1-heiko@sntech.de>
References: <20220209123800.269774-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the alternatives need to be explicitly enabled and
erratas are limited to SiFive ones.

Over time with more SoCs and additional RiscV extensions, many more
erratas or other patch-worthy features will emerge, so it doesn't
really make sense to have the core alternatives able to get
deactivated.

So make it part of the core RiscV kernel and drop the main
RISCV_ERRATA_ALTERNATIVES config symbol.

This mimics how i.e. arm64 handles its alternatives implementation.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/Kconfig.erratas                  | 10 ----------
 arch/riscv/Kconfig.socs                     |  1 -
 arch/riscv/Makefile                         |  2 +-
 arch/riscv/errata/Makefile                  |  1 -
 arch/riscv/include/asm/alternative-macros.h | 22 ---------------------
 arch/riscv/kernel/Makefile                  |  1 +
 arch/riscv/{errata => kernel}/alternative.c |  0
 arch/riscv/kernel/smpboot.c                 |  2 --
 arch/riscv/kernel/traps.c                   |  2 +-
 9 files changed, 3 insertions(+), 38 deletions(-)
 rename arch/riscv/{errata => kernel}/alternative.c (100%)

diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
index b44d6ecdb46e..d18be8ff0245 100644
--- a/arch/riscv/Kconfig.erratas
+++ b/arch/riscv/Kconfig.erratas
@@ -1,17 +1,7 @@
 menu "CPU errata selection"
 
-config RISCV_ERRATA_ALTERNATIVE
-	bool "RISC-V alternative scheme"
-	default y
-	help
-	  This Kconfig allows the kernel to automatically patch the
-	  errata required by the execution platform at run time. The
-	  code patching is performed once in the boot stages. It means
-	  that the overhead from this mechanism is just taken once.
-
 config ERRATA_SIFIVE
 	bool "SiFive errata"
-	depends on RISCV_ERRATA_ALTERNATIVE
 	help
 	  All SiFive errata Kconfig depend on this Kconfig. Disabling
 	  this Kconfig will disable all SiFive errata. Please say "Y"
diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 6ec44a22278a..3df7f7ed0d81 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -14,7 +14,6 @@ config SOC_SIFIVE
 	select CLK_SIFIVE
 	select CLK_SIFIVE_PRCI
 	select SIFIVE_PLIC
-	select RISCV_ERRATA_ALTERNATIVE
 	select ERRATA_SIFIVE
 	help
 	  This enables support for SiFive SoC platform hardware.
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 8a107ed18b0d..194220889969 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -97,7 +97,7 @@ endif
 
 head-y := arch/riscv/kernel/head.o
 
-core-$(CONFIG_RISCV_ERRATA_ALTERNATIVE) += arch/riscv/errata/
+core-y += arch/riscv/errata/
 core-$(CONFIG_KVM) += arch/riscv/kvm/
 
 libs-y += arch/riscv/lib/
diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
index b8f8740a3e44..0ca1c5281a2d 100644
--- a/arch/riscv/errata/Makefile
+++ b/arch/riscv/errata/Makefile
@@ -1,2 +1 @@
-obj-y	+= alternative.o
 obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
index 67406c376389..92da6b3920a3 100644
--- a/arch/riscv/include/asm/alternative-macros.h
+++ b/arch/riscv/include/asm/alternative-macros.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_ALTERNATIVE_MACROS_H
 #define __ASM_ALTERNATIVE_MACROS_H
 
-#ifdef CONFIG_RISCV_ERRATA_ALTERNATIVE
-
 #ifdef __ASSEMBLY__
 
 .macro ALT_ENTRY oldptr newptr vendor_id errata_id new_len
@@ -76,26 +74,6 @@
 
 #endif /* __ASSEMBLY__ */
 
-#else /* !CONFIG_RISCV_ERRATA_ALTERNATIVE*/
-#ifdef __ASSEMBLY__
-
-.macro __ALTERNATIVE_CFG old_c
-	\old_c
-.endm
-
-#define _ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, CONFIG_k) \
-	__ALTERNATIVE_CFG old_c
-
-#else /* !__ASSEMBLY__ */
-
-#define __ALTERNATIVE_CFG(old_c)  \
-	old_c "\n"
-
-#define _ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, CONFIG_k) \
-	__ALTERNATIVE_CFG(old_c)
-
-#endif /* __ASSEMBLY__ */
-#endif /* CONFIG_RISCV_ERRATA_ALTERNATIVE */
 /*
  * Usage:
  *   ALTERNATIVE(old_content, new_content, vendor_id, errata_id, CONFIG_k)
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 612556faa527..3ea2d133887d 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -18,6 +18,7 @@ extra-y += head.o
 extra-y += vmlinux.lds
 
 obj-y	+= soc.o
+obj-y	+= alternative.o
 obj-y	+= cpu.o
 obj-y	+= cpufeature.o
 obj-y	+= entry.o
diff --git a/arch/riscv/errata/alternative.c b/arch/riscv/kernel/alternative.c
similarity index 100%
rename from arch/riscv/errata/alternative.c
rename to arch/riscv/kernel/alternative.c
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 622f226454d5..a6d13dca1403 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -41,9 +41,7 @@ static DECLARE_COMPLETION(cpu_running);
 void __init smp_prepare_boot_cpu(void)
 {
 	init_cpu_topology();
-#ifdef CONFIG_RISCV_ERRATA_ALTERNATIVE
 	apply_boot_alternatives();
-#endif
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index fe92e119e6a3..9984c8622c3b 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -86,7 +86,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 	}
 }
 
-#if defined (CONFIG_XIP_KERNEL) && defined (CONFIG_RISCV_ERRATA_ALTERNATIVE)
+#if defined (CONFIG_XIP_KERNEL)
 #define __trap_section		__section(".xip.traps")
 #else
 #define __trap_section
-- 
2.30.2


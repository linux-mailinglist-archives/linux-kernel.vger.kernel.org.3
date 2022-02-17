Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053154BA1DA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241432AbiBQNrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:47:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbiBQNq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:46:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48999260A;
        Thu, 17 Feb 2022 05:46:41 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A0BAF1F37D;
        Thu, 17 Feb 2022 13:46:40 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 8D667A3B85;
        Thu, 17 Feb 2022 13:46:40 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: remove asm/war.h
Date:   Thu, 17 Feb 2022 14:46:28 +0100
Message-Id: <20220217134630.42203-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The major part for workaround handling has already moved to config
options. This change replaces the remaining defines by already
available config options and gets rid of war.h

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/Kconfig                  | 38 ++++++++++++++++
 arch/mips/include/asm/futex.h      |  1 -
 arch/mips/include/asm/mipsmtregs.h |  1 -
 arch/mips/include/asm/mipsregs.h   |  1 -
 arch/mips/include/asm/war.h        | 73 ------------------------------
 arch/mips/kernel/entry.S           |  1 -
 arch/mips/kernel/genex.S           |  1 -
 arch/mips/kernel/r4k-bugs64.c      |  9 ++--
 arch/mips/kernel/scall32-o32.S     |  1 -
 arch/mips/kernel/scall64-n64.S     |  1 -
 arch/mips/kernel/signal.c          |  1 -
 arch/mips/kernel/signal_n32.c      |  1 -
 arch/mips/lib/delay.c              |  1 -
 arch/mips/mm/c-octeon.c            |  1 -
 arch/mips/mm/c-r4k.c               |  1 -
 arch/mips/mm/page.c                |  5 +-
 arch/mips/mm/tlbex.c               |  1 -
 17 files changed, 47 insertions(+), 91 deletions(-)
 delete mode 100644 arch/mips/include/asm/war.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 058446f01487..03b1fd4ceb97 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2520,13 +2520,51 @@ config CPU_HAS_SYNC
 #
 # CPU non-features
 #
+
+# Work around the "daddi" and "daddiu" CPU errata:
+#
+# - The `daddi' instruction fails to trap on overflow.
+#   "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0",
+#   erratum #23
+#
+# - The `daddiu' instruction can produce an incorrect result.
+#   "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0",
+#   erratum #41
+#   "MIPS R4000MC Errata, Processor Revision 2.2 and 3.0", erratum
+#   #15
+#   "MIPS R4400PC/SC Errata, Processor Revision 1.0", erratum #7
+#   "MIPS R4400MC Errata, Processor Revision 1.0", erratum #5
 config CPU_DADDI_WORKAROUNDS
 	bool
 
+# Work around certain R4000 CPU errata (as implemented by GCC):
+#
+# - A double-word or a variable shift may give an incorrect result
+#   if executed immediately after starting an integer division:
+#   "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0",
+#   erratum #28
+#   "MIPS R4000MC Errata, Processor Revision 2.2 and 3.0", erratum
+#   #19
+#
+# - A double-word or a variable shift may give an incorrect result
+#   if executed while an integer multiplication is in progress:
+#   "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0",
+#   errata #16 & #28
+#
+# - An integer division may give an incorrect result if started in
+#   a delay slot of a taken branch or a jump:
+#   "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0",
+#   erratum #52
 config CPU_R4000_WORKAROUNDS
 	bool
 	select CPU_R4400_WORKAROUNDS
 
+# Work around certain R4400 CPU errata (as implemented by GCC):
+#
+# - A double-word or a variable shift may give an incorrect result
+#   if executed immediately after starting an integer division:
+#   "MIPS R4400MC Errata, Processor Revision 1.0", erratum #10
+#   "MIPS R4400MC Errata, Processor Revision 2.0 & 3.0", erratum #4
 config CPU_R4400_WORKAROUNDS
 	bool
 
diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index 8612a7e42d78..05832eb240fa 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -17,7 +17,6 @@
 #include <asm/compiler.h>
 #include <asm/errno.h>
 #include <asm/sync.h>
-#include <asm/war.h>
 
 #define arch_futex_atomic_op_inuser arch_futex_atomic_op_inuser
 #define futex_atomic_cmpxchg_inatomic futex_atomic_cmpxchg_inatomic
diff --git a/arch/mips/include/asm/mipsmtregs.h b/arch/mips/include/asm/mipsmtregs.h
index be4cf9d477be..a8d67c2f4f7b 100644
--- a/arch/mips/include/asm/mipsmtregs.h
+++ b/arch/mips/include/asm/mipsmtregs.h
@@ -9,7 +9,6 @@
 #define _ASM_MIPSMTREGS_H
 
 #include <asm/mipsregs.h>
-#include <asm/war.h>
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 2616353b940c..305651af15b3 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -17,7 +17,6 @@
 #include <linux/types.h>
 #include <asm/hazards.h>
 #include <asm/isa-rev.h>
-#include <asm/war.h>
 
 /*
  * The following macros are especially useful for __asm__
diff --git a/arch/mips/include/asm/war.h b/arch/mips/include/asm/war.h
deleted file mode 100644
index 21443f096238..000000000000
--- a/arch/mips/include/asm/war.h
+++ /dev/null
@@ -1,73 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle
- * Copyright (C) 2007  Maciej W. Rozycki
- */
-#ifndef _ASM_WAR_H
-#define _ASM_WAR_H
-
-/*
- * Work around certain R4000 CPU errata (as implemented by GCC):
- *
- * - A double-word or a variable shift may give an incorrect result
- *   if executed immediately after starting an integer division:
- *   "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0",
- *   erratum #28
- *   "MIPS R4000MC Errata, Processor Revision 2.2 and 3.0", erratum
- *   #19
- *
- * - A double-word or a variable shift may give an incorrect result
- *   if executed while an integer multiplication is in progress:
- *   "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0",
- *   errata #16 & #28
- *
- * - An integer division may give an incorrect result if started in
- *   a delay slot of a taken branch or a jump:
- *   "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0",
- *   erratum #52
- */
-#ifdef CONFIG_CPU_R4000_WORKAROUNDS
-#define R4000_WAR 1
-#else
-#define R4000_WAR 0
-#endif
-
-/*
- * Work around certain R4400 CPU errata (as implemented by GCC):
- *
- * - A double-word or a variable shift may give an incorrect result
- *   if executed immediately after starting an integer division:
- *   "MIPS R4400MC Errata, Processor Revision 1.0", erratum #10
- *   "MIPS R4400MC Errata, Processor Revision 2.0 & 3.0", erratum #4
- */
-#ifdef CONFIG_CPU_R4400_WORKAROUNDS
-#define R4400_WAR 1
-#else
-#define R4400_WAR 0
-#endif
-
-/*
- * Work around the "daddi" and "daddiu" CPU errata:
- *
- * - The `daddi' instruction fails to trap on overflow.
- *   "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0",
- *   erratum #23
- *
- * - The `daddiu' instruction can produce an incorrect result.
- *   "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0",
- *   erratum #41
- *   "MIPS R4000MC Errata, Processor Revision 2.2 and 3.0", erratum
- *   #15
- *   "MIPS R4400PC/SC Errata, Processor Revision 1.0", erratum #7
- *   "MIPS R4400MC Errata, Processor Revision 1.0", erratum #5
- */
-#ifdef CONFIG_CPU_DADDI_WORKAROUNDS
-#define DADDI_WAR 1
-#else
-#define DADDI_WAR 0
-#endif
-
-#endif /* _ASM_WAR_H */
diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index 4b896f5023ff..d8ca173680f9 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -17,7 +17,6 @@
 #include <asm/stackframe.h>
 #include <asm/isadep.h>
 #include <asm/thread_info.h>
-#include <asm/war.h>
 
 #ifndef CONFIG_PREEMPTION
 #define resume_kernel	restore_all
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 743d75927b71..fc53ea2cf850 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -19,7 +19,6 @@
 #include <asm/mipsregs.h>
 #include <asm/stackframe.h>
 #include <asm/sync.h>
-#include <asm/war.h>
 #include <asm/thread_info.h>
 
 	__INIT
diff --git a/arch/mips/kernel/r4k-bugs64.c b/arch/mips/kernel/r4k-bugs64.c
index 35729c9e6cfa..11392e40d034 100644
--- a/arch/mips/kernel/r4k-bugs64.c
+++ b/arch/mips/kernel/r4k-bugs64.c
@@ -163,7 +163,8 @@ static __always_inline __init void check_mult_sh(void)
 	}
 
 	pr_cont("no.\n");
-	panic(bug64hit, !R4000_WAR ? r4kwar : nowar);
+	panic(bug64hit, !IS_ENABLED(CONFIG_CPU_R4000_WORKAROUNDS) ? r4kwar :
+								    nowar);
 }
 
 static volatile int daddi_ov;
@@ -239,7 +240,8 @@ static __init void check_daddi(void)
 	}
 
 	pr_cont("no.\n");
-	panic(bug64hit, !DADDI_WAR ? daddiwar : nowar);
+	panic(bug64hit, !IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS) ? daddiwar :
+								    nowar);
 }
 
 int daddiu_bug	= -1;
@@ -307,7 +309,8 @@ static __init void check_daddiu(void)
 	}
 
 	pr_cont("no.\n");
-	panic(bug64hit, !DADDI_WAR ? daddiwar : nowar);
+	panic(bug64hit, !IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS) ? daddiwar :
+								    nowar);
 }
 
 void __init check_bugs64_early(void)
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 9bfce5f75f60..18dc9b345056 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -19,7 +19,6 @@
 #include <asm/sysmips.h>
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
-#include <asm/war.h>
 #include <asm/asm-offsets.h>
 
 	.align	5
diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
index 5f6ed4b4c399..e6264aa62e45 100644
--- a/arch/mips/kernel/scall64-n64.S
+++ b/arch/mips/kernel/scall64-n64.S
@@ -18,7 +18,6 @@
 #include <asm/sysmips.h>
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
-#include <asm/war.h>
 
 #ifndef CONFIG_MIPS32_COMPAT
 /* Neither O32 nor N32, so define handle_sys here */
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 5bce782e694c..71e309be86a2 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -35,7 +35,6 @@
 #include <asm/sim.h>
 #include <asm/ucontext.h>
 #include <asm/cpu-features.h>
-#include <asm/war.h>
 #include <asm/dsp.h>
 #include <asm/inst.h>
 #include <asm/msa.h>
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 7bd00fad61af..cfc77b69420a 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -24,7 +24,6 @@
 #include <asm/ucontext.h>
 #include <asm/fpu.h>
 #include <asm/cpu-features.h>
-#include <asm/war.h>
 
 #include "signal-common.h"
 
diff --git a/arch/mips/lib/delay.c b/arch/mips/lib/delay.c
index 2e8dfc1d59c8..ccdb1fc1e4bf 100644
--- a/arch/mips/lib/delay.c
+++ b/arch/mips/lib/delay.c
@@ -16,7 +16,6 @@
 
 #include <asm/asm.h>
 #include <asm/compiler.h>
-#include <asm/war.h>
 
 #ifndef CONFIG_CPU_DADDI_WORKAROUNDS
 #define GCC_DADDI_IMM_ASM() "I"
diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index 737870d8fd94..c7ed589de882 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -23,7 +23,6 @@
 #include <asm/r4kcache.h>
 #include <asm/traps.h>
 #include <asm/mmu_context.h>
-#include <asm/war.h>
 
 #include <asm/octeon/octeon.h>
 
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 50261fd8eb21..ccb9e47322b0 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -33,7 +33,6 @@
 #include <asm/r4kcache.h>
 #include <asm/sections.h>
 #include <asm/mmu_context.h>
-#include <asm/war.h>
 #include <asm/cacheflush.h> /* for run_uncached() */
 #include <asm/traps.h>
 #include <asm/mips-cps.h>
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index 504bc4047c4c..d3b4459d0fe8 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -25,7 +25,6 @@
 #include <asm/mipsregs.h>
 #include <asm/mmu_context.h>
 #include <asm/cpu.h>
-#include <asm/war.h>
 
 #ifdef CONFIG_SIBYTE_DMA_PAGEOPS
 #include <asm/sibyte/sb1250.h>
@@ -103,7 +102,9 @@ static int cache_line_size;
 static inline void
 pg_addiu(u32 **buf, unsigned int reg1, unsigned int reg2, unsigned int off)
 {
-	if (cpu_has_64bit_gp_regs && DADDI_WAR && r4k_daddiu_bug()) {
+	if (cpu_has_64bit_gp_regs &&
+	    IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS) &&
+	    r4k_daddiu_bug()) {
 		if (off > 0x7fff) {
 			uasm_i_lui(buf, T9, uasm_rel_hi(off));
 			uasm_i_addiu(buf, T9, T9, uasm_rel_lo(off));
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index b131e6a77383..d9df2c43b15c 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -33,7 +33,6 @@
 #include <asm/cacheflush.h>
 #include <asm/cpu-type.h>
 #include <asm/mmu_context.h>
-#include <asm/war.h>
 #include <asm/uasm.h>
 #include <asm/setup.h>
 #include <asm/tlbex.h>
-- 
2.29.2


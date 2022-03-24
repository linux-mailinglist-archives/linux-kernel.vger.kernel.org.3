Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1464E652E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351034AbiCXOcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350971AbiCXOci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:32:38 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75207AC060
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:31:05 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KPSM22h5Wz9sTf;
        Thu, 24 Mar 2022 15:30:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SsVy4jWI__nD; Thu, 24 Mar 2022 15:30:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KPSLy35sBz9sTh;
        Thu, 24 Mar 2022 15:30:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 55EA58B763;
        Thu, 24 Mar 2022 15:30:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id t6C-KzDmjo-b; Thu, 24 Mar 2022 15:30:50 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.77])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A01CB8B787;
        Thu, 24 Mar 2022 15:30:49 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22OEUg2G1811718
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 24 Mar 2022 15:30:42 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22OEUgp31811717;
        Thu, 24 Mar 2022 15:30:42 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 10/22] powerpc/ftrace: Use CONFIG_FUNCTION_TRACER instead of CONFIG_DYNAMIC_FTRACE
Date:   Thu, 24 Mar 2022 15:30:00 +0100
Message-Id: <72070995f96acaa9a387963e3848bd24a436a847.1648131740.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648131740.git.christophe.leroy@csgroup.eu>
References: <cover.1648131740.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648132151; l=6898; s=20211009; h=from:subject:message-id; bh=7a3n3vVzipjhc9wdEDaF2vM9nWN6CKOUlXyd7asESRc=; b=W6S2xOdjmipBzbwj+Eihns5K2pIYCoNq9sncWg6XBUYDzKZbcXHljQsI0m97EX1UGZgGsLDPiZZc P/iY5+38CBRJGAfG1L2bvdXiE4FpER9XuPzq8Ekuchs27Wtlv0co
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0c0c52306f47 ("powerpc: Only support DYNAMIC_FTRACE not
static"), CONFIG_DYNAMIC_FTRACE is always selected when
CONFIG_FUNCTION_TRACER is selected.

To avoid confusion and have the reader wonder what's happen when
CONFIG_FUNCTION_TRACER is selected and CONFIG_DYNAMIC_FTRACE is not,
use CONFIG_FUNCTION_TRACER in ifdefs instead of CONFIG_DYNAMIC_FTRACE.

As CONFIG_FUNCTION_GRAPH_TRACER depends on CONFIG_FUNCTION_TRACER,
ftrace.o doesn't need to appear for both symbols in Makefile.

Then as ftrace.o is built only when CONFIG_FUNCTION_TRACER is selected
ifdef CONFIG_FUNCTION_TRACER is not needed in ftrace.c

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h | 2 +-
 arch/powerpc/include/asm/module.h            | 4 ++--
 arch/powerpc/include/asm/nohash/pgtable.h    | 2 +-
 arch/powerpc/kernel/module_32.c              | 4 ++--
 arch/powerpc/kernel/module_64.c              | 6 +++---
 arch/powerpc/kernel/trace/Makefile           | 4 +---
 arch/powerpc/kernel/trace/ftrace.c           | 4 ----
 8 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 772e00dc4ef1..992aed626eb4 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -124,7 +124,7 @@ static inline bool pte_user(pte_t pte)
  * on platforms where such control is possible.
  */
 #if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
-	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
+	defined(CONFIG_KPROBES) || defined(CONFIG_FUNCTION_TRACER)
 #define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
 #else
 #define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 875730d5af40..cf01b609572f 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -169,7 +169,7 @@
  * on platforms where such control is possible.
  */
 #if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) || \
-	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
+	defined(CONFIG_KPROBES) || defined(CONFIG_FUNCTION_TRACER)
 #define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
 #else
 #define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index 857d9ff24295..e6f5963fd96e 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -39,7 +39,7 @@ struct mod_arch_specific {
 	unsigned int init_plt_section;
 #endif /* powerpc64 */
 
-#ifdef CONFIG_DYNAMIC_FTRACE
+#ifdef CONFIG_FUNCTION_TRACER
 	unsigned long tramp;
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 	unsigned long tramp_regs;
@@ -68,7 +68,7 @@ struct mod_arch_specific {
 #    endif	/* MODULE */
 #endif
 
-#ifdef CONFIG_DYNAMIC_FTRACE
+#ifdef CONFIG_FUNCTION_TRACER
 #    ifdef MODULE
 	asm(".section .ftrace.tramp,\"ax\",@nobits; .align 3; .previous");
 #    endif	/* MODULE */
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index ac75f4ab0dba..2e8cf217a191 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -23,7 +23,7 @@
  * on platforms where such control is possible.
  */
 #if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
-	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
+	defined(CONFIG_KPROBES) || defined(CONFIG_FUNCTION_TRACER)
 #define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
 #else
 #define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index a0432ef46967..2aa368ce21c9 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -39,7 +39,7 @@ static unsigned int count_relocs(const Elf32_Rela *rela, unsigned int num)
 			r_addend = rela[i].r_addend;
 		}
 
-#ifdef CONFIG_DYNAMIC_FTRACE
+#ifdef CONFIG_FUNCTION_TRACER
 	_count_relocs++;	/* add one for ftrace_caller */
 #endif
 	return _count_relocs;
@@ -288,7 +288,7 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 	return 0;
 }
 
-#ifdef CONFIG_DYNAMIC_FTRACE
+#ifdef CONFIG_FUNCTION_TRACER
 int module_trampoline_target(struct module *mod, unsigned long addr,
 			     unsigned long *target)
 {
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 794720530442..b13a72665eee 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -207,7 +207,7 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 		}
 	}
 
-#ifdef CONFIG_DYNAMIC_FTRACE
+#ifdef CONFIG_FUNCTION_TRACER
 	/* make the trampoline to the ftrace_caller */
 	relocs++;
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
@@ -372,7 +372,7 @@ static bool is_mprofile_ftrace_call(const char *name)
 {
 	if (!strcmp("_mcount", name))
 		return true;
-#ifdef CONFIG_DYNAMIC_FTRACE
+#ifdef CONFIG_FUNCTION_TRACER
 	if (!strcmp("ftrace_caller", name))
 		return true;
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
@@ -740,7 +740,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 	return 0;
 }
 
-#ifdef CONFIG_DYNAMIC_FTRACE
+#ifdef CONFIG_FUNCTION_TRACER
 int module_trampoline_target(struct module *mod, unsigned long addr,
 			     unsigned long *target)
 {
diff --git a/arch/powerpc/kernel/trace/Makefile b/arch/powerpc/kernel/trace/Makefile
index fc32ec30b297..af8527538fe4 100644
--- a/arch/powerpc/kernel/trace/Makefile
+++ b/arch/powerpc/kernel/trace/Makefile
@@ -14,9 +14,7 @@ obj64-$(CONFIG_FUNCTION_TRACER)		+= ftrace_mprofile.o
 else
 obj64-$(CONFIG_FUNCTION_TRACER)		+= ftrace_64_pg.o
 endif
-obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace_low.o
-obj-$(CONFIG_DYNAMIC_FTRACE)		+= ftrace.o
-obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
+obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace_low.o ftrace.o
 obj-$(CONFIG_TRACING)			+= trace_clock.o
 
 obj-$(CONFIG_PPC64)			+= $(obj64-y)
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 2c7e42e439bb..188f59f4ee4a 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -28,9 +28,6 @@
 #include <asm/syscall.h>
 #include <asm/inst.h>
 
-
-#ifdef CONFIG_DYNAMIC_FTRACE
-
 /*
  * We generally only have a single long_branch tramp and at most 2 or 3 plt
  * tramps generated. But, we don't use the plt tramps currently. We also allot
@@ -783,7 +780,6 @@ int __init ftrace_dyn_arch_init(void)
 	return 0;
 }
 #endif
-#endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
-- 
2.35.1


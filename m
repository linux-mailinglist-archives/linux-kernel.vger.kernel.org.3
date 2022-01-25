Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2179A49B306
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381761AbiAYLhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:37:43 -0500
Received: from foss.arm.com ([217.140.110.172]:37066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231356AbiAYLeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:34:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FEB91435;
        Tue, 25 Jan 2022 03:32:28 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A06953F7D8;
        Tue, 25 Jan 2022 03:32:26 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org
Subject: [PATCH v2 7/7] tools: update x86 string routines
Date:   Tue, 25 Jan 2022 11:32:00 +0000
Message-Id: <20220125113200.3829108-8-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125113200.3829108-1-mark.rutland@arm.com>
References: <20220125113200.3829108-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the perf tool the build system complains that the x86
string routines are out-of-date:

| Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
| diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
| Warning: Kernel ABI header at 'tools/arch/x86/lib/memset_64.S' differs from latest version at 'arch/x86/lib/memset_64.S'
| diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S

This is due to the way the asm-annotations for symbol aliasing were
reworked, which should have no functional/performance impact.

Import the latest versions, adding the new style SYM_FUNC_ALIAS(),
SYM_FUNC_ALIAS_LOAD(), SYM_FUNC_ALIAS_WEAK() macros into the perf
<linux/linkage.h> header. The old style SYM_FUNC_START_ALIAS() and
SYM_FUNC_END_ALIAS() macros are removed.

Other than removign the build-time warning, there should be no
functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 tools/arch/x86/lib/memcpy_64.S          | 10 ++--
 tools/arch/x86/lib/memset_64.S          |  6 +-
 tools/perf/util/include/linux/linkage.h | 80 ++++++++++++++++---------
 3 files changed, 61 insertions(+), 35 deletions(-)

diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index 59cf2343f3d90..d0d7b9bc6cad3 100644
--- a/tools/arch/x86/lib/memcpy_64.S
+++ b/tools/arch/x86/lib/memcpy_64.S
@@ -27,8 +27,7 @@
  * Output:
  * rax original destination
  */
-SYM_FUNC_START_ALIAS(__memcpy)
-SYM_FUNC_START_WEAK(memcpy)
+SYM_FUNC_START(__memcpy)
 	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memcpy_erms", X86_FEATURE_ERMS
 
@@ -40,11 +39,12 @@ SYM_FUNC_START_WEAK(memcpy)
 	movl %edx, %ecx
 	rep movsb
 	RET
-SYM_FUNC_END(memcpy)
-SYM_FUNC_END_ALIAS(__memcpy)
-EXPORT_SYMBOL(memcpy)
+SYM_FUNC_END(__memcpy)
 EXPORT_SYMBOL(__memcpy)
 
+SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
+EXPORT_SYMBOL(memcpy)
+
 /*
  * memcpy_erms() - enhanced fast string memcpy. This is faster and
  * simpler than memcpy. Use memcpy_erms when possible.
diff --git a/tools/arch/x86/lib/memset_64.S b/tools/arch/x86/lib/memset_64.S
index d624f2bc42f16..fc9ffd3ff3b21 100644
--- a/tools/arch/x86/lib/memset_64.S
+++ b/tools/arch/x86/lib/memset_64.S
@@ -17,7 +17,6 @@
  *
  * rax   original destination
  */
-SYM_FUNC_START_WEAK(memset)
 SYM_FUNC_START(__memset)
 	/*
 	 * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
@@ -42,10 +41,11 @@ SYM_FUNC_START(__memset)
 	movq %r9,%rax
 	RET
 SYM_FUNC_END(__memset)
-SYM_FUNC_END_ALIAS(memset)
-EXPORT_SYMBOL(memset)
 EXPORT_SYMBOL(__memset)
 
+SYM_FUNC_ALIAS_WEAK(memset, __memset)
+EXPORT_SYMBOL(memset)
+
 /*
  * ISO C memset - set a memory block to a byte value. This function uses
  * enhanced rep stosb to override the fast string function.
diff --git a/tools/perf/util/include/linux/linkage.h b/tools/perf/util/include/linux/linkage.h
index 5acf053fca7d4..b8edb5059bd6d 100644
--- a/tools/perf/util/include/linux/linkage.h
+++ b/tools/perf/util/include/linux/linkage.h
@@ -32,59 +32,59 @@
 
 /* === generic annotations === */
 
+#ifndef SYM_ENTRY_AT
+#define SYM_ENTRY_AT(name, location, linkage)		\
+	linkage(name) ASM_NL				\
+	.set .L____sym_entry__##name, location ASM_NL	\
+	.set name, location ASM_NL
+#endif
+
 /* SYM_ENTRY -- use only if you have to for non-paired symbols */
 #ifndef SYM_ENTRY
 #define SYM_ENTRY(name, linkage, align...)		\
-	linkage(name) ASM_NL				\
 	align ASM_NL					\
-	name:
+	SYM_ENTRY_AT(name, ., linkage)
+#endif
+
+/* SYM_START_AT -- use only if you have to */
+#ifndef SYM_START_AT
+#define SYM_START_AT(name, location, linkage)		\
+	SYM_ENTRY_AT(name, location, linkage)
 #endif
 
 /* SYM_START -- use only if you have to */
 #ifndef SYM_START
 #define SYM_START(name, linkage, align...)		\
-	SYM_ENTRY(name, linkage, align)
+	align ASM_NL					\
+	SYM_START_AT(name, ., linkage)
 #endif
 
-/* SYM_END -- use only if you have to */
-#ifndef SYM_END
-#define SYM_END(name, sym_type)				\
+/* SYM_END_AT -- use only if you have to */
+#ifndef SYM_END_AT
+#define SYM_END_AT(name, location, sym_type)		\
 	.type name sym_type ASM_NL			\
-	.size name, .-name
+	.set .L____sym_end__##name, location ASM_NL	\
+	.size name, location-name ASM_NL
 #endif
 
-/*
- * SYM_FUNC_START_ALIAS -- use where there are two global names for one
- * function
- */
-#ifndef SYM_FUNC_START_ALIAS
-#define SYM_FUNC_START_ALIAS(name)			\
-	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
+/* SYM_END -- use only if you have to */
+#ifndef SYM_END
+#define SYM_END(name, sym_type)				\
+	SYM_END_AT(name, ., sym_type)
 #endif
 
 /* SYM_FUNC_START -- use for global functions */
 #ifndef SYM_FUNC_START
-/*
- * The same as SYM_FUNC_START_ALIAS, but we will need to distinguish these two
- * later.
- */
 #define SYM_FUNC_START(name)				\
 	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
 #endif
 
 /* SYM_FUNC_START_LOCAL -- use for local functions */
 #ifndef SYM_FUNC_START_LOCAL
-/* the same as SYM_FUNC_START_LOCAL_ALIAS, see comment near SYM_FUNC_START */
 #define SYM_FUNC_START_LOCAL(name)			\
 	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
 #endif
 
-/* SYM_FUNC_END_ALIAS -- the end of LOCAL_ALIASed or ALIASed function */
-#ifndef SYM_FUNC_END_ALIAS
-#define SYM_FUNC_END_ALIAS(name)			\
-	SYM_END(name, SYM_T_FUNC)
-#endif
-
 /* SYM_FUNC_START_WEAK -- use for weak functions */
 #ifndef SYM_FUNC_START_WEAK
 #define SYM_FUNC_START_WEAK(name)			\
@@ -96,9 +96,35 @@
  * SYM_FUNC_START_WEAK, ...
  */
 #ifndef SYM_FUNC_END
-/* the same as SYM_FUNC_END_ALIAS, see comment near SYM_FUNC_START */
 #define SYM_FUNC_END(name)				\
 	SYM_END(name, SYM_T_FUNC)
 #endif
 
-#endif	/* PERF_LINUX_LINKAGE_H_ */
+/*
+ * SYM_FUNC_ALIAS_LOCAL -- define a local alias for an existing function
+ */
+#ifndef SYM_FUNC_ALIAS_LOCAL
+#define SYM_FUNC_ALIAS_LOCAL(alias, name)				\
+	SYM_START_AT(alias, .L____sym_entry__##name, SYM_L_LOCAL)	\
+	SYM_END_AT(alias, .L____sym_end__##name, SYM_T_FUNC)
+#endif
+
+/*
+ * SYM_FUNC_ALIAS -- define a global alias for an existing function
+ */
+#ifndef SYM_FUNC_ALIAS
+#define SYM_FUNC_ALIAS(alias, name)					\
+	SYM_START_AT(alias, .L____sym_entry__##name, SYM_L_GLOBAL)	\
+	SYM_END_AT(alias, .L____sym_end__##name, SYM_T_FUNC)
+#endif
+
+/*
+ * SYM_FUNC_ALIAS_WEAK -- define a weak global alias for an existing function
+ */
+#ifndef SYM_FUNC_ALIAS_WEAK
+#define SYM_FUNC_ALIAS_WEAK(alias, name)				\
+	SYM_START_AT(alias, .L____sym_entry__##name, SYM_L_WEAK)	\
+	SYM_END_AT(alias, .L____sym_end__##name, SYM_T_FUNC)
+#endif
+
+#endif /* PERF_LINUX_LINKAGE_H */
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286D54B28E8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242245AbiBKPPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:15:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351328AbiBKPPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:15:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFF95B18
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 07:15:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D441106F;
        Fri, 11 Feb 2022 07:15:05 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 96DFF3F718;
        Fri, 11 Feb 2022 07:15:03 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        mingo@redhat.com, ndesaulniers@google.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org
Subject: [PATCH v3 5/5] tools: update x86 string routines
Date:   Fri, 11 Feb 2022 15:14:45 +0000
Message-Id: <20220211151445.2027553-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220211151445.2027553-1-mark.rutland@arm.com>
References: <20220211151445.2027553-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Other than removing the build-time warning, there should be no
functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 tools/arch/x86/lib/memcpy_64.S          | 10 +++---
 tools/arch/x86/lib/memset_64.S          |  6 ++--
 tools/perf/util/include/linux/linkage.h | 46 ++++++++++++++++++-------
 3 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index 59cf2343f3d9..d0d7b9bc6cad 100644
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
index d624f2bc42f1..fc9ffd3ff3b2 100644
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
index 5acf053fca7d..b97d2e60edeb 100644
--- a/tools/perf/util/include/linux/linkage.h
+++ b/tools/perf/util/include/linux/linkage.h
@@ -50,16 +50,18 @@
 #ifndef SYM_END
 #define SYM_END(name, sym_type)				\
 	.type name sym_type ASM_NL			\
+	.set .L__sym_size_##name, .-name ASM_NL		\
 	.size name, .-name
 #endif
 
-/*
- * SYM_FUNC_START_ALIAS -- use where there are two global names for one
- * function
- */
-#ifndef SYM_FUNC_START_ALIAS
-#define SYM_FUNC_START_ALIAS(name)			\
-	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
+/* SYM_ALIAS -- use only if you have to */
+#ifndef SYM_ALIAS
+#define SYM_ALIAS(alias, name, sym_type, linkage)			\
+	linkage(alias) ASM_NL						\
+	.set alias, name ASM_NL						\
+	.type alias sym_type ASM_NL					\
+	.set .L__sym_size_##alias, .L__sym_size_##name ASM_NL		\
+	.size alias, .L__sym_size_##alias
 #endif
 
 /* SYM_FUNC_START -- use for global functions */
@@ -79,12 +81,6 @@
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
@@ -101,4 +97,28 @@
 	SYM_END(name, SYM_T_FUNC)
 #endif
 
+/*
+ * SYM_FUNC_ALIAS_LOCAL -- define a local alias for an existing function
+ */
+#ifndef SYM_FUNC_ALIAS_LOCAL
+#define SYM_FUNC_ALIAS_LOCAL(alias, name)				\
+	SYM_ALIAS(alias, name, SYM_T_FUNC, SYM_L_LOCAL)
+#endif
+
+/*
+ * SYM_FUNC_ALIAS -- define a global alias for an existing function
+ */
+#ifndef SYM_FUNC_ALIAS
+#define SYM_FUNC_ALIAS(alias, name)					\
+	SYM_ALIAS(alias, name, SYM_T_FUNC, SYM_L_GLOBAL)
+#endif
+
+/*
+ * SYM_FUNC_ALIAS_WEAK -- define a weak global alias for an existing function
+ */
+#ifndef SYM_FUNC_ALIAS_WEAK
+#define SYM_FUNC_ALIAS_WEAK(alias, name)				\
+	SYM_ALIAS(alias, name, SYM_T_FUNC, SYM_L_WEAK)
+#endif
+
 #endif	/* PERF_LINUX_LINKAGE_H_ */
-- 
2.30.2


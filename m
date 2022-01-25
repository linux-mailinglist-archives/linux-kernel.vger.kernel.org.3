Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B0349B2FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356252AbiAYLf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:35:56 -0500
Received: from foss.arm.com ([217.140.110.172]:36840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347779AbiAYLcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:32:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 597F412FC;
        Tue, 25 Jan 2022 03:32:17 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 555693F7D8;
        Tue, 25 Jan 2022 03:32:15 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org
Subject: [PATCH v2 3/7] linkage: add SYM_FUNC_ALIAS{,_LOCAL,_WEAK}()
Date:   Tue, 25 Jan 2022 11:31:56 +0000
Message-Id: <20220125113200.3829108-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125113200.3829108-1-mark.rutland@arm.com>
References: <20220125113200.3829108-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently aliasing an asm function requires adding START and END
annotations for each name, as per Documentation/asm-annotations.rst:

	SYM_FUNC_START_ALIAS(__memset)
	SYM_FUNC_START(memset)
	    ... asm insns ...
	SYM_FUNC_END(memset)
	SYM_FUNC_END_ALIAS(__memset)

This is more painful than necessary to maintain, especially where a
function has many aliases, some of which we may wish to define
conditionally. For example, arm64's memcpy/memmove implementation (which
uses some arch-specific SYM_*() helpers) has:

	SYM_FUNC_START_ALIAS(__memmove)
	SYM_FUNC_START_ALIAS_WEAK_PI(memmove)
	SYM_FUNC_START_ALIAS(__memcpy)
	SYM_FUNC_START_WEAK_PI(memcpy)
	    ... asm insns ...
	SYM_FUNC_END_PI(memcpy)
	EXPORT_SYMBOL(memcpy)
	SYM_FUNC_END_ALIAS(__memcpy)
	EXPORT_SYMBOL(__memcpy)
	SYM_FUNC_END_ALIAS_PI(memmove)
	EXPORT_SYMBOL(memmove)
	SYM_FUNC_END_ALIAS(__memmove)
	EXPORT_SYMBOL(__memmove)
	SYM_FUNC_START(name)

It would be much nicer if we could define the aliases *after* the
standard function definition. This would avoid the need to specify each
symbol name twice, and would make it easier to spot the canonical
function definition. This patch adds new macros to allow us to do so,
which allows the above example to be rewritten more succinctly as:

	SYM_FUNC_START(__pi_memcpy)
	    ... asm insns ...
	SYM_FUNC_END(__pi_memcpy)

	SYM_FUNC_ALIAS(__memcpy, __pi_memcpy)
	EXPORT_SYMBOL(__memcpy)
	SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
	EXPORT_SYMBOL(memcpy)

	SYM_FUNC_ALIAS(__pi_memmove, __pi_memcpy)
	SYM_FUNC_ALIAS(__memmove, __pi_memmove)
	EXPORT_SYMBOL(__memmove)
	SYM_FUNC_ALIAS_WEAK(memmove, __memmove)
	EXPORT_SYMBOL(memmove)

The reduction in duplication will also make it possible to replace some
uses of WEAK with more accurate Kconfig guards, e.g.

	#ifndef CONFIG_KASAN
	SYM_FUNC_ALIAS(memmove, __memmove)
	EXPORT_SYMBOL(memmove)
	#endif

... which should make it easier to ensure that symbols are neither used
nor overidden unexpectedly.

The existing SYM_FUNC_START_ALIAS() and SYM_FUNC_START_LOCAL_ALIAS() are
marked as deprecated, and will be removed once existing users are moved
over to the new scheme.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 Documentation/asm-annotations.rst | 16 ++++++++++++++--
 include/linux/linkage.h           | 29 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
index f4bf0f6395fb9..4868b58c60fb1 100644
--- a/Documentation/asm-annotations.rst
+++ b/Documentation/asm-annotations.rst
@@ -130,8 +130,20 @@ denoting a range of code via ``SYM_*_START/END`` annotations.
   In fact, this kind of annotation corresponds to the now deprecated ``ENTRY``
   and ``ENDPROC`` macros.
 
-* ``SYM_FUNC_START_ALIAS`` and ``SYM_FUNC_START_LOCAL_ALIAS`` serve for those
-  who decided to have two or more names for one function. The typical use is::
+* ``SYM_FUNC_ALIAS``, ``SYM_FUNC_ALIAS_LOCAL``, and ``SYM_FUNC_ALIAS_WEAK`` can
+  be used to define multiple names for a function. The typical use is::
+
+    SYM_FUNC_START(__memset)
+        ... asm insns ...
+    SYN_FUNC_END(__memset)
+    SYM_FUNC_ALIAS(memset, __memset)
+
+  In this example, one can call ``__memset`` or ``memset`` with the same
+  result, except the debug information for the instructions is generated to
+  the object file only once -- for the non-``ALIAS`` case.
+
+* ``SYM_FUNC_START_ALIAS`` and ``SYM_FUNC_START_LOCAL_ALIAS`` are deprecated
+    ways to define two or more names for one function. The typical use is::
 
     SYM_FUNC_START_ALIAS(__memset)
     SYM_FUNC_START(memset)
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index d87c2acda2540..becd64e9e5b18 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -150,6 +150,7 @@
 #ifndef SYM_ENTRY_AT
 #define SYM_ENTRY_AT(name, location, linkage)		\
 	linkage(name) ASM_NL				\
+	.set .L____sym_entry__##name, location ASM_NL	\
 	.set name, location ASM_NL
 #endif
 
@@ -177,6 +178,7 @@
 #ifndef SYM_END_AT
 #define SYM_END_AT(name, location, sym_type)		\
 	.type name sym_type ASM_NL			\
+	.set .L____sym_end__##name, location ASM_NL	\
 	.size name, location-name ASM_NL
 #endif
 
@@ -293,6 +295,33 @@
 	SYM_END(name, SYM_T_FUNC)
 #endif
 
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
 /* SYM_CODE_START -- use for non-C (special) functions */
 #ifndef SYM_CODE_START
 #define SYM_CODE_START(name)				\
-- 
2.30.2


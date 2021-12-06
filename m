Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E934695F1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbhLFMu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:50:59 -0500
Received: from foss.arm.com ([217.140.110.172]:56304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243374AbhLFMuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:50:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B2D8152F;
        Mon,  6 Dec 2021 04:47:27 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 102A23F73D;
        Mon,  6 Dec 2021 04:47:24 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        maz@kernel.org, mingo@redhat.com, peterz@infradead.org,
        tabba@google.com, tglx@linutronix.de, will@kernel.org
Subject: [RFC PATCH 2/6] linkage: add SYM_FUNC_{LOCAL_,}ALIAS()
Date:   Mon,  6 Dec 2021 12:47:11 +0000
Message-Id: <20211206124715.4101571-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211206124715.4101571-1-mark.rutland@arm.com>
References: <20211206124715.4101571-1-mark.rutland@arm.com>
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

TODO:

* Handle tools/ copy

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 Documentation/asm-annotations.rst | 16 ++++++++++++++--
 include/linux/linkage.h           | 29 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
index f4bf0f6395fb..cdc53bf7f9bb 100644
--- a/Documentation/asm-annotations.rst
+++ b/Documentation/asm-annotations.rst
@@ -130,8 +130,20 @@ denoting a range of code via ``SYM_*_START/END`` annotations.
   In fact, this kind of annotation corresponds to the now deprecated ``ENTRY``
   and ``ENDPROC`` macros.
 
-* ``SYM_FUNC_START_ALIAS`` and ``SYM_FUNC_START_LOCAL_ALIAS`` serve for those
-  who decided to have two or more names for one function. The typical use is::
+* ``SYM_FUNC_ALIAS``, ``SYM_FUNC_ALIAS_WEAK``, and ``SYM_FUNC_LOCAL_ALIAS`` can
+   be used to define multiple names for a function. The typical use is::
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
index 45a4c0fcef7d..e91e5db92b2b 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -150,6 +150,7 @@
 #ifndef SYM_ENTRY_AT
 #define SYM_ENTRY_AT(name, location, linkage, align...)	\
 	linkage(name) ASM_NL				\
+	.set .L____sym_entry__##name, location ASM_NL	\
 	.set name, location ASM_NL
 #endif
 
@@ -176,6 +177,7 @@
 #ifndef SYM_END_AT
 #define SYM_END_AT(name, location, sym_type)		\
 	.type name sym_type ASM_NL			\
+	.set .L____sym_end__##name, location ASM_NL	\
 	.size name, location-name ASM_NL
 #endif
 
@@ -292,6 +294,33 @@
 	SYM_END(name, SYM_T_FUNC)
 #endif
 
+/*
+ * SYM_FUNC_LOCAL_ALIAS -- define a local alias for an existing function
+ */
+#ifndef SYM_FUNC_LOCAL_ALIAS
+#define SYM_FUNC_LOCAL_ALIAS(alias, name)					\
+	SYM_START_AT(alias, .L____sym_entry__##name, SYM_L_LOCAL, SYM_A_NONE)	\
+	SYM_END_AT(alias, .L____sym_end__##name, SYM_T_FUNC)
+#endif
+
+/*
+ * SYM_FUNC_ALIAS -- define a global alias for an existing function
+ */
+#ifndef SYM_FUNC_ALIAS
+#define SYM_FUNC_ALIAS(alias, name)						\
+	SYM_START_AT(alias, .L____sym_entry__##name, SYM_L_GLOBAL, SYM_A_NONE)	\
+	SYM_END_AT(alias, .L____sym_end__##name, SYM_T_FUNC)
+#endif
+
+/*
+ * SYM_FUNC_ALIAS_WEAK -- define a weak global alias for an existing function
+ */
+#ifndef SYM_FUNC_ALIAS_WEAK
+#define SYM_FUNC_ALIAS_WEAK(alias, name)						\
+	SYM_START_AT(alias, .L____sym_entry__##name, SYM_L_WEAK, SYM_A_NONE)	\
+	SYM_END_AT(alias, .L____sym_end__##name, SYM_T_FUNC)
+#endif
+
 /* SYM_CODE_START -- use for non-C (special) functions */
 #ifndef SYM_CODE_START
 #define SYM_CODE_START(name)				\
-- 
2.30.2


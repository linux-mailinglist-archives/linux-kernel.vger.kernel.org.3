Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9C64695F5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243454AbhLFMvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:51:13 -0500
Received: from foss.arm.com ([217.140.110.172]:56396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243429AbhLFMvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:51:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA8B96D;
        Mon,  6 Dec 2021 04:47:37 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF14C3F73D;
        Mon,  6 Dec 2021 04:47:35 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        maz@kernel.org, mingo@redhat.com, peterz@infradead.org,
        tabba@google.com, tglx@linutronix.de, will@kernel.org
Subject: [RFC PATCH 6/6] linkage: remove START/END ALIAS macros
Date:   Mon,  6 Dec 2021 12:47:15 +0000
Message-Id: <20211206124715.4101571-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211206124715.4101571-1-mark.rutland@arm.com>
References: <20211206124715.4101571-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all aliases are defined using SYM_FUNC_ALIAS(), remove the old
SYM_FUNC_{START,END}_ALIAS() macros.

TODO:

* Handle tools/ copy

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 Documentation/asm-annotations.rst | 13 -------------
 include/linux/linkage.h           | 30 ------------------------------
 2 files changed, 43 deletions(-)

diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
index cdc53bf7f9bb..ff7ecc43ca35 100644
--- a/Documentation/asm-annotations.rst
+++ b/Documentation/asm-annotations.rst
@@ -142,19 +142,6 @@ denoting a range of code via ``SYM_*_START/END`` annotations.
   result, except the debug information for the instructions is generated to
   the object file only once -- for the non-``ALIAS`` case.
 
-* ``SYM_FUNC_START_ALIAS`` and ``SYM_FUNC_START_LOCAL_ALIAS`` are deprecated
-    ways to define two or more names for one function. The typical use is::
-
-    SYM_FUNC_START_ALIAS(__memset)
-    SYM_FUNC_START(memset)
-        ... asm insns ...
-    SYM_FUNC_END(memset)
-    SYM_FUNC_END_ALIAS(__memset)
-
-  In this example, one can call ``__memset`` or ``memset`` with the same
-  result, except the debug information for the instructions is generated to
-  the object file only once -- for the non-``ALIAS`` case.
-
 * ``SYM_CODE_START`` and ``SYM_CODE_START_LOCAL`` should be used only in
   special cases -- if you know what you are doing. This is used exclusively
   for interrupt handlers and similar where the calling convention is not the C
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index e91e5db92b2b..813e4f37586b 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -219,30 +219,8 @@
 	SYM_ENTRY(name, linkage, SYM_A_NONE)
 #endif
 
-/*
- * SYM_FUNC_START_LOCAL_ALIAS -- use where there are two local names for one
- * function
- */
-#ifndef SYM_FUNC_START_LOCAL_ALIAS
-#define SYM_FUNC_START_LOCAL_ALIAS(name)		\
-	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
-#endif
-
-/*
- * SYM_FUNC_START_ALIAS -- use where there are two global names for one
- * function
- */
-#ifndef SYM_FUNC_START_ALIAS
-#define SYM_FUNC_START_ALIAS(name)			\
-	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
-#endif
-
 /* SYM_FUNC_START -- use for global functions */
 #ifndef SYM_FUNC_START
-/*
- * The same as SYM_FUNC_START_ALIAS, but we will need to distinguish these two
- * later.
- */
 #define SYM_FUNC_START(name)				\
 	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
 #endif
@@ -255,7 +233,6 @@
 
 /* SYM_FUNC_START_LOCAL -- use for local functions */
 #ifndef SYM_FUNC_START_LOCAL
-/* the same as SYM_FUNC_START_LOCAL_ALIAS, see comment near SYM_FUNC_START */
 #define SYM_FUNC_START_LOCAL(name)			\
 	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
 #endif
@@ -278,18 +255,11 @@
 	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)
 #endif
 
-/* SYM_FUNC_END_ALIAS -- the end of LOCAL_ALIASed or ALIASed function */
-#ifndef SYM_FUNC_END_ALIAS
-#define SYM_FUNC_END_ALIAS(name)			\
-	SYM_END(name, SYM_T_FUNC)
-#endif
-
 /*
  * SYM_FUNC_END -- the end of SYM_FUNC_START_LOCAL, SYM_FUNC_START,
  * SYM_FUNC_START_WEAK, ...
  */
 #ifndef SYM_FUNC_END
-/* the same as SYM_FUNC_END_ALIAS, see comment near SYM_FUNC_START */
 #define SYM_FUNC_END(name)				\
 	SYM_END(name, SYM_T_FUNC)
 #endif
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8239949B305
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381652AbiAYLha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:37:30 -0500
Received: from foss.arm.com ([217.140.110.172]:37064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345859AbiAYLeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:34:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA2F913D5;
        Tue, 25 Jan 2022 03:32:25 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C36633F7D8;
        Tue, 25 Jan 2022 03:32:23 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org
Subject: [PATCH v2 6/7] linkage: remove SYM_FUNC_{START,END}_ALIAS()
Date:   Tue, 25 Jan 2022 11:31:59 +0000
Message-Id: <20220125113200.3829108-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125113200.3829108-1-mark.rutland@arm.com>
References: <20220125113200.3829108-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all aliases are defined using SYM_FUNC_ALIAS(), remove the old
SYM_FUNC_{START,END}_ALIAS() macros.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 Documentation/asm-annotations.rst | 13 -------------
 include/linux/linkage.h           | 30 ------------------------------
 2 files changed, 43 deletions(-)

diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
index 4868b58c60fb1..a64f2ca469d45 100644
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
index becd64e9e5b18..960d9a032861e 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -220,30 +220,8 @@
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
@@ -256,7 +234,6 @@
 
 /* SYM_FUNC_START_LOCAL -- use for local functions */
 #ifndef SYM_FUNC_START_LOCAL
-/* the same as SYM_FUNC_START_LOCAL_ALIAS, see comment near SYM_FUNC_START */
 #define SYM_FUNC_START_LOCAL(name)			\
 	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
 #endif
@@ -279,18 +256,11 @@
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


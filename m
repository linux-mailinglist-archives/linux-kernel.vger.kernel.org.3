Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32EB4B28ED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbiBKPPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:15:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351309AbiBKPPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:15:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F3CAB0B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 07:15:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F18A5139F;
        Fri, 11 Feb 2022 07:15:02 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 18D073F718;
        Fri, 11 Feb 2022 07:15:00 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        mingo@redhat.com, ndesaulniers@google.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org
Subject: [PATCH v3 4/5] linkage: remove SYM_FUNC_{START,END}_ALIAS()
Date:   Fri, 11 Feb 2022 15:14:44 +0000
Message-Id: <20220211151445.2027553-5-mark.rutland@arm.com>
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
index 4868b58c60fb..a64f2ca469d4 100644
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
index aca8f5cb9c3c..bee482e956b4 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -211,30 +211,8 @@
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
@@ -247,7 +225,6 @@
 
 /* SYM_FUNC_START_LOCAL -- use for local functions */
 #ifndef SYM_FUNC_START_LOCAL
-/* the same as SYM_FUNC_START_LOCAL_ALIAS, see comment near SYM_FUNC_START */
 #define SYM_FUNC_START_LOCAL(name)			\
 	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
 #endif
@@ -270,18 +247,11 @@
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


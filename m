Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609354D2A2C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiCIH7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiCIH5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:57:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC1E163078;
        Tue,  8 Mar 2022 23:55:35 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812520;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQua3acg7u2za/YQmo74bpacduseUGkWpGtZFEclibU=;
        b=COWVhm/e/zi6JY+X4KxhNRqktig54OKtkVJn8E4UB3OowmIFhcIWFKRq2fHoGs7t9bH6+J
        6izaUbLVkdgQrtPrf/SP+J82xzRn8IEeukQJwlUdPZV6CNqkZ8YD8TUcrei0DP26v6ivzO
        p2MB1wz2cAYviFQNXnCqfLYURs8aElbbL5IRztnScSKMJtowlLiRoQnXiJe6hYapsraCKP
        VNHyClHp5qkP8lODrPy6mU//g4fHjic2SMoQfQiZTBGCc3Wn50ICQ4gSYBeXU6GStbuufr
        2aD11ZLSrSmzBAOMcryscLe/PvYPm1PNRpFM0O3kOyb1P8+II34LEi6FE8XDTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812520;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQua3acg7u2za/YQmo74bpacduseUGkWpGtZFEclibU=;
        b=gRsOBdfmSZWFayWQX5RhB8ETHqBiBN5ETiv6tWHi3VpK1XojDtPizFwQdRox9A4mxK3sPO
        g6XClf/Jy1lAPhCA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] linkage: remove SYM_FUNC_{START,END}_ALIAS()
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Jiri Slaby <jslaby@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220216162229.1076788-5-mark.rutland@arm.com>
References: <20220216162229.1076788-5-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <164681251954.16921.8052789899380488205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     be9aea74400433e03c2a8b0260fc9ffe2495f698
Gitweb:        https://git.kernel.org/tip/be9aea74400433e03c2a8b0260fc9ffe2495f698
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 16 Feb 2022 16:22:29 
Committer:     Will Deacon <will@kernel.org>
CommitterDate: Tue, 22 Feb 2022 16:21:34 

linkage: remove SYM_FUNC_{START,END}_ALIAS()

Now that all aliases are defined using SYM_FUNC_ALIAS(), remove the old
SYM_FUNC_{START,END}_ALIAS() macros.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Mark Brown <broonie@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220216162229.1076788-5-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 Documentation/asm-annotations.rst       | 13 +----------
 include/linux/linkage.h                 | 30 +------------------------
 tools/perf/util/include/linux/linkage.h | 21 +-----------------
 3 files changed, 64 deletions(-)

diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
index 4868b58..a64f2ca 100644
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
index e574a84..acb1ad2 100644
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
diff --git a/tools/perf/util/include/linux/linkage.h b/tools/perf/util/include/linux/linkage.h
index 7b4cd79..aa0c517 100644
--- a/tools/perf/util/include/linux/linkage.h
+++ b/tools/perf/util/include/linux/linkage.h
@@ -64,38 +64,18 @@
 	.size alias, .L__sym_size_##alias
 #endif
 
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
@@ -107,7 +87,6 @@
  * SYM_FUNC_START_WEAK, ...
  */
 #ifndef SYM_FUNC_END
-/* the same as SYM_FUNC_END_ALIAS, see comment near SYM_FUNC_START */
 #define SYM_FUNC_END(name)				\
 	SYM_END(name, SYM_T_FUNC)
 #endif

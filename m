Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D514D2A34
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiCIH7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiCIH45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB325167F82;
        Tue,  8 Mar 2022 23:55:27 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812523;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6iAXRFNlGiOuLkQ8n1Z/8wU15pH0555kDE8HKzUB5dk=;
        b=Pno2KSMehfwqdh2jY2dV4El8ZGQFRVDisevFk1y1J4weEZaOwj1pEBozN4XKWxi1Vkf0bt
        /w+S3eFtOwDGxbAirTpszNSX85H77Z5VjK2G/f+K+t1Zgp2zHBdJj+1gkHfwHVYYwbOrBD
        bVx3OOHrdcFrIGlQ2ThYbn6+1rfygYfA5/+PLxa5yWqu+kNZI3TY61KJTPxW/nvVjWaZ8l
        igyypia/iS+LPxbx+2BmEssSCWYhNrcbIQjFHaRkMFIxXGTCdbRs11RA7VXSR0wi1Vk1vo
        8jHziolfvwIjisGn1lH6iDujz9a9eBPoS0aQlS6ZOEt7C+hPBGh5szOca7Lxmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812523;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6iAXRFNlGiOuLkQ8n1Z/8wU15pH0555kDE8HKzUB5dk=;
        b=NUMHpsceJNrKm6+IjI8/lqcfvTI67AQr2aJdAGmSOJtW1jKlpgPcKpYGaOVQ9W5eQPf7rJ
        Fddods2Jdw42yKBQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] linkage: add SYM_FUNC_ALIAS{,_LOCAL,_WEAK}()
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Jiri Slaby <jslaby@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220216162229.1076788-2-mark.rutland@arm.com>
References: <20220216162229.1076788-2-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <164681252222.16921.2515658088729657001.tip-bot2@tip-bot2>
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

Commit-ID:     e0891269a8c25715bd9510dc355326b00ab42db2
Gitweb:        https://git.kernel.org/tip/e0891269a8c25715bd9510dc355326b00ab42db2
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 16 Feb 2022 16:22:26 
Committer:     Will Deacon <will@kernel.org>
CommitterDate: Tue, 22 Feb 2022 16:21:33 

linkage: add SYM_FUNC_ALIAS{,_LOCAL,_WEAK}()

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
function definition.

This patch adds new macros to allow us to do so, which allows the above
example to be rewritten more succinctly as:

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

The tools/perf/ copy of linkage.h is updated to match. A subsequent
patch will depend upon this when updating the x86 asm annotations.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Mark Brown <broonie@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220216162229.1076788-2-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 Documentation/asm-annotations.rst       | 16 ++++++++--
 include/linux/linkage.h                 | 37 +++++++++++++++++++++++-
 tools/perf/util/include/linux/linkage.h | 35 +++++++++++++++++++++++-
 3 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
index f4bf0f6..4868b58 100644
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
index dbf8506..e574a84 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -165,7 +165,18 @@
 #ifndef SYM_END
 #define SYM_END(name, sym_type)				\
 	.type name sym_type ASM_NL			\
-	.size name, .-name
+	.set .L__sym_size_##name, .-name ASM_NL		\
+	.size name, .L__sym_size_##name
+#endif
+
+/* SYM_ALIAS -- use only if you have to */
+#ifndef SYM_ALIAS
+#define SYM_ALIAS(alias, name, sym_type, linkage)			\
+	linkage(alias) ASM_NL						\
+	.set alias, name ASM_NL						\
+	.type alias sym_type ASM_NL					\
+	.set .L__sym_size_##alias, .L__sym_size_##name ASM_NL		\
+	.size alias, .L__sym_size_##alias
 #endif
 
 /* === code annotations === */
@@ -275,6 +286,30 @@
 	SYM_END(name, SYM_T_FUNC)
 #endif
 
+/*
+ * SYM_FUNC_ALIAS -- define a global alias for an existing function
+ */
+#ifndef SYM_FUNC_ALIAS
+#define SYM_FUNC_ALIAS(alias, name)					\
+	SYM_ALIAS(alias, name, SYM_T_FUNC, SYM_L_GLOBAL)
+#endif
+
+/*
+ * SYM_FUNC_ALIAS_LOCAL -- define a local alias for an existing function
+ */
+#ifndef SYM_FUNC_ALIAS_LOCAL
+#define SYM_FUNC_ALIAS_LOCAL(alias, name)				\
+	SYM_ALIAS(alias, name, SYM_T_FUNC, SYM_L_LOCAL)
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
 /* SYM_CODE_START -- use for non-C (special) functions */
 #ifndef SYM_CODE_START
 #define SYM_CODE_START(name)				\
diff --git a/tools/perf/util/include/linux/linkage.h b/tools/perf/util/include/linux/linkage.h
index 5acf053..7b4cd79 100644
--- a/tools/perf/util/include/linux/linkage.h
+++ b/tools/perf/util/include/linux/linkage.h
@@ -50,9 +50,20 @@
 #ifndef SYM_END
 #define SYM_END(name, sym_type)				\
 	.type name sym_type ASM_NL			\
+	.set .L__sym_size_##name, .-name ASM_NL		\
 	.size name, .-name
 #endif
 
+/* SYM_ALIAS -- use only if you have to */
+#ifndef SYM_ALIAS
+#define SYM_ALIAS(alias, name, sym_type, linkage)			\
+	linkage(alias) ASM_NL						\
+	.set alias, name ASM_NL						\
+	.type alias sym_type ASM_NL					\
+	.set .L__sym_size_##alias, .L__sym_size_##name ASM_NL		\
+	.size alias, .L__sym_size_##alias
+#endif
+
 /*
  * SYM_FUNC_START_ALIAS -- use where there are two global names for one
  * function
@@ -101,4 +112,28 @@
 	SYM_END(name, SYM_T_FUNC)
 #endif
 
+/*
+ * SYM_FUNC_ALIAS -- define a global alias for an existing function
+ */
+#ifndef SYM_FUNC_ALIAS
+#define SYM_FUNC_ALIAS(alias, name)					\
+	SYM_ALIAS(alias, name, SYM_T_FUNC, SYM_L_GLOBAL)
+#endif
+
+/*
+ * SYM_FUNC_ALIAS_LOCAL -- define a local alias for an existing function
+ */
+#ifndef SYM_FUNC_ALIAS_LOCAL
+#define SYM_FUNC_ALIAS_LOCAL(alias, name)				\
+	SYM_ALIAS(alias, name, SYM_T_FUNC, SYM_L_LOCAL)
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

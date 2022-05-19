Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EC852DFAF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245435AbiESV55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245394AbiESV5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:57:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72446108AA7;
        Thu, 19 May 2022 14:57:28 -0700 (PDT)
Date:   Thu, 19 May 2022 21:57:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652997447;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSPMLRw1pmQPK5o4VwMo09I8cSgfaQ+4eOpXqmuc8tw=;
        b=VC7Ye8l//u6HVJt/u+VOwKoCodbsAIrNcmvzc92yIVGCV9iaUPyZQi9m+BFibEqxHy+1m2
        wliuBhGX91jSHwEjutjjGyamzeQwkm4LqLLfob4mKgPsNPD9UJSBP/Yuofr53WqwhlLJET
        YiPgPEiJRcGErGRZd/dmpqQEeU8F7XnTSG6tVbkS+uEkvQUoS/ozaL5Z5pqKiiu1x8fiJF
        AqWtFHIPXp72hhNmWPBZZciE/FgLig/a0M1IkUpHpjT5D38QYhc8ip0iXPo0QMZA9U5s45
        Sh5Q1AkrXHEATIjHv9v0DGwrMfE5rYJFoChxx/ElJ5sJbYkg0dAu46M6SDZvXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652997447;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSPMLRw1pmQPK5o4VwMo09I8cSgfaQ+4eOpXqmuc8tw=;
        b=eQLof9jR5FQvyX758l2F/9GSXLS2ANoa0+Bor7XmyvB9hRsMjofrGtKDbBjeC4bkO8EmPa
        IajtMgsD6ghwqVBw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] bug: Use normal relative pointers in 'struct bug_entry'
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <f0e05be797a16f4fc2401eeb88c8450dcbe61df6.1652362951.git.jpoimboe@kernel.org>
References: <f0e05be797a16f4fc2401eeb88c8450dcbe61df6.1652362951.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <165299744635.4207.4995639142275371987.tip-bot2@tip-bot2>
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

Commit-ID:     69505e3d9a39a988aaed9b58aa6b3482238f6516
Gitweb:        https://git.kernel.org/tip/69505e3d9a39a988aaed9b58aa6b3482238f6516
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 12 May 2022 06:56:23 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 May 2022 23:46:10 +02:00

bug: Use normal relative pointers in 'struct bug_entry'

With CONFIG_GENERIC_BUG_RELATIVE_POINTERS, the addr/file relative
pointers are calculated weirdly: based on the beginning of the bug_entry
struct address, rather than their respective pointer addresses.

Make the relative pointers less surprising to both humans and tools by
calculating them the normal way.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Sven Schnelle <svens@linux.ibm.com> # s390
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]
Link: https://lkml.kernel.org/r/f0e05be797a16f4fc2401eeb88c8450dcbe61df6.1652362951.git.jpoimboe@kernel.org
---
 arch/arm64/include/asm/asm-bug.h |  4 ++--
 arch/powerpc/include/asm/bug.h   | 14 ++++++++------
 arch/riscv/include/asm/bug.h     |  4 ++--
 arch/s390/include/asm/bug.h      |  5 +++--
 arch/x86/include/asm/bug.h       |  2 +-
 lib/bug.c                        | 15 +++++++--------
 6 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
index 03f52f8..c762038 100644
--- a/arch/arm64/include/asm/asm-bug.h
+++ b/arch/arm64/include/asm/asm-bug.h
@@ -14,7 +14,7 @@
 	14472:	.string file;					\
 		.popsection;					\
 								\
-		.long 14472b - 14470b;				\
+		.long 14472b - .;				\
 		.short line;
 #else
 #define _BUGVERBOSE_LOCATION(file, line)
@@ -25,7 +25,7 @@
 #define __BUG_ENTRY(flags) 				\
 		.pushsection __bug_table,"aw";		\
 		.align 2;				\
-	14470:	.long 14471f - 14470b;			\
+	14470:	.long 14471f - .;			\
 _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
 		.short flags; 				\
 		.popsection;				\
diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index ecbae18..61a4736 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -13,7 +13,8 @@
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 .macro __EMIT_BUG_ENTRY addr,file,line,flags
 	 .section __bug_table,"aw"
-5001:	 .4byte \addr - 5001b, 5002f - 5001b
+5001:	 .4byte \addr - .
+	 .4byte 5002f - .
 	 .short \line, \flags
 	 .org 5001b+BUG_ENTRY_SIZE
 	 .previous
@@ -24,7 +25,7 @@
 #else
 .macro __EMIT_BUG_ENTRY addr,file,line,flags
 	 .section __bug_table,"aw"
-5001:	 .4byte \addr - 5001b
+5001:	 .4byte \addr - .
 	 .short \flags
 	 .org 5001b+BUG_ENTRY_SIZE
 	 .previous
@@ -49,15 +50,16 @@
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 #define _EMIT_BUG_ENTRY				\
 	".section __bug_table,\"aw\"\n"		\
-	"2:\t.4byte 1b - 2b, %0 - 2b\n"		\
-	"\t.short %1, %2\n"			\
+	"2:	.4byte 1b - .\n"		\
+	"	.4byte %0 - .\n"		\
+	"	.short %1, %2\n"		\
 	".org 2b+%3\n"				\
 	".previous\n"
 #else
 #define _EMIT_BUG_ENTRY				\
 	".section __bug_table,\"aw\"\n"		\
-	"2:\t.4byte 1b - 2b\n"			\
-	"\t.short %2\n"				\
+	"2:	.4byte 1b - .\n"		\
+	"	.short %2\n"			\
 	".org 2b+%3\n"				\
 	".previous\n"
 #endif
diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index d3804a2..1aaea81 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -30,8 +30,8 @@
 typedef u32 bug_insn_t;
 
 #ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
-#define __BUG_ENTRY_ADDR	RISCV_INT " 1b - 2b"
-#define __BUG_ENTRY_FILE	RISCV_INT " %0 - 2b"
+#define __BUG_ENTRY_ADDR	RISCV_INT " 1b - ."
+#define __BUG_ENTRY_FILE	RISCV_INT " %0 - ."
 #else
 #define __BUG_ENTRY_ADDR	RISCV_PTR " 1b"
 #define __BUG_ENTRY_FILE	RISCV_PTR " %0"
diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index 0b25f28..aebe1e2 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -15,7 +15,8 @@
 		"1:	.asciz	\""__FILE__"\"\n"		\
 		".previous\n"					\
 		".section __bug_table,\"awM\",@progbits,%2\n"	\
-		"2:	.long	0b-2b,1b-2b\n"			\
+		"2:	.long	0b-.\n"				\
+		"	.long	1b-.\n"				\
 		"	.short	%0,%1\n"			\
 		"	.org	2b+%2\n"			\
 		".previous\n"					\
@@ -30,7 +31,7 @@
 	asm_inline volatile(					\
 		"0:	mc	0,0\n"				\
 		".section __bug_table,\"awM\",@progbits,%1\n"	\
-		"1:	.long	0b-1b\n"			\
+		"1:	.long	0b-.\n"				\
 		"	.short	%0\n"				\
 		"	.org	1b+%1\n"			\
 		".previous\n"					\
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 4d20a29..76fbe24 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -18,7 +18,7 @@
 #ifdef CONFIG_X86_32
 # define __BUG_REL(val)	".long " __stringify(val)
 #else
-# define __BUG_REL(val)	".long " __stringify(val) " - 2b"
+# define __BUG_REL(val)	".long " __stringify(val) " - ."
 #endif
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
diff --git a/lib/bug.c b/lib/bug.c
index 45a0584..c223a25 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -6,8 +6,7 @@
 
   CONFIG_BUG - emit BUG traps.  Nothing happens without this.
   CONFIG_GENERIC_BUG - enable this code.
-  CONFIG_GENERIC_BUG_RELATIVE_POINTERS - use 32-bit pointers relative to
-	the containing struct bug_entry for bug_addr and file.
+  CONFIG_GENERIC_BUG_RELATIVE_POINTERS - use 32-bit relative pointers for bug_addr and file
   CONFIG_DEBUG_BUGVERBOSE - emit full file+line information for each BUG
 
   CONFIG_BUG and CONFIG_DEBUG_BUGVERBOSE are potentially user-settable
@@ -53,10 +52,10 @@ extern struct bug_entry __start___bug_table[], __stop___bug_table[];
 
 static inline unsigned long bug_addr(const struct bug_entry *bug)
 {
-#ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
-	return bug->bug_addr;
+#ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
+	return (unsigned long)&bug->bug_addr_disp + bug->bug_addr_disp;
 #else
-	return (unsigned long)bug + bug->bug_addr_disp;
+	return bug->bug_addr;
 #endif
 }
 
@@ -131,10 +130,10 @@ void bug_get_file_line(struct bug_entry *bug, const char **file,
 		       unsigned int *line)
 {
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
-	*file = bug->file;
+#ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
+	*file = (const char *)&bug->file_disp + bug->file_disp;
 #else
-	*file = (const char *)bug + bug->file_disp;
+	*file = bug->file;
 #endif
 	*line = bug->line;
 #else

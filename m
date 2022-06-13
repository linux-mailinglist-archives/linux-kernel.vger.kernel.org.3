Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8D75481A6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbiFMIW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238957AbiFMIWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:22:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9715225CF;
        Mon, 13 Jun 2022 01:22:21 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:22:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655108539;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xXXl7tlInLHreKiAzdYD4t4G3JyFW5ACW+PT+Cm/5M8=;
        b=Jn2uUAwXAxSAf0wGqJ62/PCpHlPp/UjmRb7dOdkDyB6MMPn9sQIpUkKAobccsj3p7qvFAd
        XuMlKEgvCy0kGfqjputq0Y07MnztO23Ba4IDMRz5g1/xahZiQjajA4bLPiQ/OXJtMVQ3BE
        MVP6gH1dKB06L5p6WPQ9yswzR9cqexnSSKXDRzOBXE7+GXrpLaSPJJX6YQOYhj2TyvtnHP
        efTUxCIp2Sut5wg2dmZZ5vtVFaHqHAZeFICeZwm0WXvGlp4VQCKYlVgsM9pjqPi5ck82JJ
        GWWYHKyDgR6k1hPRVY8y/Zw5rFeg6bysCOIWvCoRfHXNPsjMD2aaU3vm4jyFNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655108539;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xXXl7tlInLHreKiAzdYD4t4G3JyFW5ACW+PT+Cm/5M8=;
        b=U0lNliAn9qD2YA1cMKLHDd+v3tDhhbeJbw18WJBaponf1FzIQK/prJIU1YlhRlyvIOVX0z
        JhUM67rZ6LTiFpBA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Fix RESERVE_BRK() for older binutils
Cc:     Joe Damato <jdamato@fastly.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <22d07a44c80d8e8e1e82b9a806ddc8c6bbb2606e.1654759036.git.jpoimboe@kernel.org>
References: <22d07a44c80d8e8e1e82b9a806ddc8c6bbb2606e.1654759036.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <165510853780.4207.497514321420713760.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e32683c6f7d22ba624e0bfc58b02cf3348bdca63
Gitweb:        https://git.kernel.org/tip/e32683c6f7d22ba624e0bfc58b02cf3348bdca63
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 09 Jun 2022 00:17:32 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:15:04 +02:00

x86/mm: Fix RESERVE_BRK() for older binutils

With binutils 2.26, RESERVE_BRK() causes a build failure:

  /tmp/ccnGOKZ5.s: Assembler messages:
  /tmp/ccnGOKZ5.s:98: Error: missing ')'
  /tmp/ccnGOKZ5.s:98: Error: missing ')'
  /tmp/ccnGOKZ5.s:98: Error: missing ')'
  /tmp/ccnGOKZ5.s:98: Error: junk at end of line, first unrecognized
  character is `U'

The problem is this line:

  RESERVE_BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE)

Specifically, the INIT_PGT_BUF_SIZE macro which (via PAGE_SIZE's use
_AC()) has a "1UL", which makes older versions of the assembler unhappy.
Unfortunately the _AC() macro doesn't work for inline asm.

Inline asm was only needed here to convince the toolchain to add the
STT_NOBITS flag.  However, if a C variable is placed in a section whose
name is prefixed with ".bss", GCC and Clang automatically set
STT_NOBITS.  In fact, ".bss..page_aligned" already relies on this trick.

So fix the build failure (and simplify the macro) by allocating the
variable in C.

Also, add NOLOAD to the ".brk" output section clause in the linker
script.  This is a failsafe in case the ".bss" prefix magic trick ever
stops working somehow.  If there's a section type mismatch, the GNU
linker will force the ".brk" output section to be STT_NOBITS.  The LLVM
linker will fail with a "section type mismatch" error.

Note this also changes the name of the variable from .brk.##name to
__brk_##name.  The variable names aren't actually used anywhere, so it's
harmless.

Fixes: a1e2c031ec39 ("x86/mm: Simplify RESERVE_BRK()")
Reported-by: Joe Damato <jdamato@fastly.com>
Reported-by: Byungchul Park <byungchul.park@lge.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Joe Damato <jdamato@fastly.com>
Link: https://lore.kernel.org/r/22d07a44c80d8e8e1e82b9a806ddc8c6bbb2606e.1654759036.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/setup.h  | 38 ++++++++++++++++++----------------
 arch/x86/kernel/setup.c       |  5 +----
 arch/x86/kernel/vmlinux.lds.S |  4 ++--
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 7590ac2..f8b9ee9 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -108,19 +108,16 @@ extern unsigned long _brk_end;
 void *extend_brk(size_t size, size_t align);
 
 /*
- * Reserve space in the brk section.  The name must be unique within the file,
- * and somewhat descriptive.  The size is in bytes.
+ * Reserve space in the .brk section, which is a block of memory from which the
+ * caller is allowed to allocate very early (before even memblock is available)
+ * by calling extend_brk().  All allocated memory will be eventually converted
+ * to memblock.  Any leftover unallocated memory will be freed.
  *
- * The allocation is done using inline asm (rather than using a section
- * attribute on a normal variable) in order to allow the use of @nobits, so
- * that it doesn't take up any space in the vmlinux file.
+ * The size is in bytes.
  */
-#define RESERVE_BRK(name, size)						\
-	asm(".pushsection .brk_reservation,\"aw\",@nobits\n\t"		\
-	    ".brk." #name ":\n\t"					\
-	    ".skip " __stringify(size) "\n\t"				\
-	    ".size .brk." #name ", " __stringify(size) "\n\t"		\
-	    ".popsection\n\t")
+#define RESERVE_BRK(name, size)					\
+	__section(".bss..brk") __aligned(1) __used	\
+	static char __brk_##name[size]
 
 extern void probe_roms(void);
 #ifdef __i386__
@@ -133,12 +130,19 @@ asmlinkage void __init x86_64_start_reservations(char *real_mode_data);
 
 #endif /* __i386__ */
 #endif /* _SETUP */
-#else
-#define RESERVE_BRK(name,sz)				\
-	.pushsection .brk_reservation,"aw",@nobits;	\
-.brk.name:						\
-1:	.skip sz;					\
-	.size .brk.name,.-1b;				\
+
+#else  /* __ASSEMBLY */
+
+.macro __RESERVE_BRK name, size
+	.pushsection .bss..brk, "aw"
+SYM_DATA_START(__brk_\name)
+	.skip \size
+SYM_DATA_END(__brk_\name)
 	.popsection
+.endm
+
+#define RESERVE_BRK(name, size) __RESERVE_BRK name, size
+
 #endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_X86_SETUP_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3ebb853..bd6c6fd 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -67,11 +67,6 @@ RESERVE_BRK(dmi_alloc, 65536);
 #endif
 
 
-/*
- * Range of the BSS area. The size of the BSS area is determined
- * at link time, with RESERVE_BRK() facility reserving additional
- * chunks.
- */
 unsigned long _brk_start = (unsigned long)__brk_base;
 unsigned long _brk_end   = (unsigned long)__brk_base;
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index f5f6dc2..81aba71 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -385,10 +385,10 @@ SECTIONS
 	__end_of_kernel_reserve = .;
 
 	. = ALIGN(PAGE_SIZE);
-	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
+	.brk (NOLOAD) : AT(ADDR(.brk) - LOAD_OFFSET) {
 		__brk_base = .;
 		. += 64 * 1024;		/* 64k alignment slop space */
-		*(.brk_reservation)	/* areas brk users have reserved */
+		*(.bss..brk)		/* areas brk users have reserved */
 		__brk_limit = .;
 	}
 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3025444A4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbiFIHSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiFIHSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:18:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEE153C42
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DA11B82C43
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6D2C34114;
        Thu,  9 Jun 2022 07:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654759090;
        bh=rFAOsO9s0TX2iCUq+2hV3AMeYVnpxuvz85chAYDHAOk=;
        h=From:To:Cc:Subject:Date:From;
        b=o8WTHj1HBUs6S4bBh7y919rSrCfhvHPoAN4pASyqBqjHaFQHr4+48JXpVhAYvw5yN
         8pax8q7L2zBU02Qpwos7jhs8Gr4zHBppWV7GbbNqgz6vZnZJ4coktK33wuj4eruRE/
         fqgXimLfdkFpPYdnYZWQfFfhSAJufc8p8KAvPY7EUUZVnpIx/HH6im8jSJA8h1uwKu
         23bIHbMs/356gXh3247xP8iW5FtpiwEs7oZ/QlHM6SO4gqZr0Zj+lYBy/u2JnXNWb5
         h0gqnrBsZj2NN6+WoHerMGliO8f2RHDOqn+P+Hm2nHpkV4bU5jMBGtfIZSGeNyl0T8
         e390BDoP8g4Zg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        jiangshanlai@gmail.com, bp@suse.de, brgerst@gmail.com,
        Joe Damato <jdamato@fastly.com>,
        Byungchul Park <byungchul.park@lge.com>
Subject: [PATCH v2] x86/mm: Fix RESERVE_BRK() for older binutils
Date:   Thu,  9 Jun 2022 00:17:32 -0700
Message-Id: <22d07a44c80d8e8e1e82b9a806ddc8c6bbb2606e.1654759036.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reported-by: Joe Damato <jdamato@fastly.com>
Reported-by: Byungchul Park <byungchul.park@lge.com>
Fixes: a1e2c031ec39 ("x86/mm: Simplify RESERVE_BRK()")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/setup.h  | 38 +++++++++++++++++++----------------
 arch/x86/kernel/setup.c       |  5 -----
 arch/x86/kernel/vmlinux.lds.S |  4 ++--
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 7590ac2570b9..f8b9ee97a891 100644
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
index 3ebb85327edb..bd6c6fd373ae 100644
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
index f5f6dc2e8007..81aba718ecd5 100644
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
 
-- 
2.34.3


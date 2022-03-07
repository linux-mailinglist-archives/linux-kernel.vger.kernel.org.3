Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683AF4CFD5A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiCGLty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239665AbiCGLrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:47:41 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A61673CD;
        Mon,  7 Mar 2022 03:46:44 -0800 (PST)
Received: from integral2.. (unknown [182.2.38.152])
        by gnuweeb.org (Postfix) with ESMTPSA id D480D7E6D2;
        Mon,  7 Mar 2022 11:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1646653604;
        bh=cM8WXBpiKTdqwwlj8vmfRUjFqLMuWyr1K0bI+bSKYbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BcvcreQDS/o9JJTPLLLhm0bQ0qBFBgphs+hexvFSwRsy48jyvstYvYBGknbHK2d4f
         kw/4q+WDyQdXmC2AaaeTL9FXzoCmYprPLW+qJkwCak5iAuzeVAvM+NSh9OLprrTNi+
         d5yXGoO0TtNMF4G+Meba8n7aIIqqsF8k1lfYf2iR/iVxqol3DUNkvS5AzHjhvpmU/M
         0oGRl71yJ5nXTAMd3XntOL8zvGVq1W3Y2gqMES7gc/KqUGfbaHzQG3qwfrVqTs0Gia
         RsagM3kbR7D4K6B4ZGiC73TPiVejLNwNdb3blYYqJOcHAOWRGy6l1ozrd2Uxf+o72x
         e7lcnVihFRBGw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gwml@vger.gnuweeb.org, x86@kernel.org
Subject: [PATCH v1 2/2] x86/lib: Avoid using INC and DEC instructions on hot paths
Date:   Mon,  7 Mar 2022 18:45:58 +0700
Message-Id: <20220307114558.1234494-3-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220307114558.1234494-1-ammarfaizi2@gnuweeb.org>
References: <20220307114558.1234494-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to take maximum advantage of out-of-order execution,
avoid using INC and DEC instructions when appropriate. INC/DEC
only writes to part of the flags register, which can cause a
partial flag register stall.

Agner Fog's optimization manual says [1]:
"""
  The INC and DEC instructions are inefficient on some CPUs because they
  write to only part of the flags register (excluding the carry flag).
  Use ADD or SUB instead to avoid false dependences or inefficient
  splitting of the flags register, especially if they are followed by
  an instruction that reads the flags.
"""

Intel's optimization manual 3.5.1.1 says [2]:
"""
  The INC and DEC instructions modify only a subset of the bits in the
  flag register. This creates a dependence on all previous writes of
  the flag register. This is especially problematic when these
  instructions are on the critical path because they are used to change
  an address for a load on which many other instructions depend.

  Assembly/Compiler Coding Rule 33. (M impact, H generality) INC and DEC
  instructions should be replaced with ADD or SUB instructions, because
  ADD and SUB overwrite all flags, whereas INC and DEC do not, therefore
  creating false dependencies on earlier instructions that set the flags.
"""

[1]: https://www.agner.org/optimize/optimizing_assembly.pdf
[2]: https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-optimization-manual.pdf

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 arch/x86/lib/copy_mc_64.S   | 14 +++++++-------
 arch/x86/lib/copy_user_64.S | 26 +++++++++++++-------------
 arch/x86/lib/memset_64.S    |  6 +++---
 arch/x86/lib/string_32.c    | 20 ++++++++++----------
 arch/x86/lib/strstr_32.c    |  4 ++--
 arch/x86/lib/usercopy_64.c  | 12 ++++++------
 6 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/x86/lib/copy_mc_64.S b/arch/x86/lib/copy_mc_64.S
index c859a8a09860..acd707ccd7f7 100644
--- a/arch/x86/lib/copy_mc_64.S
+++ b/arch/x86/lib/copy_mc_64.S
@@ -37,9 +37,9 @@ SYM_FUNC_START(copy_mc_fragile)
 	movb (%rsi), %al
 .L_write_leading_bytes:
 	movb %al, (%rdi)
-	incq %rsi
-	incq %rdi
-	decl %ecx
+	addq $1, %rsi
+	addq $1, %rdi
+	subl $1, %ecx
 	jnz .L_read_leading_bytes
 
 .L_8byte_aligned:
@@ -54,7 +54,7 @@ SYM_FUNC_START(copy_mc_fragile)
 	movq %r8, (%rdi)
 	addq $8, %rsi
 	addq $8, %rdi
-	decl %ecx
+	subl $1, %ecx
 	jnz .L_read_words
 
 	/* Any trailing bytes? */
@@ -68,9 +68,9 @@ SYM_FUNC_START(copy_mc_fragile)
 	movb (%rsi), %al
 .L_write_trailing_bytes:
 	movb %al, (%rdi)
-	incq %rsi
-	incq %rdi
-	decl %ecx
+	addq $1, %rsi
+	addq $1, %rdi
+	subl $1, %ecx
 	jnz .L_read_trailing_bytes
 
 	/* Copy successful. Return zero */
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 8ca5ecf16dc4..d17638ad4d2d 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -27,9 +27,9 @@
 	subl %ecx,%edx
 100:	movb (%rsi),%al
 101:	movb %al,(%rdi)
-	incq %rsi
-	incq %rdi
-	decl %ecx
+	addq $1,%rsi
+	addq $1,%rdi
+	subl $1,%ecx
 	jnz 100b
 102:
 
@@ -77,7 +77,7 @@ SYM_FUNC_START(copy_user_generic_unrolled)
 16:	movq %r11,7*8(%rdi)
 	leaq 64(%rsi),%rsi
 	leaq 64(%rdi),%rdi
-	decl %ecx
+	subl $1,%ecx
 	jnz 1b
 .L_copy_short_string:
 	movl %edx,%ecx
@@ -88,16 +88,16 @@ SYM_FUNC_START(copy_user_generic_unrolled)
 19:	movq %r8,(%rdi)
 	leaq 8(%rsi),%rsi
 	leaq 8(%rdi),%rdi
-	decl %ecx
+	subl $1,%ecx
 	jnz 18b
 20:	andl %edx,%edx
 	jz 23f
 	movl %edx,%ecx
 21:	movb (%rsi),%al
 22:	movb %al,(%rdi)
-	incq %rsi
-	incq %rdi
-	decl %ecx
+	addq $1,%rsi
+	addq $1,%rdi
+	subl $1,%ecx
 	jnz 21b
 23:	xor %eax,%eax
 	ASM_CLAC
@@ -288,7 +288,7 @@ SYM_FUNC_START(__copy_user_nocache)
 16:	movnti %r11,7*8(%rdi)
 	leaq 64(%rsi),%rsi
 	leaq 64(%rdi),%rdi
-	decl %ecx
+	subl $1,%ecx
 	jnz .L_4x8b_nocache_copy_loop
 
 	/* Set 8-byte copy count and remainder */
@@ -304,7 +304,7 @@ SYM_FUNC_START(__copy_user_nocache)
 21:	movnti %r8,(%rdi)
 	leaq 8(%rsi),%rsi
 	leaq 8(%rdi),%rdi
-	decl %ecx
+	subl $1,%ecx
 	jnz .L_8b_nocache_copy_loop
 
 	/* If no byte left, we're done */
@@ -339,9 +339,9 @@ SYM_FUNC_START(__copy_user_nocache)
 .L_1b_cache_copy_loop:
 40:	movb (%rsi),%al
 41:	movb %al,(%rdi)
-	incq %rsi
-	incq %rdi
-	decl %ecx
+	addq $1,%rsi
+	addq $1,%rdi
+	subl $1,%ecx
 	jnz .L_1b_cache_copy_loop
 
 	/* Finished copying; fence the prior stores */
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index d624f2bc42f1..844f9eef9355 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -86,7 +86,7 @@ SYM_FUNC_START_LOCAL(memset_orig)
 
 	.p2align 4
 .Lloop_64:
-	decq  %rcx
+	subq  $1,%rcx
 	movq  %rax,(%rdi)
 	movq  %rax,8(%rdi)
 	movq  %rax,16(%rdi)
@@ -108,7 +108,7 @@ SYM_FUNC_START_LOCAL(memset_orig)
 	shrl	$3,%ecx
 	.p2align 4
 .Lloop_8:
-	decl   %ecx
+	subl  $1,%ecx
 	movq  %rax,(%rdi)
 	leaq  8(%rdi),%rdi
 	jnz    .Lloop_8
@@ -118,7 +118,7 @@ SYM_FUNC_START_LOCAL(memset_orig)
 	jz      .Lende
 	.p2align 4
 .Lloop_1:
-	decl    %edx
+	subl    $1,%edx
 	movb 	%al,(%rdi)
 	leaq	1(%rdi),%rdi
 	jnz     .Lloop_1
diff --git a/arch/x86/lib/string_32.c b/arch/x86/lib/string_32.c
index 53b3f202267c..9075f89d41ff 100644
--- a/arch/x86/lib/string_32.c
+++ b/arch/x86/lib/string_32.c
@@ -34,7 +34,7 @@ EXPORT_SYMBOL(strcpy);
 char *strncpy(char *dest, const char *src, size_t count)
 {
 	int d0, d1, d2, d3;
-	asm volatile("1:\tdecl %2\n\t"
+	asm volatile("1:\tsubl $1,%2\n\t"
 		"js 2f\n\t"
 		"lodsb\n\t"
 		"stosb\n\t"
@@ -56,7 +56,7 @@ char *strcat(char *dest, const char *src)
 	int d0, d1, d2, d3;
 	asm volatile("repne\n\t"
 		"scasb\n\t"
-		"decl %1\n"
+		"subl $1,%1\n"
 		"1:\tlodsb\n\t"
 		"stosb\n\t"
 		"testb %%al,%%al\n\t"
@@ -74,9 +74,9 @@ char *strncat(char *dest, const char *src, size_t count)
 	int d0, d1, d2, d3;
 	asm volatile("repne\n\t"
 		"scasb\n\t"
-		"decl %1\n\t"
+		"subl $1,%1\n\t"
 		"movl %8,%3\n"
-		"1:\tdecl %3\n\t"
+		"1:\tsubl $1,%3\n\t"
 		"js 2f\n\t"
 		"lodsb\n\t"
 		"stosb\n\t"
@@ -120,7 +120,7 @@ int strncmp(const char *cs, const char *ct, size_t count)
 {
 	int res;
 	int d0, d1, d2;
-	asm volatile("1:\tdecl %3\n\t"
+	asm volatile("1:\tsubl $1,%3\n\t"
 		"js 2f\n\t"
 		"lodsb\n\t"
 		"scasb\n\t"
@@ -153,7 +153,7 @@ char *strchr(const char *s, int c)
 		"jne 1b\n\t"
 		"movl $1,%1\n"
 		"2:\tmovl %1,%0\n\t"
-		"decl %0"
+		"subl $1,%0"
 		: "=a" (res), "=&S" (d0)
 		: "1" (s), "0" (c)
 		: "memory");
@@ -188,7 +188,7 @@ void *memchr(const void *cs, int c, size_t count)
 		"scasb\n\t"
 		"je 1f\n\t"
 		"movl $1,%0\n"
-		"1:\tdecl %0"
+		"1:\tsubl $1,%0"
 		: "=D" (res), "=&c" (d0)
 		: "a" (c), "0" (cs), "1" (count)
 		: "memory");
@@ -204,7 +204,7 @@ void *memscan(void *addr, int c, size_t size)
 		return addr;
 	asm volatile("repnz; scasb\n\t"
 	    "jnz 1f\n\t"
-	    "dec %%edi\n"
+	    "subl $1,%%edi\n"
 	    "1:"
 	    : "=D" (addr), "=c" (size)
 	    : "0" (addr), "1" (size), "a" (c)
@@ -223,8 +223,8 @@ size_t strnlen(const char *s, size_t count)
 		"jmp 2f\n"
 		"1:\tcmpb $0,(%0)\n\t"
 		"je 3f\n\t"
-		"incl %0\n"
-		"2:\tdecl %1\n\t"
+		"addl $1,%0\n"
+		"2:\tsubl $1,%1\n\t"
 		"cmpl $-1,%1\n\t"
 		"jne 1b\n"
 		"3:\tsubl %2,%0"
diff --git a/arch/x86/lib/strstr_32.c b/arch/x86/lib/strstr_32.c
index 38f37df056f7..c9c02319e26e 100644
--- a/arch/x86/lib/strstr_32.c
+++ b/arch/x86/lib/strstr_32.c
@@ -11,7 +11,7 @@ __asm__ __volatile__(
 	"repne\n\t"
 	"scasb\n\t"
 	"notl %%ecx\n\t"
-	"decl %%ecx\n\t"	/* NOTE! This also sets Z if searchstring='' */
+	"subl $1,%%ecx\n\t"	/* NOTE! This also sets Z if searchstring='' */
 	"movl %%ecx,%%edx\n"
 	"1:\tmovl %6,%%edi\n\t"
 	"movl %%esi,%%eax\n\t"
@@ -20,7 +20,7 @@ __asm__ __volatile__(
 	"cmpsb\n\t"
 	"je 2f\n\t"		/* also works for empty string, see above */
 	"xchgl %%eax,%%esi\n\t"
-	"incl %%esi\n\t"
+	"addl $1,%%esi\n\t"
 	"cmpb $0,-1(%%eax)\n\t"
 	"jne 1b\n\t"
 	"xorl %%eax,%%eax\n\t"
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 0402a749f3a0..e3d60880f8c4 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -25,15 +25,15 @@ unsigned long __clear_user(void __user *addr, unsigned long size)
 		"	testq  %[size8],%[size8]\n"
 		"	jz     4f\n"
 		"	.align 16\n"
-		"0:	movq $0,(%[dst])\n"
+		"0:	movq   $0,(%[dst])\n"
 		"	addq   $8,%[dst]\n"
-		"	decl %%ecx ; jnz   0b\n"
-		"4:	movq  %[size1],%%rcx\n"
-		"	testl %%ecx,%%ecx\n"
+		"	subl   $1,%%ecx ; jnz   0b\n"
+		"4:	movq   %[size1],%%rcx\n"
+		"	testl  %%ecx,%%ecx\n"
 		"	jz     2f\n"
 		"1:	movb   $0,(%[dst])\n"
-		"	incq   %[dst]\n"
-		"	decl %%ecx ; jnz  1b\n"
+		"	addq   $1,%[dst]\n"
+		"	subl   $1,%%ecx ; jnz  1b\n"
 		"2:\n"
 
 		_ASM_EXTABLE_TYPE_REG(0b, 2b, EX_TYPE_UCOPY_LEN8, %[size1])
-- 
2.32.0


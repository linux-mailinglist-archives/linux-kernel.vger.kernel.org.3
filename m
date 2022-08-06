Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09FF58B5A1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 14:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiHFMuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 08:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiHFMuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:50:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE3BF30;
        Sat,  6 Aug 2022 05:50:13 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9875329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9875:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 304E61EC064A;
        Sat,  6 Aug 2022 14:50:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659790207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dSfW9DjfRnBmOy/yJy03r4akaufgvNDXLZbFPMukafI=;
        b=mHwcqxdeR+SE3OnYSgT5Ds6MHPg+/szSeo/ojplq74P86t0jxMZwnfQjjzbJH7ptj7VqSJ
        G8I3hNq4SnuadYMz8TOJZnnxVtSVm/Z+eS0X5UhUHOgqhlhu4u4mNw88K2AASZqw+79EhG
        KnhhTaVOhiVlJIWdw6XW/YR/Ga8YJ7A=
Date:   Sat, 6 Aug 2022 14:49:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Hemment <markhemm@googlemail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        patrice.chotard@foss.st.com, Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Hugh Dickins <hughd@google.com>, patches@lists.linux.dev,
        Linux-MM <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH -final] x86/clear_user: Make it faster
Message-ID: <Yu5jdu71z6WW5x58@zn.tnic>
References: <YozQZMyQ0NDdD8cH@zn.tnic>
 <YrMlVBoDxB21l/kD@zn.tnic>
 <CAHk-=wgmOfipHDvshwooTV81hMh6FHieSvhgGVWZMX8w+E-2DQ@mail.gmail.com>
 <YrN4DdR9HN0srNWe@zn.tnic>
 <CAHk-=wj_MeMUnKyRDuQTiU1OmQ=gfZVZhcD=G7Uma=1gkKkzxg@mail.gmail.com>
 <YrQ1PPB77PBWyaHs@zn.tnic>
 <YsRuUl24zkhpE3s/@zn.tnic>
 <YsVUvK/zQaIW749P@localhost.localdomain>
 <Ysv8cAa7wcDmQlpm@zn.tnic>
 <Ys1p27uWqjWlcaa1@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ys1p27uWqjWlcaa1@localhost.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 03:32:27PM +0300, Alexey Dobriyan wrote:
> I meant to say that earlyclobber is necessary only because the asm body
> is more than 1 instruction so there is possibility of writing to some
> outputs before all inputs are consumed.

Ok, thanks for clarifying. Below is a lightly tested version with the
earlyclobbers removed.

---
From 1587f56520fb9faa55ebb0cf02d69bdea0e40170 Mon Sep 17 00:00:00 2001
From: Borislav Petkov <bp@suse.de>
Date: Tue, 24 May 2022 11:01:18 +0200
Subject: [PATCH] x86/clear_user: Make it faster
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Based on a patch by Mark Hemment <markhemm@googlemail.com> and
incorporating very sane suggestions from Linus.

The point here is to have the default case with FSRM - which is supposed
to be the majority of x86 hw out there - if not now then soon - be
directly inlined into the instruction stream so that no function call
overhead is taking place.

Drop the early clobbers from the @size and @addr operands as those are
not needed anymore since we have single instruction alternatives.

The benchmarks I ran would show very small improvements and a PF
benchmark would even show weird things like slowdowns with higher core
counts.

So for a ~6m running the git test suite, the function gets called under
700K times, all from padzero():

  <...>-2536    [006] .....   261.208801: padzero: to: 0x55b0663ed214, size: 3564, cycles: 21900
  <...>-2536    [006] .....   261.208819: padzero: to: 0x7f061adca078, size: 3976, cycles: 17160
  <...>-2537    [008] .....   261.211027: padzero: to: 0x5572d019e240, size: 3520, cycles: 23850
  <...>-2537    [008] .....   261.211049: padzero: to: 0x7f1288dc9078, size: 3976, cycles: 15900
   ...

which is around 1%-ish of the total time and which is consistent with
the benchmark numbers.

So Mel gave me the idea to simply measure how fast the function becomes.
I.e.:

  start = rdtsc_ordered();
  ret = __clear_user(to, n);
  end = rdtsc_ordered();

Computing the mean average of all the samples collected during the test
suite run then shows some improvement:

  clear_user_original:
  Amean: 9219.71 (Sum: 6340154910, samples: 687674)

  fsrm:
  Amean: 8030.63 (Sum: 5522277720, samples: 687652)

That's on Zen3.

The situation looks a lot more confusing on Intel:

Icelake:

  clear_user_original:
  Amean: 19679.4 (Sum: 13652560764, samples: 693750)
  Amean: 19743.7 (Sum: 13693470604, samples: 693562)

(I ran it twice just to be sure.)

  ERMS:
  Amean: 20374.3 (Sum: 13910601024, samples: 682752)
  Amean: 20453.7 (Sum: 14186223606, samples: 693576)

  FSRM:
  Amean: 20458.2 (Sum: 13918381386, sample s: 680331)

The original microbenchmark which people were complaining about:

  for i in $(seq 1 10); do dd if=/dev/zero of=/dev/null bs=1M status=progress count=65536; done 2>&1 | grep copied
  32207011840 bytes (32 GB, 30 GiB) copied, 1 s, 32.2 GB/s
  68719476736 bytes (69 GB, 64 GiB) copied, 1.93069 s, 35.6 GB/s
  37597741056 bytes (38 GB, 35 GiB) copied, 1 s, 37.6 GB/s
  68719476736 bytes (69 GB, 64 GiB) copied, 1.78017 s, 38.6 GB/s
  62020124672 bytes (62 GB, 58 GiB) copied, 2 s, 31.0 GB/s
  68719476736 bytes (69 GB, 64 GiB) copied, 2.13716 s, 32.2 GB/s
  60010004480 bytes (60 GB, 56 GiB) copied, 1 s, 60.0 GB/s
  68719476736 bytes (69 GB, 64 GiB) copied, 1.14129 s, 60.2 GB/s
  53212086272 bytes (53 GB, 50 GiB) copied, 1 s, 53.2 GB/s
  68719476736 bytes (69 GB, 64 GiB) copied, 1.28398 s, 53.5 GB/s
  55698259968 bytes (56 GB, 52 GiB) copied, 1 s, 55.7 GB/s
  68719476736 bytes (69 GB, 64 GiB) copied, 1.22507 s, 56.1 GB/s
  55306092544 bytes (55 GB, 52 GiB) copied, 1 s, 55.3 GB/s
  68719476736 bytes (69 GB, 64 GiB) copied, 1.23647 s, 55.6 GB/s
  54387539968 bytes (54 GB, 51 GiB) copied, 1 s, 54.4 GB/s
  68719476736 bytes (69 GB, 64 GiB) copied, 1.25693 s, 54.7 GB/s
  50566529024 bytes (51 GB, 47 GiB) copied, 1 s, 50.6 GB/s
  68719476736 bytes (69 GB, 64 GiB) copied, 1.35096 s, 50.9 GB/s
  58308165632 bytes (58 GB, 54 GiB) copied, 1 s, 58.3 GB/s
  68719476736 bytes (69 GB, 64 GiB) copied, 1.17394 s, 58.5 GB/s

Now the same thing with smaller buffers:

  for i in $(seq 1 10); do dd if=/dev/zero of=/dev/null bs=1M status=progress count=8192; done 2>&1 | grep copied
  8589934592 bytes (8.6 GB, 8.0 GiB) copied, 0.28485 s, 30.2 GB/s
  8589934592 bytes (8.6 GB, 8.0 GiB) copied, 0.276112 s, 31.1 GB/s
  8589934592 bytes (8.6 GB, 8.0 GiB) copied, 0.29136 s, 29.5 GB/s
  8589934592 bytes (8.6 GB, 8.0 GiB) copied, 0.283803 s, 30.3 GB/s
  8589934592 bytes (8.6 GB, 8.0 GiB) copied, 0.306503 s, 28.0 GB/s
  8589934592 bytes (8.6 GB, 8.0 GiB) copied, 0.349169 s, 24.6 GB/s
  8589934592 bytes (8.6 GB, 8.0 GiB) copied, 0.276912 s, 31.0 GB/s
  8589934592 bytes (8.6 GB, 8.0 GiB) copied, 0.265356 s, 32.4 GB/s
  8589934592 bytes (8.6 GB, 8.0 GiB) copied, 0.28464 s, 30.2 GB/s
  8589934592 bytes (8.6 GB, 8.0 GiB) copied, 0.242998 s, 35.3 GB/s

is also not conclusive because it all depends on the buffer sizes,
their alignments and when the microcode detects that cachelines can be
aggregated properly and copied in bigger sizes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/CAHk-=wh=Mu_EYhtOmPn6AxoQZyEh-4fo2Zx3G7rBv1g7vwoKiw@mail.gmail.com
---
 arch/x86/include/asm/uaccess.h    |   5 +-
 arch/x86/include/asm/uaccess_64.h |  45 ++++++++++
 arch/x86/lib/clear_page_64.S      | 138 ++++++++++++++++++++++++++++++
 arch/x86/lib/usercopy_64.c        |  40 ---------
 tools/objtool/check.c             |   3 +
 5 files changed, 188 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 913e593a3b45..c46207946e05 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -502,9 +502,6 @@ strncpy_from_user(char *dst, const char __user *src, long count);
 
 extern __must_check long strnlen_user(const char __user *str, long n);
 
-unsigned long __must_check clear_user(void __user *mem, unsigned long len);
-unsigned long __must_check __clear_user(void __user *mem, unsigned long len);
-
 #ifdef CONFIG_ARCH_HAS_COPY_MC
 unsigned long __must_check
 copy_mc_to_kernel(void *to, const void *from, unsigned len);
@@ -526,6 +523,8 @@ extern struct movsl_mask {
 #define ARCH_HAS_NOCACHE_UACCESS 1
 
 #ifdef CONFIG_X86_32
+unsigned long __must_check clear_user(void __user *mem, unsigned long len);
+unsigned long __must_check __clear_user(void __user *mem, unsigned long len);
 # include <asm/uaccess_32.h>
 #else
 # include <asm/uaccess_64.h>
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 45697e04d771..d13d71af5cf6 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -79,4 +79,49 @@ __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
 	kasan_check_write(dst, size);
 	return __copy_user_flushcache(dst, src, size);
 }
+
+/*
+ * Zero Userspace.
+ */
+
+__must_check unsigned long
+clear_user_original(void __user *addr, unsigned long len);
+__must_check unsigned long
+clear_user_rep_good(void __user *addr, unsigned long len);
+__must_check unsigned long
+clear_user_erms(void __user *addr, unsigned long len);
+
+static __always_inline __must_check unsigned long __clear_user(void __user *addr, unsigned long size)
+{
+	might_fault();
+	stac();
+
+	/*
+	 * No memory constraint because it doesn't change any memory gcc
+	 * knows about.
+	 */
+	asm volatile(
+		"1:\n\t"
+		ALTERNATIVE_3("rep stosb",
+			      "call clear_user_erms",	  ALT_NOT(X86_FEATURE_FSRM),
+			      "call clear_user_rep_good", ALT_NOT(X86_FEATURE_ERMS),
+			      "call clear_user_original", ALT_NOT(X86_FEATURE_REP_GOOD))
+		"2:\n"
+	       _ASM_EXTABLE_UA(1b, 2b)
+	       : "+c" (size), "+D" (addr), ASM_CALL_CONSTRAINT
+	       : "a" (0)
+		/* rep_good clobbers %rdx */
+	       : "rdx");
+
+	clac();
+
+	return size;
+}
+
+static __always_inline unsigned long clear_user(void __user *to, unsigned long n)
+{
+	if (access_ok(to, n))
+		return __clear_user(to, n);
+	return n;
+}
 #endif /* _ASM_X86_UACCESS_64_H */
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index fe59b8ac4fcc..ecbfb4dd3b01 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 #include <linux/linkage.h>
+#include <asm/asm.h>
 #include <asm/export.h>
 
 /*
@@ -50,3 +51,140 @@ SYM_FUNC_START(clear_page_erms)
 	RET
 SYM_FUNC_END(clear_page_erms)
 EXPORT_SYMBOL_GPL(clear_page_erms)
+
+/*
+ * Default clear user-space.
+ * Input:
+ * rdi destination
+ * rcx count
+ *
+ * Output:
+ * rcx: uncleared bytes or 0 if successful.
+ */
+SYM_FUNC_START(clear_user_original)
+	/*
+	 * Copy only the lower 32 bits of size as that is enough to handle the rest bytes,
+	 * i.e., no need for a 'q' suffix and thus a REX prefix.
+	 */
+	mov %ecx,%eax
+	shr $3,%rcx
+	jz .Lrest_bytes
+
+	# do the qwords first
+	.p2align 4
+.Lqwords:
+	movq $0,(%rdi)
+	lea 8(%rdi),%rdi
+	dec %rcx
+	jnz .Lqwords
+
+.Lrest_bytes:
+	and $7,  %eax
+	jz .Lexit
+
+	# now do the rest bytes
+.Lbytes:
+	movb $0,(%rdi)
+	inc %rdi
+	dec %eax
+	jnz .Lbytes
+
+.Lexit:
+	/*
+	 * %rax still needs to be cleared in the exception case because this function is called
+	 * from inline asm and the compiler expects %rax to be zero when exiting the inline asm,
+	 * in case it might reuse it somewhere.
+	 */
+        xor %eax,%eax
+        RET
+
+.Lqwords_exception:
+        # convert remaining qwords back into bytes to return to caller
+        shl $3, %rcx
+        and $7, %eax
+        add %rax,%rcx
+        jmp .Lexit
+
+.Lbytes_exception:
+        mov %eax,%ecx
+        jmp .Lexit
+
+        _ASM_EXTABLE_UA(.Lqwords, .Lqwords_exception)
+        _ASM_EXTABLE_UA(.Lbytes, .Lbytes_exception)
+SYM_FUNC_END(clear_user_original)
+EXPORT_SYMBOL(clear_user_original)
+
+/*
+ * Alternative clear user-space when CPU feature X86_FEATURE_REP_GOOD is
+ * present.
+ * Input:
+ * rdi destination
+ * rcx count
+ *
+ * Output:
+ * rcx: uncleared bytes or 0 if successful.
+ */
+SYM_FUNC_START(clear_user_rep_good)
+	# call the original thing for less than a cacheline
+	cmp $64, %rcx
+	jb clear_user_original
+
+.Lprep:
+	# copy lower 32-bits for rest bytes
+	mov %ecx, %edx
+	shr $3, %rcx
+	jz .Lrep_good_rest_bytes
+
+.Lrep_good_qwords:
+	rep stosq
+
+.Lrep_good_rest_bytes:
+	and $7, %edx
+	jz .Lrep_good_exit
+
+.Lrep_good_bytes:
+	mov %edx, %ecx
+	rep stosb
+
+.Lrep_good_exit:
+	# see .Lexit comment above
+	xor %eax, %eax
+	RET
+
+.Lrep_good_qwords_exception:
+	# convert remaining qwords back into bytes to return to caller
+	shl $3, %rcx
+	and $7, %edx
+	add %rdx, %rcx
+	jmp .Lrep_good_exit
+
+	_ASM_EXTABLE_UA(.Lrep_good_qwords, .Lrep_good_qwords_exception)
+	_ASM_EXTABLE_UA(.Lrep_good_bytes, .Lrep_good_exit)
+SYM_FUNC_END(clear_user_rep_good)
+EXPORT_SYMBOL(clear_user_rep_good)
+
+/*
+ * Alternative clear user-space when CPU feature X86_FEATURE_ERMS is present.
+ * Input:
+ * rdi destination
+ * rcx count
+ *
+ * Output:
+ * rcx: uncleared bytes or 0 if successful.
+ *
+ */
+SYM_FUNC_START(clear_user_erms)
+	# call the original thing for less than a cacheline
+	cmp $64, %rcx
+	jb clear_user_original
+
+.Lerms_bytes:
+	rep stosb
+
+.Lerms_exit:
+	xorl %eax,%eax
+	RET
+
+	_ASM_EXTABLE_UA(.Lerms_bytes, .Lerms_exit)
+SYM_FUNC_END(clear_user_erms)
+EXPORT_SYMBOL(clear_user_erms)
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 0ae6cf804197..6c1f8ac5e721 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -14,46 +14,6 @@
  * Zero Userspace
  */
 
-unsigned long __clear_user(void __user *addr, unsigned long size)
-{
-	long __d0;
-	might_fault();
-	/* no memory constraint because it doesn't change any memory gcc knows
-	   about */
-	stac();
-	asm volatile(
-		"	testq  %[size8],%[size8]\n"
-		"	jz     4f\n"
-		"	.align 16\n"
-		"0:	movq $0,(%[dst])\n"
-		"	addq   $8,%[dst]\n"
-		"	decl %%ecx ; jnz   0b\n"
-		"4:	movq  %[size1],%%rcx\n"
-		"	testl %%ecx,%%ecx\n"
-		"	jz     2f\n"
-		"1:	movb   $0,(%[dst])\n"
-		"	incq   %[dst]\n"
-		"	decl %%ecx ; jnz  1b\n"
-		"2:\n"
-
-		_ASM_EXTABLE_TYPE_REG(0b, 2b, EX_TYPE_UCOPY_LEN8, %[size1])
-		_ASM_EXTABLE_UA(1b, 2b)
-
-		: [size8] "=&c"(size), [dst] "=&D" (__d0)
-		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr));
-	clac();
-	return size;
-}
-EXPORT_SYMBOL(__clear_user);
-
-unsigned long clear_user(void __user *to, unsigned long n)
-{
-	if (access_ok(to, n))
-		return __clear_user(to, n);
-	return n;
-}
-EXPORT_SYMBOL(clear_user);
-
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 /**
  * clean_cache_range - write back a cache range with CLWB
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0cec74da7ffe..4b2e11726f4e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1071,6 +1071,9 @@ static const char *uaccess_safe_builtin[] = {
 	"copy_mc_fragile_handle_tail",
 	"copy_mc_enhanced_fast_string",
 	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
+	"clear_user_erms",
+	"clear_user_rep_good",
+	"clear_user_original",
 	NULL
 };
 
-- 
2.35.1


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

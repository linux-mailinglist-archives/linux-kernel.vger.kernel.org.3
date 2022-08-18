Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E9D59819F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244131AbiHRKoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbiHRKoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:44:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31275816A4;
        Thu, 18 Aug 2022 03:44:43 -0700 (PDT)
Date:   Thu, 18 Aug 2022 10:44:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660819475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dJmeIDCedVBquH3rdX3NnhaAOxSoPshSB412WcASuT8=;
        b=bKHLWW4zcPC8hmNzd0516DKW15Djjd+jG9ZaWJvEU31aMvrsARUleyckr0+hy58izniiB5
        7QEu1dsacEiZS50n7xqrbKXB6io8+7GFttNJjrX/5BlcKGyf4Rh+O2d56YD29s0lZXY1Fi
        hzNUIR9PWLOEE6Ca4++LgbsG+dXxICmtTsmxXbPDxJMCaTSHp2S16v2JjqMxAlp9I1yQVK
        qqWlTM6rGWWYO6L5Qyi7N+q02n+JWFAch8zrFDriXK9aRucB6mCOn2loB5cnaNtHMWEogT
        +mNB2YiZB0saUflTGPcuNw3d/mkW8/5VqlIXYKZsCA9Q7KnX7T9jO/ptsW/Upg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660819475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dJmeIDCedVBquH3rdX3NnhaAOxSoPshSB412WcASuT8=;
        b=Rq8nkfyxDlKM9ZfiPZoDKVdJYKDn4Doz6nyE9+mrefX2nsKByfU+/cDRZe39pIZmaapIvI
        kzoo0wHLOaCUQgAw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/clear_user: Make it faster
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <CAHk-=wh=Mu_EYhtOmPn6AxoQZyEh-4fo2Zx3G7rBv1g7vwoKiw@mail.gmail.com>
References: <CAHk-=wh=Mu_EYhtOmPn6AxoQZyEh-4fo2Zx3G7rBv1g7vwoKiw@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <166081947386.401.14801058237866363507.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0db7058e8e23e6bbab1b4747ecabd1784c34f50b
Gitweb:        https://git.kernel.org/tip/0db7058e8e23e6bbab1b4747ecabd1784c3=
4f50b
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 24 May 2022 11:01:18 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Aug 2022 12:36:42 +02:00

x86/clear_user: Make it faster

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

  <...>-2536    [006] .....   261.208801: padzero: to: 0x55b0663ed214, size: =
3564, cycles: 21900
  <...>-2536    [006] .....   261.208819: padzero: to: 0x7f061adca078, size: =
3976, cycles: 17160
  <...>-2537    [008] .....   261.211027: padzero: to: 0x5572d019e240, size: =
3520, cycles: 23850
  <...>-2537    [008] .....   261.211049: padzero: to: 0x7f1288dc9078, size: =
3976, cycles: 15900
   ...

which is around 1%-ish of the total time and which is consistent with
the benchmark numbers.

So Mel gave me the idea to simply measure how fast the function becomes.
I.e.:

  start =3D rdtsc_ordered();
  ret =3D __clear_user(to, n);
  end =3D rdtsc_ordered();

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
  Amean: 20458.2 (Sum: 13918381386, sample=C2=A0s: 680331)

The original microbenchmark which people were complaining about:

  for i in $(seq 1 10); do dd if=3D/dev/zero of=3D/dev/null bs=3D1M status=3D=
progress count=3D65536; done 2>&1 | grep copied
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

  for i in $(seq 1 10); do dd if=3D/dev/zero of=3D/dev/null bs=3D1M status=3D=
progress count=3D8192; done 2>&1 | grep copied
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
Link: https://lore.kernel.org/r/CAHk-=3Dwh=3DMu_EYhtOmPn6AxoQZyEh-4fo2Zx3G7rB=
v1g7vwoKiw@mail.gmail.com
---
 arch/x86/include/asm/uaccess.h    |   5 +-
 arch/x86/include/asm/uaccess_64.h |  45 +++++++++-
 arch/x86/lib/clear_page_64.S      | 138 +++++++++++++++++++++++++++++-
 arch/x86/lib/usercopy_64.c        |  40 +--------
 tools/objtool/check.c             |   3 +-
 5 files changed, 188 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 913e593..c462079 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -502,9 +502,6 @@ strncpy_from_user(char *dst, const char __user *src, long=
 count);
=20
 extern __must_check long strnlen_user(const char __user *str, long n);
=20
-unsigned long __must_check clear_user(void __user *mem, unsigned long len);
-unsigned long __must_check __clear_user(void __user *mem, unsigned long len);
-
 #ifdef CONFIG_ARCH_HAS_COPY_MC
 unsigned long __must_check
 copy_mc_to_kernel(void *to, const void *from, unsigned len);
@@ -526,6 +523,8 @@ extern struct movsl_mask {
 #define ARCH_HAS_NOCACHE_UACCESS 1
=20
 #ifdef CONFIG_X86_32
+unsigned long __must_check clear_user(void __user *mem, unsigned long len);
+unsigned long __must_check __clear_user(void __user *mem, unsigned long len);
 # include <asm/uaccess_32.h>
 #else
 # include <asm/uaccess_64.h>
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess=
_64.h
index 45697e0..d13d71a 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -79,4 +79,49 @@ __copy_from_user_flushcache(void *dst, const void __user *=
src, unsigned size)
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
+static __always_inline __must_check unsigned long __clear_user(void __user *=
addr, unsigned long size)
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
+static __always_inline unsigned long clear_user(void __user *to, unsigned lo=
ng n)
+{
+	if (access_ok(to, n))
+		return __clear_user(to, n);
+	return n;
+}
 #endif /* _ASM_X86_UACCESS_64_H */
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index fe59b8a..ecbfb4d 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 #include <linux/linkage.h>
+#include <asm/asm.h>
 #include <asm/export.h>
=20
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
+	 * Copy only the lower 32 bits of size as that is enough to handle the rest=
 bytes,
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
+	 * %rax still needs to be cleared in the exception case because this functi=
on is called
+	 * from inline asm and the compiler expects %rax to be zero when exiting th=
e inline asm,
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
index 0ae6cf8..6c1f8ac 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -14,46 +14,6 @@
  * Zero Userspace
  */
=20
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
-		: [size8] "=3D&c"(size), [dst] "=3D&D" (__d0)
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
index 0cec74d..4b2e117 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1071,6 +1071,9 @@ static const char *uaccess_safe_builtin[] =3D {
 	"copy_mc_fragile_handle_tail",
 	"copy_mc_enhanced_fast_string",
 	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
+	"clear_user_erms",
+	"clear_user_rep_good",
+	"clear_user_original",
 	NULL
 };
=20

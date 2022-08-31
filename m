Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F725A7845
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiHaH6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiHaH61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:58:27 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55FC75FF9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:58:22 -0700 (PDT)
Received: from YC20090004.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.orange.fr with ESMTPA
        id TIbgoo5DzXFXxTIc2ogpKK; Wed, 31 Aug 2022 09:58:20 +0200
X-ME-Helo: YC20090004.ad.ts.tri-ad.global
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 31 Aug 2022 09:58:20 +0200
X-ME-IP: 103.175.111.222
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v6 1/2] x86/asm/bitops: ffs: use __builtin_ffs to evaluate constant expressions
Date:   Wed, 31 Aug 2022 16:57:41 +0900
Message-Id: <20220831075742.295-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831075742.295-1-mailhol.vincent@wanadoo.fr>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220831075742.295-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x86_64, the current ffs() implementation does not produce
optimized code when called with a constant expression. On the
contrary, the __builtin_ffs() function of both GCC and clang is able
to fold the expression into a single instruction.

** Example **

Let's consider two dummy functions foo() and bar() as below:

  #include <linux/bitops.h>
  #define CONST 0x01000000

  unsigned int foo(void)
  {
  	return ffs(CONST);
  }

  unsigned int bar(void)
  {
  	return __builtin_ffs(CONST);
  }

GCC would produce below assembly code:

  0000000000000000 <foo>:
     0:	ba 00 00 00 01       	mov    $0x1000000,%edx
     5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a:	0f bc c2             	bsf    %edx,%eax
     d:	83 c0 01             	add    $0x1,%eax
    10:	c3                   	ret
  <Instructions after ret and before next function were redacted>

  0000000000000020 <bar>:
    20:	b8 19 00 00 00       	mov    $0x19,%eax
    25:	c3                   	ret

And clang would produce:

  0000000000000000 <foo>:
     0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     5:	0f bc 05 00 00 00 00 	bsf    0x0(%rip),%eax        # c <foo+0xc>
     c:	83 c0 01             	add    $0x1,%eax
     f:	c3                   	ret

  0000000000000010 <bar>:
    10:	b8 19 00 00 00       	mov    $0x19,%eax
    15:	c3                   	ret

Both examples clearly demonstrate the benefit of using __builtin_ffs()
instead of the kernel's asm implementation for constant expressions.

However, for non constant expressions, the ffs() asm version of the
kernel remains better for x86_64 because, contrary to GCC, it doesn't
emit the CMOV assembly instruction, c.f. [1] (noticeably, clang is
able optimize out the CMOV call).

Use __builtin_constant_p() to select between the kernel's ffs() and
the __builtin_ffs() depending on whether the argument is constant or
not.

As a side benefit, replacing the ffs() function declaration by a macro
also removes below -Wshadow warning:

  ./arch/x86/include/asm/bitops.h:283:28: warning: declaration of 'ffs' shadows a built-in function [-Wshadow]
    283 | static __always_inline int ffs(int x)

** Statistics **

On a allyesconfig, before...:

  $ objdump -d vmlinux.o | grep bsf | wc -l
  1081

...and after:

  $ objdump -d vmlinux.o | grep bsf | wc -l
  792

So, roughly 26.7% of the calls to ffs() were using constant
expressions and could be optimized out.

(tests done on linux v5.18-rc5 x86_64 using GCC 11.2.1)

[1] commit ca3d30cc02f7 ("x86_64, asm: Optimise fls(), ffs() and fls64()")
Link: http://lkml.kernel.org/r/20111213145654.14362.39868.stgit@warthog.procyon.org.uk

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 arch/x86/include/asm/bitops.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index a288ecd230ab..6ed979547086 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -269,18 +269,7 @@ static __always_inline unsigned long __fls(unsigned long word)
 #undef ADDR
 
 #ifdef __KERNEL__
-/**
- * ffs - find first set bit in word
- * @x: the word to search
- *
- * This is defined the same way as the libc and compiler builtin ffs
- * routines, therefore differs in spirit from the other bitops.
- *
- * ffs(value) returns 0 if value is 0 or the position of the first
- * set bit if value is nonzero. The first (least significant) bit
- * is at position 1.
- */
-static __always_inline int ffs(int x)
+static __always_inline int variable_ffs(int x)
 {
 	int r;
 
@@ -310,6 +299,19 @@ static __always_inline int ffs(int x)
 	return r + 1;
 }
 
+/**
+ * ffs - find first set bit in word
+ * @x: the word to search
+ *
+ * This is defined the same way as the libc and compiler builtin ffs
+ * routines, therefore differs in spirit from the other bitops.
+ *
+ * ffs(value) returns 0 if value is 0 or the position of the first
+ * set bit if value is nonzero. The first (least significant) bit
+ * is at position 1.
+ */
+#define ffs(x) (__builtin_constant_p(x) ? __builtin_ffs(x) : variable_ffs(x))
+
 /**
  * fls - find last set bit in word
  * @x: the word to search
-- 
2.35.1


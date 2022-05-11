Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70A2523803
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344240AbiEKQEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344229AbiEKQD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:03:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484CE19B3AF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:03:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e24so2664297pjt.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vuLyis0cozB0HH3xDqQBXVh/FgY1uFVWgKAFWAeIWvM=;
        b=hhVPLl9jZ2ypnIaMCtBrwRQ4MD1YdrdEuYR/XyRJ2cz2URMLWcQbvVOHcAcJIUDqqh
         KlYavh4iDSxiPIVuLaGm7hExlyARUyFBGfw+LZROEaSo4UoNF7xEEmJl5dehfx8+octD
         OM+wh/70MPIZcCZ+wobJd+lCCLG5SWsICcfjp9jXT9fDNrzTrAAUEc9aZhScirSFlh7b
         U+0DvC6+FowLArpf4ER7XRHbllK+2yvfz+FcDoZL28yndF6a1i+BSJ7ButQUPGpbs2Ug
         lDsne26hSlf9dzvCaj+qVPa5QBZCLpW01k4xxvpTBhh3GB/ac7IaC2nEl41WTL19aLZG
         YWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vuLyis0cozB0HH3xDqQBXVh/FgY1uFVWgKAFWAeIWvM=;
        b=ColCrIhBAjuLrqrzM70PWkLBXvjWiG63+SCw2LZGbj4Sby69skc8Ag0ZI5QaQfBwXU
         uKaNbpXtUxYqlVWnadwcQYQUs6paP8S8D2KAbE/7fMKerd7w8Dy9jtSQs3qwcCsUo/Tj
         z0u+WKk9CoZqIGuXdxDMkOFHobPp4sOEia1yrTMU5KUpIz46gdkzA7cVvKdXNyKVlXQ5
         Yj25Auhll82BtZsHPvutalFlDvOa0vPtoibenbYH5H7x/JKKiXITu1OLO9T1+DZIWySW
         ysXvX7WJTPYvFbJpWs8iU78HAmEYK138HDPY1SJ3ajK+MpiyB9hOHDcyTB6ErY4GKwMp
         v0ow==
X-Gm-Message-State: AOAM531BIjDvnYRx8IR4SWevPnWktcKo+g6OzJ3JkIKGmOsRw4+/XRBw
        ClphRRsrbYh8BoGQKGwLOoM=
X-Google-Smtp-Source: ABdhPJxWqrFU+wrf1f3fcmudbr5H+AxqToGCpCuwHOM5wSjMkxBiclhBPlICHx+V9Z0uhmMF3z6nRA==
X-Received: by 2002:a17:903:189:b0:15e:9584:fbe7 with SMTP id z9-20020a170903018900b0015e9584fbe7mr26565542plg.65.1652285035170;
        Wed, 11 May 2022 09:03:55 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w11-20020a63c10b000000b003c14af50624sm42825pgf.60.2022.05.11.09.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:03:54 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 1/2] x86/asm/bitops: ffs: use __builtin_ffs to evaluate constant expressions
Date:   Thu, 12 May 2022 01:03:18 +0900
Message-Id: <20220511160319.1045812-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x86_64, the current ffs() implementation does not produce
optimized code when called with a constant expression. On the
contrary, the __builtin_ffs() function of both GCC and clang is able
to simplify the expression into a single instruction.

* Example *

Let's consider two dummy functions foo() and bar() as below:

| #include <linux/bitops.h>
| #define CONST 0x01000000
|
| unsigned int foo(void)
| {
| 	return ffs(CONST);
| }
|
| unsigned int bar(void)
| {
| 	return __builtin_ffs(CONST);
| }

GCC would produce below assembly code:

| 0000000000000000 <foo>:
|    0:	ba 00 00 00 01       	mov    $0x1000000,%edx
|    5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
|    a:	0f bc c2             	bsf    %edx,%eax
|    d:	83 c0 01             	add    $0x1,%eax
|   10:	c3                   	ret
|   11:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
|   18:	00 00 00 00
|   1c:	0f 1f 40 00          	nopl   0x0(%rax)
|
| 0000000000000020 <bar>:
|   20:	b8 19 00 00 00       	mov    $0x19,%eax
|   25:	c3                   	ret

And clang would produce:

| 0000000000000000 <foo>:
|    0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
|    5:	0f bc 05 00 00 00 00 	bsf    0x0(%rip),%eax        # c <foo+0xc>
|    c:	83 c0 01             	add    $0x1,%eax
|    f:	c3                   	ret
|
| 0000000000000010 <bar>:
|   10:	b8 19 00 00 00       	mov    $0x19,%eax
|   15:	c3                   	ret

For both example, we clearly see the benefit of using __builtin_ffs()
instead of the kernel's asm implementation for constant
expressions.

However, for non constant expressions, the ffs() asm version of the
kernel remains better for x86_64 because, contrary to GCC, it doesn't
emit the CMOV assembly instruction, c.f. [1] (noticeably, clang is
able optimize out the CMOV call).

This patch uses the __builtin_constant_p() to select between the
kernel's ffs() and the __builtin_ffs() depending on whether the
argument is constant or not.

As a side benefit, this patch also removes below -Wshadow warning:

| ./arch/x86/include/asm/bitops.h:283:28: warning: declaration of 'ffs' shadows a built-in function [-Wshadow]
|   283 | static __always_inline int ffs(int x)

** Statistics **

On a allyesconfig, before applying this patch...:

| $ objdump -d vmlinux.o | grep bsf | wc -l
| 3607

...and after:

| $ objdump -d vmlinux.o | grep bsf | wc -l
| 792

So, roughly 26.7% of the call to ffs() were using constant expression
and were optimized out.

(tests done on linux v5.18-rc5 x86_64 using GCC 11.2.1)

[1] commit ca3d30cc02f7 ("x86_64, asm: Optimise fls(), ffs() and fls64()")
http://lkml.kernel.org/r/20111213145654.14362.39868.stgit@warthog.procyon.org.uk

CC: Nick Desaulniers <ndesaulniers@google.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571B8521D64
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbiEJPEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345281AbiEJPDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:03:15 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01981F8C4E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:26:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 15so14774213pgf.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+wxOYG9ghH/9a5UJTVaKlcRNHbqfracDkNPfmduVwBo=;
        b=k9+PjtptzZEnQKChCLzYZbzQWE1mIn4uv/pIHXhTfxtWMVh6eoOGw/gxJ18YqLkHgF
         OcXq0HcCsygqny/0P5I3xfRlLYnC/4i1d1MdP4jQ0vEvkcxdDC5MpVNhl95F7ySjfy++
         fLE85uau3pjLVWJphwgCt99DKyeOVnAFy6GKh9mjGuCTONQWTu12tHjPIXMl7xGxBAhk
         eXPIDnyz5ieePPSibI/A7Froy8CR3JKh35KviAiQ2gOHcyQICY4x01MUFHy/lUZEMyLi
         tlcuOx6E23i7gvDFTKtngwvPvWakQp29Rhr3LB+zZxrksse5AKghVr26S1IS5y73jY4U
         FVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+wxOYG9ghH/9a5UJTVaKlcRNHbqfracDkNPfmduVwBo=;
        b=VtxkF9ZNaFP9+owfnkAIj97+7ZCYADMZ45fJK9QwiC7qPJdfm4jXiQky7ncDp7Mx3n
         hrgp3GvkI6mo3DbGTfR+gctVdKYisF/UHckfy3gKmfm6m3t4LenzufEYdI2uizJISw0g
         5wyQF1DyA1Edm6HuN42HwBPpbTovTkiSFcmqiayLIriSkP6RnPpIObZtjsrF0ET44IJG
         DzR9699TQDqLd0atiGRlI6lzmeOj7snUazOBU/rV+m+px79r/wqlBeb8C43+JXHHkk3B
         6Gsao/1j/+TBvSgAuop5I2CtsbttEQu70nBKoqtSVAyry16XKP7EzxiWmwhJbQX6FT7a
         URVQ==
X-Gm-Message-State: AOAM532JKGgsy0PGNpuU77do7D/iyKHatdSsN4Cr/u5nkCHMeHmHP/Dr
        BGlJsjkXOR3ZOgP5OuIQ3ybGIrxFrNA8b23H
X-Google-Smtp-Source: ABdhPJwxuyIepWDfdgGxfWUw3KHfu67KyVM092PCotq6edwFAS2ONUMYFyz/fJPf5o8NsvRd8efdTA==
X-Received: by 2002:a05:6a00:ac1:b0:4f1:29e4:b3a1 with SMTP id c1-20020a056a000ac100b004f129e4b3a1mr20596239pfl.63.1652192790629;
        Tue, 10 May 2022 07:26:30 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709028eca00b0015ea8b4b8f3sm2057568plo.263.2022.05.10.07.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 07:26:30 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 1/2] x86/asm/bitops: ffs: use __builtin_ffs to evaluate constant expressions
Date:   Tue, 10 May 2022 23:25:49 +0900
Message-Id: <20220510142550.1686866-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510142550.1686866-1-mailhol.vincent@wanadoo.fr>
References: <20220510142550.1686866-1-mailhol.vincent@wanadoo.fr>
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
|    0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
|    5:	0f bc c7             	bsf    %edi,%eax
|    8:	83 c0 01             	add    $0x1,%eax
|    b:	c3                   	ret
|    c:	0f 1f 40 00          	nopl   0x0(%rax)
|
| 0000000000000010 <bar>:
|   10:	b8 19 00 00 00       	mov    $0x19,%eax
|   15:	c3                   	ret

And clang would produce:

| 0000000000000000 <foo>:
|    0:	55                   	push   %rbp
|    1:	48 89 e5             	mov    %rsp,%rbp
|    4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
|    9:	0f bc 05 00 00 00 00 	bsf    0x0(%rip),%eax        # 10 <foo+0x10>
|   10:	ff c0                	inc    %eax
|   12:	5d                   	pop    %rbp
|   13:	c3                   	ret
|   14:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
|   1b:	00 00 00
|   1e:	66 90                	xchg   %ax,%ax
|
| 0000000000000020 <bar>:
|   20:	55                   	push   %rbp
|   21:	48 89 e5             	mov    %rsp,%rbp
|   24:	b8 19 00 00 00       	mov    $0x19,%eax
|   29:	5d                   	pop    %rbp
|   2a:	c3                   	ret

For both examples, we clearly see the benefit of using __builtin_ffs()
instead of the kernel's asm implementation for constant expressions.

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

[1] commit ca3d30cc02f7 ("x86_64, asm: Optimise fls(), ffs() and fls64()")
http://lkml.kernel.org/r/20111213145654.14362.39868.stgit@warthog.procyon.org.uk


Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 arch/x86/include/asm/bitops.h | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index a288ecd230ab..535a7a358c14 100644
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
+static __always_inline int __ffs_asm(int x)
 {
 	int r;
 
@@ -310,6 +299,22 @@ static __always_inline int ffs(int x)
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
+#define ffs(x)					\
+	 (__builtin_constant_p(x) ?		\
+	  __builtin_ffs(x) :			\
+	  __ffs_asm(x))
+
 /**
  * fls - find last set bit in word
  * @x: the word to search
-- 
2.35.1


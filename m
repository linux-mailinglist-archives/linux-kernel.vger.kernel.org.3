Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC075524152
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349536AbiELAEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349526AbiELAEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:04:16 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644E579806
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:04:14 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m12so3364798plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJV9qCkaOxpO84xo6ebk43WZP210trdb6TDi7Y9RbbU=;
        b=cYDsj7gf4wAZNvatYUNPaypENVCUXAVHkGpYkETxpTFfEoUlTCFjPivD76VDqlg7hi
         eJasiUp+bH4A3bDHDpkLJBURCA5EdgZQunSULBqYNhBaZJFFsA+7AEO8wCZt2IQTW86T
         ub3XmPJAe1HX54hf3rcI7T/AoDIq+S1nc+aJr5OSQx+/1hv2C8VXuS4/kFtLIyBb/Ns5
         LzO3i9GshcitFY2NK/BEcdRRP9nJjd3dEpQqeuF8s94ZFiOSzmxiQcHCufi+RTW6P5a0
         nSC4LPyBLOBnqQ0Mgn3B0K9CyTrtu7ECT49xQvDKSwZEp3L+Su5iHyiCv45oZ7c1YNZm
         +c1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZJV9qCkaOxpO84xo6ebk43WZP210trdb6TDi7Y9RbbU=;
        b=k5gZAkEhJFpiouRrAHHIJJUZhdYNZu5qwhbSIbnVEp4I4GkgRJG+Fwfd8xZP/zVF+i
         N8FqYx/uj9jGT04tpXINGmnsKjYydwvGc2PiAWmyxT9rr/0JAjFqveZ6GlOEpj6keuoS
         kZAdAz2aSS6iE5EKLiHdAOO/ai/4TNtSKwggZhtL69zLhid2Wi1LbDwF5bF/UZDvczN+
         J5EEVi2QgOk4R8czVIqGBhdkBaTjRcSfu0KN1rPEGca6EPUMredfmepx0Um5DaB58s0R
         driMEKnc6BUM+KKq9VIiooxaqksXBAtimmnqW3aTHlvs35rEqsupuoIWbk2nJPfMbCJu
         TMPA==
X-Gm-Message-State: AOAM530D8R9QfPdSWs3R5NY5CS/keyEx341gohMSNcGp+hMW7o8KM7WZ
        nLQJUNAxr5Xwk6QOTIRbNxs=
X-Google-Smtp-Source: ABdhPJz/sIUB1FWNgKw07AVyLZvVee4bfNwaHe8dvDQdVVeqiYVBi7q0hxsTBcqhHy/H/3h3g++leg==
X-Received: by 2002:a17:902:f54e:b0:15e:9158:1237 with SMTP id h14-20020a170902f54e00b0015e91581237mr27271569plf.37.1652313853862;
        Wed, 11 May 2022 17:04:13 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902d38200b0015f300ed0b7sm2491462pld.76.2022.05.11.17.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 17:04:13 -0700 (PDT)
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
Subject: [PATCH v3 1/2] x86/asm/bitops: ffs: use __builtin_ffs to evaluate constant expressions
Date:   Thu, 12 May 2022 09:03:39 +0900
Message-Id: <20220512000340.1171988-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512000340.1171988-1-mailhol.vincent@wanadoo.fr>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220512000340.1171988-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
<Instructions after ret and before next function were redacted>
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

And finally, Nick Desaulniers pointed out in [2] that this also fixes
a constant propagation missed-optimization in clang.

** Statistics **

On a allyesconfig, before applying this patch...:

| $ objdump -d vmlinux.o | grep bsf | wc -l
| 1081

...and after:

| $ objdump -d vmlinux.o | grep bsf | wc -l
| 792

So, roughly 26.7% of the calls to ffs() were using constant
expressions and could be optimized out.

(tests done on linux v5.18-rc5 x86_64 using GCC 11.2.1)

[1] commit ca3d30cc02f7 ("x86_64, asm: Optimise fls(), ffs() and fls64()")
http://lkml.kernel.org/r/20111213145654.14362.39868.stgit@warthog.procyon.org.uk

[2] https://lore.kernel.org/all/CAKwvOdnH_gYv4qRN9pKY7jNTQK95xNeH1w1KZJJmvCkh8xJLBg@mail.gmail.com/

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


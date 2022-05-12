Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11886524153
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349545AbiELAEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349533AbiELAEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:04:21 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490B479820
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:04:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i1so3349642plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/PaByGRhEGBhwCNS2nARgA0uB7mRgubG621cnM8Ytdw=;
        b=Ncprh/EGurdgo/9UVMCgqqAl2hyO8i1oIstb1T6EL9tz1wTbCLp3ZWWeZwJZQmyeZQ
         Q8Cf8TZau1SQOsvwH9sg6O3K8op7IDLl6jgMMB1tCYyeAuIon//1AmmN/ztdFaSg0LLK
         8euqSn5C+XdXw5x7jHmLM4RvC13zDu9vbw5UF8Ynn0l0B/GuYuppmA3cVRO/mB69s+ZI
         QEMS+8Yfn3EJUge2uaCJNDYqRk1kywMuOd9XulJt0zvNyi0YupwAJtLRM0gvxRev2qSw
         GPtrIrWkHxqrnjcanC8XDyrJ7Qm2KTfR32HR89F4TfZSzaTcinXwiLNAHqWlUmtYKYcW
         +ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/PaByGRhEGBhwCNS2nARgA0uB7mRgubG621cnM8Ytdw=;
        b=n6h5cyRUc9xswTqoZs2GdoMC+eXPE4T+mhZX+orYXLsj4hFfS13Vop/EfOaignbzzA
         r9zXQtDnhALlFu/PCjAUUlmkyfOprt4czoG4gLBsaKLr4n9Z5hmmk7xDt8sZLIWO0gtO
         10ynMco0orqxZDMDrGfKkI5H3VdX2YKZNGwlmcblUAkIU7joKeK5Za3erP/EU5Qcwkpj
         ZZrhnRZW0q+676x/7xGk1hBcqsQJLFAhbWGtsqu7x8zs+lOgOGv/AQytt4E0jZqHt5eg
         NJuBtLh7Fp+a9e/BIL4oxzu76B0LV2HmV5H9de4k6pYBfgHXebnSmItYhfzp7Y2sMLR6
         jf+w==
X-Gm-Message-State: AOAM530Gfop4Ji8wRZs56+W94+CKt7cevIVrSQVOqMBZBoFRSSx9Jy0F
        zyM5UJf5FpqaKz0P/Lj1z94=
X-Google-Smtp-Source: ABdhPJzT9/j/Ej+xBb7CJ8SwsJc0KuFRpL2Sy6A7Y+0ZtUfeeqrA08eYDXjkdzYM/Hk/MxK6CHTOMw==
X-Received: by 2002:a17:903:2289:b0:15e:8d2c:5b44 with SMTP id b9-20020a170903228900b0015e8d2c5b44mr27290441plh.113.1652313858617;
        Wed, 11 May 2022 17:04:18 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902d38200b0015f300ed0b7sm2491462pld.76.2022.05.11.17.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 17:04:18 -0700 (PDT)
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
Subject: [PATCH v3 2/2] x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to evaluate constant expressions
Date:   Thu, 12 May 2022 09:03:40 +0900
Message-Id: <20220512000340.1171988-3-mailhol.vincent@wanadoo.fr>
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

__ffs(x) is equivalent to (unsigned long)__builtin_ctzl(x) and ffz(x)
is equivalent to (unsigned long)__builtin_ctzl(~x). Because
__builting_ctzl() returns an int, a cast to (unsigned long) is
necessary to avoid potential warnings on implicit casts.

For x86_64, the current __ffs() and ffz() implementations do not
produce optimized code when called with a constant expression. On the
contrary, the __builtin_ctzl() gets simplified into a single
instruction.

However, for non constant expressions, the __ffs() and ffz() asm
versions of the kernel remains slightly better than the code produced
by GCC (it produces a useless instruction to clear eax).

This patch uses the __builtin_constant_p() to select between the
kernel's __ffs()/ffz() and the __builtin_ctzl() depending on whether
the argument is constant or not.

** Statistics **

On a allyesconfig, before applying this patch...:

| $ objdump -d vmlinux.o | grep tzcnt | wc -l
| 3607

...and after:

| $ objdump -d vmlinux.o | grep tzcnt | wc -l
| 2600

So, roughly 27.9% of the calls to either __ffs() or ffz() were using
constant expressions and could be optimized out.

(tests done on linux v5.18-rc5 x86_64 using GCC 11.2.1)

Note: on x86_64, the asm bsf instruction produces tzcnt when used with
the ret prefix (which is why we grep tzcnt instead of bsf in above
benchmark). c.f. [1]

[1] commit e26a44a2d618 ("x86: Use REP BSF unconditionally")
http://lkml.kernel.org/r/5058741E020000780009C014@nat28.tlf.novell.com

CC: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 arch/x86/include/asm/bitops.h | 38 ++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 6ed979547086..fb0d7cd9f957 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -224,13 +224,7 @@ static __always_inline bool variable_test_bit(long nr, volatile const unsigned l
 	 ? constant_test_bit((nr), (addr))	\
 	 : variable_test_bit((nr), (addr)))
 
-/**
- * __ffs - find first set bit in word
- * @word: The word to search
- *
- * Undefined if no bit exists, so code should check against 0 first.
- */
-static __always_inline unsigned long __ffs(unsigned long word)
+static __always_inline unsigned long variable___ffs(unsigned long word)
 {
 	asm("rep; bsf %1,%0"
 		: "=r" (word)
@@ -238,13 +232,18 @@ static __always_inline unsigned long __ffs(unsigned long word)
 	return word;
 }
 
-/**
- * ffz - find first zero bit in word
- * @word: The word to search
- *
- * Undefined if no zero exists, so code should check against ~0UL first.
- */
-static __always_inline unsigned long ffz(unsigned long word)
+/**
+ * __ffs - find first set bit in word
+ * @word: The word to search
+ *
+ * Undefined if no bit exists, so code should check against 0 first.
+ */
+#define __ffs(word)				\
+	(__builtin_constant_p(word) ?		\
+	 (unsigned long)__builtin_ctzl(word) :	\
+	 variable___ffs(word))
+
+static __always_inline unsigned long variable_ffz(unsigned long word)
 {
 	asm("rep; bsf %1,%0"
 		: "=r" (word)
@@ -252,6 +251,17 @@ static __always_inline unsigned long ffz(unsigned long word)
 	return word;
 }
 
+/**
+ * ffz - find first zero bit in word
+ * @word: The word to search
+ *
+ * Undefined if no zero exists, so code should check against ~0UL first.
+ */
+#define ffz(word)				\
+	(__builtin_constant_p(word) ?		\
+	 (unsigned long)__builtin_ctzl(~word) :	\
+	 variable_ffz(word))
+
 /*
  * __fls: find last set bit in word
  * @word: The word to search
-- 
2.35.1


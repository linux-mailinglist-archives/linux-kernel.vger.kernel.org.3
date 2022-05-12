Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCD65241F8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349892AbiELBUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349867AbiELBUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:20:35 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FBEA0D2C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:20:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id v11so3437541pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nyw+kIA5BAs/IWrKxn3GKDGPvGzat8nDAzo2DBLLfVQ=;
        b=lHrCVIXEYfUGh2winYDW1cmqYJce8Z3fVZKUfdoVJjk/fENnqbBsd06otQQh2BzoEp
         jG9/5U9ce4aSF/nROlXRisuVJtHiSJIklOzJdtExiZHtZl89BAoAmA1KiSIGoyDuI9YR
         nC+DLRD2lxRH7wWEgwX5eLBmYutZglDCPmzzcpDhZFSEyWJol86n7lCbsSXfeobkHKsD
         vC8iQq7uPL0TmLwxFnOgStCuLWMh3thZUdNdgRUFm+MvzzlrXeaTTElvkS5huBShjNLI
         S1ZdXNHDDL0KJKe+O9FSgrAIspumtYpNCjhzhyHDKYrTh/0szm8QKKYBgJN2TUflyGiS
         LICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nyw+kIA5BAs/IWrKxn3GKDGPvGzat8nDAzo2DBLLfVQ=;
        b=7NIa9fYk6YnYkUa8j/WHslsHlyRGGTgVeqlMWH5A8JquRmWuy7+wZCEnqQgqSNvkYi
         CgbxyriB9WulwStamgt4G7c45OGLi3CcDRe/bjBosCt4J4tLLFFEKxpBqKqKEJbkzHrY
         /NvmSkoShXWlb8cYjniFPaU1ArbCY23/QNi07oJIsSDRD1p+NUpe4wv21Cu0w1QBM4xX
         wNCD1WhmVlVNDHD38ieLELnHFgs/2P8c60KRIh5tStuEF+JDNJIGsMr2CYkZQjhNQYHe
         H0tKTk20V09JStkasUepwL55Qa2ft2B0tzt+02sjY6i6FkNp/WSL9GF5oG3WTzEdRKPl
         mWzQ==
X-Gm-Message-State: AOAM53170fNgsFgoDV+kmXxeD3AjO57ug0kZHkPwfknb6n7p3QtjJxRd
        Jh0W8yPNfRNJkQaoUFFdygU=
X-Google-Smtp-Source: ABdhPJzCVGkzF8jmxnDJbp2OMWjfUzpveTKZHLNBWCrPVGPA/DA6fVqnzk4jGRhPJ6r0O8zDUuBeKA==
X-Received: by 2002:a62:a105:0:b0:50d:c97b:3084 with SMTP id b5-20020a62a105000000b0050dc97b3084mr27500292pff.61.1652318424346;
        Wed, 11 May 2022 18:20:24 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ea8500b0015e8d4eb24bsm2545978plb.149.2022.05.11.18.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 18:20:24 -0700 (PDT)
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
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 2/2] x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to evaluate constant expressions
Date:   Thu, 12 May 2022 10:18:55 +0900
Message-Id: <20220512011855.1189653-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512011855.1189653-1-mailhol.vincent@wanadoo.fr>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220512011855.1189653-1-mailhol.vincent@wanadoo.fr>
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

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 arch/x86/include/asm/bitops.h | 38 ++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 6ed979547086..f88c55b8b37c 100644
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CD3521D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345518AbiEJPDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345423AbiEJPDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:03:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7911B229239
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:26:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so2149141pjv.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4L5S8FVGf1sMR35eidZeiyVG8JnT7nykUFphbiRbJOE=;
        b=D0yJ+81QhdVQKnSC1cDM6q74m4kyDY226rltceKQLyqMl5nkiLbFIHHfkt4vev55oW
         NEZwe8kry7HmVjGb/vG2Nu0ZcuYX0x7LFy+G4hFriF3LEMQH3PKlgWP0ZGvqkUFewTfj
         OafwLSMF6qHvoe8gK0SR7SkAWbuHRH/jz7wbyYP/YBo34GSypmopha4d7WYQoUgFGoxG
         t1m8X9h8n6Muqg7J/cSVg9b7PkA4Rc2I/drY2YCZ7Xnq2ltx62MCVYofFSk1RMY+Nlo/
         SAq9cJA6fjxDVryf2skE0anV/isCzIG6kkwf158Qc0SxWnghXfRxMP7oVSnmA27L78QC
         Rv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4L5S8FVGf1sMR35eidZeiyVG8JnT7nykUFphbiRbJOE=;
        b=Kqll/4JTkgDk4tsUcMj8BWxrbq52oAs9Xty5TLSXZGNsIL6091Of0ZMwgh8guzm86D
         lyO+NrLMQd7SvOIKhYONN3nB5r1kUDVEhPHex7jQdOxSg+Ou0wYrt6yLUlh6DT1FeX6d
         gPuA6yvUVJZeSQqDMopDtPYGi8y86+QxrEvaADLzFkDze4JWVCvmyQ7Xo9AFNyo+T2ak
         1hDchPK0ud2UMKFFXss5WjWo41BV/pzgYgjPilag4dKc0rA46AYyq+xtWR73RhK0V+Of
         EfI4wZAcBWFy/Nu/mWUWYGHIw0Gr1TOsAEu+D40DY0NkRczjMg1702NKVkQ6Q4PZsy4r
         ubpA==
X-Gm-Message-State: AOAM530TJNH+RR6hbCCA9b9Xq+40QmYNJoAgyBWETBoMsHFwsR6phKoB
        L+broKh6FVbhu0QxQQQDxOtl8kkCFTVpY6CG
X-Google-Smtp-Source: ABdhPJyBqsurrR904pcspa44t3Se2r7m2fHOr/QA5JhLtVn5m+o0oMztQhsUUErQLkVErJJHrhwIZA==
X-Received: by 2002:a17:903:22d2:b0:15e:a3a4:918c with SMTP id y18-20020a17090322d200b0015ea3a4918cmr20284232plg.36.1652192806635;
        Tue, 10 May 2022 07:26:46 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709028eca00b0015ea8b4b8f3sm2057568plo.263.2022.05.10.07.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 07:26:46 -0700 (PDT)
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
Subject: [PATCH 2/2] x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to evaluate constant expressions
Date:   Tue, 10 May 2022 23:25:50 +0900
Message-Id: <20220510142550.1686866-3-mailhol.vincent@wanadoo.fr>
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


Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Usually, helper functions are prefixed by two underscores. But here,
__ffs() is already prefixed, instead of creating an ____ffs(), I
renamed it instead to __ffs_asm_not_zero(). The _not_zero() suffix is
to differentiate it from the __ffs_asm() helper function of the
previous patch.

If someone has better inspiration of the naming for this patch and the
previous one, please let me know().
---
 arch/x86/include/asm/bitops.h | 36 ++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 535a7a358c14..694d0d100399 100644
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
+static __always_inline unsigned long __ffs_asm_not_zero(unsigned long word)
 {
 	asm("rep; bsf %1,%0"
 		: "=r" (word)
@@ -239,12 +233,17 @@ static __always_inline unsigned long __ffs(unsigned long word)
 }
 
 /**
- * ffz - find first zero bit in word
- * @word: The word to search
- *
- * Undefined if no zero exists, so code should check against ~0UL first.
- */
-static __always_inline unsigned long ffz(unsigned long word)
+ * __ffs - find first set bit in word
+ * @word: The word to search
+ *
+ * Undefined if no bit exists, so code should check against 0 first.
+ */
+#define __ffs(word)				\
+	(__builtin_constant_p(word) ?		\
+	 (unsigned long)__builtin_ctzl(word) :	\
+	 __ffs_asm_not_zero(word))
+
+static __always_inline unsigned long __ffz_asm(unsigned long word)
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
+	 __ffz_asm(word))
+
 /*
  * __fls: find last set bit in word
  * @word: The word to search
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1EE57EFFF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 17:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbiGWPP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 11:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbiGWPPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 11:15:52 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC89710577
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 08:15:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r186so6702343pgr.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nyw+kIA5BAs/IWrKxn3GKDGPvGzat8nDAzo2DBLLfVQ=;
        b=RZE9+srs/ZQzf+6+8iMp8aSA+S4b3XHtaBcIK6cWQOJUIxJVQYnVj1IXBzsP02WL7E
         +pp2U8Htt9zTu1bRiYFE2dE6852hCRVpwjG9FShI2mWgMd+L4TbkNZtrcBh1hEY98ZD6
         85MWFxZ4uhWnekb5n77j4yDtDudwFT8tpq0SrFn0NiPeqtkrr0ncPBQFNp95idgQWQA2
         PAfh0mipOkRRR3HSSYK6IQZWUJGetDgiiNSD8dcK7YcvMnJSB1k0ANx0qlUUDCpPo9JB
         7v/hNqJaQHCNNmBjU0AYqwALfgc9v/HdOM8XvH/W5RNmKg8CNteWK+O7Hxr69aUO4yvV
         jAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nyw+kIA5BAs/IWrKxn3GKDGPvGzat8nDAzo2DBLLfVQ=;
        b=uYIkSTL6f6KVqizFo8sRFQXW3YHFHD2QzHfv2njO5G1NWq45xkUu/evEPnY+eeR5c2
         SEVD77uDlkdE6qSMbvDHbNBhfoY/ATqkv4DTMg+7CqSMyFybPeJOF7ZYctcaWOqXPvs1
         yYiw+A5/3cUFMqZ7mLhsw17BJb/zT5wfm9ou/u6nicB1g8AucIV0mtmBUy0FEgeh/dLy
         jioUVwuvFdX1ISokaI1I/JsKAPf/AXylJWeg7w543CI7eJ3NRLMdEwDSeAOq1Sm9F+9u
         +nI7wZDjWP4iBoSOUx6+Z7KwuK+DTrI4bdVjZ9yyrdZKDBZhax5jyX925iSwIN95xmux
         hO9Q==
X-Gm-Message-State: AJIora+Kv1EdT1ORqlP65NlWBbdY18KaVHu12Uu0Da2uka2ZE5BCLqzy
        QWM65EyDvwxwAZ/G2kWl+r0=
X-Google-Smtp-Source: AGRyM1sAYtOF3ID6coRuH3k+muPkfvjnG5dlXIbn2P0RoBCWcX3EXbdpe4PoLRE69uBbjS2c4EAkKw==
X-Received: by 2002:aa7:9e41:0:b0:52b:b32:ccf0 with SMTP id z1-20020aa79e41000000b0052b0b32ccf0mr5035133pfq.16.1658589344243;
        Sat, 23 Jul 2022 08:15:44 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id a5-20020aa794a5000000b0052ac1af926fsm6071350pfl.20.2022.07.23.08.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 08:15:43 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RESEND PATCH v4 2/2] x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to evaluate constant expressions
Date:   Sun, 24 Jul 2022 00:15:21 +0900
Message-Id: <20220723151521.51451-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220723151521.51451-1-mailhol.vincent@wanadoo.fr>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220723151521.51451-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FF85B28CA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiIHVzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiIHVzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:55:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7A497B01
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:55:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d82-20020a25e655000000b006a8fc4506c0so10695406ybh.18
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=g3Gq9NjDQ4hoNq7pf0wYq1hQ9S7+uZzv+7qsTdt2KdI=;
        b=e6ayS0gC7nTSB7sRK6XqhQ8PkPz9hlgp/RG7EOOdhWea6QvJiQZOd6p6yRF1NZYv/o
         vzQ7PUjvc1GQcMZf/RvGUwpu+aH8P3ZoExhuwot4Tu7nh4eE2MqU4XX/qfmC11xMEW4o
         Y/AZQ0xzwG2Mar5BAt3A1szuyTFm5NvUtfYqEfXV1CSjQcMQ3Q1HdqhaSkzso9vU/bfF
         2S9OU1oxlI5/swmy9dZQTjUadiVrICRahUR+1BkjvlCNWRfP9Mw6o1NCxiHcqC/FEK0/
         FLsQPDJso9Ylk5O0+Jzhs1qE+tMp3ptdqsU96cyzMV7BAd396uxnK/WHPUbXM9y+WcfA
         SKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=g3Gq9NjDQ4hoNq7pf0wYq1hQ9S7+uZzv+7qsTdt2KdI=;
        b=b5teVlKeJatoIuEcA6YqsB1KIwAzlC5exRwagqY0X7iAb7Wqu8rZWxkJgh4RTyeQyG
         BCEGStWHT7297TZNiItnwl3wlbiXkImJh90VicEuzhq6JWjIcC+OVY6DLjpu1dGJOiQY
         7O/tb83L1eWR8obrP4PslkbOQXG5+ZrzSc4294hV/ajICn4jHeW86GY81PQ4RPtUrdX7
         yq02f0WRW3MrkeAPzqr8YfP8lJB0gQrJ7vb5kWntlce6a0+TSv5Cq8o8I5gp8RVAD67p
         zp0q5FvJvBqbwZhtLoZEWisbdUhgW1SvgVPHVLEUTxyuurhY8dWZa08QDbmbbdESVvuu
         WmBA==
X-Gm-Message-State: ACgBeo29zPEj6PC/Nf6gy6tBtnnO8hWvJtQOZc4PhGqzrxTdhlKQm9gc
        r/qwAznkrCD/EQgk2csXkwV/2+P8EHxAPBRCVxwJnFPUg3yBHKDyhpbAK/OGVjD1cRxIcyCYllf
        nKmEyEXjaGNYDaWdLTa7ZDkKYG6En+US1dYVcojLJ4mY3hLRrTNw5Q05Du653Rpys4nPYPRO1Gm
        IMNNuNJ6+HXA==
X-Google-Smtp-Source: AA6agR4oLa4FfONKqbwF0FpWWwehyzcLO0uVvsqUFNdTCDrYLlJiXgNyonePKOhCzmHaZvZqc+/KvgSAGwpx0OzCFUY=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a25:6405:0:b0:695:626f:2f54 with SMTP
 id y5-20020a256405000000b00695626f2f54mr9342982ybb.532.1662674117353; Thu, 08
 Sep 2022 14:55:17 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:46 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3358; i=samitolvanen@google.com;
 h=from:subject; bh=q6/maWZMNVpRPStuCMK4l2y855666X5QfHf+jlPyW9E=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmSzPgBZK/tC4vtUdRH53Ki3URAzr5yoqoKUBNEd
 9pDUmUOJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpkswAKCRBMtfaEi7xW7qFOC/
 4zoXFSdT6EVd7MKSkn3bke2rRW5/QfuEhpApzfIEcWm7hYWqvt2j4d0/ZBv/AhDbpfAu63FzvtxKRe
 LIizJqs3rsDJZpaN8FOfE15jM5ZEhcW+XQhXeBb9cPII1xyUjI50Ewak9+QqMAhJKWkpnhCw0ZiuyF
 PkSvSEFK7IsX3rt9E5mGQHKwiO6tST5MVjp6wnXwKiilISNiFuddkn8K9CPBqsGqw7fPEvOYNlUNJw
 Lv8Z2wulw6ah+Tl2+nNV4fPFZsX3KFvWLh0DToEsUurPTa/RX3Is8GCXDKckNFqFTeWwc1UXH9mPuj
 yLGtLW6UtdSWrCAf8feKWj1r8dLd7yCN+z2mTGNfD8tXyUKkrV/e2tC1ZTz8xlxKGF1kJY+loYhPbr
 CsUhah3L7kmv88pnkFBqwxaBm+vHrXGYpar87u4ga69xVDbczil5jN333/KQnbR7bBNMtDdatTv7U8
 u3+F3CuQjOOfIUjzM2EfPHtSCxBwfwZJKRVf7tIBFv3gI=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 04/22] cfi: Drop __CFI_ADDRESSABLE
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __CFI_ADDRESSABLE macro is used for init_module and cleanup_module
to ensure we have the address of the CFI jump table, and with
CONFIG_X86_KERNEL_IBT to ensure LTO won't optimize away the symbols.
As __CFI_ADDRESSABLE is no longer necessary with -fsanitize=kcfi, add
a more flexible version of the __ADDRESSABLE macro and always ensure
these symbols won't be dropped.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/cfi.h      | 20 --------------------
 include/linux/compiler.h |  6 ++++--
 include/linux/module.h   |  4 ++--
 3 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 4ab51c067007..2cdbc0fbd0ab 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -13,26 +13,6 @@ typedef void (*cfi_check_fn)(uint64_t id, void *ptr, void *diag);
 /* Compiler-generated function in each module, and the kernel */
 extern void __cfi_check(uint64_t id, void *ptr, void *diag);
 
-/*
- * Force the compiler to generate a CFI jump table entry for a function
- * and store the jump table address to __cfi_jt_<function>.
- */
-#define __CFI_ADDRESSABLE(fn, __attr) \
-	const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
-
-#else /* !CONFIG_CFI_CLANG */
-
-#ifdef CONFIG_X86_KERNEL_IBT
-
-#define __CFI_ADDRESSABLE(fn, __attr) \
-	const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
-
-#endif /* CONFIG_X86_KERNEL_IBT */
-
 #endif /* CONFIG_CFI_CLANG */
 
-#ifndef __CFI_ADDRESSABLE
-#define __CFI_ADDRESSABLE(fn, __attr)
-#endif
-
 #endif /* _LINUX_CFI_H */
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 7713d7bcdaea..7bfafc69172a 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -221,9 +221,11 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * otherwise, or eliminated entirely due to lack of references that are
  * visible to the compiler.
  */
-#define __ADDRESSABLE(sym) \
-	static void * __section(".discard.addressable") __used \
+#define ___ADDRESSABLE(sym, __attrs) \
+	static void * __used __attrs \
 		__UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)&sym;
+#define __ADDRESSABLE(sym) \
+	___ADDRESSABLE(sym, __section(".discard.addressable"))
 
 /**
  * offset_to_ptr - convert a relative memory offset to an absolute pointer
diff --git a/include/linux/module.h b/include/linux/module.h
index 518296ea7f73..8937b020ec04 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -132,7 +132,7 @@ extern void cleanup_module(void);
 	{ return initfn; }					\
 	int init_module(void) __copy(initfn)			\
 		__attribute__((alias(#initfn)));		\
-	__CFI_ADDRESSABLE(init_module, __initdata);
+	___ADDRESSABLE(init_module, __initdata);
 
 /* This is only required if you want to be unloadable. */
 #define module_exit(exitfn)					\
@@ -140,7 +140,7 @@ extern void cleanup_module(void);
 	{ return exitfn; }					\
 	void cleanup_module(void) __copy(exitfn)		\
 		__attribute__((alias(#exitfn)));		\
-	__CFI_ADDRESSABLE(cleanup_module, __exitdata);
+	___ADDRESSABLE(cleanup_module, __exitdata);
 
 #endif
 
-- 
2.37.2.789.g6183377224-goog


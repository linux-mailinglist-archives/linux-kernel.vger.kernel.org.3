Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F04547028
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350605AbiFJXfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349356AbiFJXfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:35:38 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C095289F3A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:25 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k10-20020a170902ce0a00b0016774f4a707so261895plg.22
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=McmKeDfQU54OT2ddjesNbtVSHYxn5HOZJ/k/YIxSA2Q=;
        b=pKSmswC9i7CgIKNd8Ueb3Mz+6W8hfA6K3s8z6NmKiL9LavoDEDZ6LuI6xYKZyL/Qkr
         160+qtQ1m3Pr4c4JAr7nYajwE1TSz/y2E1Rrx9U++y9J2+JSWlXRC5Nl3ytA7Ul5xzdO
         LISOUP2H04z2pfT/iuQxpK756TTuJdOX8Llgnt3mEUhHJ4JH2+YFORRQmfjqRsJn4Bha
         d2lJj5ycPYMuGuK+7809rBwk55D2MIZfdYbMtD+yfSi3pj5+WYVoynmFYFomThVrwt7o
         j7kMxaeyxnvLaVO3AbnVftP4ICSRzwZIOsIGKZKiAR/cybwHZ+1F8gwFFjHtiLh7Ahn2
         MnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=McmKeDfQU54OT2ddjesNbtVSHYxn5HOZJ/k/YIxSA2Q=;
        b=t9gUmoCPKhSdSWADNSNkLFrkTdraNRMpEIo6cXIZJasxURaafT7L5PEBxZuYFtG73A
         6YcuZioIzFyKczJ0BsCi6MUhCHltv1o+OD4FNeSYQOe5GtLffXdD5M0GQFt0pD06Lnh8
         q5pLLisqSynHvbhgynp1dfcFt/LHMyGtTPXCtWUEhKIQ8tsXtnpt1aYZKOBQVXSR3Eu/
         AiH/7Kzkvts4a9id6Z1LoCRBubhiqh3eHTzs7JAhwWq/+fz2pYAygwr9XkiObQ62nqRb
         Mz0TMjT5aromZfEv+f6/LCMGYxbve6WKPX8DfMevuGbKw1sdy/S3PKjSrPZnFiDmCTAt
         i+RA==
X-Gm-Message-State: AOAM533f1UhLl+x936wrRA9/mooD1m4BqSAXFCtmmc+XoPr53w7qMDDE
        9fbnwY0JvDYsjsQANE+fJ8FOe/my7GZNn+793cfI+wnRQNprvT4kz61cOa3L/HyjHtjjr727+hD
        zep7eO/E/UsOlULIjCePq1Fede8tNMw4XJ6s60p0J8nJNfXcKV9Z0ND4wNEF2arRA7u5WhXmwXD
        Ss3w/Lbs8qrQ==
X-Google-Smtp-Source: ABdhPJwgQhAUrkZ2E3ncordFI1QLNbwk0KpIEhulvG6cFyGBziAQCqlrz6Jc+ed47AfAPj4RJHLMezGZqpWcUfbVd+4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a65:4149:0:b0:3fb:1476:d0dc with SMTP
 id x9-20020a654149000000b003fb1476d0dcmr41179133pgp.373.1654904124994; Fri,
 10 Jun 2022 16:35:24 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:34:57 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3262; h=from:subject;
 bh=hbOGCW0Qi8kWOELjdrp8JGjjRWA8+I9n0fNulcEZcDg=; b=owEB7AET/pANAwAKAUy19oSLvFbuAcsmYgBio9UtgU/4jH18jloCAgXuwbucQRi4omU8/F8NLShQ
 oWKWan2JAbIEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLQAKCRBMtfaEi7xW7sBKC/
 iex5GdKDqwH+DynVX5SiIJ/O/kBiCxebuuv+PRNnuuu5NP3jE7hyT+5F6E93ER1zUiBBK717u3FgLM
 L/KlhU6pU7G104AQ8tdX1EU7D34Q2YLaJaHJT0vOywEEKfCCVNO+h3Nx/jZ+PHXxg1QbXtXlSWqwD4
 +/kvY1WrcT2i0BoLP1VvzxkSbZ3OIWtWezPEJtmHsP0Zy1M3HZLifJAwutTnmdIsdpv9vZQ68g8N1R
 S/V+L3L0LNtSorcPqo4u5nmqsCPPmIuNp+YSGzEHyyTivV/J+hlSsjueuuG+FneyECj2fZXlEwrptx
 UaYbxCmG+FVcXob7aFxve9hYP4mWfcFcfo7ktgXDRFpRdlXdFOIESUIV0VgVIUuD5GwLoCwcU7BXjp
 LBOlYl7jufqbE7cbRH0s3GrWLWgb9tXfwvkRiQYvNAsCxgZdDhOJu/Agg+kRH9qOBXZVA7xHUVh+3c
 PHYJe+YwgEv/MPvMx4VnjwfiMUUrjuw0CqB1kic5eKMA==
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 04/20] cfi: Drop __CFI_ADDRESSABLE
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
        autolearn=ham autolearn_force=no version=3.4.6
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
index 01ce94b58b42..63be1c23d676 100644
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
index abd9fa916b7d..efecd65a976d 100644
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
2.36.1.476.g0c4daa206d-goog


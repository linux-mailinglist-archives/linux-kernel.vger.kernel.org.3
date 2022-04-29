Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC465155D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381040AbiD2Ul1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380938AbiD2UlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:41:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB6DC8667
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d7eaa730d9so84822987b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mgYY2lX+6A5TnPtbA+mhyQDA8k1F/8PITaCzkIIr+as=;
        b=YjpbUMEKsiPqXO7j5QaX9CEnteTNYermxAVj8vpBYNcU/DKnyhIaC+KAxIbQ0HMh50
         jZAmuGlryAzqWQgF7v18N9rzJ/FqqonqTEqQ/8zVqDbxRTv0LgoCJ6IGvArsgIrIU3Fc
         FuGRQz95g0YZ+nDn4YVpaZcNM/vIYbltZH6wh1xpHvNFyaOb+eq8KSDdMHNkV7zxuTUE
         jgEidlDR+yMW3OdmVRrZA4F/WUddh9IvCWCnqoGIW5ErpQkQ2PDPToXqhYoIN4XlOqhF
         nNy8Gp5x2LZn9OUz9m9EXN06xvPvfyCapJ6Il8ctGUGTDqd3GoZZddD4mn/UC3XWHeII
         RLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mgYY2lX+6A5TnPtbA+mhyQDA8k1F/8PITaCzkIIr+as=;
        b=EH5yEH9n/CvBl3gT8+MzyqCpdSvmIE63SsjxG7xsl8CwOgRb4Tzt+aPKz8/KmNm9v7
         vYa9f08Dsa9vbNcTK7QqPdiQdSiXL+7KK1A7f8nlWSGazADDQ7oPqZyjNyn3aVXkhOwA
         fXE2O63ibddJIWnY2UBpmUo+p7qBbNl0+4g1mblJ27NJ5c2NkSJEJUmuN0TqwsaDbnIb
         vuGZstpdJJn4BtnJG7dln9IYVfatswtA3Dl+uwykAeUKPlzgfN13BnbWSbS/mFnE53+2
         IQ9jbpW0j1DAf4F1YFrIkFTUhjwIrYfT2Qp7MHxIGs6SdJhI41YQb4eLL50Oa3oq5eJe
         ULYw==
X-Gm-Message-State: AOAM530AtY55OQIR6Uj7pVkNGpLNfv6xUi6K9FV9xY10gqQqNoNS4fru
        Mr9TfqObWeZhyqFek1Aq/r8zuP5nmCKhlI7bwsyalKe1EjoaHuQO/Csh3ogGGhWkRY87Mh5fNQo
        uqn17EdRFGoV7k8NW2IzfYQ331syKLKg6mZyA5lxmAINMz2hvDDRw1YDO6Ch7tOGM0d7OOJwlOn
        8/cM11vD1JJw==
X-Google-Smtp-Source: ABdhPJyambFdCnuhmSj7yilVaN1wZnPPJvyC6XgV07kwK6srYdBE5TrGTkmK5Jt3LNHtm046MZq4+WTcrii2u9VORI0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a25:6157:0:b0:645:8d0e:f782 with SMTP
 id v84-20020a256157000000b006458d0ef782mr1403212ybb.36.1651264643566; Fri, 29
 Apr 2022 13:37:23 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:38 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3560; h=from:subject;
 bh=bFdr8KmKdxGKWmbD2cJi1nCiQhugbXkWJr6xn+4w/Vg=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExXTqTrMCKvJUQRO1SvugummwkQzb2swGsRRMku
 BRKSFeaJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVwAKCRBMtfaEi7xW7pzWC/
 9n2bx+onwgeKynQ327/gYKyBj78JXPpfWB3IzaBiLs329WOK7TdsBUtqcjEop94O5lG3vUcXzch3sP
 RPbgoCCB4IVfV0NIpcBczH7oUNdurADR5O5bYK5KKFqphm81E7KU4PYHv5HLtfauMByN4QqVaOiuKj
 nb4s0SqLCSNGJ8NHnLtsdfz1ESGEY3UQ9Hf94PEgnLxMtxbVQnq4bSi3ArQDlpl2QFPcA3/U/ou/ir
 3ye/0/3VNdUfN6wx9MhGZRyUWfNrfsJCVH6LtgXxLk+sKB1dR7r2sJqxQLn0IXlpaGxI2oFll0L3W4
 9h0AFZpcu+A6kKeGZhi5v7qoeGrn6rv+iz76lwz2ARGx3q9Fqmfxl8sHSfrHkZUk6tl9dDbDglqQ76
 xWXwKlr62HVRv+4b0BefusoLDrdAFe4dl5+a0RR9NPa3RGsJBN0qGPaC+ZEqob2tNLJYOl103mi8Nq
 1z6e8gI84Cpj0HOxsEVgnM2XFp/xJq+9FZzznLF8NVshQ=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 15/21] static_call: Use cfi_unchecked
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_HAVE_STATIC_CALL, static calls are patched into direct
calls. Disable indirect call CFI checking for the call sites with the
cfi_unchecked macro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/static_call.h             |  6 ++++--
 include/linux/static_call_types.h       |  9 ++++++---
 tools/include/linux/static_call_types.h | 13 ++++++++-----
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 7f1219fb98cf..f666c841b718 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -204,7 +204,8 @@ extern long __static_call_return0(void);
 	};								\
 	ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)
 
-#define static_call_cond(name, args...)	(void)__static_call(name)(args)
+#define static_call_cond(name, args...)					\
+	(void)cfi_unchecked(__static_call(name)(args))
 
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
@@ -246,7 +247,8 @@ static inline int static_call_init(void) { return 0; }
 	};								\
 	ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)
 
-#define static_call_cond(name, args...)	(void)__static_call(name)(args)
+#define static_call_cond(name, args...)					\
+	(void)cfi_unchecked(__static_call(name)(args))
 
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 7e1ce240a2cd..faebc1412c86 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -81,13 +81,16 @@ struct static_call_key {
 
 #ifdef MODULE
 #define __STATIC_CALL_MOD_ADDRESSABLE(name)
-#define static_call_mod(name, args...)	__raw_static_call(name)(args)
+#define static_call_mod(name, args...) \
+	cfi_unchecked(__raw_static_call(name)(args))
 #else
 #define __STATIC_CALL_MOD_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
-#define static_call_mod(name, args...)	__static_call(name)(args)
+#define static_call_mod(name, args...) \
+	cfi_unchecked(__static_call(name)(args))
 #endif
 
-#define static_call(name, args...)	__static_call(name)(args)
+#define static_call(name, args...) \
+	cfi_unchecked(__static_call(name)(args))
 
 #else
 
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 5a00b8b2cf9f..faebc1412c86 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -81,13 +81,16 @@ struct static_call_key {
 
 #ifdef MODULE
 #define __STATIC_CALL_MOD_ADDRESSABLE(name)
-#define static_call_mod(name)	__raw_static_call(name)
+#define static_call_mod(name, args...) \
+	cfi_unchecked(__raw_static_call(name)(args))
 #else
 #define __STATIC_CALL_MOD_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
-#define static_call_mod(name)	__static_call(name)
+#define static_call_mod(name, args...) \
+	cfi_unchecked(__static_call(name)(args))
 #endif
 
-#define static_call(name)	__static_call(name)
+#define static_call(name, args...) \
+	cfi_unchecked(__static_call(name)(args))
 
 #else
 
@@ -95,8 +98,8 @@ struct static_call_key {
 	void *func;
 };
 
-#define static_call(name)						\
-	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
+#define static_call(name, args...)					\
+	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))(args)
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
-- 
2.36.0.464.gb9c8b46e94-goog


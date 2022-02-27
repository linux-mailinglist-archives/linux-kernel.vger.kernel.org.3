Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868164C5E36
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 19:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiB0SqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 13:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiB0SqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:46:00 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A024728E27
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:45:22 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so9403695pjw.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rtQJ6+HWuDHNtXviDEv3CrUYrjsryDE8pWmriGiESg0=;
        b=m2E7Mkc5+O/hSN+7zDdRObC+NbGDn8KfETTWlSmuj/vdJqDtWt/86czuCbSuNxGYsA
         1Y8x9mmgL+ELb5DPf58L2FnoGs1NDCSPpYG1XAYvTOFZMvu4Tjtd1dL3M+2Uzub2AVmJ
         mxFjyzhIpbnoLtl+uqKjMt1eDPuGbpgQO/92Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rtQJ6+HWuDHNtXviDEv3CrUYrjsryDE8pWmriGiESg0=;
        b=1FIgmjJy9K/52VeVWzPI2cJ6HoL982qFNu3SnwLNQAyXK/Bvi38svMV3mONR78deom
         1CqMkUqpPpBvqjCIl2ymzCGsL9XAbC8kTzj1Ee25dO7Cm3Gc0aM88oFqFfVlpFZ2oZI0
         BQl8DQ3cmjDu4YE5brPg6BDNVfNAKxqrXVDOBBOFlbe7eUjphqvPg7vUUhRN9/Toh2JS
         qXFsQaKwK/a9qkqHuvPV5RgMS6/czyMYQ8nxxN+yRvhje5ZQDy1bRWKLr+mY6+9p54Sr
         t/o1RXwTfJ5ndcZGfiPDxb46y3r0obDijf4GjLE7MrH3mCOOspJ79xKP6yzYhHeLp+y/
         P3FA==
X-Gm-Message-State: AOAM533XRWSIV4IZ5tro6WHgwaqmQTQAiD7aucCWMfXdL48d6kC+aqLC
        GEYfRp3ZrM/VR6HmNjwOlZyEfg==
X-Google-Smtp-Source: ABdhPJzVRRQGxF6e1NTngPEsB3I/EvTNRmSUfuQ6v7xj8PQt1X32lE1LoqLXaWLdGVbZluSQR3Vj5w==
X-Received: by 2002:a17:90b:250f:b0:1bc:e520:91e6 with SMTP id ns15-20020a17090b250f00b001bce52091e6mr13355572pjb.43.1645987521825;
        Sun, 27 Feb 2022 10:45:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00084a00b004f26d3f5d8fsm10450378pfk.25.2022.02.27.10.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 10:45:21 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org,
        kunit-dev@googlegroups.com, llvm@lists.linux.dev, x86@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 1/7] overflow: Provide constant expression struct_size
Date:   Sun, 27 Feb 2022 10:45:11 -0800
Message-Id: <20220227184517.504931-2-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220227184517.504931-1-keescook@chromium.org>
References: <20220227184517.504931-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5098; h=from:subject; bh=2kZK8Pa8mdtDR/Nqo/3Vk6gXcxnyZeRVGJOFKK5/Dm4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiG8a7FSbvVC74wmbAmC12ksTVuBzN9xRSIPC+WKU3 EO0+lGSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhvGuwAKCRCJcvTf3G3AJksnD/ 9jFKmi/Ux9BHhxzZ2RpxelaewUNUU1aSHv57YDOG4L43fmRoLxzBROLz9OcWcP5/ejuFFtwfP5323z DZFpA+Ts0sy9zDjBAcP06aCVrZ0D5y/C1HsAUvPpk+yS2jUe50vXwu7X4wwMS//COr8VCW+aGk4dvG B9loTCNsEklQK46RkPdt0d/WAGj0xMnzHWyztM050GcaJUl4TSBtIeN+5BKRWOt045Npdnf3eCWXq5 24GX5UE5ts6sZKHIk4ywytyDoK+uftNnd8Ufbn8iG34ZO8/fbkf7WAilUNTQH/y1cfyx8qYSIDJ7eL ZqDZejMvx4eMGypzGXA4J2L+Isq+cRIXrbnFLxtUgJt9YvTRrfQdunOtMOTC2WmHAnEKzOs9jlymHB T+Vc4UxaWsdNIBMnhRu+nSHuG/JJK2iYBNxjlNh3xcFWcODPFhCJG4S93ANnr+fKRDE8kq9rAkOYna KxjcdpjVWN/jDTmLHOI3cXBRLG3AxPuwSNAvFKvnck0F8hRGoQDfqTXM10M3TLrNXL9tKJrEJ/eIuQ TT36kiajoi0oH2nbWk9ne714xn1lJ4NoqeFFDO05bz78F70Sb5SOe7nU5RN75Gdbpw18YhvTG6ojX6 cuKk1/+pWSBz29y7CCOHSd+MakbP+FqPYa4n7OorO435P4PZiQdZPAhov3Xw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been cases where struct_size() (or flex_array_size()) needs
to be calculated for an initializer, which requires it be a constant
expression. This is possible when the "count" argument is a constant
expression, so provide this ability for the helpers.

Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Tested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/lkml/20220210010407.GA701603@embeddedor
---
v1: https://lore.kernel.org/linux-hardening/20220210004326.776574-1-keescook@chromium.org
v2:
 - fix broken self-test due to CE optimization
---
 include/linux/overflow.h | 10 +++++++---
 lib/test_overflow.c      | 26 +++++++++++++++++---------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 59d7228104d0..f1221d11f8e5 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -4,6 +4,7 @@
 
 #include <linux/compiler.h>
 #include <linux/limits.h>
+#include <linux/const.h>
 
 /*
  * We need to compute the minimum and maximum values representable in a given
@@ -221,8 +222,9 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
 #define flex_array_size(p, member, count)				\
-	size_mul(count,							\
-		 sizeof(*(p)->member) + __must_be_array((p)->member))
+	__builtin_choose_expr(__is_constexpr(count),			\
+		(count) * sizeof(*(p)->member) + __must_be_array((p)->member),	\
+		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
 
 /**
  * struct_size() - Calculate size of structure with trailing flexible array.
@@ -237,6 +239,8 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
 #define struct_size(p, member, count)					\
-	size_add(sizeof(*(p)), flex_array_size(p, member, count))
+	__builtin_choose_expr(__is_constexpr(count),			\
+		sizeof(*(p)) + flex_array_size(p, member, count),	\
+		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
 
 #endif /* __LINUX_OVERFLOW_H */
diff --git a/lib/test_overflow.c b/lib/test_overflow.c
index 712fb2351c27..f6530fce799d 100644
--- a/lib/test_overflow.c
+++ b/lib/test_overflow.c
@@ -602,10 +602,18 @@ struct __test_flex_array {
 
 static int __init test_overflow_size_helpers(void)
 {
+	/* Make sure struct_size() can be used in a constant expression. */
+	u8 ce_array[struct_size((struct __test_flex_array *)0, data, 55)];
 	struct __test_flex_array *obj;
 	int count = 0;
 	int err = 0;
 	int var;
+	volatile int unconst = 0;
+
+	/* Verify constant expression against runtime version. */
+	var = 55;
+	OPTIMIZER_HIDE_VAR(var);
+	err |= sizeof(ce_array) != struct_size(obj, data, var);
 
 #define check_one_size_helper(expected, func, args...)	({	\
 	bool __failure = false;					\
@@ -663,28 +671,28 @@ static int __init test_overflow_size_helpers(void)
 				     flex_array_size, obj, data, var++);
 	err |= check_one_size_helper(5 * sizeof(*obj->data),
 				     flex_array_size, obj, data, var++);
-	err |= check_one_size_helper(0, flex_array_size, obj, data, 0);
+	err |= check_one_size_helper(0, flex_array_size, obj, data, 0 + unconst);
 	err |= check_one_size_helper(sizeof(*obj->data),
-				     flex_array_size, obj, data, 1);
+				     flex_array_size, obj, data, 1 + unconst);
 	err |= check_one_size_helper(7 * sizeof(*obj->data),
-				     flex_array_size, obj, data, 7);
+				     flex_array_size, obj, data, 7 + unconst);
 	err |= check_one_size_helper(SIZE_MAX,
-				     flex_array_size, obj, data, -1);
+				     flex_array_size, obj, data, -1 + unconst);
 	err |= check_one_size_helper(SIZE_MAX,
-				     flex_array_size, obj, data, SIZE_MAX - 4);
+				     flex_array_size, obj, data, SIZE_MAX - 4 + unconst);
 
 	var = 4;
 	err |= check_one_size_helper(sizeof(*obj) + (4 * sizeof(*obj->data)),
 				     struct_size, obj, data, var++);
 	err |= check_one_size_helper(sizeof(*obj) + (5 * sizeof(*obj->data)),
 				     struct_size, obj, data, var++);
-	err |= check_one_size_helper(sizeof(*obj), struct_size, obj, data, 0);
+	err |= check_one_size_helper(sizeof(*obj), struct_size, obj, data, 0 + unconst);
 	err |= check_one_size_helper(sizeof(*obj) + sizeof(*obj->data),
-				     struct_size, obj, data, 1);
+				     struct_size, obj, data, 1 + unconst);
 	err |= check_one_size_helper(SIZE_MAX,
-				     struct_size, obj, data, -3);
+				     struct_size, obj, data, -3 + unconst);
 	err |= check_one_size_helper(SIZE_MAX,
-				     struct_size, obj, data, SIZE_MAX - 3);
+				     struct_size, obj, data, SIZE_MAX - 3 + unconst);
 
 	pr_info("%d overflow size helper tests finished\n", count);
 
-- 
2.32.0


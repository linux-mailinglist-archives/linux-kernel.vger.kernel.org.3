Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE1B543F35
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiFHWfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236634AbiFHWfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:35:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686981D4DC3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 15:35:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w13-20020a17090a780d00b001e8961b355dso7973595pjk.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 15:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QkfG3CN6VP7C6URzXpCUgAMNHT6wVB7vqkw29Zwtti8=;
        b=aVmSd5Qm43ot4Iz6ZdHjcy1oJnJoZREHn5Iz8ybmYiwx2DSn9VAdXPHEVwL2Vubyaj
         fikCdsfY2d5SNFlxXkk4Dm8OGFn4ESH19O28hn21JRsO3WBLpw3ca1+ZztdYXLo7Uz5f
         UnEmYMCv9RjzQq/kSUfGLvzYHOcXaic2qyWuZu6CJHMpeESeNSvfi1hokmVzWExONL91
         BmpNbBQ4BUwXWirTRSFKrfy0Dt1+s/ATmOYCKQDJOeRVeMqPMktzjCztbtvu2TWYV/zO
         havqXOpDEMFcSHUeK9hBcU+wsjYHOWedKV7Tgkgw0XklrIZcJeruOcvB+QUSYqrnv3c4
         P2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QkfG3CN6VP7C6URzXpCUgAMNHT6wVB7vqkw29Zwtti8=;
        b=8CwH4jRUEJbLQQHSlo0eK44Svzy7cVnGKTmjq4smH0du6JTqiquQvDwwcPPIryLxTx
         JVGg06LlF+6KKiYOfJ6sSw2x4LljctJP/EYb1iyDF3PqnEZebqKBd+Dd5JjmBD4Uo90R
         YHhRPEfGnAv5tq/IysYMrB/fG4uDJhgduvsO9+CJ0Q3ec7AY+aWcpGtEmp+irg1S83YK
         h7TgI0f4eHBuNC/NQeXVWs4iqgJi1bcFGAbxT4uq2SEmff6Gq8Lgq72NJLHw4S21j9Mz
         onyg6YGXCJJPV97qKHFkttQTq1Jkb5yYrRSArxV8YrORLkeV0RhHDrG4NhbAWgHkZDEw
         dZZw==
X-Gm-Message-State: AOAM533v2p7NhNgoXeRhYB7wIkwMtTJaJdrIsLxNMF8tvnLTx9bpLiJj
        raAKsNkesU9MTWvlJaBs3j4=
X-Google-Smtp-Source: ABdhPJxP8xhSZFpzrx8YPSQgMGYtyQAtidz5XK8BadsQSYqXUyDGJ5Pzgkq4Isax41MsJUyi6JB38A==
X-Received: by 2002:a17:90b:4c8c:b0:1e8:5607:7ec0 with SMTP id my12-20020a17090b4c8c00b001e856077ec0mr251063pjb.36.1654727744901;
        Wed, 08 Jun 2022 15:35:44 -0700 (PDT)
Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:2396:fa38:7c58:2e7b])
        by smtp.googlemail.com with ESMTPSA id t185-20020a625fc2000000b0051b9d15fc18sm15726494pfb.156.2022.06.08.15.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 15:35:44 -0700 (PDT)
From:   Justin Stitt <jstitt007@gmail.com>
X-Google-Original-From: Justin Stitt <justinstitt@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>,
        Justin Stitt <jstitt007@gmail.com>
Subject: [PATCH v3] include/uapi/linux/swab.h: move explicit cast outside ternary
Date:   Wed,  8 Jun 2022 15:35:39 -0700
Message-Id: <20220608223539.470472-1-justinstitt@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Stitt <jstitt007@gmail.com>

A cast inside __builtin_constant_p doesn't do anything since it should
evaluate as constant at compile time irrespective of this cast. Instead,
I moved this cast outside the ternary to ensure the return type is as
expected.

Additionally, if __HAVE_BUILTIN_BSWAP16__ was not defined then __swab16
is actually returning an `int` not a `u16` due to integer promotion.

As Al Viro notes:
You *can't* get smaller-than-int out of ? :, same as you can't get it
out of addition, etc.

This also fixes some clang -Wformat warnings involving default
argument promotion.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Justin Stitt <jstitt007@gmail.com>
---
 diff from v2 -> v3:
  * re-insert respective (u16, u32, u64) cast to __builtin_bswap as per
     Nick's suggestion
  * added note from Al Viro

 include/uapi/linux/swab.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index 7272f85d6d6a..0723a9cce747 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -102,7 +102,7 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
 #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
 #else
 #define __swab16(x)				\
-	(__builtin_constant_p((__u16)(x)) ?	\
+	(__u16)(__builtin_constant_p(x) ?	\
 	___constant_swab16(x) :			\
 	__fswab16(x))
 #endif
@@ -115,7 +115,7 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
 #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
 #else
 #define __swab32(x)				\
-	(__builtin_constant_p((__u32)(x)) ?	\
+	(__u32)(__builtin_constant_p(x) ?	\
 	___constant_swab32(x) :			\
 	__fswab32(x))
 #endif
@@ -128,7 +128,7 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
 #define __swab64(x) (__u64)__builtin_bswap64((__u64)(x))
 #else
 #define __swab64(x)				\
-	(__builtin_constant_p((__u64)(x)) ?	\
+	(__u64)(__builtin_constant_p(x) ?	\
 	___constant_swab64(x) :			\
 	__fswab64(x))
 #endif
-- 
2.36.1.476.g0c4daa206d-goog


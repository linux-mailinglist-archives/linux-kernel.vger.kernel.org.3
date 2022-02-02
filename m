Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B494A6E92
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbiBBKVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343511AbiBBKVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:21:52 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340BBC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 02:21:52 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c24so41292047edy.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 02:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=onRlZdRbDosaab/y/zUC++ZMX5giuurTyAahBOEwPR8=;
        b=Iw8mIF0IhzTswuIYzJcfjySaSEWJKOjDnQp43YD102crOmlk6ox48nP108mNAPQatc
         scZPiFCncu7zFYS/sGdDAV32PuAL/d0WMFsnJKi/7/U/vBTfLXpKjIYfJys+khnY66Fn
         taN0nCKP4/pAqVCuAHztjDePFlX0QmtWfoQ0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=onRlZdRbDosaab/y/zUC++ZMX5giuurTyAahBOEwPR8=;
        b=gHY0yBS59YulTJFBJxH88JwRI0S+979c8ybTxpvLWb4PaNr0LloU8YS+4YKIUsncMg
         MpwesN1WXtr6HaJaCn33N74WpxLxKwNnMcKxbdGLW/d2bWubcI3iQelJWhaTgKD4K1Ho
         toMqMXDYINKktKMrpGYDX2Bl8kxHPxJp0Byo7GIOm13ydCjt9alukGqJjHVgyozP85Il
         Dg7z6qVs5oy3jfKj7sQnZpZp8xn9W4attllqACPx20CgPSWogszN705SpVkuPGfrkegH
         iRwsFInZ0KoQqS7RaokjSycuCbj5Uewrzgxa3nVOgQVwmnxsIQNja9N55YXvbc0QbpL6
         1RJA==
X-Gm-Message-State: AOAM533Id7jsAdN5dvF78xCnq8is3nfWsHdYZTlADr+5zPsF59DOiuzj
        hlSnk1M4/79+nV+uiY2TIBUWbpOgUg22n6Ao
X-Google-Smtp-Source: ABdhPJx+fpprtlVWRfOIbm22oor83E+wyYwA4ey03sqFiVnjRuxsTVTcpecmQmC5c/zbGMz6xVJlmw==
X-Received: by 2002:a05:6402:2682:: with SMTP id w2mr29049244edd.355.1643797310747;
        Wed, 02 Feb 2022 02:21:50 -0800 (PST)
Received: from localhost.localdomain ([80.208.64.233])
        by smtp.gmail.com with ESMTPSA id v2sm15277559ejb.114.2022.02.02.02.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 02:21:50 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] include: drop pointless __compiler_offsetof indirection
Date:   Wed,  2 Feb 2022 11:21:47 +0100
Message-Id: <20220202102147.326672-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(1) compiler_types.h is unconditionally included via an -include
flag (see scripts/Makefile.lib), and it defines __compiler_offsetof
unconditionally. So testing for definedness of __compiler_offsetof is
mostly pointless.

(2) Every relevant compiler provides __builtin_offsetof (even sparse
has had that for 14 years), and if for whatever reason one would end
up picking up the poor man's fallback definition (C file compiler with
completely custom CFLAGS?), newer clang versions won't treat the
result as an Integer Constant Expression, so if used in place where
such is required (static initializer or static_assert), one would
get errors like

t.c:11:16: error: static_assert expression is not an integral constant expression
t.c:11:16: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
t.c:4:33: note: expanded from macro 'offsetof'
#define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)

So just define offsetof unconditionally and directly in terms of
__builtin_offsetof.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/compiler_types.h | 2 --
 include/linux/stddef.h         | 6 +-----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3c1795fdb568..83ee7f7ada5d 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -137,8 +137,6 @@ struct ftrace_likely_data {
  */
 #define __naked			__attribute__((__naked__)) notrace
 
-#define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
-
 /*
  * Prefer gnu_inline, so that extern inline functions do not emit an
  * externally visible function. This makes extern inline behave as per gnu89
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index ca507bd5f808..929d67710cc5 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -13,11 +13,7 @@ enum {
 };
 
 #undef offsetof
-#ifdef __compiler_offsetof
-#define offsetof(TYPE, MEMBER)	__compiler_offsetof(TYPE, MEMBER)
-#else
-#define offsetof(TYPE, MEMBER)	((size_t)&((TYPE *)0)->MEMBER)
-#endif
+#define offsetof(TYPE, MEMBER)	__builtin_offsetof(TYPE, MEMBER)
 
 /**
  * sizeof_field() - Report the size of a struct field in bytes
-- 
2.31.1


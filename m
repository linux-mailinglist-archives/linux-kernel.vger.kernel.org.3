Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAC4542644
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiFHC1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446606AbiFHCU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 22:20:56 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AF7107888
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 17:14:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j6so16873404pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 17:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=45epDQdJCBp4DgsIx1Sz2CxwS+YHltdpTyZ3wnT8hgs=;
        b=aQTromRtl9Y8U0lSwdvw9JG/L6+ooOtEs95fFlo72XqRmwp+oPMHpnTAvjNmGlpzcP
         P6SsxkAWmuw0sO2drXqm1qW6y86edJ8FtkvwTqyy4Z7F6OskExf3akYJDxmxgb5UAgEV
         8bnEHiAjLg/Jxwg5mj4zvzCh5ZXxVmBgxmlJ12LeG4M6EzrOJ8uGq1Rw/fzsJc4GBCWO
         PMxIEj7Iii+JdU2tsKoIb/+EKDVglzEsSFNuA4D0YpNmwKdz2cUIzUAlhCMEtwzPCm4L
         qaUeh1GXO75cY11pQH5OhdAedvysyZBHTpwZ9xYnLGd0pEetd+sadM8v5NNfj9ghO8in
         FiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45epDQdJCBp4DgsIx1Sz2CxwS+YHltdpTyZ3wnT8hgs=;
        b=5VQ9ujpbhz/XQq8aMnqU6OBx8tT8Qr164/neEgXR8YEgKYzZYfIZrJsuPfQyu8oPy5
         QyO7gmC3W/U5ONXwocc7T5kxZ7uOwLUPY1vFw+X5B30s7pfuZktUGOaJTgyQGlRRgKW1
         gWb0vtKi6DR4fybla4nuNCJcpGeegGoYszdXdKQIZE5xuC8cwem+94uQZ/viqupj8Hfs
         OvD7AhSpX70qY3EHBkE0qxiW2BddEZSXoTE4eg3pz23b79EtDNxufExuyqtjJYT5zyft
         K1th4BjLAPR/o8pUyXx63hkNk5VRB9c4w7ykSQlmPIS2UNg1lVQGhQNRgbuVPCNs/sDS
         fD0Q==
X-Gm-Message-State: AOAM530qSYdLkozLdffUGRTle9x3+a2jXJ860LNquMeUMkSczLjlibg/
        nDb6ZeNUi08vom3pBXImQpY=
X-Google-Smtp-Source: ABdhPJyp28p2GDv7dkrNLXwv8Yj9hsL5KfMbOVCvI7otC6p6OS3I+JYKTxX9fdbZfv/y1by8dd43Kw==
X-Received: by 2002:a63:6b41:0:b0:3fe:22d6:e6aa with SMTP id g62-20020a636b41000000b003fe22d6e6aamr2305774pgc.249.1654647291916;
        Tue, 07 Jun 2022 17:14:51 -0700 (PDT)
Received: from penguin.lxd ([2620:0:1000:2514:216:3eff:fe31:a1ca])
        by smtp.googlemail.com with ESMTPSA id t1-20020a63f341000000b003fc4cc19414sm13458821pgj.45.2022.06.07.17.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 17:14:51 -0700 (PDT)
From:   Justin Stitt <jstitt007@gmail.com>
To:     ndesaulniers@google.com, akpm@linux-foundation.org
Cc:     jstitt007@gmail.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, trix@redhat.com
Subject: [PATCH v2] include/uapi/linux/swab.h: move explicit cast outside ternary
Date:   Tue,  7 Jun 2022 17:14:22 -0700
Message-Id: <20220608001422.26383-1-jstitt007@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAKwvOd=-NXR5HoHwwEUZMsCt90oaADH6XHifje9n-8S8rj9SFw@mail.gmail.com>
References: <CAKwvOd=-NXR5HoHwwEUZMsCt90oaADH6XHifje9n-8S8rj9SFw@mail.gmail.com>
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

A cast inside __builtin_constant_p doesn't do anything since it should evaluate
as constant at compile time irrespective of this cast. Instead, I moved this
cast outside the ternary to ensure the return type is as expected.

For instance, if __HAVE_BUILTIN_BSWAP16__ was not defined then __swab16 is
actually returning an `int` not a `u16` due to integer promotion as described
by Nick in this thread. This has repercussions when building with clang
-Wformat. This fix should solve many of these warnings.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Justin Stitt <jstitt007@gmail.com>
---
 include/uapi/linux/swab.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index f6be3f2e6fee..ab5a1283800c 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -99,10 +99,10 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
  * @x: value to byteswap
  */
 #ifdef __HAVE_BUILTIN_BSWAP16__
-#define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
+#define __swab16(x) (__u16)__builtin_bswap16(x)
 #else
 #define __swab16(x)				\
-	(__u16)(__builtin_constant_p((__u16)(x)) ?	\
+	(__u16)(__builtin_constant_p(x) ?	\
 	___constant_swab16(x) :			\
 	__fswab16(x))
 #endif
@@ -112,10 +112,10 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
  * @x: value to byteswap
  */
 #ifdef __HAVE_BUILTIN_BSWAP32__
-#define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
+#define __swab32(x) (__u32)__builtin_bswap32(x)
 #else
 #define __swab32(x)				\
-	(__builtin_constant_p((__u32)(x)) ?	\
+	(__u32)(__builtin_constant_p(x) ?	\
 	___constant_swab32(x) :			\
 	__fswab32(x))
 #endif
@@ -125,10 +125,10 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
  * @x: value to byteswap
  */
 #ifdef __HAVE_BUILTIN_BSWAP64__
-#define __swab64(x) (__u64)__builtin_bswap64((__u64)(x))
+#define __swab64(x) (__u64)__builtin_bswap64(x)
 #else
 #define __swab64(x)				\
-	(__builtin_constant_p((__u64)(x)) ?	\
+	(__u64)(__builtin_constant_p(x) ?	\
 	___constant_swab64(x) :			\
 	__fswab64(x))
 #endif
-- 
2.30.2


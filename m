Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51FC5424C6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442269AbiFHCAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835760AbiFGX4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:56:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFC61F61D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 16:20:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u26so29866192lfd.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 16:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJadlcijpEraHCzXfyi7dHvp0N+x8osaIwQlxh9G2bY=;
        b=Z0ia+eLjj6yYhXvzoGPJY2ac0xIAPYnyriaetuCT3yoo9N/HOqP4XHzBGfMavxNlGQ
         JLjlyCYB5YLQc1PwQqza+kuCemyXvU+6AdZYjKQaoHP7z2E8K8oFFC5L4Q6cnM5JlFId
         EYJy6ZGMqU9k/lpBl+tq3yRhcdXnfg4GGxbc6IvuGEofwwTGWi2q0fFdCX4SSnO1btc4
         LWirHSmpgUAOz3v+bCyo21FfstCG4S0rRaZ/7ZgdLn6nFlBpKLo+JOkIWk87m90vdBE5
         1Wzkx4tFR26DuHShOoFlyOVaLcTGbfSc22D80wD2jfOVwvttkNKZ0ES6XCvZwi7/1i3F
         ZvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJadlcijpEraHCzXfyi7dHvp0N+x8osaIwQlxh9G2bY=;
        b=DNXJeZ27rn0cZSdDpCvibIWEWDknd4elrfVf3+pfUfSbx+VXy7di1vm24VDiGl8gE/
         Zvt/VMnxcU2URF0QbUd82Clfhf1+62Cws6mR/oT5dOCPhyMWg3dPQoSmrguvm2Uy/x1n
         UVPbT5jqKL86dtc2Y79PTWM2dTlAWItDIVn5t2JztITWT48kJg6Ouigh6C48++GR3ejG
         FAFiNVjh59qOt5sPh6E/A0cSCDQDG3MWO0ci6yOUVe8brpnEem9bbT4D86T+qP4wYBc9
         dE48nn+lyi4AnERE+oFlUV/ON5BgHLkwyaLk/3K+0awZ+4AvDdWaWs2yknb0lLuxIRFl
         D8bQ==
X-Gm-Message-State: AOAM533n2LjGFPFBqDqs87D6Eqj7kCdvKNtmioHry/rDuubs9F5nyJzQ
        0itWZ0jYcxDMCvNwitnzjGnz8D6/ulgqcR8Y5ZweKw==
X-Google-Smtp-Source: ABdhPJxMM91AMDYynBTs5Q7XtkgbyiYpxCwW9+RLJVrUt/uZz2PBE4EVkez8NfMupZZuHvJ7gQ8aix+PQfB54ft4sBs=
X-Received: by 2002:a05:6512:3f94:b0:478:7abe:de4a with SMTP id
 x20-20020a0565123f9400b004787abede4amr54322287lfa.401.1654644029597; Tue, 07
 Jun 2022 16:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220607222006.22719-1-jstitt007@gmail.com>
In-Reply-To: <20220607222006.22719-1-jstitt007@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Jun 2022 16:20:17 -0700
Message-ID: <CAKwvOd=-NXR5HoHwwEUZMsCt90oaADH6XHifje9n-8S8rj9SFw@mail.gmail.com>
Subject: Re: [PATCH] include/uapi/linux/swab.h: add __u16 cast to __swab16 conditional
To:     Justin Stitt <jstitt007@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 3:20 PM Justin Stitt <jstitt007@gmail.com> wrote:
>
> if __HAVE_BUILTIN_BSWAP16__ is defined then __swab16 utilizes a __u16 cast.
> This same cast should be used if __HAVE_BUILTIN_BSWAP16__ is not defined as
> well. This should fix loads (at least a few) clang -Wformat warnings
> specifically with `ntohs()`
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Justin Stitt <jstitt007@gmail.com>

I wonder why there's a cast inside the __builtin_constant_p parameter
list? Can't imagine that changing anything. I wonder if this should
be:

diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index 7272f85d6d6a..0723a9cce747 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -102,7 +102,7 @@ static inline __attribute_const__ __u32
__fswahb32(__u32 val)
 #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
 #else
 #define __swab16(x)                            \
-       (__builtin_constant_p((__u16)(x)) ?     \
+       (__u16)(__builtin_constant_p(x) ?       \
        ___constant_swab16(x) :                 \
        __fswab16(x))
 #endif
@@ -115,7 +115,7 @@ static inline __attribute_const__ __u32
__fswahb32(__u32 val)
 #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
 #else
 #define __swab32(x)                            \
-       (__builtin_constant_p((__u32)(x)) ?     \
+       (__u32)(__builtin_constant_p(x) ?       \
        ___constant_swab32(x) :                 \
        __fswab32(x))
 #endif
@@ -128,7 +128,7 @@ static inline __attribute_const__ __u32
__fswahb32(__u32 val)
 #define __swab64(x) (__u64)__builtin_bswap64((__u64)(x))
 #else
 #define __swab64(x)                            \
-       (__builtin_constant_p((__u64)(x)) ?     \
+       (__u64)(__builtin_constant_p(x) ?       \
        ___constant_swab64(x) :                 \
        __fswab64(x))
 #endif
--
Thanks,
~Nick Desaulniers

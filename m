Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539764AE5B2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbiBHX6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbiBHX63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:58:29 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48884C061577
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:58:28 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id on2so612321pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 15:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Al312nSB11RWQ/fPz/oLtgMbGtxfQXub9WO/1WYfmpk=;
        b=QVhTkuP6g5ht0lSUDdZXX4ML54Png+mqetf03uPCTSZEbVJJRRik/1zcMYrH17WVc3
         bpnDG1ZupaKCXeN7lPCDGJ5EAv8dmXPG65CXGhHlRVFz0gJq0z1+3Q/Xv+P/D3bFVjZC
         pq+jYhiAV+G8dH8pK+8L0b1G59nytVkjzXk1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Al312nSB11RWQ/fPz/oLtgMbGtxfQXub9WO/1WYfmpk=;
        b=ebRbpZTwZ7RABWFlafXnYmD6JFL33PiangSNPXesYvE9IkDyWk8kO4tHc5izuY6Kjh
         qSn4tjgNeY6WCZVUzfSGGIOq8WEoL1BzjWP7h9okECXmBnCMiXwGwkZJaL/C+65DQTPQ
         XbnPstCk2ru6SMU1IFDXEiPvOYpj7Hmrb05unEWuNXeCylePe8ezLjbml569ij0RR0yC
         Yh04/QpkrndsAGH5C3B75OnXaeVyKGfGj68fAFOSdqf+UQRJepy3Gbg7121VAw+oVRBm
         UqLXX92+mH4nbnXwwQCOitVvwPfvONrPo8O/eCb2Zn4hGRIS3lg2oUbcDyAtiaIpGVHd
         rH8A==
X-Gm-Message-State: AOAM532cvFw+NcUKm2hwYTWtB3w3BevlSfuGuJJmzWuM1peDsJiwiF2w
        mxnGBQ9lW210FTSn8JxKhjX2QA==
X-Google-Smtp-Source: ABdhPJw+/mRo5ofjXEkCHagXxoE3e/S1IZPBO5qaKIqgxKt9qk6CwAf4EaSB4bnfRh2kzoYBWuaIAw==
X-Received: by 2002:a17:902:e88e:: with SMTP id w14mr6839434plg.95.1644364707754;
        Tue, 08 Feb 2022 15:58:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r7sm6748208pgv.15.2022.02.08.15.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 15:58:27 -0800 (PST)
Date:   Tue, 8 Feb 2022 15:58:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v7 7/8] fortify: Make sure strlen() may still be used as
 a constant expression
Message-ID: <202202081555.ED0C0658@keescook>
References: <20220208225350.1331628-1-keescook@chromium.org>
 <20220208225350.1331628-8-keescook@chromium.org>
 <CAKwvOd=wre3uzFVBFaOs4Oud+SobxiW_BwKXMsa5p0tEy6BsiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=wre3uzFVBFaOs4Oud+SobxiW_BwKXMsa5p0tEy6BsiA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 03:17:13PM -0800, Nick Desaulniers wrote:
> On Tue, Feb 8, 2022 at 2:53 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > In preparation for enabling Clang FORTIFY_SOURCE support, redefine
> > strlen() as a macro that tests for being a constant expression
> > so that strlen() can still be used in static initializers, which is
> > lost when adding __pass_object_size and __overloadable.
> >
> > An example of this usage can be seen here:
> >         https://lore.kernel.org/all/202201252321.dRmWZ8wW-lkp@intel.com/
> >
> > Notably, this constant expression feature of strlen() is not available
> > for architectures that build with -ffreestanding. This means the kernel
> > currently does not universally expect strlen() to be used this way, but
> > since there _are_ some build configurations that depend on it, retain
> > the characteristic for Clang FORTIFY_SOURCE builds too.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/fortify-string.h | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> > index db1ad1c1c79a..f77cf22e2d60 100644
> > --- a/include/linux/fortify-string.h
> > +++ b/include/linux/fortify-string.h
> > @@ -2,6 +2,8 @@
> >  #ifndef _LINUX_FORTIFY_STRING_H_
> >  #define _LINUX_FORTIFY_STRING_H_
> >
> > +#include <linux/const.h>
> > +
> >  #define __FORTIFY_INLINE extern __always_inline __gnu_inline
> >  #define __RENAME(x) __asm__(#x)
> >
> > @@ -95,9 +97,16 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const p, __kernel_size_t m
> >         return ret;
> >  }
> >
> > -/* defined after fortified strnlen to reuse it. */
> > +/*
> > + * Defined after fortified strnlen to reuse it. However, it must still be
> > + * possible for strlen() to be used on compile-time strings for use in
> > + * static initializers (i.e. as a constant expression).
> > + */
> > +#define strlen(p)                                                      \
> > +       __builtin_choose_expr(__is_constexpr(__builtin_strlen(p)),      \
> 
> Is `__is_constexpr(p) == __is_constexpr(__builtin_strlen(p))`? i.e.
> can we drop the first `__builtin_strlen`? It seems redundant.
> 
> So instead, we'd have:
> 
> #define strlen(p) __builtin_choose_expr(__is_constexpr(p),
> __builtin_strlen(p), __fortify_strlen(p))
> 
> Or is there some funny business where p isn't constexpr but strlen(p)
> somehow is? I doubt that.  (Or is it that p is constexpr, but
> strlen(p) is not?)
> 
> (Guess I'm wrong: https://godbolt.org/z/19ffz7vjx)

Yeah, as you've discovered ... funny business. :P

> Ok then.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks!

-- 
Kees Cook

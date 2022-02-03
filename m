Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978824A88C0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352297AbiBCQl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352291AbiBCQlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:41:25 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5C7C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:41:25 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id h12so2920121pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 08:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1evXhfpbBKElbnPFpb9YOErw3xinbR29/m37zDfFiAw=;
        b=S/UAP0f153LFonp1hCXbIVWAfYmrYBM8A9I4S4MSqcNaBK/XGFbffMh95ZGYIZ02J2
         J30wn/NHcxDB9DTV6U1ItVXuLRqx+8GWqMlsxpvlKrDFs01zr0cJYjALOlGuFxEsxc2I
         SsWacMJDXRmANGCDAQkwxE9ivNqKuc+pELREQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1evXhfpbBKElbnPFpb9YOErw3xinbR29/m37zDfFiAw=;
        b=GaUNpGLhnao4pc4n2VUIwbkukJqblpO3yKDJUKCz8KBeqfJr2zfjZwFg3BpSWGEOj5
         KNwqeiiRuTD43LUXvcAkTLO/XXBynY9AS4tzuLP49i8FoEt8vZS0BLVv5fLkcGq+YapF
         3DvweoHmW/5D/KY1szQODAQ2LF/VWgdCn2OHSwwBvhbD3a9umFKH5T28ZIxgMzikkQbz
         3/d8SXDOWnnd5vvLbeJJahMYfwVJgkGcMIhfK3Sa8yL4eRIuf32Bg/XdSNVGLMTfwEuQ
         X38LNsL96Ta9hiecX0zkPbmi8imEO+wl7IsmN2vg2R+Yn0Qfw/eXw4GlQVny7nKMukqz
         gXBg==
X-Gm-Message-State: AOAM532UQHefke3ybJHLnje6NNicySpS4enEvQwQ6RmlM4JeA1QqPdxL
        TwqB9tg/WPZJzhUJyh2ayCU9tw==
X-Google-Smtp-Source: ABdhPJzMqsctX1naiJ7QdADWrvnbSgaWNfF861ADFSzgLjkBcEQ0An+n3G1dZLDGYZsYZmDRJlHqEw==
X-Received: by 2002:a17:902:8f8e:: with SMTP id z14mr24281634plo.28.1643906485287;
        Thu, 03 Feb 2022 08:41:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d20sm3234791pfu.9.2022.02.03.08.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:41:24 -0800 (PST)
Date:   Thu, 3 Feb 2022 08:41:24 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
Message-ID: <202202030840.74FCB6868@keescook>
References: <20220130183653.491292-1-keescook@chromium.org>
 <20220202160149.GA2322037@roeck-us.net>
 <202202021237.487D3DE73@keescook>
 <5ff18cff-6cfd-1f85-da74-1e5660a1a250@roeck-us.net>
 <CAMuHMdWssK2=NFc6NO-inQg5dWxZP4Wv41K3J3RqRXThXatovw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWssK2=NFc6NO-inQg5dWxZP4Wv41K3J3RqRXThXatovw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 09:04:22AM +0100, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> On Thu, Feb 3, 2022 at 12:12 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > On 2/2/22 12:52, Kees Cook wrote:
> > > On Wed, Feb 02, 2022 at 08:01:49AM -0800, Guenter Roeck wrote:
> > >> On Sun, Jan 30, 2022 at 10:36:53AM -0800, Kees Cook wrote:
> > >>> Add a simple test for strlen() functionality, including using it as a
> > >>> constant expression.
> > >>>
> > >>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > >>> Cc: Peter Rosin <peda@axentia.se>
> > >>> Signed-off-by: Kees Cook <keescook@chromium.org>
> > >>> ---
> > >>> I'll be taking this as part of my Clang FORTIFY_SOURCE series.
> > >>> ---
> > >>>   lib/test_string.c | 37 +++++++++++++++++++++++++++++++++++++
> > >>>   1 file changed, 37 insertions(+)
> > >>>
> > >>> diff --git a/lib/test_string.c b/lib/test_string.c
> > >>> index 9dfd6f52de92..59994f552c48 100644
> > >>> --- a/lib/test_string.c
> > >>> +++ b/lib/test_string.c
> > >>> @@ -179,6 +179,38 @@ static __init int strnchr_selftest(void)
> > >>>     return 0;
> > >>>   }
> > >>>
> > >>> +/*
> > >>> + * Unlike many other string functions, strlen() can be used in
> > >>> + * static initializers when string lengths are known at compile
> > >>> + * time. (i.e. Under these conditions, strlen() is a constant
> > >>> + * expression.) Make sure it can be used this way.
> > >>> + */
> > >>> +static const int strlen_ce = strlen("tada, a constant expression");
> > >>> +
> > >>
> > >> This results in:
> > >>
> > >> lib/test_string.c:188:30: error: initializer element is not constant
> > >>    188 | static const int strlen_ce = strlen("tada, a constant expression");
> > >>
> > >> for several of my tests. I don't think you can mandate that a compiler
> > >> implements this.
> > >
> > > Which tests?
> > >
> >
> > Some examples:
> >
> > Build reference: next-20220202
> > Compiler version: m68k-linux-gcc (GCC) 11.2.0
> >
> > Building m68k:defconfig ... failed
> > --------------
> > Error log:
> > lib/test_string.c:188:30: error: initializer element is not constant
> >    188 | static const int strlen_ce = strlen("tada, a constant expression");
> >
> > Building mips:malta_defconfig:nocd:smp:net,e1000:initrd ... failed
> > ------------
> > Error log:
> > lib/test_string.c:188:30: error: initializer element is not constant
> >   static const int strlen_ce = strlen("tada, a constant expression");
> >
> > Building i386:q35:Broadwell:defconfig:smp:ata:net,rtl8139:hd ... failed
> > ------------
> > Error log:
> > lib/test_string.c:188:30: error: initializer element is not constant
> >    188 | static const int strlen_ce = strlen("tada, a constant expression");
> >
> > i386 and is defconfig + CONFIG_STRING_SELFTEST=y; mips is
> > malta_defconfig + CONFIG_STRING_SELFTEST=y. All use gcc 11.2.
> >
> > There may be more, but there are so many failures in -next right now
> > that I may be missing some.
> >
> > > This property of strlen() is already required by our builds (this is how
> > > I tripped over it). For example:
> > >
> > > drivers/firmware/xilinx/zynqmp-debug.c:
> > >
> > > #define PM_API(id)               {id, #id, strlen(#id)}
> > > static struct pm_api_info pm_api_list[] = {
> > >          PM_API(PM_GET_API_VERSION),
> > >          PM_API(PM_QUERY_DATA),
> > > };
> >
> > I do not think that it is a C standard that strlen() on a constant string
> > must be compile-time evaluated and result in a constant.
> 
> Not if -ffreestanding, which is what several architectures are
> using nowadays, to a.o. prevent gcc from replacing calls to stdlib
> functions to other stdlib functions (e.g. strncat() -> strlen() +
> store, strncmp() -> strcmp()), which breaks linking if the latter is
> only provided inline.
> 
> > Anyway, key difference, I think, is the presence of an architecture-specific
> > version of strlen(), or the maybe non-presence of __HAVE_ARCH_STRLEN,
> > or the definition of strlen() in include/linux/fortify-string.h.
> 
> It works after dropping -ffreestanding.

Ah-ha, thanks for the clue here. I'll see if there is some way to
detect this (or, I guess, drop the patch). I don't like that this
requirement depends on the architecture, so I'd rather it behave the
same everywhere. Hmm

-- 
Kees Cook

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08F74A8D2A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354022AbiBCUZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiBCUZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:25:44 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4039CC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 12:25:44 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id g20so3204658pgn.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 12:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w+LLHTNkjCg8G8mpinMROaqEcNPU0yQi3XK+MfA4g/k=;
        b=I+xZHAsR/mNWONu8dpx9fGkVLIfWe3cXRpfSSxEUM7vLO2X41zknnLrpYnEz4p5hZ+
         gPLcMYVaye+rM09VuDz+D1YKggIgy6P7mRmp17K7r+adtDephAGK/KWBpiPqIed0blHP
         Yo0oHmE/BEkSn35OFUCTr5TOv/uk/HvAVLbmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w+LLHTNkjCg8G8mpinMROaqEcNPU0yQi3XK+MfA4g/k=;
        b=QyhSwtDrhL0eu0jjdJNxupA9Yw/+eoYUTY4cwj35oO0C5p3v6jil5oogyFkTxXdUBR
         rPSVbxmaX3OT6PvlJU0JgfoXLtp0PZo2GeadaSq2FHJWZsFIKQVNw72BF353eSpwKRIk
         EdxNDweTMZLmYIJPnxtHF2FsY0wrxVF+6b8FGBIGtD0/Lbhs72zx2wBzsNjmnSRAAMOn
         0OUAbJZrak4dLVrXmryocAU+igdZ47xUArp3BY/PPfwfvrCxjiRwWJBTaLamOCEBLzVS
         C30AR99X/Pk+EZDz4ReL4Z6Wtt+k+1TmM0kVrKQUd844OY06Ud/UmwO7Pg6y8y05SMgy
         xbiA==
X-Gm-Message-State: AOAM531kfmWw8X8d7BGEYhHWjgResV5J4xIDdQJlFkX29RBKs48X9YoP
        uaREbtErIUUH7w96EuDfbzUk/A==
X-Google-Smtp-Source: ABdhPJxuMUSbjcs7eeh4ZAYGgmCf8XHJfncPDRiBnvq0omOq8R08vFrFhG93FtpinFeN4d+uyewzGg==
X-Received: by 2002:a63:8641:: with SMTP id x62mr29194205pgd.293.1643919943729;
        Thu, 03 Feb 2022 12:25:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t14sm10426596pjd.6.2022.02.03.12.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:25:43 -0800 (PST)
Date:   Thu, 3 Feb 2022 12:25:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
Message-ID: <202202031221.B83DC87374@keescook>
References: <20220130183653.491292-1-keescook@chromium.org>
 <20220202160149.GA2322037@roeck-us.net>
 <202202021237.487D3DE73@keescook>
 <5ff18cff-6cfd-1f85-da74-1e5660a1a250@roeck-us.net>
 <CAMuHMdWssK2=NFc6NO-inQg5dWxZP4Wv41K3J3RqRXThXatovw@mail.gmail.com>
 <202202030911.4914709E@keescook>
 <CAMuHMdUBKofPP-6EofE3B7d6k0zv0nPJ7e4pjsznPF==ApJ6qg@mail.gmail.com>
 <CAKwvOdnJ3w2Jb9tBZ+JnEfviquj2WktemCd833f=_P66a0qVag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnJ3w2Jb9tBZ+JnEfviquj2WktemCd833f=_P66a0qVag@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 11:50:34AM -0800, Nick Desaulniers wrote:
> On Thu, Feb 3, 2022 at 10:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Kees,
> >
> > On Thu, Feb 3, 2022 at 6:15 PM Kees Cook <keescook@chromium.org> wrote:
> > > On Thu, Feb 03, 2022 at 09:04:22AM +0100, Geert Uytterhoeven wrote:
> > > > Not if -ffreestanding, which is what several architectures are
> > > > using nowadays, to a.o. prevent gcc from replacing calls to stdlib
> > > > functions to other stdlib functions (e.g. strncat() -> strlen() +
> > > > store, strncmp() -> strcmp()), which breaks linking if the latter is
> > > > only provided inline.
> > >
> > > Hah, for i386:
> > >
> > > arch/x86/Makefile
> > >         # temporary until string.h is fixed
> > >         KBUILD_CFLAGS += -ffreestanding
> > >
> > > This "temporary" is from 2006. ;)\
> 
> IIRC I sent a patch removing that. Yeah, Kees even signed off on it.
> https://lore.kernel.org/lkml/20200817220212.338670-5-ndesaulniers@google.com/#t
> I still think that's the right way to go, perhaps worth a resend to
> rekick discussions.

Hah. Yay. I'll go pick this into the memcpy topic branch.  Building x86_64
and ia32 differently makes no sense (and this solves the head-scratching
compile-time test failures I was seeing on ia32 too).

> >
> > And before that, we had it in the main Makefile.
> >
> > > 6edfba1b33c7 ("[PATCH] x86_64: Don't define string functions to builtin")
> > >
> > > Removing that appears to solve it, and appears to build correctly. I'll
> > > continue testing.
> > >
> > > > It works after dropping -ffreestanding.
> > >
> > > I wonder if the other architectures were just copying x86?
> >
> > At least on m68k it was added because gcc added new optimizations
> > that broke if an architecture provides some functions as inline.
> > As the kernel is not supposed to be linked with the standard C
> > library, -ffreestanding should be correct, isn't it?
> 
> The kernel does not link against a libc; but it does provide many
> symbols that libc would provide, with the same or similar enough
> semantics that I would strongly recommend we _don't_ use
> -ffreestanding in order to get such libcall optimizations (there are a
> lot; see https://github.com/llvm/llvm-project/blob/main/llvm/lib/Transforms/Utils/SimplifyLibCalls.cpp
> for some examples) and simply use -fno-builtin-* when necessary, or
> fix the kernel implementations individually.

Right, so, I think for x86 it's straight forward. For the other
architectures it may need more careful checking, so I'm just going
to drop the new test from the memcpy topic branch, and maybe start a
"-ffreestanding removal" topic branch so there isn't a cross-dependency
here.

-- 
Kees Cook

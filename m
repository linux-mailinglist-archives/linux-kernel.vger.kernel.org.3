Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A5547F2F8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 11:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhLYK0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 05:26:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45234 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhLYK0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 05:26:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE5FC60C67;
        Sat, 25 Dec 2021 10:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD69C36AEB;
        Sat, 25 Dec 2021 10:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640428005;
        bh=CNUfBvBgi/J3c+aw188ktUWVlWfu0JLSQiRrc8Jf1kw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SGmat4V7zEj5EQ/4IcTTG384eMMr4YHBEJjD8SA08JgZik1ho9YFf/kvmR9FBX1iq
         s1jYFQVSeZmRUQ6L54FyRZFBTvE+shzD2qX67mEBwbnUI3ImHX3hQMqUwRnuUV4Ldh
         arZpCv4IQwFd77gNGlmE+GbA3BNPRlMyXvoJjfbURD1qCk+YgAHlC5EfPb4SxcvXm4
         vhQE4U4fK9qqjNhq36EL/830DU4X+MpbvZ+NecfYDjictAqlI7GDfgs+HKZED37ODd
         QIreei49UB8hCi1a4cyX2ARtbxhmEII1FibrBSeGhf91yAQvoajPi3isgbhyCKXIPk
         3niKC9hm5rYrQ==
Received: by mail-wm1-f47.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so5904896wmd.5;
        Sat, 25 Dec 2021 02:26:45 -0800 (PST)
X-Gm-Message-State: AOAM531TAsBQkyltkh9HIpt2FQ2uHWpxTZf1TRkcwsIJG3i/tqnmALLN
        Dkp+1l4QrieOdnMhVKHkHlqCpNHGq/6hOEyh+PA=
X-Google-Smtp-Source: ABdhPJx7xrvSiDwNkbL1+LnCROnUr9LMiBx0ZXDcEWmxjtxh6RBooxPZZLiFf5UjO3te1K44Jju+T+Vj+eOnXNxM31c=
X-Received: by 2002:a05:600c:3ac5:: with SMTP id d5mr7318705wms.32.1640428003264;
 Sat, 25 Dec 2021 02:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20211223141113.1240679-1-Jason@zx2c4.com> <CAK7LNARjb4=9JOVDdfUg1sxLG4OH-Eko44iEewbr+0Wd+CNf1Q@mail.gmail.com>
In-Reply-To: <CAK7LNARjb4=9JOVDdfUg1sxLG4OH-Eko44iEewbr+0Wd+CNf1Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 25 Dec 2021 11:26:32 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG7PFpj1Oz1osVCBW1NhCHQT+Oc=0WMLYSeRtC1QK4e8Q@mail.gmail.com>
Message-ID: <CAMj1kXG7PFpj1Oz1osVCBW1NhCHQT+Oc=0WMLYSeRtC1QK4e8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib/crypto: blake2s: include as built-in
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Dec 2021 at 10:28, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, Dec 23, 2021 at 11:11 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > In preparation for using blake2s in the RNG, we change the way that it
> > is wired-in to the build system. Instead of kconfig mazes and ifdefs, we
> > use weak symbols, so that an arch version can override the generic
> > version. Then we include the generic version in lib-y, so that it can be
> > removed from the image if the arch version doesn't fallback to it (as is
> > the case on arm though not x86).
>
>
> As I replied in another email, this does not work like that.
>
> Since 7273ad2b08f8ac9563579d16a3cf528857b26f49,
> libs-y are all linked when CONFIG_MODULES=y.
>
>
>
> So, what this patch is doing are:
>
>  - Add __weak to the generic function
>  - Make modules into built-in.
>
>
> Both generic functions and ARM-specific ones
> will remain in vmlinux.
>
> __weak makes it difficult to track which function is
> actually used.
> Using #ifdef CONFIG_* (as the current code does)
> is better.
>
>
>
> >
> > diff --git a/Makefile b/Makefile
> > index d85f1ff79f5c..892ea632ea63 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -668,7 +668,7 @@ drivers-y   := drivers/ sound/
> >  drivers-$(CONFIG_SAMPLES) += samples/
> >  drivers-$(CONFIG_NET) += net/
> >  drivers-y      += virt/
> > -libs-y         := lib/
> > +libs-y         := lib/ lib/crypto/
>
>
> If this is merged, someone will try to
> add random patterns.
> libs-y         := lib/ lib/crypto/ lib/foo/bar/ lib/foo/ba/baz
>
>
>
> lib-y and libs-y are a bad idea in the first place
> and should not be extended any more.
>
> Since this patch is not working as the commit description
> claims, and it is going in the bad direction, so
>
> NACK
>

So we are no longer permitted to use static libraries to provide
routines that should only be pulled into vmlinux on demand? Has this
also changed for things like string routines etc?

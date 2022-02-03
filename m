Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260F44A8B39
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353248AbiBCSKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:10:13 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:46944 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiBCSKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:10:12 -0500
Received: by mail-ua1-f50.google.com with SMTP id c36so6605958uae.13;
        Thu, 03 Feb 2022 10:10:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/hgS+ERDNLODK1leRfRhcIAV22csg/2nDjF16o/r6Y=;
        b=5zn9hiYKFr24Ftfur6f+WMDSFrdpj531C/3eGIdTgthsu3FiCmENQHIrECnPhCrlWZ
         PRj8ZbGULtF3UAKSf6y1+n2nratWCjuBHvt4sAhya+jx/Dzvkj9XS260CkOhQ7RNvilW
         OQhPSAY8IoFhIbB5W81fpEcV9Wo2n4HTReWTG/uT+Zx6OobNWDFEqmuv2F4dbFCJxo1a
         HlqiUEl728vYQraaPzYe1TWmR8Yp7duF9dgVIgtF6D1hc9fO2FnFs0ix0rYwvVyEo8Q8
         tjN9sI8rqY7bS//yNHcKsevzIXppQky4kifYRPbwZa1SOnjw74QDsQMMOb6y/GTOaCTb
         KsYg==
X-Gm-Message-State: AOAM531FvXN9SfaWrfYPk00GVeMUrG1WH6ciz4s5qzb9Lev7HHFAI97a
        C/7ksuBfXvmnstGzNzaWLy67kDcSoaEVSA==
X-Google-Smtp-Source: ABdhPJzxUpm94gLkdSeB2L0sqG1FoQmmc4YXTU6V/JB9lt2w3Kkyy2VEJKHsOzxc+tgunoyAOzqoCw==
X-Received: by 2002:ab0:3c9f:: with SMTP id a31mr16065770uax.141.1643911810358;
        Thu, 03 Feb 2022 10:10:10 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id w6sm6029864uap.12.2022.02.03.10.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 10:10:10 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id p26so6618379uaa.11;
        Thu, 03 Feb 2022 10:10:09 -0800 (PST)
X-Received: by 2002:a67:a401:: with SMTP id n1mr13230708vse.38.1643911809441;
 Thu, 03 Feb 2022 10:10:09 -0800 (PST)
MIME-Version: 1.0
References: <20220130183653.491292-1-keescook@chromium.org>
 <20220202160149.GA2322037@roeck-us.net> <202202021237.487D3DE73@keescook>
 <5ff18cff-6cfd-1f85-da74-1e5660a1a250@roeck-us.net> <CAMuHMdWssK2=NFc6NO-inQg5dWxZP4Wv41K3J3RqRXThXatovw@mail.gmail.com>
 <202202030911.4914709E@keescook>
In-Reply-To: <202202030911.4914709E@keescook>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Feb 2022 19:09:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUBKofPP-6EofE3B7d6k0zv0nPJ7e4pjsznPF==ApJ6qg@mail.gmail.com>
Message-ID: <CAMuHMdUBKofPP-6EofE3B7d6k0zv0nPJ7e4pjsznPF==ApJ6qg@mail.gmail.com>
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
To:     Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Thu, Feb 3, 2022 at 6:15 PM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Feb 03, 2022 at 09:04:22AM +0100, Geert Uytterhoeven wrote:
> > Not if -ffreestanding, which is what several architectures are
> > using nowadays, to a.o. prevent gcc from replacing calls to stdlib
> > functions to other stdlib functions (e.g. strncat() -> strlen() +
> > store, strncmp() -> strcmp()), which breaks linking if the latter is
> > only provided inline.
>
> Hah, for i386:
>
> arch/x86/Makefile
>         # temporary until string.h is fixed
>         KBUILD_CFLAGS += -ffreestanding
>
> This "temporary" is from 2006. ;)

And before that, we had it in the main Makefile.

> 6edfba1b33c7 ("[PATCH] x86_64: Don't define string functions to builtin")
>
> Removing that appears to solve it, and appears to build correctly. I'll
> continue testing.
>
> > It works after dropping -ffreestanding.
>
> I wonder if the other architectures were just copying x86?

At least on m68k it was added because gcc added new optimizations
that broke if an architecture provides some functions as inline.
As the kernel is not supposed to be linked with the standard C
library, -ffreestanding should be correct, isn't it?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

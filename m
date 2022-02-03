Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE18D4A8CB5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353864AbiBCTut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242830AbiBCTus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:50:48 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1806BC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 11:50:48 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id a25so5428979lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVBeKDKPYFp+Sm22VFGesckBrKnktcRnAdKBFblfodE=;
        b=AbjtmmjGWQpWdgmjPMsIc8GVNpR6kfz4i/s3EjeX9oSZeV1gQ+cJTDv9UvwEH5rH6C
         kMf5vi9O1DUi3v8wRd+r927wglgfPiddZu468FnuMFIuDLhtL3ChMK/MxHI7PBY8gzQ/
         zLOk6W9kMaJbsX0qZJ4X9jOZ6qInlhIMmfIyV/8XOmLBwQhOwmWniKtgiynBLd825bbA
         5uSzfQYGoAvd0YSJGL+WNkDpnmx4YYLhUd06MnlzN/B455n933bNLVnktWVuVW1HPvAL
         YcUfyDkoaKoXtKRPjTYXPkTK/x5PDS1HKlZYI/K/8Dlhe6U9B1tNuyAqaavcy5dWL9Sl
         K7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVBeKDKPYFp+Sm22VFGesckBrKnktcRnAdKBFblfodE=;
        b=S7MCZoD4rCMfF5nxCVewCdW+2NeQzhq1dEdIqRD6Eo4cG0DdhKQplQCw2W9L4NaTay
         rmcZrkH1ytpSZe/2ZCbe8rY/aF8d2UQFZdjIxZw7g1xtJPUZVBmhgM8UpiXlaCqNjjIT
         2KvnK1akpo6HwrbgQu59wNHh0aCE7zlQOx5WFxtMOJV7//dYNySnXgWqaTm99gYQu9M8
         x1kLb96djK6TB1Zja+vAUmEW37Lq4sNnoWluoPlXd8tT29TLADmGuVN5A0X/9ko6/XF1
         deNKkqVYlAvvO/lra8yCFAFmEvrCM7XnL7P3r+WT5vXYPB+1iwOC0AFQvVibD/bByErv
         zBCA==
X-Gm-Message-State: AOAM533neAqqZyPX6goAhByU0Eo6Yh+eb+PS5vkGBgcIUvZKktHnp1Ug
        GELkw6EPeL//7lAtPHg4EdLK4mwwGsNstJT4z+lfVA==
X-Google-Smtp-Source: ABdhPJxc3sO/oNI/Ujb2wt/q0D3RYB++ahedSpN+JSsytdZf3f4yykiSmktj8jSXmlhjNSYVKgmXGFiLyRxkOQ+A/4w=
X-Received: by 2002:a2e:954:: with SMTP id 81mr14783838ljj.198.1643917846193;
 Thu, 03 Feb 2022 11:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20220130183653.491292-1-keescook@chromium.org>
 <20220202160149.GA2322037@roeck-us.net> <202202021237.487D3DE73@keescook>
 <5ff18cff-6cfd-1f85-da74-1e5660a1a250@roeck-us.net> <CAMuHMdWssK2=NFc6NO-inQg5dWxZP4Wv41K3J3RqRXThXatovw@mail.gmail.com>
 <202202030911.4914709E@keescook> <CAMuHMdUBKofPP-6EofE3B7d6k0zv0nPJ7e4pjsznPF==ApJ6qg@mail.gmail.com>
In-Reply-To: <CAMuHMdUBKofPP-6EofE3B7d6k0zv0nPJ7e4pjsznPF==ApJ6qg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Feb 2022 11:50:34 -0800
Message-ID: <CAKwvOdnJ3w2Jb9tBZ+JnEfviquj2WktemCd833f=_P66a0qVag@mail.gmail.com>
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 10:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Kees,
>
> On Thu, Feb 3, 2022 at 6:15 PM Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Feb 03, 2022 at 09:04:22AM +0100, Geert Uytterhoeven wrote:
> > > Not if -ffreestanding, which is what several architectures are
> > > using nowadays, to a.o. prevent gcc from replacing calls to stdlib
> > > functions to other stdlib functions (e.g. strncat() -> strlen() +
> > > store, strncmp() -> strcmp()), which breaks linking if the latter is
> > > only provided inline.
> >
> > Hah, for i386:
> >
> > arch/x86/Makefile
> >         # temporary until string.h is fixed
> >         KBUILD_CFLAGS += -ffreestanding
> >
> > This "temporary" is from 2006. ;)\

IIRC I sent a patch removing that. Yeah, Kees even signed off on it.
https://lore.kernel.org/lkml/20200817220212.338670-5-ndesaulniers@google.com/#t
I still think that's the right way to go, perhaps worth a resend to
rekick discussions.

>
> And before that, we had it in the main Makefile.
>
> > 6edfba1b33c7 ("[PATCH] x86_64: Don't define string functions to builtin")
> >
> > Removing that appears to solve it, and appears to build correctly. I'll
> > continue testing.
> >
> > > It works after dropping -ffreestanding.
> >
> > I wonder if the other architectures were just copying x86?
>
> At least on m68k it was added because gcc added new optimizations
> that broke if an architecture provides some functions as inline.
> As the kernel is not supposed to be linked with the standard C
> library, -ffreestanding should be correct, isn't it?

The kernel does not link against a libc; but it does provide many
symbols that libc would provide, with the same or similar enough
semantics that I would strongly recommend we _don't_ use
-ffreestanding in order to get such libcall optimizations (there are a
lot; see https://github.com/llvm/llvm-project/blob/main/llvm/lib/Transforms/Utils/SimplifyLibCalls.cpp
for some examples) and simply use -fno-builtin-* when necessary, or
fix the kernel implementations individually.

-- 
Thanks,
~Nick Desaulniers

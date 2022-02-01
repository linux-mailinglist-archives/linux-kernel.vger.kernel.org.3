Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D004A5D4B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbiBANQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbiBANQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:16:15 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C03C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 05:16:15 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso2863218pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 05:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ksCYgL+3G+j9avSh44FJZlckNASik0bTPJz1BLZJ1iY=;
        b=WrLORAozns9nqKfWJE0RmkGcRAJ4bsY/NR7hTUmc9ksd0oFpyHwC8eO/J2XFksSXxz
         ejTpMykgL1Qq2UHt6zSujHFnHl64tNURmaaHWASNoVqHQGWgtSppjWNnenU608rbLcJB
         KPIN+yO51crgFI+xSfFWvrGS3reoRpiDOWl1J4bCA/vT/xrbZ6FsGGUYx6aGFCi8RtGS
         5hlDyFyK+NZe3UxNuqrrZbQTgGo5lHhjojEC5k+ISgeJ9xRonHwLlMoKv+IZBaxawDHZ
         xHEDYZJsowsJTq/WzvvOMzGIF2OJfCsLW25rxGyHlIYOsVZ8CzPD7uSkBp/iIrkkze4r
         E2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ksCYgL+3G+j9avSh44FJZlckNASik0bTPJz1BLZJ1iY=;
        b=1wqA+MtO21qGpSgMF+Lm6nucpmyJndWPIu9Sj7MQhCiMThkAHGohdqJ55S812uSL61
         yCkKqDgmPiiixYSBuPXqHaAgJkylGVygZAU7lWfjRjMFE7/pKSbgyf1Oaeq5G51evIpO
         5nmIWSlAyum8pj+D1Q6hR3E0sBKgQeQkhrsiK6u8nuF81p5O/UtXOPnKRhEN2lVIKe3t
         A5mYQ6nI3mcPhH0JhgdjooyuypIB5xwtO2+2FYUa+54M/LGCKY1U5MxNOFKa0HX6Z0YU
         LIG8a3U6hxGShjVQ70Di+jkTJcimth/HbQ3jF454u2dixHej3/bzOPWQtzpUdmtHvFXw
         cv9g==
X-Gm-Message-State: AOAM531ytgE789AX6za3dPiJhQOZ09Dj4lZf8GFb4TKid5h4PPP5jKzZ
        iKk7PPi9X+E8cWywEkojFC8y5lTqj84fwh1AjHs=
X-Google-Smtp-Source: ABdhPJwsY8mtBHjCmBE/yRt5+S2wRtdew6P6z1ARY/1yxyczDhaoO6mfSMlLElJD7u08Nt2EXO7/59a6dKJkBsRCE3Q=
X-Received: by 2002:a17:90b:4f83:: with SMTP id qe3mr2264212pjb.120.1643721374784;
 Tue, 01 Feb 2022 05:16:14 -0800 (PST)
MIME-Version: 1.0
References: <20220131201716.5198-1-a3at.mail@gmail.com> <CAMe9rOqoPy6jsWrodnc41M4+b2onwkfbfr=pZ9qRWzOU2Uisgg@mail.gmail.com>
 <20220201061832.yatgwglxvi7ho4yr@carbon.azat>
In-Reply-To: <20220201061832.yatgwglxvi7ho4yr@carbon.azat>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 1 Feb 2022 05:15:38 -0800
Message-ID: <CAMe9rOptn2vpY90yY3HuGmmMdj4Hpaba2PRhp4d033XBDgL_5w@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf: use ELF_ET_DYN_BASE for PIE (ET_DYN with
 INTERP) binaries
To:     Azat Khuzhin <a3at.mail@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chris Kennelly <ckennelly@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:18 PM Azat Khuzhin <a3at.mail@gmail.com> wrote:
>
> On Mon, Jan 31, 2022 at 01:30:38PM -0800, H.J. Lu wrote:
> > On Mon, Jan 31, 2022 at 12:17 PM Azat Khuzhin <a3at.mail@gmail.com> wrote:
> > >
> > > Since 9630f0d60fec ELF_ET_DYN_BASE is not used as a load_bias anymore
> > > and this breaks PIE binaries, since after this change data segment
> > > became too nearby the stack:
> > >
> > > Before 9630f0d60fec:
> > >
> > >     $ strace -febrk /tmp/test-stack |& head
> > >     brk(NULL)                               = 0x555555559000
> > >     $ /tmp/test-stack
> > >     bottom_of_stack = 0x7fffffffc5c0
> > >     recursion depth: 1 (stack diff: 32)
> > >     ...
> > >     recursion depth: 7690 (stack diff: 8365664)
> > >     Segmentation fault (core dumped)
> > >
> > > After 9630f0d60fec:
> > >
> > >     $ strace -ebrk /tmp/test-stack  |& head
> > >     brk(NULL)                               = 0x7ffff7fff000
> > >
> > >     $ /tmp/test-stack
> > >     bottom_of_stack = 0x7fffffffc640
> > >     recursion depth: 1 (stack diff: 32)
> > >     ...
> > >     recursion depth: 146 (stack diff: 157792)
> > >     Segmentation fault (core dumped)
> > >
> > > Found this during compiling with clang, that started to randomly
> > > SIGSEGV when it eats some heap.
> >
> > How do I reproduce it on x86-64?
>
> It fails for me for pretty big C++ unit, so I don't have a simple
> reproducer with clang, but the attached reproducer below should show the
> problem.

The reproducer doesn't fail for me under 5.17-rc2 on Fedora 35/x86-64
with 32GB RAM.  Did you turn off PF_RANDOMIZE?

> > > Reproducer:
> > >
> > >     #include <stdio.h>
> > >     #include <stddef.h>
> > >     #include <stdlib.h>
> > >
> > >     static int depth = 0;
> > >     static void* bottom_of_stack;
> > >
> > >     int inner()
> > >     {
> > >         char buffer[1024];
> > >         ptrdiff_t diff;
> > >         int ret;
> > >
> > >         ++depth;
> > >         diff = bottom_of_stack - __builtin_frame_address(0);
> > >
> > >         fprintf(stderr,
> > >                 "recursion depth: %i (stack diff: %zu)\n",
> > >                 depth, (size_t)diff);
> > >
> > >         for (size_t i = 0; i < 1024; ++i)
> > >                 ret += buffer[i];
> > >
> > >         ret += inner();
> > >
> > >         return ret;
> > >     }
> > >
> > >     int main()
> > >     {
> > >         for (size_t size = 0; size < 128<<20; size += 16<<10)
> > >                 malloc(16<<10);
> > >
> > >         bottom_of_stack = __builtin_frame_address(0);
> > >         fprintf(stderr, "bottom_of_stack = %p\n", bottom_of_stack);
> > >         inner();
> > >     }



-- 
H.J.
